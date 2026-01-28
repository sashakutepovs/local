$game_player.call_balloon(8)
wait(60)
SndLib.sound_MaleWarriorDed(10)
$game_player.call_balloon(1)
wait(120)
$game_player.direction = 6
SndLib.sound_MaleWarriorDed(20)
wait(120)
$game_player.call_balloon(8)
$game_player.direction = 4
wait(60)
$game_player.call_balloon(8)
$game_player.direction = 2
wait(60)
call_msg("TagMapB4CampOrkind:enterMap/begin")
eventPlayEnd