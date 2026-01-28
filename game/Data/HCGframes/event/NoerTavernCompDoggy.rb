if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

get_character(0).animation = nil
SndLib.dogSpot
	call_msg("commonComp:CompDoggy/begin")
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonComp:Companion/TeamUp"]			,"TeamUp"]  if $game_player.record_companion_name_front != "CompDoggy"
	tmpTarList << [$game_text["commonComp:Companion/Disband"]			,"Disband"] if $game_player.record_companion_name_front == "CompDoggy"
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
	
	case tmpPicked
	when "TeamUp"
		call_msg("commonComp:CompDoggy/CompData")
		show_npc_info(get_character(0),extra_info=false,"commonComp:Companion/Accept") 			#\optD[算了，確定]
		case $game_temp.choice
			when 0,-1
			when 1
				if $game_party.item_number($data_items[42]) >=1 #肉湯
					optain_lose_item($data_items[42],1)
					get_character(0).set_this_event_companion_front("CompDoggy",false,nil)
					SndLib.dogSpot
					call_msg("commonComp:CompDoggy/Comp_win")
				else
					SndLib.dogAtk
					call_msg("commonComp:CompDoggy/Comp_failed")
				end
		end
	when "Disband"
		call_msg("commonComp:Companion/Accept") 			#\optD[算了，確定]
			case $game_temp.choice
				when 0,-1
				when 1
					SndLib.dogHurt
					call_msg("commonComp:CompDoggy/Comp_disband")
					get_character(0).set_this_companion_disband(false)
			end
	end
	
SndLib.dogSpot
eventPlayEnd
