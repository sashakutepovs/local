#for abom worm creature
class Npc_AbomHookworm < Game_NonPlayerCharacter

	def setup_npc
		reset_wander_count
		super
	end
	def set_extra_event_data
		@event.batch_smallCreatureForcedXY
	end
	def reset_wander_count
		@wander_count=rand(5)
		@wander_count_max=rand(35)+16
	end
	def get_move_command
		return if @event.chk_skill_eff_reserved
		tgt = get_target
		return [:move_random] if tgt.nil?
		if @wander_count >= 10
			@wander_count += 1
			reset_wander_count if @wander_count >= @wander_count_max
			return 
		end
		@wander_count += 1
		@event.npc.process_target_lost if !tgt.nil? && @event.npc.race == tgt.npc.race
		near = @event.near_the_target?(tgt,safe_distance)
		case @event.npc.ai_state
			when :fucker
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetDumbAI,tgt] if !@event.near_the_target?(tgt,2)
				return [:turn_toward_character,tgt]
			else
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetDumbAI,tgt] if !near
				return [:turn_toward_character,tgt]
		end
	end
	def update_frame
		if $game_map.water_floor?(@event.x, @event.y)
			@event.opacity = 128
		else
			@event.opacity = 255
		end
		super
	end
	def process_skill_cost(skill)
		return true
	end
	
	def overfatigue_death?
		@stat.get_stat("sta")<=0 
	end
	
	def npc_dead?
		@stat.get_stat("health")<=0 || @stat.get_stat("sta") <= 0
	end
	
	
end
