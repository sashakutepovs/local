asd = $game_map.npcs.any?{|event| 
	next unless event.summon_data
	next unless event.summon_data[:Mama]
	next if [:stun,:death].include?(event.npc.action_state)
	true
}

if asd
	tmpMamaX,tmpMamaY,tmpMamaID=$game_map.get_storypoint("mama")
	get_character(tmpMamaID).direction = 8
	call_msg("TagMapSybBarn:mama/LastWords")
	get_character(tmpMamaID).npc.killer_condition={"health"=>[0, "<"]}
	get_character(tmpMamaID).npc.assaulter_condition={"health"=>[0, ">"]}
	get_character(tmpMamaID).set_manual_move_type(2)
	get_character(tmpMamaID).move_type = 2 if get_character(tmpMamaID).npc.target == nil
	eventPlayEnd
end

get_character(0).erase
