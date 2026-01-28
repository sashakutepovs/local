#==============================================================================
# This script is created by Kslander 
#==============================================================================
#砲台類使用的AI模型
class Npc_AbomHiveTentcle  < Game_NonPlayerCharacter
	
	#override
	def process_target(target,distance,signal,sensor_type)
		super
		@event.turn_toward_character(target)
	end
	
	def overfatigue_death?
		@stat.get_stat("sta")<=0 
	end
	
	def npc_dead?
		@stat.get_stat("health")<=0 || @stat.get_stat("sta") <= 0
	end
	
	def take_aggro(attacker,skill,no_action_change=false)
		super
		return if @master == nil || !@master.actor.aggro_allowed?(attacker,skill)
		master.actor.set_aggro(attacker,skill,1800)
	end
	
	def process_skill_cost(skill)
		return true
	end

	def can_launch_skill?(skill)
		target_in_range?(skill)
	end
	#def avoid_friendly_fire?(skill)
	#	#Turret , 注意hit_detection要搬進來
	#	true
	#end

end