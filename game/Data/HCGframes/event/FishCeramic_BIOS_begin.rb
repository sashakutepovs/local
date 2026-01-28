batch_weather_r15_26_Marsh
SndLib.bgm_stop
SndLib.bgs_play("RainLight",70,130)
$game_map.interpreter.weather("rain_fast", 4, "Rain")
$game_map.shadows.set_color(50, 120, 40) if $game_date.day?
$game_map.shadows.set_opacity(120)  if $game_date.day?
$game_map.shadows.set_color(50, 120, 40) if $game_date.night?
$game_map.shadows.set_opacity(210)  if $game_date.night?
$story_stats["BG_EFX_data"] = get_BG_EFX_data_Indoor
if [44].include?($game_player.region_id)
 SndLib.bgs_play("RainLight",70,80)
 weather_stop
 $game_map.set_underground_light
 $game_map.set_fog(nil)
 set_SFX_to_indoor_SFX
end
$game_map.interpreter.map_background_color(80,150,120,50,0)
enter_static_tag_map(event_id=nil,fadeout=false) if $story_stats["ReRollHalfEvents"] ==1
summon_companion
chcg_background_color(0,0,0,255,-7) if get_chcg_background_opacity >= 255
eventPlayEnd
get_character(0).erase
