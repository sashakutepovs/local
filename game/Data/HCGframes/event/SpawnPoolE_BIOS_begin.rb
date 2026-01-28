#SndLib.bgs_play("AlienRumble",100,100)
#SndLib.bgm_stop
weather_batch_r6_BadlandForest
#$game_map.shadows.set_color(120, 50, 40) if $game_date.day?
#$game_map.shadows.set_opacity(110)  if $game_date.day?
#$game_map.shadows.set_color(120, 50, 40) if $game_date.night?
#$game_map.shadows.set_opacity(180)  if $game_date.night?
#$game_map.set_fog("infested_fallSM")
#$game_map.interpreter.weather("snow", 5, "redDot",true)
#map_background_color(200,40,150,40,0)
fadeout=$story_stats["ReRollHalfEvents"] == 1
enter_static_tag_map(nil,fadeout)
summon_companion
$story_stats["ReRollHalfEvents"] = 0
$story_stats["OnRegionMapSpawnRace"] =  "AbomManager"
$story_stats["LimitedNapSkill"] =1
eventPlayEnd
load_script("Data/HCGframes/event/SpawnPoolE_Begin.rb")
get_character(0).erase
