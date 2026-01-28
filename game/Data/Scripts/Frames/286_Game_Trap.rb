#==============================================================================
# This script is created by Kslander 
#==============================================================================
#陷阱類使用的AI模型
class GameTrap  < Game_NonPlayerCharacter
	

	attr_accessor :use_iff
	#override
	def process_target(target,distance,signal,sensor_type)
		return if target.actor.dodged
		super
	end
	
	def avoid_friendly_fire?(skill)
		false
	end
	
	def friendly?(character)
		return super if @use_iff
		false 
	end
	
	
	def char_spotted?(character,min_signal=1)
		sensors.each{
			|sensor|
			signal =sensor.get_signal(map_token,character)
			return true if signal!=0 && signal[2] >= min_signal
		}
		return false
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
	
	def take_skill_effect(user,skill,can_sap=false,force_hit=false)
		return if @trap_triggered
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
		take_damage(user,skill,force_hit)
		apply_skill_state(skill,user) unless @immune_state_effect
		take_sap(user) if skill.sap? && can_sap && !@immune_state_effect
		take_aggro(user,skill)
		refresh
	end	
end
