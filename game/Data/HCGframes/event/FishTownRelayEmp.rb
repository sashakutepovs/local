if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if $game_player.actor.stat["SlaveBrand"] == 1
	call_msg("DataRelay:RelayEMPfish/SlaveAccept")
else
	call_msg("DataRelay:RelayEMPfish/Welcome#{rand(2)}")
end
call_msg("CompElise:FishResearch1/NoerDockSP") if $game_player.record_companion_name_ext == "CompExtUniqueElise" && $story_stats["RecQuestElise"] == 17
$game_temp.choice = -1
tmpGotoTar = ""
tmpTarList = []
tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"]
tmpTarList << [$game_text["DataItem:ToNoerDock/item_name"]			,"RecQuestElise17"] if $game_player.record_companion_name_ext == "CompExtUniqueElise" && $story_stats["RecQuestElise"] == 17
tmpTarList << [$game_text["commonNPC:commonNPC/Slave"]				,"Slave"] if $game_player.actor.stat["SlaveBrand"] == 1
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
	if $game_player.actor.stat["SlaveBrand"] == 1
		$story_stats["SlaveOwner"] = "FishTownR"
		call_msg("DataRelay:RelayEMPfish/SlaveBlock")
		return eventPlayEnd
	end

	manual_barters("RelayEmp_FishTown")

when "RecQuestElise17"
	tmpX,tmpY=$game_map.get_storypoint("RelayTrader")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(0).moveto(tmpX,tmpY)
		get_character(0).direction = 2
		$game_player.moveto(tmpX-1,tmpY+2)
		$game_player.direction = 8
		get_character($game_player.get_followerID(-1)).moveto(tmpX,tmpY+2)
		get_character($game_player.get_followerID(-1)).direction = 8
	chcg_background_color(0,0,0,255,-7)
	get_character($game_player.get_followerID(-1)).call_balloon(20)
	wait(20)
	get_character(0).call_balloon(20)
	wait(40)
	$game_player.call_balloon(8)
	wait(60)
	$game_player.direction = 6
	get_character($game_player.get_followerID(-1)).direction = 4
	get_character($game_player.get_followerID(-1)).npc_story_mode(true)
	get_character($game_player.get_followerID(-1)).animation = get_character($game_player.get_followerID(-1)).animation_atk_sh
	optain_item($data_items[286],1) #ToNoerDock
	wait(60)
	get_character($game_player.get_followerID(-1)).npc_story_mode(false)
	
when "Slave"
	tmpSlave = ($game_player.player_slave? || $game_player.actor.weak >= 30)
	if !tmpSlave
		call_msg("TagMapNoerDock:SlaveDealer/Talk_failed")
		return eventPlayEnd
	end
	$story_stats["SlaveOwner"] = "FishTownR"
	$story_stats["OverMapForceTrans"] = "FishTownR"
	load_script("Data/Batch/Put_BondageItemsON.rb") #上銬批次檔
	$story_stats["dialog_collar_equiped"] =0
	rape_loop_drop_item(false,false)
	call_msg("TagMapBanditCamp1:Trans/begin2")
	#傳送主角至定點
	$game_player.move_normal
	$game_player.actor.sta = -99 if $game_player.actor.sta <= -99
	wait(20)
	portrait_hide
	chcg_background_color(0,0,0,0,4)
	portrait_off
	SndLib.me_play("ME/SeaWaves")
	wait(40)
	change_map_leave_tag_map
	$story_stats["Captured"] = 1
	SndLib.sound_equip_armor(125)
	return eventPlayEnd
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
	SndLib.me_play("ME/SeaWaves")
	wait(40)
	$story_stats["OverMapForceTrans"] = tmpToWhere
	$story_stats["OverMapForceTransStay"] = 1
	change_map_leave_tag_map
	############################################################################ TARGET LIST2 END
end
eventPlayEnd
