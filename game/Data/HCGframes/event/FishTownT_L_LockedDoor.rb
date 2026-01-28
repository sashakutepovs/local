if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

	$game_temp.choice == -1
	call_msg("TagMapFishTownT:release/DeepOneF")
	call_msg("TagMapNoerMobHouse:Door/UnlockedOUT")
	if $game_temp.choice == 1
		chcg_background_color(0,0,0,1,7)
		wait(35)
		SndLib.sound_step_chain(100,90+rand(20))
		wait(35)
		SndLib.sound_step_chain(100,90+rand(20))
		wait(35)
		SndLib.sound_step_chain(100,90+rand(20))
		wait(35)
		SndLib.sound_step_chain(100,90+rand(20))
		call_msg("TagMapNoerMobHouse:Door/UnlockedOUT_win")
		get_character(0).switch1_id = 120
		get_character(0).moveto(1,1)
		tmpRwx,tmpRwy,tmpRwID=$game_map.get_storypoint("FdepPT")
		tmpFFR1x,tmpFFR1y,tmpFFR1ID=$game_map.get_storypoint("FFregR1")
		tmpFFR2x,tmpFFR2y,tmpFFR2ID=$game_map.get_storypoint("FFregR2")
		tmpFFL1x,tmpFFL1y,tmpFFL1ID=$game_map.get_storypoint("FFregL1")
		tmpFFL2x,tmpFFL2y,tmpFFL2ID=$game_map.get_storypoint("FFregL2")
		get_character(tmpFFR1ID).moveto(tmpRwx+1,tmpRwy+1)
		get_character(tmpFFR2ID).moveto(tmpRwx+1,tmpRwy+2)
		get_character(tmpFFL1ID).moveto(tmpRwx-1,tmpRwy+1)
		get_character(tmpFFL2ID).moveto(tmpRwx-1,tmpRwy+2)
		get_character(tmpFFR1ID).set_manual_move_type(3)
		get_character(tmpFFR2ID).set_manual_move_type(3)
		get_character(tmpFFL1ID).set_manual_move_type(3)
		get_character(tmpFFL2ID).set_manual_move_type(3)
		get_character(tmpFFR1ID).move_type = 3
		get_character(tmpFFR2ID).move_type = 3
		get_character(tmpFFL1ID).move_type = 3
		get_character(tmpFFL2ID).move_type = 3
		get_character(tmpFFR1ID).set_move_frequency(5)
		get_character(tmpFFR2ID).set_move_frequency(5)
		get_character(tmpFFL1ID).set_move_frequency(5)
		get_character(tmpFFL2ID).set_move_frequency(5)
		get_character(tmpFFR1ID).move_frequency = 5
		get_character(tmpFFR2ID).move_frequency = 5
		get_character(tmpFFL1ID).move_frequency = 5
		get_character(tmpFFL2ID).move_frequency = 5
		
		
		if [15,16,17].include?($story_stats["RecQuestElise"]) && $story_stats["UniqueCharUniqueElise"] != -1
			get_character(tmpFFR1ID).set_npc("FishkindCommonerF")
			get_character(tmpFFR2ID).set_npc("FishkindCommonerF")
			get_character(tmpFFL1ID).set_npc("FishkindCommonerF")
			get_character(tmpFFL2ID).set_npc("FishkindCommonerF")
		#	get_character(tmpFFR1ID).npc.death_event="FishkindChargerF"
		#	get_character(tmpFFR2ID).npc.death_event="FishkindChargerF"
		#	get_character(tmpFFL1ID).npc.death_event="FishkindChargerF"
		#	get_character(tmpFFL2ID).npc.death_event="FishkindChargerF"
		else
			get_character(tmpFFR1ID).set_npc("FishkindCommonerF")
			get_character(tmpFFR2ID).set_npc("FishkindChargerF")
			get_character(tmpFFL1ID).set_npc("FishkindCommonerF")
			get_character(tmpFFL2ID).set_npc("FishkindChargerF")
		end
		#get_character(tmpFFR1ID).npc.no_aggro = true
		#get_character(tmpFFR2ID).npc.no_aggro = true
		#get_character(tmpFFL1ID).npc.no_aggro = true
		#get_character(tmpFFL2ID).npc.no_aggro = true
		
		chcg_background_color(0,0,0,255,-7)
	end

eventPlayEnd