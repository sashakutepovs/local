#==============================================================================
# This script is created by Kslander 
#==============================================================================
#有生命值但不會動的NPC，主要是給物品類型，ex:可以破壞的寶箱
#==============================================================================
# This script is created by Kslander 
#==============================================================================
#有生命值但不會動的NPC，主要是給物品類型，ex:可以破壞的寶箱

class Npc_ProtectShield < Game_NonPlayerCharacter
	attr_accessor :obj_friendly
	attr_accessor :obj_WithFriendlyCheck
	attr_accessor :obj_FriendlyIfSameRace
	def initialize(name)
		super
		@obj_friendly=true #possible not used
		@is_a_ProtectShield = true
		@custom_hit_efx = true
		@no_aggro = true
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
	
	def update_frame
	end
	
	def take_skill_effect(user,skill,can_sap=false,force_hit=false)
		return if skill.is_support
		return if user == @master.actor
		super
	end
	
	
	def exec_custom_hit_efx(skill)
		return if skill.is_support || skill.no_aggro || skill.no_action_change
		SndLib.sound_BloodMagicCasting(@event.report_distance_to_vol_close-20,200)
		@event.zoom_x =  @event.zoom_x*0.7
		@event.zoom_y =  @event.zoom_y*0.7
		@event.mirror = !@event.mirror
		@event.opacity = 80
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
	
	def update_frame
	end
		
	def reset_aggro
	end
	def aggro_allowed?(attacker,skill)
		return false
	end
	

	def process_death
		return p" nothing to do @event.id=>#{@event.id}" if @action_state == :death
		@target=nil
		add_state(1)
		set_alert_level(0)
		play_sound(:sound_death,map_token.report_distance_to_vol_close_npc_vol)
		set_action_state(:death,true)
	end
	
	
	
	def take_skill_hit_aggro(user,skill,can_sap=false,force_hit=false)
	end
	def set_alert_level(new_alert)
		@alert_level=0
		#alert_level絕對不會被改變
	end
	
	def summon_death_event
		super unless @trap_triggered
	end
	
	def overfatigue_death?
		@stat.get_stat("sta")<=0 
	end
	
	def npc_dead?
		return true if !@master || @master.actor.action_state == :death
		@stat.get_stat("health")<=0 || @stat.get_stat("sta") <= 0
	end
end
