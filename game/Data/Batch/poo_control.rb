#SceneManager.scene.hud.perform_damage_effect
$game_player.actor.portrait.shake
$game_player.actor.mood -= (rand(3)+2) if $game_player.actor.stat["IronWill"] ==1 && !$game_map.interpreter.IsChcg? #change to -mood
#Global.good_happen if masturbation
$game_player.actor.mood += (rand(3)+2) if $game_player.actor.stat["Nymph"] ==1 && !$game_map.interpreter.IsChcg?
tmpSight = $game_player.innocent_spotted?
#------------------------------------------------------------- #每FRAME EXP 接收
tmpBouns = 1
tmpBouns += 0.2 if $game_player.actor.stat["Prostitute"] == 1
tmpBouns += 0.5 if $game_player.actor.stat["Exhibitionism"] == 1 && tmpSight
tmpBouns += 0.2 if $game_player.actor.stat["Masochist"] == 1
#tmpBouns += 0.2 if $game_player.actor.stat["SemenGulper"] == 1
tmpExp= ((rand(65)+$game_player.actor.level)/2).round
case $game_player.actor.stat["persona"]
	when "typical"
		tmpExp = ((tmpExp*0.5)*tmpBouns).round
	when "gloomy"
		tmpExp = ((tmpExp*0.3)*tmpBouns).round
	when "tsundere"
		tmpExp = ((tmpExp*0.4)*tmpBouns).round
	when "slut"
		tmpExp = ((tmpExp*0.5)*tmpBouns).round
end
$game_player.actor.gain_exp(tmpExp)
#-------------------------------------------------------------
$game_player.actor.arousal += rand(50) if $game_player.actor.stat["Nymph"] ==1
$game_player.actor.arousal += rand(75) if $story_stats["sex_record_defecate_incontinent"] >= 15
$game_player.actor.arousal += rand(60) if $game_player.actor.stat["AsVulva_Anal"] ==1
$game_player.actor.sta -= 2
$game_player.actor.dirt += rand(2)+4
$game_player.actor.dirt += rand(2)+6 if $game_map.interpreter.IsChcg?
$game_map.reserve_summon_event("WastePoo1") if !$game_map.isOverMap && rand(100)>=50
#$game_player.actor.mp += rand(3) if masturbation

SndLib.sound_chs_buchu(100)
SndLib.sound_chs_dopyu(100,rand(50)+50)
SndLib.sound_chcg_scat(20,50)
