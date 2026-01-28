
tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
if get_character(tmpDualBiosID).summon_data[:Aggro]
	$game_map.npcs.each{
	|event|
		next unless event.summon_data
		next unless event.summon_data[:Villager]
		next if event.deleted?
		next if event.npc.action_state == :death
		event.npc.add_fated_enemy([0,8])
	}
	$game_player.call_balloon(19)
	$game_player.actor.add_state("MoralityDown30")
end
get_character(0).erase
