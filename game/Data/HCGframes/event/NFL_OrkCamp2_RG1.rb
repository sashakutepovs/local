tmpQ0 = $story_stats["UniqueChar_NFL_MerCamp_Leader"] != -1
tmpQ1 = $story_stats["NFL_MerCamp_SaveDog"] == 2
tmpQ2 = $story_stats["RapeLoop"] == 0
tmpQ3 = $story_stats["Captured"] == 0


if tmpQ0 && tmpQ1 && tmpQ2 && tmpQ3
	tmpMerLeaderX,tmpMerLeaderY,tmpMerLeaderID = $game_map.get_storypoint("MerLeader")
	tmpDoggyX,tmpDoggyY,tmpDoggyID = $game_map.get_storypoint("Doggy")
	if get_character(tmpMerLeaderID).report_range($game_player) <= 3 && get_character(tmpDoggyID).report_range($game_player) <= 3
		$story_stats["NFL_MerCamp_SaveDog"] = 3
		call_msg("TagMapNFL_OrkCamp2:Doggy/QuestDone1")
		$game_player.turn_toward_character(get_character(tmpMerLeaderID))
		call_msg("TagMapNFL_OrkCamp2:Doggy/QuestDone2")
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			get_character(tmpMerLeaderID).delete
			get_character(tmpDoggyID).delete
		chcg_background_color(0,0,0,255,-7)
		optain_exp(10000)
		wait(30)
		optain_morality(5)
		wait(30)
		optain_item("ItemCoin2", 1)
		eventPlayEnd
	else
		SndLib.sys_buzzer
		call_msg_popup("QuickMsg:CoverTar/NonNearLona")
	end
else
	change_map_tag_map_exit(true)
end