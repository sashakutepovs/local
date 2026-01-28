#SndLib.bgs_play("AlienRumble",100,100)
weather_batch_r6_BadlandForest
SndLib.bgm_stop
#$game_map.shadows.set_color(120, 50, 40) if $game_date.day?
#$game_map.shadows.set_opacity(80)  if $game_date.day?
#$game_map.shadows.set_color(120, 50, 40) if $game_date.night?
#$game_map.shadows.set_opacity(160)  if $game_date.night?
#$game_map.set_fog("infested_fallSM")
#$game_map.interpreter.weather("snow", 5, "redDot",true)
#map_background_color(200,40,150,40,0)
load_script("Data/HCGframes/event/SpawnPoolR_Begin.rb")
fadeout=$story_stats["ReRollHalfEvents"] == 1
enter_static_tag_map(nil,fadeout)
summon_companion
$story_stats["ReRollHalfEvents"] = 0
$story_stats["OnRegionMapSpawnRace"] =  "AbomManager"
$story_stats["LimitedNapSkill"] =1
eventPlayEnd
get_character(0).erase
