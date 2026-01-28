

class Npc_OrkindThrower < Game_NonPlayerCharacter
	#attr_accessor :eventEquiped
	
	def setup_npc
		#@eventEquiped = nil
		@wander_count=0
		super
		@stance_count 			= 120
		@stance_wait			= 120
		@idle_wait			= 0
		@idle_count			= 60
	end

	#use aggro as frame update
	def update_frame
		return @idle_wait -= 1 if @idle_wait >= 1
		@stance_wait -= 1 if @action_state != :skill
		stance_next if @stance_wait <= 0 && @action_state != :skill #&& !@event.force_update
		super
	end
	
	#each sec check any tgt around user, and able to throw to tgt.
	def stance_next
		return if !self.target
		return if @event.report_range(self.target) <= 2
		@stance_wait = @stance_count
		tarEV = $game_map.npcs.select{|ev|
			next if ev.actor.master != @event
			next if [:death,:sex,:grabbed].include?(ev.actor.action_state)
			next if @event.report_range(ev) >= 2
			next if !@event.actor.friendly?(ev)
			ev
		}
		
		if tarEV.length >= 1
			@idle_wait			= @idle_count
			@event.summon_data[:ThrowEvEquiped] = tarEV.shuffle.shift
			launch_skill($data_arpgskills["NpcUnitThrow"])
		else
			@stance_wait = 10
			tmpData={
				:user => @event,
				:master => @event
			}
			EvLib.sum("GoblinSlaveBaby",@event.x,@event.y,tmpData)
		end
	end
	
	def get_move_command
		return if @event.chk_skill_eff_reserved
		return if @idle_wait >= 1
		tgt = get_target
		return [:move_random] if tgt.nil?
		@wander_count+=1
		if @wander_count >= 10
			@wander_count = 0 
			process_target_lost
		end
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
end


