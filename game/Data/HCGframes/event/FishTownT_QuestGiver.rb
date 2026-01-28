if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if $story_stats["RecQuestElise"] == 13 && $game_player.record_companion_name_ext == "CompExtUniqueElise"
	tmpQgX,tmpQgY,tmpQgID=$game_map.get_storypoint("QuestGiver")
	tmpSg0X,tmpSg0Y,tmpSg0ID=$game_map.get_storypoint("StoryGuard0")
	tmpSwX,tmpSwY,tmpSwID=$game_map.get_storypoint("Swirl")
	tmpLrX,tmpLrY,tmpLrID=$game_map.get_storypoint("LivingRoom")
	tmpEliseID=$game_player.get_followerID(-1)
	
	$story_stats["RecQuestElise"] = 14
	call_msg("CompElise:FishResearch1/14_begin1")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpQgID).npc_story_mode(true)
		get_character(tmpSg0ID).npc_story_mode(true)
		get_character(tmpEliseID).npc_story_mode(true)
		get_character(tmpEliseID).move_type = 0
		get_character(tmpQgID).moveto(tmpLrX-1,tmpLrY)
		get_character(tmpQgID).direction = 6
		get_character(tmpQgID).forced_y = -16
		get_character(tmpSg0ID).moveto(tmpLrX+3,tmpLrY+1)
		get_character(tmpSg0ID).direction = 4
		
		$game_player.moveto(tmpLrX+1,tmpLrY)
		$game_player.direction = 4
		get_character(tmpEliseID).moveto(tmpLrX+1,tmpLrY-1)
		get_character(tmpEliseID).direction = 4
	chcg_background_color(0,0,0,255,-7)
	get_character(tmpQgID).call_balloon(8)
	wait(90)
	call_msg("CompElise:FishResearch1/14_begin2")
	get_character(tmpEliseID).animation = get_character(tmpEliseID).animation_atk_sh
	call_msg("CompElise:FishResearch1/14_begin3")
	call_msg("CompElise:FishResearch1/14_begin4")
	get_character(tmpEliseID).direction = 2
	call_msg("CompElise:FishResearch1/14_begin4_1")
	get_character(tmpEliseID).direction = 4
	call_msg("CompElise:FishResearch1/14_begin5")
	portrait_hide
	get_character(tmpSg0ID).direction = 4 ; get_character(tmpSg0ID).move_forward
	wait(40)
	get_character(tmpSg0ID).direction = 8 ; get_character(tmpSg0ID).move_forward
	wait(40)
	get_character(tmpSg0ID).direction = 8 ; get_character(tmpSg0ID).move_forward
	wait(40)
	get_character(tmpSg0ID).direction = 4
	wait(10)
	get_character(tmpSg0ID).animation = get_character(tmpSg0ID).animation_atk_mh
	wait(10)
	get_character(tmpEliseID).animation = get_character(tmpEliseID).animation_stun
	get_character(tmpEliseID).call_balloon(13,-1)
	SndLib.sound_punch_hit(100)
	$game_player.direction = 8
	wait(20)
	call_msg("CompElise:FishResearch1/14_begin6")
	get_character(tmpSg0ID).direction = 2 ; get_character(tmpSg0ID).move_forward
	wait(40)
	get_character(tmpSg0ID).direction = 4
	get_character(tmpSg0ID).animation = get_character(tmpSg0ID).animation_grabber_qte($game_player)
	$game_player.animation = $game_player.animation_grabbed_qte
	SndLib.sound_equip_armor
	call_msg("CompElise:FishResearch1/14_begin7")
	
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpSg0ID).animation = nil
		get_character(tmpSg0ID).direction = 8
		get_character(tmpSg0ID).moveto(tmpSwX,tmpSwY+2)
		get_character(tmpQgID).moveto(tmpQgX,tmpQgY)
		get_character(tmpQgID).direction = 2
		get_character(tmpQgID).forced_y = 0
		$game_player.moveto(tmpSwX,tmpSwY)
		$game_player.animation = nil
		$game_player.direction = 8
		cam_follow(tmpQgID,0)
	chcg_background_color(0,0,0,255,-4)
	
	#######################################################################################
	call_msg("CompElise:FishResearch1/14_begin8")
	$game_map.npcs.each{|event|
		next if !event.summon_data
		next if !event.summon_data[:Commoner]
		next if event.deleted? || event.actor.action_state == :death
		event.call_balloon(20)
	}
	call_msg("TagMapFishTown:QuestGiver/sexParty2")
	cam_follow(tmpQgID,0)
	portrait_hide
	get_character(tmpQgID).jump_to(tmpQgX,tmpQgY)
	SndLib.sound_equip_armor
	wait(20)
	get_character(tmpSwID).npc_story_mode(true)
	set_event_force_page(tmpSwID,1)
	get_character(tmpSwID).animation = get_character(tmpSwID).animation_swirl
	call_msg("CompElise:FishResearch1/14_begin9")
	portrait_hide
	20.times{
		$game_player.direction = 4
		wait(2)
		$game_player.direction = 8
		wait(2)
		$game_player.direction = 6
		wait(2)
		$game_player.direction = 2
		wait(2)
		$game_player.forced_y += 1
		$game_player.opacity -= 12
	}
	$game_player.moveto(0,0)
	wait(60)
	$game_map.npcs.each{|event|
		next if !event.summon_data
		next if !event.summon_data[:Commoner]
		next if event.deleted? || event.actor.action_state == :death
		event.call_balloon(20)
	}
	#call_msg("TagMapFishTown:QuestGiver/sexParty3")
	#$game_player.actor.morality_lona = 0
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		call_msg("CompElise:FishResearch1/14_begin10")
		portrait_off
		$game_player.forced_y =0
		$game_player.opacity = 255
		get_character(tmpQgID).forced_y = 0
		get_character(tmpQgID).npc_story_mode(false)
		get_character(tmpEliseID).npc_story_mode(false)
		get_character(tmpEliseID).move_type = 3
	
	$story_stats["OverMapForceTrans"] = "FishkindCave3"
	change_map_leave_tag_map
	$story_stats["Captured"] = 1
else
	call_msg("TagMapFishTownT:Farseer/Else")
end
eventPlayEnd
