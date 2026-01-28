#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#標準型人類，發現目標就是衝過去狂扁


# ON　　　ｄｅｖ
class Npc_PlayerMasterFriendCharge < Game_NonPlayerCharacter

	def get_move_command
		return if @event.chk_skill_eff_reserved
		tgt = get_target
		return [:move_random] if tgt.nil?
		return self.process_target_lost if self.target == @master || (!@master.nil? && @master.actor.master && @target == @master.actor.master) # no aggro to master
		near = @event.near_the_target?(tgt,safe_distance)
		case @ai_state
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
	
	def friendly?(character)
		if @master && character.npc.master
			return true if @master == character.npc.master
			return true if @master.npc.master == character.npc.master && @master.npc.master && character.npc.master
			return true if @master == character.npc.master.npc.master && character.npc.master.npc.master
		end
		return false if character.npc.target == $game_player || character.npc.last_attacker == $game_player
		return false if !character.npc? && character!=$game_player
		return false if @aggro_frame!=0 && character==@target
		case @fraction_mode
		when 0,4;
			return character.actor.fraction == @fraction  # || character.actor.fraction== 4
		when 2;return !character.actor.fraction == 1
		when 1,3;return false;
		end
	end

end
