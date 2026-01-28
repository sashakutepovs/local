#SceneManager.scene.hud.perform_damage_effect
$game_player.actor.portrait.shake
$game_map.interpreter.flash_screen(Color.new(255,255,0,20),4,false)
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
tmpExp= ((rand(65)+ $game_player.actor.level)/2).round
tmpExp = ((tmpExp*0.2)*tmpBouns).round
$game_player.actor.gain_exp(tmpExp)
#-------------------------------------------------------------
 $game_player.actor.arousal += rand(10) if $game_player.actor.stat["Nymph"] ==1
 $game_player.actor.arousal += rand(15) if $story_stats["sex_record_urinary_incontinence"]>= 15
 $game_player.actor.arousal += rand(30) if  $game_player.actor.state_stack(105) !=0
 $game_player.actor.arousal += rand(30) if $game_player.actor.stat["AsVulva_Urethra"] ==1
 $game_player.actor.sta -= 1
 $game_player.actor.dirt += 1
 $game_player.actor.dirt += 1
#$game_map.reserve_summon_event("WastePee") if !$game_map.isOverMap && rand(100)>=50

SndLib.sound_chcg_full(50,50)
