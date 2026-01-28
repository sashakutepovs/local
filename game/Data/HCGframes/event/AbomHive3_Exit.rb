tmpQ1 = $story_stats["RecQuestLisa"] == 14
tmpQ2 = $story_stats["Captured"] != 1
tmpQ3 = $game_player.record_companion_name_ext == "CompExtUniqueLisaDown"

if tmpQ1 && tmpQ2 && tmpQ3
	if get_character($game_player.get_followerID(-1)).region_id != 50
		return $game_map.popup(0,"CompLisa:Lisa14/LisaNotInR50",0,0)
	end
	change_map_leave_tag_map
else
	change_map_tag_map_exit
end
#33.12