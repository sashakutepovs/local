#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#基本怪物類型，視需求製造class並附寫
#哥布林AI，走三部打一步
class Npc_FollowerUndeadMissileCharge < Game_NonPlayerCharacter
	
	def setup_npc
		gen_wander_range_count
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
	
	def process_skill_cost(skill)
		return true
	end
	
	def overfatigue_death?
		@stat.get_stat("sta")<=0 
	end
	
	def npc_dead?
		@stat.get_stat("health")<=0 || @stat.get_stat("sta") <= 0
	end

	def process_target(target,distance,signal,sensor_type)
		return if !@master.nil? && @master.actor.friendly?(target) && target.actor.target != @master
		return if target == @master || (!@master.nil? && @master.actor.master && target == @master.actor.master)  # no aggro to master
		super
	end
	def get_move_command
		return if @event.chk_skill_eff_reserved
		tgt = get_target
		return [:move_random] if tgt.nil?
		#msgbox "asdasd #{@self.target == tgt.actor.master}"
		return self.process_target_lost if self.target == @master || (!@master.nil? && @master.actor.master && @target == @master.actor.master) # no aggro to master
		return self.take_aggro(master.actor.target.actor,$data_arpgskills["BasicNormal"]) if !@master.nil? && @master.actor.target != nil && @event.actor.aggro_frame <10
		near = @event.near_the_target?(tgt,safe_distance)
		tmpWayBlocked = @event.howManyWayBlocked?
		tmpMyDirPass = @event.passable?(@event.x,@event.y,@event.direction)
		case @ai_state
			when :killer,:assaulter
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_random] if near && tmpWayBlocked.between?(1,3) && !tmpMyDirPass && rand(100) >= 80# some where to run , move random
				return [:turn_toward_character,tgt] if @event.near_the_target?(tgt,2) #&& tmpWayBlocked >= 4 # if no where to run, do melee, remove tmpWayBlocked if he is good at melee
				return [:move_away_from_character,tgt] if near
				#return [:move_random] if !near && !same_line?(tgt)
				@wander_range_count += 1
				return [:move_toward_TargetDumbAI,tgt] if @wander_range_count % @wander_range_max == 0
				return [:turn_toward_character,tgt]
			when :fucker
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetDumbAI,tgt] if !@event.near_the_target?(tgt,2)
				return [:turn_toward_character,tgt]
			else
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetDumbAI,tgt] if !@event.near_the_target?(tgt,2)
				return [:turn_toward_character,tgt]
		end
	end
	
end