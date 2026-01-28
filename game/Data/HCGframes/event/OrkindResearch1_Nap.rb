

tmpMobAlive = $game_map.npcs.any?{
|event| 
	next unless event.summon_data
	next unless event.summon_data[:WildnessNapEvent]
	next if event.deleted?
	next if event.npc.action_state == :death
	true
}

if tmpMobAlive
	$story_stats["RapeLoop"] =1
	$story_stats["OnRegionMapSpawnRace"] = "Orkind"
	region_map_wildness_nap
else
	portrait_hide
	$story_stats["RapeLoopTorture"] = 0
	$story_stats["Captured"] = 0
	$story_stats["RapeLoop"] =0
	return handleNap
end
