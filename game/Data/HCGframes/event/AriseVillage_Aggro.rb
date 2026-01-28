
tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
get_character(tmpDualBiosID).summon_data[:Aggro] = true
$game_map.npcs.each{
|event|
	next unless event.summon_data
	next unless event.summon_data[:Villager]
	next if event.deleted?
	next unless [nil,:none].include?(event.npc.action_state)
	event.npc.add_fated_enemy([0,8])
	event.npc.killer_condition={"health"=>[0, ">"]}
	event.npc.assaulter_condition={"health"=>[0, ">"]}
	event.npc.fraction_mode = 4
			
	next unless !event.summon_data[:Shopper]
	event.move_type = 1 if event.move_type == 0
	event.set_manual_move_type(1)
	event.set_move_frequency(rand(3)+1)
	event.move_frequency = rand(3)+1
}
call_msg("TagMapAriseVillage:GateKeeper/AggroAlert")
eventPlayEnd