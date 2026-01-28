
map_background_color(0,0,0,255,0)
tmpPicked = nil

tmpGotoTar = ""
tmpTarList = []
tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]		,"Cancel"]
tmpTarList << [$game_text["DataNpcName:race/Human"]			,"Human"]				if $story_stats["Rebirth_Lost_PlayerHumanBaby"] >= 1	|| $game_party.has_item?("PlayerHumanBaby")
tmpTarList << [$game_text["DataNpcName:race/Moot"]			,"Moot"]				if $story_stats["Rebirth_Lost_PlayerMootBaby"] >= 1		|| $game_party.has_item?("PlayerMootBaby")
tmpTarList << [$game_text["DataNpcName:race/DeeponeLona"]	,"Deepone"]				if $story_stats["Rebirth_Lost_PlayerDeeponeBaby"] >= 1	|| $game_party.has_item?("PlayerDeeponeBaby")
tmpTarList << [$game_text["DataNpcName:race/AbomLona"]		,"HumanAbomination"]	if $story_stats["RecQuestEliseAbomBabySale"] >= 2
tmpTarList << [$game_text["DataNpcName:race/AbomMootLona"]	,"MootAbomination"]		if $story_stats["RecQuestEliseAbomBabySale"] >= 4
#tmpTarList = tmpTarList.shuffle
return unless tmpTarList.length >= 2
	call_msg("commonEnding:Lona/hp0_WithChild")
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	#call_msg("TagMapDoomFortress:InnKeeper/Begin",0,2,0)
	call_msg("\\optD[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
	
	if ![nil,"Cancel",false].include?(tmpPicked)
		$game_player.actor.build_inheritance_data(tmpPicked)
		call_msg("commonEnding:Lona/hp0_WithChild_choosed0")
		SceneManager.goto(Scene_RebirthOptions)
		wait(1)
		call_msg("commonEnding:Lona/hp0_WithChild_choosed1")
		chcg_background_color(255,255,255,0,7)
	else
		call_msg("commonEnding:Lona/hp0_WithChild_canceled")
		portrait_hide
		wait(30)
		portrait_off
		wait(1)
	end
