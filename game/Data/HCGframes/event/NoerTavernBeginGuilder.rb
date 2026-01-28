if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
tmp_BeginGuide = $story_stats["RecordFirstFollower"] >= 1 && get_character(0).summon_data[:BeginGuideAble] == true
if !tmp_BeginGuide
	SndLib.sound_QuickDialog
	$game_map.popup(get_character(0).id,"........",0,0)
	return
end
if $story_stats["RecordFirstFollower"] ==  1
	call_msg("TagMapNoerTavernQuest:GuideTheWorld/begin")
	$story_stats["RecordFirstFollower"] = 2
end

until false
	$cg.erase
	$bg.erase
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]										,"Cancel"]
	tmpTarList << [$game_text["commonComp:Companion/TeamUp"]									,"TeamUp"]
	tmpTarList << [$game_text["menu:main_stats/race"]											,"Race"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]										,"Barter"]
	tmpTarList << [$game_text["menu:equip/scu"]													,"scu"]
	tmpTarList << [$game_text["menu:main_stats/level"]											,"LVL"]
	tmpTarList << [$game_text["menu:body_stats/common_wound"]									,"Wound"]
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("TagMapNoerTavernQuest:GuideTheWorld/Choose",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	
	break if $game_temp.choice == -1
	$game_temp.choice = -1
	
	case tmpPicked
		when "TeamUp"
			call_msg("TagMapNoerTavernQuest:GuideTheWorld/opt_TeamUp")
			
		when "Race"
			call_msg("TagMapNoerTavernQuest:GuideTheWorld/opt_Race")
			
		when "LVL"
			portrait_hide
			call_msg("MainTownSewer:Tutorial/LVL")
			call_msg("MainTownSewer:Tutorial/STA")
			call_msg("MainTownSewer:Tutorial/SAT")
			
		when "scu"
			portrait_hide
			call_msg("MainTownSewer:system/SneakT1")
			call_msg("MainTownSewer:system/SneakT2")
			call_msg("MainTownSewer:system/SneakT3")
			call_msg("MainTownSewer:Tutorial/Sap")
		when "Barter"
			call_msg("TagMapNoerTavernQuest:TradeTur/fristTime0")
		when "Wound"
			portrait_hide
			call_msg("TagMapNoerTavernQuest:WoundTur/0")
		else
			call_msg("TagMapNoerTavernQuest:GuideTheWorld/end1")
			break
	end
end
if $story_stats["RecordFirstFollower"] == 2
	$story_stats["RecordFirstFollower"] = 3
	call_msg("TagMapNoerTavernQuest:GuideTheWorld/end2")
end

$cg.erase
$bg.erase
eventPlayEnd
