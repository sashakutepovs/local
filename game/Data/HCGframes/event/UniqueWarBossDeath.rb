
SndLib.bgs_play("D/ATMO EERIE Cave, Water Drips, Emptyness, Howling Interior Wind, Oppressive, LOOP",50)
SndLib.me_play("/ME/Frantic Battle LOOP END")
tmpOgreEV = get_character(0).summon_data[:user]
tmpOgreEV.zoom_x = 1.2
tmpOgreEV.zoom_y = 1.2



GabeSDK.getAchievement("DefeatOrkindWarboss") if !tmpOgreEV.summon_data[:WarbossOrkindSlayerWin]
eventPlayStart

if get_character(0).summon_data[:user].summon_data[:StoryMode]
	#tmpOgreEV.character_index	= 3
	#tmpOgreEV.animation = nil
	tmpOgreEV.priority_type = 1
	tmpOgreEV.forced_x = 0
	tmpOgreEV.forced_y = 0
	tmpOgreEV.forced_z = 0

	tmpCenterX,tmpCenterY,tmpCenterID = $game_map.get_storypoint("Center")
	tmpArmoredSetCropseX,tmpArmoredSetCropseY,tmpArmoredSetCropseID = $game_map.get_storypoint("ArmoredSetCropse")
	tmpBossRoomDoorX,tmpBossRoomDoorY,tmpBossRoomDoorID = $game_map.get_storypoint("BossRoomDoor")
	
	get_character(tmpBossRoomDoorID).pattern = get_character(tmpBossRoomDoorID).manual_pattern = 1
	get_character(tmpBossRoomDoorID).summon_data[:locked] = false
	SndLib.closeDoor(50,50)
	
	#if !tmpOgreEV.summon_data[:GoblinSlayerMode]
		get_character(tmpArmoredSetCropseID).animation = get_character(tmpArmoredSetCropseID).aniCustom(get_character(tmpArmoredSetCropseID).summon_data[:aniArr],-1)
		get_character(tmpArmoredSetCropseID).effects=["FadeIn",0,false,nil,nil,nil]
		get_character(tmpArmoredSetCropseID).moveto(tmpCenterX,tmpCenterY)
	#end
	
	if tmpOgreEV.summon_data[:WarbossOrkindSlayerWin]
	 #do nothing for now
	
	elsif get_character(0).summon_data[:deathType] == "sta"
		$game_map.delete_npc(tmpOgreEV)
		tmpOgreEV.npc = nil
		tmpOgreEV.character_index	= 3
		tmpOgreEV.mirror = false
		tmpOgreEV.forced_x = 0
		tmpOgreEV.forced_y = 0
		tmpOgreEV.forced_z = 0
		tmpOgreEV.direction_fix = false
		tmpOgreEV.priority_type = 1
		tmpOgreEV.animation = nil
		tmpOgreEV.move_type = 0
		tmpGobFucker1X,tmpGobFucker1Y,tmpGobFucker1ID = $game_map.get_storypoint("GobFucker1")
		tmpGobFucker2X,tmpGobFucker2Y,tmpGobFucker2ID = $game_map.get_storypoint("GobFucker2")
		tmpToBossRoomX,tmpToBossRoomY,tmpToBossRoomID = $game_map.get_storypoint("ToBossRoom")
		tmpWarBossRapedX,tmpWarBossRapedY,tmpWarBossRapedID = $game_map.get_storypoint("WarBossRaped")
		tmpCamX,tmpCamY,tmpCamID = $game_map.get_storypoint("Cam")
		tmpOgreEV.set_manual_move_type(0)
		tmpOgreEV.npc_story_mode(true)
		tmpOgreEV.balloon_XYfix = -40
		get_character(tmpGobFucker1ID).npc_story_mode(true)
		get_character(tmpGobFucker2ID).npc_story_mode(true)
		get_character(tmpCamID).npc_story_mode(true)
		get_character(tmpGobFucker1ID).opacity = 255
		get_character(tmpGobFucker2ID).opacity = 255
		
		#ogre_hurt_jump
		tmpOgreEV.character_index = 4
		tmpOgreEV.jump_to(tmpOgreEV.x,tmpOgreEV.y)
		wait(20)
		tmpOgreEV.character_index = 3
		if tmpOgreEV.report_range($game_player) >= 2
			$game_player.move_toward_character(tmpOgreEV)
			$game_player.move_speed = 4
		end
		tmpOgreEV.move_away_from_character($game_player)
		tmpOgreEV.move_speed = 2.5
		tmpOgreEV.call_balloon(6)
		until !$game_player.moving?; wait(1) end
		
		#lona move to boss
		rang1 = 0
		count = 0
		until rang1 >= 1 || count >= 3
			rang1 = tmpOgreEV.report_range($game_player)
			$game_player.move_toward_character(tmpOgreEV) if rang1 >= 1
			$game_player.move_speed = 3
			rang1 = tmpOgreEV.report_range($game_player)
			count += 1
			until !$game_player.moving?; wait(1) end
		end
		
		cam_follow(tmpCamID,0)
		#move Cam
		get_character(tmpCamID).moveto($game_player.x,$game_player.y)
		get_character(tmpCamID).direction = 8 ; get_character(tmpCamID).movetoRolling(tmpOgreEV.x,tmpOgreEV.y)
		get_character(tmpCamID).move_speed = 5
		until !get_character(tmpCamID).moving? ; wait(1) end
		
		wait(20)
		$game_player.jump_to($game_player.x,$game_player.y)
		tmpOgreEV.character_index	= 3
		tmpOgreEV.animation = nil
		call_msg("TagMapSyb_WarBossRoom:Win/StaWin0") ; portrait_hide
		
		
		#Gob move to boss
		get_character(tmpGobFucker1ID).moveto(tmpOgreEV.x,tmpOgreEV.y-7)
		get_character(tmpGobFucker2ID).moveto(tmpOgreEV.x,tmpOgreEV.y-7)
		get_character(tmpGobFucker1ID).jump_to(tmpOgreEV.x,tmpOgreEV.y)
		get_character(tmpGobFucker1ID).item_jump_to
		wait(5)
		get_character(tmpGobFucker2ID).jump_to(tmpOgreEV.x,tmpOgreEV.y)
		get_character(tmpGobFucker2ID).item_jump_to
		get_character(tmpGobFucker1ID).turn_toward_character(tmpOgreEV)
		get_character(tmpGobFucker2ID).turn_toward_character(tmpOgreEV)
		SndLib.sound_goblin_spot(80,100)
		wait(2)
		SndLib.sound_goblin_spot(80,120)
		$game_player.call_balloon(1)
		2.times{
			$game_player.move_away_from_character(tmpOgreEV)
			$game_player.move_speed = 4
			$game_player.turn_toward_character(tmpOgreEV)
		}
		wait(50)
		call_msg("TagMapSyb_WarBossRoom:Win/StaWin1") ; portrait_hide
		
		######### Gob Beat up Ogre.
		get_character(tmpGobFucker1ID).call_balloon(8)
		tmpOgreEV.turn_toward_character(get_character(tmpGobFucker1ID))
		wait(60)
		get_character(tmpGobFucker2ID).call_balloon(8)
		tmpOgreEV.turn_toward_character(get_character(tmpGobFucker2ID))
		wait(60)
		get_character(tmpGobFucker1ID).animation = get_character(tmpGobFucker1ID).animation_atk_mh
		get_character(tmpGobFucker1ID).call_balloon([15,7,5].sample)
		tmpOgreEV.turn_toward_character(get_character(tmpGobFucker1ID))
		SndLib.sound_goblin_roar(80)
		wait(5)
		tmpOgreEV.call_balloon(6)
		SndLib.sound_punch_hit(100)
		SndLib.sound_OgreHurt(100,90+rand(80))
		wait(60)
		get_character(tmpGobFucker2ID).animation = get_character(tmpGobFucker2ID).animation_atk_mh
		get_character(tmpGobFucker2ID).call_balloon([15,7,5].sample)
		tmpOgreEV.turn_toward_character(get_character(tmpGobFucker2ID))
		SndLib.sound_goblin_roar(80)
		wait(5)
		tmpOgreEV.call_balloon(6)
		SndLib.sound_punch_hit(100)
		SndLib.sound_OgreHurt(100,90+rand(80))
		wait(60)
		6.times{
			get_character(tmpGobFucker1ID).animation = get_character(tmpGobFucker1ID).animation_atk_mh
			get_character(tmpGobFucker1ID).call_balloon([15,7,5].sample) if rand(100) >= 80
			tmpOgreEV.turn_toward_character(get_character(tmpGobFucker1ID))
			SndLib.sound_goblin_roar(80) if rand(100) >= 80
			wait(5)
			tmpOgreEV.call_balloon(6) if rand(100) >= 80
			SndLib.sound_OgreHurt(100,90+rand(80)) if rand(100) >= 60
			SndLib.sound_punch_hit(100)
			wait(10+rand(5))
			get_character(tmpGobFucker2ID).animation = get_character(tmpGobFucker2ID).animation_atk_mh
			get_character(tmpGobFucker2ID).call_balloon([15,7,5].sample) if rand(100) >= 80
			tmpOgreEV.turn_toward_character(get_character(tmpGobFucker2ID))
			SndLib.sound_goblin_roar(80) if rand(100) >= 80
			wait(5)
			tmpOgreEV.call_balloon(6) if rand(100) >= 80
			SndLib.sound_OgreHurt(100,90+rand(80)) if rand(100) >= 60
			SndLib.sound_punch_hit(100)
			wait(10+rand(5))
		}
		get_character(tmpGobFucker1ID).call_balloon(8)
		tmpOgreEV.turn_toward_character(get_character(tmpGobFucker1ID))
		tmpOgreEV.call_balloon(6)
		wait(60)
		get_character(tmpGobFucker2ID).call_balloon(8)
		tmpOgreEV.turn_toward_character(get_character(tmpGobFucker2ID))
		tmpOgreEV.call_balloon(6)
		wait(60)
		SndLib.sound_OgreDed(100,120)
		tmpOgreEV.call_balloon(8)
		tmpOgreEV.turn_toward_character($game_player)
		get_character(tmpGobFucker1ID).call_balloon(4)
		get_character(tmpGobFucker2ID).call_balloon(4)
		get_character(tmpGobFucker1ID).set_event_storymode_fuck_a_target(nil)
		get_character(tmpGobFucker2ID).set_event_storymode_fuck_a_target(nil)
		SndLib.sound_chs_pyu
		wait(50)
		call_msg("TagMapSyb_WarBossRoom:Win/StaWin2") ; portrait_hide
		
		chcg_background_color(0,0,0,0,7)
			cam_center(0)
			tmpOgreEV.npc_story_mode(false)
			get_character(tmpWarBossRapedID).opacity = 255
			get_character(tmpWarBossRapedID).move_type = 3
			get_character(tmpWarBossRapedID).set_manual_move_type(3)
			get_character(tmpWarBossRapedID).animation = get_character(tmpWarBossRapedID).aniCustom(get_character(tmpWarBossRapedID).summon_data[:aniArr],-1)
			get_character(tmpWarBossRapedID).moveto(tmpOgreEV.x,tmpOgreEV.y)
			get_character(tmpGobFucker1ID).npc_story_mode(false)
			get_character(tmpGobFucker2ID).npc_story_mode(false)
			get_character(tmpCamID).npc_story_mode(false)
			get_character(tmpGobFucker1ID).delete
			get_character(tmpGobFucker2ID).delete
			tmpOgreEV.delete
		chcg_background_color(0,0,0,255,-7)
		GabeSDK.getAchievement("DefeatOrkindWarbossSTA")
	end
end

get_character(0).erase
get_character(0).delete
