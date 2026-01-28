
if $story_stats["RecQuestAriseVillageFish"] == 3 && $game_player.record_companion_name_ext == "AriseVillageCompExtConvoy"
	tmpGateX,tmpGateY,tmpGateID = $game_map.get_storypoint("Gate")
	$story_stats["RecQuestAriseVillageFish"] = 4
	
	
	wait(10)
	get_character($game_player.get_followerID(-1)).npc_story_mode(true)
	tmpCOmove_type = get_character($game_player.get_followerID(-1)).move_type
	get_character($game_player.get_followerID(-1)).move_type = 0
		
	get_character($game_player.get_followerID(-1)).direction = 2 ; get_character($game_player.get_followerID(-1)).move_forward_force ; get_character($game_player.get_followerID(-1)).move_speed = 3
	call_msg("TagMapPB_FishCampA:AriseVillageFish/3to4_0") ; portrait_hide
	$game_map.interpreter.screen.start_shake(1,7,60)
	SndLib.sound_FlameCast(100,70)
	wait(30)
	$game_player.direction = 8
	get_character($game_player.get_followerID(-1)).direction = 8
	until get_character(tmpGateID).opacity >= 255
		get_character(tmpGateID).opacity += 5
		wait(1)
	end
	call_msg("TagMapPB_FishCampA:AriseVillageFish/3to4_1")
	$game_player.direction = 2
	get_character($game_player.get_followerID(-1)).direction = 8
	call_msg("TagMapPB_FishCampA:AriseVillageFish/3to4_2")
	
	get_character($game_player.get_followerID(-1)).move_type = tmpCOmove_type
	get_character($game_player.get_followerID(-1)).npc_story_mode(false)
	eventPlayEnd
end
