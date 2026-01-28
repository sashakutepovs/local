#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#標準型人類，發現目標就是衝過去狂扁
class Npc_Charge_IgnoreMaster < Npc_Charge
	
	def friendly?(character)
		return true if character == @master
		return super
	end
	

end