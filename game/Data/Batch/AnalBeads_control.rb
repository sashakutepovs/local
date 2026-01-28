#basic frame damage
#SceneManager.scene.hud.perform_damage_effect #req map hud
$game_player.actor.portrait.shake
$game_actors[1].mood -= (rand(5)+5) if $game_player.actor.stat["Prostitute"] ==0 #change to -mood
$game_actors[1].mood -= (rand(5)+5) if $game_player.actor.stat["IronWill"] ==1 #change to -mood
#Global.good_happen  if aggrement sex
$game_actors[1].mood += (rand(5)+5) if $game_player.actor.stat["Masochist"] ==1 #change to +mood
tmpSight = true
#------------------------------------------------------------- #每FRAME EXP 接收
tmpBouns = 1
tmpBouns += 0.2 if $game_player.actor.stat["Prostitute"] == 1
tmpBouns += 0.2 if $game_player.actor.stat["Exhibitionism"] == 1 && tmpSight
tmpBouns += 0.2 if $game_player.actor.stat["Masochist"] == 1
#tmpBouns += 0.2 if $game_player.actor.stat["SemenGulper"] == 1
tmpExp = rand(65)+$game_player.actor.level
case $game_player.actor.stat["persona"]
	when "typical"
		tmpExp = ((tmpExp*0.7)*tmpBouns).round
	when "gloomy"
		tmpExp = ((tmpExp*0.5)*tmpBouns).round
	when "tsundere"
		tmpExp = ((tmpExp*0.6)*tmpBouns).round
	when "slut"
		tmpExp = tmpExp*tmpBouns
end
$game_player.actor.gain_exp(tmpExp)
#-------------------------------------------------------------
$game_actors[1].dirt += rand(4)+7
$game_actors[1].arousal -= rand(35)
$game_actors[1].arousal += rand(100) if $story_stats["sex_record_defecate_incontinent"] >=15
$game_actors[1].arousal += rand(100) if $game_player.actor.stat["Masochist"] ==1
$game_actors[1].arousal += rand(50) if $game_player.actor.stat["AsVulva_Anal"]  ==1
$game_actors[1].anal_damage += rand(500)
$game_actors[1].health -= 3+rand(4) if $story_stats["sex_record_defecate_incontinent"].between?(0,14) && $game_player.actor.stat["SphincterDamaged"] < 1
$game_actors[1].sta -= 2+rand(3)
#$game_actors[1].sta += 1 if $story_stats["sex_record_defecate_incontinent"].between?(0,14)&&$game_actors[1].state_stack(43) < 1



$game_actors[1].health -=  3+rand(3) if $story_stats["Setup_Hardcore"] >= 1

temp_value_roll = rand(2)
$game_map.reserve_summon_event("WasteBlood") if temp_value_roll ==1 && !$game_map.isOverMap
$game_actors[1].add_wound("groin") if temp_value_roll ==1

SndLib.sound_chs_buchu(100)
