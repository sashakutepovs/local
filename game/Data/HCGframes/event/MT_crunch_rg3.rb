
tmpToGraveID=$game_map.get_storypoint("ToGrave")[2]
tmpUndTarID=$game_map.get_storypoint("ThatUndead")[2]
tmpDoCocona = cocona_in_group? && follower_in_range?(0,5)
if !get_character(tmpToGraveID).summon_data[:FirstTime]
	get_character(tmpToGraveID).summon_data[:FirstTime] = true
	if tmpDoCocona
		tmpX,tmpY=$game_map.get_storypoint("ToCave")
		$game_player.moveto(tmpX-1,tmpY)
		get_character($game_player.get_followerID(0)).moveto($game_player.x+1,$game_player.y)
		get_character($game_player.get_followerID(0)).direction = 4
		$game_player.direction = 4
		if !get_character(tmpUndTarID).nil?
			get_character(tmpUndTarID).set_manual_move_type(0)
			get_character(tmpUndTarID).move_type = 0
			get_character(tmpUndTarID).npc.no_aggro= true
			get_character(tmpUndTarID).npc.fated_enemy = []
			get_character(tmpUndTarID).npc.fucker_condition={"sex"=>[65535, "="]}
			get_character(tmpUndTarID).npc.killer_condition={"sex"=>[65535, "="]}
			get_character(tmpUndTarID).npc.assaulter_condition={"sex"=>[65535, "="]}
			get_character(tmpUndTarID).npc.set_morality(50)
		end
	elsif !get_character(tmpUndTarID).nil?
		get_character(tmpUndTarID).set_manual_move_type(1)
		get_character(tmpUndTarID).move_type = 1
	end
	call_msg("TagMapMT_crunch:lona/EnterCave")
	if tmpDoCocona
		$game_player.direction = 6
		get_character($game_player.get_followerID(0)).direction = 4
		call_msg("TagMapMT_crunch:cocona/Home0")
	end
end
eventPlayEnd
get_character(0).erase