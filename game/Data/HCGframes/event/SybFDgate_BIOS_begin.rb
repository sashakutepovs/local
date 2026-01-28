batch_weather_r6_SybFDgate
#SndLib.bgs_play("forest_wind",80,100)
#SndLib.bgm_play("D/I3-Emotional - Murn for the Past",80,100)
#$game_map.shadows.set_color(120, 50, 40) if $game_date.day?
#$game_map.shadows.set_opacity(80)  if $game_date.day?
#$game_map.shadows.set_color(120, 50, 40) if $game_date.night?
#$game_map.shadows.set_opacity(120)  if $game_date.night?
#$game_map.interpreter.weather("snow", 5, "redDot",true)
SndLib.bgm_play("D/I3-Emotional - Murn for the Past",80,100)
map_background_color(200,40,150,40,0)

fadeout=$story_stats["ReRollHalfEvents"] == 1
enter_static_tag_map(nil,fadeout)
summon_companion

$story_stats["ReRollHalfEvents"] = 0


$story_stats["OnRegionMapSpawnRace"] =  "AbomManager"
$story_stats["LimitedNapSkill"] =1

eventPlayEnd

get_character(0).erase
