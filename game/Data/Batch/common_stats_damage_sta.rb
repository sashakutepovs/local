#事件STA 傷害 common \c[6]洛娜：\c[0]\n    \call[Data/Batch/common_stats_damage_sta.rb] \{"EAHH!!!"
if $game_player.actor.stat["Masochist"] == 1 && $game_player.actor.stat["Nymph"] ==1
	$game_map.interpreter.lona_mood "p5ahegao"
else
	$game_map.interpreter.lona_mood "p5sta_damage"
end


$game_player.actor.portrait.shake
$game_player.actor.mood -= (rand(3)+2) if $game_player.actor.stat["Prostitute"] ==0
$game_player.actor.mood -= (rand(3)+2) if $game_player.actor.stat["IronWill"] ==1
$game_player.actor.mood += (rand(3)+2) if $game_player.actor.stat["Masochist"] ==1
$game_player.actor.gain_exp(rand(65)+$game_player.actor.level)
$game_player.actor.sta -= rand(6)
$game_player.actor.sta -= rand(6)    if $game_player.actor.stat["WeakSoul"] ==0
$game_player.actor.health -= rand(2) if $game_player.actor.stat["WeakSoul"] ==0
$game_player.actor.health -= rand(2)

SndLib.sound_Heartbeat(95)