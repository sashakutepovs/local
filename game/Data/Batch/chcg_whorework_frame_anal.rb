#basic frame damage
#SceneManager.scene.hud.perform_damage_effect #req map hud
$game_player.actor.portrait.shake
$game_actors[1].mood -= (rand(3)+2) if $game_player.actor.stat["Prostitute"] ==0 #change to -mood
$game_actors[1].mood -= (rand(3)+2) if $game_player.actor.stat["IronWill"] ==1 #change to -mood
#Global.good_happen  if aggrement sex
$game_actors[1].mood += (rand(3)+2) if $game_player.actor.stat["Nymph"] ==1 #change to +mood
$game_actors[1].mood += (rand(3)+2) if $game_player.actor.stat["Masochist"] ==1 #change to +mood

tmpSight = true
#------------------------------------------------------------- #每FRAME EXP 接收
tmpBouns = 1
tmpBouns += 0.2 if $game_player.actor.stat["Prostitute"] == 1
tmpBouns += 0.2 if $game_player.actor.stat["Exhibitionism"] == 1 && tmpSight
#tmpBouns += 0.2 if $game_player.actor.stat["Masochist"] == 1
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
$game_actors[1].arousal += 5+(rand(5) * $game_actors[1].sensitivity_anal) #anal_sensitivity
$game_actors[1].arousal += rand(50) if $game_player.actor.stat["Nymph"] ==1
$game_actors[1].arousal += rand(50) if $game_player.actor.stat["Masochist"] ==1
$game_actors[1].arousal += (20*$game_player.actor.stat["FeelsHorniness"]) # feels hot
$game_actors[1].arousal += 10 if $game_player.actor.stat["FeelsWarm"] ==1 # feels warm
$game_actors[1].arousal += rand(60) if $game_player.actor.stat["AsVulva_Anal"] ==1
$game_actors[1].sta -= 1
$game_actors[1].lactation_level += $game_player.actor.stat["Lactation"] + ($game_player.actor.stat["Mod_MilkGland"]*5) #STATE增加乳汁
$game_actors[1].urinary_level += rand(3)
#--------------------------------------------if ready to birth --
$game_actors[1].pain_value_preg +=10 if $game_actors[1].preg_level ==5 && $story_stats["dialog_ready_to_birth"] ==0
$game_actors[1].puke_value_preg = 0 if $game_actors[1].preg_level ==5 && $story_stats["dialog_ready_to_birth"] ==0



SndLib.sound_chcg_full(70+rand(30))
