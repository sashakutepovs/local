if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

#Still in progress
if $story_stats["NFL_BridgeBunkerBat"] == 1
	call_msg("NFL_BridgeBunker:BatHouseMan/NFL_BridgeBunkerBat_QUprog0")
	return eventPlayEnd
elsif $story_stats["NFL_BridgeBunkerBat"] < 3
	call_msg("NFL_BridgeBunker:BatHouseMan/Begin_b4BatQu#{rand(2)}")
elsif $story_stats["NFL_BridgeBunkerBat"] == 1 #in progress
	call_msg("NFL_BridgeBunker:BatHouseMan/NFL_BridgeBunkerBat_QUprog1")
	return eventPlayEnd
elsif $story_stats["NFL_BridgeBunkerBat"] == 4 #after progress.
	call_msg("NFL_BridgeBunker:BatHouseMan/Begin_afterBatQu#{rand(2)}")
	return eventPlayEnd
end
tmpPicked = ""
$game_temp.choice = 0
until tmpPicked == "Cancel" || $game_temp.choice == -1
	tmpQuestList = []
	tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Cancel"]				,"Cancel"]
	tmpQuestList << [$game_text["NFL_BridgeBunker:BatHouseMan/opt_about"]			,"About"] if $story_stats["NFL_BridgeBunkerBat_FirstTalked"] == 0 && $story_stats["NFL_BridgeBunkerBat"] < 1
	tmpQuestList << [$game_text["NFL_BridgeBunker:BatHouseMan/opt_Bat"]				,"Bat"] if $story_stats["NFL_BridgeBunkerBat_FirstTalked"] == 1 && $story_stats["NFL_BridgeBunkerBat"] < 1
	tmpQuestList << [$game_text["NFL_BridgeBunker:BatHouseMan/opt_Quest"]			,"Quest"] if $story_stats["NFL_BridgeBunkerBat_FirstTalked"] == 2 && $story_stats["NFL_BridgeBunkerBat"] == 0
	tmpQuestList << [$game_text["NFL_BridgeBunker:BatHouseMan/opt_Report"]			,"Report"] if $story_stats["NFL_BridgeBunkerBat"] == 2
	tmpQuestList << [$game_text["NFL_BridgeBunker:BatHouseMan/opt_reward"]			,"Reward"] if $story_stats["NFL_BridgeBunkerBat"] == 3
	cmd_sheet = tmpQuestList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("commonNPC:MaleHumanRandomNpc/CommonHuman_CommonNpcOpt",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	#$game_temp.choice = -1
	case tmpPicked
		when "About"
			$story_stats["NFL_BridgeBunkerBat_FirstTalked"] = 1 if $story_stats["NFL_BridgeBunkerBat_FirstTalked"] == 0
			call_msg("NFL_BridgeBunker:BatHouseMan/opt_about_ans")
		when "Bat"
			#too weak or being slave. he dont want talk about it.
			if $game_player.player_slave? || $game_player.actor.weak >= 50
				call_msg("NFL_BridgeBunker:BatHouseMan/opt_about_ans_TooWeak")
			else
				$story_stats["NFL_BridgeBunkerBat_FirstTalked"] = 2 if $story_stats["NFL_BridgeBunkerBat_FirstTalked"] == 1
				call_msg("NFL_BridgeBunker:BatHouseMan/opt_bat_ans1_PassedChk")
			end

		when "Quest" # take quest
			#first prog
			if $story_stats["NFL_BridgeBunkerBat"] == 0
			#too weak or being slave. he dont want talk about it.
				if $game_player.player_slave? || $game_player.actor.weak >= 50
					call_msg("NFL_BridgeBunker:BatHouseMan/opt_Quest_ans_TooWeak")
					return eventPlayEnd
				end
				call_msg("NFL_BridgeBunker:BatHouseMan/opt_Quest_ans0")
				call_msg("NFL_BridgeBunker:BatHouseMan/BatQU_board")
				call_msg("common:Lona/Decide_optB")
				if $game_temp.choice == 1
					$story_stats["NFL_BridgeBunkerBat"] = 1
					tmpX,tmpY,tmpID=$game_map.get_storypoint("BatHouse")
					get_character(tmpID).call_balloon(28,-1)
					call_msg("NFL_BridgeBunker:BatHouseMan/opt_Quest_ans0_optYes")
					break
				else
					call_msg("NFL_BridgeBunker:BatHouseMan/opt_Quest_ans0_optNo")
					break
				end
			end
		when "Report"
			if $story_stats["NFL_BridgeBunkerBat"] == 2
				call_msg("NFL_BridgeBunker:BatHouseMan/NFL_BridgeBunkerBat_QUprog2")
				$story_stats["NFL_BridgeBunkerBat"] = 3
				get_character(0).npc_story_mode(true,false)
				get_character(0).direction = 2
				get_character(0).move_forward_force
				cam_center(0)
				portrait_hide
				until !get_character(0).moving?
					wait(1)
				end
				get_character(0).direction = 4
				wait(20	)
				until get_character(0).opacity <= 5
					get_character(0).opacity -= 10
					wait(1)
				end
				get_character(0).npc_story_mode(false,false)
				get_character(0).delete
			end
			break
		when "Reward"

			# take reward
			if $story_stats["NFL_BridgeBunkerBat"] == 3
				$story_stats["NFL_BridgeBunkerBat"] = 4
				$story_stats["NFL_BridgeBunkerBat_AMT"] = $game_date.dateAmt
				call_msg("NFL_BridgeBunker:BatHouseMan/NFL_BridgeBunkerBat_QUprog3_reward")
				portrait_hide
				optain_morality(2)
				wait(30)
				optain_exp(7000)
				wait(30)
				optain_item("ItemCoin2", 3)
				wait(30)
				optain_item("ItemCoin1", 10)
				call_msg("CompAdam:Adam/1_Begin_done2")
			end
			break
	end #until
end   #case
eventPlayEnd

return if $story_stats["NFL_BridgeBunkerBat_FirstTalked"] < 2
return if $game_player.player_slave? || $game_player.actor.weak >= 50
return get_character(0).call_balloon(28,-1) if [0,2,3].include?($story_stats["NFL_BridgeBunkerBat"])
