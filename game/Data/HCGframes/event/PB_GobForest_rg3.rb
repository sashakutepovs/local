return get_character(0).erase if $story_stats["QuProgPB_GobForest"] >= 2
$story_stats["QuProgPB_GobForest"] = 3

portrait_hide
$game_player.call_balloon(8)
$game_player.direction = 4
wait(60)
$game_player.call_balloon(8)
$game_player.direction = 2
wait(60)
$game_player.call_balloon(8)
$game_player.direction = 8
call_msg("TagMapPB_GobForest:rg3/begin0") ; portrait_hide
$game_player.direction = 6


eventPlayEnd
get_character(0).erase