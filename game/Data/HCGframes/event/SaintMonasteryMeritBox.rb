if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
tmpPP = 0

################################################################ 尋找湯米的任務
if $story_stats["RecQuestSMRefugeeCampFindChild"] == 5 && get_character(0).summon_data[:QuprogTommy] == 5
	get_character(0).call_balloon(0)
	$story_stats["RecQuestSMRefugeeCampFindChild"] = 6
	call_msg("TagMapSaintMonastery:MIAchildMAMA/prog5") 
	portrait_hide
	$game_player.direction = 2
	$game_player.call_balloon(8)
	wait(60)
	call_msg("TagMapSaintMonastery:MIAchildMAMA/prog5_1")
	return eventPlayEnd

################################################################ common
else
	call_msg("TagMapSaintMonastery:Merit/begin1")
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]					,"Cancel"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]					,"Barter"]
	tmpTarList << [$game_text["commonNPC:commonNPC/opt_ex_Donation"]		,"Donation"]
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
		when "Barter"
			if $story_stats["RecordBaptizeByPriest"] >= 4 || $game_player.actor.record_lona_title == "WhoreJob/SaintBeliever"
				call_msg("TagMapSaintMonastery:Merit/Barter_begin1_success")
				manual_barters("SaintMonasteryMeritBox")
			else
				call_msg("TagMapSaintMonastery:Merit/Barter_begin1_failed")
			end
		when "Donation"
			call_msg("TagMapSaintMonastery:Merit/Box1")
			wait(10)
			SceneManager.goto(Scene_ItemStorage)
			SceneManager.scene.prepare(System_Settings::STORAGE_TEMP)
			call_msg("TagMapSaintMonastery:Merit/Box2")
			tmpPP = $game_boxes.get_price(System_Settings::STORAGE_TEMP)
			tmpPP > 0 ? tmpMoralityPlus = tmpPP / 2000 : tmpMoralityPlus = 0
			if tmpMoralityPlus >=1
				optain_morality(tmpMoralityPlus)
				call_msg("TagMapSaintMonastery:Merit/END_Good")
			elsif tmpPP > 0
				call_msg("TagMapSaintMonastery:Merit/END_Bad")
			end
			$game_boxes.box(System_Settings::STORAGE_TEMP).clear
	end
end
eventPlayEnd
