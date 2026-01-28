
if $story_stats["RecQuestLeeruoiStatue"] == 2
	$story_stats["RecQuestLeeruoiStatue"] = 3
	tmpStatueX,tmpStatueY,tmpStatueID = $game_map.get_storypoint("Statue")
	get_character(tmpStatueID).call_balloon(0)
	call_msg("TagMapNoerDockC1:Statue/Basic")
	call_msg("TagMapNoerDockC1:Statue/Quest")
	eventPlayEnd
else
	call_msg("TagMapNoerDockC1:Statue/Basic")
	eventPlayEnd
end
