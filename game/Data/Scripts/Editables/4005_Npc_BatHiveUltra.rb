
class Npc_BatHiveUltra < Game_NonPlayerCharacter
	attr_accessor :obj_friendly
	attr_accessor :obj_WithFriendlyCheck
	attr_accessor :obj_FriendlyIfSameRace
	def initialize(name)
		super
		@obj_WithFriendlyCheck = true
		@obj_friendly = true #possible not used
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
	
	#when aggro.  re summon all minions to max.  and forced to attack attacker.
	def take_aggro(attacker,skill,no_action_change=false)
		#return if !aggro_allowed?(attacker,skill)
		@event.effects=["BreathSingle",0,false,@event.zoom_x,@event.zoom_y]
		summon_bats_check
		$game_map.npcs.each{|tar| ;
			next if tar == @event
			next if tar.actor.master != self ; 
			next if tar.deleted? ; 
			next if tar.actor.action_state == :death 
			tar.actor.set_aggro(attacker,$data_arpgskills["BasicNormal"],300)
		}
	end
	
	def check_ai_state(target,distance,signal,sensor_type) #Check only
		return :none
	end
	def summon_bats_check
		$game_map.npcs.each{|tar| ; 
			next if tar.actor.master != self ; 
			next if tar.deleted? ; 
			next if tar.actor.action_state == :death ; 
			@event.summon_data[:minions_count] += 1
		}
		if @event.summon_data[:minions_count] < 3
			SndLib.sound_gore(@event.report_distance_to_vol_close-30,200+rand(10))
			until @event.summon_data[:minions_count] >= 3
				EvLib.sum("AbomHiveBat",@event.x,@event.y,{:user=>@event})
				@event.summon_data[:minions_count] += 1
			end
		end
	end
	
	def set_alert_level(new_alert)
		@alert_level=0
		#alert_level絕對不會被改變
	end
	
	def summon_death_event
		super unless @trap_triggered
	end


end
