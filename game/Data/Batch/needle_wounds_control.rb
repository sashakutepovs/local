#SceneManager.scene.hud.perform_damage_effect #req map hud
$game_player.actor.portrait.shake

$game_actors[1].mood -= (rand(5)+2) if $game_player.actor.stat["Prostitute"] ==0 #change to -mood
$game_actors[1].mood -= (rand(5)+2) if $game_player.actor.stat["IronWill"] ==1 #change to -mood
#Global.good_happen  if aggrement sex
$game_actors[1].mood += (rand(2)+1) if $game_player.actor.stat["Nymph"] ==1 #change to +mood
$game_actors[1].mood += (rand(5)+9) if $game_player.actor.stat["Masochist"] ==1 #change to +mood
tmpSight = true
#------------------------------------------------------------- #每FRAME EXP 接收
tmpBouns = 1
#tmpBouns += 0.2 if $game_player.actor.stat["Prostitute"] == 1
tmpBouns += 0.2 if $game_player.actor.stat["Exhibitionism"] == 1 && tmpSight
tmpBouns += 0.2 if $game_player.actor.stat["Masochist"] == 1
#tmpBouns += 0.2 if $game_player.actor.stat["SemenGulper"] == 1
tmpExp = rand(65)+$game_player.actor.level
case $game_player.actor.stat["persona"]
	when "typical"
		tmpExp = ((tmpExp*0.9)*tmpBouns).round
	when "gloomy"
		tmpExp = ((tmpExp*0.6)*tmpBouns).round
	when "tsundere"
		tmpExp = ((tmpExp*0.7)*tmpBouns).round
	when "slut"
		tmpExp = tmpExp*tmpBouns
end
$game_player.actor.gain_exp(tmpExp)
#-------------------------------------------------------------
$game_actors[1].dirt += rand(3)+3
$game_actors[1].arousal -= rand(20)
$game_actors[1].arousal += rand(50) if $game_player.actor.stat["Nymph"] ==1
$game_actors[1].arousal += rand(50) if $game_player.actor.stat["Masochist"] ==1
#$game_actors[1].sta += rand(3)+1
$game_actors[1].health -= rand(2)

temp_value_roll = rand(2)
$game_map.reserve_summon_event("WasteBlood") if temp_value_roll ==1 && !$game_map.isOverMap
case $game_player.actor.stat["EventVag"] 
when "Needle1" 			; $game_actors[1].add_state("WoundChest") if temp_value_roll ==1
when "Needle2" 			; $game_actors[1].add_state("WoundChest") if temp_value_roll ==1
when "Needle3"			; $game_actors[1].add_state("WoundChest") if temp_value_roll ==1
when "Needle4"			; $game_actors[1].add_state("WoundChest") if temp_value_roll ==1
when "Needle5"			; $game_actors[1].add_state("WoundChest") if temp_value_roll ==1
when "Needle6"			; $game_actors[1].add_state("WoundChest") if temp_value_roll ==1
when "Needle7" 			; $game_actors[1].add_state("WoundGroin") if temp_value_roll ==1
when "Needle8" 			; $game_actors[1].add_state("WoundGroin") if temp_value_roll ==1
when "Needle9"			; $game_actors[1].add_state("WoundGroin") if temp_value_roll ==1
when "Needle10"			; $game_actors[1].add_state("WoundGroin") if temp_value_roll ==1
when "Needle11"			; $game_actors[1].add_state("WoundGroin") if temp_value_roll ==1
end

SndLib.sound_chs_pyu(100)
