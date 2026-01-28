if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if cocona_in_group? && get_character(0).summon_data[:Cocona]
	call_msg("TagMapNoerRelayOut:Monk/begin0Cocona")
	
else
	call_msg("TagMapNoerRelayOut:Monk/begin0")
end
until false
	call_msg("TagMapNoerRelayOut:Monk/beginOPT") #[耶？！,信仰者？,謊言者？,無辜者？]
	case $game_temp.choice
		when 0,-1 # cancel
			call_msg("TagMapNoerRelayOut:Monk/beginOPT_NVM")
			call_msg("TagMapNoerRelayOut:Monk/beginOPT_NVM_Cocona") if cocona_in_group? && get_character(0).summon_data[:Cocona]
			break
		when 1 # belever
			call_msg("TagMapNoerRelayOut:Monk/beginOPT_BLI")
		when 2 # Lier
			call_msg("TagMapNoerRelayOut:Monk/beginOPT_LIE")
			
		when 3 # 無辜者？
			call_msg("TagMapNoerRelayOut:Monk/beginOPT_FAR")
		
		when 4 # 從者？
			call_msg("TagMapNoerRelayOut:Monk/beginOPT_FOL")
			
	end
end
get_character(0).summon_data[:Cocona] = false
eventPlayEnd
