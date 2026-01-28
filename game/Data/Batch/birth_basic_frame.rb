#basic frame damage
#SceneManager.scene.hud.perform_damage_effect #req map hud
$game_player.actor.portrait.shake
$game_actors[1].mood -= (rand(2)+1) if $game_player.actor.stat["Prostitute"] ==0 #change to -mood
$game_actors[1].mood -= (rand(5)+2) if $game_player.actor.stat["IronWill"] ==1 #change to -mood
#Global.good_happen  if aggrement sex
$game_actors[1].mood += (rand(2)+1) if $game_player.actor.stat["Nymph"] ==1 #change to +mood
$game_actors[1].mood += (rand(2)+1) if $game_player.actor.stat["Masochist"] ==1 #change to +mood
tmpSight = $game_player.innocent_spotted?
#------------------------------------------------------------- #每FRAME EXP 接收
tmpBouns = 1
tmpBouns += 0.2 if $game_player.actor.stat["Prostitute"] == 1
tmpBouns += 0.2 if $game_player.actor.stat["Exhibitionism"] == 1 && tmpSight
tmpBouns += 0.2 if $game_player.actor.stat["Masochist"] == 1
#tmpBouns += 0.2 if $game_player.actor.stat["SemenGulper"] == 1
tmpExp = rand(200)+$game_player.actor.level*3
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
$game_actors[1].dirt += rand(3)+9
$game_actors[1].arousal += rand(30)+10
$game_actors[1].arousal += rand(50)+30 if $game_player.actor.stat["WeakSoul"] ==1
$game_actors[1].arousal += rand(50)+30 if $game_player.actor.stat["Nymph"] ==1
$game_actors[1].arousal += rand(50)+30 if $game_player.actor.stat["Masochist"] ==1
$game_actors[1].arousal += (20*$game_player.actor.stat["FeelsHorniness"]) # feels hot
$game_actors[1].arousal += 10 if $game_player.actor.stat["FeelsWarm"] ==1 # feels warm
$game_actors[1].lactation_level += (3*$game_player.actor.stat["Lactation"]) + ($game_player.actor.stat["Mod_MilkGland"]*5) #STATE增加乳汁
$game_actors[1].vag_damage +=rand(500)
$game_actors[1].sta -= rand(10)+10
$game_actors[1].health -= rand(8)

temp_value_roll = rand(2)
$game_actors[1].add_state("WoundGroin") if temp_value_roll ==1 #wound_groin
$game_map.reserve_summon_event("WasteBlood") if temp_value_roll ==1 && !$game_map.isOverMap
$game_map.reserve_summon_event("WastePee") if temp_value_roll ==1 && !$game_map.isOverMap


SndLib.sound_Heartbeat(95)
SndLib.sound_gore
SndLib.sound_chcg_chupa
a= rand(3)
case a
when 0 ; SndLib.sound_chs_buchu
when 1 ; SndLib.sound_chs_dopyu
when 2 ; SndLib.sound_chs_pyu
end
