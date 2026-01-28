
#EliseQP2
if $story_stats["RecQuestElise"] == 10 && $game_player.record_companion_name_ext == "CompExtUniqueElise" && $story_stats["UniqueCharUniqueElise"] != -1
	get_character(0).call_balloon(0)
	if $game_map.threat
		SndLib.sys_buzzer
		$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
		return
	end
	tmpEqp0X,tmpEqp0Y,tmpEqp0ID=$game_map.get_storypoint("EliseQP0")
	tmpEqp1X,tmpEqp1Y,tmpEqp1ID=$game_map.get_storypoint("EliseQP1")
	tmpEqp2X,tmpEqp2Y,tmpEqp2ID=$game_map.get_storypoint("EliseQP2")
	tmpEqp3X,tmpEqp3Y,tmpEqp3ID=$game_map.get_storypoint("EliseQP3")
	tmpEliseID=$game_player.get_followerID(-1)
	$story_stats["RecQuestElise"] = 11
	
	
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		$game_player.moveto(tmpEqp2X+2,tmpEqp2Y+1)
		get_character(tmpEliseID).moveto(tmpEqp2X+1,tmpEqp2Y)
		$game_player.direction = 4
		get_character(tmpEliseID).direction = 4
	chcg_background_color(0,0,0,255,-7)
	call_msg("CompElise:FishResearch1/11_begin1")
		get_character(tmpEliseID).direction = 6
	call_msg("CompElise:FishResearch1/11_begin2")
		get_character(tmpEliseID).direction = 4
	call_msg("CompElise:FishResearch1/11_begin3")
		get_character(tmpEliseID).direction = 6
	call_msg("CompElise:FishResearch1/11_begin4")
	get_character(tmpEqp3ID).call_balloon(28,-1)
	eventPlayEnd
end