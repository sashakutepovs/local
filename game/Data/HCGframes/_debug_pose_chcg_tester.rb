
########################################################################frame 0 至中畫面 準備撥放###################################################################################################

lona_mood "chcg1fuck_shame"
$game_player.actor.stat["chcg_x"] = -158 ; $game_player.actor.stat["chcg_y"] = -25
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
call_msg("chcg1fuck_shame")
lona_mood "chcg2fuck_shame"
$game_player.actor.stat["chcg_x"] = -28 ; $game_player.actor.stat["chcg_y"] = 25
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
call_msg("chcg2fuck_shame")
lona_mood "chcg3fuck_shame"
$game_player.actor.stat["chcg_x"] = -228 ; $game_player.actor.stat["chcg_y"] = -125
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
call_msg("chcg3fuck_shame")
lona_mood "chcg4fuck_shame"
$game_player.actor.stat["chcg_x"] = -28 ; $game_player.actor.stat["chcg_y"] = 0
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
call_msg("chcg4fuck_shame")
lona_mood "chcg5fuck_shame"
$game_player.actor.stat["chcg_x"] = -128 ; $game_player.actor.stat["chcg_y"] = -60
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
call_msg("chcg5fuck_shame")
half_event_key_cleaner
chcg_background_color_off
