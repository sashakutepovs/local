if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).call_balloon(0)
#初次見面對話
tmpTo2fDoorX,tmpTo2fDoorY,tmpTo2fDoorID=$game_map.get_storypoint("To2fDoor")
tmpQUrec =  $story_stats["RecQuestNorthFL_Main"]
if $story_stats["RecQuestNorthFL_Main"] == 0
	$story_stats["RecQuestNorthFL_Main"] = 1
	call_msg("TagMapNorthFL:SGT/RecQuestNorthFL0_Main_begin0")
	if $game_player.player_slave? || $game_player.actor.sexy >= 25
		call_msg("TagMapNorthFL:SGT/RecQuestNorthFL0_Main_begin1_slave")
	else
		call_msg("TagMapNorthFL:SGT/RecQuestNorthFL0_Main_begin1_basic")
	end
end
#若初次見面的額外對話
call_msg("TagMapNorthFL:SGT/RecQuestNorthFL0_Main_begin2") if tmpQUrec == 0

#交還MAIL  回報
if [4,100].include?($story_stats["RecQuestNorthFL_AtkOrkCamp2"])
	$story_stats["RecQuestNorthFL_AtkOrkCamp2"] = 101
	get_character(tmpTo2fDoorID).call_balloon(0)
	call_msg("TagMapNorthFL:SGT/RecQuestNorthFL101_done0")
	if $story_stats["UniqueChar_NFL_MerCamp_Leader"] == -1
		$story_stats["RecQuestNorthFL_Main"] = 8
		call_msg("TagMapNorthFL:SGT/RecQuestNorthFL101_done1_dead0")
		call_msg("TagMapNorthFL:SGT/RecQuestNorthFL101_done1_dead1")
	else
		$story_stats["RecQuestNorthFL_Main"] = 9
		call_msg("TagMapNorthFL:SGT/RecQuestNorthFL101_done1_alive")
	end
	call_msg("TagMapNorthFL:SGT/RecQuestNorthFL101_done2")
	call_msg("TagMapNorthFL:SGT/RecQuestNorthFL101_done3")
	optain_item("ItemCoin2",1)
	wait(30)
	call_msg("TagMapNorthFL:SGT/RecQuestNorthFL3_begin2")
	optain_exp(6000)
	
#燒毀穀倉
elsif $story_stats["RecQuestNorthFL_Main"] == 1
	call_msg("TagMapNorthFL:SGT/RecQuestNorthFL1_Main_begin0")
	call_msg("TagMapNorthFL:SGT/RecQuestNorthFL1_QuBoard")
	call_msg("common:Lona/Decide_optB")
	if $game_temp.choice == 1
		#accept
		$story_stats["RecQuestNorthFL_Main"] = 2
		call_msg("TagMapNorthFL:SGT/RecQuestNorthFL1_accept")
	else
		call_msg("TagMapNorthFL:SGT/RecQuestNorthFL1_no")
	end
	
#	燒毀穀倉  DONE
elsif $story_stats["RecQuestNorthFL_Main"] == 3
	$story_stats["RecQuestNorthFL_Main"] = 4
	get_character(tmpTo2fDoorID).call_balloon(0)
	call_msg("TagMapNorthFL:SGT/RecQuestNorthFL3_begin0")
	call_msg("TagMapNorthFL:SGT/RecQuestNorthFL3_begin1")
	portrait_hide
	optain_item("ItemCoin2",3)
	wait(30)
	optain_item("ItemCoin1",5)
	wait(30)
	optain_exp(10000)
	call_msg("TagMapNorthFL:SGT/RecQuestNorthFL3_begin2")
	
	#合戰 NFLorkindCamp2 quest
elsif $story_stats["RecQuestNorthFL_Main"] >= 4
	call_msg("TagMapNorthFL:SGT/RecQuestNorthFL_Common")
	$game_temp.choice = 0
	tmpPicked = ""
	until tmpPicked == "Cancel" || $game_temp.choice == -1
		tmpQuestList = []
		tmpQuestList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
		tmpQuestList << [$game_text["commonNPC:commonNPC/About"]				,"OPT_About"]	if $story_stats["RecQuestNorthFL_Main"] >= 4
		tmpQuestList << [$game_text["TagMapNorthFL:SGT/OPT_Salt"]				,"OPT_Salt"]	if $story_stats["RecQuestNorthFL_Main"] >= 5
		tmpQuestList << [$game_text["commonNPC:commonNPC/Work"]					,"OPT_Work"] 	if $story_stats["RecQuestNorthFL_Main"] == 6
		cmd_sheet = tmpQuestList
		cmd_text =""
		for i in 0...cmd_sheet.length
			cmd_text.concat(cmd_sheet[i].first+",")
		end
		call_msg("TagMapNorthFL:SGT/RecQuestNorthFL_Common1",0,2,0)
		call_msg("\\optB[#{cmd_text}]")
		$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
		
		case tmpPicked
			when "OPT_About"
				$story_stats["RecQuestNorthFL_Main"] = 5 if $story_stats["RecQuestNorthFL_Main"] == 4
				call_msg("TagMapNorthFL:SGT/Ans_about_1_0")
				
			when "OPT_Salt"
				$story_stats["RecQuestNorthFL_Main"] = 6 if $story_stats["RecQuestNorthFL_Main"] == 5
				call_msg("TagMapNorthFL:SGT/Ans_about_1_1")
				
			when "OPT_Work"
				call_msg("TagMapNorthFL:SGT/RecQuestNorthFL4_info")
				call_msg("TagMapNorthFL:SGT/RecQuestNorthFL4_brd")
				call_msg("common:Lona/Decide_optB")
				if $game_temp.choice ==1
					$story_stats["RecQuestNorthFL_Main"] = 7 if $story_stats["RecQuestNorthFL_Main"] == 6
					call_msg("TagMapNorthFL:SGT/RecQuestNorthFL1_opt_accept")
					optain_item("ItemQuestRecQuestNorthFL4",1)
					$game_temp.choice = -1
				else
					call_msg("TagMapNorthFL:SGT/RecQuestNorthFL4_opt_no")
					$game_temp.choice = -1
				end
		end
	end
	$game_temp.choice = -1
else
	call_msg("TagMapNorthFL:SGT/else_common")
end
eventPlayEnd



return get_character(0).call_balloon(28,-1) if [4,100].include?($story_stats["RecQuestNorthFL_AtkOrkCamp2"]) #return mail
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestNorthFL_Main"] == 0
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestNorthFL_Main"] == 1
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestNorthFL_Main"] == 4 #NFLorkindCamp2 quest
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestNorthFL_Main"] == 5 #NFLorkindCamp2 quest
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestNorthFL_Main"] == 6 #NFLorkindCamp2 quest
