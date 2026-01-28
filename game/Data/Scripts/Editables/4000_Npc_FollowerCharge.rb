#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#標準型人類，發現目標就是衝過去狂扁
class Npc_FollowerCharge < Game_NonPlayerCharacter
	#這個AI必須有主人(@summon_data[:user])
	#暫時不支援主人為玩家
	attr_accessor :master
	
	
	
	def get_move_command
		return if @event.chk_skill_eff_reserved
		tgt = get_target
		@event.npc.process_target_lost if @event.actor.target == master # no aggro to master  but crash
		@event.actor.take_aggro(master.actor.target.actor,$data_arpgskills["BasicNormal"]) if !@master.nil? && @master.actor.target != nil && @event.actor.aggro_frame <10
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
	

end