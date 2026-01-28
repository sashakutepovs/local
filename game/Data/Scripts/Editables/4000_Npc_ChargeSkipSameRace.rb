#本AI目前僅用於女魚人
class Npc_ChargeSkipSameRace < Game_NonPlayerCharacter

	def get_move_command
		return if @event.chk_skill_eff_reserved
		tgt = get_target
		@event.npc.process_target_lost if !tgt.nil? && tgt.actor.fraction == @event.npc.fraction
		return [:move_random] if tgt.nil?
		near = @event.near_the_target?(tgt,safe_distance)
		case @event.npc.ai_state
			when :fucker
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !@event.near_the_target?(tgt,2)
				return [:turn_toward_character,tgt]
			else
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !near
				return [:turn_toward_character,tgt]
		end
	end
	
	#針對女魚人於主角為TRUE DEEPONE時之處裡
	def friendly?(character)
		friendly_sign = super
		return true if character == $game_player && character.actor.stat["RaceRecord"] == "TrueDeepone"
		return friendly_sign
	end

end
