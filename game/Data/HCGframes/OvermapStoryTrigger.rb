return if $story_stats["OverMapForceTrans"] !=0
return if $story_stats["RapeLoop"] ==1 || $story_stats["Captured"] ==1
#最初的打老鼠任務
if $story_stats["RecQuestSewerSawGoblin"] ==1 # || $game_party.item_number($data_items[103]) >=8
	chcg_background_color_off
	$story_stats["RecQuestSewerSawGoblin"] =2
	$story_stats["HiddenOPT0"] = InputUtils.getKeyAndTranslateLong(:CTRL)
	$story_stats["HiddenOPT1"] = InputUtils.getKeyAndTranslateLong(:SHIFT)
	call_msg("OvermapEvents:NoerTavern/FristTimeNotice0")
	call_msg("OvermapEvents:NoerTavern/FristTimeNotice1")
	call_msg("OvermapEvents:NoerTavern/FristTimeNotice2")
	call_msg("OvermapEvents:NoerTavern/FristTimeNotice3")
	call_msg("OvermapEvents:NoerTavern/FristTimeNotice4")
	GabeSDK.getAchievement("DoneTutorial")
	$story_stats["HiddenOPT0"] = "0"
	$story_stats["HiddenOPT1"] = "0"

#若在地圖中來回 則檢測一次HOM
elsif $story_stats["OverMapEvent_ForceHOM"] == 1
	$story_stats["OverMapEvent_ForceHOM"] =0
	$game_player.handle_on_move_overmap(true)
end

################拯救LISA任務串 返回婦產科
if $story_stats["RecQuestLisa"] == 14 && $game_player.record_companion_name_ext == "CompExtUniqueLisaDown"
	$story_stats["RecQuestLisa"] = 15
	call_msg("CompLisa:Lisa15/ExitHive3")
	$story_stats["HiddenOPT1"] = ($game_player.record_companion_ext_date-$game_date.dateAmt)/2
	call_msg("CompLisa:Lisa15/begin0_board")
	$story_stats["HiddenOPT1"] = "0"
	optain_exp(16000)
end