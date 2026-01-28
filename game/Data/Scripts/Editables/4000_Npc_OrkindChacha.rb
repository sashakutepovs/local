#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#基本怪物類型，視需求製造class並附寫
#哥布林AI，走三部打一步
class Npc_OrkindChacha < Game_NonPlayerCharacter
	

	
	def setup_npc
		@wander_count=0
		super
	end
	
	
	def get_move_command
		return if @event.chk_skill_eff_reserved
		tgt = get_target
		return [:move_random] if tgt.nil?
		@wander_count += 1
		near = @event.near_the_target?(tgt,safe_distance)
		case @event.npc.ai_state
			when :fucker
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !@event.near_the_target?(tgt,2)
				return [:turn_toward_character,tgt]
			else
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				if !tgt.facing_character?(@event) #if tgt not facing. attack it
					return [:move_toward_TargetSmartAI,tgt] if !near
					return [:turn_toward_character,tgt]
				end
				return [:move_random] if near && @wander_count < 5 && !@skill
				return [:move_away_from_character,tgt] if ranged? && @event.too_close?(tgt)
				return [:move_toward_TargetSmartAI,tgt] if !near
				return [:turn_toward_character,tgt]
		end
	end
	
	def friendly?(character)
		friendly_sign = super
		return false if friendly_sign && ["Orkind","Goblin"].include?(character.actor.race) && character.npc.get_b_stat("sta") <= 0
		return friendly_sign
	end
	
	def set_assaulter_skill(dist)
		return if @wander_count < 5
		super
		@wander_count = 0 if @skill
	end
	
	def set_killer_skill(dist)
		return if @wander_count < 5
		super
		@wander_count = 0 if @skill
	end
	
	def take_aggro(attacker,skill,no_action_change=false)
		super
		@wander_count = 0
	end
	

end