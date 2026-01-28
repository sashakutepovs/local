

if $story_stats["RecQuestDf_Heresy"] == 4 && $game_player.record_companion_name_ext == "Df_Heresy4CompExtConvoy" && get_character($game_player.get_companion_id(-1)).region_id != 50
	SndLib.sys_buzzer
	call_msg_popup("QuickMsg:CoverTar/NonNearExit")
	return
end

change_map_tag_map_exit

