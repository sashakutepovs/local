
tmpQ1 =$story_stats["RecQuestCocona"] == 19
tmpQ2 = $story_stats["UniqueCharUniqueCocona"] != -1
tmpQ3 = $game_player.record_companion_name_back == "UniqueCoconaMaid"
if tmpQ1 && tmpQ2 && tmpQ3
	chcg_background_color(0,0,0,0,7)
	map_background_color(0,0,0,255,0)
	SndLib.sys_StepChangeMap
	wait(60)
	call_msg("CompCocona:cocona/RecQuestCocona_19_escape0")
	if $story_stats["UniqueCharUniqueTavernWaifu"] != -1
		cam_center(0)
		call_msg("CompCocona:cocona/RecQuestCocona_19_escape0_mamaQ0")
		$game_player.actor.morality_lona = 50
		optain_item($data_items[105],1)
		call_msg("CompCocona:cocona/RecQuestCocona_19_escape0_mamaQ1")
	end
	call_msg("CompCocona:cocona/RecQuestCocona_19_escape1")
	call_msg("CompCocona:cocona/RecQuestCocona_19_escape2")
	$story_stats["RecQuestCocona"] = 20
	change_map_leave_tag_map
else
	change_map_tag_map_exit
end
