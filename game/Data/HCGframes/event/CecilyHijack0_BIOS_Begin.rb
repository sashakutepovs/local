map_background_color(0,0,0,255,0)
chcg_background_color(0,0,0,255,255)
portrait_off
weather_batch_r5_forest
SndLib.bgs_play("forest_unname",80,100)
SndLib.bgm_play("Hatching_Grounds",80)
$game_map.shadows.set_color(50, 120, 70) if $game_date.day?
$game_map.shadows.set_opacity(130)  if $game_date.day?
$game_map.shadows.set_color(50, 160, 120) if $game_date.night?
$game_map.shadows.set_opacity(220)  if $game_date.night?
$game_map.interpreter.weather("snow", 3, "GrayGreenDot",true)
set_BG_EFX_data($story_stats["BG_EFX_data"])
if $story_stats["ReRollHalfEvents"] ==1
	enter_static_tag_map(nil,false)
	data=[tmpX=$game_player.x,tmpY=$game_player.y,skipExt=false,slot=nil,fadein=false]
	summon_companion(*data)
else
	set_BG_EFX_data($story_stats["BG_EFX_data"]) if !$story_stats["BG_EFX_data"].empty?
end

wait(10)

if $story_stats["QuProgSaveCecily"] == 8
	$story_stats["QuProgSaveCecily"] = 9
	tmpB_ID = $game_player.get_followerID(0)
	tmpF_ID = $game_player.get_followerID(1)
	tmpStX,tmpStY=$game_map.get_storypoint("StartPoint")
	get_character(tmpB_ID).moveto(tmpStX,tmpStY-1)
	get_character(tmpF_ID).moveto(tmpStX+1,tmpStY-1)
	get_character(tmpB_ID).direction = 6
	get_character(tmpF_ID).direction = 4
	get_character(tmpB_ID).summon_data[:Friendly] = true
	get_character(tmpF_ID).summon_data[:Friendly] = true
	$game_player.direction = 8
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapCecilyHijack:QuestStart/Begin0")
	$game_player.direction = 4
	cam_center(0)
	portrait_hide
end

chcg_background_color(0,0,0,255,-7) if get_chcg_background_opacity >= 255

$story_stats["RapeLoop"] = 1
eventPlayEnd
get_character(0).erase
