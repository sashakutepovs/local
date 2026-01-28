tmpSgX,tmpSgY,tmpSgID = $game_map.get_storypoint("securityGuard")
tmpDtX,tmpDtY,tmpDtID = $game_map.get_storypoint("DormTable")
tmpCcX,tmpCcY,tmpCcID = $game_map.get_storypoint("CorpseCart")
tmpWakeX,tmpWakeY,tmpWakeID = $game_map.get_storypoint("WakeUp")
tmpTpX,tmpTpY,tmpTpID = $game_map.get_storypoint("TorturePoint")
tmpRpX,tmpRpY,tmpRpID = $game_map.get_storypoint("Raper")
tmpShit1X,tmpShit1Y,tmpShit1ID = $game_map.get_storypoint("Shit1")
tmpShit2X,tmpShit2Y,tmpShit2ID = $game_map.get_storypoint("Shit2")
tmpShit3X,tmpShit3Y,tmpShit3ID = $game_map.get_storypoint("Shit3")
tmpShit4X,tmpShit4Y,tmpShit4ID = $game_map.get_storypoint("Shit4")


######################################## begin event ###############################################################
if $story_stats["Captured"] == 1 && $story_stats["ReRollHalfEvents"] ==1 && $story_stats["RapeLoop"] == 1 && $story_stats["RapeLoopTorture"] == 0
	#begin
	portrait_hide
	get_character(tmpSgID).npc_story_mode(true)
	$game_player.moveto(tmpSgX,tmpSgY+2)
	$game_player.direction = 8
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapDoomFortress:DormGuard/SlaveBegin0")
	
	#table
	chcg_background_color(0,0,0,0,7)
		get_character(tmpSgID).moveto(tmpDtX-1,tmpDtY)
		get_character(tmpSgID).direction = 6
		$game_player.moveto(tmpDtX-1,tmpDtY-1)
		$game_player.direction = 6
		portrait_hide
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapDoomFortress:DormGuard/SlaveBegin_Dorm")
	
	#corpse cart
	chcg_background_color(0,0,0,0,7)
		get_character(tmpSgID).moveto(tmpCcX+1,tmpCcY+1)
		get_character(tmpSgID).direction = 8
		$game_player.moveto(tmpCcX,tmpCcY+1)
		$game_player.direction = 8
		portrait_hide
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapDoomFortress:DormGuard/SlaveBegin_Cart")
	
	#WashRoom
	chcg_background_color(0,0,0,0,7)
		get_character(tmpSgID).moveto(tmpWakeX-4,tmpWakeY+1)
		get_character(tmpSgID).direction = 6
		$game_player.moveto(tmpWakeX-5,tmpWakeY+1)
		$game_player.direction = 6
		portrait_hide
	chcg_background_color(0,0,0,255,-7)
	wait(45)
	get_character(tmpSgID).move_forward
	$game_player.move_forward
	wait(45)
	get_character(tmpSgID).move_forward
	$game_player.move_forward
	wait(45)
	get_character(tmpSgID).move_forward
	$game_player.move_forward
	wait(45)
	get_character(tmpSgID).move_forward
	$game_player.move_forward
	wait(45)
	get_character(tmpSgID).direction = 4
	$game_player.direction = 6
	call_msg("TagMapDoomFortress:DormGuard/SlaveBegin_Washroom0")
	call_msg("TagMapDoomFortress:DormGuard/SlaveBegin_Washroom1")
	call_msg("TagMapDoomFortress:DormGuard/SlaveBegin_Washroom2")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		get_character(tmpSgID).moveto(tmpSgX,tmpSgY)
		get_character(tmpSgID).direction = 2
		get_character(tmpSgID).npc_story_mode(false)
		$game_player.moveto(tmpWakeX,tmpWakeY)
		$game_player.direction = 2
		cam_center(0)
		portrait_off
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapDoomFortress:DormGuard/SlaveBegin_end")
	
######################################## Escaped event ###############################################################
elsif $story_stats["Captured"] == 1 && $story_stats["ReRollHalfEvents"] ==1 && $story_stats["RapeLoopTorture"] ==1
	#begin
	portrait_hide
	get_character(tmpSgID).npc_story_mode(true)
	$game_player.moveto(tmpSgX,tmpSgY+2)
	$game_player.direction = 8
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapDoomFortress:DormGuard/SlaveBegin_Escape")

	portrait_hide
	chcg_background_color(0,0,0,0,7)
		get_character(tmpSgID).moveto(tmpSgX,tmpSgY)
		get_character(tmpSgID).direction = 2
		get_character(tmpSgID).npc_story_mode(false)
		$game_player.moveto(tmpWakeX,tmpWakeY)
		$game_player.direction = 2
		cam_center(0)
		portrait_off
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapDoomFortress:DormGuard/SlaveBegin_end")


######################################## Normal Rape ###############################################################
elsif $story_stats["Captured"] == 1 && rand(100) >= 60
	map_background_color(0,0,0,255,0)
	get_character(tmpRpID).npc_story_mode(true)
	get_character(tmpRpID).moveto($game_player.x,$game_player.y)
	get_character(tmpRpID).item_jump_to
	$game_player.turn_toward_character(get_character(tmpRpID))
	get_character(tmpRpID).turn_toward_character($game_player)
	wait(20)
	get_character(tmpRpID).npc_story_mode(false)
	#$game_player.direction = 2
	$game_player.actor.stat["EventMouthRace"] = "Human"
	tmpRace = $game_player.actor.stat["EventMouthRace"]
	map_background_color
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapDoomFortress:Guard/DailyRape0")
	get_character(tmpRpID).animation = get_character(tmpRpID).animation_atk_mh
	SndLib.sound_punch_hit
	call_msg("TagMapDoomFortress:Guard/DailyRape1")
	
	#0 SUCK DICK 1 RAPE
	if rand(2) == 0
		call_msg("TagMapDoomFortress:Guard/DailyRape_suckDick")
		load_script("Data/HCGframes/UniqueEvent_SuckDick.rb")
	else
		tmpFailed = false
		$game_temp.choice = -1
		call_msg("TagMapDoomFortress:Guard/DailyRape_Rape")
		
		if $game_temp.choice == 0
			get_character(tmpRpID).moveto($game_player.x,$game_player.y)
			portrait_hide
			play_sex_service_menu(get_character(tmpRpID),0,nil,true)
		else
			call_msg("commonH:Lona/SuckDick_Failed")
			call_msg("commonH:Lona/SuckDick_#{tmpRace}Failed#{rand(3)}")
			$game_portraits.setLprt("nil")
			$game_player.actor.stat["EventMouthRace"]= tmpRace
			$game_player.actor.stat["EventVagRace"] =  tmpRace
			$game_player.actor.stat["EventAnalRace"] = tmpRace
			$game_player.actor.stat["EventExt1Race"] = tmpRace
			$game_player.actor.stat["EventExt2Race"] = tmpRace
			$game_player.actor.stat["EventExt3Race"] = tmpRace
			$game_player.actor.stat["EventExt4Race"] = tmpRace
			load_script("Data/batch/common_MCtorture_FunBeaten_event.rb")
		end
		
	end
	
	chcg_background_color(0,0,0,0,7)
		whole_event_end
		get_character(tmpRpID).moveto(1,1)
	chcg_background_color(0,0,0,255,-7)
end


######################################## setup Raper ###############################################################
if $game_date.day?
	case rand(4)
		when 0 ;get_character(tmpRpID).moveto(tmpShit1X,tmpShit1Y+1)
		when 1 ;get_character(tmpRpID).moveto(tmpShit2X,tmpShit2Y+1)
		when 2 ;get_character(tmpRpID).moveto(tmpShit3X,tmpShit3Y+1)
		when 3 ;get_character(tmpRpID).moveto(tmpShit4X,tmpShit4Y+1)
	end
	get_character(tmpRpID).direction = 8
	get_character(tmpRpID).animation = get_character(tmpRpID).animation_masturbation
end

######################################## end ###############################################################
portrait_hide
cam_center(0)