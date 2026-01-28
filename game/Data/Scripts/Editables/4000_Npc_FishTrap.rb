#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#基本怪物類型，視需求製造class並附寫
#哥布林AI，走三部打一步
class Npc_FishTrap < Game_NonPlayerCharacter
	attr_accessor :use_iff
	#override
	def process_target(target,distance,signal,sensor_type)
		super
	end
	
	def avoid_friendly_fire?(skill)
		false
	end
	
	def friendly?(character)
		return super if @use_iff
		false 
	end
	
	
		
	def launch_skill(skill,force=false)
		super
		return @trap_triggered=false if @skill.nil?
		return @trap_triggered=false if @skill.holding?
		@trap_triggered=true
	end
	
	def take_aggro(user,skill,no_action_change=false)
	end
	
	def reset_skill(force=false)
		super
	end
	
	def summon_death_event
		super unless @trap_triggered
	end
	
    def take_skill_effect(user,skill,can_sap=false)
		return map_token.perform_dodge if @dodged && !skill.no_dodge
		if !@skill.nil?
			if !@skill.blocking?
				cancel_holding  
				reset_skill(true)
			elsif skill.no_parry
				cancel_holding  
				reset_skill(true)
			end
		else
		 reset_skill 
		end
		remove_stun_by_chance
		take_damage(user,skill)
		apply_skill_state_effect(skill,user) unless @immune_state_effect
		take_sap(user) if skill.sap? && can_sap && !@immune_state_effect
		take_aggro(user,skill)
		refresh
	end	

	

	def get_move_command
		tgt = get_target
		return [:move_random] if tgt.nil?
		return [:turn_toward_character,tgt]
	end

end
