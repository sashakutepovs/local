return get_character(0).erase if $story_stats["UniqueCharUniqueGrayRat"] == -1
return get_character(0).erase if $story_stats["UniqueCharUniqueCecily"] == -1

tmpTfX,tmpTfY,tmpTfID=$game_map.get_storypoint("ThunderFlash")
tmpAdamX,tmpAdamY,tmpAdamID=$game_map.get_storypoint("Adam")
tmpRpX,tmpRpY,tmpRpID=$game_map.get_storypoint("replacer")
tmpFw1X,tmpFw1Y,tmpFw1ID=$game_map.get_storypoint("Follower1")
tmpTflX,tmpTflY,tmpTflID=$game_map.get_storypoint("TfLona")
tmpCecilyID=$game_player.get_followerID(0)
tmpGrayRarID=$game_player.get_followerID(1)

chcg_background_color(0,0,0,0,7)
	$game_player.moveto(tmpTflX,tmpTflY)
	$game_player.direction = 8
	get_character(tmpCecilyID).moveto(tmpTflX-1,tmpTflY+1)
	get_character(tmpGrayRarID).moveto(tmpTflX,tmpTflY+1)
	get_character(tmpCecilyID).direction = 8
	get_character(tmpGrayRarID).direction = 8
chcg_background_color(0,0,0,255,-7)
call_msg("TagMapCecilyHijack:QuestStart/flash0")
$game_player.direction = 6
call_msg("TagMapCecilyHijack:QuestStart/flash1")
get_character(tmpGrayRarID).npc_story_mode(true)
SndLib.sound_equip_armor
$game_player.jump_to(tmpTflX-1,tmpTflY)
get_character(tmpGrayRarID).move_forward
wait(40)
get_character(tmpGrayRarID).npc_story_mode(false)
get_character(tmpGrayRarID).direction = 6
wait(10)
$game_player.direction = 6
call_msg("TagMapCecilyHijack:QuestStart/flash2")

if $story_stats["UniqueCharUniqueAdam"] != -1
	portrait_hide
	cam_center(0)
	get_character(tmpAdamID).npc_story_mode(true)
	get_character(tmpAdamID).moveto(tmpTfX,tmpTfY)
	get_character(tmpAdamID).opacity = 255
	get_character(tmpAdamID).direction = 2
	get_character(tmpAdamID).jump_to(tmpTflX,tmpTflY-1)
	SndLib.stepBush
	get_character(tmpAdamID).direction = 2
	wait(10)
	
	get_character(tmpFw1ID).npc_story_mode(true)
	get_character(tmpFw1ID).moveto(tmpTfX,tmpTfY)
	get_character(tmpFw1ID).opacity = 255
	get_character(tmpFw1ID).direction = 2
	get_character(tmpFw1ID).jump_to(tmpTflX-1,tmpTflY-1)
	SndLib.stepBush
	get_character(tmpFw1ID).direction = 2
	wait(40)
	get_character(tmpAdamID).move_type = 3
	get_character(tmpFw1ID).move_type = 3
	get_character(tmpAdamID).npc_story_mode(false)
	get_character(tmpFw1ID).npc_story_mode(false)
	get_character(tmpGrayRarID).direction = 8
	$game_player.direction = 8
	call_msg("TagMapCecilyHijack:QuestStart/ShowUp_AdamAlive0_t1") if $story_stats["RecQuestAdam"] >= 1
	call_msg("TagMapCecilyHijack:QuestStart/ShowUp_AdamAlive0_t0") if $story_stats["RecQuestAdam"] == 0
	call_msg("TagMapCecilyHijack:QuestStart/ShowUp_AdamAlive1")
	
else
	portrait_hide
	cam_center(0)
	get_character(tmpRpID).npc_story_mode(true)
	get_character(tmpRpID).moveto(tmpTfX,tmpTfY)
	get_character(tmpRpID).opacity = 255
	get_character(tmpRpID).direction = 2
	get_character(tmpRpID).jump_to(tmpTflX,tmpTflY-1)
	SndLib.stepBush
	get_character(tmpRpID).direction = 2
	wait(10)
	
	get_character(tmpFw1ID).npc_story_mode(true)
	get_character(tmpFw1ID).moveto(tmpTfX,tmpTfY)
	get_character(tmpFw1ID).opacity = 255
	get_character(tmpFw1ID).direction = 2
	get_character(tmpFw1ID).jump_to(tmpTflX-1,tmpTflY-1)
	SndLib.stepBush
	get_character(tmpFw1ID).direction = 2
	wait(40)
	#get_character(tmpRpID).move_type = 3
	#get_character(tmpFw1ID).move_type = 3
	get_character(tmpRpID).npc_story_mode(false)
	get_character(tmpFw1ID).npc_story_mode(false)
	get_character(tmpGrayRarID).direction = 8
	$game_player.direction = 8
	call_msg("TagMapCecilyHijack:QuestStart/ShowUp_AdamDed0")
	call_msg("TagMapCecilyHijack:QuestStart/ShowUp_AdamDed0_milo") if $story_stats["RecQuestMilo"] == 11
	call_msg("TagMapCecilyHijack:QuestStart/ShowUp_AdamDed1")
end
call_msg("TagMapCecilyHijack:QuestStart/ShowUp_Quest0")
$game_player.direction = 2
call_msg("TagMapCecilyHijack:QuestStart/ShowUp_Quest1") #\optD[好！,呃...]
call_msg("TagMapCecilyHijack:QuestStart/ShowUp_Quest2") if $game_temp.choice == 0
call_msg("TagMapCecilyHijack:QuestStart/ShowUp_Quest3") if $game_temp.choice == 0
call_msg("TagMapCecilyHijack:QuestStart/ShowUp_Quest3_kill") if $game_temp.choice == 1
$game_temp.choice == 1 ? tmpKillWay = 1 : tmpKillWay = 0
if $story_stats["UniqueCharUniqueAdam"] != -1
	get_character(tmpAdamID).moveto(tmpTfX-2,tmpTfY)
	get_character(tmpAdamID).direction = 8
else
	get_character(tmpRpID).moveto(tmpTfX-2,tmpTfY)
	get_character(tmpRpID).direction = 8
end
chcg_background_color(0,0,0,0,7)
	cam_center(0)
	get_character(tmpFw1ID).direction = 8
	$game_player.moveto(tmpTflX,tmpTflY)
	get_character(tmpCecilyID).moveto(tmpTflX+1,tmpTflY)
	get_character(tmpGrayRarID).moveto(tmpTflX,tmpTflY+1)
	get_character(tmpCecilyID).direction = 8
	get_character(tmpGrayRarID).direction = 8
	if tmpKillWay == 1
		$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:F_Guard]
		event.summon_data[:user] = get_character(tmpCecilyID)
		event.npc.master = get_character(tmpCecilyID)
		event.set_manual_move_type(3)
		event.move_type = 3 if event.move_type == 0
		}
	else
		get_character(tmpCecilyID).follower[1] = 0
		get_character(tmpGrayRarID).follower[1] = 0
	end
chcg_background_color(0,0,0,255,7)

eventPlayEnd
get_character(0).erase