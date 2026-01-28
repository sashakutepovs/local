if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).call_balloon(0)

if $story_stats["RecQuestPenisTribeHelp"] == 3 #todooooooooooooooooooooooooooooooooo
	get_character(0).npc_story_mode(true)
	optain_lose_item($data_items[124],$game_party.item_number($data_items[124])) #ItemQuestBoarPenis
	wait(15)
	$game_player.set_animation("animation_atk_sh")
	call_msg("TagMapPenisTribe:Witch/BoarPenid_End0")
	call_msg("TagMapPenisTribe:Witch/BoarPenid_End1")
	get_character(0).set_animation("animation_atk_sh")
	wait(15)
	optain_item($data_armors[35],1) #ItemPaintHead
	wait(30)
	optain_exp(9000)
	wait(30)
	get_character(0).npc_story_mode(false)
	call_msg("TagMapPenisTribe:Witch/BoarPenid_End2")
	$story_stats["RecQuestPenisTribeHelp"] = 4
else
		call_msg("TagMapPenisTribe:WitchOPT/Begin")
		tmpGotoTar = ""
		tmpTarList = []
		tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
		tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"]
		tmpTarList << [$game_text["TagMapPenisTribe:WitchOPT/AboutHere"]			,"AboutHere"]
		tmpTarList << [$game_text["TagMapPenisTribe:WitchOPT/AboutDedOne"]			,"AboutDedOne"] if $story_stats["RecQuestPenisTribeHelp"] >= 2
		tmpTarList << [$game_text["TagMapPenisTribe:WitchOPT/AboutWhyMe"]			,"AboutWhyMe"] if $story_stats["RecQuestPenisTribeHelp"] == 1
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
				manual_barters("PenisTribeWitch")
				
			when "AboutHere"
				call_msg("TagMapPenisTribe:WitchOPT/AboutHere0")
				
			when "AboutDedOne"
				call_msg("TagMapPenisTribe:WitchOPT/AboutDedOne0")
				
			when "AboutWhyMe"
				call_msg("TagMapPenisTribe:WitchOPT/AboutWhyMe0")
				call_msg("TagMapPenisTribe:WitchOPT/AboutWhyMe1")
				call_msg("common:Lona/Decide_optB") #算了,決定
				if $game_temp.choice == 1
					$story_stats["RecQuestPenisTribeHelp"] = 2
					call_msg("TagMapPenisTribe:WitchOPT/AboutWhyMe2_yes")
				end
				
				
		end
end
call_msg("TagMapPenisTribe:WitchOPT/End")
eventPlayEnd

#check balloon
get_character(0).call_balloon(28,-1) if $story_stats["RecQuestPenisTribeHelp"] == 1
