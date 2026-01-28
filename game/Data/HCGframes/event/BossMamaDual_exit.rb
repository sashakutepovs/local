return SndLib.sys_buzzer if $game_player.cannot_change_map
if $game_map.threat && $story_stats["Setup_Hardcore"] >= 1
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
elsif !$game_party.has_item?("ItemQuestMhKatana") #!($story_stats["RecQuestCoconaDefeatBossMama"] >= 1 || $game_party.has_item?("ItemQuestMhKatana"))
	SndLib.sys_DoorLock
	call_msg_popup("TagMapNoerCatacomb:Necropolis/Locked#{rand(2)}")
else #quest
	if $game_player.record_companion_name_back != nil || $game_player.record_companion_name_front != nil
		$game_player.record_companion_name_front = nil
		$game_player.record_companion_name_back = nil
		call_msg("common:Lona/Follower_disbanded")
	end
	$story_stats["RecQuestCocona"] = 26
	tmpMaidText = $game_map.interpreter.cocona_maid? ? "Maid" : ""
	tmpMaidText = "UniqueCocona#{tmpMaidText}"
	$game_player.record_companion_name_back = tmpMaidText
	eventPlayEnd
	change_map_tag_sub("NoerArena","StartPointArena",2,tmpChoice=true,tmpSkipOpt=true,capture=false)
	call_msg("CompCocona:LeaveArena/0")
	portrait_hide
end

