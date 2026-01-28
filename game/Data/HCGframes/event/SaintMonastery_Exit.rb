

if $story_stats["RecQuestSMRefugeeCampFindChild"] == 8 && $game_player.record_companion_name_ext == "MonasteryFindChild_Qobj" && get_character($game_player.get_companion_id(-1)).region_id != 50
	SndLib.sys_buzzer
	call_msg_popup("QuickMsg:CoverTar/NonNearExit")
	return
end

change_map_tag_map_exit(temp_region_trigger=false,tmpChoice=false)
if $story_stats["RecQuestSMRefugeeCampFindChild"] == 8 && $game_temp.choice == 1
	$story_stats["RecQuestSMRefugeeCampFindChild"] = 9
end

