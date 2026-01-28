#SceneManager.scene.hud.perform_damage_effect
$game_player.actor.portrait.shake
$game_player.actor.mood -= (rand(3)+2) if $game_player.actor.stat["IronWill"] ==1 #change to -mood
#Global.good_happen if masturbation
$game_player.actor.mood += (rand(3)+2) if $game_player.actor.stat["Nymph"] ==1 #change to +mood
tmpSight = $game_player.innocent_spotted?
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
$game_player.actor.arousal -= 200
$game_player.actor.arousal += rand(50) if $game_player.actor.state_stack(33) ==1
$game_player.actor.arousal += rand(75) if $game_player.actor.state_stack(34) ==1
$game_player.actor.sta -= rand(2)+1
$game_player.actor.dirt += rand(3)+5
$game_player.actor.ograsm_addiction_level -=rand(100)
$game_player.actor.ograsm_addiction_damage +=rand(12)
$game_map.reserve_summon_event("WasteWet",$game_player.x,$game_player.y,-1,{:user=>$game_player}) if !$game_map.isOverMap
#$game_player.actor.mp += rand(3) if masturbation

SndLib.sound_chcg_pee(100,400)