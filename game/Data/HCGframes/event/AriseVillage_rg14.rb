if $story_stats["RecQuestAriseVillageApe"] == 1
	$story_stats["RecQuestAriseVillageApe"] = 2
	tmpApeGuard1X,tmpApeGuard1Y,tmpApeGuard1ID=$game_map.get_storypoint("ApeGuard1")
	tmpApeGuard2X,tmpApeGuard2Y,tmpApeGuard2ID=$game_map.get_storypoint("ApeGuard2")
	tmpApe1X,tmpApe1Y,tmpApe1ID=$game_map.get_storypoint("Ape1")
	tmpCamX,tmpCamY,tmpCamID = $game_map.get_storypoint("Cam")
	get_character(tmpCamID).npc_story_mode(true)
	get_character(tmpApeGuard1ID).npc_story_mode(true)
	get_character(tmpApeGuard2ID).npc_story_mode(true)
	get_character(tmpApe1ID).call_balloon(0)
	#SndLib.sound_MaleWarriorDed
	SndLib.MonkeyLost(80,65)
	$game_player.call_balloon(1)
	wait(60)
	call_msg("TagMapAriseVillage:Rho/RG14_x")
	portrait_hide
	call_msg("TagMapAriseVillage:Rho/RG14_0")
	$game_player.direction = 4
	get_character(tmpCamID).moveto($game_player.x,$game_player.y)
	cam_follow(tmpCamID,0)
	get_character(tmpCamID).movetoRolling(tmpApe1X+1,tmpApe1Y+1)
	until !get_character(tmpCamID).moving?
		wait(1)
	end
	get_character(tmpApeGuard1ID).animation = get_character(tmpApeGuard1ID).animation_masturbation
	call_msg("TagMapAriseVillage:Rho/RG14_1")
	get_character(tmpApeGuard1ID).animation = nil
	SndLib.sound_MaleWarriorDed
	call_msg("TagMapAriseVillage:Rho/RG14_2")
	SndLib.MonkeyLost(80,65)
	3.times{
		SndLib.sound_MaleWarriorDed
		get_character(tmpApeGuard2ID).jump_to(get_character(tmpApeGuard2ID).x,get_character(tmpApeGuard2ID).y)
		get_character(tmpApeGuard2ID).call_balloon(25)
		wait(60)
	}
	get_character(tmpApeGuard2ID).animation = get_character(tmpApeGuard2ID).animation_masturbation
	get_character(tmpApeGuard2ID).set_manual_move_type(3)
	get_character(tmpApeGuard2ID).move_type = 3
	get_character(tmpApeGuard1ID).npc_story_mode(false)
	get_character(tmpApeGuard2ID).npc_story_mode(false)
	get_character(tmpCamID).npc_story_mode(false)
	get_character(tmpApeGuard1ID).set_manual_move_type(3)
	get_character(tmpApeGuard1ID).move_type = 3
	cam_center(0)
	$game_player.call_balloon(8)
	wait(60)
	call_msg("TagMapAriseVillage:Rho/RG14_3")
	$game_player.call_balloon(8)
	wait(60)
	call_msg("TagMapAriseVillage:Rho/RG14_4")
	get_character(tmpApe1ID).call_balloon(28,-1)
	eventPlayEnd
end