	p "Playing HCGframe : Action_Slipped.rb"

$game_portraits.lprt.hide

$story_stats["WildDangerous"] +=65535 if $story_stats["OnRegionMap"] >=1
#$game_player.animation = $game_player.animation_stun
#$game_player.call_balloon(7,0)
$game_actors[1].sta = -100
call_msg("commonCommands:Lona/CampActionSlip")