tmpLewdPoisonID = $game_map.get_storypoint("LewdPoison")[2]
if $story_stats["RecQuest_Df_TellerSide"] >= 3
	get_character(0).set_region_trigger(65535)
	return get_character(0).delete if $story_stats["RecQuest_Df_TellerSide"] >= 3
	
end
slotList = $data_system.equip_type_name
!equip_slot_removetable?("MH")		? equips_MH_id = -1 :		equips_MH_id =		$game_player.actor.equips[slotList["MH"]].item_name		#0
!equip_slot_removetable?("SH")		? equips_SH_id = -1 :		equips_SH_id =		$game_player.actor.equips[slotList["SH"]].item_name		#1
!equip_slot_removetable?("Top")		? equips_Top_id = -1 :		equips_Top_id =		$game_player.actor.equips[slotList["Top"]].item_name	#2
!equip_slot_removetable?("Mid")		? equips_Mid_id = -1 :		equips_Mid_id =		$game_player.actor.equips[slotList["Mid"]].item_name	#3
!equip_slot_removetable?("Bot")		? equips_Bot_id = -1 :		equips_Bot_id =		$game_player.actor.equips[slotList["Bot"]].item_name	#4
!equip_slot_removetable?("TopExt")	? equips_TopExt_id = -1 :	equips_TopExt_id =	$game_player.actor.equips[slotList["TopExt"]].item_name	#5
!equip_slot_removetable?("MidExt")	? equips_MidExt_id = -1 :	equips_MidExt_id =	$game_player.actor.equips[slotList["MidExt"]].item_name	#6
!equip_slot_removetable?("Hair")	? equips_Hair_id = -1 :		equips_Hair_id =	$game_player.actor.equips[slotList["Hair"]].item_name	#7
!equip_slot_removetable?("Head")	? equips_Head_id = -1 :		equips_Head_id =	$game_player.actor.equips[slotList["Head"]].item_name	#8
!equip_slot_removetable?("Neck")	? equips_Neck_id = -1 :		equips_Neck_id =	$game_player.actor.equips[slotList["Neck"]].item_name	#14
!equip_slot_removetable?("Vag")		? equips_Vag_id = -1 :		equips_Vag_id =		$game_player.actor.equips[slotList["Vag"]].item_name	#15
!equip_slot_removetable?("Anal")	? equips_Anal_id = -1 :		equips_Anal_id =	$game_player.actor.equips[slotList["Anal"]].item_name	#16
withCloth = !$game_player.player_nude?
if $story_stats["RecDfWaterCaveHeresyWatch"] == 0 && $story_stats["Captured"] == 0
	$story_stats["RecDfWaterCaveHeresyWatch"] = 1
	tmpCamX,tmpCamY,tmpCamID = $game_map.get_storypoint("Cam")
	tmpBlueBlueX,tmpBlueBlueY,tmpBlueBlueID = $game_map.get_storypoint("BlueBlue")
	tmpPigManX,tmpPigManY,tmpPigManID = $game_map.get_storypoint("PigMan")
	tmpGodX,tmpGodY,tmpGodID = $game_map.get_storypoint("God")
	tmpOfferingX,tmpOfferingY,tmpOfferingID = $game_map.get_storypoint("Offering")
	tmpPPL1ID = $game_map.get_storypoint("PPL1")[2]
	tmpPPL2ID = $game_map.get_storypoint("PPL2")[2]
	tmpPPL3ID = $game_map.get_storypoint("PPL3")[2]
	tmpPPL4ID = $game_map.get_storypoint("PPL4")[2]
	tmpPPL5ID = $game_map.get_storypoint("PPL5")[2]
	tmpPPL1MT = get_character(tmpPPL1ID).move_type
	tmpPPL2MT = get_character(tmpPPL2ID).move_type
	tmpPPL3MT = get_character(tmpPPL3ID).move_type
	tmpPPL4MT = get_character(tmpPPL4ID).move_type
	tmpPPL5MT = get_character(tmpPPL5ID).move_type
	tmpPPL1DIR = get_character(tmpPPL1ID).direction
	tmpPPL2DIR = get_character(tmpPPL2ID).direction
	tmpPPL3DIR = get_character(tmpPPL3ID).direction
	tmpPPL4DIR = get_character(tmpPPL4ID).direction
	tmpPPL5DIR = get_character(tmpPPL5ID).direction
	$game_map.npcs.each{
	|event|
		next unless event.summon_data
		next unless event.summon_data[:sexUnit] || event.summon_data[:OBJ]
		next if event.deleted?
		next if event.npc.action_state == :death
		event.npc_story_mode(true)
	}
	
	$game_player.call_balloon(1)
	$game_player.direction = 2
	call_msg("TagMapDfWaterCave:SexPartyOP/0") ; portrait_hide
	$game_player.direction = 6 ; $game_player.call_balloon(8) ; wait(60)
	$game_player.direction = 4 ; $game_player.call_balloon(8) ; wait(60)
	$game_player.direction = 2 ; $game_player.call_balloon(8) ; wait(60)
	call_msg("TagMapDfWaterCave:SexPartyOP/1") ; portrait_hide
	
	cam_follow(tmpCamID,0)
	get_character(tmpCamID).npc_story_mode(true)
	portrait_hide
	
	SndLib.bgm_play("/D/Between two worlds",80)
	$hudForceHide = true
	10.times{get_character(tmpCamID).direction = 2 ; get_character(tmpCamID).move_forward_force ; wait(32)}
	5.times{get_character(tmpCamID).direction = 6 ; get_character(tmpCamID).move_forward_force ; wait(32)}
	4.times{get_character(tmpCamID).direction = 8 ; get_character(tmpCamID).move_forward_force ; wait(32)}
	2.times{get_character(tmpCamID).direction = 4 ; get_character(tmpCamID).move_forward_force ; wait(32)}
	#2.times{get_character(tmpCamID).direction = 2 ; get_character(tmpCamID).move_forward_force ; wait(32)}
	call_msg("TagMapDfWaterCave:SexPartyOP/2_1")
	get_character(tmpOfferingID).move_type = 0
	get_character(tmpPigManID).move_type = 0
	tmpOfferingX,tmpOfferingY,tmpOfferingID = $game_map.get_storypoint("Offering")
	npc_sex_service_main(get_character(tmpPigManID),get_character(tmpOfferingID),"mouth",5,0)
	call_msg("TagMapDfWaterCave:SexPartyOP/2_2")
	tmpOfferingX,tmpOfferingY,tmpOfferingID = $game_map.get_storypoint("Offering")
	npc_sex_service_main(get_character(tmpPigManID),get_character(tmpOfferingID),"mouth",5,1)
	call_msg("TagMapDfWaterCave:SexPartyOP/2_3")
	tmpOfferingX,tmpOfferingY,tmpOfferingID = $game_map.get_storypoint("Offering")
	npc_sex_service_main(get_character(tmpPigManID),get_character(tmpOfferingID),"mouth",5,2)
	get_character(tmpPPL1ID).animation = nil
	get_character(tmpPPL2ID).animation = nil
	get_character(tmpPPL3ID).animation = nil
	get_character(tmpPPL4ID).animation = nil
	get_character(tmpPPL5ID).animation = nil
	get_character(tmpPPL1ID).move_type = 0
	get_character(tmpPPL2ID).move_type = 0
	get_character(tmpPPL3ID).move_type = 0
	get_character(tmpPPL4ID).move_type = 0
	get_character(tmpPPL5ID).move_type = 0
	get_character(tmpPPL1ID).turn_toward_character(get_character(tmpPigManID))
	get_character(tmpPPL2ID).turn_toward_character(get_character(tmpPigManID))
	get_character(tmpPPL3ID).turn_toward_character(get_character(tmpPigManID))
	get_character(tmpPPL4ID).turn_toward_character(get_character(tmpPigManID))
	get_character(tmpPPL5ID).turn_toward_character(get_character(tmpPigManID))
	4.times{
		$game_map.interpreter.flash_screen(Color.new(255,255,255,25),4,false)
		SndLib.sound_chcg_full(75+rand(30))
		wait(60)
	}
	get_character(tmpOfferingID).unset_event_chs_sex
	get_character(tmpPigManID).unset_event_chs_sex
	call_msg("TagMapDfWaterCave:SexPartyOP/3")
	
	2.times{
	get_character(tmpOfferingID).direction = 2 ; get_character(tmpOfferingID).move_forward_force ; wait(60)
	get_character(tmpPPL1ID).turn_toward_character(get_character(tmpOfferingID))
	get_character(tmpPPL2ID).turn_toward_character(get_character(tmpOfferingID))
	get_character(tmpPPL3ID).turn_toward_character(get_character(tmpOfferingID))
	get_character(tmpPPL4ID).turn_toward_character(get_character(tmpOfferingID))
	get_character(tmpPPL5ID).turn_toward_character(get_character(tmpOfferingID))
	}
	##################################################################### 邪神現身
	call_msg("TagMapDfWaterCave:SexPartyOP/3_1")
	call_msg("TagMapDfWaterCave:SexPartyOP/4")
	$game_map.interpreter.screen.start_shake(5,10,60)
	screen.start_tone_change(Tone.new(125,0,125,125),10)
	SndLib.sound_FlameCast(100,70)
	wait(5)
	SndLib.sound_Heartbeat(100,90)
	get_character(tmpGodID).npc_story_mode(true)
	get_character(tmpGodID).moveto(tmpPigManX,tmpPigManY+3)
	get_character(tmpGodID).forced_y = -24
	get_character(tmpGodID).move_type = 3
	get_character(tmpGodID).zoom_y = 1.5
	get_character(tmpGodID).zoom_x = 1.5
	get_character(tmpGodID).forced_z = 10
	#cam_follow(tmpGodID)
	#call_msg("asd")
	until get_character(tmpGodID).opacity >= 255
		get_character(tmpGodID).opacity += 5
		wait(2)
	end
	$game_map.npcs.each{
	|event|
		next unless event.summon_data
		next unless event.summon_data[:sexUnit] || event.summon_data[:OBJ]
		next if event.deleted?
		next if event.npc.action_state == :death
		event.summon_data[:savedMoveType] = event.move_type
		event.move_type = 0
		event.unset_event_chs_sex
		event.animation = nil
		event.turn_toward_character(get_character(tmpOfferingID))
	}
	get_character(tmpPigManID).animation = get_character(tmpPigManID).aniCustom([[6,0,0,0,6]],-1)
	##################################################################### 漂浮術
	call_msg("TagMapDfWaterCave:SexPartyOP/5")
	call_msg("TagMapDfWaterCave:SexPartyOP/6") ; portrait_hide
	get_character(tmpOfferingID).angle = 0
	get_character(tmpOfferingID).forced_x = 0
	get_character(tmpOfferingID).forced_y = 0
	tmpANI = [
	[1,2,4,1,0],
	[1,2,4,0,0]
	]
	get_character(tmpOfferingID).animation =get_character(tmpOfferingID).aniCustom(tmpANI,-1)
	$game_map.interpreter.screen.start_shake(5,10,30)
	until get_character(tmpOfferingID).angle >= 90
		get_character(tmpOfferingID).forced_x += 0.3
		get_character(tmpOfferingID).forced_y -= 0.5
		get_character(tmpOfferingID).angle += 1
		SndLib.sound_FlameCast(100,100)
		wait(2)
	end
	get_character(tmpOfferingID).forced_x = get_character(tmpOfferingID).forced_x.round
	get_character(tmpOfferingID).forced_y = get_character(tmpOfferingID).forced_y.round
	tmpANI = [
	[1,0,4,1,0],
	[1,2,4,1,0],
	[1,1,4,1,0],
	[1,3,4,0,0]
	]
	get_character(tmpOfferingID).animation =get_character(tmpOfferingID).aniCustom(tmpANI,-1)
	wait(80)
	call_msg("TagMapDfWaterCave:SexPartyOP/4_1")
	get_character(tmpOfferingID).forced_x = 0
	get_character(tmpOfferingID).angle = 0
	get_character(tmpOfferingID).animation =get_character(tmpOfferingID).animation_stun
	
	$game_map.interpreter.screen.start_shake(5,10,30)
	SndLib.sound_FlameCast(100,50)
	until get_character(tmpOfferingID).forced_y >= 0
		get_character(tmpOfferingID).forced_y += 5
		SndLib.sound_FlameCast(100,100)
		wait(2)
	end
	get_character(tmpOfferingID).forced_y = 0
	SndLib.sound_punch_hit(100)
	wait(60)
	############################################################################ 收尾
	#SndLib.sound_Heartbeat(100,90)
	
	until get_character(tmpGodID).opacity <=0
		SndLib.sound_Heartbeat(100-(get_character(tmpGodID).opacity-140),60)
		get_character(tmpGodID).opacity -= 5
		wait(4)
	end
	############################################################################ 移動 準備幹便器
	call_msg("TagMapDfWaterCave:SexPartyOP/4_2")
	get_character(tmpPPL1ID).direction = 8 ; get_character(tmpPPL1ID).move_forward_force
	get_character(tmpPPL2ID).direction = 6 ; get_character(tmpPPL2ID).move_forward_force
	get_character(tmpPPL4ID).direction = 4 ; get_character(tmpPPL4ID).move_forward_force
	wait(60)
	get_character(tmpPPL1ID).direction = 6 ; get_character(tmpPPL1ID).move_forward_force
	get_character(tmpPPL2ID).direction = 6 ; get_character(tmpPPL2ID).move_forward_force
	wait(60)
	get_character(tmpPPL1ID).direction = 6 ; get_character(tmpPPL1ID).move_forward_force
	get_character(tmpPPL2ID).direction = 6 ; get_character(tmpPPL2ID).move_forward_force
	wait(60)
	get_character(tmpPPL1ID).direction = 6 ; get_character(tmpPPL1ID).move_forward_force
	wait(60)
	get_character(tmpPPL1ID).direction = 2 ; get_character(tmpPPL1ID).move_forward_force
	wait(60)
	get_character(tmpPPL1ID).direction = 6 ; get_character(tmpPPL1ID).move_forward_force
	wait(60)
	get_character(tmpPPL1ID).direction = 6 ; get_character(tmpPPL1ID).move_forward_force
	wait(60)
	get_character(tmpPPL1ID).direction = 2
	get_character(tmpPPL1ID).animation = get_character(tmpPPL1ID).animation_masturbation
	get_character(tmpPPL2ID).animation = get_character(tmpPPL2ID).animation_masturbation
	get_character(tmpPPL4ID).animation = get_character(tmpPPL4ID).animation_masturbation
	wait(60)
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpGodID).delete
		get_character(tmpOfferingID).move_type = 0
		get_character(tmpOfferingID).set_manual_move_type(0)
		get_character(tmpOfferingID).npc.receiver_type =2
		get_character(tmpOfferingID).npc.no_aggro = true
		get_character(tmpOfferingID).npc.remove_skill("killer","NpcMarkMoralityDown")
		get_character(tmpOfferingID).npc.remove_skill("assaulter","NpcMarkMoralityDown")
		get_character(tmpPPL1ID).npc.fucker_condition={"sex"=>[0, "="]}
		get_character(tmpPPL2ID).npc.fucker_condition={"sex"=>[0, "="]}
		get_character(tmpPPL4ID).npc.fucker_condition={"sex"=>[0, "="]}
		
	get_character(tmpPPL1ID).npc.sense_target(get_character(tmpPPL1ID),0)
	get_character(tmpPPL2ID).npc.sense_target(get_character(tmpPPL2ID),0)
	get_character(tmpPPL4ID).npc.sense_target(get_character(tmpPPL4ID),0)
		get_character(tmpPigManID).move_type = 3
		get_character(tmpPPL1ID).move_type = tmpPPL1MT
		get_character(tmpPPL2ID).move_type = tmpPPL2MT
		get_character(tmpPPL3ID).move_type = tmpPPL3MT
		get_character(tmpPPL4ID).move_type = tmpPPL4MT
		get_character(tmpPPL5ID).move_type = tmpPPL5MT
		$game_map.npcs.each{
		|event|
			next unless event.summon_data
			next unless event.summon_data[:sexUnit] || event.summon_data[:OBJ]
			next if event.deleted?
			next if event.npc.action_state == :death
			event.npc_story_mode(false)
			event.move_type = event.summon_data[:savedMoveType]
		}
		get_character(tmpCamID).npc_story_mode(false)
		cam_center(0)
		$game_player.animation = $game_player.animation_stun
		SndLib.bgm_play_prev
		if cocona_in_group?
			call_msg("TagMapDfWaterCave:SexPartyOP/end_cocona")
			get_character($game_player.get_followerID(0)).moveto($game_player.x,$game_player.y-1)
			get_character($game_player.get_followerID(0)).direction = 2
		end
	chcg_background_color(0,0,0,255,-7)
	$hudForceHide = false
	call_msg("TagMapDfWaterCave:SexPartyOP/end1")
	$game_player.animation = nil
	call_msg("TagMapDfWaterCave:SexPartyOP/end1_cocona") if cocona_in_group?
	call_msg("TagMapDfWaterCave:SexPartyOP/end2")
	call_msg("TagMapDfWaterCave:SexPartyOP/end2_cocona") if cocona_in_group?
	$game_player.actor.add_state(32)
	$game_player.actor.add_state(32)
	$game_player.actor.add_state(32)
	set_event_force_page(tmpLewdPoisonID,1) # enable Lewd Poison
	get_character(tmpBlueBlueID).call_balloon(28,-1) if $story_stats["RecQuestDf_HeresyMomo"] == 2
	get_character(tmpPigManID).call_balloon(28,-1) if $story_stats["RecQuest_Df_TellerSide"] == 2
	eventPlayEnd
elsif $story_stats["Captured"] == 1
	SndLib.bgm_play("/D/Between two worlds",80)
	screen.start_tone_change(Tone.new(125,0,125,125),60)
	call_msg("TagMapDfWaterCave:RG27StepOn/0")
	$game_player.actor.add_state("FeelsHorniness")
	$game_player.actor.add_state("FeelsHorniness")
	$game_player.actor.add_state("FeelsHorniness")
	$game_player.actor.add_state("ForceExhibitionism")
	$game_player.actor.add_state("ForceLewd")
	set_event_force_page(tmpLewdPoisonID,1) # enable Lewd Poison
	$story_stats["dialog_dress_out"] = 0
	combat_remove_random_equip("Head")
	combat_remove_random_equip("MH")
	combat_remove_random_equip("SH")
	combat_remove_random_equip("MidExt")
	combat_remove_random_equip("Top")
	combat_remove_random_equip("Bot")
	combat_remove_random_equip("Mid")
	combat_remove_random_equip("Vag")
	combat_remove_random_equip("Anal")

	if equips_Mid_id == -1 && equips_Bot_id == -1 && equips_Vag_id == -1 && equips_MidExt_id == -1
		SndLib.sound_equip_armor(100)
		wait(3)
	end
	player_force_update
	eventPlayEnd
else
	tmpPigManX,tmpPigManY,tmpPigManID = $game_map.get_storypoint("PigMan")
	tmpBlueBlueX,tmpBlueBlueY,tmpBlueBlueID = $game_map.get_storypoint("BlueBlue")
	SndLib.bgm_play("/D/Between two worlds",80)
	screen.start_tone_change(Tone.new(125,0,125,125),60)
	call_msg("TagMapDfWaterCave:RG27StepOn/0")
	$game_player.actor.add_state(32)
	$game_player.actor.add_state(32)
	$game_player.actor.add_state(32)
	set_event_force_page(tmpLewdPoisonID,1) # enable Lewd Poison
	eventPlayEnd
	get_character(tmpBlueBlueID).call_balloon(28,-1) if $story_stats["RecQuestDf_HeresyMomo"] == 2
	get_character(tmpPigManID).call_balloon(28,-1) if $story_stats["RecQuest_Df_TellerSide"] == 2

end

get_character(0).erase
