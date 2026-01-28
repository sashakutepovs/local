SndLib.bgs_play("AlienRumble",80,100)
$game_map.set_fog("infested_Cave")
map_background_color(200,40,150,30,0)

############################################################### when quest is done,  do summon monster
questTag = [2,3].include?($story_stats["QuProgSybBarn"])
if !questTag
	$game_map.events.each{|event|
		next if !event[1].summon_data
		next if !event[1].summon_data[:Human]
		event[1].delete
	}
	#todo  summon monster
	#move chest
elsif questTag
	tmpOpGuard1X,tmpOpGuard1Y,tmpOpGuard1ID=$game_map.get_storypoint("OpGuard1")
	tmpOpGuard2X,tmpOpGuard2Y,tmpOpGuard2ID=$game_map.get_storypoint("OpGuard2")
	tmpGpickerX,tmpGpickerY,tmpGpickerID=$game_map.get_storypoint("Gpicker")
	tmpMouthX,tmpMouthY,tmpMouthID=$game_map.get_storypoint("Mouth")
	tmpGscoutX,tmpGscoutY,tmpGscoutID=$game_map.get_storypoint("Gscout")
	tmpBonesX,tmpBonesY,tmpBonesID=$game_map.get_storypoint("Bones")
	tmpStartPointX,tmpStartPointY,tmpStartPointID=$game_map.get_storypoint("StartPoint")
	tmpDoorX,tmpDoorY,tmpDoorID=$game_map.get_storypoint("Door")
	tmpQuestChestX,tmpQuestChestY,tmpQuestChestID=$game_map.get_storypoint("questChest")
	tmpChestX,tmpChestY,tmpChestID=$game_map.get_storypoint("Chest")
	tmpMamaX,tmpMamaY,tmpMamaID=$game_map.get_storypoint("mama")
	tmpOpGuard1OD = get_character(tmpOpGuard1ID).direction
	tmpOpGuard2OD = get_character(tmpOpGuard2ID).direction
	tmpMamaOD = get_character(tmpMamaID).direction
	
	
	get_character(tmpChestID).moveto(tmpQuestChestX,tmpQuestChestY)
	get_character(tmpOpGuard1ID).moveto(tmpStartPointX+2,tmpStartPointY+1)
	get_character(tmpOpGuard2ID).moveto(tmpStartPointX-2,tmpStartPointY+1)
	get_character(tmpMamaID).moveto(tmpStartPointX,tmpStartPointY+2)
	get_character(tmpOpGuard1ID).direction = 4
	get_character(tmpOpGuard2ID).direction = 6
	get_character(tmpMamaID).direction = 8
		set_event_force_page(tmpDoorID,1)
	if $story_stats["QuProgSybBarn"] == 3
		get_character(tmpGpickerID).moveto(tmpStartPointX+1,tmpStartPointY+1)
		get_character(tmpGscoutID).moveto(tmpStartPointX-1,tmpStartPointY+1)
	end
end


fadeout=$story_stats["ReRollHalfEvents"] == 1
enter_static_tag_map(nil,fadeout)


#################################################################### when quest isnt done,  do OP
if questTag
	wait(60)
	$game_player.call_balloon(8)
	wait(60)
	get_character(tmpMamaID).call_balloon(8)
	wait(60)
	$story_stats["QuProgSybBarn"] == 3 ? call_msg("TagMapSybBarn:Op/Begin0_3") : call_msg("TagMapSybBarn:Op/Begin0")
	call_msg("TagMapSybBarn:Op/Begin1_3") if $story_stats["QuProgSybBarn"] == 3
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpMamaID).npc_story_mode(true)
		set_event_force_page(tmpDoorID,2)
		SndLib.closeChest
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapSybBarn:Op/Begin1") ; portrait_hide
	call_msg("TagMapSybBarn:Op/Begin2_3") if $story_stats["QuProgSybBarn"] == 3
	portrait_hide
	get_character(tmpMamaID).move_forward_force
	call_msg("TagMapSybBarn:Op/Begin2") ; portrait_hide
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpMamaID).moveto(tmpMamaX,tmpMamaY)
		get_character(tmpOpGuard1ID).moveto(tmpMamaX+1,tmpMamaY+2)
		get_character(tmpOpGuard2ID).moveto(tmpMamaX+1,tmpMamaY-2)
		$game_player.moveto(tmpMouthX-1,tmpMouthY)
		get_character(tmpMamaID).direction = 6
		get_character(tmpOpGuard1ID).direction = 6
		get_character(tmpOpGuard2ID).direction = 6
		$game_player.direction = 6
		if $story_stats["QuProgSybBarn"] == 3
			get_character(tmpGpickerID).moveto(tmpMouthX,tmpMouthY+1)
			get_character(tmpGscoutID).moveto(tmpMouthX,tmpMouthY-1)
			get_character(tmpGpickerID).direction = 6
			get_character(tmpGscoutID).direction = 6
		end
	chcg_background_color(0,0,0,255,-7)
	
	
	call_msg("TagMapSybBarn:Op/Begin3") ; portrait_hide
	$game_player.move_forward_force
	if $story_stats["QuProgSybBarn"] == 3
		call_msg("TagMapSybBarn:Op/Begin3_3") ; portrait_hide
	end
	$game_player.direction = 4
	get_character(tmpGpickerID).direction = 4
	get_character(tmpGscoutID).direction = 4
	call_msg("TagMapSybBarn:Op/Begin4") ; portrait_hide
	wait(60)
	$game_player.direction = 6
	$game_player.call_balloon(8)
	get_character(tmpGpickerID).direction = 6
	get_character(tmpGscoutID).direction = 6
	wait(60)
	get_character(tmpMouthID).opacity = 255
	get_character(tmpMouthID).zoom_x = 0
	get_character(tmpMouthID).zoom_y = 0
	get_character(tmpMouthID).forced_y = 0
	SndLib.FishkindPuke(100,70)
	10.times{
		get_character(tmpMouthID).zoom_x += 0.2
		get_character(tmpMouthID).zoom_y += 0.3
		get_character(tmpMouthID).forced_y += 4
		wait(1)
	}
	5.times{
		get_character(tmpMouthID).zoom_x += 0.1
		get_character(tmpMouthID).zoom_y += 0.15
		get_character(tmpMouthID).forced_y -= 1
		get_character(tmpGpickerID).forced_y += 3 if $story_stats["QuProgSybBarn"] == 3
		get_character(tmpGscoutID).forced_y += 3 if $story_stats["QuProgSybBarn"] == 3
		$game_player.forced_y += 3
		get_character(tmpGpickerID).opacity -= 50 if $story_stats["QuProgSybBarn"] == 3
		get_character(tmpGscoutID).opacity -= 50 if $story_stats["QuProgSybBarn"] == 3
		$game_player.opacity -= 50
		wait(1)
	}
	until get_character(tmpMouthID).zoom_x <= 0
		get_character(tmpMouthID).zoom_x -= 0.2
		get_character(tmpMouthID).zoom_y -= 0.3
		get_character(tmpMouthID).forced_y -= 2
		get_character(tmpGpickerID).forced_y += 1 if $story_stats["QuProgSybBarn"] == 3
		get_character(tmpGscoutID).forced_y += 1 if $story_stats["QuProgSybBarn"] == 3
		$game_player.forced_y += 1
		wait(1)
	end
	portrait_hide
	wait(60)
	get_character(tmpMamaID).call_balloon(8)
	wait(60)
	get_character(tmpOpGuard2ID).call_balloon(8)
	wait(60)
	get_character(tmpOpGuard2ID).call_balloon(8)
	wait(60)
	call_msg("TagMapSybBarn:Op/Begin5")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpMouthID).opacity = 0
		get_character(tmpGpickerID).forced_y = 0 if $story_stats["QuProgSybBarn"] == 3
		get_character(tmpGscoutID).forced_y = 0 if $story_stats["QuProgSybBarn"] == 3
		get_character(tmpGpickerID).opacity = 255 if $story_stats["QuProgSybBarn"] == 3
		get_character(tmpGscoutID).opacity = 255 if $story_stats["QuProgSybBarn"] == 3
		$game_player.opacity = 255
		$game_player.forced_y = 0
		get_character(tmpOpGuard1ID).moveto(tmpOpGuard1X,tmpOpGuard1Y)
		get_character(tmpOpGuard2ID).moveto(tmpOpGuard2X,tmpOpGuard2Y)
		get_character(tmpMamaID).moveto(tmpMamaX,tmpMamaY)
		get_character(tmpOpGuard1ID).direction = tmpOpGuard1OD
		get_character(tmpOpGuard2ID).direction = tmpOpGuard2OD
		get_character(tmpMamaID).direction = 6
		get_character(tmpMamaID).npc_story_mode(false)
		$game_player.moveto(tmpChestX,tmpChestY-10)
		cam_follow(tmpBonesID,0)
		if $story_stats["QuProgSybBarn"] == 3
			get_character(tmpGpickerID).moveto(tmpChestX+2,tmpChestY-1)
			get_character(tmpGscoutID).moveto(tmpChestX-2,tmpChestY-1)
			get_character(tmpGpickerID).direction = 6
			get_character(tmpGscoutID).direction = 4
		end
	chcg_background_color(0,0,0,255,-7)
	$game_player.jump_to(tmpChestX,tmpChestY-1)
	wait(35)
	SndLib.sound_punch_hit(90,50)
	$game_player.set_animation("animation_stun")
	$game_player.call_balloon(14)
	lona_mood "p5health_damage"
	$game_player.actor.portrait.shake
	call_msg("TagMapSybBarn:Op/Begin7")
	$game_player.animation = nil
	call_msg("TagMapSybBarn:Op/Begin8")
	$game_player.direction = 8
	call_msg("TagMapSybBarn:Op/Begin9")
	if $story_stats["QuProgSybBarn"] == 3
		call_msg("TagMapSybBarn:Op/Begin9_3")
		get_character(tmpGpickerID).turn_toward_character($game_player)
		get_character(tmpGscoutID).turn_toward_character($game_player)
		call_msg("TagMapSybBarn:Op/Begin9_31")
		get_character(tmpGpickerID).call_balloon(8,-1)
		get_character(tmpGscoutID).call_balloon(8,-1)
	end
	call_msg("TagMapSybBarn:Op/Begin9_board")
	
	get_character(tmpDoorID).call_balloon(28,-1)
	$story_stats["QuProgSybBarn"] = 4
end



SndLib.bgm_play("D/Space Ambient #1",80,100)
summon_companion
$story_stats["ReRollHalfEvents"] = 0
$story_stats["OnRegionMapSpawnRace"] =  "AbomManager"
$story_stats["LimitedNapSkill"] =1
eventPlayEnd
get_character(0).erase