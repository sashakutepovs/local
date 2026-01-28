if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end


call_msg("TagMapSybFDgate:GuardMain/opt") #[沒事,傭兵,她]
case $game_temp.choice
when 1
	call_msg("TagMapSybFDgate:GuardMain/opt_Mercenary")
when 2
	call_msg("TagMapSybFDgate:GuardMain/opt_Her")
end
$game_temp.choice = -1
eventPlayEnd
