$game_map.shadows.set_color(120, 90, 70) if $game_date.day?
$game_map.shadows.set_opacity(120) if $game_date.day?
$game_map.shadows.set_color(50, 70, 160) if $game_date.night?
$game_map.shadows.set_opacity(160) if $game_date.night?
tmpLP = RPG::BGM.last.pos
portrait_hide
$story_stats["LonaCannotDie"] = 1
SndLib.bgs_play("AMBIENCE_Public_Hall_Chatter_01_loop_stereo",50,50)
map_background_color(0,0,0,255)
call_msg("CompCocona:EnterDual/0")
tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
tmpStartPointX,tmpStartPointY,tmpStartPointID = $game_map.get_storypoint("StartPoint")
tmpBossMamaT1X,tmpBossMamaT1Y,tmpBossMamaT1ID = $game_map.get_storypoint("BossMamaT1")
tmpHazubendoX,tmpHazubendoY,tmpHazubendoID = $game_map.get_storypoint("Hazubendo")
tmpMamaBeginX,tmpMamaBeginY,tmpMamaBeginID = $game_map.get_storypoint("MamaBegin")
tmpBeginLanternX,tmpBeginLanternY,tmpBeginLanternID = $game_map.get_storypoint("BeginLantern")
tmpStartPointX,tmpStartPointY,tmpStartPointID = $game_map.get_storypoint("StartPoint")
tmpCoconaX,tmpCoconaY,tmpCoconaID = $game_map.get_storypoint("Cocona")
cam_follow(tmpBeginLanternID,0)
get_character(tmpBossMamaT1ID).moveto(tmpMamaBeginX,tmpMamaBeginY)
get_character(tmpBossMamaT1ID).direction = 2
get_character(tmpBossMamaT1ID).npc_story_mode(true)
get_character(tmpHazubendoID).npc_story_mode(true)
get_character(tmpCoconaID).npc_story_mode(true)
map_background_color
chcg_background_color(0,0,0,255,-7)
get_character(tmpBossMamaT1ID).direction = 6
call_msg("CompCocona:EnterDual/1")
portrait_hide
1.times{
	get_character(tmpBossMamaT1ID).direction = 2 ; get_character(tmpBossMamaT1ID).move_forward_force
	get_character(tmpBossMamaT1ID).move_speed = 2.8
	until !get_character(tmpBossMamaT1ID).moving? ; wait(1) end
}

2.times{
	get_character(tmpBossMamaT1ID).direction = 6 ; get_character(tmpBossMamaT1ID).move_forward_force
	get_character(tmpBossMamaT1ID).move_speed = 2.8
	until !get_character(tmpBossMamaT1ID).moving? ; wait(1) end
}
get_character(tmpCoconaID).jump_to(get_character(tmpCoconaID).x,get_character(tmpCoconaID).y)
call_msg("CompCocona:EnterDual/1_1")
portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	SndLib.bgm_play("/D/Arena-Industrial Combat LAYER12",80)
	call_msg("CompCocona:EnterDual/0_1")
	$game_map.shadows.set_color(40, 90, 120)
	$game_map.shadows.set_opacity(200)
	$game_map.interpreter.map_background_color(60,60,200,80)
	SndLib.bgs_play("AMBIENCE_Public_Hall_Chatter_01_loop_stereo",20,100)
	wait(32)
	SndLib.sound_step(100,50)
	wait(32)
	SndLib.sound_step(100,50)
	wait(32)
	SndLib.sound_step(100,50)
	wait(32)
	SndLib.se_play("ME/Door - Stone Long 02",95,200)
	wait(70)
	get_character(tmpBossMamaT1ID).moveto(tmpBossMamaT1X,tmpBossMamaT1Y)
	$game_player.direction = 8
	enter_static_tag_map(nil,false)
	$game_player.moveto(tmpStartPointX,tmpStartPointY+2)
	cam_center(0)
	summon_companion
chcg_background_color(0,0,0,255,-4)
1.times{
	$game_player.direction = 6 ; $game_player.move_forward_force
	$game_player.move_speed = 2.8
	until !$game_player.moving? ; wait(1) end
}
2.times{
	$game_player.direction = 8 ; $game_player.move_forward_force
	$game_player.move_speed = 2.8
	until !$game_player.moving? ; wait(1) end
}
1.times{
	$game_player.direction = 4 ; $game_player.move_forward_force
	$game_player.move_speed = 2.8
	until !$game_player.moving? ; wait(1) end
}
$game_player.direction = 6
$game_player.call_balloon(8)
wait(60)
$game_player.direction = 4
$game_player.call_balloon(8)
wait(60)
$game_player.direction = 8
$game_player.call_balloon(8)
wait(60)
get_character(tmpCoconaID).npc_story_mode(true)
get_character(tmpCoconaID).jump_to(get_character(tmpCoconaID).x,get_character(tmpCoconaID).y)
$game_player.direction = 2
call_msg("CompCocona:EnterDual/2")
get_character(tmpCoconaID).jump_to(get_character(tmpCoconaID).x,get_character(tmpCoconaID).y)
call_msg("CompCocona:EnterDual/3")
portrait_hide
3.times{
	get_character(tmpBossMamaT1ID).direction = 2 ; get_character(tmpBossMamaT1ID).move_forward_force
	get_character(tmpBossMamaT1ID).move_speed = 2.8
	until !get_character(tmpBossMamaT1ID).moving? ; wait(1) end
}

$game_player.direction = 8
if $game_player.getComB_Name != nil || $game_player.getComF_Name != nil
	call_msg("CompCocona:EnterDual/4_withFollower")
else
	call_msg("CompCocona:EnterDual/4_noFollower")
end
call_msg("CompCocona:EnterDual/5")
portrait_off
	get_character(tmpCoconaID).npc_story_mode(false)
	get_character(tmpBossMamaT1ID).npc_story_mode(false)
	get_character(tmpHazubendoID).npc_story_mode(false)
	get_character(tmpCoconaID).npc_story_mode(false)
	get_character(tmpBossMamaT1ID).direction = 2
	get_character(tmpBossMamaT1ID).move_type = 8
	get_character(tmpBossMamaT1ID).set_manual_move_type(8)
	get_character(tmpBossMamaT1ID).npc.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
$story_stats["LimitedNeedsSkill"] = 1
$story_stats["LimitedNapSkill"] = 1

SndLib.bgm_play("/D/Arena-Industrial Combat LAYER 3",80)
eventPlayEnd
get_character(0).erase