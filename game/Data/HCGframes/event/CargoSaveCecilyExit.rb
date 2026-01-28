
if $game_map.threat && $story_stats["Setup_Hardcore"] >= 1
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
tmpCecEv = nil
tmpGrvEv = nil
$game_map.npcs.each{|event|
	next unless ["-point-UniqueGrayRat","-point-Cecily"].include?(event.name)
	next if event.deleted?
	next if event.npc.action_state == :death
	tmpCecEv = event if event.name == "-point-Cecily"
	tmpGrvEv = event if event.name == "-point-UniqueGrayRat"
}
if !tmpCecEv || !tmpGrvEv
	SndLib.sys_buzzer
	call_msg_popup("QuickMsg:CoverTar/NonNearExit")
	return
end
#tmpQ1 = $game_player.record_companion_name_front == "UniqueGrayRat" && $game_player.record_companion_name_back == "UniqueCecily"
#tmpQ2 = nil
tmpQ1 = $game_player.record_companion_name_front == "UniqueGrayRat" && tmpGrvEv.region_id != 50
tmpQ2 = $game_player.record_companion_name_back == "UniqueCecily" && tmpCecEv.region_id != 50

if tmpQ1 || tmpQ2
	SndLib.sys_buzzer
	call_msg_popup("QuickMsg:CoverTar/NonNearExit")
	return
end

if $story_stats["UniqueCharUniqueCecily"] != -1 && $story_stats["UniqueCharUniqueGrayRat"] != -1 && ![-1,4].include?($story_stats["QuProgSaveCecily"])
	call_msg("TagMapCargoSaveCecily:Exit/QuestFailWarning")
end

call_msg("OvermapEvents:Lona/Exit")


if $game_temp.choice == 1
	if $story_stats["UniqueCharUniqueCecily"] != -1 && $story_stats["UniqueCharUniqueGrayRat"] != -1 && [4].include?($story_stats["QuProgSaveCecily"])
		$story_stats["RecQuestSaveCecily"] = 1
		$story_stats["QuProgSaveCecily"] = 5
		change_map_leave_tag_map
	else
		$story_stats["QuProgSaveCecily"] = -1
		$story_stats["RecQuestSaveCecily"] = -1
		change_map_leave_tag_map
	end
end

$game_temp.choice = nil
