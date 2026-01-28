#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#基本怪物類型，視需求製造class並附寫
#哥布林AI，走三部打一步
class Npc_CompanionSlowMage < Game_NonPlayerCharacter
	
	def update_frame
		@event.call_balloon(11,-1) if @event.balloon_id == 0 && @event.summon_data && @event.summon_data[:CallMarked] == true
		gen_wander_range_count
		super
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
		tgt = get_target
		assemble = self.master == $game_player && $game_player.check_companion_assemblyCall?
		if event.follower[0] == 1 && assemble
			return [:move_goto_xy,$game_player.crosshair.x,$game_player.crosshair.y] if $game_player.crosshair.x != @event.x || $game_player.crosshair.y != @event.y
			return if tgt.nil?
			return [:turn_toward_character,tgt]
		end
		return if tgt.nil?
		near = @event.near_the_target?(tgt,safe_distance)
		tmpWayBlocked = @event.howManyWayBlocked?
		tmpMyDirPass = @event.passable?(@event.x,@event.y,@event.direction)
		case @event.npc.ai_state
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
	
	def process_target(target,distance,signal,sensor_type)
		return if self.master == $game_player && $game_player.check_companion_assemblyCall?
		super
	end
	


end
