if $story_stats["RecQuestElise"] == 7 && $game_player.record_companion_name_ext == "CompExtUniqueElise" && $story_stats["UniqueCharUniqueElise"] != -1
	tmpEqp0X,tmpEqp0Y,tmpEqp0ID=$game_map.get_storypoint("EliseQP0")
	tmpEqp1X,tmpEqp1Y,tmpEqp1ID=$game_map.get_storypoint("EliseQP1")
	tmpEqp2X,tmpEqp2Y,tmpEqp2ID=$game_map.get_storypoint("EliseQP2")
	tmpEqp3X,tmpEqp3Y,tmpEqp3ID=$game_map.get_storypoint("EliseQP3")
	tmpEqp4X,tmpEqp4Y,tmpEqp4ID=$game_map.get_storypoint("EliseQP4")
	$story_stats["RecQuestElise"] = 8
	wait(5)
	tmpEliseID=$game_player.get_followerID(-1)
	get_character(tmpEliseID).npc_story_mode(true)
	get_character(tmpEliseID).direction = 8
	prevEliseMoveType = get_character(tmpEliseID).move_type
	get_character(tmpEliseID).move_type = 0
	$game_player.direction = 8
	$game_player.moveto($game_player.x,$game_player.y+1)
	get_character(tmpEliseID).moveto(1,1)
	wait(10)
	get_character(tmpEliseID).move_type = 0
	get_character(tmpEliseID).moveto($game_player.x,$game_player.y-2)
	chcg_background_color(0,0,0,255,-7)
	cam_follow(tmpEliseID,0)
	get_character(tmpEliseID).npc_story_mode(false)
	wait(40)
	get_character(tmpEliseID).direction = 4
	get_character(tmpEliseID).call_balloon(8)
	wait(40)
	get_character(tmpEliseID).direction = 6
	get_character(tmpEliseID).call_balloon(8)
	wait(40)
	get_character(tmpEliseID).direction = 8
	call_msg("CompElise:FishResearch1/8_begin1")
	
	get_character(tmpEliseID).npc_story_mode(true)
	get_character(tmpEliseID).direction = 2
	1.times{
		get_character(tmpEliseID).direction = 2 ; get_character(tmpEliseID).move_forward_force
		get_character(tmpEliseID).move_speed = 3
		until !get_character(tmpEliseID).moving? ; wait(1) end
	}
	get_character(tmpEliseID).npc_story_mode(false)
	call_msg("CompElise:FishResearch1/8_begin2")
	get_character(tmpEliseID).direction = 8
	call_msg("CompElise:FishResearch1/8_begin3")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		cam_center(0)
		get_character(tmpEliseID).npc_story_mode(false)
		get_character(tmpEliseID).move_type = prevEliseMoveType
		get_character(tmpEliseID).moveto($game_player.x,$game_player.y)
		$game_player.moveto($game_player.x,$game_player.y-1)
		$game_player.direction = 8
		get_character(tmpEqp0ID).call_balloon(28,-1)
	chcg_background_color(0,0,0,255,-7)
	eventPlayEnd
end