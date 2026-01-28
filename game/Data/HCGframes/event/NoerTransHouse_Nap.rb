return handleNap if $story_stats["UniqueCharNoerSnowflake"] == -1
return handleNap if $story_stats["RecQuestNoerSnowflake"] == -1
if $story_stats["Captured"] == 0
	tmpSnowflakeX,tmpSnowflakeY,tmpSnowflakeID = $game_map.get_storypoint("Snowflake")
	tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
	get_character(tmpSnowflakeID).npc.take_skill_cancel($data_arpgskills["BasicNormal"])
	chcg_background_color(0,0,0,0,7)
		get_character(tmpSnowflakeID).move_type = 0
		get_character(tmpSnowflakeID).npc_story_mode(true)
		get_character(tmpSnowflakeID).animation = nil
		get_character(tmpSnowflakeID).moveto($game_player.x,$game_player.y)
		get_character(tmpSnowflakeID).item_jump_to
		get_character(tmpSnowflakeID).turn_toward_character($game_player)
		$game_player.call_balloon(0)
		wait(30)
	chcg_background_color(0,0,0,255,-7)
	get_character(tmpSnowflakeID).call_balloon(8)
	wait(60)
	get_character(tmpSnowflakeID).call_balloon(3)
	wait(60)
	
	chcg_background_color(0,0,0,0,7)
	map_background_color(0,0,0,255)
		$game_player.moveto(tmpWakeUpX,tmpWakeUpY)
		$story_stats["Captured"] = 1
		$story_stats["RapeLoop"] = 0
		$story_stats["RapeLoopTorture"] = 0
		$game_player.actor.change_equip(0, nil)
		$game_player.actor.change_equip(1, nil)
		$game_player.actor.change_equip(5, nil)
		rape_loop_drop_item(tmpEquip=false,tmpSummon=false,lostItem=true,keepInBox=true)

		load_script("Data/Batch/Put_BondageItemsON.rb")
		$story_stats["dialog_cuff_equiped"]=0
		SndLib.sound_equip_armor(100)
		get_character(tmpSnowflakeID).npc_story_mode(false)
		portrait_hide
	handleNap
elsif $story_stats["Captured"] == 1 && $story_stats["RapeLoop"] == 1
	tmpSnowflakeX,tmpSnowflakeY,tmpSnowflakeID=$game_map.get_storypoint("Snowflake")
	tmpCapturedPointX,tmpCapturedPointY,tmpCapturedPointID=$game_map.get_storypoint("CapturedPoint")
	tmpGate1X,tmpGate1Y,tmpGate1ID=$game_map.get_storypoint("Gate1")
	tmpWakeUpX,tmpWakeUpY,tmpWakeUpID=$game_map.get_storypoint("WakeUp")
	get_character(tmpSnowflakeID).npc.take_skill_cancel($data_arpgskills["BasicNormal"])
	chcg_background_color(0,0,0,0,7)
		get_character(tmpSnowflakeID).move_type = 0
		get_character(tmpSnowflakeID).set_manual_move_type(0)
		get_character(tmpSnowflakeID).npc_story_mode(true)
		get_character(tmpSnowflakeID).animation = nil
		get_character(tmpSnowflakeID).moveto($game_player.x,$game_player.y)
		get_character(tmpSnowflakeID).item_jump_to
		get_character(tmpSnowflakeID).turn_toward_character($game_player)
		$game_player.call_balloon(0)
		wait(30)
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapNoerTransHouse:Trans/NapRapeloop0")
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["TagMapNoerTransHouse:Trans/opt_pills"]			,"skip"] #skip ....
	tmpTarList << [$game_text["TagMapNoerTransHouse:Trans/opt_male"]			,"opt_male"] if $game_player.actor.talk_persona == "_tsundere" || $story_stats["RapeLoopTorture"] >= 1#you are male #persona is touch or normal or nymph
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("TagMapNoerTransHouse:Trans/NapRapeloop1",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
	
	if tmpPicked == "opt_male"
		$game_player.turn_toward_character(get_character(tmpSnowflakeID))
		$game_player.animation = nil
		$story_stats["RecQuestNoerSnowflake"] = -1
		call_msg("TagMapNoerTransHouse:rapeloop/ans_male0")
		call_msg("TagMapNoerTransHouse:rapeloop/ans_male1")

		get_character(tmpSnowflakeID).animation = get_character(tmpSnowflakeID).animation_atk_mh
		$game_player.actor.stat["EventVagRace"] = "Human"
		load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
		wait(10)
		$game_player.animation = $game_player.animation_stun
		wait(60)
		call_msg("TagMapNoerTransHouse:rapeloop/ans_male2")
		cam_center(0)
		portrait_hide
		15.times{
			get_character(tmpSnowflakeID).move_speed = 4
			get_character(tmpSnowflakeID).call_balloon([5,6,7].sample)
			get_character(tmpSnowflakeID).move_random
			until !get_character(tmpSnowflakeID).moving?
				wait(1)
			end
		}
	else
		$story_stats["RapeLoopTorture"] = 1
		get_character(tmpSnowflakeID).animation = get_character(tmpSnowflakeID).animation_grabber_qte($game_player)
		$game_player.animation = $game_player.animation_grabbed_qte
		SndLib.sound_equip_armor(100)
		wait(60)
		portrait_off
		play_sex_service_main(ev_target=get_character(tmpSnowflakeID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4)
		half_event_key_cleaner
		play_sex_service_main(ev_target=get_character(tmpSnowflakeID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4)
		half_event_key_cleaner
		play_sex_service_main(ev_target=get_character(tmpSnowflakeID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4)
		portrait_off
		call_msg("TagMapNoerTransHouse:Trans/NapCapture4")
		portrait_off
		$game_player.actor.stat["EventVagRace"] =  "Human"
		$game_player.actor.stat["EventVag"] = "CumInside1"
		load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
		portrait_off
		$game_player.unset_event_chs_sex
		get_character(tmpSnowflakeID).unset_event_chs_sex
		call_msg("TagMapNoerTransHouse:Trans/NapCapture5")
	end
	handleNap
end
