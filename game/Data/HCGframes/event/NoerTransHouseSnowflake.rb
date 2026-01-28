if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
call_msg("TagMapNoerTransHouse:Trans/talkedBegin0")
if $story_stats["RecQuestNoerSnowflake"] == 1
	$story_stats["RecQuestNoerSnowflake"] = 2
	call_msg("TagMapNoerTransHouse:Trans/begin0")
	call_msg("TagMapNoerTransHouse:Trans/begin1")
	call_msg("TagMapNoerTransHouse:Trans/begin2")
	call_msg("TagMapNoerTransHouse:Trans/begin3")
	return eventPlayEnd
end
$game_temp.choice = 0
tmpPicked = nil
tmpCommonEnd = nil
until ["opt_pills","Cancel"].include?(tmpPicked) || $game_temp.choice == -1
	#tmp_Prostitution = $game_player.actor.stat["Prostitute"] ==1 && get_character(0).summon_data[:SexTradeble]
	#tmp_Begging = $game_player.actor.weak >= 50 && get_character(0).summon_data[:SexTradeble]
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]						,"Cancel"]
	tmpTarList << [$game_text["commonNPC:commonNPC/About"]						,"opt_about"]
	tmpTarList << [$game_text["TagMapNoerTransHouse:Trans/opt_pills"]			,"opt_pills"] if $story_stats["RecQuestNoerSnowflake"] == 3
	tmpTarList << [$game_text["TagMapNoerTransHouse:Trans/opt_male"]			,"opt_male"] if $story_stats["RecQuestNoerSnowflake"] == 3
	#tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]					,"Barter"]
	#tmpTarList << [$game_text["commonNPC:commonNPC/Prostitution"]		,"Prostitution"] if tmp_Prostitution
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("TagMapNoerTransHouse:Trans/talkedDay0",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	#$game_temp.choice = -1
	case tmpPicked
		when "Cancel"
			tmpCommonEnd = true
		when "opt_pills"
			call_msg("TagMapNoerTransHouse:Trans/ans_pills_opt") #[真藥,假藥]
			if $game_temp.choice == 0
				call_msg("TagMapNoerTransHouse:Trans/ans_pills_opt_real")
				tmpCommonEnd = true
			else
				$story_stats["RecQuestNoerSnowflake"] = -1
				call_msg("TagMapNoerTransHouse:Trans/ans_pills_opt_fake0") ; portrait_hide
				get_character(0).call_balloon(8)
				wait(60)
				get_character(0).call_balloon(8)
				wait(60)
				call_msg("TagMapNoerTransHouse:Trans/ans_pills_opt_fake1")
				return load_script("Data/HCGframes/event/NoerTransHouseSnowflake_Frag.rb")
				tmpCommonEnd = false
			end
		when "opt_male"
			tmpCommonEnd = false
			call_msg("TagMapNoerTransHouse:Trans/ans_male")
			return load_script("Data/HCGframes/event/NoerTransHouseSnowflake_Frag.rb")
		when "opt_about"
			call_msg("TagMapNoerTransHouse:Trans/Ans_about0")
			call_msg("TagMapNoerTransHouse:Trans/Ans_about1")
			call_msg("TagMapNoerTransHouse:Trans/Ans_about2")
			$story_stats["RecQuestNoerSnowflake"] = 3 if $story_stats["RecQuestNoerSnowflake"] == 2
			tmpCommonEnd = true
	end
	tmpCommonEnd = true if $game_temp.choice == -1
end
if tmpCommonEnd
	portrait_hide
	get_character(0).call_balloon(8)
	wait(60)
	call_msg("TagMapNoerTransHouse:endTalkQuestion/begin0") #[女人,男人]
	if $game_temp.choice == 0
		call_msg("TagMapNoerTransHouse:endTalkQuestion/begin0_ansF")
	else
		call_msg("TagMapNoerTransHouse:endTalkQuestion/begin0_ansM")
		return load_script("Data/HCGframes/event/NoerTransHouseSnowflake_Frag.rb")
	end
end
eventPlayEnd
