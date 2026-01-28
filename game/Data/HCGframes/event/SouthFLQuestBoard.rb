if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
#$story_stats["QuProgSFL_SpiderLeg"]
#$story_stats["QuProgSFL_MonsterBone"]
#$story_stats["QuProgSFL_BreedLingLiver"]
#$story_stats["QuProgSFL_DestroyHive"]




tmpQ0 = $story_stats["GuildQuestCurrent"] == 0
tmpQ1 = $story_stats["RecQuestSouthFLMain"] >= 9
tmpLoopQUamt = $story_stats["RecQuestSouthFL_LoopQU"]
if !(tmpQ0 && tmpQ1)
	SndLib.sys_buzzer
	return call_msg_popup("TagMapSouthFL:noquestPOP/0",0)
end
tmpPicked = ""
tmpQuestList = []
tmpQuestList << [$game_text["TagMapSouthFL:QuestBoard/SybBarn"]							,"SybBarn"]				if tmpQ0 && tmpQ1 && $story_stats["GuildQuestBeforeAccept"] != "SybBarn" 			&& $story_stats["QuProgSybBarn"] == 0
tmpQuestList << [$game_text["TagMapSouthFL:QuestBoard/SpiderLeg"]						,"SFL_SpiderLeg"]		if tmpQ0 && tmpQ1 && $story_stats["GuildQuestBeforeAccept"] != "SFL_SpiderLeg" 		&& tmpLoopQUamt >= 0 && $story_stats["QuProgSFL_SpiderLeg"] == 0
tmpQuestList << [$game_text["TagMapSouthFL:QuestBoard/BreedLingMeat"]					,"SFL_BreedLingMeat"]	if tmpQ0 && tmpQ1 && $story_stats["GuildQuestBeforeAccept"] != "SFL_BreedLingMeat" 	&& tmpLoopQUamt >= 1 && $story_stats["QuProgSFL_BreedLingMeat"] == 0
tmpQuestList << [$game_text["TagMapSouthFL:QuestBoard/MonsterBone"]						,"SFL_MonsterBone"]		if tmpQ0 && tmpQ1 && $story_stats["GuildQuestBeforeAccept"] != "SFL_MonsterBone" 	&& tmpLoopQUamt >= 2 && $story_stats["QuProgSFL_MonsterBone"] == 0
#tmpQuestList << [$game_text["TagMapSouthFL:QuestBoard/DestroyHive"]						,"SFL_DestroyHive"]		if tmpQ0 && tmpQ1 && $story_stats["GuildQuestBeforeAccept"] != "SFL_DestroyHive" 	&& tmpLoopQUamt >= 3 && $story_stats["QuProgSFL_DestroyHive"] == 0
tmpQuestList << [$game_text["TagMapNoerTavernQuest:QuestBoard/None_list"]				,"none"]				if tmpQuestList.empty?

		cmd_sheet = tmpQuestList
		cmd_text =""
		for i in 0...cmd_sheet.length
			cmd_text.concat(cmd_sheet[i].first+",")
		end
		call_msg("#{$game_text["TagMapNoerTavernQuest:QuestBoard/List"]}\\optB[#{cmd_text}]")

		$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
		$game_temp.choice = -1
		
case tmpPicked
	when "SFL_SpiderLeg"
		call_msg("TagMapSouthFL:QuestBoard/SpiderLeg_BOARD")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "SFL_SpiderLeg" if $game_temp.choice ==1
	when "SFL_MonsterBone"
		call_msg("TagMapSouthFL:QuestBoard/MonsterBone_BOARD")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "SFL_MonsterBone" if $game_temp.choice ==1
	when "SFL_BreedLingMeat"
		call_msg("TagMapSouthFL:QuestBoard/BreedLingMeat_BOARD")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "SFL_BreedLingMeat" if $game_temp.choice ==1
	when "SFL_DestroyHive"
		call_msg("TagMapSouthFL:QuestBoard/DestroyHive_BOARD")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "SFL_DestroyHive" if $game_temp.choice ==1
	when "SybBarn" #SybSuperMarket
		call_msg("TagMapSouthFL:QuestBoard/SybBarn_BOARD")
		call_msg("TagMapNoerTavernQuest:QuestBoard/decide")
		SndLib.sys_PaperTear if $game_temp.choice ==1
		$story_stats["GuildQuestBeforeAccept"] = "SybBarn" if $game_temp.choice ==1
end

if $story_stats["GuildQuestBeforeAccept"] !=0
	point=$game_map.get_storypoint("GuildEmpolyee")
	get_character(point[2]).call_balloon(28,-1) if !$game_map.events[point[2]].nil?
end


$game_temp.choice = -1