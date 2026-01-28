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
	manual_barters("RelayEmp_DoomFortressL")
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
