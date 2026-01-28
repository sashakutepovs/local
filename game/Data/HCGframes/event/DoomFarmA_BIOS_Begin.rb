
weather_batch_r5_forest
$game_map.shadows.set_color(50, 120, 70) if $game_date.day?
$game_map.shadows.set_opacity(160)  if $game_date.day?
$game_map.shadows.set_color(50, 120, 70) if $game_date.night?
$game_map.shadows.set_opacity(200)  if $game_date.night?
$game_map.interpreter.map_background_color(170,170,120,25,0)
SndLib.bgm_stop
$story_stats["BG_EFX_data"] = get_BG_EFX_data_Indoor

if [40].include?($game_player.region_id)
	$game_map.set_fog(nil)
	weather_stop
	set_SFX_to_indoor_SFX
end

enter_static_tag_map
summon_companion

load_script("Data/HCGframes/event/DoomFarmA_CapturedBegin.rb")


eventPlayEnd
get_character(0).erase



