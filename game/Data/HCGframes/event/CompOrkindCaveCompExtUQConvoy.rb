if $story_stats["RecQuestConvoyTarget"].include?($story_stats["OnRegionMap_Regid"])
	$story_stats["QuProgScoutCampOrkind3"] = 2
	call_msg("TagMapScoutCampOrkind:CommonConvoyTarget/Arrivel")
	optain_exp(2000*2)
	wait(30)
	optain_morality(5)
	chcg_background_color(0,0,0,0,7)
	get_character(0).set_this_companion_disband
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapScoutCampOrkind:CommonConvoyTarget/Arrivel1")
	if $game_map.add_data["event"] == "NoerTavern"
		tmpID = $game_map.get_storypoint("GuildEmpolyee")[2]
		get_character(tmpID).call_balloon(28,-1)
	end
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
			call_msg("TagMapScoutCampOrkind:CommonConvoyTarget/CommonConvoyTarget",0,2,0)
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




$game_temp.choice = -1
portrait_hide
