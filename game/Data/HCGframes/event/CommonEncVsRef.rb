if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if get_character(0).summon_data && !get_character(0).summon_data[:TarClear]
	call_msg("commonNPC:refVsExt/Help#{rand(3)}")

elsif get_character(0).summon_data[:RewardGet] == true && get_character(0).summon_data[:TarClear]
	get_character(0).call_balloon(0)
	call_msg("commonNPC:refVsExt/WinDialog#{rand(3)}")
else
	get_character(0).call_balloon(0)
	get_character(0).summon_data[:RewardGet] = true
	call_msg("commonNPC:refVsExt/WinDialog#{rand(3)}")
	optain_item($data_items[[14,20,30].sample],1)
	wait(30)
	optain_exp(900)
	wait(30)
	optain_morality(1)
end
eventPlayEnd
