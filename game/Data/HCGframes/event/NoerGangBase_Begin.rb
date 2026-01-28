

if $story_stats["QuProgSaveCecily"] == 17
	$game_map.npcs.each do |event| 
		next if event.summon_data == nil
		next if event.summon_data[:OnRegionMapSpawnRace] == nil
		next if !event.summon_data[:OnRegionMapSpawnRace]
		event.npc.set_fated_enemy([0,5,6,9,10])
	end
	$game_player.call_balloon(8)
	$game_player.direction = 8
	wait(60)
	$game_player.call_balloon(8)
	$game_player.direction = 4
	wait(60)
	$game_player.call_balloon(8)
	$game_player.direction = 6
	wait(60)
	$game_player.direction = 8
	call_msg("CompCecily:NoerGangBase/SleepGuard")
	call_msg("CompCecily:Cecily/16to17_END_brd")
	eventPlayEnd
end

