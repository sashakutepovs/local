
tmpHunterAlive = $game_map.npcs.any?{|event|
	next if event.summon_data == nil
	next if !event.summon_data[:Hunter]
	next if ![nil,:none].include?(event.actor.action_state)
	true
}
if tmpHunterAlive
	SndLib.sound_QuickDialog
	$game_map.popup(0,"TagMapSMRefugeeCamp:CapGob/Qmsg#{rand(2)}",0,0)
	return
else
	call_msg("TagMapSMRefugeeCamp:GoblinCBT/begin#{rand(2)}")
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]					,"Cancel"]
	tmpTarList << [$game_text["TagMapSMRefugeeCamp:GoblinCBT/Release"]		,"Release"] if !tmpHunterAlive
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("commonNPC:MaleHumanRandomNpc/CommonHuman_CommonNpcOpt",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1

	case tmpPicked
		when"Release"
			return load_script("Data/HCGframes/event/SMRefugeeCamp_ReleaseCBT.rb")
	end
end
