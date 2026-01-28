weather_batch_r8_25_Swamp

fadeout=$story_stats["ReRollHalfEvents"] == 1
enter_static_tag_map(nil,fadeout) if $story_stats["ReRollHalfEvents"] == 1
summon_companion
chcg_background_color(0,0,0,255,-7) if get_chcg_background_opacity >= 255

eventPlayEnd

get_character(0).erase
