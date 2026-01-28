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
	call_msg("TagMapSouthFL:InnKeeper/Begin",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
	
case tmpPicked
	when "Barter"
			manual_barters("InnKeeper_SouthFL_INN")
	when "About"
		call_msg("TagMapSouthFL:InnKeeper/About_here")
		
	when "Work"
		call_msg("TagMapSouthFL:InnKeeper/About_work0")
		if $story_stats["SouthFL_DailyWorkAmt"] >= $game_date.dateAmt
			call_msg("TagMapSouthFL:InnKeeper/About_work_failed")
			return eventPlayEnd
		end
		$game_temp.choice = -1
		tmpGotoTar = ""
		tmpTarList = []
		tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
		tmpTarList << [$game_text["TagMapSouthFL:InnWork/Purge"]			,"Purge"]
		cmd_sheet = tmpTarList
		cmd_text =""
		for i in 0...cmd_sheet.length
			cmd_text.concat(cmd_sheet[i].first+",")
		end
		call_msg("...",0,2,0)
		call_msg("\\optB[#{cmd_text}]")
		$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
		$game_temp.choice = -1
		case tmpPicked
		when "Purge"
			call_msg("TagMapSouthFL:InnKeeper/About_work1")
			$game_map.npcs.each do |event|
				next if event.summon_data == nil
				next if !event.summon_data[:SaintWorker]
				next if event.actor.action_state == :death
				event.summon_data[:JobAccept] = true
				event.call_balloon(8,-1)
			end
		end
		
end

eventPlayEnd
