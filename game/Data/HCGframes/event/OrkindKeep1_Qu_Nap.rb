if $story_stats["RapeLoop"] == 1 && $story_stats["UniqueCharUniqueOgreWarBoss"] != -1
	$story_stats["RapeLoop"] = 1
	$story_stats["Captured"] = 1
	change_map_captured_enter_tagSub("Syb_WarBossRoom")
else
	handleNap
end


