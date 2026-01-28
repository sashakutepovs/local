#==============================================================================
# This script is created by Kslander 
#==============================================================================
#有生命值但不會動的NPC，主要是給物品類型，ex:可以破壞的寶箱

class Npc_AbomHiveLink < Game_NonPlayerCharacter
	attr_accessor :obj_friendly
	def initialize(name)
		super
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
		return @master.actor.friendly?(character) if @master
		@obj_friendly
	end
		
	def launch_skill(skill,force=false)
		super
		@trap_triggered=true
	end
	
	def update_npc_stat
		return process_death if npc_dead?
		@stat.reset_definition
		@stat.check_stat
		refresh_state_effects
		refresh_combat_attribute
		@event.set_move_speed
		@stat = @master.actor.stat
	end
	
	#def aggro_allowed?(attacker,skill)
	#	return false if skill.no_aggro || @no_aggro
	#	return false if @action_state==:grabbed || map_token.sex_receiver?
	#	return false if friendly?(@event) && @aggro_frame==0
	#	return true
	#end
	
	def take_aggro(attacker,skill,no_action_change=false)
		return if @master == nil || !@master.actor.aggro_allowed?(attacker,skill)
		master.actor.set_aggro(attacker,skill,1800)
	end
	
	
	def set_alert_level(new_alert)
		@alert_level=0
		#alert_level絕對不會被改變
	end
	
	def summon_death_event
		super unless @trap_triggered
	end


end
