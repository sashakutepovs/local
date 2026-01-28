if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

tmpPicked = ""
tmpQuestList = []
tmpQuestList << [$game_text["TagMapPirateBane:QuestBoard/PB_MassGrave_list"]			,"PB_MassGrave"]		if $story_stats["GuildQuestCurrent"] == 0 && $story_stats["GuildQuestBeforeAccept"] != "PB_MassGrave" && $story_stats["QuProgPB_MassGrave"]==0
tmpQuestList << [$game_text["TagMapPirateBane:QuestBoard/PB_DeeponeEyes_list"]			,"PB_DeeponeEyes"]		if $story_stats["GuildQuestCurrent"] == 0 && $story_stats["GuildQuestBeforeAccept"] != "PB_DeeponeEyes" && $story_stats["QuProgPB_DeeponeEyes"]==0
tmpQuestList << [$game_text["TagMapPirateBane:QuestBoard/PB_NorthCP_list"]				,"PB_NorthCP"]			if $story_stats["GuildQuestCurrent"] == 0 && $story_stats["GuildQuestBeforeAccept"] != "PB_NorthCP" && $story_stats["QuProgPB_NorthCP"]==0
tmpQuestList << [$game_text["TagMapPirateBane:QuestBoard/PB_OrkDen4_list"]				,"PB_OrkDen4"]			if $story_stats["GuildQuestCurrent"] == 0 && $story_stats["GuildQuestBeforeAccept"] != "PB_OrkDen4" && $story_stats["QuProgPB_OrkDen4"]==0
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
	when "PB_MassGrave" #亂葬崗的邪惡
		call_msg("TagMapPirateBane:QuestBoard/PB_MassGrave")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "PB_MassGrave" if $game_temp.choice ==1
		
	when "PB_DeeponeEyes" #挖出牠的眼
		call_msg("TagMapPirateBane:QuestBoard/PB_DeeponeEyes")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "PB_DeeponeEyes" if $game_temp.choice ==1
		
	when "PB_NorthCP" #北哨點的訊息
		call_msg("TagMapPirateBane:QuestBoard/PB_NorthCP")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "PB_NorthCP" if $game_temp.choice ==1
		
	when "PB_OrkDen4" #類獸人巢穴
		call_msg("TagMapPirateBane:QuestBoard/PB_OrkDen4")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "PB_OrkDen4" if $game_temp.choice ==1
end

if $story_stats["GuildQuestBeforeAccept"] !=0
	point=$game_map.get_storypoint("GuildEmpolyee")
	get_character(point[2]).call_balloon(28,-1) if !$game_map.events[point[2]].nil?
end


eventPlayEnd