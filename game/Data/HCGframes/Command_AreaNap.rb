if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
	##################################################################################################		旅店
	#add_data_event name  , item ID
	#tmpMapNameKey=[
	#	["NoerTavern",106],
	#	["PirateBaneInn",114],
	#	["DoomFortressInn",116],
	#	["FishTownInn",119],
	#	["SouthFL_INN",125],
	#	["NorthFL_INN",129]]
	##是否是旅店
	#tmpItemIcon = 0
	#tmpKeyNumber = 0
	#tmpNeedKey = tmpMapNameKey.any?{|tmpAry|
	#	next unless tmpAry[0] == $game_map.add_data["event"]
	#	tmpItemIcon = $data_items[tmpAry[1]].icon_index
	#	tmpKeyNumber = $game_party.item_number($data_items[tmpAry[1]])
	#	break true
	#}
	tmpNeedKey= false
	tmpKeyNumber = 0
	tmpItemIcon = 0
	[["NoerTavern"		,106],
	["PirateBaneInn"	,114],
	["DoomFortressInn"	,116],
	["FishTownInn"		,119],
	["SouthFL_INN"		,125],
	["NorthFL_INN"		,129]].each{ |itr|
		next unless itr[0] == $game_map.add_data["event"]
		tmpItemIcon = $data_items[itr[1]].icon_index
		tmpNeedKey = true
		tmpKeyNumber = $game_party.item_number($data_items[itr[1]])
		break
	}
	##################################################################################################		旅店
	
	temp_groin_cums = $game_player.actor.cumsMeters["CumsCreamPie"] + $game_player.actor.cumsMeters["CumsMoonPie"] >=1
	temp_milk_level = $game_player.actor.lactation_level >=300
	temp_gameover = $story_stats["Ending_MainCharacter"] !=0
	
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Sleep"]				,"Sleep"]
	tmpTarList << [$game_text["commonCommands:Lona/BasicNeedsOpt_CleanPrivates"]		,"CleanPrivates"] if temp_groin_cums
	tmpTarList << [$game_text["commonCommands:Lona/BasicNeedsOpt_CollectMilk"]			,"CollectMilk"] if temp_milk_level
	tmpTarList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Gameover"]				,"Gameover"] if temp_gameover
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	if tmpNeedKey
		$story_stats["HiddenOPT0"] = tmpItemIcon
		$story_stats["HiddenOPT1"] = tmpKeyNumber
		call_msg("commonCommands:Inn/GetInnKey",0,2,0)
	else
		call_msg("commonCommands:Lona/Nap_begin",0,2,0)
	end
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
	$story_stats["HiddenOPT0"] = 0
	$story_stats["HiddenOPT1"] = 0
	case tmpPicked
		when "Sleep"
			$game_player.animation = $game_player.animation_stun
			$game_player.call_balloon(12,-1)
			call_msg("......")
			load_script("Data/Batch/birth_trigger.rb") if $game_player.actor.preg_level == 5
			return $game_map.napEventId.nil? ?  handleNap : $game_map.call_nap_event
			
		when "CleanPrivates"	; load_script("Data/HCGframes/Command_GroinClearn.rb")
		when "CollectMilk"		; load_script("Data/HCGframes/Command_SelfMilking.rb")
		when "Gameover" 		;
			call_msg("commonCommands:Lona/Nap_RapeLoop_begin2#{talk_style}")
			call_msg("commonCommands:Lona/Nap_RapeLoop_begin2_opt#{talk_style}") # no ,yes
			load_script("Data/HCGframes/event/Ending_loaderBad.rb") if $game_temp.choice == 1
	end

eventPlayEnd
