if $story_stats["RecQuest_Df_TellerSide"] >= 3
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:Heretic] || event.summon_data[:OBJ]
		event.delete
	}
	return
end
#################################################################################	通商寬衣 初次進場RAPELOOP
tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
tmpOfferingX,tmpOfferingY,tmpOfferingID = $game_map.get_storypoint("Offering")
if $story_stats["Captured"] == 1 && get_character(tmpDualBiosID).summon_data[:BeginRaped] == false
	tmpPigManX,tmpPigManY,tmpPigManID = $game_map.get_storypoint("PigMan")
	tmpPPL4ID = $game_map.get_storypoint("PPL4")[2]
	tmpPPL5ID = $game_map.get_storypoint("PPL5")[2]
	tmpPPL6ID = $game_map.get_storypoint("PPL6")[2]
	tmpPPL7ID = $game_map.get_storypoint("PPL7")[2]
	get_character(tmpOfferingID).delete
	get_character(tmpPPL4ID).animation = nil
	get_character(tmpPPL5ID).animation = nil
	get_character(tmpPPL6ID).animation = nil
	get_character(tmpPPL7ID).animation = nil
	get_character(tmpPPL4ID).move_type = 0
	get_character(tmpPPL5ID).move_type = 0
	get_character(tmpPPL6ID).move_type = 0
	get_character(tmpPPL7ID).move_type = 0
	get_character(tmpPPL4ID).moveto(tmpOfferingX-1,tmpOfferingY+1)
	get_character(tmpPPL5ID).moveto(tmpOfferingX+1,tmpOfferingY+1)
	get_character(tmpPPL6ID).moveto(tmpOfferingX-1,tmpOfferingY+2)
	get_character(tmpPPL7ID).moveto(tmpOfferingX+1,tmpOfferingY+2)
	get_character(tmpPPL4ID).direction = 8
	get_character(tmpPPL5ID).direction = 8
	get_character(tmpPPL6ID).direction = 8
	get_character(tmpPPL7ID).direction = 8
	get_character(tmpPPL4ID).npc_story_mode(true)
	get_character(tmpPPL5ID).npc_story_mode(true)
	get_character(tmpPPL6ID).npc_story_mode(true)
	get_character(tmpPPL7ID).npc_story_mode(true)
	$game_player.direction = 8
	$game_player.moveto(tmpOfferingX,tmpOfferingY)
	$game_player.animation = $game_player.aniCustom([[10, 3, 4, 1, 7-16], [10, 3, 2, 1, 8-16], [10, 3, 6, 2, 8-16], [10, 3, 2, 1, 7-16]],-1)
	#get_character(tmpPigManID).animation = nil
	call_msg("TagMapDfWaterCave:RapeLoop/FirstTime1")
	portrait_hide
	chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapDfWaterCave:RapeLoop/FirstTime2")
		$game_player.actor.stat["EventMouthRace"] = "Human"
		load_script("Data/HCGframes/UniqueEvent_DeepThroat.rb")
		get_character(tmpPigManID).move_type = 0
		get_character(tmpPigManID).animation = nil
		whole_event_end
		$game_player.animation = nil
		call_msg("TagMapDfWaterCave:RapeLoop/FirstTime3")
		################################################################ 右下的7號給LONA喝精華
		call_msg("TagMapDfWaterCave:RapeLoop/FirstTime3_1") ;portrait_hide
		$game_player.direction = 2
		get_character(tmpPPL4ID).move_type = 0
		get_character(tmpPPL5ID).move_type = 0
		get_character(tmpPPL6ID).move_type = 0
		get_character(tmpPPL7ID).move_type = 0
		get_character(tmpPPL4ID).animation = nil
		get_character(tmpPPL5ID).animation = nil
		get_character(tmpPPL6ID).animation = nil
		get_character(tmpPPL7ID).animation = nil
		get_character(tmpPPL4ID).direction = 6
		get_character(tmpPPL5ID).direction = 4
		get_character(tmpPPL6ID).direction = 6
		get_character(tmpPPL7ID).direction = 4
		get_character(tmpPPL7ID).move_type = 0
		get_character(tmpPPL7ID).direction = 4 ; get_character(tmpPPL7ID).move_forward_force ; wait(60)
		get_character(tmpPPL7ID).direction = 6 ; wait(30)
		get_character(tmpPPL7ID).direction = 2 ; get_character(tmpPPL7ID).animation = get_character(tmpPPL7ID).animation_atk_mh
		SndLib.sound_equip_armor(100)
		wait(60)
		get_character(tmpPPL7ID).direction = 8 ; get_character(tmpPPL7ID).move_forward_force ; wait(60)
		get_character(tmpPPL7ID).animation = get_character(tmpPPL7ID).animation_atk_mh
		SndLib.sound_equip_armor(100)
		$game_player.animation = $game_player.aniCustom([[2,4,0,0,6]],-1)
		$game_map.popup(0,"1",$data_items[34].icon_index,1)
		wait(60)
		get_character(tmpPPL7ID).direction = 2 ; get_character(tmpPPL7ID).move_forward_force ; wait(60)
		get_character(tmpPPL7ID).direction = 6 ; get_character(tmpPPL7ID).move_forward_force ; wait(60)
		get_character(tmpPPL7ID).direction = 4
		call_msg("TagMapDfWaterCave:RapeLoop/FirstTime3_2") ;portrait_hide
		$game_map.popup(0,"1",$data_items[34].icon_index,-1)
		SndLib.sys_UseItem
		$game_player.animation = nil
		wait(50)
		$game_player.call_balloon(8)
		wait(60)
		call_msg("TagMapDfWaterCave:RapeLoop/FirstTime4")
		call_msg("TagMapDfWaterCave:RapeLoop/FirstTime4_1")
		call_msg("TagMapDfWaterCave:RapeLoop/FirstTime5") ; portrait_hide
		$game_player.move_speed = 3 ; $game_player.move_forward_force ; wait(60)
		get_character(tmpPPL7ID).direction = 4 ; get_character(tmpPPL7ID).move_forward_force
		get_character(tmpPPL4ID).direction = 8 ; get_character(tmpPPL4ID).move_forward_force
		get_character(tmpPPL6ID).direction = 8 ; get_character(tmpPPL6ID).move_forward_force
		wait(60)
		get_character(tmpPPL4ID).direction = 6 ; get_character(tmpPPL4ID).move_forward_force
		wait(60)
		get_character(tmpPPL4ID).turn_toward_character($game_player)
		get_character(tmpPPL5ID).turn_toward_character($game_player)
		get_character(tmpPPL6ID).turn_toward_character($game_player)
		get_character(tmpPPL7ID).turn_toward_character($game_player)
		get_character(tmpPPL4ID).animation = get_character(tmpPPL4ID).animation_masturbation
		get_character(tmpPPL5ID).animation = get_character(tmpPPL5ID).animation_masturbation
		get_character(tmpPPL6ID).animation = get_character(tmpPPL6ID).animation_masturbation
		get_character(tmpPPL7ID).animation = get_character(tmpPPL7ID).animation_masturbation
		call_msg("TagMapDfWaterCave:RapeLoop/FirstTime4_1")
		portrait_hide
	portrait_off
	get_character(tmpPPL4ID).actor.npc.sex_taste["sex_fetish_appetizer"] = ["none"]
	get_character(tmpPPL5ID).actor.npc.sex_taste["sex_fetish_appetizer"] = ["none"]
	get_character(tmpPPL6ID).actor.npc.sex_taste["sex_fetish_appetizer"] = ["none"]
	get_character(tmpPPL7ID).actor.npc.sex_taste["sex_fetish_appetizer"] = ["none"]
	get_character(tmpPPL4ID).actor.npc.sex_taste["sex_fetish_ending"] = ["none"]
	get_character(tmpPPL5ID).actor.npc.sex_taste["sex_fetish_ending"] = ["none"]
	get_character(tmpPPL6ID).actor.npc.sex_taste["sex_fetish_ending"] = ["none"]
	get_character(tmpPPL7ID).actor.npc.sex_taste["sex_fetish_ending"] = ["none"]
	get_character(tmpPPL4ID).animation = nil
	get_character(tmpPPL5ID).animation = nil
	get_character(tmpPPL6ID).animation = nil
	get_character(tmpPPL7ID).animation = nil
	get_character(tmpPPL4ID).npc_story_mode(false)
	get_character(tmpPPL5ID).npc_story_mode(false)
	get_character(tmpPPL6ID).npc_story_mode(false)
	get_character(tmpPPL7ID).npc_story_mode(false)
	get_character(tmpPigManID).moveto(tmpPigManX,tmpPigManY)
	get_character(tmpOfferingID).moveto(tmpOfferingX,tmpOfferingY)
	get_character(tmpPigManID).move_type = 3
	get_character(tmpOfferingID).move_type = 3
	get_character(tmpPPL4ID).move_type = 0
	get_character(tmpPPL5ID).move_type = 0
	get_character(tmpPPL6ID).move_type = 0
	get_character(tmpPPL7ID).move_type = 0
	get_character(tmpPPL4ID).set_manual_move_type(0)
	get_character(tmpPPL5ID).set_manual_move_type(0)
	get_character(tmpPPL6ID).set_manual_move_type(0)
	get_character(tmpPPL7ID).set_manual_move_type(0)
	get_character(tmpPPL4ID).npc.fucker_condition={"sex"=>[0, "="]}
	get_character(tmpPPL5ID).npc.fucker_condition={"sex"=>[0, "="]}
	get_character(tmpPPL6ID).npc.fucker_condition={"sex"=>[0, "="]}
	get_character(tmpPPL7ID).npc.fucker_condition={"sex"=>[0, "="]}
	get_character(tmpPPL4ID).npc.sense_target(get_character(tmpPPL4ID),0)
	get_character(tmpPPL5ID).npc.sense_target(get_character(tmpPPL5ID),0)
	get_character(tmpPPL6ID).npc.sense_target(get_character(tmpPPL6ID),0)
	get_character(tmpPPL7ID).npc.sense_target(get_character(tmpPPL7ID),0)
	get_character(tmpDualBiosID).summon_data[:BeginRaped] = true
	get_character(tmpDualBiosID).summon_data[:GangRaped] = true
	get_character(tmpDualBiosID).summon_data[:SexWithSomeOne] = true

############################################################################################################ Gameover
elsif $story_stats["Captured"] == 1 && get_character(tmpDualBiosID).summon_data[:BeginRaped] == true && $story_stats["RapeLoopTorture"] == 1
	tmpPigManX,tmpPigManY,tmpPigManID = $game_map.get_storypoint("PigMan")
	tmpOfferingX,tmpOfferingY,tmpOfferingID = $game_map.get_storypoint("Offering")
	tmpCapturedPointX,tmpCapturedPointY,tmpCapturedPointID = $game_map.get_storypoint("CapturedPoint")
	tmpGpt6X,tmpGpt6Y,tmpGpt6ID = $game_map.get_storypoint("Gpt6")
	tmpPOTX,tmpPOTY,tmpPOTID = $game_map.get_storypoint("POT")
	tmpDedLonaID = $game_map.get_storypoint("DedLona")[2]
	tmpPPL1ID = $game_map.get_storypoint("PPL1")[2]
	tmpPPL2ID = $game_map.get_storypoint("PPL2")[2]
	tmpPPL3ID = $game_map.get_storypoint("PPL3")[2]
	tmpPPL4ID = $game_map.get_storypoint("PPL4")[2]
	tmpPPL5ID = $game_map.get_storypoint("PPL5")[2]
	tmpPPL6ID = $game_map.get_storypoint("PPL6")[2]
	tmpPPL7ID = $game_map.get_storypoint("PPL7")[2]
	get_character(tmpPPL1ID).moveto(tmpPOTX-1,tmpPOTY-1)
	get_character(tmpPPL2ID).moveto(tmpPOTX,tmpPOTY-1)
	get_character(tmpPPL3ID).moveto(tmpPOTX+1,tmpPOTY-1)
	get_character(tmpPPL4ID).moveto(tmpPOTX-1,tmpPOTY-2)
	get_character(tmpPPL5ID).moveto(tmpPOTX,tmpPOTY-2)
	get_character(tmpPPL6ID).moveto(tmpPOTX+1,tmpPOTY-2)
	get_character(tmpPPL7ID).moveto(tmpPOTX,tmpPOTY-3)
	get_character(tmpPPL1ID).move_type = 0
	get_character(tmpPPL2ID).move_type = 0
	get_character(tmpPPL3ID).move_type = 0
	get_character(tmpPPL4ID).move_type = 0
	get_character(tmpPPL5ID).move_type = 0
	get_character(tmpPPL6ID).move_type = 0
	get_character(tmpPPL7ID).move_type = 0
	get_character(tmpPPL1ID).direction = 2
	get_character(tmpPPL2ID).direction = 2
	get_character(tmpPPL3ID).direction = 2
	get_character(tmpPPL4ID).direction = 2
	get_character(tmpPPL5ID).direction = 2
	get_character(tmpPPL6ID).direction = 2
	get_character(tmpPPL7ID).direction = 2
	get_character(tmpPPL1ID).animation = nil
	get_character(tmpPPL2ID).animation = nil
	get_character(tmpPPL3ID).animation = nil
	get_character(tmpPPL4ID).animation = nil
	get_character(tmpPPL5ID).animation = nil
	get_character(tmpPPL6ID).animation = nil
	get_character(tmpPPL7ID).animation = nil
	get_character(tmpOfferingID).delete
	get_character(tmpPigManID).animation = nil
	get_character(tmpPigManID).move_type = 0
	get_character(tmpPigManID).moveto(tmpGpt6X,tmpGpt6Y)
	get_character(tmpPigManID).direction = 8
	get_character(tmpDedLonaID).opacity = 255
	cam_follow(tmpPOTID,0)
	$game_player.opacity = 0
	get_character(tmpDedLonaID).moveto(tmpCapturedPointX,tmpCapturedPointY)
	get_character(tmpDedLonaID).npc_story_mode(true)
	portrait_hide
	call_msg("TagMapDfWaterCave:GameOver/0") ; portrait_hide
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapDfWaterCave:GameOver/1") ; portrait_hide
	until get_character(tmpDedLonaID).forced_y >= 0
		get_character(tmpDedLonaID).forced_y += 1
		SndLib.sound_step_chain(rand(20)+30,rand(20)+80) 
		wait(4)
	end
	chcg_background_color(0,0,0,0,7)
	$cg = TempCG.new(["event_CannibalPot"])
	call_msg("TagMapDfWaterCave:GameOver/2") ; portrait_hide
	8.times{
		$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
		SndLib.sound_AcidBurnLong
		SndLib.sound_Bubble
		wait(20+rand(20))
	}
	$cg.erase
	call_msg("TagMapDfWaterCave:GameOver/3")
	return load_script("Data/HCGframes/OverEvent_Death.rb")

############################################################################################################ Normal Day
elsif $story_stats["Captured"] == 1 && get_character(tmpDualBiosID).summon_data[:BeginRaped] == true && get_character(tmpDualBiosID).summon_data[:GangRaped] == true
	get_character(tmpDualBiosID).summon_data[:GangRaped] = false
	get_character(tmpDualBiosID).summon_data[:SexWithSomeOne] = false
	get_character(tmpOfferingID).delete
	$game_player.direction = 8
	$game_player.moveto(tmpOfferingX,tmpOfferingY)
	$game_player.animation = $game_player.aniCustom([[10, 3, 4, 1, 7-16], [10, 3, 2, 1, 8-16], [10, 3, 6, 2, 8-16], [10, 3, 2, 1, 7-16]],-1)
	call_msg("TagMapDfWaterCave:wakeUp/suckDick-0")
	chcg_background_color(0,0,0,255,-7)
	load_script("Data/HCGframes/event/DfWaterCave_SuckDickPigMan.rb")
	$game_player.animation = nil
	call_msg("TagMapDfWaterCave:wakeUp/suckDick2") ; portrait_hide
	$game_player.move_speed = 3 ; $game_player.direction = 2 ;$game_player.move_forward_force ; wait(60)
	call_msg("TagMapDfWaterCave:wakeUp/suckDick3")
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:Heretic]
		next unless event.summon_data[:NeedSex] == false
		next if event.deleted?
		next if event.npc.action_state == :death
		next unless event.npc.sex == 1
		event.summon_data[:NeedSex] = true
		event.npc.fucker_condition={"sex"=>[65535, "="]}
		event.call_balloon(19,-1)
	}
	
############################################################################################################ rapeloop until no sta
elsif $story_stats["Captured"] == 1 && get_character(tmpDualBiosID).summon_data[:BeginRaped] == true && get_character(tmpDualBiosID).summon_data[:GangRaped] == false
	get_character(tmpDualBiosID).summon_data[:GangRaped] = true
	get_character(tmpDualBiosID).summon_data[:SexWithSomeOne] = true
	get_character(tmpOfferingID).delete
	tmpBreakOrGang = [true,false].sample #GANG RAPE OR BREAK
	if tmpBreakOrGang
		tmpPPL1ID = $game_map.get_storypoint("PPL1")[2]
		tmpPPL6ID = $game_map.get_storypoint("PPL6")[2]
		tmpPPL7ID = $game_map.get_storypoint("PPL7")[2]
		get_character(tmpPPL1ID).animation = nil
		get_character(tmpPPL6ID).animation = nil
		get_character(tmpPPL7ID).animation = nil
		get_character(tmpPPL1ID).move_type = 0
		get_character(tmpPPL6ID).move_type = 0
		get_character(tmpPPL7ID).move_type = 0
		get_character(tmpPPL1ID).set_manual_move_type(0)
		get_character(tmpPPL6ID).set_manual_move_type(0)
		get_character(tmpPPL7ID).set_manual_move_type(0)
		get_character(tmpPPL1ID).moveto(tmpOfferingX-1,tmpOfferingY+1)
		get_character(tmpPPL6ID).moveto(tmpOfferingX,tmpOfferingY+2)
		get_character(tmpPPL7ID).moveto(tmpOfferingX+1,tmpOfferingY+1)
		get_character(tmpPPL1ID).direction = 8
		get_character(tmpPPL6ID).direction = 8
		get_character(tmpPPL7ID).direction = 8
		get_character(tmpPPL1ID).npc_story_mode(true)
		get_character(tmpPPL6ID).npc_story_mode(true)
		get_character(tmpPPL7ID).npc_story_mode(true)
		get_character(tmpPPL1ID).animation = get_character(tmpPPL1ID).animation_masturbation
		get_character(tmpPPL6ID).animation = get_character(tmpPPL6ID).animation_masturbation
		get_character(tmpPPL7ID).animation = get_character(tmpPPL7ID).animation_masturbation
		get_character(tmpPPL1ID).actor.npc.sex_taste["sex_fetish_appetizer"] = ["none"]
		get_character(tmpPPL6ID).actor.npc.sex_taste["sex_fetish_appetizer"] = ["none"]
		get_character(tmpPPL7ID).actor.npc.sex_taste["sex_fetish_appetizer"] = ["none"]
		get_character(tmpPPL1ID).actor.npc.sex_taste["sex_fetish_ending"] = ["none"]
		get_character(tmpPPL6ID).actor.npc.sex_taste["sex_fetish_ending"] = ["none"]
		get_character(tmpPPL7ID).actor.npc.sex_taste["sex_fetish_ending"] = ["none"]
		get_character(tmpPPL1ID).npc.fucker_condition={"sex"=>[0, "="]}
		get_character(tmpPPL6ID).npc.fucker_condition={"sex"=>[0, "="]}
		get_character(tmpPPL7ID).npc.fucker_condition={"sex"=>[0, "="]}
	end
	$game_player.direction = 8
	$game_player.moveto(tmpOfferingX,tmpOfferingY)
	$game_player.animation = $game_player.aniCustom([[10, 3, 4, 1, 7-16], [10, 3, 2, 1, 8-16], [10, 3, 6, 2, 8-16], [10, 3, 2, 1, 7-16]],-1)
	call_msg("TagMapDfWaterCave:wakeUp/suckDick-0")
	chcg_background_color(0,0,0,255,-7)
	load_script("Data/HCGframes/event/DfWaterCave_SuckDickPigMan.rb")
	$game_player.animation = nil
	############################### ############################### GanGRape
	if tmpBreakOrGang
		call_msg("TagMapDfWaterCave:wakeUp/GangRape0") ; portrait_hide
		$game_player.move_speed = 3 ; $game_player.direction = 2 ;$game_player.move_forward_force ; wait(60)
		get_character(tmpPPL1ID).turn_toward_character($game_player)
		get_character(tmpPPL6ID).turn_toward_character($game_player)
		get_character(tmpPPL7ID).turn_toward_character($game_player)
		get_character(tmpPPL1ID).animation = get_character(tmpPPL1ID).animation_masturbation
		get_character(tmpPPL6ID).animation = get_character(tmpPPL6ID).animation_masturbation
		get_character(tmpPPL7ID).animation = get_character(tmpPPL7ID).animation_masturbation
		$game_player.animation = $game_player.animation_masturbation
		call_msg("TagMapDfWaterCave:wakeUp/GangRape1")
		get_character(tmpPPL1ID).npc_story_mode(false)
		get_character(tmpPPL6ID).npc_story_mode(false)
		get_character(tmpPPL7ID).npc_story_mode(false)
		get_character(tmpPPL1ID).npc.sense_target(get_character(tmpPPL1ID),0)
		get_character(tmpPPL6ID).npc.sense_target(get_character(tmpPPL6ID),0)
		get_character(tmpPPL7ID).npc.sense_target(get_character(tmpPPL7ID),0)
	else ############################### ############################### break
		call_msg("TagMapDfWaterCave:wakeUp/Break0") ; portrait_hide
		$game_player.move_speed = 3 ; $game_player.direction = 2 ;$game_player.move_forward_force ; wait(60)
		call_msg("TagMapDfWaterCave:wakeUp/Break1")
	end
else
#None
end
