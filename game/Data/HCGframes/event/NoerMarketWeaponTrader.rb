if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).call_balloon(0)

	call_msg("TagMapNoerMarket:WeaponTrader/Welcome#{rand(2)}")

	manual_barters("CommonWeaponTrader")

eventPlayEnd
