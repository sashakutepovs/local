if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
portrait_hide
get_character(0).call_balloon(0)

tmpEliseX,tmpEliseY,tmpEliseID=$game_map.get_storypoint("elise")
tmpEliseTarX,tmpEliseTarY,tmpEliseTarID=$game_map.get_storypoint("EliseTar")
tmpGoblinTarX,tmpGoblinTarY,tmpGoblinTarID=$game_map.get_storypoint("GoblinTar")
tmpBabyX,tmpBabyY,tmpBabyID=$game_map.get_storypoint("OrkindBaby")
tmpPeeTreeX,tmpPeeTreeY,tmpPeeTreeID=$game_map.get_storypoint("peeTree")


if $story_stats["RecQuestElise"] ==2
	call_msg("CompElise:RecQuestElise2/DrinkWater")
	if $game_temp.choice == 1
		call_msg("CompElise:RecQuestElise2/optNo")
		get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],420)
		return portrait_hide
	end
	$game_player.actor.urinary_level = 500
	call_msg("CompElise:RecQuestElise2/DrinkWater_optYes")
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			get_character($game_player.get_followerID(0)).moveto(1,1) if $game_player.get_followerID(0) != nil && $game_player.record_companion_name_back != nil
			get_character($game_player.get_followerID(1)).moveto(1,1) if $game_player.get_followerID(1) != nil && $game_player.record_companion_name_front != nil
			$game_player.moveto(tmpPeeTreeX+1,tmpPeeTreeY)
			$game_player.direction = 4
			get_character(0).moveto(tmpPeeTreeX+1,tmpPeeTreeY+1)
			get_character(0).direction = 8
		chcg_background_color(0,0,0,255,-7)
	call_msg("CompElise:RecQuestElise2/DoPeePee")
	if $game_temp.choice == 1
		call_msg("CompElise:RecQuestElise2/optNo")
		get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],420)
		return portrait_hide
	else
		call_msg("CompElise:RecQuestElise2/DoPeePee_OptYes")
		##################################################################################### PEE ##################################################################################################
		$game_portraits.lprt.hide
			temp_vag_cums =$game_player.actor.cumsMeters["CumsCreamPie"]
			temp_anal_cums =$game_player.actor.cumsMeters["CumsMoonPie"]
			temp_groin_cums = $game_player.actor.cumsMeters["CumsCreamPie"] + $game_player.actor.cumsMeters["CumsMoonPie"]
			temp_milk_level = $game_player.actor.lactation_level
			$game_player.actor.urinary_level >=300 || $game_player.actor.defecate_level >=300		? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
			temp_groin_cums >=1																? $story_stats["HiddenOPT2"] = "1" : $story_stats["HiddenOPT2"] = "0"
			temp_milk_level >=300															? $story_stats["HiddenOPT3"] = "1" : $story_stats["HiddenOPT3"] = "0"
			

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
		
			$story_stats["dialog_dress_out"] = 0
			chcg_background_color(0,0,0,0,7)
			
			if equips_MidExt_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("MidExt", nil)
				SndLib.sound_equip_armor(125)
				player_force_update
				wait(30)
			end
			if equips_Bot_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("Bot", nil)
				SndLib.sound_equip_armor(125)
				player_force_update
				wait(30)
			end
			if equips_Vag_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("Vag", nil)
				SndLib.sound_equip_armor(100)
				player_force_update
				wait(30)
			end
			
			call_msg("CompElise:RecQuestElise2/DoPeePeeExt1")
			
			load_script("Data/HCGframes/Command_Pee.rb")
			chcg_background_color(0,0,0,255,-7)
			
			Audio.se_stop
			
			call_msg("CompElise:RecQuestElise2/DoPeePeeExt2")
			
			#if !Input.press?(:SHIFT)
				if equips_Vag_id != -1#檢查裝備 並穿裝
					$game_player.actor.change_equip("Vag", $data_ItemName[equips_Vag_id])
					SndLib.sound_equip_armor(100)
					player_force_update
					wait(30)
				end
				if equips_Bot_id != -1#檢查裝備 並穿裝
					$game_player.actor.change_equip("Bot", $data_ItemName[equips_Bot_id])
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
			#end
		##################################################################################### PEE END ##################################################################################################
	end
	call_msg("CompElise:RecQuestElise2/DoPeePeeExt3")
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			$game_player.moveto(tmpEliseTarX+1,tmpEliseTarY)
			$game_player.direction = 2
			set_event_force_page(tmpEliseID,1)
			get_character(0).moveto(tmpEliseTarX,tmpEliseTarY)
			get_character(0).direction = 2
			get_character(0).move_type = 0
			get_character($game_player.get_followerID(0)).moveto(tmpEliseTarX+2,tmpEliseTarY) if $game_player.get_followerID(0) != nil
			get_character($game_player.get_followerID(1)).moveto(tmpEliseTarX+3,tmpEliseTarY) if $game_player.get_followerID(1) != nil
			get_character($game_player.get_followerID(0)).process_npc_DestroyForceRoute if $game_player.get_followerID(0) != nil && $game_player.record_companion_name_back != nil
			get_character($game_player.get_followerID(1)).process_npc_DestroyForceRoute if $game_player.get_followerID(1) != nil && $game_player.record_companion_name_front != nil
			get_character($game_player.get_followerID(0)).npc.process_target_lost if $game_player.get_followerID(0) != nil && $game_player.record_companion_name_back != nil
			get_character($game_player.get_followerID(1)).npc.process_target_lost if $game_player.get_followerID(1) != nil && $game_player.record_companion_name_front != nil
			get_character($game_player.get_followerID(0)).direction = 2 if $game_player.get_followerID(0) != nil && $game_player.record_companion_name_back != nil
			get_character($game_player.get_followerID(1)).direction = 2 if $game_player.get_followerID(1) != nil && $game_player.record_companion_name_front != nil
		chcg_background_color(0,0,0,255,-7)	
	call_msg("CompElise:RecQuestElise2/DoHide0")
	
	
	$game_map.npcs.each do |event| 
		next unless event.summon_data
		next unless event.summon_data[:Walker]
		event.npc_story_mode(true)
		event.moveto(tmpGoblinTarX,tmpGoblinTarY)
		event.move_type =3
	end
	call_msg("CompElise:RecQuestElise2/DoHide1")
	call_msg("CompElise:RecQuestElise2/DoHide2") ; portrait_hide
	cam_center(0)
	get_character(tmpEliseID).call_balloon(8)
	wait(60)
	call_msg("CompElise:RecQuestElise2/DoHide3") ; portrait_hide
	get_character(tmpBabyID).npc_story_mode(true)
	get_character(tmpBabyID).moveto(tmpGoblinTarX,tmpGoblinTarY)
	get_character(tmpBabyID).move_type =3
	call_msg("CompElise:RecQuestElise2/DoHide3_1") ; portrait_hide
	wait(120)
	call_msg("CompElise:RecQuestElise2/DoHide4")

	# ROLL BACK  and ready to combat
	$game_map.npcs.each do |event| 
		next unless event.summon_data
		next unless event.summon_data[:Walker]
		event.npc_story_mode(false)
	end
	get_character(tmpBabyID).call_balloon(28,-1)
	get_character(tmpBabyID).npc_story_mode(false)
	$story_stats["RecQuestElise"] =3
	SndLib.bgm_play("D/Hidden Assault LOOP",90,100)
	get_character(tmpEliseID).process_npc_DestroyForceRoute
	get_character(tmpEliseID).npc.process_target_lost


elsif $story_stats["RecQuestElise"] ==3 && !$game_party.has_item?($data_items[107])
	SndLib.sound_QuickDialog
	$game_map.popup(get_character(0).id,"CompElise:RecQuestElise3/Qmsg",0,0)
	get_character(tmpBabyID).call_balloon(28,-1)
end


$game_temp.choice = -1 ; portrait_hide
