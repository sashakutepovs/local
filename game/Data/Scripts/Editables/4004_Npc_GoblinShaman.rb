#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#基本怪物類型，視需求製造class並附寫
#哥布林AI，走三部打一步


class Sensors::OrkindHealVision < Sensors::Multi
	def self.type;				:support;	end
	def self.sight_hp;			4;			end
	def self.use_iff?;			false;		end
	def self.ignore_dead?;		false;		end
	def self.ignore_object?;	true;		end
	def self.friendly_only?;	true;		end
	def self.calc_signal_strength(character,target,sight_hp,mine_value)
		return -400 if !character.actor.friendly?(target)
		return -400 if character.actor.battle_stat.get_stat("sta") < 0
		return 100 if character.actor.check_tgt_heal?(target)
		return -400
	end
end


class Npc_GoblinShaman < Game_NonPlayerCharacter
	

	

	def setup_npc
		gen_wander_range_count
		super
						#stance			stanceWait S
		@stance_default_list = [
						[:Support		,9 ,180], 
						[:Attack		,2 ,120]#normal AI
						]
		@stance_list = [
						[:Support		,9 ,180]#normal AI
						]
		@stance_current 		= [:Attack		,2 ,120]
		@stance_name			= @stance_current[0]
		@stance_count 			= @stance_current[1]
		@stance_wait			= @stance_current[2]
	end
	
	def stance_next
		@stance_list += @stance_default_list if @stance_list.empty?
		@stance_current			= @stance_list.shift
		@stance_name 			= @stance_current[0]
		@stance_count 			= @stance_current[1]
		@stance_wait			= @stance_current[2]
		case @stance_name
			when :Attack			;skills = ["NpcBoneStaffNormal","NpcCurvedSummonAbom","WoodenShieldHeavy","WoodenClubNormal"]
									@skills_killer_list=@skills_assaulter_list=skills
									
			when :Support			;skills = []
									@skills_killer_list=@skills_assaulter_list=skills
		end
		clear_cached_skill
	end
	
	def update_frame
		@stance_wait -= 1 if @action_state != :skill
		stance_next if @stance_wait <= 0 && @action_state != :skill #&& !@event.force_update
		super
	end
	
	def launch_skill(skill,force=false)
		if [$data_arpgskills["NpcCurvedSummonAbom"]].include?(skill)
			return if (@target && @target.actor && target.howManyWayBlocked? >= 4)
		end
		return if !super
		if @stance_name ==  :Attack
			@stance_count -= 1
			stance_next if @stance_count <= 0
		end
	end

	def check_tgt_heal?(target)
		return false if [:skill,:sex,:grabbed].include?(@action_state)
		return false if [:skill,:sex,:grabbed].include?(target.actor.action_state)
		return true if target.actor.battle_stat.get_stat("sta",2)*0.7 >= target.actor.battle_stat.get_stat("sta") || target.actor.battle_stat.get_stat("health",2)*0.7 >= target.actor.battle_stat.get_stat("health")
		return false
	end
	
	def sense_target(character,mode=0)
		detected=nil
		sensors.each{
			|sensor|
			detection=sensor.sense(character,$game_map.all_characters) #所有腳色包含主角
			next if detection==0 || detection[1] < 0 #[target,distance,signal_strength,sensortype]
			detected = detection if detected.nil? || detected[2]< detection[2]
		}
		if detected.nil?
			return if @aggro_frame != 0
			if @alert_level==2 || @target
				return @targetLock_HP -= 1 if @targetLock_HP > 0 && @target && @target.actor && @target.actor.action_state != :death #npc will hold target for a short time
				process_target_lost
			end
		else
			process_target(*detected)
		end
	end
	
	def process_target(target,distance,signal,sensor_type)
		return if @event.chk_skill_eff_reserved
		#return if @action_state == :skill && @skill.is_support
		return super unless friendly?(target) #敵人通通交給原版處理，原版就是設計來面對敵人的。
		#return process_target_lost if @target==target && target.actor.state_stack(6)>=1
		#return if target.actor.state_stack(6)>=1
		#處理發現的目標是友軍的狀況
		process_alert_level(target,distance,signal,sensor_type)
		process_ai_state(target,distance,signal,sensor_type)
		return unless @alert_level==2
		return if progress_heal(target,distance,signal,sensor_type)
	end
	
	
	def check_support_skill_friendly(target)
		if self.friendly?(target)
			true
		else
			process_target_lost
			false
		end
	end

	def progress_heal(target,distance,signal,sensor_type)
		return false if !check_support_skill_friendly(target)
		return false if [:skill,:sex,:grabbed].include?(@action_state)
		return false if [:skill,:sex,:grabbed].include?(target.actor.action_state)
		return false if !check_tgt_heal?(target)
		if !can_launch_skill?($data_arpgskills["NpcShamanBuff"])
			return false
		else
			@target = target
		end
		@event.turn_toward_character(target)
		@targetLock_HP = 0
		launch_skill($data_arpgskills["NpcShamanBuff"])
		true
	end

	def set_assaulter_skill(dist)
		super
		gen_wander_range_count if @skill
	end
	
	def set_killer_skill(dist)
		super
		gen_wander_range_count if @skill
	end

	def gen_wander_range_count
		@wander_count = 0
		@wander_range_count = 0
		@wander_range_max = rand(80)+40
	end

	
	def get_move_command
		return if @event.chk_skill_eff_reserved
		#calling methods in Game_Event
		tgt = get_target
		@safe_land = position_hazardous?(@event.x,@event.y) ? find_safe_land : nil
		if @safe_land
		#p "safe_land functioned @safe_land=>#{@safe_land}"
		#@event.balloon_id=3
		return [:move_toward_xy,*find_safe_land] 
		end
		return [:move_toward_xy,@safe_point[0],@safe_point[1]] if @safe_point
		return [:move_random] if tgt.nil?
		near = @event.near_the_target?(tgt,safe_distance)
		case @event.npc.ai_state
			when :killer,:assaulter
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:turn_toward_character,tgt] if @event.near_the_target?(tgt,2)
				return [:move_random] if !near && !same_line?(tgt)
				@wander_range_count += 1
				return [:move_toward_TargetSmartAI,tgt] if @wander_range_count % @wander_range_max == 0
				return [:turn_toward_character,tgt]
			when :fucker
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !@event.near_the_target?(tgt,2)
				return [:turn_toward_character,tgt]
			else
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !@event.near_the_target?(tgt,2)
				return [:turn_toward_character,tgt]
		end
	end
	
	
	#當下所在的位置是否具有危險
	def position_hazardous?(x=@event.x,y=@event.y)
		$game_map.npcs.any?{
			|event|
			event.pos?(x,y) && !event.deleted? && event.npc.action_state!=:death  && (event.npc.is_a?(Game_DestroyableObject)||event.npc.is_a?(GameTrap) ) && event.npc.friendly_fire
		}
	end
	
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


