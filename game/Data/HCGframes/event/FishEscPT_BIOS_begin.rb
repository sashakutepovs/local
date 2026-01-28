
batch_weather_r15_26_Marsh
enter_static_region_map if $story_stats["Kidnapping"] == 0
summon_companion
chcg_background_color(0,0,0,255,-7) if get_chcg_background_opacity >= 255

$story_stats["ReRollHalfEvents"] = 0
eventPlayEnd
get_character(0).erase
