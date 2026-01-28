if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).call_balloon(0)
tmpPicked = ""
tmpQuestList = []
tmpQuestList << [$game_text["TagMapNoerTavernQuest:QuestBoard/StaHerbCollect_list"]			,"StaHerbCollect"]		if $story_stats["GuildQuestCurrent"] == 0 && $story_stats["GuildQuestBeforeAccept"] != "StaHerbCollect" && $story_stats["QuProgStaHerbCollect"]==0 && $story_stats["UniqueCharUniqueElise"] != -1
tmpQuestList << [$game_text["TagMapNoerTavernQuest:QuestBoard/MineCaveAbomHunt_list"]		,"MineCaveAbomHunt"]	if $story_stats["GuildQuestCurrent"] == 0 && $story_stats["GuildQuestBeforeAccept"] != "MineCaveAbomHunt" && $story_stats["QuProgMineCaveAbomHunt"]==0
tmpQuestList << [$game_text["TagMapNoerTavernQuest:QuestBoard/CataUndeadHunt_list"]			,"CataUndeadHunt"]		if $story_stats["GuildQuestCurrent"] == 0 && $story_stats["GuildQuestBeforeAccept"] != "CataUndeadHunt" && $story_stats["QuProgCataUndeadHunt"]==0 && ($story_stats["GuildCompletedCataUndeadHunt2"] == 1 || $story_stats["QuProgCataUndeadHunt2"] ==0) && $game_date.dateAmt >= $story_stats["QuProgCataUndeadHuntAMT"] + 3
tmpQuestList << [$game_text["TagMapNoerTavernQuest:QuestBoard/NoerToPirate_list"]			,"NoerToPirate"]		if $story_stats["GuildQuestCurrent"] == 0 && $story_stats["GuildQuestBeforeAccept"] != "NoerToPirate" && $story_stats["QuProgNoerToPirate"] ==0 && $story_stats["GuildCompletedScoutCampOrkind"] >= 3 && !$DEMO
tmpQuestList << [$game_text["TagMapNoerTavernQuest:QuestBoard/NoerToDoom_list"]				,"NoerToDoom"]			if $story_stats["GuildQuestCurrent"] == 0 && $story_stats["GuildQuestBeforeAccept"] != "NoerToDoom" && $story_stats["QuProgNoerToDoom"] ==0 && $story_stats["GuildCompletedScoutCampOrkind"] >= 3 && !$DEMO
tmpQuestList << [$game_text["TagMapNoerTavernQuest:QuestBoard/OrkindEars_list"]				,"OrkindEars"]			if $story_stats["GuildQuestCurrent"] == 0 && $story_stats["GuildQuestBeforeAccept"] != "OrkindEars" && $story_stats["QuProgOrkindEars"] ==0 && $story_stats["GuildCompletedScoutCampOrkind"] >= 1 && !$DEMO
tmpQuestList << [$game_text["TagMapNoerTavernQuest:QuestBoard/ScoutCampOrkind_list"]		,"ScoutCampOrkind"]		if $story_stats["GuildQuestCurrent"] == 0 && $story_stats["GuildQuestBeforeAccept"] != "ScoutCampOrkind" && $story_stats["QuProgScoutCampOrkind"] ==0 && $story_stats["GuildCompletedScoutCampOrkind"] == 0
tmpQuestList << [$game_text["TagMapNoerTavernQuest:QuestBoard/ScoutCampOrkind2_list"]		,"ScoutCampOrkind2"]	if $story_stats["GuildQuestCurrent"] == 0 && $story_stats["GuildQuestBeforeAccept"] != "ScoutCampOrkind2" && $story_stats["QuProgScoutCampOrkind2"] ==0 && $story_stats["GuildCompletedScoutCampOrkind"] == 1 && !$DEMO
tmpQuestList << [$game_text["TagMapNoerTavernQuest:QuestBoard/ScoutCampOrkind3_list"]		,"ScoutCampOrkind3"]	if $story_stats["GuildQuestCurrent"] == 0 && $story_stats["GuildQuestBeforeAccept"] != "ScoutCampOrkind3" && $story_stats["QuProgScoutCampOrkind3"] ==0 && $story_stats["GuildCompletedScoutCampOrkind"] == 2 && !$DEMO
tmpQuestList << [$game_text["TagMapNoerTavernQuest:QuestBoard/CataUndeadHunt2_list"]		,"CataUndeadHunt2"]		if $story_stats["GuildQuestCurrent"] == 0 && $story_stats["GuildQuestBeforeAccept"] != "CataUndeadHunt2" && $story_stats["QuProgCataUndeadHunt2"] ==0 && $story_stats["GuildCompletedCataUndeadHunt"] >=1 && $story_stats["GuildCompletedScoutCampOrkind"] >= 2 && $story_stats["GuildCompletedCataUndeadHunt2"] != 1 && !$DEMO
tmpQuestList << [$game_text["TagMapNoerTavernQuest:QuestBoard/SewerKickMobs_list"]			,"SewerKickMobs"]		if $story_stats["GuildQuestCurrent"] == 0 && $story_stats["GuildQuestBeforeAccept"] != "SewerKickMobs" && $story_stats["QuProgSewerKickMobs"] == 0 && $game_date.dateAmt >= $story_stats["RecQuestSewerHoboAmt"] && $story_stats["RecQuestSewerHoboAmt"] != 0 && !$DEMO
tmpQuestList << [$game_text["TagMapNoerTavernQuest:QuestBoard/None_list"]					,"none"]				if tmpQuestList.empty?

		cmd_sheet = tmpQuestList
		cmd_text =""
		for i in 0...cmd_sheet.length
			cmd_text.concat(cmd_sheet[i].first+",")
		end
		call_msg("#{$game_text["TagMapNoerTavernQuest:QuestBoard/List"]}\\optB[#{cmd_text}]")

		$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
		$game_temp.choice = -1
		
case tmpPicked
	when "StaHerbCollect" #收集白龍草
		call_msg("TagMapNoerTavernQuest:QuestBoard/StaHerbCollect")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "StaHerbCollect" if $game_temp.choice ==1
	when "MineCaveAbomHunt" #礦坑魔物清理
		call_msg("TagMapNoerTavernQuest:QuestBoard/MineCaveAbomHunt")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "MineCaveAbomHunt" if $game_temp.choice ==1
	when "CataUndeadHunt" #墳場的不死者
		call_msg("TagMapNoerTavernQuest:QuestBoard/CataUndeadHunt")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "CataUndeadHunt" if $game_temp.choice ==1
		$story_stats["QuProgCataUndeadHuntCount"] = 0 if $game_temp.choice ==1
	when "ScoutCampOrkind" #失蹤的車隊
		call_msg("TagMapNoerTavernQuest:QuestBoard/ScoutCampOrkind")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "ScoutCampOrkind" if $game_temp.choice ==1
	when "ScoutCampOrkind2" #北方關口哨塔
		call_msg("TagMapNoerTavernQuest:QuestBoard/ScoutCampOrkind2")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "ScoutCampOrkind2" if $game_temp.choice ==1
	when "CataUndeadHunt2" #墳場失蹤的屍體
		call_msg("TagMapNoerTavernQuest:QuestBoard/CataUndeadHunt2")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "CataUndeadHunt2" if $game_temp.choice ==1
	when "ScoutCampOrkind3" #女兒失蹤了
		call_msg("TagMapNoerTavernQuest:QuestBoard/ScoutCampOrkind3")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "ScoutCampOrkind3" if $game_temp.choice ==1
	when "SewerKickMobs" #下水道的遊民
		call_msg("TagMapNoerTavernQuest:QuestBoard/SewerKickMobs")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "SewerKickMobs" if $game_temp.choice ==1
	when "OrkindEars" #牠們怕的是你
		call_msg("TagMapNoerTavernQuest:QuestBoard/OrkindEars")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "OrkindEars" if $game_temp.choice ==1
	when "NoerToPirate" #保鑣：海賊毀滅者堡壘
		call_msg("TagMapNoerTavernQuest:QuestBoard/NoerToPirate")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "NoerToPirate" if $game_temp.choice ==1
	when "NoerToDoom" #保鑣：末日堡壘
		call_msg("TagMapNoerTavernQuest:QuestBoard/NoerToDoom")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "NoerToDoom" if $game_temp.choice ==1
end
get_character(0).call_balloon(28,-1) if get_character(0).summon_data[:ForceQuest]

if $story_stats["GuildQuestBeforeAccept"] !=0
	get_character(0).summon_data[:ForceQuest] = false
	get_character(0).call_balloon(0)
	point=$game_map.get_storypoint("GuildEmpolyee")
	get_character(point[2]).call_balloon(28,-1) if !$game_map.events[point[2]].nil?
end


eventPlayEnd