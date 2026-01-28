weather_batch_r5_forest

$game_map.set_fog("forestfog")
SndLib.bgm_play("Hatching_Grounds",80)
SndLib.bgs_play("rainforest3", 80, 100)
$game_map.interpreter.weather("rain", 40, "Rain", false)
$game_map.shadows.set_color(50, 120, 70) if $game_date.day?
$game_map.shadows.set_opacity(130)  if $game_date.day?
$game_map.shadows.set_color(50, 160, 120) if $game_date.night?
$game_map.shadows.set_opacity(220)  if $game_date.night?
map_background_color(80, 120, 100,20)
if $story_stats["ReRollHalfEvents"] ==1
	enter_static_tag_map(nil,false)
	data=[tmpX=$game_player.x,tmpY=$game_player.y,skipExt=false,slot=nil,fadein=false]
	summon_companion(*data)
end
wait(10)

if $story_stats["QuProgSaveCecily"] == 10
	$story_stats["QuProgSaveCecily"] = 11
	tmpB_ID = $game_player.get_followerID(0)
	tmpF_ID = $game_player.get_followerID(1)
	tmpStX,tmpStY=$game_map.get_storypoint("StartPoint")
	get_character(tmpB_ID).moveto(tmpStX+1,tmpStY-1)
	get_character(tmpF_ID).moveto(tmpStX,tmpStY-1)
	get_character(tmpB_ID).direction = 2
	get_character(tmpF_ID).direction = 2
	get_character(tmpB_ID).summon_data[:Friendly] = true
	get_character(tmpF_ID).summon_data[:Friendly] = true
	$game_player.direction = 8
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapCecilyHijack:Part2/Enter")
	$game_player.direction = 6
	cam_center(0)
	portrait_hide
end
chcg_background_color(0,0,0,255,-7) if get_chcg_background_opacity >= 255

$story_stats["RapeLoop"] =1
eventPlayEnd
get_character(0).erase
