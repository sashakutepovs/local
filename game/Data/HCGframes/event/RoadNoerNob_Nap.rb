$story_stats["OnRegionMapSpawnRace"] = "NobleGuards"
$story_stats["RapeLoop"] = 1
check_enemy_survival?
if $story_stats["RapeLoop"] == 1
	chcg_background_color(0,0,0,0,7)
	call_msg("OvermapEvents:NobleGateGuard/NapCapture")
end
region_map_wildness_nap