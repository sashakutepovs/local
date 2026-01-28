get_character(0).pattern = 0
return if $story_stats["UniqueChar_NFL_MerCamp_Leader"] == -1
return if $story_stats["NFL_MerCamp_SaveDog"] != 1
return if $story_stats["RapeLoop"] >= 1
return if $story_stats["Captured"] >= 1
return if $story_stats["UniqueChar_NFL_MerCamp_Leader"] == -1
tmpMerLeaderX,tmpMerLeaderY,tmpMerLeaderID = $game_map.get_storypoint("MerLeader")
tmpDoggyX,tmpDoggyY,tmpDoggyID = $game_map.get_storypoint("Doggy")
if get_character(tmpMerLeaderID).report_range($game_player) <= 3
	#portrait_hide
	#chcg_background_color(0,0,0,0,7)
	#	portrait_off
	#	get_character(tmpDoggyID).opacity = 255
	#	SndLib.sound_gore(100)
	#chcg_background_color(0,0,0,255,-7)
	get_character(0).call_balloon(0)
	get_character(tmpMerLeaderID).remove_this_companion_lite
	get_character(tmpMerLeaderID).move_type = 1
	get_character(tmpMerLeaderID).set_manual_move_type(1)
	SndLib.bgm_play_prev
	call_msg("TagMapNFL_OrkCamp2:Doggy/KIA")
	eventPlayEnd
	$story_stats["NFL_MerCamp_SaveDog"] = -1
	$story_stats["UniqueChar_NFL_MerCamp_Leader"] = -1
	optain_exp(5000)
else
	SndLib.sys_buzzer
	call_msg_popup("QuickMsg:CoverTar/NonNearLona")
end


#if get_character(0).summon_data[:deadDog] == false
#end