if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
elsif [25,26].include?($story_stats["RecQuestCocona"])
	SndLib.sys_DoorLock
	call_msg_popup("TagMapNoerCatacomb:Necropolis/Locked#{rand(2)}")
	return
end
tmpBiosID = $game_map.get_storypoint("DualBios")[2]
tmpPwX,tmpPwY,tmpPwID = $game_map.get_storypoint("PlayerWatch")
tmpCpX,tmpCpY,tmpCpID = $game_map.get_storypoint("CenterPillar")
tmpTsX,tmpTsY,tmpTsID=$game_map.get_storypoint("TicketSeller")
tmpRpX,tmpRpY,tmpRpID=$game_map.get_storypoint("Reporter")
tmpG1X,tmpG1Y,tmpG1ID=$game_map.get_storypoint("Gate1")
tmpG2X,tmpG2Y,tmpG2ID=$game_map.get_storypoint("Gate2")
tmpEastColossusX,tmpEastColossusY,tmpEastColossusID=$game_map.get_storypoint("EastColossus")
tmpSexBeastX,tmpSexBeastY,tmpSexBeastID=$game_map.get_storypoint("SexBeast")
tmpRightArenaX,tmpRightArenaY,tmpRightArenaID=$game_map.get_storypoint("RightArenaE")
tmpLeftArenaX,tmpLeftArenaY,tmpLeftArenaID=$game_map.get_storypoint("LeftArenaE")
tmpLightTopX,tmpLightTopY,tmpLightTopID=$game_map.get_storypoint("FireT")
tmpHowMuch = get_character(tmpBiosID).summon_data[:HowMuch]
tmpPlayedOP = get_character(tmpBiosID).summon_data[:PlayedOP]
tmpMultiple = get_character(tmpBiosID).summon_data[:Multiple]
tmpBetTarget = get_character(tmpBiosID).summon_data[:BetTarget]
tmpMatchEnd = get_character(tmpBiosID).summon_data[:MatchEnd]
tmpPlayerMatch = get_character(tmpBiosID).summon_data[:PlayerMatch]
tmpFireTx,tmpFireTy,tmpFireTid = $game_map.get_storypoint("FireT")
tmpFireBx,tmpFireBy,tmpFireBid = $game_map.get_storypoint("FireB")
tmpFireLx,tmpFireLy,tmpFireLid = $game_map.get_storypoint("FireL")
tmpFireRx,tmpFireRy,tmpFireRid = $game_map.get_storypoint("FireR")

###################################################################################################### FIRST TIME
if $story_stats["RecQuestNoerArena"] == 1 && get_character(tmpBiosID).summon_data[:PlayedOP] == false
	SndLib.sys_StepChangeMap
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpBiosID).summon_data[:PlayedPrevX] = $game_player.x
		get_character(tmpBiosID).summon_data[:PlayedPrevY] = $game_player.y
		$game_player.moveto(tmpPwX,tmpPwY+1)
		$game_player.direction = 2
		$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:viewers]
			event[1].opacity =  255
			event[1].force_update = true
		}
		get_character(tmpCpID).opacity = 0
		get_character(tmpCpID).set_event_terrain_tag(0)
		get_character(tmpCpID).through = true
		get_character(tmpRpID).opacity = 0
		get_character(tmpRpID).moveto(tmpRpX,tmpRpY)
		get_character(tmpRpID).drop_light
		SndLib.bgm_stop
		SndLib.bgs_stop
	chcg_background_color(0,0,0,255,-7)
	SndLib.bgs_play("AMBIENCE_Public_Hall_Chatter_01_loop_stereo",80,100,RPG::BGS.last.pos)
	call_msg("TagMapNoerArena:firstTime/firstMatch0")
	SndLib.bgs_stop
	call_msg("TagMapNoerArena:firstTime/firstMatch1") ; portrait_hide
	SndLib.play_cursor(50)
	wait(5)
	get_character(tmpRpID).give_light("red600_3")
	SndLib.ppl_CheerGroup(100)
	call_msg("TagMapNoerArena:firstTime/firstMatch2") ; portrait_hide
	$game_player.direction = 4
	get_character(tmpRpID).opacity = 5
	25.times{
		get_character(tmpRpID).opacity += 10
		wait(2)
	}
	SndLib.ppl_CheerGroup(100)
	wait(30)
	get_character(tmpRpID).set_animation("animation_dance")
	SndLib.ppl_CheerGroup(100)
	call_msg("TagMapNoerArena:firstTime/firstMatch3") ; portrait_hide
	get_character(tmpRpID).animation = nil
	wait(35)
	get_character(tmpRpID).move_forward
	wait(35)
	get_character(tmpRpID).move_forward
	wait(35)
	SndLib.ppl_CheerGroup(100)
	call_msg("TagMapNoerArena:firstTime/firstMatch4") ; portrait_hide
	SndLib.ppl_CheerGroup(100)
	call_msg("TagMapNoerArena:firstTime/firstMatch5") ; portrait_hide
	get_character(tmpEastColossusID).moveto(tmpLeftArenaX,tmpLeftArenaY+1)
	get_character(tmpEastColossusID).force_update = true
	get_character(tmpEastColossusID).opacity = 5
	#cam_follow(tmpEastColossusID,0)
	SndLib.ppl_CheerGroup(100)
	25.times{
		get_character(tmpEastColossusID).opacity += 10
		wait(2)
	}
	$game_player.direction = 4
	SndLib.ppl_CheerGroup(100)
	wait(20)
	get_character(tmpEastColossusID).call_balloon(20) ; SndLib.MaleWarriorFatSpot(100)
	wait(40)
	call_msg("TagMapNoerArena:firstTime/firstMatch6") ; portrait_hide
	get_character(tmpSexBeastID).moveto(tmpRightArenaX,tmpRightArenaY+1)
	get_character(tmpSexBeastID).force_update = true
	get_character(tmpSexBeastID).opacity = 5
	#cam_follow(tmpSexBeastID,0)
	25.times{
		get_character(tmpSexBeastID).opacity += 10
		wait(2)
	}
	$game_player.direction = 4
	wait(20)
	get_character(tmpSexBeastID).call_balloon(20) ; SndLib.MaleWarriorGruntSpot(100)
	wait(40)
	call_msg("TagMapNoerArena:firstTime/firstMatch7") ; portrait_hide
	call_msg("TagMapNoerArena:firstTime/firstMatch8") ; portrait_hide
	SndLib.ppl_CheerGroup(100)
	call_msg("TagMapNoerArena:firstTime/firstMatch9") ; portrait_hide
	SndLib.ppl_CheerGroup(100)
	cam_follow(tmpLightTopID,0)
	4.times{
		get_character(tmpSexBeastID).move_forward_force
		get_character(tmpEastColossusID).move_forward_force
		wait(35)
	}
	get_character(tmpEastColossusID).direction = 6
	get_character(tmpSexBeastID).direction = 4
	SndLib.bgm_play("CB_Combat LOOP",79,105,RPG::BGM.last.pos)
	wait(40)
	call_msg("TagMapNoerArena:firstTime/firstMatch10") ; portrait_hide
	SndLib.ppl_CheerGroup(100)
	call_msg("TagMapNoerArena:firstTime/firstMatch11") ; portrait_hide
	
	cam_follow(tmpEastColossusID,0)
	get_character(tmpSexBeastID).move_forward_force ; SndLib.MaleWarriorGruntSpot(100)
	wait(15)
	get_character(tmpEastColossusID).jump_to(get_character(tmpSexBeastID).x-1,get_character(tmpSexBeastID).y) ; SndLib.sound_equip_armor ; SndLib.MaleWarriorFatSpot(100)
	wait(20)
	get_character(tmpEastColossusID).set_animation("animation_atk_mh") ; wait(5) ; SndLib.sound_whoosh(80) ; SndLib.MaleWarriorFatAtk(100) ; wait(5) ; SndLib.sound_punch_hit(100)
	get_character(tmpSexBeastID).jump_to(get_character(tmpSexBeastID).x+1,get_character(tmpSexBeastID).y)
	wait(20)
	get_character(tmpEastColossusID).jump_to(get_character(tmpSexBeastID).x-1,get_character(tmpSexBeastID).y)
	get_character(tmpEastColossusID).set_animation("animation_atk_sh") ; wait(5) ; SndLib.sound_whoosh(80) ; SndLib.MaleWarriorFatAtk(100) ; wait(5) ; SndLib.sound_punch_hit(100)
	get_character(tmpSexBeastID).jump_to(get_character(tmpSexBeastID).x+1,get_character(tmpSexBeastID).y)
	get_character(tmpSexBeastID).direction = 4
	wait(15)
	get_character(tmpSexBeastID).set_animation("animation_stun")
	get_character(tmpEastColossusID).move_forward_force
	wait(35)
	call_msg("TagMapNoerArena:firstTime/firstMatch12") ; portrait_hide
	get_character(tmpSexBeastID).animation = nil ; SndLib.MaleWarriorGruntSpot(100)
	wait(10)
	get_character(tmpSexBeastID).set_animation("animation_atk_mh") ; SndLib.MaleWarriorGruntAtk(100) ; wait(5) ; SndLib.sound_whoosh(80)
	wait(3)
	get_character(tmpEastColossusID).jump_to(get_character(tmpSexBeastID).x-3,get_character(tmpSexBeastID).y) ; SndLib.sound_equip_armor ; SndLib.MaleWarriorFatSpot(100)
	get_character(tmpEastColossusID).direction = 6
	call_msg("TagMapNoerArena:firstTime/firstMatch13") ; portrait_hide
	get_character(tmpSexBeastID).move_forward_force
	wait(35)
	get_character(tmpEastColossusID).jump_to(get_character(tmpSexBeastID).x-1,get_character(tmpSexBeastID).y) ; SndLib.sound_equip_armor ; SndLib.MaleWarriorFatSpot(100)
	wait(15)
	get_character(tmpEastColossusID).set_animation("animation_atk_piercing") ; wait(5) ; SndLib.sound_whoosh(80) ; wait(5) ; SndLib.sound_punch_hit(100)
	wait(5)
	get_character(tmpSexBeastID).set_animation("animation_stun")
	call_msg("TagMapNoerArena:firstTime/firstMatch14") ; portrait_hide
	get_character(tmpEastColossusID).direction = 8
	call_msg("TagMapNoerArena:firstTime/firstMatch15") ; portrait_hide
	get_character(tmpSexBeastID).animation = nil
	get_character(tmpEastColossusID).direction = 6
	call_msg("TagMapNoerArena:firstTime/firstMatch16") ; portrait_hide
	get_character(tmpSexBeastID).set_animation("animation_atk_mh") ; SndLib.MaleWarriorGruntAtk(100) ; wait(5) ; SndLib.sound_whoosh(80) ; wait(5) ; SndLib.sound_punch_hit(100)
	wait(8)
	get_character(tmpEastColossusID).jump_to(get_character(tmpSexBeastID).x-2,get_character(tmpSexBeastID).y) ; get_character(tmpEastColossusID).direction = 6
	wait(10)
	get_character(tmpEastColossusID).set_animation("animation_stun")
	wait(10)
	get_character(tmpSexBeastID).move_forward_force
	wait(35)
	call_msg("TagMapNoerArena:firstTime/firstMatch17")
	get_character(tmpSexBeastID).set_animation("animation_atk_sh") ; SndLib.MaleWarriorGruntAtk(100) ; wait(5) ; SndLib.sound_whoosh(80) ; wait(5) ; SndLib.sound_punch_hit(100)
	wait(8)
	get_character(tmpEastColossusID).jump_to(get_character(tmpSexBeastID).x-2,get_character(tmpSexBeastID).y) ; get_character(tmpEastColossusID).direction = 6
	wait(10)
	get_character(tmpEastColossusID).set_animation("animation_stun")
	wait(10)
	get_character(tmpSexBeastID).move_forward_force
	wait(35)
	call_msg("TagMapNoerArena:firstTime/firstMatch18")
	get_character(tmpSexBeastID).set_animation("animation_atk_mh") ; SndLib.MaleWarriorGruntAtk(100) ; wait(5) ; SndLib.sound_whoosh(80) ; wait(5) ; SndLib.sound_punch_hit(100)
	wait(8)
	get_character(tmpEastColossusID).jump_to(get_character(tmpSexBeastID).x-2,get_character(tmpSexBeastID).y) ; get_character(tmpEastColossusID).direction = 6
	wait(10)
	get_character(tmpEastColossusID).set_animation("animation_stun")
	wait(10)
	get_character(tmpSexBeastID).move_forward_force
	wait(35)
	call_msg("TagMapNoerArena:firstTime/firstMatch19")
	get_character(tmpSexBeastID).set_animation("animation_atk_sh") ; SndLib.MaleWarriorGruntAtk(100) ; wait(5) ; SndLib.sound_whoosh(80) ; wait(5) ; SndLib.sound_punch_hit(100)
	wait(8)
	get_character(tmpEastColossusID).jump_to(get_character(tmpSexBeastID).x-2,get_character(tmpSexBeastID).y) ; get_character(tmpEastColossusID).direction = 6
	wait(10)
	get_character(tmpEastColossusID).set_animation("animation_stun")
	wait(10)
	get_character(tmpSexBeastID).move_forward_force
	wait(35)
	get_character(tmpEastColossusID).animation = nil
	call_msg("TagMapNoerArena:firstTime/firstMatch20") ; portrait_hide
	cam_follow(tmpEastColossusID,0)
	get_character(tmpEastColossusID).call_balloon(8)
	wait(35)
	get_character(tmpEastColossusID).character_index = 3
	get_character(tmpEastColossusID).call_balloon(8)
	wait(35)
	get_character(tmpEastColossusID).call_balloon(8)
	wait(35)
	get_character(tmpEastColossusID).direction = 4
	call_msg("TagMapNoerArena:firstTime/firstMatch21") ; portrait_hide
	get_character(tmpSexBeastID).animation = get_character(tmpSexBeastID).animation_grabber_qte(get_character(tmpEastColossusID))
	get_character(tmpEastColossusID).animation = get_character(tmpEastColossusID).animation_grabbed_qte
	SndLib.sound_equip_armor
	call_msg("TagMapNoerArena:firstTime/firstMatch22") ; portrait_hide
	call_msg("TagMapNoerArena:firstTime/firstMatch22_1") ; portrait_hide
	call_msg("TagMapNoerArena:firstTime/firstMatch22_2") ; portrait_hide
	
	
	get_character(tmpSexBeastID).animation = get_character(tmpSexBeastID).animation_melee_touch_target(get_character(tmpEastColossusID))
	SndLib.sound_DressTear
	wait(25)
	get_character(tmpSexBeastID).moveto(get_character(tmpEastColossusID).x,get_character(tmpEastColossusID).y)
	npc_sex_service_main(get_character(tmpSexBeastID),get_character(tmpEastColossusID),"anal",1,0)
	call_msg("TagMapNoerArena:firstTime/firstMatch23") ; portrait_hide
	wait(60)
	call_msg("TagMapNoerArena:firstTime/firstMatch22_1") ; portrait_hide
	call_msg("TagMapNoerArena:firstTime/firstMatch23_1") ; portrait_hide
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		call_msg("TagMapNoerArena:firstTime/firstMatch24") ; portrait_hide
		SndLib.sys_StepChangeMap
		get_character(tmpG1ID).call_balloon(0)
		get_character(tmpG2ID).call_balloon(0)
		get_character(tmpTsID).call_balloon(28,-1)
		npc_sex_service_main(get_character(tmpSexBeastID),get_character(tmpEastColossusID),"anal",1,1)
		tmpGOtoX = get_character(tmpBiosID).summon_data[:PlayedPrevX]
		tmpGOtoY = get_character(tmpBiosID).summon_data[:PlayedPrevY]
		$game_player.moveto(tmpGOtoX,tmpGOtoY)
		$game_player.direction = 2
		$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:viewers]
			event[1].opacity =  0
			event[1].force_update = false
		}
		get_character(tmpCpID).opacity = 255
		get_character(tmpCpID).set_event_terrain_tag(3)
		get_character(tmpCpID).through = false
		get_character(tmpRpID).opacity = 0
		get_character(tmpRpID).moveto(tmpRpX,tmpRpY)
		SndLib.bgs_stop
		SndLib.bgs_play("AMBIENCE_Public_Hall_Chatter_01_loop_stereo",50,100,RPG::BGS.last.pos)
		SndLib.bgm_play("/D/Arena-Western INSIDE LOOP",65,105,RPG::BGM.last.pos)
		cam_center(0)
	chcg_background_color(0,0,0,255,-7)
	get_character(tmpBiosID).summon_data[:MatchEnd] = true
	get_character(tmpBiosID).summon_data[:PlayedOP] = true
	get_character(tmpBiosID).summon_data[:Winner] = "SexBeast"
	get_character(tmpBiosID).summon_data[:PtPayed] = 0
	$story_stats["RecQuestNoerArenaAmt"] = $game_date.dateAmt + 2
	call_msg("TagMapNoerArena:firstTime/firstMatch25")
	eventPlayEnd
	return
end

###################################################################################################### PLAYER MATCH
###################################################################################################### PLAYER MATCH
###################################################################################################### PLAYER MATCH
###################################################################################################### PLAYER MATCH
###################################################################################################### PLAYER MATCH
###################################################################################################### PLAYER MATCH
###################################################################################################### PLAYER MATCH
###################################################################################################### PLAYER MATCH
###################################################################################################### PLAYER MATCH
###################################################################################################### PLAYER MATCH
###################################################################################################### PLAYER MATCH
###################################################################################################### PLAYER MATCH
###################################################################################################### PLAYER MATCH
if tmpPlayerMatch == true
	cam_center(0)
	return
end


###################################################################################################### BET MATCH
###################################################################################################### BET MATCH
###################################################################################################### BET MATCH
###################################################################################################### BET MATCH
###################################################################################################### BET MATCH
###################################################################################################### BET MATCH
###################################################################################################### BET MATCH
###################################################################################################### BET MATCH
###################################################################################################### BET MATCH




portrait_hide
SndLib.sys_StepChangeMap
if !get_character(tmpBiosID).summon_data[:PlayedOP] && get_character(tmpBiosID).summon_data[:SpecEvent] == "CecilyShow_Gang" && get_character(tmpBiosID).summon_data[:SpecEventUnit]
	$story_stats["RecQuestNoerArenaAmt"] = $game_date.dateAmt + 2
	$story_stats["RecQuestNoerArenaList"] = 0
	$game_map.events.each{|event|
		next if !event[1].summon_data
		next if !event[1].summon_data[:viewers]
		event[1].opacity =  255
		event[1].force_update = true
	}
	SndLib.bgs_stop
	SndLib.bgm_stop
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpRpID).opacity = 255
		get_character(tmpRpID).moveto(tmpRpX,tmpRpY+2)
		cam_follow(tmpRpID,0)
		$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:viewers]
			event[1].opacity =  255
		}
		get_character(tmpCpID).opacity = 0
		get_character(tmpCpID).set_event_terrain_tag(0)
		get_character(tmpCpID).through = true
		get_character(tmpRpID).opacity = 255
		get_character(tmpRpID).drop_light
		if $game_date.night? && $story_stats["UniqueCharUniqueMilo"] != -1 && rand(100) > 60
			tmpMiloX,tmpMiloY,tmpMiloID = $game_map.get_storypoint("Milo")
			set_event_force_page(tmpMiloID,1)
		end
		EvLib.sum("ArenaCecilyRBQ",tmpCpX,tmpCpY)
		$story_stats["HiddenOPT0"] = $game_text["TagMapNoerArena:name/#{get_character(tmpBiosID).summon_data[:SpecEventUnit]}"]
		get_character(tmpG1ID).call_balloon(0)
		get_character(tmpG2ID).call_balloon(0)
		$game_map.shadows.set_color(0, 0, 0)
		$game_map.shadows.set_opacity(255)
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapNoerArena:CecilyShow_Gang/show_start_begin1")
	portrait_hide
	wait(5)
	portrait_off
	wait(60)
	SndLib.play_cursor(50)
	get_character(tmpRpID).give_light("red300_5")
	wait(30)
	SndLib.ppl_CheerGroup(100)
	wait(60)
	call_msg("TagMapNoerArena:CecilyShow_Gang/show_start_begin2")
	portrait_hide
	wait(5)
	EvLib.sum(get_character(tmpBiosID).summon_data[:SpecEventUnit],tmpFireTx,tmpFireTy-1) ####################
	EvLib.sum(get_character(tmpBiosID).summon_data[:SpecEventUnit],tmpFireBx,tmpFireBy+1) ####################
	EvLib.sum(get_character(tmpBiosID).summon_data[:SpecEventUnit],tmpFireLx-1,tmpFireLy) ####################
	EvLib.sum(get_character(tmpBiosID).summon_data[:SpecEventUnit],tmpFireRx+1,tmpFireRy) ####################
	cam_follow(tmpCpID,0)
	call_msg("TagMapNoerArena:CecilyShow_Gang/show_start_begin3") # show cecily
	portrait_hide
	wait(5)
	portrait_off
	get_character(tmpCpID).give_light("red300_5")
	SndLib.play_cursor(50)
	wait(70)
	SndLib.ppl_BooGroup(100)
	SndLib.ppl_BooGroup(100)
	SndLib.ppl_BooGroup(100)
	SndLib.ppl_BooGroup(100)
	wait(60)
	call_msg("TagMapNoerArena:CecilyShow_Gang/show_start_begin3_1") # show cecily
	portrait_hide
	wait(5)
	portrait_off
	get_character(tmpRpID).drop_light
	get_character(tmpCpID).drop_light
	$game_map.shadows.set_color(40, 90, 120)
	$game_map.shadows.set_opacity(200)
	SndLib.sound_FlameCast(100,70)
	call_msg("TagMapNoerArena:CecilyShow_Gang/show_start_begin4") # and she will facing.
	portrait_hide
	wait(5)
	portrait_off
	cam_follow(tmpFireTid,0)
	SndLib.ppl_CheerGroup(100)
	wait(60)
	cam_follow(tmpFireBid,0)
	SndLib.ppl_CheerGroup(100)
	wait(60)
	cam_follow(tmpFireLid,0)
	SndLib.ppl_CheerGroup(100)
	wait(60)
	cam_follow(tmpFireRid,0)
	SndLib.ppl_CheerGroup(100)
	wait(60)
	cam_follow(tmpCpID,0)
	wait(30)
	call_msg("TagMapNoerArena:CecilyShow_Gang/show_start_begin5") # let battle begin
	index = rand < 0.8 ? 0 : 1
	call_msg("TagMapNoerArena:CecilyShow_Gang/show_start_begin6_#{index}")
	SndLib.bgm_play("/D/Arena-Industrial Combat LAYER12",80,100,RPG::BGM.last.pos)
	SndLib.bgs_play("AMBIENCE_Public_Hall_Chatter_01_loop_stereo",40,100,RPG::BGS.last.pos)
	get_character(tmpBiosID).summon_data[:MatchEnd] = true
	get_character(tmpBiosID).summon_data[:PlayedOP] = true
	get_character(tmpBiosID).summon_data[:SndCheerNed] = 30
	set_event_force_page(tmpBiosID,7)
	get_character(tmpCpID).delete

	########################################################################################### PLAYING OP
elsif !get_character(tmpBiosID).summon_data[:PlayedOP] && tmpHowMuch >= 1
	$story_stats["RecQuestNoerArenaList"] = 0
	tmpFighterList = get_character(tmpBiosID).summon_data[:FighterPick]
	get_character(tmpBiosID).summon_data[:MatchEnd] = false
	get_character(tmpBiosID).summon_data[:PlayedOP] = true
	SndLib.bgs_stop
	SndLib.bgm_stop
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpRpID).opacity = 255
		get_character(tmpRpID).moveto(tmpRpX,tmpRpY+2)
		cam_follow(tmpRpID,0)
		$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:viewers]
			event[1].opacity =  255
		}
		get_character(tmpCpID).opacity = 255
		get_character(tmpCpID).set_event_terrain_tag(3)
		get_character(tmpCpID).through = false
		get_character(tmpRpID).opacity = 255
		posi = Array.new
		posi += $game_map.region_map[8]
		until posi.empty?
			tmpGoto = posi.shift
			EvLib.sum("Hp3WoodBarrier",tmpGoto[0],tmpGoto[1])
		end
	chcg_background_color(0,0,0,255,-7)
	
	SndLib.bgs_play("AMBIENCE_Public_Hall_Chatter_01_loop_stereo",40,100,RPG::BGS.last.pos)
	if $game_date.night? && $story_stats["UniqueCharUniqueMilo"] != -1 && rand(100) > 60
		tmpMiloX,tmpMiloY,tmpMiloID = $game_map.get_storypoint("Milo")
		set_event_force_page(tmpMiloID,1)
	end
	call_msg("TagMapNoerArena:NewMatch/begin1") ; portrait_hide
	tmpSummonTar = tmpFighterList.shift[0]
	EvLib.sum(tmpSummonTar,tmpFireTx,tmpFireTy+1)
	cam_follow(tmpFireTid,0)
	SndLib.ppl_CheerGroup(100)
	call_msg($game_text["TagMapNoerArena:name/#{tmpSummonTar}"])
	
	tmpSummonTar = tmpFighterList.shift[0]
	EvLib.sum(tmpSummonTar,tmpFireBx,tmpFireBy-1)
	cam_follow(tmpFireBid,0)
	SndLib.ppl_CheerGroup(100)
	call_msg($game_text["TagMapNoerArena:name/#{tmpSummonTar}"])
	
	tmpSummonTar = tmpFighterList.shift[0]
	EvLib.sum(tmpSummonTar,tmpFireLx+1,tmpFireLy)
	cam_follow(tmpFireLid,0)
	SndLib.ppl_CheerGroup(100)
	call_msg($game_text["TagMapNoerArena:name/#{tmpSummonTar}"])
	
	tmpSummonTar = tmpFighterList.shift[0]
	EvLib.sum(tmpSummonTar,tmpFireRx-1,tmpFireRy)
	cam_follow(tmpFireRid,0)
	SndLib.ppl_CheerGroup(100)
	call_msg($game_text["TagMapNoerArena:name/#{tmpSummonTar}"])
	call_msg("TagMapNoerArena:NewMatch/begin2") ; portrait_hide
	SndLib.ppl_CheerGroup(100)
	set_event_force_page(tmpBiosID,3)
end

SndLib.bgs_stop
portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	############################################## SETUP Ev
	get_character(tmpBiosID).summon_data[:PlayedPrevX] = $game_player.x
	get_character(tmpBiosID).summon_data[:PlayedPrevY] = $game_player.y
	$game_player.moveto(tmpPwX,tmpPwY+1)
	$game_player.direction = 2
	$hudForceHide = true
	$balloonForceHide = true
	$game_player.force_update = false
	$game_system.menu_disabled = true
	get_character(0).switch1_id = [0,0]
	get_character(0).switch2_id = 1
	get_character(0).call_balloon(0)
	tmpCurX,tmpCurY,tmpCurID=$game_map.get_storypoint("CannonCur")
	cam_follow(tmpCurID,0)
	get_character(tmpCurID).move_type = :control_this_event
	get_character(tmpCurID).set_manual_move_type(:control_this_event)
	set_this_event_force_page(4)
	
	
	get_character($game_player.get_followerID(-1)).follower[1] = 0 if !$game_player.get_followerID(-1).nil?
	get_character($game_player.get_followerID(0)).follower[1] = 0 if !$game_player.get_followerID(0).nil?
	get_character($game_player.get_followerID(1)).follower[1] = 0 if !$game_player.get_followerID(1).nil?
	
	#PickaNPC
	scanResult = nil
	scanCompareTar = nil
	tmpPick = $game_map.npcs.any?{|event|
	next unless event.summon_data
	next unless event.summon_data[:ArenaPlayer]
	next if event.npc.action_state == :death
	next if event.actor.battle_stat.get_stat("sta") < 1
	scanCompareTar = event.summon_data[:ArenaTeamID]
	}
	#scan and compare
	tmpCheck = $game_map.npcs.any?{|event|
	next unless event.summon_data
	next unless event.summon_data[:ArenaTeamID]
	next if event.npc.action_state == :death
	next if scanCompareTar == event.summon_data[:ArenaTeamID]
	scanResult = event.summon_data[:ArenaTeamID]
	}
	######################################################################################### Match still running
	if get_character(tmpBiosID).summon_data[:PlayedOP] == true && tmpHowMuch >= 1 && get_character(tmpBiosID).summon_data[:MatchEnd] == false
		SndLib.bgs_stop
		SndLib.bgm_play("/D/Arena-Industrial Combat LAYER12",80,100,RPG::BGM.last.pos)
		SndLib.bgs_play("AMBIENCE_Public_Hall_Chatter_01_loop_stereo",40,100,RPG::BGS.last.pos)
	else
		get_character(tmpRpID).opacity = 0
	end
	######################################################################################### SETUP Ev #Closed
	if scanResult.nil? || scanCompareTar.nil?
		$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:viewers]
			event[1].opacity =  0
		}
		get_character(tmpCpID).opacity = 0
		get_character(tmpCpID).set_event_terrain_tag(0)
		get_character(tmpCpID).through = true
		#posi = Array.new
		#posi += $game_map.region_map[8]
		#until posi.empty?
		#	tmpGoto = posi.shift
		#	$game_map.events_xy(tmpGoto[0],tmpGoto[1]).any?{|event|
		#		next if !event.npc?
		#		event.delete
		#	}
		#end
	end
	
	@hint_sprite = Sprite.new(@viewport)
	@hint_sprite.z = System_Settings::COMPANION_UI_Z
	@hint_sprite.bitmap= Bitmap.new(Graphics.width,Graphics.height)
	@hint_sprite.bitmap.font.outline = false
	@hint_sprite.x = 0
	@hint_sprite.y = 0
	tmpKey0L = InputUtils.getKeyAndTranslateLong(:S1)
	tmpKey1L = "-"
	tmpKey2L = "THROW"
	tmpKey0R = InputUtils.getKeyAndTranslateLong(:B)
	tmpKey1R = "-"
	tmpKey2R = "QUIT"
	@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_LARGE #30
	@hint_sprite.opacity = 255
	@hint_sprite.bitmap.draw_text(18, 5,320,40,tmpKey0L.upcase,0)
	@hint_sprite.bitmap.draw_text(18, 20,320,40,tmpKey1L,0)
	@hint_sprite.bitmap.draw_text(18, 39,320,40,tmpKey2L,0)
	@hint_sprite.bitmap.draw_text(307, 5,320,40,tmpKey0R.upcase,2)
	@hint_sprite.bitmap.draw_text(307, 20,320,40,tmpKey1R,2)
	@hint_sprite.bitmap.draw_text(307, 39,320,40,tmpKey2R,2)
	
	
	SndLib.bgs_stop
	SndLib.bgs_play("AMBIENCE_Public_Hall_Chatter_01_loop_stereo",20,100,RPG::BGS.last.pos)
chcg_background_color(0,0,0,255,-7)
