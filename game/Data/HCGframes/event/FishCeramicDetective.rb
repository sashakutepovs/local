if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).call_balloon(0)
if $game_player.player_slave? || $game_player.actor.weak >= 50
	call_msg("TagMapFishCeramic:Detective/Slave")
	eventPlayEnd
	return
end

if $story_stats["RecQuestFishCeramic"] == 0
	call_msg("TagMapFishCeramic:Detective/NotKilled0_#{rand(2)}")
	call_msg("TagMapFishCeramic:Detective/NotKilled1")
	call_msg("TagMapFishCeramic:Detective/NotKilled1_about") if $game_temp.choice == 1 #[沒事,關於]

elsif $story_stats["RecQuestFishCeramic"] == 1
	tmpDetectiveX,tmpDetectiveY,tmpDetectiveID= $game_map.get_storypoint("Detective")
	$story_stats["RecQuestFishCeramic"] = 2
	
	chcg_background_color(0,0,0,0,7)
		get_character(0).moveto(tmpDetectiveX,tmpDetectiveY)
		get_character(0).direction = 4
		$game_player.moveto(tmpDetectiveX-1,tmpDetectiveY)
		$game_player.direction = 6
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapFishCeramic:Detective/killed0")
	get_character(0).npc_story_mode(true)
	cam_center(0)
	get_character(0).direction = 8 ; get_character(0).move_forward_force ; wait(35) ; $game_player.turn_toward_character(get_character(0))
	get_character(0).direction = 8 ; get_character(0).move_forward_force ; wait(35) ; $game_player.turn_toward_character(get_character(0))
	get_character(0).direction = 8 ; get_character(0).move_forward_force ; wait(35) ; $game_player.turn_toward_character(get_character(0))
	get_character(0).direction = 8 ; get_character(0).move_forward_force ; wait(35) ; $game_player.turn_toward_character(get_character(0))
	until get_character(0).opacity <= 5
		get_character(0).opacity -= 5
		wait(1)
	end
	posi=$game_map.region_map[44].sample
	get_character(0).moveto(posi[0],posi[1])
	get_character(0).opacity = 255
	get_character(0).npc_story_mode(false)
	get_character(0).set_manual_move_type(1)
	get_character(0).move_type = 1
	call_msg("TagMapFishCeramic:Detective/killed1")
	optain_exp(3500)
else
	SndLib.FishkindSmSpot
	call_msg_popup("TagMapFishCeramic:Detective/Qmsg#{rand(3)}",get_character(0).id)
end
eventPlayEnd
