batch_weather_r15_26_Marsh
SndLib.bgm_stop
tmpLP = RPG::BGM.last.pos
SndLib.bgm_play("D/Canyon_Survivor_Version_01_LOOP",75,110,tmpLP) if $game_date.day?
SndLib.bgm_play("D/Canyon_Survivor_Version_01_LOOP",75,90,tmpLP) if $game_date.night?
enter_static_tag_map if $story_stats["ReRollHalfEvents"] ==1
summon_companion
chcg_background_color(0,0,0,255,-7) if get_chcg_background_opacity >= 255
eventPlayEnd
get_character(0).erase
