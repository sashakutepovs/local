SndLib.bgs_play("AlienRumble",80,100)
if $story_stats["NFL_BridgeBunkerBat"] >= 2
	SndLib.bgm_play("D/Space Ambient #1",80,100)
else
	SndLib.bgm_play("D/Alien_Underworld",80)
end

$game_map.set_fog("infested_Cave")
$story_stats["LimitedNapSkill"] = 1 if $story_stats["NFL_BridgeBunkerBat"] < 3 #################################################
map_background_color(200,40,150,30,0)



if $game_player.record_companion_name_ext != nil
	summon_companion(tmpX=$game_player.x,tmpY=$game_player.y,false,-1)
end



$story_stats["LimitedNeedsSkill"] = 1



fadeout=$story_stats["ReRollHalfEvents"] == 1
enter_static_tag_map(nil,fadeout) if $story_stats["ReRollHalfEvents"] == 1



eventPlayEnd
get_character(0).erase
