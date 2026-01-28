if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end


tmpPicked = ""
tmpQuestList = []
tmpQuestList << [$game_text["commonNPC:commonNPC/Cancel"]			,"Cancel"]
tmpQuestList << [$game_text["commonNPC:commonNPC/Chat"]				,"Chat"]
tmpQuestList << [$game_text["commonNPC:commonNPC/Barter"]			,"Barter"]
tmpQuestList << [$game_text["commonNPC:commonNPC/Storage"]			,"Storage"]
cmd_sheet = tmpQuestList
cmd_text =""
for i in 0...cmd_sheet.length
	cmd_text.concat(cmd_sheet[i].first+",")
	p cmd_text
end
call_msg("TagMapBank:Maani/begin1_unknow",0,2,0) if $story_stats["RecordMaaniFirstTimeTalked"] == 0
call_msg("TagMapBank:Maani/begin1_talked",0,2,0) if $story_stats["RecordMaaniFirstTimeTalked"] != 0
show_npc_info(get_character(0),extra_info=false,"\\optB[#{cmd_text}]")

$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
$game_temp.choice = -1


case tmpPicked
	when "Chat"
	call_msg("TagMapBank:Maani/begin2_about")
	$story_stats["RecordMaaniFirstTimeTalked"] = 1
	
	when "Barter"
		manual_barters("NoerBankMaani")
	when "Storage"
		SceneManager.goto(Scene_BankStorage)
		SceneManager.scene.prepare(System_Settings::STORAGE_BANK)
		achCheckBankTP
end


eventPlayEnd
