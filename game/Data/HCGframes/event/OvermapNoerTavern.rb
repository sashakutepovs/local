if $story_stats["UniqueCharUniqueCocona"] != -1 && $story_stats["RecQuestCocona"] == 2 && $story_stats["UniqueCharUniqueTavernWaifu"] != -1
	$story_stats["RecQuestCocona"] = 3
	call_msg("CompCocona:Cocona/Qu3")

elsif $story_stats["RecQuestCocona"] == 20 && $game_player.record_companion_name_back == "UniqueCoconaMaid"
	call_msg("CompCocona:cocona/RecQuestCocona_20")
	$game_player.record_companion_name_back = nil
	$story_stats["RecQuestCocona"] = 21
end

call_msg("TagMapNoerTavern:NoerTavern/OvermapEnter")
case $game_temp.choice
	when 1
	$game_player.direction= 8
	change_map_enter_tag("NoerTavern")
end

eventPlayEnd