#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#標準型人類，發現目標就是衝過去狂扁
class Npc_Human < Game_NonPlayerCharacter

	def get_move_command
		return if @event.chk_skill_eff_reserved
		tgt = get_target
		return [:move_away_from_character,tgt] if ranged? && @event.too_close?(tgt)
		return [:move_toward_TargetSmartAI,tgt]
	end
	

end