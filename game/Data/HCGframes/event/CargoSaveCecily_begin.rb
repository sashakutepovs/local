
tmpGrX,tmpGrY,tmpGrID = $game_map.get_storypoint("UniqueGrayRat")
tmpCeX,tmpCeY,tmpCeID=$game_map.get_storypoint("CeTrapped")

$game_player.direction = 8 ; $game_player.call_balloon(8) ; wait(60)
$game_player.direction = 8 ; $game_player.move_forward_force ; wait(35)

$game_player.direction = 6 ; $game_player.call_balloon(8) ; wait(60)
$game_player.direction = 4 ; $game_player.call_balloon(8) ; wait(60)
call_msg("TagMapCargoSaveCecily:AboutTrap/Begin1")
$game_player.direction = 8
get_character(0).direction = 8
call_msg("TagMapCargoSaveCecily:AboutTrap/Begin2")
$game_player.call_balloon(1)
$game_player.direction = 4
call_msg("TagMapCargoSaveCecily:AboutTrap/Begin3")


call_msg("TagMapCargoSaveCecily:AboutTrap/Begin4")
$story_stats["QuProgSaveCecily"] = 2
get_character(tmpCeID).call_balloon(28,-1)
eventPlayEnd