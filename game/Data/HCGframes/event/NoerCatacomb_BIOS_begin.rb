
weather_batch_r1_PlainField
map_background_color(125,125,150,50,0)
SndLib.bgs_play("PlainFieldDay5", 80, 100)
SndLib.bgm_play("Pretty Dungeon LOOP",80) if $game_date.day?
SndLib.bgm_play("Pretty Dungeon LOOP",80,90) if $game_date.night?
fadeout=$story_stats["ReRollHalfEvents"] == 1
enter_static_tag_map(nil,fadeout) if $story_stats["ReRollHalfEvents"] == 1
chcg_background_color(0,0,0,255,-7) if get_chcg_background_opacity >= 255
summon_companion
tmpQ1 = cocona_in_group?
if $story_stats["RecQuestCocona"] ==1 && tmpQ1
	wait(1)
	$story_stats["RecQuestCocona"] = 2
	tmpID = $game_player.get_followerID(0)
	get_character(tmpID).moveto($game_player.x,$game_player.y+1)
	call_msg("TagMapNoerCatacomb:Lona/UndeadHunt2_End")
	eventPlayEnd
end
$story_stats["OnRegionMapSpawnRace"] = "UndeadWalking"
$story_stats["LimitedNapSkill"] = 1 if $game_date.night?
$story_stats["LimitedNapSkill"] = 0 if $game_date.day?
eventPlayEnd
get_character(0).erase
