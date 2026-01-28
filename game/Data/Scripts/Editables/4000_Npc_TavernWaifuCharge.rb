#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#標準型人類，發現目標就是衝過去狂扁
class Npc_TavernWaifuCharge < Game_NonPlayerCharacter
	
	def get_move_command
		tgt = get_target
		@event.npc.process_target_lost if !tgt.nil? && tgt.actor.is_a?(Npc_UniqueCocona)
		@event.npc.process_target_lost if !tgt.nil? && (@event.actor.master != nil && @master.actor.fraction == tgt.actor.fraction)
		return [:move_random] if tgt.nil?
		near = @event.near_the_target?(tgt,safe_distance)
		case @event.npc.ai_state
			when :fucker
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !@event.near_the_target?(tgt,2)
				return [:turn_toward_character,tgt]
			else
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !near
				return [:turn_toward_character,tgt]
		end
	end
	
	def process_ai_state(target,distance,signal,sensor_type)
		prev_ai=@ai_state
		is_friend=friendly?(target)
		if flee?(target,is_friend)
			@ai_state=:flee	 
		elsif target == $game_player && $game_player.target != nil && @event.actor.master != $game_player
			@ai_state=:killer
		elsif target != $game_player && target.actor.target != nil && !target.actor.is_a?(Npc_UniqueCocona)
			@ai_state=:killer
		elsif fucker?(target,is_friend)
			@ai_state=:fucker 	
		elsif killer?(target,is_friend)
			@ai_state=:killer 
		elsif assulter?(target,is_friend)
			@ai_state=:assaulter
		else 
			@ai_state=:none
		end
		ai_state_changed=!(prev_ai == @ai_state)
		set_ai_state_balloon if ai_state_changed
		set_action_state(:none,ai_state_changed)
	end

end
