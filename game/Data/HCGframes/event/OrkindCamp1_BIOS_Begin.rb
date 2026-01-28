weather_batch_r5_forest
$story_stats["BG_EFX_data"] = get_BG_EFX_data_Indoor
#r5_OrkindCamp1_save_weather_to_tmpdata($weather_tmp_data)

if [40,41,42,43,47,39].include?($game_player.region_id)
	$game_map.set_fog(nil)
	weather_stop
	set_SFX_to_indoor_SFX
	$game_map.set_underground_light
end

SndLib.bgm_play("Hatching_Grounds",80)
fadeout=$story_stats["ReRollHalfEvents"] == 1
enter_static_tag_map(nil,fadeout) if $story_stats["ReRollHalfEvents"] == 1
summon_companion

eventPlayEnd

chcg_background_color(0,0,0,255,-7) if get_chcg_background_opacity >= 255
get_character(0).erase
