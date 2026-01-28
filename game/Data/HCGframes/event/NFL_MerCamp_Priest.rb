if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if $story_stats["UniqueChar_NFL_MerCamp_Leader"] == -1
	
	SndLib.sound_QuickDialog
	call_msg_popup("TagMapNFL_MerCamp:Commoner/Qmsg_lose#{rand(2)}",get_character(0).id)
elsif $story_stats["NFL_MerCamp_Invade"] == 1

	SndLib.sound_QuickDialog
	call_msg_popup("TagMapNFL_MerCamp:Commoner/BattleQmsg#{rand(2)}",get_character(0).id)
else
	SndLib.sound_QuickDialog
	call_msg_popup("TagMapAbanHouse2:guard2/beginElseQmsg#{rand(2)}",get_character(0).id)
end