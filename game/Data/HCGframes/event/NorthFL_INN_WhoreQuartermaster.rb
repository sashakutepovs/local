if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
if get_character(tmpDualBiosID).summon_data[:DressTaken] == false
	get_character(tmpDualBiosID).summon_data[:DressTaken] = true
	call_msg("TagMapNorthFL_INN:Mama/getDress")
	optain_item($data_armors[3],1)
	wait(30)
	optain_item($data_armors[8],1)
end

call_msg("TagMapNorthFL_INN:Mama/Begin#{rand(2)}")
manual_barters("NorthFL_INN_WhoreQuartermaster")
call_msg("TagMapNorthFL_INN:Mama/End#{rand(2)}")
eventPlayEnd

