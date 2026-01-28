weather_batch_r5_forest


$game_player.direction = 2 if $story_stats["ReRollHalfEvents"] ==1
$story_stats["LimitedNapSkill"] =1


if $story_stats["ReRollHalfEvents"] ==1
	st_id=$game_map.get_storypoint("StartPoint")[2]
	fadeout=$story_stats["ReRollHalfEvents"] ==1
	enter_static_tag_map(st_id,fadeout)
end
summon_companion


$story_stats["OnRegionMapSpawnRace"] = "Orkind"
$story_stats["LimitedNapSkill"] =1
eventPlayEnd

load_script("Data/HCGframes/event/B4CampOrkind_begin.rb")
get_character(0).erase
