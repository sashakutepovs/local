#SndLib.bgs_play("WindMountain",80,100)
weather_batch_r1_PlainField
SndLib.bgm_stop
#$game_map.set_fog("mountainLEFT")
#$game_map.interpreter.weather("light_go_left", 5, "FlameDirt",true)
#$game_map.shadows.set_color(40, 60, 120) if $game_date.day?
#$game_map.shadows.set_opacity(120)  if $game_date.day?
#$game_map.shadows.set_color(40, 40, 170) if $game_date.night?
#$game_map.shadows.set_opacity(180)  if $game_date.night?
#$game_map.interpreter.map_background_color(125,125,150,40,0)

enter_static_tag_map if $story_stats["ReRollHalfEvents"] ==1
summon_companion

chcg_background_color(0,0,0,255,-7) if get_chcg_background_opacity >= 255
eventPlayEnd
get_character(0).erase
