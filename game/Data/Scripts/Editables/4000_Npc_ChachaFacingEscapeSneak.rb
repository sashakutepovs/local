
#猴子，走三步打一步
#若被面對則逃跑 若目標被STUN則侵略
class Npc_ChachaFacingEscapeSneak < Game_NonPlayerCharacter
	

	attr_accessor	:movement
	
	def setup_npc
		@wander_count=0
		@movement = :normal
		super
	end
	
	
	def get_move_command
		return if @event.chk_skill_eff_reserved
		tgt = get_target
		return [:move_random] if tgt.nil?
		@wander_count+=1
		near = @event.near_the_target?(tgt,safe_distance)
		tgtFucked = [:stun,:sex].include?(tgt.actor.action_state)
		case @event.npc.ai_state
			when :assaulter,:fucker
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !@event.near_the_target?(tgt,2)
				return [:turn_toward_character,tgt]
			else
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if tgtFucked
				return [:move_random] if near && @wander_count % 3 !=0 && !tgtFucked
				return [[:move_away_from_character,tgt],[:move_random]].sample if (ranged? && @event.too_close?(tgt) ) || (tgt.facing_character?(@event) && !tgtFucked)
				return [:move_toward_TargetSmartAI,tgt]
		end
	end
	
	def set_assaulter_skill(dist)
		return if @wander_count < 3
		super
		@wander_count=0 if @skill
	end
	
	def set_killer_skill(dist)
		return if @wander_count < 3
		super
		@wander_count=0 if @skill
	end

	
	def move_sneak
		return if @movement == :sneak
		tmpfatigue = self.is_fatigue?
		tmpfatigue_WithState = self.state_stack(14) >= 1 #Fatigue
		return if tmpfatigue && !tmpfatigue_WithState
		@event.character_index = 3
		@movement = :sneak
		@event.opacity = 175
		@stat.set_stat_m("move_speed",2.4,[0,2,3])
		@stat.set_stat("move_speed",@stat.get_stat("move_speed",ActorStat::MAX_STAT))
		@event.set_move_speed
		SndLib.sound_equip_armor(@event.report_distance_to_vol_close)
	end
	def move_normal
		return if @movement == :normal
		tmpfatigue = self.is_fatigue?
		tmpfatigue_WithState = self.state_stack(14) >= 1 #Fatigue
		return if tmpfatigue && !tmpfatigue_WithState
		@event.character_index = @event.chs_definition.chs_default_index[event.charset_index]
		@movement = :normal
		@event.opacity = 255
		@stat.set_stat_m("move_speed",3,[0,2,3])
		@stat.set_stat("move_speed",@stat.get_stat("move_speed",ActorStat::MAX_STAT))
		@event.set_move_speed
		SndLib.sound_equip_armor(@event.report_distance_to_vol_close)
	end
	def scoutcraft
		return @scoutcraft if @movement == :sneak
		return super
	end

end
