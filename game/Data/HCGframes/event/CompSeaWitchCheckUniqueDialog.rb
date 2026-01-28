
tmpCecDialog = $game_player.record_companion_name_back == "UniqueCecily" && follower_in_range?(0,4) && $story_stats["RecQuestSeaWitchMeetCecily"] == 0
tmpCocoDialog = cocona_in_group? && follower_in_range?(0,4) && $story_stats["RecQuestSeaWitchMeetCocona"] == 0
if tmpCecDialog
	get_character($game_player.get_followerID(0)).turn_toward_character(get_character(0))
	 $story_stats["RecQuestSeaWitchMeetCecily"] = 1
	call_msg("CompSeaWitch:FirstMeet/BothBegin")
	call_msg("CompSeaWitch:FirstMeet/Cecily0")
elsif tmpCocoDialog
	get_character($game_player.get_followerID(0)).turn_toward_character(get_character(0))
	$story_stats["RecQuestSeaWitchMeetCocona"] = 1
	call_msg("CompSeaWitch:FirstMeet/BothBegin")
	call_msg("CompSeaWitch:FirstMeet/Cocona0")
end