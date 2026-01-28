if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
 if $game_player.actor.stat["SlaveBrand"] == 1
	SndLib.sound_QuickDialog
	call_msg_popup("TagMapNoerArena:FoodSeller/SlaveQmsg#{rand(3)}",get_character(0).id)
	return
end
	call_msg("TagMapNoerArena:FoodSeller/begin")
	manual_barters("NoerArena_FoodSeller")
eventPlayEnd
