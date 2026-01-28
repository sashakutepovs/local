#==============================================================================
# This script is created by Kslander 
#==============================================================================
#砲台類使用的AI模型
class Game_Turret  < Game_NonPlayerCharacter
	
	#override
	def process_target(target,distance,signal,sensor_type)
		super
		return if ["fucker","killer","assaulter"].include?(@ai_state)
		@event.turn_toward_character(target)
	end
	
	#def avoid_friendly_fire?(skill)
	#	#Turret , 注意hit_detection要搬進來
	#	true
	#end

end