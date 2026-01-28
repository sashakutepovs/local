#SceneManager.scene.hud.perform_damage_effect
$game_player.actor.portrait.shake
$game_actors[1].mood -= (rand(3)+2) if $game_player.actor.stat["IronWill"] ==1 #change to -mood
#Global.good_happen if masturbation
$game_actors[1].mood += (rand(3)+2) if $game_player.actor.stat["Nymph"] ==1 #change to +mood
#------------------------------------------------------------- #每FRAME EXP 接收
tmpBouns = 1
#tmpBouns += 0.2 if $game_player.actor.stat["Prostitute"] == 1
#tmpBouns += 0.2 if $game_player.actor.stat["Exhibitionism"] == 1 && tmpSight
#tmpBouns += 0.2 if $game_player.actor.stat["Masochist"] == 1
#tmpBouns += 0.2 if $game_player.actor.stat["SemenGulper"] == 1
tmpExp = rand(30)+$game_player.actor.level
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
$game_actors[1].arousal -= 200
$game_actors[1].arousal += rand(50) if $game_actors[1].state_stack(33) ==1
$game_actors[1].arousal += rand(75) if $game_actors[1].state_stack(34) ==1
$game_actors[1].sta -= rand(2)+1
$game_actors[1].dirt += rand(3)+5
$game_actors[1].ograsm_addiction_level -=rand(150)
$game_actors[1].ograsm_addiction_damage +=rand(17)
$game_map.reserve_summon_event("WasteWet",$game_player.x,$game_player.y,-1,{:user=>$game_player}) if !$game_map.isOverMap
#$game_actors[1].mp += rand(3) if masturbation
SndLib.sound_chcg_pee(100,450)