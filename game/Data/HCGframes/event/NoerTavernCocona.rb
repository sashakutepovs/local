if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
tmpMamaID = -1
tmpMamaThere = $game_map.npcs.any?{|ev|
	next if !ev.summon_data
	next if !ev.summon_data[:TavernWaifu]
	next if ev.npc.action_state == :death
	next if ev.deleted? || ev.erased
	tmpMamaID = ev.id
	true
}
get_character(0).call_balloon(0)
get_character(0).animation = nil
############################################################################## 可可娜感謝主角  UNLOCK FOLLOWER #########################################################################################################
if $story_stats["RecQuestCocona"] == 4
	$story_stats["RecQuestCocona"] = 5
	$story_stats["RecQuestCoconaAmt"] = $game_date.dateAmt + 2
	call_msg("CompCocona:Cocona/RecQuestCocona_3_1")
	eventPlayEnd
	GabeSDK.getAchievement("RecQuestCocona_5")

############################################################################## Bath #########################################################################################################
elsif $story_stats["RecQuestCocona"] == 9 && $story_stats["UniqueCharUniqueTavernWaifu"] != -1
	
	call_msg("CompCocona:Cocona/RecQuestCocona_9_1")
	chcg_background_color(0,0,0,0,7)
	tmpCoX,tmpCoY,tmpCoID=$game_map.get_storypoint("UniqueCocona")
		$game_player.moveto(tmpCoX,tmpCoY)
		$game_player.direction = 4
		get_character(tmpCoID).moveto(tmpCoX-1,tmpCoY)
		get_character(tmpCoID).direction = 6




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

		if equips_Head_id != -1#檢查裝備 並脫裝
			$game_player.actor.change_equip("Head", nil)
			SndLib.sound_equip_armor(80)
			player_force_update
			wait(30)
		end
		if equips_MidExt_id != -1#檢查裝備 並脫裝
			$game_player.actor.change_equip("MidExt", nil)
			SndLib.sound_equip_armor(80)
			player_force_update
			wait(30)
		end
		get_character(0).batch_cocona_setCHS("-char-F-TEEN01",13)
		$game_NPCLayerMain.stat["Cocona_Dress"] = "Nude"
		$game_NPCLayerMain.prtmood("cocona_sad")
		$game_portraits.setLprt("NPCLayerMain")
		
		if equips_Top_id != -1#檢查裝備 並脫裝
			$game_player.actor.change_equip("Top", nil)
			SndLib.sound_equip_armor(80)
			player_force_update
			wait(30)
		end
		$game_NPCLayerMain.stat["Cocona_Dress"] = "Nude"
		$game_NPCLayerMain.prtmood("cocona_angry")
		$game_portraits.setLprt("NPCLayerMain")
		if equips_Bot_id != -1#檢查裝備 並脫裝
			$game_player.actor.change_equip("Bot", nil)
			SndLib.sound_equip_armor(80)
			player_force_update
			wait(30)
		end
		if equips_Anal_id != -1#檢查裝備 並脫裝
			$game_player.actor.change_equip("Anal", nil)
			SndLib.sound_equip_armor(80)
			player_force_update
			wait(30)
		end
		if equips_Vag_id != -1#檢查裝備 並脫裝
			$game_player.actor.change_equip("Vag", nil)
			SndLib.sound_equip_armor(80)
			player_force_update
			wait(30)
		end
		
		$game_NPCLayerMain.stat["Cocona_Dress"] = "Nude"
		$game_NPCLayerMain.prtmood("cocona_sad")
		$game_portraits.setLprt("NPCLayerMain")
		if equips_Mid_id != -1#檢查裝備 並脫裝
			$game_player.actor.change_equip("Mid", nil)
			SndLib.sound_equip_armor(80)
			player_force_update
			wait(30)
		end
		
		
		
		4.times{load_script("Data/Batch/Command_Bath.rb")}
		call_StoryHevent("RecHevCoconaBath","HevCoconaBath")
		call_msg("CompCocona:Cocona/RecQuestCocona_9_2")

		#if !Input.press?(:SHIFT)
			if equips_Vag_id != -1#檢查裝備 並穿裝
				$game_player.actor.change_equip("Vag", $data_ItemName[equips_Vag_id])
				SndLib.sound_equip_armor(100)
				player_force_update
				wait(30)
			end
			if equips_Anal_id != -1#檢查裝備 並穿裝
				$game_player.actor.change_equip("Anal", $data_ItemName[equips_Anal_id])
				SndLib.sound_equip_armor(100)
				player_force_update
				wait(30)
			end
			if equips_Mid_id != -1#檢查裝備 並穿裝
				$game_player.actor.change_equip("Mid", $data_ItemName[equips_Mid_id])
				SndLib.sound_equip_armor(100)
				player_force_update
				wait(30)
			end
		#end
		
		$story_stats["RecQuestCocona"] = 10
		$game_NPCLayerMain.nap_reset_stats
		$game_NPCLayerMain.prtmood("cocona_confused")
		$game_portraits.setLprt("NPCLayerMain")
		$game_NPCLayerMain.stat["Cocona_Dress"] = "Maid"
		
		#if !Input.press?(:SHIFT)
			if equips_Mid_id != -1#檢查裝備 並穿裝
				$game_player.actor.change_equip("Bot", $data_ItemName[equips_Bot_id])
				SndLib.sound_equip_armor(100)
				player_force_update
				wait(30)
			end
			if equips_Top_id != -1#檢查裝備 並穿裝
				$game_player.actor.change_equip("Top", $data_ItemName[equips_Top_id])
				SndLib.sound_equip_armor(100)
				player_force_update
				wait(30)
			end
			if equips_MidExt_id != -1#檢查裝備 並穿裝
				$game_player.actor.change_equip("MidExt", $data_ItemName[equips_MidExt_id])
				SndLib.sound_equip_armor(100)
				player_force_update
				wait(30)
			end
			if equips_Head_id != -1#檢查裝備 並穿裝
				$game_player.actor.change_equip("Head", $data_ItemName[equips_MidExt_id])
				SndLib.sound_equip_armor(100)
				player_force_update
				wait(30)
			end
		#end
	optain_lose_item("ItemQuestCoconaMaid", 1)
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		tmpCoX,tmpCoY,tmpCoID=$game_map.get_storypoint("UniqueCocona")
		set_this_event_force_page(2)
		
		
		
		#get_character(0).setup_ForceCHS("-char-F-TEEN01",12)
		get_character(0).batch_cocona_setCHS("-char-F-TEEN01",12)
		
		get_character(0).moveto(tmpCoX,tmpCoY)
		get_character(0).direction = 2
		get_character(0).move_type = 0
		$game_player.moveto(tmpCoX,tmpCoY+1)
		$game_player.direction = 8
	chcg_background_color(0,0,0,255,-7)
	call_msg("CompCocona:Cocona/RecQuestCocona_9_3")

	tmpTwX,tmpTwY,tmpTwID=$game_map.get_storypoint("TavernWaifu")
	tmpCoX,tmpCoY,tmpCoID=$game_map.get_storypoint("UniqueCocona")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		$game_player.moveto(tmpTwX+1,tmpTwY+2)
		$game_player.direction = 8
		get_character(tmpTwID).moveto(tmpTwX,tmpTwY)
		get_character(tmpTwID).direction = 2
		get_character(tmpCoID).moveto(tmpTwX,tmpTwY+2)
		get_character(tmpCoID).direction = 8
	chcg_background_color(0,0,0,255,-7)
	
	
	call_msg("CompCocona:Cocona/RecQuestCocona_9_4_1")
	if $game_player.actor.stat["ManaKnowledge"] == 1
		call_msg("CompCocona:Cocona/RecQuestCocona_9_4_2_IsMage")
	else
		call_msg("CompCocona:Cocona/RecQuestCocona_9_4_2_NotMage")
	end
	call_msg("CompCocona:Cocona/RecQuestCocona_9_4_3")
	
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpCoID).moveto(tmpCoX+1,tmpCoY)
		get_character(tmpCoID).direction = 2
		$game_player.moveto(tmpTwX,tmpTwY+2)
	chcg_background_color(0,0,0,255,-7)
	optain_exp(1000*2)
	call_msg("CompCocona:Cocona/RecQuestCocona_9_5")
	optain_item($data_items[106], 1)
	
	$story_stats["RecQuestCoconaAmt"] = $game_date.dateAmt + 2
	
	
	#todo goto mama talkabout the staff-
############################################################################## b4 bath #########################################################################################################
elsif $story_stats["RecQuestCocona"] == 8 && $story_stats["UniqueCharUniqueTavernWaifu"] != -1
	$story_stats["RecQuestCocona"] = 9
	get_character(0).move_type = 1
	call_msg("CompCocona:Cocona/RecQuestCocona_8_1")
	call_msg("CompCocona:Cocona/RecQuestCocona_8_2")
	call_msg("CompCocona:Cocona/RecQuestCocona_8_3")
	get_character(0).call_balloon(6,-1)
	
############################################################################## 教導她社會常識 #########################################################################################################
elsif $story_stats["RecQuestCocona"] == 6 && $story_stats["UniqueCharUniqueTavernWaifu"] != -1
	$story_stats["RecQuestCocona"] = 7
	$story_stats["RecQuestCoconaAmt"] = $game_date.dateAmt + 2
	call_msg("CompCocona:Cocona/RecQuestCocona_7_1")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		call_msg("CompCocona:Cocona/RecQuestCocona_7_2")
	chcg_background_color(0,0,0,255,-7)
	call_msg("CompCocona:Cocona/RecQuestCocona_7_3")
	tmpTwX,tmpTwY,tmpTwID=$game_map.get_storypoint("TavernWaifu")
	tmpCoX,tmpCoY,tmpCoID=$game_map.get_storypoint("UniqueCocona")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		$game_player.moveto(tmpTwX+1,tmpTwY+2)
		$game_player.direction = 8
		get_character(tmpTwID).moveto(tmpTwX,tmpTwY)
		get_character(tmpTwID).direction = 2
		get_character(tmpCoID).moveto(tmpTwX,tmpTwY+2)
		get_character(tmpCoID).direction = 8
	chcg_background_color(0,0,0,255,-7)
	
	call_msg("CompCocona:Cocona/RecQuestCocona_7_4")
	
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpCoID).moveto(tmpCoX+1,tmpCoY)
		get_character(tmpCoID).direction = 2
		$game_player.moveto(tmpTwX,tmpTwY+2)
	chcg_background_color(0,0,0,255,-7)
	optain_exp(2000*2)
	$game_player.actor.sat += 100
	call_msg("CompCocona:Cocona/RecQuestCocona_7_5")
	optain_item($data_items[49], 3)
	
############################################################################## 出遊 #########################################################################################################
elsif $story_stats["RecQuestCocona"] == 11 && $story_stats["UniqueCharUniqueTavernWaifu"] != -1 && $game_date.day?
	$story_stats["RecQuestCocona"] = 12
	call_msg("CompCocona:Cocona/RecQuestCocona_11_1")
	call_msg("CompCocona:Cocona/RecQuestCocona_11_2")
	
############################################################################## cocona offer food if lona is too weak
elsif $game_player.actor.weak > 100 && tmpMamaThere
	#################################################Lona太弱  給食物
	call_msg("CompCocona:Cocona/CompCommand")
	call_msg("CompCocona:Cocona/TavernHelpDot0")
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food3")
	if $game_date.dateAmt > $story_stats["CoconaFoodSupport"]
		$story_stats["CoconaFoodSupport"] = $game_date.dateAmt
		get_character(0).npc_story_mode(true)
		tmpPrevMoveType = get_character(0).move_type
		get_character(0).move_type = 0
		call_msg("CompCocona:Cocona/TavernHelp_pass0")
		call_msg("CompCocona:Cocona/TavernHelpDot1")
		call_msg("CompCocona:Cocona/RecQuestCocona_12_food3")
		portrait_hide
		get_character(0).call_balloon(8)
		wait(60)
		get_character(0).animation = get_character(0).animation_atk_sh
		wait(5)
		optain_item($data_items[49],1) #ItemSopGood
		wait(30)
		$game_player.call_balloon(8)
		wait(60)
		$game_player.call_balloon(8)
		wait(60)
		call_msg("CompCocona:Cocona/TavernHelp_pass1")
		get_character(0).jump_to(get_character(0).x,get_character(0).y)
		call_msg("CompCocona:Cocona/TavernHelp_pass2")
		get_character(0).npc_story_mode(false)
		get_character(0).move_type = tmpPrevMoveType
		return eventPlayEnd
		
	else #已給過食物  被MAMA趕出去
		call_msg("CompCocona:Cocona/TavernHelp_failed0")
		portrait_hide
		if tmpMamaThere
			user=get_character(tmpMamaID)
			tgt=$game_player
			get_character(tmpMamaID).npc_story_mode(true)
				get_character(tmpMamaID).animation = nil
				get_character(tmpMamaID).move_type = 0
				get_character(tmpMamaID).combat_jump_to_target(user,tgt)
				get_character(tmpMamaID).opacity = 255
				wait(60)
				get_character(tmpMamaID).turn_toward_character(tgt)
				$game_player.turn_toward_character(get_character(tmpMamaID))
				call_msg("CompCocona:Cocona/MamaKickOut0")
				call_msg("TagMapNoerTavern:Waifu/WorkFailed3")
				portrait_off
			get_character(tmpMamaID).npc_story_mode(false)
			whole_event_end
		end
		change_map_leave_tag_map
		return eventPlayEnd
	end
else
	tmpMaid = $game_map.interpreter.cocona_maid? ? 1 : 0
	tmpMaidText =  $game_map.interpreter.cocona_maid? ? "Maid" : ""
	tmpDailyBuff = $game_date.dateAmt > $story_stats["RecQuestCoconaDailyBuffAmt"]
	tmpTellCoconaLeave = $story_stats["RecQuestCocona"] == 23 && $story_stats["UniqueCharUniqueTavernWaifu"] != -1 && $game_date.dateAmt >= $story_stats["RecQuestCoconaAmt"]
	if [24,25].include?($story_stats["RecQuestCocona"])
		call_msg("CompCocona:Cocona/RecQuestCocona24_Common#{rand(3)}")
	elsif $story_stats["RecQuestCocona"] == 12
		call_msg("CompCocona:Cocona/RecQuestCocona_11_NotInGroup")
	elsif $game_date.day?
		call_msg("CompCocona:Cocona/KnownBegin")
	else
		call_msg("CompCocona:Cocona/KnownBegin_night#{rand(3)}")
	end
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]					,"Cancel"]
	tmpTarList << [$game_text["commonComp:Companion/TeamUp"]				,"TeamUp"]		if !["UniqueCoconaMaid","UniqueCocona"].include?($game_player.record_companion_name_back)
	tmpTarList << [$game_text["commonComp:Companion/Disband"]				,"Disband"]		if ["UniqueCoconaMaid","UniqueCocona"].include?($game_player.record_companion_name_back)
	tmpTarList << [$game_text["CompCocona:Cocona/ChangeDress"]				,"ChangeDress"]	if $story_stats["RecQuestCocona"] >= 28 && ["UniqueCoconaMaid","UniqueCocona"].include?($game_player.record_companion_name_back)
	tmpTarList << [$game_text["CompCocona:cocona/RecQuestCocona_23to24_OPT"],"OptQuest23"]	if tmpTellCoconaLeave
	tmpTarList << [$game_text["CompCocona:Cocona/OptHeadPat"]				,"OptHeadPat"]	if $game_date.night? && $story_stats["RecQuestCocona"] >= 10 && tmpDailyBuff
	tmpTarList << [$game_text["CompCocona:Cocona/OptBath"]					,"OptBath"]		if $game_date.day? && $story_stats["RecQuestCocona"] >= 10 && tmpDailyBuff && $story_stats["RecQuestCoconaDailyBuff"] >= 3
	tmpTarList << [$game_text["CompCocona:Cocona/OptSleep"]					,"OptSleep"]	if $game_date.day? && $story_stats["RecQuestCocona"] >= 10 && tmpDailyBuff && $story_stats["RecQuestCoconaDailyBuff"] >= 6 && $story_stats["UniqueCharUniqueTavernWaifu"] != -1 && [-1,1].include?($story_stats["RecQuestCoconaVagTaken"])
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("CompCocona:Cocona/BasicOpt",0,2,0) if ![24,25].include?($story_stats["RecQuestCocona"])
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
	
	case tmpPicked
		when 0,-1
		when "TeamUp"
			tmpCompData = 6+tmpMaid*2 + $story_stats["RecQuestCoconaBuryMama"]*2 + $story_stats["RecQuestCoconaBuryPapa"]*2 +$story_stats["RecQuestCoconaDailyBuff"] +$story_stats["RecQuestCoconaDefeatBossMama"]*2
			tmpCompData < 20 ? $story_stats["HiddenOPT0"] = tmpCompData*0.5 : $story_stats["HiddenOPT0"] = "NIL"
			if $game_map.interpreter.cocona_maid?
				$game_NPCLayerMain.stat["Cocona_Dress"] = "Maid"
				$story_stats["HiddenOPT1"] = $game_text["DataNpcName:fraction/nature"]
			else
				$game_NPCLayerMain.stat["Cocona_Dress"] = "Necro"
				$story_stats["HiddenOPT1"] = $game_text["DataNpcName:fraction/evil"]
			end
			call_msg("CompCocona:Cocona/CompData")
			show_npc_info(get_character(0),extra_info=false,"commonComp:Companion/Accept")	#\optD[算了，確定]
			if $game_temp.choice == 1
					call_msg("CompCocona:Cocona/Comp_win")
					if tmpCompData < 20
						get_character(0).set_this_event_companion_back("UniqueCocona#{tmpMaidText}",false,$game_date.dateAmt+tmpCompData)
					else
						get_character(0).set_this_event_companion_back("UniqueCocona#{tmpMaidText}",false,nil)
					end
			end
		when "Disband"
			call_msg("commonComp:Companion/Accept") 			#\optD[算了，確定]
				case $game_temp.choice
					when 0,-1
					when 1
						call_msg("CompCocona:Cocona/Comp_disband")
						$game_player.record_companion_name_back = nil
						$game_player.record_companion_back_date = nil
				end
				
		when "ChangeDress"
			if $game_player.record_companion_name_back == "UniqueCocona"
				call_msg("CompCocona:Cocona/ChangeDress_maid")
				$game_player.record_companion_name_back = "UniqueCoconaMaid"
				$game_NPCLayerMain.stat["Cocona_Dress"] = "Maid"
			elsif $game_player.record_companion_name_back == "UniqueCoconaMaid"
				call_msg("CompCocona:Cocona/ChangeDress_necro")
				$game_player.record_companion_name_back = "UniqueCocona"
				$game_NPCLayerMain.stat["Cocona_Dress"] = "Necro"
			end
			
		when "OptQuest23"
			tmpCoX,tmpCoY,tmpCoID = $game_map.get_storypoint("UniqueCocona")
			tmpCoconaBedX,tmpCoconaBedY,tmpCoconaBedID = $game_map.get_storypoint("CoconaBed")
			tmpWaifuX,tmpWaifuY,tmpWaifuID = $game_map.get_storypoint("TavernWaifu")
			tmpSexPoint2X,tmpSexPoint2Y,tmpSexPoint2ID = $game_map.get_storypoint("SexPoint2")
			$story_stats["RecQuestCocona"] = 24
			call_msg("CompCocona:cocona/RecQuestCocona_23to24_1")
			call_msg("CompCocona:cocona/RecQuestCocona_23to24_2")
			portrait_hide
			2.times{
				$game_player.call_balloon(8)
				wait(60)
			}
			call_msg("CompCocona:cocona/RecQuestCocona_23to24_3")
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				portrait_off
				get_character(tmpWaifuID).npc_story_mode(true)
				tmpWaifuO_M = get_character(tmpWaifuID).move_type
				get_character(tmpWaifuID).move_type = 0
				get_character(tmpWaifuID).direction = 6
				get_character(tmpWaifuID).moveto(tmpCoconaBedX-2,tmpCoconaBedY+1)
				get_character(0).moveto(tmpCoconaBedX-1,tmpCoconaBedY)
				$game_player.moveto(tmpCoconaBedX-1,tmpCoconaBedY+1)
				#get_character(tmpWaifuID).item_jump_to
				#SndLib.sys_DoorLock
				get_character(tmpWaifuID).turn_toward_character($game_player)
				get_character(0).turn_toward_character(get_character(tmpWaifuID))
				get_character(0).turn_toward_character(get_character(tmpWaifuID))
				$game_player.turn_toward_character(get_character(tmpWaifuID))
				wait(30)
			chcg_background_color(0,0,0,255,-7)
			call_msg("CompCocona:cocona/RecQuestCocona_23to24_4")
			get_character(0).turn_toward_character(get_character(tmpWaifuID))
			get_character(tmpWaifuID).turn_toward_character(get_character(0))
			call_msg("CompCocona:cocona/RecQuestCocona_23to24_5")
			portrait_hide
			get_character(tmpWaifuID).call_balloon(8)
			wait(60)
			get_character(tmpWaifuID).call_balloon(8)
			wait(60)
			get_character(tmpWaifuID).turn_toward_character($game_player)
			call_msg("CompCocona:cocona/RecQuestCocona_23to24_6")
			call_msg("CompCocona:cocona/RecQuestCocona_23to24_7")
			call_msg("CompCocona:cocona/RecQuestCocona_23to24_8")
			portrait_hide
			cam_center(0)
			1.times{
				get_character(tmpWaifuID).direction = 4 ; get_character(tmpWaifuID).move_forward_force
				get_character(tmpWaifuID).move_speed = 2.8
				until !get_character(tmpWaifuID).moving? ; wait(1) end
			}
			2.times{
				get_character(tmpWaifuID).direction = 2 ; get_character(tmpWaifuID).move_forward_force
				get_character(tmpWaifuID).move_speed = 2.8
				until !get_character(tmpWaifuID).moving? ; wait(1) end
			}
			until get_character(tmpWaifuID).opacity <= 0
				get_character(tmpWaifuID).opacity -= 5
				wait(1)
			end
			call_msg("CompCocona:cocona/RecQuestCocona_23to24_8_1")
			portrait_hide
				portrait_off
 				cam_center(0)
				get_character(tmpWaifuID).opacity = 255
				get_character(tmpWaifuID).move_type = tmpWaifuO_M
				get_character(tmpWaifuID).npc_story_mode(false)
				get_character(tmpWaifuID).moveto(tmpWaifuX,tmpWaifuY)
				get_character(tmpWaifuID).direction = 2
				#get_character(tmpWaifuID).call_balloon(28,-1)
				get_character(0).turn_toward_character($game_player)
				$game_player.turn_toward_character(get_character(0))
			call_msg("CompCocona:cocona/RecQuestCocona_23to24_9")
			call_msg("CompCocona:cocona/RecQuestCocona_23to24_EndBRD")
			if $story_stats["RecQuestCoconaVagTaken"] >= 2 #若cocona非處  且認知為賺錢
				call_msg("CompCocona:cocona/RecQuestCocona_23to24_10_Cocona_whore")
			else
				call_msg("CompCocona:cocona/RecQuestCocona_23to24_10_Cocona_virgin")
			end
			call_msg("CompCocona:cocona/RecQuestCocona_23to24_EndBRD")
			
			
			
		when "OptHeadPat"
			tmpPrevMoveType = get_character(0).move_type
			get_character(0).npc_story_mode(true)
			get_character(0).move_type = 0
			get_character(0).jump_to(get_character(0).x,get_character(0).y)
			if $story_stats["RecQuestCoconaDailyBuff"] == 0
				call_msg("CompCocona:Cocona/HeatPatA_1")
				load_script("Data/HCGframes/event/HevCoconaHeadPat.rb")
			else
				call_msg("CompCocona:Cocona/HeatPatB_1")
				load_script("Data/HCGframes/event/HevCoconaHeadPatAgain.rb")
			end
			$game_player.actor.mood += 200
			wait(20)
			get_character(0).jump_to(get_character(0).x,get_character(0).y)
			call_msg("CompCocona:Cocona/HeatPat_End")
			get_character(0).npc_story_mode(false)
			get_character(0).move_type = tmpPrevMoveType
			optain_state(183,2) #DailyPlusMood
			$story_stats["RecQuestCoconaDailyBuffAmt"] = $game_date.dateAmt
			$story_stats["RecQuestCoconaDailyBuff"] += 1 if $story_stats["RecQuestCoconaDailyBuff"] < 3
			$story_stats["RecCoconaHeadPat"] += 1
			GabeSDK.setAchievementStat("RecCoconaHeadPat",$story_stats["RecCoconaHeadPat"])
			
		when "OptBath"
			tmpPrevMoveType = get_character(0).move_type
			get_character(0).npc_story_mode(true)
			get_character(0).move_type = 0
			get_character(0).jump_to(get_character(0).x,get_character(0).y)
			if $story_stats["RecQuestCoconaDailyBuff"] == 3
				call_msg("CompCocona:Cocona/BathAgainA_1")
				load_script("Data/HCGframes/event/HevCoconaBathAgain.rb")
				4.times{load_script("Data/Batch/Command_Bath.rb")}
				call_msg("CompCocona:Cocona/BathAgainA_END")
			else
				call_msg("CompCocona:Cocona/BathAgainB_1")
				load_script("Data/HCGframes/event/HevCoconaBathAgain.rb")
				4.times{load_script("Data/Batch/Command_Bath.rb")}
			end
			wait(20)
			chcg_background_color_off
			get_character(0).jump_to(get_character(0).x,get_character(0).y)
			call_msg("CompCocona:Cocona/HeatPat_End")
			get_character(0).npc_story_mode(false)
			get_character(0).move_type = tmpPrevMoveType
			optain_state(182,2) #DailyPlusHealthy
			$story_stats["RecQuestCoconaDailyBuffAmt"] = $game_date.dateAmt
			$story_stats["RecQuestCoconaDailyBuff"] += 1 if $story_stats["RecQuestCoconaDailyBuff"] < 6
			$story_stats["RecCoconaBath"] += 1
			GabeSDK.setAchievementStat("RecCoconaBath",$story_stats["RecCoconaBath"])
			
		when "OptSleep"
			tmpBedX,tmpBedY,tmpBedID=$game_map.get_storypoint("CoconaBed")
			tmpPrevMoveType = get_character(0).move_type
			get_character(0).npc_story_mode(true)
			get_character(0).move_type = 0
			get_character(0).jump_to(get_character(0).x,get_character(0).y)
			call_msg("CompCocona:Cocona/SleepTogeter_1")
			if $story_stats["RecQuestCoconaDailyBuff"] == 6
				call_msg("CompCocona:Cocona/SleepTogeterA_1")
			else
				call_msg("CompCocona:Cocona/SleepTogeterB_1")
			end
			get_character(0).npc_story_mode(false)
			get_character(0).move_type = tmpPrevMoveType
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				portrait_off
				$game_player.moveto(tmpBedX,tmpBedY)
				$game_player.direction = 4
				$game_player.transparent = true
				get_character(0).moveto(1,1)
				set_event_force_page(tmpBedID,3)
				get_character(tmpBedID).manual_cw = 1 #canvas witdh(how many item in this PNG's witdh)
				get_character(tmpBedID).manual_ch = 1 #canvas height(how many item in this PNG's height)
				get_character(tmpBedID).pattern = 0 #force 0 because only 1x1
				get_character(tmpBedID).direction = 2 #force to 2 because only 1x1
				get_character(tmpBedID).character_index =0 #force 0 because only 1x1
				if ["Deepone","Moot"].include?($game_player.actor.stat["Race"])
					get_character(tmpBedID).character_name = "LonaEXT/LonaMootCoconaBed.png"
				else
					get_character(tmpBedID).character_name = "LonaEXT/LonaCoconaBed.png"
				end
				get_character(tmpBedID).chs_need_update=true
				cam_follow(tmpBedID,0)
			chcg_background_color(0,0,0,255,-7)
			call_msg("CompCocona:Cocona/SleepTogeter_2_pure") if $story_stats["RecQuestCoconaVagTaken"] <= 1
			call_msg("CompCocona:Cocona/SleepTogeter_2_vagTak") if $story_stats["RecQuestCoconaVagTaken"] >= 2
			$game_party.gain_item($data_items[106],1) #ItemNoerTavernNapKey
			$story_stats["RecQuestCoconaDailyBuffAmt"] = $game_date.dateAmt
			$story_stats["RecQuestCoconaDailyBuff"] += 1 if $story_stats["RecQuestCoconaDailyBuff"] < 9
			$story_stats["RecCoconaSleep"] += 1
			load_script("Data/HCGframes/Command_Nap.rb")
			GabeSDK.setAchievementStat("RecCoconaSleep",$story_stats["RecCoconaSleep"])
			#handle nap here
	end #case
end

eventPlayEnd

# check balloon
#出遊
tmpQ1 = $story_stats["RecQuestCocona"] == 11 && $game_date.day?
tmpQ2 = $story_stats["UniqueCharUniqueTavernWaifu"] != -1
return get_character(0).call_balloon(28,-1) if tmpQ1 && tmpQ2
#出遊2
tmpQ1 = $story_stats["RecQuestCocona"] == 12 && $game_date.day?
tmpQ3 = $game_player.record_companion_name_back != "UniqueCoconaMaid"
return get_character(0).call_balloon(28,-1) if tmpQ1 && tmpQ2 && tmpQ3
#姐姐不要走 begin
tmpQ1 = $story_stats["RecQuestCocona"] == 23
tmpQ2 = $story_stats["UniqueCharUniqueTavernWaifu"] != -1
tmpQ3 = $game_date.dateAmt >= $story_stats["RecQuestCoconaAmt"]
return  get_character(0).call_balloon(28,-1) if tmpQ1 && tmpQ2 && tmpQ3
