#SceneManager.scene.hud.perform_damage_effect
$game_player.actor.portrait.shake
#Global.good_happen if masturbation
tmpSight = $game_player.innocent_spotted?
if tmpSight && ($game_player.actor.stat["Exhibitionism"] == 1 || $game_player.actor.stat["Nymph"] == 1)
	$game_player.actor.mood += (rand(3)+2)
elsif tmpSight
	$game_player.actor.mood -= (rand(3)+2)
end
#------------------------------------------------------------- #每FRAME EXP 接收
tmpBouns = 1
#tmpBouns += 0.2 if $game_player.actor.stat["Prostitute"] == 1
tmpBouns += 0.5 if $game_player.actor.stat["Exhibitionism"] == 1 && tmpSight
#tmpBouns += 0.2 if $game_player.actor.stat["Masochist"] == 1
#tmpBouns += 0.2 if $game_player.actor.stat["SemenGulper"] == 1
tmpExp = rand(65)+$game_player.actor.level
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
$game_actors[1].arousal += rand(50) if $game_player.actor.stat["Nymph"] ==1
$game_actors[1].arousal += rand(40) if $story_stats["sex_record_urinary_incontinence"]>= 15
$game_actors[1].arousal += rand(60) if $game_actors[1].state_stack(105) !=0
$game_actors[1].arousal += rand(60) if $game_player.actor.stat["AsVulva_Urethra"] ==1
#$game_actors[1].sta -= 1
$game_actors[1].dirt += rand(2)+2
$game_actors[1].dirt += rand(2)+3 if IsChcg?
#$game_actors[1].mp += rand(3) if masturbation
$game_map.reserve_summon_event("WastePee") if !$game_map.isOverMap && rand(100)>=50

SndLib.sound_chcg_pee(100,300)
