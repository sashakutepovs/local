#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#基本怪物類型，視需求製造class並附寫
#哥布林AI，走三部打一步
class Npc_HitRunCharge < Game_NonPlayerCharacter
	

	
	def setup_npc
		@wander_count=0
		super
	end
	
	
	def get_move_command
		#calling methods in Game_Event
		tgt = get_target
		return [:move_random] if tgt.nil?
		@wander_count+=1
		near = @event.near_the_target?(tgt,safe_distance)
		tmpWayBlocked = @event.howManyWayBlocked?
		tmpMyDirPass = @event.passable?(@event.x,@event.y,@event.direction)
		case @event.npc.ai_state
			when :assaulter,:fucker
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !@event.near_the_target?(tgt,2)
				return [:turn_toward_character,tgt]
			else
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_random] if near && tmpWayBlocked.between?(1,3) && !tmpMyDirPass # some where to run , move random
				return [:turn_toward_character,tgt] if @event.near_the_target?(tgt,2) && tmpWayBlocked >= 4 # if no where to run, do melee, remove tmpWayBlocked if he is good at melee
				return [:move_random] if !near && @wander_count % 3 !=0 #normal ppl bad at combat
				return [:move_away_from_character,tgt] if near
				return [:move_random]
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