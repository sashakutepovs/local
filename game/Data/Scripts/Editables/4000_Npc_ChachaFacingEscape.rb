
#猴子，走三步打一步
#若被面對則逃跑 若目標被STUN則侵略
class Npc_ChachaFacingEscape < Game_NonPlayerCharacter
	

	
	def setup_npc
		@wander_count=0
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

	

end