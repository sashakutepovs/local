#basic frame damage
#SceneManager.scene.hud.perform_damage_effect #req map hud
$game_player.actor.portrait.shake
$game_actors[1].mood -= (rand(3)+2) if $game_player.actor.stat["Prostitute"] ==0 #change to -mood
$game_actors[1].mood -= (rand(3)+2) if $game_player.actor.stat["IronWill"] ==1 #change to -mood

tmpSight = $game_player.innocent_spotted?
#------------------------------------------------------------- #每FRAME EXP 接收
tmpBouns = 1
tmpBouns += 0.2 if $game_player.actor.stat["Prostitute"] == 1
tmpBouns += 0.2 if $game_player.actor.stat["Exhibitionism"] == 1 && tmpSight
tmpBouns += 0.2 if $game_player.actor.stat["Masochist"] == 1
#tmpBouns += 0.2 if $game_player.actor.stat["SemenGulper"] == 1
tmpExp= ((rand(65)+$game_actors[1].level)/2).round
case $game_player.actor.stat["persona"]
	when "typical"
		tmpExp = ((tmpExp*0.5)*tmpBouns).round
	when "gloomy"
		tmpExp = ((tmpExp*0.3)*tmpBouns).round
	when "tsundere"
		tmpExp = ((tmpExp*0.4)*tmpBouns).round
	when "slut"
		tmpExp = tmpExp*tmpBouns
end
$game_player.actor.gain_exp(tmpExp)
#-------------------------------------------------------------
$game_actors[1].dirt += rand(2)
$game_actors[1].arousal += rand(4) * 5 if $game_player.actor.stat["AsVulva_Skin"] ==1 #皮膚性器化
$game_actors[1].arousal += rand(15)+(rand(3) * $game_actors[1].sensitivity_breast) #B敏感
$game_actors[1].arousal += rand(15) if $game_player.actor.stat["Nymph"] ==1
$game_actors[1].arousal += rand(15) if $game_player.actor.stat["Masochist"] ==1
$game_actors[1].arousal += rand(15) if $game_player.actor.stat["WeakSoul"] ==1
$game_actors[1].arousal += (20*$game_player.actor.stat["FeelsHorniness"]) # feels hot
$game_actors[1].arousal += 10 if $game_player.actor.stat["FeelsWarm"] ==1 # feels warm
$game_actors[1].lactation_level -= 50
$game_actors[1].sat -=1
$game_actors[1].mood += 5
$game_actors[1].sta -= rand(2)
$game_actors[1].sta -= rand(2) if $game_player.actor.stat["WeakSoul"] ==0



#$game_actors[1].health -= rand(2) if $game_player.actor.stat["WeakSoul"] ==0
#$game_actors[1].health -= rand(2)
SndLib.sound_chcg_chupa(100)
