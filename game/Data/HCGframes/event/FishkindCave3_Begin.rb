if $story_stats["RecQuestElise"] == 14
	$story_stats["RecQuestElise"] = 15
	$game_player.animation = $game_player.animation_stun
	call_msg("CompElise:FishResearch1/15_begin1")
	$game_player.animation = nil
	$game_player.direction = 2
	call_msg("CompElise:FishResearch1/15_begin2")
	$game_player.direction = 4
	call_msg("CompElise:FishResearch1/15_begin3")
	$game_player.direction = 6
	call_msg("CompElise:FishResearch1/15_begin4")
	$game_player.direction = 2
	call_msg("CompElise:FishResearch1/15_begin5")
	call_msg("CompElise:FishResearch1/15_begin6")
	eventPlayEnd
end
