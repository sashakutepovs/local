if $story_stats["UniqueChar_NFL_MerCamp_Leader"] != -1
 call_msg("TagMapNFL_MerCamp:Invade/3_waveEND")
 portrait_hide
 tmpID = $game_map.get_storypoint("Leader")[2]
 get_character(tmpID).call_balloon(28,-1)
end

SndLib.bgm_play_prev
SndLib.bgs_stop
SndLib.bgs_play("forest_wind",80,100)
$story_stats["NFL_MerCamp_Invade"] = 2
