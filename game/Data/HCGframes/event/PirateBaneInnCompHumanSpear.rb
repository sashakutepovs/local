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

	call_msg("commonComp:CompHumanSpear/begin")
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonComp:Companion/TeamUp"]			,"TeamUp"]  if $game_player.record_companion_name_front != get_character(0).name
	tmpTarList << [$game_text["commonComp:Companion/Disband"]			,"Disband"] if $game_player.record_companion_name_front == get_character(0).name
	tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Prostitution"]		,"Prostitution"] if $game_player.actor.stat["Prostitute"] ==1 && get_character(0).summon_data[:SexTradeble]
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
		call_msg("commonComp:CompHumanSpear/CompData")
		show_npc_info(get_character(0),extra_info=false,"commonComp:Companion/Accept") 			#\optD[算了，確定]
		case $game_temp.choice
			when 0,-1
			when 1
				if $game_party.item_number($data_items[27]) >=1 #白龍草
					optain_lose_item($data_items[27],1)
					get_character(0).set_this_event_companion_front(get_character(0).name,false,$game_date.dateAmt+6)
					call_msg("commonComp:CompHumanSpear/Comp_win")
				else
					call_msg("commonComp:CompHumanSpear/Comp_failed")
				end
		end
	when "Disband"
		call_msg("commonComp:Companion/Accept") 			#\optD[算了，確定]
			case $game_temp.choice
				when 0,-1
				when 1
					call_msg("commonComp:CompHumanSpear/Comp_disband")
					get_character(0).set_this_companion_disband(false)
			end
			
	when "Barter"
			manual_barters("PirateBaneInnCompHumanSpear")
		
	when "Prostitution"
		get_character(0).summon_data[:SexTradeble] = false
		$game_temp.choice == 0
		call_msg("commonNPC:RandomNpc/WhoreWork#{talk_style}")
		call_msg("commonNPC:RandomNpc/choosed")
		$game_player.actor.sta -=1 #WhoreWorkCost
		temp_vs1=5+rand(10) #性交易難度
		call_msg("\\narr #{$game_player.actor.weak.round} VS #{temp_vs1.round}")
		if $game_player.actor.weak > temp_vs1
			$game_player.actor.mood +=10
			$story_stats["sex_record_whore_job"] +=1
			$game_player.actor.record_lona_title = "WhoreJob/title_hooker" if $story_stats["sex_record_whore_job"] % 10 == 0
			call_msg("commonNPC:RandomNpc/WhoreWork_win")
			prev_gold = $game_party.gold
			play_sex_service_menu(get_character(0),0.5,"rand")
			play_sex_service_items(get_character(0),["ItemCoin1","ItemCoin2","ItemCoin3"],prev_gold)
		else
			$game_player.actor.mood -=3
			call_msg("commonNPC:RandomNpc/WhoreWork_failed")
		end
	end
	

eventPlayEnd
