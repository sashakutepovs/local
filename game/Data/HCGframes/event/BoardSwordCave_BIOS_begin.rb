weather_batch_r50_SnowMountain
$story_stats["BG_EFX_data"] = get_BG_EFX_data_Indoor

$game_map.interpreter.weather("snow", 0, "WhiteDotBig",true)
SndLib.bgs_play("Cave/CaveLOOP",85)
SndLib.bgs_play("forest_wind",80,100)
$game_map.shadows.set_color(25, 35, 100)
$game_map.shadows.set_opacity(225)
$game_map.set_fog("cave_fall")
map_background_color(128,128,135,80)



fadeout=$story_stats["ReRollHalfEvents"] ==1
enter_static_region_map(fadeout) if $story_stats["Kidnapping"] == 0
summon_companion


$story_stats["OnRegionMapSpawnRace"] = "UndeadWalking"
$story_stats["LimitedNapSkill"] = 1
chcg_background_color(0,0,0,255,-7) if get_chcg_background_opacity >= 255
eventPlayEnd
get_character(0).erase
