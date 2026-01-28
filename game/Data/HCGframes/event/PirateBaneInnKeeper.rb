if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

$game_temp.choice = -1
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"]
	tmpTarList << [$game_text["commonNPC:commonNPC/About"]				,"About"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Work"]				,"Work"]
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("TagMapPirateBane:InnKeeper/Begin",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1


case tmpPicked
	when "Barter"
		manual_barters("PirateBaneInnKeeper")
	when "About"
		call_msg("TagMapPirateBane:InnKeeper/About_here")
		
	when "Work"
		call_msg("TagMapPirateBane:InnKeeper/About_work")
end

cam_center(0)
portrait_hide
$game_temp.choice = -1
