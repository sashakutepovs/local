if !get_character($game_map.get_storypoint("Keeper")[2]) || get_character($game_map.get_storypoint("Keeper")[2]).summon_data[:Enter]
	return get_character(0).erase
end
SndLib.bgm_play("D/Hidden Assault LOOP",70,100)
$game_map.npcs.each{
|event|
	next unless event.summon_data
	next unless event.summon_data[:Heretic]
	next if event.deleted?
	next if event.npc.action_state == :death
	if event.npc.sex == 1
		#event.npc.fucker_condition={"weak"=>[50, ">"],"sex"=>[0, "="]}
		event.npc.fucker_condition={"sex"=>[65535, "="]}
		event.npc.killer_condition={"sex"=>[65535, "="]}
		event.npc.assaulter_condition={"health"=>[0, ">"]}
	end
	event.npc.fraction_mode = 4
	event.npc.set_fraction(15)
	event.npc.refresh
}
$game_player.call_balloon(19)
get_character(0).erase