$story_stats["RapeLoopTorture"] = 1

$game_player.call_balloon(19)
$game_map.npcs.each{|event|
	next unless ["Orkind","Goblin"].include?(event.npc.race)
	next unless [nil,:none].include?(event.npc.action_state)
	event.npc.add_fated_enemy([0])
}
get_character(0).erase