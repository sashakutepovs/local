if [-1].include?($story_stats["RecQuestBC2_SideQu"]) || $story_stats["RecQuestBC2_SideQu"] >= 5
	$game_map.npcs.each{
	|event|
		next unless event.summon_data
		next unless event.summon_data[:WildnessNapEvent] == "BanditMobs"
		next if event.deleted?
		event.set_manual_move_type(8)
		event.move_type = 8
		posi=$game_map.region_map[4]
		posi=posi.sample
		event.moveto(posi[0],posi[1])
	}
end