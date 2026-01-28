if $game_party.has_item?($data_items[126]) && $story_stats["RecQuestBC2_SideQu"] == 8
	get_character(0).call_balloon(0)
	call_msg("TagMapBC2_SideQu:QuGiver9/Begin0")
	optain_lose_item($data_items[126],1)
	$story_stats["RecQuestBC2_SideQu"] = 9
	call_msg("TagMapBC2_SideQu:QuGiver9/Begin1")
	call_msg("TagMapBC2_SideQu:QuGiver9/Begin2")
	
else
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
			if $story_stats["RecQuestBC2_SideQu"] < 8
				call_msg("TagMapBC2_SideQu:NPC/CommonConvoyTarget7",0,2,0)
			else
				call_msg("TagMapBC2_SideQu:NPC/CommonConvoyTarget8")
				call_msg(".......",0,2,0)
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

