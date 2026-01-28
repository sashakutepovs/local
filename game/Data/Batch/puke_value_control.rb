
$game_player.actor.portrait.shake
$game_player.actor.mood -= (rand(3)+2)
$game_player.actor.mood -= (rand(3)+2) if $game_player.actor.stat["IronWill"] ==1
$game_player.actor.mood += (rand(3)+2) if $game_player.actor.stat["Masochist"] ==1
$game_player.actor.gain_exp(rand(65)+$game_actors[1].level)
$game_player.actor.sta -= rand(5)
$game_player.actor.sat -= 2
$game_map.reserve_summon_event("WasteVomit#{rand(2)}") if !$game_map.isOverMap
#$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")

#lona_mood "p5puke"
SndLib.sound_chcg_puke(80)