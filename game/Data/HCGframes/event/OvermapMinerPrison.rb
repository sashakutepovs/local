call_msg("TagMapHumanPrisonCave:HumanPrisonCave/OvermapEnter")
case $game_temp.choice
 when 1
	#abomHuntQuest
	tmpQ1 = [1,2].include?($story_stats["QuProgMineCaveAbomHunt"])
	
	#Lisa C130 Quest
	tmpQ2_1 = $story_stats["RecQuestC130"] == 3
	tmpQ2_2 = [1,2,4].include?($story_stats["RecQuestLisa"])
	tmpQ2_3 = $game_player.record_companion_name_ext == "CompExtUniqueLisa"
	tmpQ2 = tmpQ2_1 && tmpQ2_2 && tmpQ2_3
	
	#heal LISA
	tmpQ3_1 = [3].include?($story_stats["RecQuestLisa"])
	tmpQ3_2 =  $story_stats["UniqueCharUniqueLisa"] != -1
	tmpQ3 = tmpQ3_1 && tmpQ3_2
	if tmpQ2
		call_msg("CompLisa:Lisa/QuestLisa_1_1") if $story_stats["RecQuestLisa"] ==1
		call_msg("CompLisa:Lisa/QuestLisa_1_board")
		$story_stats["RecQuestLisa"] = 2 if $story_stats["RecQuestLisa"] ==1
	end
	
	
	
	
	$game_player.direction = 2
	if tmpQ1 || tmpQ2 || tmpQ3
		change_map_enter_tag("MineCaveQuest")
	else
		change_map_enter_tag("MinerPrison") 
	end
end

$game_portraits.lprt.hide
$game_portraits.rprt.hide
$game_temp.choice = -1