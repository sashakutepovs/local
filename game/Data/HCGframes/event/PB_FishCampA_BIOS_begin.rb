
batch_weather_r15_26_Marsh
if $story_stats["ReRollHalfEvents"] ==1
	st_id=$game_map.get_storypoint("StartPoint")[2]
	fadeout=$story_stats["ReRollHalfEvents"] ==1
	enter_static_tag_map(st_id,fadeout)
end
summon_companion
chcg_background_color(0,0,0,255,-7) if get_chcg_background_opacity >= 255
eventPlayEnd
get_character(0).erase
