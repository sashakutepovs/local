#==============================================================================
# This script is created by Kslander 
#==============================================================================
#有生命值但不會動的NPC，主要是給物品類型，ex:可以破壞的寶箱

class Game_DestroyableObject < Game_NonPlayerCharacter
	attr_accessor :obj_friendly
	attr_accessor :obj_WithFriendlyCheck
	attr_accessor :obj_FriendlyIfSameRace
	def initialize(name)
		super
		@obj_friendly=true #possible not used
	end
	
	def sense_target(character,mode=0);end;
	def killer?(target,friendly);false;end
	def fucker?(target,friendly);false;end
	def assulter?(target,friendly);false;end
	def can_launch_skill?(skill);true;end
	
	#override
	def process_target(target,distance,signal,sensor_type)
		super
	end
	def avoid_friendly_fire?(skill)
		false
	end
	
	def friendly?(character)
		return super if obj_WithFriendlyCheck
		return self.race == character.npc.race if obj_FriendlyIfSameRace
		@obj_friendly
	end
		
	def launch_skill(skill,force=false)
		super
		@trap_triggered=true
	end
	
	def take_aggro(user,skill,no_action_change=false)
	end
	
	def set_alert_level(new_alert)
		@alert_level=0
		#alert_level絕對不會被改變
	end
	
	def summon_death_event
		super unless @trap_triggered
	end


end
