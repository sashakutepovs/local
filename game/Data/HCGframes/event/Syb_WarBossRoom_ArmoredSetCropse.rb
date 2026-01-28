if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
call_msg("TagMapSyb_WarBossRoom:ArmoredSetCropse/0")
eventPlayEnd
optain_item("ItemFootmanMid",1)
wait(30)
optain_item("ItemFootmanBot",1)
wait(30)
optain_item("ItemFootmanMidExtra",1)
wait(30)
optain_item("ItemFootmanHelmet",1)
wait(30)
optain_item("ItemQuestFerrumRecpie",1)
wait(30)

EvLib.sum("EffectOverKill",get_character(0).x,get_character(0).y)
get_character(0).delete