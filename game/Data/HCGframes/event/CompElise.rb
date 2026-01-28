if $game_player.actor.stat["equip_head"] == "DocHead"
	SndLib.sound_QuickDialog
	$game_map.popup(get_character(0).id,"CompElise:BirbMaskedLona/Qmsgpop#{rand(5)}",0,0)
	get_character(0).call_balloon([5,6,7].sample)
	get_character(0).move_away_from_character($game_player) if !get_character(0).moving?
	get_character(0).turn_toward_character($game_player)
	return
end

if $game_party.has_item?($data_items[107]) && $story_stats["RecQuestElise"] ==4 && $story_stats["RecQuestConvoyTarget"].include?($story_stats["OnRegionMap_Regid"])
	get_character(0).call_balloon(0)
	$story_stats["RecQuestElise"] =5
	$story_stats["RecQuestEliseAmt"] = 6+$game_date.dateAmt
	call_msg("CompElise:RecQuestElise4/ReturnQ0")
	optain_lose_item($data_items[107],1)
	call_msg("CompElise:RecQuestElise4/ReturnQ1")
	optain_item($data_items[51],6)
	call_msg("CompElise:RecQuestElise4/ReturnQ2")
	optain_exp(5000*2)
	eventPlayEnd
	chcg_background_color(0,0,0,0,7)
		portrait_hide
		get_character(0).set_this_companion_disband
	chcg_background_color(0,0,0,255,-7)
	GabeSDK.getAchievement("RecQuestElise_5")
	
elsif $game_party.has_item?($data_items[120]) && $story_stats["RecQuestElise"] == 17 && $story_stats["RecQuestConvoyTarget"].include?($story_stats["OnRegionMap_Regid"])
	get_character(0).call_balloon(0)
	$story_stats["RecQuestElise"] =18
	$story_stats["RecQuestEliseAmt"] = 6+$game_date.dateAmt
	call_msg("CompElise:FishResearch1/17_End1")
	optain_lose_item($data_items[120],1)
	call_msg("CompElise:FishResearch1/17_End2")
	optain_item($data_items[52],3)
	call_msg("CompElise:FishResearch1/17_End3")
	optain_exp(20000)
	eventPlayEnd
	chcg_background_color(0,0,0,0,7)
		portrait_hide
		get_character(0).set_this_companion_disband
	chcg_background_color(0,0,0,255,-7)
	GabeSDK.getAchievement("RecQuestElise_18")
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
			call_msg("common:Lona/CompCommand",0,2,0)
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




