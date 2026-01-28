$game_player.call_balloon(19)
$game_map.npcs.each{|ev|
	next if !ev.summon_data
	next if !ev.summon_data[:Commoner]
	next if ev.npc.action_state == :death
	if [true,false].sample
		ev.npc.fucker_condition={"sex"=>[65535, "="]}
		ev.npc.killer_condition={"sex"=>[65535, "="]}
		ev.npc.assaulter_condition={"sex"=>[65535, "="]}
	else
		ev.npc.fucker_condition={"sex"=>[0, "="]}
		ev.npc.killer_condition={"weak"=>[10, "<"]}
		ev.npc.assaulter_condition={"weak"=>[10, ">"]}
	end
}