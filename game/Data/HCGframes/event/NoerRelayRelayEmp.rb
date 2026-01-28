if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

call_msg("DataRelay:RelayEMP/Welcome#{rand(2)}")
$game_temp.choice = -1
tmpGotoTar = ""
tmpTarList = []
tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"]
#tmpTarList << [$game_text["DataNpcName:name/HorseCarry"]			,"HorseCarry"] if $game_player.record_companion_name_ext != "CompHorseCarry"
cmd_sheet = tmpTarList
cmd_text =""
for i in 0...cmd_sheet.length
	cmd_text.concat(cmd_sheet[i].first+",")
end
cam_center(0) ; $game_player.call_balloon(8)
call_msg("DataRelay:RelayEMP/opt",0,2,0)
call_msg("\\optB[#{cmd_text}]")
$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
$game_temp.choice = -1

case tmpPicked
	when "Barter"
		if $game_player.player_slave?
			call_msg("DataRelay:RelayEMP/SlaveBlock")
			return eventPlayEnd
		end
		manual_barters("RelayEmp_Noer")
		
		
	when "HorseCarry"
		tpNeed = 100
		$story_stats["HiddenOPT1"] = tpNeed
		call_msg("commonComp:CompHorseCarry/CompData")
		$story_stats["HiddenOPT1"] = "0"
		call_msg("common:Lona/Decide_optB")
		set_comp=false
		if $game_temp.choice ==1 && $game_player.record_companion_name_ext == nil
			set_comp = true
		elsif $game_temp.choice ==1 && $game_player.record_companion_name_ext != nil
			$game_temp.choice = -1
			call_msg("commonComp:notice/ExtOverWrite")
			call_msg("common:Lona/Decide_optD")
			if $game_temp.choice ==1
				set_comp = true
			else
				return eventPlayEnd
			end
		else
			return eventPlayEnd
		end
		$game_boxes.box(System_Settings::STORAGE_TEMP).clear
		SceneManager.goto(Scene_ItemStorage)
		SceneManager.scene.prepare(System_Settings::STORAGE_TEMP)
		wait(1)
		tmpPP = $game_boxes.get_price(System_Settings::STORAGE_TEMP)
		$game_boxes.box(System_Settings::STORAGE_TEMP).clear
		dateAmt = tmpPP/tpNeed
		return eventPlayEnd if dateAmt < 1
		if set_comp
			chcg_background_color(0,0,0,0,7)
				$story_stats["RecQuestConvoyTarget"] = [21,22] #Inside Noer
				$game_boxes.box(System_Settings::STORAGE_HORSE_CARRY).clear
				get_character(0).set_this_event_companion_ext(temp_name="CompHorseCarry",false,dateAmt)
				EvLib.sum("CompHorseCarry",$game_player.x,$game_player.y)
				SndLib.horseDed
				#get_character(0).delete ############################################################################################## if for relay
			chcg_background_color(0,0,0,255,-7)
		end
end

if $game_party.has_item_type("TravelTricket")
	tmpToWhere = $game_party.item_has_common_tag_and_report("TravelTricketTo")
	$game_party.lost_item_type("TravelTricket")
	############################################################################ TARGET LIST2
	return if tmpToWhere == ""
	call_msg("\\{\\narr#{$game_text["DataItem:To#{tmpToWhere}/item_name"]}")
	tmpToWhere = "NoerDockOut" if tmpToWhere == "NoerDock" && !$game_party.has_item_type("NoerPassport")
	tmpToWhere = "NoerRelay" if tmpToWhere == "NoerRelayOut" && !$game_party.has_item_type("NoerPassport")
	SndLib.sound_equip_armor
	$game_map.popup(0,"",$data_items[282].icon_index,-1)
	wait(40)
	portrait_hide
	chcg_background_color(0,0,0,0,4)
	portrait_off
	SndLib.horseDed
	wait(40)
	$story_stats["OverMapForceTrans"] = tmpToWhere
	$story_stats["OverMapForceTransStay"] = 1
	change_map_leave_tag_map
	############################################################################ TARGET LIST2 END
end
eventPlayEnd
