
$game_switches.data_common_event[:default] = false #turn off all GMI and HOM update
$game_switches.data_common_event[:AutoCommon] = false
	map_background_color(0,0,0,255,0)
	
	tmpDataSavEvID = $game_map.get_storypoint("DualBios")[2]
	
	get_character(tmpDataSavEvID).summon_data[:slot_RosterCurrent]       = $game_player.slot_RosterCurrent
	get_character(tmpDataSavEvID).summon_data[:slot_RosterArray]         = $game_player.slot_RosterArray
	get_character(tmpDataSavEvID).summon_data[:slot_skill_normal]        = $game_player.slot_skill_normal
	get_character(tmpDataSavEvID).summon_data[:slot_skill_heavy]         = $game_player.slot_skill_heavy
	get_character(tmpDataSavEvID).summon_data[:slot_skill_control]       = $game_player.slot_skill_control
	get_character(tmpDataSavEvID).summon_data[:slot_hotkey_0]            = $game_player.slot_hotkey_0
	get_character(tmpDataSavEvID).summon_data[:slot_hotkey_1]            = $game_player.slot_hotkey_1
	get_character(tmpDataSavEvID).summon_data[:slot_hotkey_2]            = $game_player.slot_hotkey_2
	get_character(tmpDataSavEvID).summon_data[:slot_hotkey_3]            = $game_player.slot_hotkey_3
	get_character(tmpDataSavEvID).summon_data[:slot_hotkey_4]            = $game_player.slot_hotkey_4
	get_character(tmpDataSavEvID).summon_data[:slot_hotkey_other]        = $game_player.slot_hotkey_other
	
	
	
	
	
	
	$game_player.setup_SkillRoster(tmpRoster=4,nil,:slot_skill_normal)
	$game_player.setup_SkillRoster(tmpRoster=4,nil,:slot_skill_heavy)
	$game_player.setup_SkillRoster(tmpRoster=4,nil,:slot_skill_control)
	$game_player.setup_SkillRoster(tmpRoster=4,nil,:slot_hotkey_0)
	$game_player.setup_SkillRoster(tmpRoster=4,nil,:slot_hotkey_1)
	$game_player.setup_SkillRoster(tmpRoster=4,nil,:slot_hotkey_2)
	$game_player.setup_SkillRoster(tmpRoster=4,nil,:slot_hotkey_3)
	$game_player.setup_SkillRoster(tmpRoster=4,nil,:slot_hotkey_4)
	$game_player.setup_SkillRoster(tmpRoster=4,nil,:slot_hotkey_other)
	$story_stats["dialog_wet"]=0
	$story_stats["dialog_sta"]=0
	$story_stats["dialog_sat"] =0
	$story_stats["dialog_cumflation"] =0
	$story_stats["dialog_cuff"] =0
	$story_stats["dialog_collar"] =0
	$story_stats["dialog_dress_out"] =0
	$story_stats["dialog_defecate"] =0
	$story_stats["dialog_urinary"] =0
	$story_stats["dialog_defecated"] =0
	$story_stats["dialog_overweight"] =0
	$story_stats["dialog_lactation"] =0
	$story_stats["dialog_sick"] =0
	$story_stats["dialog_drug_addiction"] =0
	$story_stats["dialog_moon_worm_hit"] =0
	$story_stats["dialog_pot_worm_hit"] =0
	$story_stats["dialog_HookWorm_hit"]		=1
	$story_stats["dialog_PolypWorm_hit"]	=1
	$story_stats["dialog_parasited"] =0
	$story_stats["dialog_parasited"] =0
	$story_stats["MenuSysSavegameOff"]		=1
	$story_stats["MenuSysHardcoreOff"]	=1
	$story_stats["MenuSysScatOff"]		=1
	$story_stats["MenuSysUrineOff"]		=1
	
	#$game_map.shadows.set_color(0, 20, 40)
	#$game_map.shadows.set_opacity(165)
	$game_map.shadows.set_color(120, 90, 70)
	$game_map.shadows.set_opacity(180)
	map_background_color(104,70,40,80,0)
	$game_map.interpreter.weather("cave_dust", 1, "WhiteDot")
	#$game_map.clear_fog
	$game_player.actor.sat = 100
	$game_player.actor.sta = 100
	$game_player.actor.dirt = 0
	$game_player.actor.health = 100
	$game_player.actor.change_equip(0, nil)
	$game_player.actor.change_equip(1, nil)
	$story_stats["LimitedNapSkill"] =1
	$game_player.direction = 2
	$game_system.menu_disabled = true
	$hudForceHide = true
	$balloonForceHide = false
	enter_static_tag_map
	player_force_update
	$game_player.opacity = 255

if $story_stats["GameOverGood"] == 1 #$story_stats["Ending_MainCharacter"] == "Ending_MC_ShipTicketBought" && !$DEMO
	SndLib.bgm_play("Peace in My World_Loop",vol=90,pitch=110,RPG::BGM.last.pos)
elsif $story_stats["GameOverGood"] == 0#$story_stats["Ending_MainCharacter"] == "Ending_MC_ShipSlave" && !$DEMO
	tmpCamX,tmpCamY,tmpCamID = $game_map.get_storypoint("Cam")
	tmpPtSlave0X,tmpPtSlave0Y,tmpPtSlave0ID = $game_map.get_storypoint("PtSlave0")
	tmpPtSlave1X,tmpPtSlave1Y,tmpPtSlave1ID = $game_map.get_storypoint("PtSlave1")
	tmpPtSlave2X,tmpPtSlave2Y,tmpPtSlave2ID = $game_map.get_storypoint("PtSlave2")
	tmpFucker5X,tmpFucker1Y,tmpFucker5ID = $game_map.get_storypoint("Fucker5")
	tmpFucker4X,tmpFucker2Y,tmpFucker4ID = $game_map.get_storypoint("Fucker4")
	tmpFucker3X,tmpFucker3Y,tmpFucker3ID = $game_map.get_storypoint("Fucker3")
	tmpFucker2X,tmpFucker4Y,tmpFucker2ID = $game_map.get_storypoint("Fucker2")
	tmpFucker1X,tmpFucker5Y,tmpFucker1ID = $game_map.get_storypoint("Fucker1")
	cam_follow(tmpCamID,0)
	get_character(tmpCamID).npc_story_mode(true)
	$game_player.actor.equips[1] = nil
	$game_player.actor.equips[2] = nil
	$game_player.actor.equips[3] = nil
	$game_player.actor.equips[4] = nil
	$game_player.actor.equips[6] = nil
	$game_player.actor.equips[8] = nil
	$game_player.actor.equips[9] = nil
	load_script("Data/Batch/Put_HeavyestBondage_no_dialog.rb")
	$game_player.actor.addCums("CumsCreamPie",1000,"Human")
	$game_player.actor.addCums("CumsCreamPie",1000,"Human")
	$game_player.actor.addCums("CumsCreamPie",1000,"Human")
	$game_player.actor.addCums("CumsMoonPie",1000,"Human")
	$game_player.actor.addCums("CumsMoonPie",1000,"Human")
	$game_player.actor.addCums("CumsMoonPie",1000,"Human")
	$game_player.actor.dirt = 255
	#summon_fucker
	#put animation
	#$game_player.animation = $gmae_player.animation_stun
	SndLib.bgm_play("Peace in My World_Loop",vol=90,pitch=10,RPG::BGM.last.pos)
	SndLib.bgs_play("WATER_Sea_Waves_Small_20sec_loop_stereo",85,60)
	
	cam_follow(tmpCamID,0)
	get_character(tmpCamID).moveto(tmpPtSlave0X,tmpPtSlave0Y)
	get_character(tmpFucker1ID).moveto(tmpPtSlave2X,tmpPtSlave2Y)
	get_character(tmpFucker2ID).moveto(tmpPtSlave2X-1,tmpPtSlave2Y)
	get_character(tmpFucker3ID).moveto(tmpPtSlave2X-2,tmpPtSlave2Y)
	get_character(tmpFucker4ID).moveto(tmpPtSlave2X-3,tmpPtSlave2Y)
	get_character(tmpFucker5ID).moveto(tmpPtSlave2X-4,tmpPtSlave2Y-1)
	get_character(tmpFucker1ID).opacity = 255
	get_character(tmpFucker2ID).opacity = 255
	get_character(tmpFucker3ID).opacity = 255
	get_character(tmpFucker4ID).opacity = 255
	get_character(tmpFucker5ID).opacity = 255
	
	get_character(tmpFucker1ID).move_type = 3
	get_character(tmpFucker1ID).npc_story_mode(true)
	npc_sex_service_main(get_character(tmpFucker1ID),$game_player,"vag",2,0)
	call_msg("commonEnding:EndingShipSlaveLona/begin1")
	wait(60)
	call_msg("commonEnding:EndingShipSlaveLona/begin2")
	portrait_hide
	chcg_background_color(0,0,0,255,-7)
		portrait_off
		get_character(tmpCamID).movetoRolling(tmpPtSlave1X,tmpPtSlave1Y)
		until !get_character(tmpCamID).moving?
			wait(1)
		end
		get_character(tmpCamID).movetoRolling(tmpPtSlave2X,tmpPtSlave2Y)
		until !get_character(tmpCamID).moving?
			wait(1)
		end
		call_msg("commonEnding:EndingShipSlaveLona/begin3")
		wait(120)
		call_msg("commonEnding:EndingShipSlaveLona/begin4")
		get_character(tmpFucker1ID).summon_data[:wait_dount] = 16
		npc_sex_service_main(get_character(tmpFucker1ID),$game_player,"vag",2,1)
		wait(120)
		get_character(tmpFucker1ID).summon_data[:wait_dount] = 50
		npc_sex_service_main(get_character(tmpFucker1ID),$game_player,"vag",2,2)
		wait(120)
		$game_player.actor.sta = -100
		$game_player.actor.mood = -100
		chcg_decider_basic_vag(pose="chcg4")
		$game_player.actor.stat["EventVagRace"] = "Human"
		$game_player.actor.stat["EventVag"] = "CumInside1"
		$game_player.actor.stat["vagopen"] = 1
		get_character(tmpFucker1ID).move_type = 0
		load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
	portrait_hide
	portrait_off
	chcg_background_color(0,0,0,0,4)
	call_msg("commonEnding:EndingShipSlaveLona/begin5")
	portrait_off
	map_background_color(0,0,0,255,0)
	
	call_msg("commonEnding:EndingShipSlaveLona/end")
	$game_player.animation = $game_player.animation_stun
	SndLib.bgm_stop
	$game_map.interpreter.chcg_background_color(0,0,0,0,3)
	$game_player.force_update = true
	wait(120)
	SndLib.bgs_stop
	wait(60)
	tmpDataSavEvID = $game_map.get_storypoint("DualBios")[2]
	$game_player.slot_RosterCurrent   = get_character(tmpDataSavEvID).summon_data[:slot_RosterCurrent]
	$game_player.slot_RosterArray     = get_character(tmpDataSavEvID).summon_data[:slot_RosterArray]  
	$game_player.slot_skill_normal    = get_character(tmpDataSavEvID).summon_data[:slot_skill_normal] 
	$game_player.slot_skill_heavy     = get_character(tmpDataSavEvID).summon_data[:slot_skill_heavy]  
	$game_player.slot_skill_control   = get_character(tmpDataSavEvID).summon_data[:slot_skill_control]
	$game_player.slot_hotkey_0        = get_character(tmpDataSavEvID).summon_data[:slot_hotkey_0]     
	$game_player.slot_hotkey_1        = get_character(tmpDataSavEvID).summon_data[:slot_hotkey_1]     
	$game_player.slot_hotkey_2        = get_character(tmpDataSavEvID).summon_data[:slot_hotkey_2]     
	$game_player.slot_hotkey_3        = get_character(tmpDataSavEvID).summon_data[:slot_hotkey_3]     
	$game_player.slot_hotkey_4        = get_character(tmpDataSavEvID).summon_data[:slot_hotkey_4]     
	$game_player.slot_hotkey_other    = get_character(tmpDataSavEvID).summon_data[:slot_hotkey_other] 
	load_script("Data/HCGframes/OverEvent_RebirthCheck.rb")
	return SceneManager.goto(Scene_Gameover)
end
SndLib.bgs_play("WATER_Sea_Waves_Small_20sec_loop_stereo",85,60)
#SndLib.bgm_play("D/Loop_The_Old_Tower_Inn",80,100)
chcg_background_color(0,0,0,255,-7)
eventPlayEnd
get_character(0).erase
