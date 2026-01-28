if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).call_balloon(0)
get_character(0).animation = nil
call_msg("TagMapMT_crunch:Priest/begin0")
tmpCrunchDoorX,tmpCrunchDoorY,tmpCrunchDoorID = $game_map.get_storypoint("CrunchDoor")
tmpGateKeeperX,tmpGateKeeperY,tmpGateKeeperID = $game_map.get_storypoint("GateKeeper")
################################################################## 尋找醫師
if $story_stats["RecQuestMT_findDoc"] == 3
	call_msg("TagMapMT_crunch:Priest/doctor_Done0")
	$story_stats["RecQuestMT_findDoc"] = 4
	portrait_hide
	optain_item($data_items[51],2) if !$game_player.player_slave?
	wait(30)
	optain_exp(4500)
	wait(30)
	optain_morality(1)
	
################################################################## 殺光不死族
elsif get_character(0).summon_data[:UndeadDone] == true && $story_stats["RecQuestMT_UndeadQu"] == 2
	get_character(tmpCrunchDoorID).call_balloon(0)
	call_msg("TagMapMT_crunch:Priest/KillAllUndead0")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		wait(60)
	chcg_background_color(0,0,0,255,-7)
	$story_stats["RecQuestMT_UndeadQu"] = 3
	call_msg("TagMapMT_crunch:Priest/KillAllUndead1") ; portrait_hide
	optain_item($data_items[51],2) if !$game_player.player_slave?
	wait(30)
	optain_exp(4500)
	wait(30)
	optain_morality(1)
	call_msg("TagMapMT_crunch:Priest/KillAllUndead2")
else
	tmpUndeadQU = $story_stats["RecQuestMT_UndeadQu"] == 1
	tmpFindDocQU = $story_stats["RecQuestMT_findDoc"] == 1
	tmpSaintMonasteryQU = $story_stats["RecQuestSaintMonasteryToMT_crunch"] == 1
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]						,"Cancel"]
	tmpTarList << [$game_text["TagMapMT_crunch:Priest/opt_MT_crunch"]			,"opt_MT_crunch"]
	tmpTarList << [$game_text["TagMapMT_crunch:Priest/opt_Undead"]				,"opt_Undead"]				if tmpUndeadQU
	tmpTarList << [$game_text["TagMapMT_crunch:Priest/opt_Doctor"]				,"opt_Doctor"]				if tmpFindDocQU
	tmpTarList << [$game_text["TagMapMT_crunch:Priest/opt_SaintMonastery"]		,"opt_SaintMonastery"]		if tmpSaintMonasteryQU
	tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]						,"Barter"]
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	#call_msg("commonNPC:MaleHumanRandomNpc/CommonHuman_CommonNpcOpt",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
	
	case tmpPicked
		when "Cancel"
			$game_temp.choice = -1
		when "opt_MT_crunch"
			call_msg("TagMapMT_crunch:Priest/Ans_crunch")
			$story_stats["RecQuestMT_findDoc"] = 1 if $story_stats["RecQuestMT_findDoc"] == 0 
			$story_stats["RecQuestMT_UndeadQu"] = 1 if $story_stats["RecQuestMT_UndeadQu"] == 0 
			
		when "opt_Doctor"
			if $game_player.actor.weak < 25
				call_msg("TagMapMT_crunch:Priest/Ans_doctor")
				call_msg("TagMapMT_crunch:Priest/Ans_doctor_brd")
				call_msg("common:Lona/Decide_optB")
				if $game_temp.choice == 1
					$story_stats["RecQuestMT_findDoc"] = 2
					call_msg("TagMapMT_crunch:Priest/Ans_accept")
				end
			else
				call_msg("TagMapMT_crunch:Priest/TooWeak")
			end
			
			
			
		when "opt_Undead"
			if $game_player.actor.weak < 25
				call_msg("TagMapMT_crunch:Priest/Ans_Undead")
				call_msg("TagMapMT_crunch:Priest/Ans_Undead_brd")
				call_msg("common:Lona/Decide_optB")
				if $game_temp.choice == 1
					$story_stats["RecQuestMT_UndeadQu"] = 2
					call_msg("TagMapMT_crunch:Priest/Ans_accept")
					get_character(tmpGateKeeperID).call_balloon(28,-1)
				end
			else
				call_msg("TagMapMT_crunch:Priest/TooWeak")
			end
		
		when "opt_SaintMonastery"
			get_character(tmpCrunchDoorID).call_balloon(0)
			call_msg("TagMapMT_crunch:Lona/Ans_SaintMonastery")
			$story_stats["RecQuestSaintMonasteryToMT_crunch"] = 2
			
		when "Barter"
			manual_barters("MT_crunch_Priest")
	end
end
call_msg("TagMapMT_crunch:Priest/EndTalk")
eventPlayEnd


$story_stats["RecQuestSaintMonasteryToMT_crunch"] == 1			? get_character(tmpCrunchDoorID).call_balloon(28,-1) : get_character(tmpCrunchDoorID).call_balloon(0)
get_character(0).summon_data[:UndeadDone] == true				? get_character(tmpCrunchDoorID).call_balloon(28,-1) : get_character(tmpCrunchDoorID).call_balloon(0)
$story_stats["RecQuestMT_findDoc"] == 3							? get_character(tmpCrunchDoorID).call_balloon(28,-1) : get_character(tmpCrunchDoorID).call_balloon(0)
get_character(0).call_balloon(28,-1) if get_character(0).summon_data[:UndeadDone] == true && $story_stats["RecQuestMT_UndeadQu"] == 2
get_character(0).call_balloon(28,-1) if $story_stats["RecQuestSaintMonasteryToMT_crunch"] == 1
get_character(0).call_balloon(28,-1) if $story_stats["RecQuestMT_findDoc"] == 1
