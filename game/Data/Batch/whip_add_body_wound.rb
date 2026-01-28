$game_player.actor.portrait.shake

$game_actors[1].mood -= (rand(5)+2) if $game_player.actor.stat["Prostitute"] ==0 #change to -mood
$game_actors[1].mood -= (rand(5)+2) if $game_player.actor.stat["IronWill"] ==1 #change to -mood
#Global.good_happen  if aggrement sex
$game_actors[1].mood += (rand(2)+1) if $game_player.actor.stat["Nymph"] ==1 #change to +mood
$game_actors[1].mood += (rand(5)+9) if $game_player.actor.stat["Masochist"] ==1 #change to +mood
$game_actors[1].gain_exp(rand(65)+$game_actors[1].level)
#-------------------------------------------------------------
$game_actors[1].dirt += rand(3)+3
$game_actors[1].arousal -= rand(20)
$game_actors[1].arousal += rand(50) if $game_player.actor.stat["Nymph"] ==1
$game_actors[1].arousal += rand(50) if $game_player.actor.stat["Masochist"] ==1
#$game_actors[1].sta += rand(3)+1
$game_actors[1].health -= 3+rand(2)

$game_actors[1].add_wound("body")