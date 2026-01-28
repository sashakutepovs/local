


 $game_map.interpreter.weather("snow", 5, "redDot",true)
 $game_map.shadows.set_color(120, 50, 40) if $game_date.day?
 $game_map.shadows.set_opacity(170)  if $game_date.day?
 $game_map.shadows.set_color(120, 50, 40) if $game_date.night?
 $game_map.shadows.set_opacity(210)  if $game_date.night?
 
	SndLib.bgs_play("forest_wind",80,100)
	SndLib.bgm_play("D/Surface Exploration LOOP",70,95)
map_background_color(150,40,200,40,0)
tmpGroupTopAction = nil
tmpMoveGroupWatchBot = false
tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
tmpMapContThrowID = $game_map.get_storypoint("MapContThrow")[2]
tmpDryCropseID = $game_map.get_storypoint("DryCropse")[2]
tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
tmpPTtop1X,tmpPTtop1Y,tmpPTtop1ID = $game_map.get_storypoint("PTtop1")
tmpPTtop2X,tmpPTtop2Y,tmpPTtop2ID = $game_map.get_storypoint("PTtop2")
tmpGob1X,tmpGob1Y,tmpGob1ID = $game_map.get_storypoint("GobTop1")
tmpGob2X,tmpGob2Y,tmpGob2ID = $game_map.get_storypoint("GobTop2")
tmpGob3X,tmpGob3Y,tmpGob3ID = $game_map.get_storypoint("GobTop3")
tmpGob4X,tmpGob4Y,tmpGob4ID = $game_map.get_storypoint("GobTop4")
tmpGob5X,tmpGob5Y,tmpGob5ID = $game_map.get_storypoint("GobTop5")
tmpBreedLingX,tmpBreedLingY,tmpBreedLingID = $game_map.get_storypoint("BreedLing")
tmpAbomZombie1X,tmpAbomZombie1Y,tmpAbomZombie1ID = $game_map.get_storypoint("AbomZombie1")
tmpAbomZombie2X,tmpAbomZombie2Y,tmpAbomZombie2ID = $game_map.get_storypoint("AbomZombie2")
tmpStartPointDX,tmpStartPointDY,tmpStartPointDID = $game_map.get_storypoint("StartPointD")
posiTOP=$game_map.region_map[14].clone
posiIn=$game_map.region_map[12].clone
posiBOT=$game_map.region_map[30].clone

if $story_stats["RapeLoop"] == 1
	get_character(tmpDualBiosID).summon_data[:DayJobSelect] = [
		"ZombieRape",
		"BreedLingRape",
		"AbomRape",
		"None",
		"None",
		"None"
	]
	get_character(tmpDualBiosID).summon_data[:NightJobSelect] = [
		"DryCropse",
		"ThrowRock",
		"None",
	]
	if get_character(tmpDualBiosID).summon_data[:RapeLoopJobDid] == true && !get_character(tmpDualBiosID).summon_data[:FirstTime]
		call_msg("TagMapNFL_OrkCamp2:NFL_OrkCamp2/Rapeloop_FoodOffer")
		EvLib.sum("ItemHumanoidFlesh",tmpWakeUpX,tmpWakeUpY)
		EvLib.sum("ItemMutantFlesh",tmpWakeUpX,tmpWakeUpY)
		EvLib.sum("ItemHumanFlesh",tmpWakeUpX,tmpWakeUpY)
	end
	get_character(tmpDualBiosID).summon_data[:FirstTime] = false
	get_character(tmpDualBiosID).summon_data[:RapeLoopJobDid] = false
	if $game_date.night?
		get_character(tmpDualBiosID).summon_data[:JobSelect] = get_character(tmpDualBiosID).summon_data[:NightJobSelect].sample
	elsif $game_date.day?
		get_character(tmpDualBiosID).summon_data[:JobSelect] = get_character(tmpDualBiosID).summon_data[:DayJobSelect].sample
	end
	#get_character(tmpDualBiosID).summon_data[:JobSelect] =  "ThrowRock" ######################################################################################3 TESTTTTTTTTTTTTTTTTTT
	case get_character(tmpDualBiosID).summon_data[:JobSelect]
		when "None"
			call_msg("TagMapNFL_OrkCamp2:NFL_OrkCamp2/Rapeloop_None_WakeBegin")
			get_character(tmpDualBiosID).summon_data[:RapeLoopJobDid] = true
			get_character(tmpGob1ID).moveto(tmpPTtop2X,tmpPTtop2Y)
			get_character(tmpGob1ID).move_type = 16
			get_character(tmpGob1ID).set_manual_move_type(16)
			
			get_character(tmpGob2ID).moveto(tmpStartPointDX,tmpStartPointDY)
			get_character(tmpGob2ID).move_type = 16
			get_character(tmpGob2ID).set_manual_move_type(16)
			
			get_character(tmpGob3ID).moveto(tmpGob3X-1,tmpGob3Y-2)
			get_character(tmpGob3ID).direction = 8
			get_character(tmpGob3ID).move_type = 0
			get_character(tmpGob3ID).set_manual_move_type(0)
			get_character(tmpGob3ID).animation = get_character(tmpGob3ID).animation_sleep(8)
			
			get_character(tmpGob4ID).moveto(tmpGob4X,tmpGob4Y+1)
			get_character(tmpGob4ID).direction = 2
			get_character(tmpGob4ID).move_type = 0
			get_character(tmpGob4ID).set_manual_move_type(0)
			get_character(tmpGob4ID).animation = get_character(tmpGob4ID).animation_sleep(6)
			
			get_character(tmpGob5ID).moveto(tmpGob5X+1,tmpGob5Y+1)
			get_character(tmpGob5ID).direction = 6
			get_character(tmpGob5ID).move_type = 0
			get_character(tmpGob5ID).set_manual_move_type(0)
			get_character(tmpGob5ID).animation = get_character(tmpGob5ID).animation_sleep(2)
		when "AbomRape"
			tmpPosi = $game_map.region_map[12].clone
			tmpPosi.delete([tmpWakeUpX,tmpWakeUpY])
			posi = tmpPosi.sample
			tmpPosi.delete(posi)
			get_character(tmpAbomZombie1ID).moveto(posi[0],posi[1])
			get_character(tmpAbomZombie1ID).turn_toward_character(get_character(tmpWakeUpID))
			posi = tmpPosi.sample
			tmpPosi.delete(posi)
			get_character(tmpAbomZombie2ID).moveto(posi[0],posi[1])
			get_character(tmpAbomZombie2ID).turn_toward_character(get_character(tmpWakeUpID))
			posi = tmpPosi.sample
			tmpPosi.delete(posi)
			get_character(tmpBreedLingID).moveto(posi[0],posi[1])
			get_character(tmpBreedLingID).turn_toward_character(get_character(tmpWakeUpID))
			call_msg("TagMapNFL_OrkCamp2:NFL_OrkCamp2/Rapeloop_DryCropse_WakeBegin")
			get_character(tmpDualBiosID).summon_data[:RapeLoopJobDid] = true
		when "ZombieRape"
			tmpPosi = $game_map.region_map[12].clone
			tmpPosi.delete([tmpWakeUpX,tmpWakeUpY])
			posi = tmpPosi.sample
			tmpPosi.delete(posi)
			get_character(tmpAbomZombie1ID).moveto(posi[0],posi[1])
			get_character(tmpAbomZombie1ID).turn_toward_character(get_character(tmpWakeUpID))
			posi = tmpPosi.sample
			tmpPosi.delete(posi)
			get_character(tmpAbomZombie2ID).moveto(posi[0],posi[1])
			get_character(tmpAbomZombie2ID).turn_toward_character(get_character(tmpWakeUpID))
			call_msg("TagMapNFL_OrkCamp2:NFL_OrkCamp2/Rapeloop_DryCropse_WakeBegin")
			get_character(tmpDualBiosID).summon_data[:RapeLoopJobDid] = true
		when "BreedLingRape"
			tmpPosi = $game_map.region_map[12].clone
			tmpPosi.delete([tmpWakeUpX,tmpWakeUpY])
			posi = tmpPosi.sample
			tmpPosi.delete(posi)
			get_character(tmpBreedLingID).moveto(posi[0],posi[1])
			get_character(tmpBreedLingID).turn_toward_character(get_character(tmpWakeUpID))
			call_msg("TagMapNFL_OrkCamp2:NFL_OrkCamp2/Rapeloop_DryCropse_WakeBegin")
			get_character(tmpDualBiosID).summon_data[:RapeLoopJobDid] = true
			call_msg("AbomRape")
		when "ThrowRock"
		when "DryCropse"
			tmpGroupTopAction = "WatchTop"
			call_msg("TagMapNFL_OrkCamp2:NFL_OrkCamp2/Rapeloop_DryCropse_WakeBegin")
			get_character(tmpDryCropseID).moveto(tmpWakeUpX-1,tmpWakeUpY+1)
			get_character(tmpDryCropseID).animation = get_character(tmpDryCropseID).aniCustom(get_character(tmpDryCropseID).summon_data[:aniData],-1)
	end
	case tmpGroupTopAction
		when "WatchTop"
			$game_map.npcs.each{|event|
				next unless event.summon_data
				next unless event.summon_data[:GroupTop]
				next unless [nil,:none].include?(event.npc.action_state)
				#posi = posiTOP.sample
				#posiTOP.delete(posi)
				#event.moveto(posi[0],posi[1])
				event.animation = nil
			}
			
	end
end
fadeout=$story_stats["ReRollHalfEvents"] == 1
enter_static_tag_map(nil,fadeout)
summon_companion


if $story_stats["RapeLoop"] == 1
	if ["ZombieRape","BreedLingRape","AbomRape","DryCropse","ThrowRock"].include?(get_character(tmpDualBiosID).summon_data[:JobSelect])
			$game_map.npcs.each{|event|
				next unless event.summon_data
				next unless event.summon_data[:GroupTop]
				event.npc_story_mode(true)
				event.move_type = 0
				event.animation = nil
			}
			tarNpcs = $game_map.npcs.select{|event|
				next unless event.summon_data
				next unless event.summon_data[:GroupTop]
				true
			}
			portrait_hide
			tmpTarNpc = tarNpcs.sample
			tarNpcs.delete(tmpTarNpc)
			tmpTarNpc.jump_to(tmpTarNpc.x,tmpTarNpc.y)
			SndLib.sound_goblin_roar
			tmpTarNpc.call_balloon(20)
			$game_portraits.setRprt("goblin")
			$game_portraits.rprt.shake
			wait(60)
			
			portrait_hide
			tmpTarNpc = tarNpcs.sample
			tarNpcs.delete(tmpTarNpc)
			tmpTarNpc.jump_to(tmpTarNpc.x,tmpTarNpc.y)
			SndLib.sound_goblin_roar
			tmpTarNpc.call_balloon(20)
			$game_portraits.setLprt("goblin")
			$game_portraits.lprt.shake
			wait(60)
			
			portrait_hide
			tmpTarNpc = tarNpcs.sample
			tarNpcs.delete(tmpTarNpc)
			tmpTarNpc.jump_to(tmpTarNpc.x,tmpTarNpc.y)
			SndLib.sound_goblin_roar
			tmpTarNpc.call_balloon(20)
			$game_portraits.setRprt("goblin")
			$game_portraits.rprt.shake
			wait(60)
	end
	case get_character(tmpDualBiosID).summon_data[:JobSelect]
		when "ZombieRape","BreedLingRape","AbomRape"
			portrait_hide
			call_msg("TagMapNFL_OrkCamp2:NFL_OrkCamp2/DailyJob_select_Abom")
		when "DryCropse"
			portrait_hide
			call_msg("TagMapNFL_OrkCamp2:NFL_OrkCamp2/DailyJob_select_DryCropse")
		when "ThrowRock"
			portrait_hide
			$game_map.npcs.each{|event|
				next unless event.summon_data
				next unless event.summon_data[:GroupTop]
				next unless [nil,:none].include?(event.npc.action_state)
				event.summon_data[:ThrowMode] = true
				event.summon_data[:throwWait] = 100+rand(100)
			}
			set_event_force_page(tmpMapContThrowID,4)
			call_msg("TagMapNFL_OrkCamp2:NFL_OrkCamp2/DailyJob_select_ThrowRock")
	end
	
	get_character(tmpDryCropseID).call_balloon(28,-1)
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:GroupTop]
		next unless [nil,:none].include?(event.npc.action_state)
		event.npc_story_mode(false)
		event.move_type = 3
	}
end



$story_stats["ReRollHalfEvents"] = 0
$story_stats["OnRegionMapSpawnRace"] =  "AbomManager"
$story_stats["LimitedNapSkill"] = 1
eventPlayEnd