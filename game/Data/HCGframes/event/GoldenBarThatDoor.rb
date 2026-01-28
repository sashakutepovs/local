workAmtChk = $game_map.events.any?{|event| 
	next unless event[1].summon_data
	next unless event[1].summon_data[:tellerCG]
	next if event[1].deleted?
	true
}
if workAmtChk && $story_stats["RecQuestTellerThatDoorSucka"] == 2
	sexEVid = $game_map.get_storypoint("NTR")[2]
	if $game_map.threat
		SndLib.sys_buzzer
		$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
		return
	end
	if get_character(sexEVid).summon_data[:DoorCount] < 5
		get_character(sexEVid).summon_data[:DoorCount] += 1
		call_msg_popup("TagMapNoerRecRoom:DatDoor/NTR#{rand(5)}",sexEVid)
		SndLib.sound_QuickDialog
		return
	end
	$story_stats["RecQuestTellerThatDoorSucka"] = 3
	call_StoryHevent("RecHevTellerGoldenBar4some","HevTellerGoldenBar4some")
	call_msg("CompTeller:GoldenBarHev/End")
elsif workAmtChk
	SndLib.sys_DoorLock
	call_msg_popup("TagMapNoerCatacomb:Necropolis/Locked#{rand(2)}")
	
else
	tmpID= get_character(0).id
	doorEV_setup(tmpID,tmpPG=1,tmpTG=0,tmpSnd="openDoor",[0,-24])
end

eventPlayEnd


tmpCHK = $game_map.events.any?{|event| 
	next unless event[1].summon_data
	next unless event[1].summon_data[:tellerCG]
	next if event[1].deleted?
	true
}