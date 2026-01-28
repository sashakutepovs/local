#==============================================================================
# This script is created by Kslander 
#==============================================================================
#有生命值但不會動的NPC，主要是給物品類型，ex:可以破壞的寶箱

class Npc_ProtectTower < Game_NonPlayerCharacter
	attr_accessor :obj_friendly
	attr_accessor :obj_WithFriendlyCheck
	attr_accessor :obj_FriendlyIfSameRace
	def initialize(name)
		super
		@obj_friendly=true #possible not used
		@custom_hit_efx = true
		@turn_timer = 0
		@turn_RNG_timer = rand(60)
		
		#if @summon_data && @summon_data[:user]
		#	@master = @summon_data[:user]
		#	
		#	@recMasterSpeed = @master.actor.battle_stat.get_stat("move_speed")
		#	@master.actor.set_move_speed(0) if @master.npc?
		#	@master.actor.shieldEV = @event
		#	@master.moveto(@event.x,@event.y)
		#	@master.forced_y = @summon_data[:setHigh]
		#	@master.forced_z = @summon_data[:setLayer]
		#end
		
		
		
	end
	
	def set_owner_to_new_npc(tarName,tmpSpeed)
		return if !@master
		@master.set_npc(tarName) if tarName
		@master.npc.set_move_speed(tmpSpeed) if tmpSpeed
		@master.npc.apply_stun_effect("Stun30")
		@master.npc.shieldEV = nil
		@master = nil
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
	
	def update_frame
		return if !@master
		return if !@master.npc?
		return if @master.actor.alert_level == 1
		return if ![:none,nil].include?(@master.actor.action_state)
		return if [:flee].include?(@master.actor.ai_state)
		@turn_timer += 1
		if !@master.actor.target && @master.actor.alert_level == 0 && @turn_timer >= 240+@turn_RNG_timer
			@turn_timer = 0
			@turn_RNG_timer = rand(120)
			@master.turn_random
		elsif @master.actor.target && [:killer,:assaulter].include?(@master.actor.ai_state) && @turn_timer >= 20
			@turn_timer = 0
			@master.turn_toward_character(@master.actor.target) if [:none,nil].include?(@master.actor.action_state)
		end
	end
	def exec_custom_hit_efx(skill)
		return if skill.is_support || skill.no_aggro || skill.no_action_change
		@event.effects=["CutTreeSM",0,false,nil,nil,nil]
		SndLib.stoneCollapsed(@event.report_distance_to_vol_close)
	end
	def avoid_friendly_fire?(skill)
		false
	end
	
	def take_skill_effect(user,skill,can_sap=false,force_hit=false)
		return if skill.is_support
		return if user == @master.actor
		super
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
