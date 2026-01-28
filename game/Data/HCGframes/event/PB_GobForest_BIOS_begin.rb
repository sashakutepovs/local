#SndLib.bgs_play("forest_WetFrog",70,90)
batch_weather_r15_26_Marsh
SndLib.bgm_stop
#$game_map.shadows.set_color(50, 120, 40) if $game_date.day?
#$game_map.shadows.set_opacity(130)  if $game_date.day?
#$game_map.shadows.set_color(70, 160, 50) if $game_date.night?
#$game_map.shadows.set_opacity(220)  if $game_date.night?
#$game_map.interpreter.weather("snow", 3, "GrayGreenDot",true)
#$game_map.interpreter.map_background_color(80,150,120,50,0)
#$game_map.set_fog("mountainDown_slow")

if $story_stats["ReRollHalfEvents"] ==1
	fadeout=$story_stats["ReRollHalfEvents"] ==1
	enter_static_tag_map(nil,fadeout)
end
chcg_background_color(0,0,0,255,-7) if get_chcg_background_opacity >= 255
summon_companion
eventPlayEnd
get_character(0).erase
