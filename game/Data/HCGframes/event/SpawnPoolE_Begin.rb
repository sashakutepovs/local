
if $story_stats["RecQuestSouthFLMain"] == 3
	$story_stats["RecQuestSouthFLMain"] = 4
	$game_player.direction = 8
	$game_player.call_balloon(8)
	wait(50)
	$game_player.direction = 2
	$game_player.call_balloon(8)
	wait(50)
	$game_player.direction = 4
	$game_player.call_balloon(8)
	wait(50)
	
	call_msg("TagMapSpawnPoolE:Qprog3/begin1")
	$game_player.move_forward_force
	call_msg("TagMapSpawnPoolE:Qprog3/begin2")
	
	
end
eventPlayEnd