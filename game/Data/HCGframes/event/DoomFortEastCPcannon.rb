
tmpAmo1X,tmpAmo1Y,tmpAmo1ID = $game_map.get_storypoint("Ammo1")
tmpAmo2X,tmpAmo2Y,tmpAmo2ID = $game_map.get_storypoint("Ammo2")
tmpCan1X,tmpCan1Y,tmpCan1ID = $game_map.get_storypoint("Cannon1")
tmpCan2X,tmpCan2Y,tmpCan2ID = $game_map.get_storypoint("Cannon2")
tmpDorX,tmpDorY,tmpDorID = $game_map.get_storypoint("Door")
tmpQcX,tmpQcY,tmpQcID = $game_map.get_storypoint("QuestCount")
tmpExX,tmpExY,tmpExID = $game_map.get_storypoint("exitDor")
return SndLib.sys_trigger if $story_stats["RecQuestDF_Ecp"] == -1
return SndLib.sys_trigger if $story_stats["RecQuestDF_Ecp"] != 3

if get_character(tmpQcID).summon_data[:BothLoaded] == true && get_character(0).summon_data[:loaded] == true && get_character(0).summon_data[:fired] == false
	$game_player.animation = $game_player.animation_atk_mh
	SndLib.sound_Reload
	get_character(0).summon_data[:fired] = true
	get_character(0).call_balloon(0)
	get_character(0).move_type = 3
	get_character(0).trigger = -1
	
else
	if get_character(0).summon_data[:loaded] == true
		SndLib.sys_buzzer
		$game_map.popup(0,"TagMapDoomFortEastCP:cannon/LoadedQmsg0",0,0)
		return
	elsif get_character(tmpQcID).summon_data[:fired] == true
		SndLib.sys_buzzer
		$game_map.popup(0,"TagMapDoomFortEastCP:cannon/FiredQmsg0",0,0)
		return
	elsif get_character(0).summon_data[:loaded] == false && get_character(tmpQcID).summon_data[:withAmmo] == false
		SndLib.sys_buzzer
		$game_map.popup(0,"TagMapDoomFortEastCP:cannon/OOAQmsg0",0,0)
		return
	elsif get_character(0).summon_data[:loaded] == false && get_character(tmpQcID).summon_data[:withAmmo] ==true
		get_character(tmpCan1ID).call_balloon(0)
		get_character(tmpCan2ID).call_balloon(0)
		get_character(tmpExID).call_balloon(0)
		get_character(0).summon_data[:loaded] = true
		get_character(tmpQcID).summon_data[:withAmmo] = false
		$game_player.animation = $game_player.animation_atk_mh
		SndLib.sound_Reload
	
	end
	
	if get_character(tmpCan1ID).summon_data[:loaded] == true && get_character(tmpCan2ID).summon_data[:loaded] == true# && get_character(tmpCan1ID).summon_data[:fired] == false && get_character(tmpCan2ID).summon_data[:fired] == false
		get_character(tmpQcID).summon_data[:BothLoaded] = true
		call_msg("TagMapDoomFortEastCP:CPofficer/overrunning_begin3_fireCannon")
		portrait_hide
		cam_center(0)
		#set_event_force_page(tmpCan1ID,1)
		#set_event_force_page(tmpCan2ID,1)
		get_character(tmpCan1ID).call_balloon(28,-1)
		get_character(tmpCan2ID).call_balloon(28,-1)
	else
		get_character(tmpDorID).call_balloon(28,-1)
		get_character(tmpAmo1ID).call_balloon(28,-1)
		get_character(tmpAmo2ID).call_balloon(28,-1)
	end
end