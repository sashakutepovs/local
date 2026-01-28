
if cocona_in_group?
	tmpCoconaID=$game_map.get_storypoint("Cocona")[2]
	if get_character(tmpCoconaID).region_id != 52
		SndLib.sys_buzzer
		call_msg_popup("CompCocona:cocona/RecQuestCocona_16_ExitQmsg")
		return
	end
end
change_map_tag_sub("NoerCatacomb","StartPoint2",2,false)
if cocona_in_group? && $game_temp.choice == 1
	if $story_stats["QuProgCataUndeadHunt2"] == 5
		$story_stats["QuProgCataUndeadHunt2"] = 6
		$story_stats["RecQuestCocona"] =1
	end
end
$game_temp.choice = -1
