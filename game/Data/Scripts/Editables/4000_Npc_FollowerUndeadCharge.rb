#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#標準型人類，發現目標就是衝過去狂扁
class Npc_FollowerUndeadCharge < Game_NonPlayerCharacter

	def get_move_command
		return if @event.chk_skill_eff_reserved
		tgt = get_target
		return [:move_random] if tgt.nil?
		return self.process_target_lost if self.target == @master || (!@master.nil? && @master.actor.master && @target == @master.actor.master) # no aggro to master
		return self.take_aggro(master.actor.target.actor,$data_arpgskills["BasicNormal"]) if !@master.nil? && @master.actor.target != nil && @event.actor.aggro_frame <10
		near = @event.near_the_target?(tgt,safe_distance)
		case @ai_state
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
	

	def process_target(target,distance,signal,sensor_type)
		return if !@master.nil? && @master.actor.friendly?(target) && target.actor.target != @master
		return if target == @master || (!@master.nil? && @master.actor.master && target == @master.actor.master)  # no aggro to master
		super
	end
	
	def process_skill_cost(skill)
		return true
	end
	
	def overfatigue_death?
		@stat.get_stat("sta")<=0 
	end
	
	def npc_dead?
		@stat.get_stat("health")<=0 || @stat.get_stat("sta") <= 0
	end

end #class