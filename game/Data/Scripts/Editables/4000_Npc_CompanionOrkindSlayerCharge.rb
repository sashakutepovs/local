#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#標準型人類，發現目標就是衝過去狂扁
class Npc_CompanionOrkindSlayerCharge < Game_NonPlayerCharacter
	def update_frame
		@event.call_balloon(11,-1) if @event.balloon_id == 0 && @event.summon_data && @event.summon_data[:CallMarked] == true
		super
	end
	
	def get_move_command
		return if @event.chk_skill_eff_reserved
		assemble = self.master == $game_player && $game_player.check_companion_assemblyCall?
		tgt = get_target
		if event.follower[0] == 1 && assemble
			return [:move_goto_xy,$game_player.crosshair.x,$game_player.crosshair.y] if $game_player.crosshair.x != @event.x || $game_player.crosshair.y != @event.y
			return if tgt.nil?
			return [:turn_toward_character,tgt]
		end
		return if tgt.nil?
		near = @event.near_the_target?(tgt,safe_distance)
		case @event.npc.ai_state
			when :fucker
				return [:turn_toward_character,tgt] if event.follower[1] == 0 && event.summon_data && event.summon_data[:CallMarkedX] == @event.x && event.summon_data[:CallMarkedY] == @event.y
				return [:move_toward_XY_SmartAI,event.summon_data[:CallMarkedX],event.summon_data[:CallMarkedY]] if event.follower[1] == 0 && event.summon_data && event.summon_data[:CallMarkedX] && event.summon_data[:CallMarkedY]
				return [:move_random] if same_xy?(tgt) && !(event.follower[0] == 1 && event.follower[1] ==0) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !@event.near_the_target?(tgt,2) && !(event.follower[0] == 1 && event.follower[1] ==0)
				return [:turn_toward_character,tgt]
			else
				return [:turn_toward_character,tgt] if event.follower[1] == 0 && event.summon_data && event.summon_data[:CallMarkedX] == @event.x && event.summon_data[:CallMarkedY] == @event.y
				return [:move_toward_XY_SmartAI,event.summon_data[:CallMarkedX],event.summon_data[:CallMarkedY]] if event.follower[1] == 0 && event.summon_data && event.summon_data[:CallMarkedX] && event.summon_data[:CallMarkedY]
				return [:move_random] if same_xy?(tgt) && !(event.follower[0] == 1 && event.follower[1] ==0) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !near && !(event.follower[0] == 1 && event.follower[1] ==0)
				return [:turn_toward_character,tgt]
		end
	end
	
	def process_ai_state(target,distance,signal,sensor_type)
		prev_ai = @ai_state
		is_friend = friendly?(target)
		if flee?(target,is_friend)
			@ai_state = :flee
		elsif fated_enemy.include?(target.actor.fraction) && target.actor.battle_stat.get_stat("sta") <= 0 && ["Goblin","Orkind"].include?(target.actor.race)
			@ai_state = :fucker
		#elsif fated_enemy.include?(target.actor.fraction) && target.actor.battle_stat.get_stat("sta") > 0 && target.actor.race == "Goblin"
		#	@ai_state=:assaulter
		elsif fated_enemy.include?(target.actor.fraction)
			@ai_state = :killer
		elsif fucker?(target,is_friend)
			@ai_state = :fucker
		elsif killer?(target,is_friend)
			@ai_state = :killer
		elsif assulter?(target,is_friend)
			@ai_state = :assaulter
		else 
			@ai_state = :none
		end
		ai_state_changed = !(prev_ai == @ai_state)
		set_ai_state_balloon if ai_state_changed
		set_action_state(:none,ai_state_changed) #temp fix to test
	end
	
end
