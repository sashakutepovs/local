
$game_map.npcs.each{
|event|
	next unless event.summon_data
	next unless event.summon_data[:RoomDudes]
	next if event.deleted?
	next if event.npc.action_state == :death
	event.npc.add_fated_enemy([400,0,8])
}
$game_player.call_balloon(19)
get_character(0).erase
#$game_player.actor.add_state("MoralityDown30")
