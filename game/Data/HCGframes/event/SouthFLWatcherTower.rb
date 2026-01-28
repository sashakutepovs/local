if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
SndLib.sys_StepChangeMap
SndLib.bgm_stop
portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	call_msg("TagMapSouthFL:Tower/Go1")
	SndLib.sys_StepChangeMap
	$bg.erase
	portrait_hide
chcg_background_color(0,0,0,255,-7)
portrait_off
SndLib.bgm_play_prev