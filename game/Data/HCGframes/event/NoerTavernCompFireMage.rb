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
	call_msg("commonComp:CompFireMage/begin")
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonComp:Companion/TeamUp"]			,"TeamUp"]  if $game_player.record_companion_name_back != get_character(0).name && !$game_player.player_slave?
	tmpTarList << [$game_text["commonComp:Companion/Disband"]			,"Disband"] if $game_player.record_companion_name_back == get_character(0).name
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	#call_msg("commonNPC:MaleHumanRandomNpc/CommonHuman_CommonNpcOpt",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
	
	case tmpPicked
	when "TeamUp"
		get_character(0).animation = nil
		call_msg("commonComp:CompFireMage/CompData")
		show_npc_info(get_character(0),extra_info=false,"commonComp:Companion/Accept") 			#\optD[算了，確定]
		get_character(0).animation = get_character(0).animation_stun if get_character(0).animation == nil
		case $game_temp.choice
			when 0,-1
			when 1
				if $game_party.item_number($data_items[22]) >=1 || $game_party.item_number($data_items[27]) >= 2 #ItemBluePotion || ItemHerbSta
					if $game_party.item_number($data_items[22]) >= 1 #ItemBluePotion
						optain_lose_item($data_items[22],1)
					elsif $game_party.item_number($data_items[27]) >= 2 #ItemHerbSta
						optain_lose_item($data_items[27],2)
					end
					get_character(0).set_this_event_companion_back("CompFireMage",false,$game_date.dateAmt+5)
					get_character(0).animation = nil
					call_msg("commonComp:CompFireMage/Comp_win")
				else
					call_msg("commonComp:CompFireMage/Comp_failed")
				end
		end
	when "Disband"
		call_msg("commonComp:Companion/Accept") 			#\optD[算了，確定]
			case $game_temp.choice
				when 0,-1
				when 1
					call_msg("commonComp:CompFireMage/Comp_disband")
					get_character(0).set_this_companion_disband(false)
			end
		
	end
if $game_player.record_companion_name_back == "CompFireMage"
	get_character(0).animation = nil
else
	get_character(0).animation = get_character(0).animation_stun if get_character(0).animation == nil
end

eventPlayEnd

