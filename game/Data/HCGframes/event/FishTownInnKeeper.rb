if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if $game_player.actor.stat["SlaveBrand"] == 1
	call_msg("TagMapFishTown:Guard/spot")
	get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
	return eventPlayEnd
end
$game_temp.choice = -1
call_msg("TagMapFishTownInn:InnKeeper/Begin") #\optB[算了,交易,關於]
case $game_temp.choice
	when 1
		manual_barters("FishTownInnKeeper")
	when 2
		call_msg("TagMapFishTownInn:InnKeeper/about")
end

eventPlayEnd
