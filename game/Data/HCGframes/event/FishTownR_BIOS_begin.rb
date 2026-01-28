
weather_batch_r8_25_Swamp
tmpLP = RPG::BGM.last.pos
SndLib.bgm_play("D/Canyon_Survivor_Version_01_LOOP",75,110,tmpLP) if $game_date.day?
SndLib.bgm_play("D/Canyon_Survivor_Version_01_LOOP",75,90,tmpLP) if $game_date.night?
$game_map.shadows.set_color(50, 120, 40) if $game_date.day?
$game_map.shadows.set_opacity(120)  if $game_date.day?
$game_map.shadows.set_color(50, 120, 40) if $game_date.night?
$game_map.shadows.set_opacity(210)  if $game_date.night?
$game_map.interpreter.map_background_color(80,150,120,30,0)
$story_stats["BG_EFX_data"] = get_BG_EFX_data_Indoor
if [44].include?($game_player.region_id)
	weather_stop
	set_SFX_to_indoor_SFX
end
load_script("Data/HCGframes/event/FishTownR_CapturedBegin.rb")

enter_static_tag_map
summon_companion

chcg_background_color(0,0,0,255,-7) if get_chcg_background_opacity >= 255
eventPlayEnd
get_character(0).erase
