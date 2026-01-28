
if $game_player.actor.stat["SlaveBrand"] == 1 && check_enemy_survival?("FishPPL",false)
	chcg_background_color(0,0,0,0,7)
	$story_stats["SlaveOwner"] = "FishTownR"
	$story_stats["OnRegionMapSpawnRace"] = "FishPPL"
	call_msg("TagMapFishTown:Guard/NapSlave")
	$story_stats["RapeLoop"] = 1
	$story_stats["Kidnapping"] =1
	$game_player.actor.sta =-100
	region_map_wildness_nap
elsif check_enemy_survival?("FishPPL",false)
	chcg_background_color(0,0,0,0,7)
	$story_stats["OnRegionMapSpawnRace"] = "FishPPL"
	call_msg("TagMapFishTown:Guard/NapLowMora")
	$story_stats["RapeLoop"] = 1
	$story_stats["Kidnapping"] =1
	$game_player.actor.sta =-100
	region_map_wildness_nap
else
	handleNap
end
