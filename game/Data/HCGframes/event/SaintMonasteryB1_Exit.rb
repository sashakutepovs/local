tmpQ1 = $story_stats["RecQuestCocona"] == 17
tmpQ2 = $story_stats["UniqueCharUniqueCocona"] != -1
tmpQ3 = $game_player.record_companion_name_back == "UniqueCoconaMaid"
tmpQ4 = !$game_player.get_followerID(0).nil? && get_character($game_player.get_followerID(0)).region_id != 50
tmpQ5 = !$game_player.get_followerID(0).nil? && get_character($game_player.get_followerID(0)).region_id == 50


if tmpQ1 && tmpQ2 && tmpQ3 && tmpQ4
	SndLib.sys_buzzer
	call_msg_popup("CompCocona:cocona/RecQuestCocona_16_ExitQmsg")
elsif tmpQ1 && tmpQ2 && tmpQ3 && tmpQ5
	change_map_tag_sub("SaintMonasteryC","StartPoint2",2)
else
	change_map_tag_sub("SaintMonastery","StartPoint2",2)
end