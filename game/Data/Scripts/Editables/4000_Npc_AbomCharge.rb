#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#標準型人類，發現目標就是衝過去狂扁
class Npc_AbomCharge < Game_NonPlayerCharacter

	def setup_npc
		@flee_start = false
		super
	end
	
	def get_move_command
		return if @event.chk_skill_eff_reserved
		tgt = get_target
		@event.npc.process_target_lost if !tgt.nil? && @event.npc.race == tgt.npc.race
		return [:move_random] if tgt.nil?
		near = @event.near_the_target?(tgt,safe_distance)
		case @event.npc.ai_state
			when :fucker
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetDumbAI,tgt] if !@event.near_the_target?(tgt,2)
				return [:turn_toward_character,tgt]
			else
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetDumbAI,tgt] if !near
				return [:turn_toward_character,tgt]
		end
	end
	

	def overfatigue_death?
		@stat.get_stat("sta")<=0 
	end
	
	def npc_dead?
		@stat.get_stat("health")<=0 || @stat.get_stat("sta") <= 0
	end
	
	def flee?(target,friendly)
		@flee_start = true if (@stat.get_stat("sta") <= @stat.get_stat("sta",2)*0.2 || @stat.get_stat("health") <= @stat.get_stat("health",2)*0.2) && @flee_start == false
		return unless @flee_start == true
		if @stat.get_stat("health") >= @stat.get_stat("health",2)*0.5 && @stat.get_stat("sta") >= @stat.get_stat("sta",2)*0.5
			@flee_start = false
			@event.character_index = @event.chs_definition.chs_default_index[@event.charset_index]
		end
		@stat.set_stat("health",@stat.get_stat("health")+1) 
		@stat.set_stat("sta",@stat.get_stat("sta")+1) 
		@balloon=6
		@target==target
	end
	
end #class