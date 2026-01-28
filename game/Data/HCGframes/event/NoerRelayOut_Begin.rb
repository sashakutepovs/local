
if $story_stats["RecQuestNoerRelayOutOP"] == 0
	portrait_hide
	$story_stats["RecQuestNoerRelayOutOP"] = 1
	tmpSaFighterX,tmpSaFighterY,tmpSaFighterID=$game_map.get_storypoint("SaFighter")
	tmpSaPriestX,tmpSaPriestY,tmpSaPriestID=$game_map.get_storypoint("SaPriest")
	tmpHoboF_X,tmpHoboF_Y,tmpHoboF_ID=$game_map.get_storypoint("HoboF")
	tmpHoboM_X,tmpHoboM_Y,tmpHoboM_ID=$game_map.get_storypoint("HoboM")
	tmpGuardMainX,tmpGuardMainY,tmpGuardMainID=$game_map.get_storypoint("GuardMain")
	$game_player.direction = 4 ; $game_player.call_balloon(8) ; cam_center(0) ; wait(60)
	#call_msg("TagMapNoerRelayOut:mapOP/begin0") ; portrait_hide
	$game_player.direction = 6 ; $game_player.call_balloon(8) ; cam_center(0) ; wait(60)
	#call_msg("TagMapNoerRelayOut:mapOP/begin0") ; portrait_hide
	$game_player.direction = 8 ; $game_player.call_balloon(8) ; cam_center(0) ; wait(60)
	call_msg("TagMapNoerRelayOut:mapOP/begin0") ; portrait_hide
	$game_player.direction = 8 ; $game_player.call_balloon(8) ; cam_center(0) ; wait(60)
	$game_player.direction = 4 ; $game_player.call_balloon(8) ; cam_center(0) ; wait(60)
	call_msg("TagMapNoerRelayOut:mapOP/begin1") ; portrait_hide
end
if $story_stats["QuProgSaveCecily"] == 13 && $game_player.record_companion_name_back == "UniqueCecily"
	call_msg("....")
	tmpPotId = $game_map.get_storypoint("pot")[2]
	get_character($game_player.get_companion_id(1)).npc_story_mode(true)
	get_character($game_player.get_companion_id(0)).npc_story_mode(true)
	tmpBmove_type = get_character($game_player.get_companion_id(1)).move_type
	tmpFmove_type = get_character($game_player.get_companion_id(0)).move_type
	get_character($game_player.get_companion_id(1)).move_type = 0
	get_character($game_player.get_companion_id(0)).move_type = 0
	
	get_character($game_player.get_companion_id(1)).direction = 4
	get_character($game_player.get_companion_id(0)).direction = 6
	get_character($game_player.get_companion_id(1)).move_forward_force
	get_character($game_player.get_companion_id(0)).move_forward_force
	wait(60)
	get_character($game_player.get_companion_id(0)).turn_toward_character($game_player)
	call_msg("CompCecily:Cecily/QuestHikack13_0") ; portrait_hide
	
	$game_player.direction = 8
	$game_player.call_balloon(8)
	wait(60)
	$game_player.direction = 2
	$game_player.call_balloon(8)
	wait(60)
	$game_player.direction = 6
	$game_player.call_balloon(8)
	wait(60)
	call_msg("CompCecily:Cecily/QuestHikack13_1")
	
	get_character(tmpPotId).call_balloon(28,-1)
	get_character($game_player.get_companion_id(1)).move_type = tmpBmove_type
	get_character($game_player.get_companion_id(0)).move_type = tmpFmove_type
	get_character($game_player.get_companion_id(1)).npc_story_mode(false)
	get_character($game_player.get_companion_id(0)).npc_story_mode(false)
	
end