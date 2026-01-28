
if $story_stats["QuProgSaveCecily"] == 19
	if $game_player.record_companion_name_front != nil || $game_player.record_companion_name_back != nil
		$game_player.record_companion_name_front = nil
		$game_player.record_companion_front_date= nil
		$game_player.record_companion_name_back = nil
		$game_player.record_companion_back_date= nil
		call_msg("common:Lona/Follower_disbanded")
	end
	
	
	$game_temp.choice = -1
	change_map_tag_sub("NoerBackStreetQ","StartPoint",2,tmpChoice=false,tmpSkipOpt=true)
	if $game_temp.choice == 1
		$game_timer.off
		call_msg("CompCecily:QuProg/20_1")
		$story_stats["QuProgSaveCecily"] = 20
	end
else
	change_map_tag_map_exit
end