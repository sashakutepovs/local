if $story_stats["GuildCompletedScoutCampOrkind"] >= 1 || !$story_stats["QuProgScoutCampOrkind"].between?(1,3)
	weather_batch_r5_forest
else
	SndLib.bgs_play("forest_unname",80,100)
	SndLib.bgm_play("Hatching_Grounds",80)
	chcg_background_color(0,0,0,255,-7) if $story_stats["ReRollHalfEvents"] ==1
	$game_map.shadows.set_color(50, 120, 70) if $game_date.day?
	$game_map.shadows.set_opacity(130)  if $game_date.day?
	$game_map.shadows.set_color(50, 160, 120) if $game_date.night?
	$game_map.shadows.set_opacity(220)  if $game_date.night?
	$game_map.interpreter.weather("snow", 3, "GrayGreenDot",true)
	$game_map.interpreter.map_background_color(170,170,120,25,0)
end

$game_player.direction = 2 if $story_stats["ReRollHalfEvents"] ==1
$story_stats["LimitedNapSkill"] =1
if $story_stats["ReRollHalfEvents"] ==1
 st_id=$game_map.get_storypoint("StartPoint")[2]
 fadeout=$story_stats["ReRollHalfEvents"] ==1
 enter_static_tag_map(st_id,fadeout)
end
summon_companion
chcg_background_color(0,0,0,255,-7) if get_chcg_background_opacity >= 255

comp_count = $story_stats["GuildCompletedScoutCampOrkind"]
if $story_stats["QuProgScoutCampOrkind"]==1
 $story_stats["QuProgScoutCampOrkind"]=2
 call_msg("TagMapScoutCampOrkind:Forest/Entry") if comp_count == 0
end

$story_stats["OnRegionMapSpawnRace"] = "Orkind"
$story_stats["LimitedNapSkill"] =1

eventPlayEnd

get_character(0).erase
