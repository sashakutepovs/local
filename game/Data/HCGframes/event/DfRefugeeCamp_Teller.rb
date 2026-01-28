if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
############################################################################################################## 首次對話
if $story_stats["RecQuestDf_Heresy"] >= 3 && $story_stats["RecQuest_Df_TellerSide"] == 0
	$story_stats["RecQuest_Df_TellerSide"] = 1
	call_msg("CompTeller:Df_TellerSide/0to1_1")
	if $story_stats["RecQuestTeller"] >= 1 #是否與Teller對話過？
		call_msg("CompTeller:Df_TellerSide/0to1_2_know")
	else
		call_msg("CompTeller:Df_TellerSide/0to1_2_Unknow")
		$story_stats["RecQuestTeller"] = 1 if $story_stats["RecQuestTeller"] == 0
	end
	call_msg("CompTeller:Df_TellerSide/0to1_3")
	call_msg("CompTeller:Df_TellerSide/1to2_0_0")
end

############################################################################################################## 二次對話
if $story_stats["RecQuestDf_Heresy"] >= 3 && $story_stats["RecQuest_Df_TellerSide"] == 1
	call_msg("CompTeller:Df_TellerSide/1to2_0_1")
	call_msg("CompTeller:Df_TellerSide/1to2_1")
	call_msg("CompTeller:Df_TellerSide/1to2_1_BRD")
	call_msg("common:Lona/Decide_optB") #[算了,決定]
	if $game_temp.choice == 1
		call_msg("CompTeller:Df_TellerSide/1to2_2_Yes")
		$story_stats["RecQuest_Df_TellerSide"] = 2
	else
		call_msg("CompTeller:Df_TellerSide/1to2_2_No")
	end
	
############################################################################################################## Done
elsif $story_stats["RecQuestDf_Heresy"] >= 3 && $story_stats["RecQuest_Df_TellerSide"] == 3
	$story_stats["RecQuest_Df_TellerSide"] = 4
	call_msg("CompTeller:Df_TellerSide/3to4_0") ; portrait_hide
	optain_item("ItemMhBoneStaff",1)
	wait(30)
	optain_item("ItemShAbominationTotem",1)
	wait(30)
	optain_item("ItemCoin3",1)
	wait(30)
	optain_exp(6000*2)
	wait(30)
	optain_morality(5)
	call_msg("CompTeller:Df_TellerSide/3to4_1")
	call_msg("CompTeller:Df_TellerSide/NoneElseDone")
	GabeSDK.getAchievement("RecQuest_Df_TellerSide_4")
elsif $story_stats["RecQuest_Df_TellerSide"] >= 4 ###################任務完成占用
	call_msg("CompTeller:Df_TellerSide/NoneElseDone")
elsif $story_stats["RecQuestDf_Heresy"] < 3 && $story_stats["RecQuest_Df_TellerSide"] == 0
	SndLib.sound_QuickDialog
	call_msg_popup(".....",get_character(0).id)
else
	call_msg("CompTeller:Df_TellerSide/NoneElseNotDone")
	
end
eventPlayEnd
