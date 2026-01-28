#SndLib.bgs_play("forest_unname",80,100)
#SndLib.bgm_stop
#
#$game_map.shadows.set_color(50, 120, 70) if $game_date.day?
#$game_map.shadows.set_opacity(160)  if $game_date.day?
#$game_map.shadows.set_color(50, 120, 70) if $game_date.night?
#$game_map.shadows.set_opacity(180)  if $game_date.night?
#$game_map.interpreter.map_background_color(170,170,120,25,0)
weather_batch_r4_RainFroest
if $story_stats["ReRollHalfEvents"] ==1
	enter_static_tag_map
end
summon_companion
chcg_background_color(0,0,0,255,-7) if get_chcg_background_opacity >= 255
eventPlayEnd
get_character(0).erase
