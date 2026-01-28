if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if get_character(0).summon_data == nil
 get_character(0).set_summon_data({:SexTradeble => true})
elsif get_character(0).summon_data[:SexTradeble] == nil
 get_character(0).summon_data[:SexTradeble] = true
end


tmpData=[[6,0+get_character(0).direction_offset,0,-5,0]]
get_character(0).animation = get_character(0).aniCustom(tmpData,-1)

	call_msg("commonComp:CompWarSister/begin")
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonComp:Companion/TeamUp"]			,"TeamUp"]  if $game_player.record_companion_name_front != "CompWarSister"
	tmpTarList << [$game_text["commonComp:Companion/Disband"]			,"Disband"] if $game_player.record_companion_name_front == "CompWarSister"
	tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"]
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
		get_character(0).animation = nil
		call_msg("commonComp:CompWarSister/CompData")
		show_npc_info(get_character(0),extra_info=false,"commonComp:Companion/Accept") 			#\optD[算了，確定]
		case $game_temp.choice
			when 0,-1
			when 1
				if $game_player.actor.weak >= 100
					call_msg("commonComp:CompWarSister/Weak_failed")
					return eventPlayEnd
				elsif $game_party.item_number($data_items[135]) >=1 #HolyWaterx1
					optain_lose_item($data_items[135],1)
					get_character(0).set_this_event_companion_front("CompWarSister",false,$game_date.dateAmt+10)
					call_msg("commonComp:CompWarSister/Comp_win")
					return eventPlayEnd
				else
					call_msg("commonComp:CompWarSister/Comp_failed")
					return eventPlayEnd
				end
		end
	when "Disband"
		call_msg("commonComp:Companion/Accept") 			#\optD[算了，確定]
			case $game_temp.choice
				when 0,-1
				when 1
					call_msg("commonComp:CompWarSister/Comp_disband")
					get_character(0).set_this_companion_disband(false)
					return eventPlayEnd
			end
			
	when "Barter"
		manual_barters("SouthFL_INNCompWarSister")
	end

call_msg("commonComp:CompWarSister/End")
tmpData=[[6,0+get_character(0).direction_offset,0,-5,0]]
get_character(0).animation = get_character(0).aniCustom(tmpData,-1)
eventPlayEnd
