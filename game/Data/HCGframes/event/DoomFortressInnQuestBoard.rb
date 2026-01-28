if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

tmpPicked = ""
tmpQuestList = []
tmpQuestList << [$game_text["TagMapDoomFortress:QuestBoard/DF_Woodson_list"]			,"DF_Woodson"]			if $story_stats["GuildQuestCurrent"] == 0 && $story_stats["GuildQuestBeforeAccept"] != "DF_Woodson" && $story_stats["QuProgDF_Woodson"]==0
tmpQuestList << [$game_text["TagMapDoomFortress:QuestBoard/DF_WipeTribe_list"]			,"DF_WipeTribe"]		if $story_stats["GuildQuestCurrent"] == 0 && $story_stats["GuildQuestBeforeAccept"] != "DF_WipeTribe" &&  $story_stats["RecQuestPenisTribeHelp"] != -1
tmpQuestList << [$game_text["TagMapDoomFortress:QuestBoard/DF_BanditHunt_list"]			,"DF_BanditHunt"]		if $story_stats["GuildQuestCurrent"] == 0 && $story_stats["GuildQuestBeforeAccept"] != "DF_BanditHunt" && $story_stats["QuProgDF_BanditHunt"] == 0 && $game_date.dateAmt >= $story_stats["QuProgDF_BanditHuntAMT"] + 3
tmpQuestList << [$game_text["TagMapNoerTavernQuest:QuestBoard/None_list"]				,"none"]				if tmpQuestList.empty?

		cmd_sheet = tmpQuestList
		cmd_text =""
		for i in 0...cmd_sheet.length
			cmd_text.concat(cmd_sheet[i].first+",")
			p cmd_text
		end
		call_msg("#{$game_text["TagMapNoerTavernQuest:QuestBoard/List"]}\\optB[#{cmd_text}]")

		$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
		$game_temp.choice = -1
		
case tmpPicked
	when "DF_Woodson" #伍德森家族
		call_msg("TagMapDoomFortress:QuestBoard/DF_Woodson")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "DF_Woodson" if $game_temp.choice ==1
		
	when "DF_WipeTribe" #獵屌部落
		call_msg("TagMapDoomFortress:QuestBoard/DF_WipeTribe")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "DF_WipeTribe" if $game_temp.choice ==1
		
	when "DF_BanditHunt" #殲滅盜匪
		call_msg("TagMapDoomFortress:QuestBoard/DF_BanditHunt")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "DF_BanditHunt" if $game_temp.choice ==1
end

if $story_stats["GuildQuestBeforeAccept"] !=0
	point=$game_map.get_storypoint("GuildEmpolyee")
	get_character(point[2]).call_balloon(28,-1) if !$game_map.events[point[2]].nil?
end




$game_temp.choice = -1