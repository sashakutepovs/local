return handleNap if $story_stats["UniqueCharUniqueElise"] == -1

tmpDoTricketX,tmpDoTricketY,tmpDoTricketID=$game_map.get_storypoint("DoTricket")
if get_character(tmpDoTricketID).summon_data[:BirthLockedRoom] == true
	get_character(tmpDoTricketID).summon_data[:canSleep] = true
	handleNap
elsif get_character(tmpDoTricketID).summon_data[:canSleep] == false || $game_player.record_companion_name_ext == "CompExtUniqueElise"
	call_msg("common:Lona/NarrDriveAway")
	change_map_leave_tag_map
elsif get_character(tmpDoTricketID).summon_data[:canSleep] == true
	handleNap
	get_character(tmpDoTricketID).summon_data[:canSleep] = false
end

