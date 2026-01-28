return if $story_stats["OverMapForceTrans"] != 0
tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
get_character(tmpWakeUpID).switch2_id = 1 #1 how many days, 2 do rape?
tarRleaseDate=rand(5)+2
tarDate=tarRleaseDate+get_character(tmpWakeUpID).switch1_id

######################################## SoldEvent ###############################################
if $story_stats["Captured"] == 1 && $game_date.dateAmt >= tarDate
	tmpFucker1X,tmpFucker1Y,tmpFucker1ID = $game_map.get_storypoint("Raper1")
	tmpTraderX,tmpTraderY,tmpTraderID = $game_map.get_storypoint("Trader")
	tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
	get_character(tmpFucker1ID).npc_story_mode(true)
	get_character(tmpFucker1ID).moveto(get_character(tmpWakeUpID).x,get_character(tmpWakeUpID).y)
	get_character(tmpFucker1ID).item_jump_to
	get_character(tmpTraderID).moveto(get_character(tmpWakeUpID).x,get_character(tmpWakeUpID).y+3)
	get_character(tmpFucker1ID).turn_toward_character($game_player)
	call_msg("TagMapNoerMobHouse:Sold/begin1")
	$game_map.interpreter.chcg_background_color(0,0,0,255,-7)
	#do dialog
	get_character(tmpFucker1ID).turn_toward_character(get_character(tmpTraderID))
	call_msg("TagMapNoerMobHouse:Sold/begin2")
	get_character(tmpFucker1ID).turn_toward_character($game_player)
	call_msg("TagMapNoerMobHouse:Sold/begin3")
	get_character(tmpFucker1ID).turn_toward_character(get_character(tmpTraderID))
	call_msg("TagMapNoerMobHouse:Sold/begin4")
	$game_map.interpreter.chcg_background_color(40,0,40,0,7)
	
	if $game_player.actor.stat["SlaveBrand"] !=1
		$game_player.actor.stat["EventExt1Race"] = "Human"
		$game_player.actor.stat["EventExt1"] ="Grab"
		call_msg("TagMapNoerMobHouse:Sold/begin5")
		$game_player.actor.mood = -100
		$game_player.actor.add_state("SlaveBrand") #51
		whole_event_end
		#call_msg("TagMapNoerMobHouse:Sold/begin6")
	end
	$game_player.actor.morality_lona = 29
	
	#被賣到哪去?
	tmpTar = ["MinerPrison"]
	tmpTar << "NoerBackStreet" if $story_stats["UniqueCharUniqueGangBoss"] != -1 && $story_stats["UniqueCharUniqueHappyMerchant"] != -1 && !$DEMO
	tmpTar << "DoomFortressR" if !$DEMO
	tmpTar << "FishTownR" if !$DEMO
	tmpTar << "NoerArenaB1" if !$DEMO
	tmpTar << "NorthFL_INN" if !$DEMO
	tmpTar = tmpTar.sample
	$story_stats["OverMapForceTrans"] = tmpTar
	$story_stats["SlaveOwner"] = tmpTar
	case tmpTar
	when "MinerPrison"
			rape_loop_drop_item(false,false)
			$game_party.gain_item("ItemChainCollar", 1) 
			$game_player.actor.change_equip(5, "ItemChainCollar")
			$story_stats["dialog_collar_equiped"] =0
			call_msg("TagMapNoerMobHouse:Sold/begin7_#{tmpTar}")
			get_character(tmpFucker1ID).npc_story_mode(false)
			#傳送主角至定點
			$game_player.move_normal
			$game_map.interpreter.chcg_background_color(0,0,0,255)
			$game_player.actor.sta = -99 if $game_player.actor.sta <= -99
			change_map_leave_tag_map
			$story_stats["Captured"] = 1
			SndLib.sound_equip_armor(125)
			
	when "NoerBackStreet"
			rape_loop_drop_item(false,false)
			load_script("Data/Batch/Put_HeavyestBondage.rb") #上銬批次檔
			call_msg("TagMapNoerMobHouse:Sold/begin7_#{tmpTar}")
			get_character(tmpFucker1ID).npc_story_mode(false)
			#傳送主角至定點
			$game_player.move_normal
			$game_map.interpreter.chcg_background_color(0,0,0,255)
			$game_player.actor.sta = -99 if $game_player.actor.sta <= -99
			change_map_leave_tag_map
			$story_stats["RapeLoop"] =1
			$story_stats["RapeLoopTorture"] =0
			$story_stats["Captured"] = 1
			$story_stats["BackStreetArrearsWhorePrincipal"] = 600+($story_stats["WorldDifficulty"]*3).round
			
		when "NorthFL_INN"
			rape_loop_drop_item(false,false)
			$game_party.gain_item("ItemChainCuff", 1) 
			$game_player.actor.change_equip(0, "ItemChainCuff")
			$story_stats["dialog_collar_equiped"] =0
			$story_stats["dialog_cuff_equiped"]=0
			call_msg("TagMapNoerMobHouse:Sold/begin7_#{tmpTar}")
			get_character(tmpFucker1ID).npc_story_mode(false)
			#傳送主角至定點
			$game_player.move_normal
			$game_map.interpreter.chcg_background_color(0,0,0,255)
			$game_player.actor.sta = -99 if $game_player.actor.sta <= -99
			change_map_leave_tag_map
			$story_stats["Captured"] = 1
			$story_stats["RapeLoop"] = 1
			$story_stats["RapeLoopTorture"] = 0
			SndLib.sound_equip_armor(125)
			
		when "DoomFortressR"
			rape_loop_drop_item(false,false)
			$game_party.gain_item("ItemChainCuff", 1) 
			$game_player.actor.change_equip(0, "ItemChainCuff")
			$story_stats["dialog_collar_equiped"] =0
			$story_stats["dialog_cuff_equiped"]=0
			call_msg("TagMapNoerMobHouse:Sold/begin7_#{tmpTar}")
			get_character(tmpFucker1ID).npc_story_mode(false)
			#傳送主角至定點
			$game_player.move_normal
			$game_map.interpreter.chcg_background_color(0,0,0,255)
			$game_player.actor.sta = -99 if $game_player.actor.sta <= -99
			change_map_leave_tag_map
			$story_stats["Captured"] = 1
			$story_stats["RapeLoop"] = 1
			$story_stats["RapeLoopTorture"] = 0
			SndLib.sound_equip_armor(125)
			
			
		when "FishTownR"
			rape_loop_drop_item(false,false)
			$game_party.gain_item("ItemChainCuff", 1)
			$game_player.actor.change_equip(0, "ItemChainCuff")
			$story_stats["dialog_collar_equiped"] =0
			$story_stats["dialog_cuff_equiped"]=0
			call_msg("TagMapNoerMobHouse:Sold/begin7_#{tmpTar}")
			get_character(tmpFucker1ID).npc_story_mode(false)
			#傳送主角至定點
			$game_player.move_normal
			$game_map.interpreter.chcg_background_color(0,0,0,255)
			$game_player.actor.sta = -99 if $game_player.actor.sta <= -99
			change_map_leave_tag_map
			$story_stats["Captured"] = 1
			$story_stats["RapeLoop"] = 1
			$story_stats["RapeLoopTorture"] = 0
			SndLib.sound_equip_armor(125)
			
		when "NoerArenaB1"
			$game_player.actor.change_equip(0, nil)
			rape_loop_drop_item(false,false)
			$game_party.gain_item("ItemChainCollar", 1)
			$game_player.actor.change_equip(5, "ItemChainCollar")
			$story_stats["dialog_collar_equiped"] =0
			$story_stats["dialog_cuff_equiped"]=0
			call_msg("TagMapNoerMobHouse:Sold/begin7_#{tmpTar}")
			get_character(tmpFucker1ID).npc_story_mode(false)
			#傳送主角至定點
			$game_player.move_normal
			$game_map.interpreter.chcg_background_color(0,0,0,255)
			$game_player.actor.sta = -99 if $game_player.actor.sta <= -99
			change_map_leave_tag_map
			$story_stats["Captured"] = 1
			$story_stats["RapeLoop"] = 1
			$story_stats["RapeLoopTorture"] = 0
			SndLib.sound_equip_armor(125)
			
	end
	return eventPlayEnd
end

######################################## begin event ###############################################################
if $story_stats["Captured"] == 1 && tarDate-tarRleaseDate == $game_date.dateAmt #$story_stats["ReRollHalfEvents"] ==1
	$game_player.direction = 2
	tmpFucker1X,tmpFucker1Y,tmpFucker1ID = $game_map.get_storypoint("Raper1")
	get_character(tmpFucker1ID).moveto($game_player.x,$game_player.y+3)
	$game_map.interpreter.chcg_background_color(0,0,0,255,-7)
	get_character(tmpFucker1ID).call_balloon(5)
	call_msg("TagMapNoerMobHouse:beginEvent/begin")
	$game_map.interpreter.chcg_background_color(0,0,0,0,7)
	get_character(tmpFucker1ID).moveto(tmpFucker1X,tmpFucker1Y)
	eventPlayEnd 
	return get_character(0).erase
end


######################################## Food event ###############################################################
if $story_stats["Captured"] == 1 && $story_stats["ReRollHalfEvents"] ==0 && $game_date.day? && $story_stats["RapeLoopTorture"] !=1
	$game_player.direction = 2
	tmp1_X,tmp1_Y,tmp1_ID=$game_map.get_storypoint("HosBedPoint1")
	tmp2_X,tmp2_Y,tmp2_ID=$game_map.get_storypoint("HosBedPoint2")
	tmp3_X,tmp3_Y,tmp3_ID=$game_map.get_storypoint("HosBedPoint3")
	tmp4_X,tmp4_Y,tmp4_ID=$game_map.get_storypoint("HosBedPoint4")
	call_msg("TagMapNoerMobHouse:Rogue/PlaceFood0")
	call_msg("TagMapNoerMobHouse:Rogue/PlaceFood1")
	$game_map.reserve_summon_event("ItemBread",tmp1_X,tmp1_Y+1) 
	$game_map.reserve_summon_event("ItemBread",tmp2_X,tmp2_Y+1) 
	$game_map.reserve_summon_event("ItemBread",tmp3_X,tmp3_Y+1) 
	$game_map.reserve_summon_event("ItemBread",tmp4_X,tmp4_Y+1) 
	$game_map.reserve_summon_event("ItemBread",tmp1_X,tmp1_Y+1) 
	$game_map.reserve_summon_event("ItemBread",tmp2_X,tmp2_Y+1) 
	$game_map.reserve_summon_event("ItemBread",tmp3_X,tmp3_Y+1) 
	$game_map.reserve_summon_event("ItemBread",tmp4_X,tmp4_Y+1) 
	eventPlayEnd 
	return get_character(0).erase
end

return if $story_stats["OverMapForceTrans"] != 0
eventPlayEnd
get_character(0).erase