#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#標準型人類，發現目標就是衝過去狂扁
class Npc_UniqueBossMamaT1 < Game_NonPlayerCharacter
	
	def get_move_command
		tgt = get_target
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
	def take_sap(user)
		remove_stun_effect
		return false
	end
	
	def overfatigue_death?
		@stat.get_stat("sta")<=0 
	end
	
	def npc_dead?
		@stat.get_stat("health")<=0 || @stat.get_stat("sta") <= 0
	end

end
