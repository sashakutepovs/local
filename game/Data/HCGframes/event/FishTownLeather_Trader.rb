if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
#if $game_player.actor.state_stack(51) != 0 #is slave brand?
#	SndLib.sys_buzzer
#	$game_map.popup(get_character(0).id,"QuickMsg:Common/Slave0#{rand(2)}",0,0)
#	return
#end

call_msg("TagMapFishTownLeather:BSStrader/welcome")
call_msg("TagMapFishTownLeather:Lona/MarketOpt") #[算了,交易,關於,移除拘束具]
case $game_temp.choice
	when 0,-1
		call_msg("TagMapFishTownLeather:BSStrader/end")
	when 1
		manual_barters("FishTownLeather_Trader")
	when 2 #about
		call_msg("TagMapFishTownLeather:BSStrader/About")
end #case



eventPlayEnd
