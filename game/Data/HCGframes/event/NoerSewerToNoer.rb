
if $story_stats["RecQuestSewerSawGoblin"] ==0
	call_msg("MainTownSewer:Sewer/SkipExit")
	case $game_temp.choice
		when 0,-1
		when 1
			$story_stats["RecQuestSewerSawGoblin"] =2
			$story_stats["RecordFirstTutorialSTA"] =1
			$story_stats["RecordFirstTutorialSAT"] =1
			$story_stats["RecordFirstTutorialLVL"] =1
			$story_stats["RecordFirstTrap"] =1
			$story_stats["RecordFirstTutorialSneak"] =1 
			$story_stats["RecordFirstSap"] =1
			$story_stats["RecQuestSewerHoboAmt"] = 15 + $game_date.dateAmt if $story_stats["RecQuestSewerHoboAmt"] == 0
			$story_stats["RecordDeleteSewerChest"] =1
			$story_stats["RecQuestCaptain"] = 1
			$game_system.mails["Tutorial_MainControl"].read
			$game_system.mails["Tutorial_MainStats"].read
			$game_system.mails["Tutorial_GamePad"].read
			#$game_system.mails["SewerMiceTail1"].read
			change_map_leave_tag_map
	end
else
	$story_stats["RecQuestSewerHoboAmt"] = 15 + $game_date.dateAmt if $story_stats["RecQuestSewerHoboAmt"] == 0
	$story_stats["RecordDeleteSewerChest"] =1
	change_map_tag_map_exit
end
$game_temp.choice = -1