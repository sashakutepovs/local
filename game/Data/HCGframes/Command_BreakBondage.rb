#return call_msg("commonCommands:Lona/BreakBondage_HCblocked") if $story_stats["Setup_Hardcore"] >= 1

tmpREQtrait = $game_player.actor.combat + $game_player.actor.constitution >=10
tmpREQsta = 78
tmpReqSkillPoint= 15
tmpTargetSkill = false
tmpFailedRespond = "_sta"
call_msg("commonCommands:Lona/BreakBondage_opt") #\optB[強行,技術]

$game_player.move_normal
case $game_temp.choice
	when -1; return
	when 0; tmpTargetSkill = true
			tmpREQsta = 100
			tmpFailedRespond = "_sta"
	when 1; tmpTargetSkill =  $game_player.actor.combat_trait >=tmpReqSkillPoint || $game_player.actor.survival_trait >=tmpReqSkillPoint || $game_player.actor.scoutcraft_trait >=tmpReqSkillPoint || $game_player.actor.wisdom_trait >=tmpReqSkillPoint
			tmpFailedRespond = "_skill"
	else ; return
	
end

tmpSkillREQsta = $game_player.actor.sta.round >= tmpREQsta-1


if tmpSkillREQsta && tmpTargetSkill
	portrait_hide
	chcg_background_color(0,0,0,0,7)
	wait(40)
	SndLib.sound_step_chain(100)
	wait(40)
	SndLib.sound_step_chain(100)
	wait(40)
	SndLib.sound_step_chain(100)
	wait(40)
	SndLib.sound_step_chain(100)
	wait(40)
	SndLib.sound_step_chain(100)
	$game_player.actor.sta -= tmpREQsta
	$story_stats["RapeLoopTorture"] = 1 if $story_stats["RapeLoop"] >= 1 && $story_stats["Captured"] >= 1
	tmpBondageCuff = ["CuffTopExtra","ChainCuffTopExtra"].include?($game_player.actor.stat["MainArm"])
	tmpBondageCollar = ["CollarTopExtra","ChainCollarTopExtra"].include?($game_player.actor.stat["equip_TopExtra"])
	tmpBondageShackles = ["ChainMidExtra"].include?($game_player.actor.stat["equip_MidExtra"])
	$game_player.actor.change_equip(0, nil) if tmpBondageCuff
	$game_player.actor.change_equip(5, nil) if tmpBondageCollar
	$game_player.actor.change_equip(6, nil) if tmpBondageShackles
	chcg_background_color(0,0,0,255,-7)
	player_force_update
	wait(60)
	SndLib.sound_step_chain(100)
	call_msg("commonCommands:Lona/BreakBondageWin1")
else
	portrait_hide
	chcg_background_color(0,0,0,0,7)
	wait(60)
	SndLib.sound_step_chain(100)
	wait(60)
	SndLib.sound_step_chain(100)
	chcg_background_color(0,0,0,255,-7)
	call_msg("commonCommands:Lona/BreakBondageFailed1")
	call_msg("commonCommands:Lona/BreakBondagefailed2#{tmpFailedRespond}")
end


portrait_hide
