#尋找對玩家有興趣的NPC
if check_enemy_survival?("FishPPL",false)
	$story_stats["SlaveOwner"] = "FishTownR"
	$story_stats["OnRegionMapSpawnRace"] = "FishPPL"
	#call_msg("TagMapFishTown:Guard/NapSlave")
	$story_stats["RapeLoop"] = 1
	$story_stats["Kidnapping"] =1
	$game_player.actor.sta =-100
	region_map_wildness_nap
	
elsif check_enemy_survival?("FishFemale",false)
	$story_stats["OnRegionMapSpawnRace"] = "FishFemale"
	$story_stats["RapeLoop"] = 1
	region_map_wildness_nap
else
	handleNap
end
