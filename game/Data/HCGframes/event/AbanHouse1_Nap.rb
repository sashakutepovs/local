tmpMobAlive = $game_map.npcs.any?{
|event| 
	next unless event.summon_data
	next unless event.summon_data[:WildnessNapEvent]
	next if event.deleted?
	next if event.npc.action_state == :death
	next if event.summon_data[:IgnoreNap]
	true
}
$story_stats["RapeLoop"] = 1 if tmpMobAlive

if $story_stats["RapeLoop"] == 1
	$story_stats["RapeLoop"] =1
	$story_stats["OnRegionMapSpawnRace"] = "BanditMobs"
	$story_stats["Kidnapping"] =1
	$game_player.actor.sta =-100
	tmp_x,tmp_y=$game_map.get_storypoint("WakeUp")
	$game_player.moveto(tmp_x,tmp_y)
	region_map_wildness_nap
else
	handleNap
end

