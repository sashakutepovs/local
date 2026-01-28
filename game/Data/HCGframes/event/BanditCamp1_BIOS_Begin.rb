#batch_weather_BanditCamp1_save($story_stats["BG_EFX_data"])
weather_batch_r5_forest
enter_static_tag_map
summon_companion
SndLib.bgm_play("Hatching_Grounds",80)
$story_stats["BG_EFX_data"] = get_BG_EFX_data_Indoor
if [40,41,42,43,47,39].include?($game_player.region_id)
	$game_map.set_fog(nil)
	weather_stop
	map_background_color_off
	set_SFX_to_indoor_SFX
	$game_map.set_underground_light
end


if $story_stats["Captured"] ==1
	get_character($game_map.get_storypoint("Chest")[2]).erase
end








################################################################# Captured checker
return if $story_stats["OverMapForceTrans"] != 0
tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
get_character(tmpWakeUpID).switch2_id[0] = 1 #1 how many days, 2 do rape?
tarRleaseDate=rand(5)+12
tarDate=tarRleaseDate+get_character(tmpWakeUpID).switch1_id

######################################## SoldEvent ###############################################
if $story_stats["Captured"] == 1 && $game_date.dateAmt >= tarDate
	tmpFucker1X,tmpFucker1Y,tmpFucker1ID = $game_map.get_storypoint("Raper1")
	tmpFucker2X,tmpFucker2Y,tmpFucker2ID = $game_map.get_storypoint("Raper2")
	tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
	get_character(tmpFucker1ID).npc_story_mode(true)
	get_character(tmpFucker1ID).moveto(get_character(tmpWakeUpID).x+1,get_character(tmpWakeUpID).y-1)
	get_character(tmpFucker2ID).moveto(get_character(tmpWakeUpID).x+1,get_character(tmpWakeUpID).y)
	get_character(tmpFucker1ID).turn_toward_character($game_player)
	get_character(tmpFucker2ID).turn_toward_character($game_player)
	$game_player.turn_toward_character(get_character(tmpFucker1ID))
	call_msg("TagMapBanditCamp1:Trans/begin1")

	$story_stats["OverMapForceTrans"] = "NoerMobHouse"
	rape_loop_drop_item(false,false)
	$game_party.gain_item($data_armors[22], 1)
	$game_actors[1].change_equip(5, $data_armors[22])
	$story_stats["dialog_collar_equiped"] =0
	call_msg("TagMapBanditCamp1:Trans/begin2")
	get_character(tmpFucker1ID).npc_story_mode(false)
	#傳送主角至定點
	$game_player.move_normal
	$game_map.interpreter.chcg_background_color(0,0,0,255)
	$game_actors[1].sta = -99 if $game_actors[1].sta <= -99
	change_map_leave_tag_map
	$story_stats["Captured"] = 1
	SndLib.sound_equip_armor(125)
	return eventPlayEnd
end
######################################## begin event CAPTURED###############################################################
if $story_stats["Captured"] == 1 && tarDate-tarRleaseDate == $game_date.dateAmt #$story_stats["ReRollHalfEvents"] ==1
	tmpFucker1X,tmpFucker1Y,tmpFucker1ID = $game_map.get_storypoint("Raper1")
	get_character(tmpFucker1ID).moveto($game_player.x+1,$game_player.y)
	get_character(tmpFucker1ID).turn_toward_character($game_player)
	$game_player.turn_toward_character(get_character(tmpFucker1ID))
	$game_map.interpreter.chcg_background_color(0,0,0,255,-7)
	get_character(tmpFucker1ID).call_balloon(5)
	call_msg("TagMapBanditCamp1:beginEvent/begin")
	$game_map.interpreter.chcg_background_color(0,0,0,0,7)
	get_character(tmpFucker1ID).moveto(tmpFucker1X,tmpFucker1Y)
	eventPlayEnd
	return get_character(0).erase
end


######################################## Food event ###############################################################
if $story_stats["Captured"] == 1 && $story_stats["ReRollHalfEvents"] ==0 && $game_date.day? && $story_stats["RapeLoopTorture"] != 1

	#第一陣列負責記錄狗狗事件與群礁事件是否執行過 若1 則沒食物
	if get_character(tmpWakeUpID).switch2_id[1] == 1
		call_msg("TagMapBanditCamp1:Rogue/PlaceFood_no")
		eventPlayEnd
		return get_character(0).erase
	end

	#若啟動WHORE JOB 且單位不等於0則沒食物 每個性交單位於NPCrb中給予變數+=1
	if get_character(tmpWakeUpID).switch2_id[2] < 5 && get_character(tmpWakeUpID).switch2_id[2] !=0
		get_character(tmpWakeUpID).switch2_id[2] = 0
		call_msg("TagMapBanditCamp1:Rogue/PlaceFood_no")
		eventPlayEnd
		return get_character(0).erase
	end
	tmpWkX,tmpWkY,tmpWkID=$game_map.get_storypoint("WakeUp")
	get_character(tmpWkID).switch2_id[3] = 0 #switch2_id[3]為狗狗變數 醒來時歸零
	tmp1_X,tmp1_Y=tmpWkX+1+rand(2),tmpWkY
	tmp2_X,tmp2_Y=tmpWkX+1+rand(2),tmpWkY
	tmp3_X,tmp3_Y=tmpWkX+1+rand(2),tmpWkY
	tmp4_X,tmp4_Y=tmpWkX+1+rand(2),tmpWkY
	call_msg("TagMapBanditCamp1:Rogue/PlaceFood0")
	$game_map.reserve_summon_event("ItemBread",tmp1_X,tmp1_Y+1) if rand(100) >= 50
	$game_map.reserve_summon_event("ItemBread",tmp2_X,tmp2_Y+1)
	$game_map.reserve_summon_event("ItemBread",tmp2_X,tmp2_Y+1)
	$game_map.reserve_summon_event("ItemBread",tmp3_X,tmp3_Y+1)
	get_character(tmpWakeUpID).switch2_id[1] = 1
	eventPlayEnd
	return get_character(0).erase
end

return if $story_stats["OverMapForceTrans"] != 0
chcg_background_color(0,0,0,255,-7) if get_chcg_background_opacity >= 255

eventPlayEnd
get_character(0).erase
