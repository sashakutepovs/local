
batch_weather_r15_26_Marsh
#SndLib.bgs_play("forest_WetFrog",70,90)
#SndLib.bgm_stop
#$game_map.shadows.set_color(50, 120, 40) if $game_date.day?
#$game_map.shadows.set_opacity(130)  if $game_date.day?
#$game_map.shadows.set_color(70, 160, 50) if $game_date.night?
#$game_map.shadows.set_opacity(220)  if $game_date.night?
#$game_map.interpreter.weather("snow", 3, "GrayGreenDot",true)
#$game_map.interpreter.map_background_color(80,150,120,30,0)
#$game_map.set_fog("mountainDown_slow")
enter_static_tag_map
summon_companion
load_script("Data/HCGframes/event/FishEscSlave_CapturedBegin.rb")
chcg_background_color(0,0,0,255,-7) if get_chcg_background_opacity >= 255
eventPlayEnd
get_character(0).erase
