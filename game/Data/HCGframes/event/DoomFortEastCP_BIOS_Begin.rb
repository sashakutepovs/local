
weather_batch_r5_forest
$game_map.shadows.set_color(120, 50, 70) if $game_date.day?
$game_map.shadows.set_opacity(120)  if $game_date.day?
$game_map.shadows.set_color(120, 50, 70) if $game_date.day?
$game_map.shadows.set_opacity(160)  if $game_date.night?
$game_map.interpreter.map_background_color(170,170,120,25,0)
$game_map.interpreter.weather("snow", 1, "GrayGreenDot",true)
$game_map.set_fog("mountainLEFT_slow")
  if ![4, -1].include?($story_stats["RecQuestDF_Ecp"])
	  SndLib.bgm_play("CB_Epic Drums (Looped)", 80, 100)
	  SndLib.bgs_stop
  else
	  SndLib.bgm_stop
  end

$story_stats["BG_EFX_data"] = get_BG_EFX_data_Indoor
if $story_stats["ReRollHalfEvents"] ==1
	enter_static_tag_map
end
summon_companion

chcg_background_color(0,0,0,255,-7) if get_chcg_background_opacity >= 255
eventPlayEnd
get_character(0).erase
