if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
otherListHash = Hash.new(0)
otherList = ""
killListLine = 0
killList = ""
otherListLine = 0
otherListHash["record_TotalGain_TP"] = $story_stats["record_TotalGain_TP"] if $story_stats["record_TotalGain_TP"] >0
otherListHash["record_EncounterTriggered"] = $story_stats["record_EncounterTriggered"] if $story_stats["record_EncounterTriggered"] >0
otherListHash["record_DarkPotCooked"] = $story_stats["record_DarkPotCooked"] if $story_stats["record_DarkPotCooked"] >0
otherListHash["GuildCompletedCount"] = $story_stats["GuildCompletedCount"] if $story_stats["GuildCompletedCount"] >0
otherListHash["RecQuestHostageSaved"] = $story_stats["RecQuestHostageSaved"] if $story_stats["RecQuestHostageSaved"] >0
otherListHash["RecQuestNoerArenaWinCount"] = $story_stats["RecQuestNoerArenaWinCount"] if $story_stats["RecQuestNoerArenaWinCount"] >0
otherListHash["record_GameSaved"] = $story_stats["record_GameSaved"] if $story_stats["record_GameSaved"] >0
otherListHash["record_GameLoaded"] = $story_stats["record_GameLoaded"] if $story_stats["record_GameLoaded"] >0
otherListHash["Day_passed"] = $game_date.daysSince([1772,3,1,1]) if $game_date.daysSince([1772,3,1,1]) >0
if otherListHash.length > 0
	otherList += "\\C[2]Tasks Completed\\C[0]\\n"
	otherListHash.each{|name,count|
		if otherListLine == 0
			otherList +=" #{name}   #{count}"
		else
			otherList +="\\n #{name}   #{count}"
		end
		otherListLine +=1
	}
end
if $story_stats["record_killcount"].length > 0
	killList += "\\n\\C[2]Kill Count\\C[0]\\n"
	$story_stats["record_killcount"].each{|name,count|
		if killListLine == 0
			killList +=" #{name}   #{count}"
		else
			killList +="\\n #{name}   #{count}"
		end
		killListLine +=1
	}
end
$game_message.add("\\board[Score Board]")
$game_message.add(otherList+killList)
#$game_message.add("#{killList}")
#$game_message.add("\\n")
$game_map.interpreter.wait_for_message
eventPlayEnd
