
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
		
		
		if $story_stats["RecQuestLisa"].between?(14,17)
			call_msg("CompLisa:Lisa14/CommonConvoyTarget#{rand(3)}",0,2,0)
		else
			call_msg("CompLisa:NPC/CommonConvoyTarget#{rand(3)}",0,2,0)
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



eventPlayEnd

