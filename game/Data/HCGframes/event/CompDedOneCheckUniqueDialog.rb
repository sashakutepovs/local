
if $story_stats["RecQuestDedOneMeetLona"] == 0
	$story_stats["RecQuestDedOneMeetLona"] = 1
	$story_stats["RecQuestDedOne"] += 1
	call_msg("CompDedOne:DedOne/PirateBane_begin1")
end
#特殊腳色相遇
if cocona_in_group? && $story_stats["RecQuestDedOneMeetCocona"] == 0 && follower_in_range?(0,5)#!$game_player.get_followerID(0).nil? && get_character($game_player.get_followerID(0)).report_range($game_player) < 5
	$story_stats["RecQuestDedOneMeetCocona"] = 1
	get_character($game_player.get_followerID(0)).turn_toward_character(get_character(0))
	call_msg("CompDedOne:DedOne/PirateBane_begin_k1_Cocona")
elsif ["UniqueGrayRat"].include?($game_player.record_companion_name_front) && $story_stats["RecQuestDedOneMeetGrayRat"] == 0 && follower_in_range?(1,5)
	$story_stats["RecQuestDedOneMeetGrayRat"] = 1
	get_character($game_player.get_followerID(1)).turn_toward_character(get_character(0))
	call_msg("CompDedOne:DedOne/PirateBane_begin_k1_GratRat")
end
eventPlayEnd

