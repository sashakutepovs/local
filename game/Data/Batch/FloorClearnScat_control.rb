#basic frame damage
#SceneManager.scene.hud.perform_damage_effect #req map hud
$game_player.actor.portrait.shake
$game_actors[1].mood -= (rand(3)+4) if $game_player.actor.stat["Prostitute"] ==0 #change to -mood
$game_actors[1].mood -= (rand(3)+12) if $game_player.actor.stat["IronWill"] ==1 #change to -mood
#Global.good_happen  if aggrement sex
$game_actors[1].mood += (rand(3)+3) if $game_player.actor.stat["Nymph"] ==1 #change to +mood
$game_actors[1].mood += (rand(8)+4) if $game_player.actor.stat["Masochist"] ==1 #change to +mood
$game_actors[1].mood += (rand(8)+4) if $game_player.actor.stat["Omnivore"] == 1 #change to +mood
tmpSight = true
#------------------------------------------------------------- #每FRAME EXP 接收
tmpBouns = 1
#tmpBouns += 0.2 if $game_player.actor.stat["Prostitute"] == 1
tmpBouns += 0.2 if $game_player.actor.stat["Exhibitionism"] == 1 && tmpSight
tmpBouns += 0.2 if $game_player.actor.stat["Masochist"] == 1
#tmpBouns += 0.2 if $game_player.actor.stat["SemenGulper"] == 1
tmpBouns += 0.2 if $game_player.actor.stat["Omnivore"] == 1
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
$game_actors[1].dirt += rand(3)+17
$game_actors[1].arousal += rand(5)
$game_actors[1].arousal += (3*$game_player.actor.stat["FeelsHorniness"]) # feels hot
$game_actors[1].arousal += 3 if $game_player.actor.stat["FeelsWarm"] ==1 # feels warm
$game_actors[1].arousal += rand(50) if $game_player.actor.stat["Masochist"] ==1
$game_actors[1].arousal += rand(50) if $game_player.actor.stat["AsVulva_Esophageal"] ==1
#$game_actors[1].arousal += rand(30) if $game_player.actor.stat["Nymph"] ==1
$game_actors[1].sta -= rand(2)
$game_actors[1].sta -= rand(2) if $game_player.actor.stat["WeakSoul"] ==0
$game_actors[1].puke_value_normal += rand(200)
$game_actors[1].puke_value_normal += rand(200) if $game_player.actor.stat["Omnivore"] !=1 #eat everything
$game_actors[1].sat += rand(7) if $game_player.actor.stat["Omnivore"] ==1 #eat everything

#$game_actors[1].health -= rand(2) if $game_player.actor.stat["WeakSoul"] ==0
#$game_actors[1].health -= rand(2)
SndLib.sound_chcg_chupa(100,90)
SndLib.sound_eat(100)
