if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if get_character(0).summon_data[:CanGetReward]
	get_character(0).summon_data[:CanGetReward] = false
	call_msg("CompCecily:Nun/Thanks")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
	portrait_off
	get_character(0).delete
	chcg_background_color(0,0,0,255,-7)
	optain_item($data_items[50],1)
	wait(30)
	optain_exp(1000)
else
	SndLib.sound_QuickDialog
	call_msg_popup("TagMapSaintMonastery:healer/Qmsg#{rand(4)}",get_character(0).id)
end
eventPlayEnd