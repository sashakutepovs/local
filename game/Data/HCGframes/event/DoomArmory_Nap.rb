tmpMcID = $game_map.get_storypoint("MapCount")[2]
tmpMobAlive = $game_map.npcs.any?{
|event| 
next unless event.summon_data
next unless event.summon_data[:WildnessNapEvent]
next if event.deleted?
next if event.npc.action_state == :death
true
}

$story_stats["RapeLoop"] = 1 if tmpMobAlive && get_character(tmpMcID).summon_data[:do_capture] == true

if $story_stats["RapeLoop"] == 1 || $game_player.actor.morality < 1
	$game_player.actor.morality_lona = 29 if $game_player.actor.morality_lona > 29
	$story_stats["RapeLoop"] = 1
	$story_stats["OnRegionMapSpawnRace"] = "HumanGuard"
	$story_stats["Kidnapping"] =1
	$game_player.actor.sta =-100
	region_map_wildness_nap

elsif get_character(tmpMcID).summon_data[:do_capture] == false
	call_msg("common:Lona/NarrDriveAway")
	change_map_leave_tag_map
	portrait_hide

else
	handleNap
end

