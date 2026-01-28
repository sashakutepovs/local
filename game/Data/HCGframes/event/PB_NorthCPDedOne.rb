if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).call_balloon(0)

load_script("Data/HCGframes/event/CompDedOneCheckUniqueDialog.rb")


SndLib.sound_QuickDialog
call_msg_popup("CompDedOne:PB_NorthCP/Qmsg#{rand(3)}",get_character(0).id)


$game_temp.choice = -1
portrait_hide
cam_center(0)