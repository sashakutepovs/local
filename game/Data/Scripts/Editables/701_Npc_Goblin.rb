#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#基本怪物類型，視需求製造class並附寫
#哥布林AI，走三部打一步
class Npc_Goblin < Game_NonPlayerCharacter
	

	
	def setup_npc
		@goblin_wander_count=0
		super
	end
	
	
	def get_move_command
		return if @event.chk_skill_eff_reserved
		#calling methods in Game_Event
		tgt = get_target
		@goblin_wander_count+=1
		near = @event.near_the_target?(tgt,safe_distance)
		return [:move_type_random] if near && @goblin_wander_count % 3 !=0
		return [:move_toward_TargetSmartAI,tgt]
	end
	
	
	def same_line?(tgt)
		@event.x == tgt.x || @event.y == tgt.y
	end
	
	
	def set_assaulter_skill(dist)
		return if @goblin_wander_count < 3
		super
		@goblin_wander_count=0 if @skill
	end
	
	def set_killer_skill(dist)
		return if @goblin_wander_count < 3
		super
		@goblin_wander_count=0 if @skill
	end
	
	def set_fucker_skill(dist)
		return if @goblin_wander_count < 3
		super
		@goblin_wander_count=0 if @skill
	end
	

end