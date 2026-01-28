if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end



tmpPicked = ""
tmpQuestList = []
tmpQuestList << [$game_text["commonNPC:commonNPC/Cancel"]			,"Cancel"]
tmpQuestList << [$game_text["menu:equip/def"]						,"DEF"]
tmpQuestList << [$game_text["menu:equip/sur"]						,"SUR"]
tmpQuestList << [$game_text["menu:sex_stats/record_Rebirth"]		,"reset"]
#tmpQuestList << ["1	"		,"Cancel"]
#tmpQuestList << ["2	"					,"DEF"]
#tmpQuestList << ["3	"					,"SUR"]
#tmpQuestList << ["4	"	,"reset"]
#tmpQuestList << ["11"			,"Cancel"]
#tmpQuestList << ["22"						,"DEF"]
#tmpQuestList << ["33"						,"SUR"]
#tmpQuestList << ["44"		,"reset"]
		cmd_sheet = tmpQuestList
		cmd_text =""
		for i in 0...cmd_sheet.length
			cmd_text.concat(cmd_sheet[i].first+",")
			p cmd_text
		end
		show_npc_info(get_character(0),extra_info=false,"\\optB[#{cmd_text}]")

		$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
		$game_temp.choice = -1

case tmpPicked
	when "DEF"
		$game_variables[1] = 0
		setup_num_input([1,2])
		$game_map.interpreter.wait_for_message
		wait(20)
		get_character(0).npc.set_def($game_variables[1])
		$game_variables[1] = 0
		get_character(0).npc.refresh
		SndLib.stoneCollapsed(90+rand(11),80)
		get_character(0).effects=["CutTree",0,false,nil,nil]
	when "SUR"
		setup_num_input([1,2])
		$game_map.interpreter.wait_for_message
		wait(20)
		get_character(0).npc.set_survival($game_variables[1])
		$game_variables[1] =0
		get_character(0).npc.refresh
		SndLib.stoneCollapsed(90+rand(11),150)
		get_character(0).effects=["CutTree",0,false,nil,nil]
		
	when "reset"
		$game_map.delete_npc(get_character(0))
		get_character(0).set_npc("NeutralSandbagImmortal")
		SndLib.stoneCollapsed(90+rand(11),100)
		get_character(0).effects=["CutTree",0,false,nil,nil]
end





