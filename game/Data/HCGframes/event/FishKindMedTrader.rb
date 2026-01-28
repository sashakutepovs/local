if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
call_msg("TagMapFishTown:MedTrader/Welcome#{rand(2)}")
manual_barters("FishKindMedTrader")

$story_stats["HiddenOPT1"] = "0" 
eventPlayEnd
