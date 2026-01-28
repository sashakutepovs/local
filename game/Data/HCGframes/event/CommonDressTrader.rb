if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
call_msg("TagMapNoerMarket:DressTrader/Welcome#{rand(3)}")



manual_barters("CommonDressTrader")
eventPlayEnd
