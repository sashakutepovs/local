tmpQ1 = [0,1].include?($story_stats["RecQuestAriseVillageFish"])
tmpQ2 = $game_player.record_companion_name_ext == "AriseVillageCompExtConvoy"

if tmpQ1 && tmpQ2
	if get_character($game_player.get_followerID(-1)).region_id != 50
		return $game_map.popup(0,"QuickMsg:CoverTar/NonNearExit",0,0)
	end
	change_map_leave_tag_map
else
	change_map_tag_map_exit
end
#33.12