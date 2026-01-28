tmpMobAlive = $game_map.npcs.any?{
|event| 
next unless event.summon_data
next unless event.summon_data[:WildnessNapEvent]
next if event.deleted?
next if event.npc.action_state == :death
true
}
$story_stats["RapeLoop"] = 1 if tmpMobAlive

$story_stats["UniqueCharUniqueCecily"] = -1
$story_stats["UniqueCharUniqueGrayRat"] = -1

if $story_stats["RapeLoop"] == 1
	tmp_x,tmp_y=$game_map.get_storypoint("WakeUp")
	$game_player.moveto(tmp_x,tmp_y)
	$story_stats["RapeLoop"] =1
	$story_stats["OnRegionMapSpawnRace"] = "BanditMobs"
	$story_stats["Kidnapping"] =1
	$game_player.actor.sta =-100
	region_map_wildness_nap
else
	handleNap
end

