#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#基本怪物類型，視需求製造class並附寫
#哥布林AI，走三部打一步
class Npc_OrkindMissileRaider < Game_NonPlayerCharacter

	def setup_npc
		gen_wander_range_count
		@stance_wait = 240
		@stance_chk = 120
		super
	end
	
	def set_assaulter_skill(dist)
		super
		gen_wander_range_count if @skill
	end
	
	def set_killer_skill(dist)
		super
		gen_wander_range_count if @skill
	end

	def gen_wander_range_count
		@wander_count = 0
		@wander_range_count = 0
		@wander_range_max = rand(80)+40
	end
	
	def update_index_by_dir(dir)
		case dir
			when 2 ; @event.character_index = 1
			when 4 ; @event.character_index = 2
			when 6 ; @event.character_index = 3
			when 8 ; @event.character_index = 5
			else   ; @event.character_index = 0
		end
	end
	
	def process_target_lost
		@event.character_index = 0
		super
	end
	
	def get_move_command
		return if @event.chk_skill_eff_reserved
		#calling methods in Game_Event
		tgt = get_target
		return [:move_random] if tgt.nil?
		return self.process_target_lost if friendly?(tgt)
		update_index_by_dir(@event.turn_toward_character_get_dir(tgt))
		@wander_count+=1
		nearSameLine = @event.near_the_target?(tgt,safe_distance) && same_line?(tgt)
		nearNotSameLine = @event.near_the_target?(tgt,safe_distance+1) && !same_line?(tgt)
		near = nearSameLine || nearNotSameLine
		tmpWayBlocked = @event.howManyWayBlocked?
		tmpMyDirPass = @event.passable?(@event.x,@event.y,@event.direction)
		case @event.npc.ai_state
			when :killer,:assaulter
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				if @stance_wait > @stance_chk || near
					return [:move_random] if @wander_count % 3 !=0 #goblin stupid
					return [:move_random] if near && tmpWayBlocked.between?(1,3) && !tmpMyDirPass && rand(100) >=80# some where to run , move random
					return [:turn_toward_character,tgt] if @event.near_the_target?(tgt,2) && tmpWayBlocked >= 4 # if no where to run, do melee, remove tmpWayBlocked if he is good at melee
					return [:move_away_from_character,tgt] if near
				end
				return [:move_random] if !near && same_line?(tgt)
				#@wander_range_count += 1
				return [:move_toward_TargetSmartAI,tgt] if @wander_range_count % @wander_range_max == 0
				return [:turn_toward_character,tgt]
			when :fucker
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !@event.near_the_target?(tgt,2)
				return [:turn_toward_character,tgt]
			else
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_away_from_character,tgt] if ranged? && @event.too_close?(tgt)
				return [:move_random] if near && @wander_count % 3 !=0
				return [:move_toward_TargetSmartAI,tgt]
		end
	end
	
	def stance_next
		@stance_wait = 240
		@stance_chk = 120
	end
	
	def update_frame
		@stance_wait -= 1 if @action_state != :skill
		stance_next if @stance_wait <= 0 && @action_state != :skill #&& !@event.force_update
		super
	end
	def set_assaulter_skill(dist)
		return if @wander_count < 3
		super
		@wander_range_count = 0 if @skill
		@wander_count=0 if @skill
	end
	
	def set_killer_skill(dist)
		return if @wander_count < 3
		super
		@wander_range_count = 0 if @skill
		@wander_count=0 if @skill
	end

	def process_skill_cost(skill)
		return true
	end
	
	def player_glory_kill?
		false
	end
	
	def glory_death?
		false
	end
	
	def overfatigue_death?
		@stat.get_stat("sta")<=0
	end
	
	def npc_dead?
		@stat.get_stat("health")<=0 || @stat.get_stat("sta") <= 0
	end

	def process_death
		return p" nothing to do @event.id=>#{@event.id}" if @action_state == :death
		ded_unset_chs_sex
		return if @action_state == :sex
		player_control_mode_off
		@target=nil
		add_state(1)
		set_alert_level(0)
		@event.jump_to(@event.x,@event.y) if self.move_speed != 0
		@event.setup_cropse_graphics(1)
		play_sound(:sound_death,map_token.report_distance_to_vol_close_npc_vol) if @action_state != :death
		set_action_state(:death,true)
	end

end
