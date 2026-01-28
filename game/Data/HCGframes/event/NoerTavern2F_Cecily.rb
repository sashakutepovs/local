return if $story_stats["UniqueCharUniqueCecily"] == -1 || $story_stats["UniqueCharUniqueGrayRat"] == -1

#when battle
if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).animation = nil
call_msg("CompCecily:Cecily/KnownBeginAr")

# ############################################################################################公布 MILO的陰毛
if $story_stats["QuProgSaveCecily"] == 45 
	$story_stats["QuProgSaveCecily"] = 46
	call_msg("CompCecily:Cecily/45to46")
	call_msg("still on DEV, WIP")

# ###########################################################################################與GR對話前制  暫時阻擋23
elsif $story_stats["QuProgSaveCecily"] == 43 || $story_stats["QuProgSaveCecily"] == 22 
	get_character(0).animation = nil
	$story_stats["QuProgSaveCecily"] = 44
	$story_stats["RecQuestSaveCecilyAmt"] = $game_date.dateAmt + 1
	call_msg("CompCecily:Cecily/22-43-PLUS")
	return eventPlayEnd
	
# ############################################################################################22 刪減偷竊線 BE >> kill milo     此線暫時排除？
#elsif $story_stats["QuProgSaveCecily"] == 22 
##	$story_stats["QuProgSaveCecily"] = 23
##	$story_stats["RecQuestSaveCecilyAmt"] = $game_date.dateAmt + 2
#	call_msg("CompCecily:Cecily/22-43-PLUS")
#	call_msg("--DEV-- Quest WIP")
end
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonComp:Companion/TeamUp"]			,"TeamUp"]		if $game_player.record_companion_name_back != "UniqueCecily"
	tmpTarList << [$game_text["commonComp:Companion/Disband"]			,"Disband"]		if $game_player.record_companion_name_back == "UniqueCecily"
	tmpTarList << [$game_text["CompCecily:Cecily/23to24_opt"]		,"23to24_opt"]		if $story_stats["QuProgSaveCecily"] == 23 && $game_date.dateAmt >= $story_stats["RecQuestSaveCecilyAmt"]
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("CompCecily:Cecily/BasicOpt",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
	
	case tmpPicked
		when 0,-1
		when "TeamUp"
			call_msg("CompCecily:Cecily/CompData")
			call_msg("CompGrayRat:GrayRat/CompData")
			show_npc_info(get_character(0),extra_info=false,"commonComp:Companion/Accept") 			#\optD[算了，確定]
			case $game_temp.choice
				when 0,-1
				when 1
					if $game_player.actor.weak > 100 && $story_stats["RecQuestSaveCecilyRaped"] ==1
						call_msg("CompCecily:Cecily/Comp_failed2F")
					else
						get_character(0).set_this_event_companion_back("UniqueCecily",false,$game_date.dateAmt+10)
						$game_player.record_companion_name_front = "UniqueGrayRat"
						$game_player.record_companion_front_date = $game_date.dateAmt+10
						call_msg("CompCecily:Cecily/Comp_win2F")
					end
			end
		when "Disband"
			call_msg("commonComp:Companion/Accept") 			#\optD[算了，確定]
				case $game_temp.choice
					when 0,-1
					when 1
						call_msg("CompCecily:Cecily/Comp_disbandAr")
						remove_companion(1)
						remove_companion(0)
				end
		when "23to24_opt"
		$story_stats["QuProgSaveCecily"] == 24
		call_msg("CompCecily:Cecily/23to24_0")
end #case

eventPlayEnd
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgSaveCecily"] == 45 && $game_date.dateAmt >= $story_stats["RecQuestSaveCecilyAmt"]

################################# Quest check ########################################
#return get_character(0).call_balloon(28,-1) if $story_stats["QuProgSaveCecily"] == 6 && [7,8].include?($story_stats["RecQuestMilo"]) && $game_date.dateAmt >= $story_stats["RecQuestSaveCecilyAmt"]
#return get_character(0).call_balloon(28,-1) if $story_stats["QuProgSaveCecily"] == 7 && $game_date.dateAmt >= $story_stats["RecQuestSaveCecilyAmt"]
#return get_character(0).call_balloon(28,-1) if $story_stats["QuProgSaveCecily"] == 8 && $game_player.record_companion_name_back != "UniqueCecily"
#return get_character(0).call_balloon(28,-1) if [13,14].include?($story_stats["QuProgSaveCecily"]) && $game_player.record_companion_name_back != "UniqueCecily"
#return get_character(0).call_balloon(28,-1) if $story_stats["QuProgSaveCecily"] == 16 && $game_date.dateAmt >= $story_stats["RecQuestSaveCecilyAmt"]
#return get_character(0).call_balloon(28,-1) if $story_stats["QuProgSaveCecily"] == 12 && $game_date.dateAmt >= $story_stats["RecQuestSaveCecilyAmt"]
#return get_character(0).call_balloon(28,-1) if [18,21].include?($story_stats["QuProgSaveCecily"])
