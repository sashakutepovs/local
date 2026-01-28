if $story_stats["NFL_MerCamp_SaveDog"] == -1
	$game_map.popup(0,"TagMapNFL_OrkCamp2:MercLeader/QmsgDoggyKIA#{rand(3)}",0,0)
	SndLib.sound_QuickDialog
	get_character(0).call_balloon(5)
	get_character(0).move_type = 1
	get_character(0).set_manual_move_type(1)
	return
end
if !get_character(0).npc.master
	if $game_map.threat
		SndLib.sys_buzzer
		$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
		return
	end
	get_character(0).direction = get_character(0).prelock_direction 
	call_msg("TagMapNFL_OrkCamp2:MercJoin/leader_Buddy0")
	get_character(0).turn_toward_character($game_player)
	call_msg("TagMapNFL_OrkCamp2:MercJoin/leader_Buddy1")
	get_character(0).set_this_event_companion_front_lite
	get_character(0).call_balloon(0)
	SndLib.bgm_play("D/War_Drums_01_Loop",75,80)
	eventPlayEnd
elsif get_character(0).follower
	get_character(0).turn_toward_character($game_player)
	get_character(0).prelock_direction = get_character(0).direction
	tmpPicked = ""
	tmpQuestList = []
	tmpQuestList << [$game_text["commonComp:Companion/Follow"]			,"Follow"]
	tmpQuestList << [$game_text["commonComp:Companion/Wait"]			,"Wait"]
			cmd_sheet = tmpQuestList
			cmd_text =""
			for i in 0...cmd_sheet.length
				cmd_text.concat(cmd_sheet[i].first+",")
				p cmd_text
			end
			if $story_stats["NFL_MerCamp_SaveDog"] == 2
				call_msg("TagMapNFL_OrkCamp2:MercLeader/CompCommand_foundTGT#{rand(2)}",0,2,0)
			else
				call_msg("TagMapNFL_OrkCamp2:MercLeader/CompCommand#{rand(2)}",0,2,0)
			end
			show_npc_info(get_character(0),extra_info=false,"\\optB[#{cmd_text}]")
	
			$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
			$game_temp.choice = -1
	
	case tmpPicked
		when "Follow"
			SndLib.sound_QuickDialog 
			$game_map.popup(get_character(0).id,"QuickMsg:NPC/CommandFollow#{rand(2)}",0,0)
			get_character(0).follower[1] =1
	
		when "Wait"
			SndLib.sound_QuickDialog 
			$game_map.popup(get_character(0).id,"QuickMsg:NPC/CommandWait#{rand(2)}",0,0)
			get_character(0).follower[1] =0
	end
end
eventPlayEnd