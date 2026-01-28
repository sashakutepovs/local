
class Sensors::CoconaSupportVision < Sensors::Multi
	def self.type;				:support;	end
	def self.sight_hp;			4;			end
	def self.use_iff?;			false;		end
	def self.ignore_object?;	true;		end
	def self.friendly_only?;	true;		end
	def self.calc_signal_strength(character,target,sight_hp,mine_value)
		#return 0 if !character.actor.friendly?(target)
		if target.actor.race == "Undead"
			return 0 if target.actor.master != character
			return 0 if [0,-1].include?(target.actor.npc.delete_when_frame) || target.delete_frame > 600
			return 0 if character.actor.battle_stat.get_stat("sta") <= 0 || character.actor.battle_stat.get_stat("mood") <= 0 || character.actor.battle_stat.get_stat("mood") >= 30
		else # other friendly unit when off combat
			#return -100 if target.actor.is_object
			return -100 if !target.actor.skill
			return -100 if target.actor.action_state != :skill || target.actor.skill.is_support
			return -100 if target.actor.with_ShieldEV?
			#return -100 if target.actor.action_state == :sex
		end
		strength=sight_hp * character.scoutcraft * mine_value 
		strength
	end
end

class Npc_UniqueCocona < Game_NonPlayerCharacter
	
	
	def setup_npc
		gen_wander_range_count
		super
		@skills_killer_list=@skills_assaulter_list=["NpcCurvedNecroMissile","WoodenClubNormal","NpcCurvedSummonUndeadWarrior","NpcCurvedSummonUndeadBow"]
		@skills_support_list = ["NpcNecroProtectShield"]
	end
	def update_frame
		@event.call_balloon(11,-1) if @event.balloon_id == 0 && @event.summon_data && @event.summon_data[:CallMarked] == true
		super
	end
	
	def launch_skill(skill,force=false)
		#use missile when target blocked
		if @target && @target.actor && @target.actor.is_object && [$data_arpgskills["NpcCurvedSummonUndeadWarrior"],$data_arpgskills["NpcCurvedSummonUndeadBow"]].include?(skill)
			if @event.near_the_target?(@target,1) && @event.facing_character?(@target)
				skill = $data_arpgskills[["NpcBasicSh","BasicNormal"].sample]
			else
				skill = $data_arpgskills["NpcCurvedNecroMissile"]
			end
		elsif [$data_arpgskills["NpcCurvedSummonUndeadWarrior"],$data_arpgskills["NpcCurvedSummonUndeadBow"]].include?(skill)
			skill = $data_arpgskills["NpcCurvedNecroMissile"] if (@target && @target.actor && target.howManyWayBlocked? >= 4) || max_skeleton?
		end
		super(skill,force)
	end
	
	def max_skeleton?
		tmpUndeadCount = 0
		$game_map.npcs.each{|ev|
			next if ev == self
			next if ev.npc.action_state == :death
			next if ev.deleted?
			next unless ev.actor.master == @event
			tmpUndeadCount +=1
		}
		tmpUndeadCount >= 5
	end
	def set_assaulter_skill(dist)
		super(dist)
		gen_wander_range_count if @skill
	end
	
	def set_killer_skill(dist)
		super(dist)
		gen_wander_range_count if @skill
	end

	def gen_wander_range_count
		@wander_count = 0
		@wander_range_count = 0
		@wander_range_max = rand(80)+40
	end
	
	def process_target(target,distance,signal,sensor_type)
		#p target.name
		#p @ai_state == :flee
		process_target_lost if @ai_state == :flee && friendly?(target) 
		return if self.master == $game_player && $game_player.check_companion_assemblyCall?
		return super if !friendly?(target) #敵人通通交給原版處理，原版就是設計來面對敵人的。
		#return process_target_lost if @target==target && target.actor.state_stack(6)>=1
		#return if target.actor.state_stack(6)>=1
		#處理發現的目標是友軍的狀況
		process_alert_level(target,distance,signal,sensor_type)
		process_ai_state(target,distance,signal,sensor_type)
		return unless @alert_level==2
		return if @action_state ==:skill || @action_state==:sex || @action_state == :grabbed
		progress_support_undead(target,distance,signal,sensor_type)
		progress_support_shield(target,distance,signal,sensor_type)
	end
	
		
	def set_assaulter_skill(dist)
		return if @target && progress_combat_shield_target(@target,dist)
		super(dist)
	end
	def set_killer_skill(dist)
		return if @target && progress_combat_shield_target(@target,dist)
		super(dist)
	end
	def progress_combat_shield_target(target,distance)#,signal,sensor_type)
		if !friendly?(target) && target.npc? && target.actor.target &&  friendly?(target.actor.target) && !target.actor.target.actor.with_ShieldEV?
			return false if target.actor.target == @event
			return false if target.actor.target.actor.race == "Undead"
			prev_target = target
			@target = target = target.actor.target
			if can_launch_skill?($data_arpgskills["NpcNecroProtectShield"])
				@targetLock_HP = 0
				take_skill_cancel($data_arpgskills["BasicNormal"]) if @action_state == :skill || @skill != $data_arpgskills["NpcNecroProtectShield"]
				launch_skill($data_arpgskills["NpcNecroProtectShield"])
				play_sound(:sound_skill,map_token.report_distance_to_vol_close_npc_vol) if @skill && rand(100) > 60
				return true
			else
				@target = prev_target
				return false
			end
		end
		return false
	end
	
	def progress_support_shield(target,distance,signal,sensor_type)
		return if !can_launch_skill?($data_arpgskills["NpcNecroProtectShield"])
		@targetLock_HP = 0
		launch_skill($data_arpgskills["NpcNecroProtectShield"])
		#clear_cached_skill
	end
	
	def progress_support_undead(target,distance,signal,sensor_type)
		return if target.actor.race != "Undead"
		return if !can_launch_skill?($data_arpgskills["NpcCoconaBuff"])
		@targetLock_HP = 0
		launch_skill($data_arpgskills["NpcCoconaBuff"])
		#clear_cached_skill
	end
	
	def get_move_command
		return if @event.chk_skill_eff_reserved
		#calling methods in Game_Event
		assemble = self.master == $game_player && $game_player.check_companion_assemblyCall?
		tgt = get_target
		self.process_target_lost if !tgt.nil? && (@event.actor.target == master || tgt.actor.npc_name == "UniqueTavernWaifu")
		#@safe_land = position_hazardous?(@event.x,@event.y) ? find_safe_land : nil
		return [:turn_toward_character,tgt] if @event.summon_data && @event.summon_data[:CallMarked] && !assemble && tgt
		if event.follower[0] == 1 && assemble
			return [:move_goto_xy,$game_player.crosshair.x,$game_player.crosshair.y] if $game_player.crosshair.x != @event.x || $game_player.crosshair.y != @event.y
			return if tgt.nil?
			return [:turn_toward_character,tgt]
		end
		return [:move_toward_xy,*find_safe_land] if @safe_land
		return [:move_toward_xy,@safe_point[0],@safe_point[1]] if @safe_point
		return if tgt.nil?
		near = @event.near_the_target?(tgt,safe_distance)
		tmpWayBlocked = @event.howManyWayBlocked?
		tmpMyDirPass = @event.passable?(@event.x,@event.y,@event.direction)
		case @ai_state
			when :killer,:assaulter
				return [:turn_toward_character,tgt] if event.follower[1] == 0 && event.summon_data && event.summon_data[:CallMarkedX] == @event.x && event.summon_data[:CallMarkedY] == @event.y
				return [:move_toward_XY_SmartAI,event.summon_data[:CallMarkedX],event.summon_data[:CallMarkedY]] if event.follower[1] == 0 && event.summon_data && event.summon_data[:CallMarkedX] && event.summon_data[:CallMarkedY]
				return [:move_random] if same_xy?(tgt) && !(event.follower[0] == 1 && event.follower[1] ==0)#move_away if same xy
				return [:move_random] if near && tmpWayBlocked.between?(1,3) && !tmpMyDirPass && rand(100) >= 80 && !(event.follower[0] == 1 && event.follower[1] ==0)# some where to run , move random
				return [:turn_toward_character,tgt] if @event.near_the_target?(tgt,2) && tmpWayBlocked >= 4 # if no where to run, do melee, remove tmpWayBlocked if he is good at melee
				return [:move_away_from_character,tgt] if near && !(event.follower[0] == 1 && event.follower[1] ==0)
				#return [:move_random] if !near && !same_line?(tgt) && !(event.follower[0] == 1 && event.follower[1] ==0)
				@wander_range_count += 1
				return [:move_toward_TargetSmartAI,tgt] if @wander_range_count % @wander_range_max == 0
				return [:turn_toward_character,tgt]
			when :fucker
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !@event.near_the_target?(tgt,2)
				return [:turn_toward_character,tgt]
			else
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !@event.near_the_target?(tgt,2) && !(@event.summon_data && @event.summon_data[:CallMarked])
				return [:turn_toward_character,tgt]
		end
	end
	
	
	#def friendly?(character)
	#	return true if character.npc.race.eql?("Undead")
	#	friendly_sign = super
	#	return friendly_sign
	#end
	
	##當下所在的位置是否具有危險
	#def position_hazardous?(x=@event.x,y=@event.y)
	#	$game_map.npcs.any?{
	#		|event|
	#		event.pos?(x,y) && !event.deleted? && event.npc.action_state!=:death  && (event.npc.is_a?(Game_DestroyableObject)||event.npc.is_a?(GameTrap) ) && event.npc.friendly_fire
	#	}
	#end
	
	def find_safe_land
		return @safe_land if @safe_land
		for dist_x in 1..5
			for dist_y in 1..5
				point = [@event.x+(2-dist_x),@event.y+(2-dist_y)]
				next if @event.x==point[0] && @event.y==point[1]
				if !position_hazardous?(*point) && $game_map.events_xy_nt(*point).empty?
					return point
				end
			end
		end
	end
end


