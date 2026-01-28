return if $story_stats["RecQuestSMRefugeeCampCBT"] == -1
if $game_map.threat
 SndLib.sys_buzzer
 $game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
 return
end

tmpPrice = $story_stats["HiddenOPT1"] = 200
tmpDuabBiosID=$game_map.get_storypoint("DualBios")[2]

if get_character(tmpDuabBiosID).summon_data[:Payed] == false
	call_msg("TagMapSMRefugeeCamp:Hunter/begin")
else
	call_msg("TagMapSMRefugeeCamp:Hunter/begin_Payed")
end
tmpGotoTar = ""
tmpTarList = []
tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
tmpTarList << [$game_text["TagMapSMRefugeeCamp:Hunter/Pay"]			,"Pay"] if get_character(tmpDuabBiosID).summon_data[:Payed] == false
tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"]
tmpTarList << [$game_text["TagMapSMRefugeeCamp:HunterOpt/About"]	,"About"]
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
			manual_barters("SMRefugeeCamp_Hunter")
			
		when "Pay"
			tmpPP = 0
			SceneManager.goto(Scene_ItemStorage)
			SceneManager.scene.prepare(System_Settings::STORAGE_TEMP)
			wait(1)
			tmpPP = $game_boxes.get_price(System_Settings::STORAGE_TEMP)
			if tmpPP >= tmpPrice
				get_character(tmpDuabBiosID).summon_data[:Payed] = true
				$game_boxes.box(System_Settings::STORAGE_TEMP).clear
				call_msg("TagMapSMRefugeeCamp:Hunter/PayPass")
			else
				call_msg("TagMapSMRefugeeCamp:Hunter/PayNotEnough")
			end
		when "About"
			call_msg("TagMapSMRefugeeCamp:Hunter/AboutDialog")
end

$story_stats["HiddenOPT1"] = "0"
eventPlayEnd
