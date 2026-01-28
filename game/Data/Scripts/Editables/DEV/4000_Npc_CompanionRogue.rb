#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#標準型人類，發現目標就是衝過去狂扁
#class Npc_CompanionCharge < Game_NonPlayerCharacter
class Npc_CompanionRogue < Game_NonPlayerCharacter
	#EffectHoldAssembleCall
	def get_move_command
		return if @event.chk_skill_eff_reserved
		assemble = self.master == $game_player && $game_player.check_companion_assemblyCall?
		tgt = get_target
		if @event.follower[0] == 1 && assemble
			return [:move_goto_xy,$game_player.crosshair.x,$game_player.crosshair.y] if $game_player.crosshair.x != @event.x || $game_player.crosshair.y != @event.y
			return if tgt.nil?
			return [:turn_toward_character,tgt]
		end
		return if tgt.nil?
		near = @event.near_the_target?(tgt,safe_distance)
		case @ai_state
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
	
	

end
