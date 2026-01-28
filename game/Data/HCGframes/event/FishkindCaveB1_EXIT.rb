change_map_tag_map_exit(temp_region_trigger=false,tmpChoice=false)
if $game_temp.choice == 1
	$game_temp.choice = -1
		$story_stats["OverMapForceTrans"] = "FishkindCave1B2"
		$story_stats["OverMapForceNoNap"] = 1
		$story_stats["OverMapForceTransStay"] = 1
end

