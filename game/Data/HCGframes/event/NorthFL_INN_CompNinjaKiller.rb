if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
	get_character(0).animation = get_character(0).animation_atk_pray_hold
	get_character(0).call_balloon(0)
	call_msg("commonComp:CompNinjaKiller/begin")
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonComp:Companion/TeamUp"]			,"TeamUp"]  if $game_player.record_companion_name_front != get_character(0).name && !$game_player.player_slave?
	tmpTarList << [$game_text["commonComp:Companion/Disband"]			,"Disband"] if $game_player.record_companion_name_front == get_character(0).name
	#tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"] if !$game_player.player_slave?
	#tmpTarList << [$game_text["commonNPC:commonNPC/Prostitution"]		,"Prostitution"] if $game_player.actor.stat["Prostitute"] ==1 && get_character(0).summon_data[:SexTradeble]
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
		$story_stats["HiddenOPT0"] = InputUtils.getKeyAndTranslateLong(:SHIFT)
		$story_stats["HiddenOPT1"] = InputUtils.getKeyAndTranslateLong(:C)
		call_msg("commonComp:CompNinjaKiller/CompData")
		$story_stats["HiddenOPT0"] = "0"
		$story_stats["HiddenOPT1"] = "0"
		show_npc_info(get_character(0),extra_info=false,"commonComp:Companion/Accept") 			#\optD[算了，確定]
		case $game_temp.choice
			when 0,-1
			when 1
				if $game_party.item_number("ItemThrowingKnivesI") >=20 #肉湯
					optain_lose_item($data_items[42],1)
					get_character(0).set_this_event_companion_front(get_character(0).name,false,$game_date.dateAmt+10)
					call_msg("commonComp:CompNinjaKiller/Comp_win")
				else
					call_msg("commonComp:CompNinjaKiller/Comp_failed")
				end
		end
	when "Disband"
		call_msg("commonComp:Companion/Accept") 			#\optD[算了，確定]
			case $game_temp.choice
				when 0,-1
				when 1
					call_msg("commonComp:CompNinjaKiller/Comp_disband")
					get_character(0).set_this_companion_disband(false)
			end
end

	get_character(0).animation = nil

eventPlayEnd

