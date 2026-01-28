if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
	###################################################################### 檢查是否留著記憶
if [16,17].include?($story_stats["RecQuestLisa"])
	############################################# RESET MEMORY
	if $story_stats["RecQuestLisa"] == 16
		$story_stats["RecQuestLisa"] = 18
	############################################# KEEP MEMORY
	elsif $story_stats["RecQuestLisa"] == 17
		$story_stats["RecQuestLisa"] = 19
	end
	call_msg("CompLisa:Lisa18_19/InMarket0")
	
	###################################################################### 初期的第一次對話
elsif $story_stats["RecordLisaFirstTimeTalked"] == 0
	call_msg("CompLisa:Lisa/WelcomeUnknow")
	call_msg("CompLisa:Lona/LisaOptUnknow")
	call_msg("CompLisa:Lisa/About")
	$story_stats["RecordLisaFirstTimeTalked"] =1
	###################################################################### 通用對話
else
	call_msg("CompLisa:Lisa/Welcome#{rand(3)}")
	
	tmp_QuEastCP = $story_stats["RecQuestC130"] == 3 && [0,1,2].include?($story_stats["RecQuestLisa"])
	tmp_QuSouthFL = $story_stats["RecQuestSouthFLMain"] == 11 && $story_stats["RecQuestLisa"] == 5
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"]
	tmpTarList << [$game_text["commonNPC:commonNPC/About"]				,"About"] if $story_stats["RecQuestLisa"] < 16
	tmpTarList << [$game_text["CompLisa:Lona/LisaOpt_Supply"]			,"LisaOpt_Supply"] if tmp_QuEastCP
	tmpTarList << [$game_text["CompLisa:Lona/LisaOpt_SouthFL"]			,"LisaOpt_SouthFL"] if tmp_QuSouthFL
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("CompLisa:Lona/LisaOpt",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
	
	case tmpPicked
		when "Barter"
			manual_barters("NoerMarketLisa")
			
		when "About"
			call_msg("CompLisa:Lisa/About")
		
		when "LisaOpt_Supply"
				call_msg("CompLisa:Lisa/C130_3_0") if $story_stats["RecQuestLisa"] ==0
				call_msg("CompLisa:Lisa/C130_3_1board")
				$game_temp.choice = -1
				call_msg("common:Lona/Decide_optB")
				if $game_temp.choice == 1
					set_comp=false
					if $game_temp.choice ==1 && $game_player.record_companion_name_ext == nil
						set_comp=true
					elsif $game_temp.choice ==1 && $game_player.record_companion_name_ext != nil
						$game_temp.choice = -1
						call_msg("commonComp:notice/ExtOverWrite")
						call_msg("common:Lona/Decide_optD")
						if $game_temp.choice ==1
						set_comp=true
						end
					end
				
					if set_comp
						call_msg("CompLisa:Lisa/C130_3_Accept") if $story_stats["RecQuestLisa"] ==0
						$story_stats["RecQuestLisa"] = 1 if $story_stats["RecQuestLisa"] ==0
						portrait_hide
						chcg_background_color(0,0,0,0,7)
						get_character(0).set_this_event_companion_ext("CompExtUniqueLisa",false,10+$game_date.dateAmt)
						get_character(0).delete
						$game_map.reserve_summon_event("CompExtUniqueLisa",$game_player.x,$game_player.y)
						chcg_background_color(0,0,0,255,-7)
						call_msg("CompLisa:Lisa/C130_3_2")
					end
				end
				
				
				
				
		when "LisaOpt_SouthFL"
				call_msg("CompLisa:SouthFL_11/begin")
				questDate = 30
				$story_stats["HiddenOPT1"] = questDate/2 #quest timer
				call_msg("CompLisa:SouthFL_11/begin_board")
				$story_stats["HiddenOPT1"] = 0
				$game_temp.choice = -1
				call_msg("common:Lona/Decide_optB")
				if $game_temp.choice == 1
					set_comp=false
					if $game_temp.choice ==1 && $game_player.record_companion_name_ext == nil
						set_comp=true
					elsif $game_temp.choice ==1 && $game_player.record_companion_name_ext != nil
						$game_temp.choice = -1
						call_msg("commonComp:notice/ExtOverWrite")
						call_msg("common:Lona/Decide_optD")
						if $game_temp.choice ==1
						set_comp=true
						end
					end
				
					if set_comp
						call_msg("CompLisa:SouthFL_12/Joined0")
						$story_stats["RecQuestLisa"] = 6
						$story_stats["RecQuestSouthFLMain"] = 12
						portrait_hide
						chcg_background_color(0,0,0,0,7)
						get_character(0).set_this_event_companion_ext("CompExtUniqueLisa",false,questDate+$game_date.dateAmt)
						get_character(0).delete
						$game_map.reserve_summon_event("CompExtUniqueLisa",$game_player.x,$game_player.y)
						chcg_background_color(0,0,0,255,-7)
					end
				end
				
	end #case basic
end #case if

eventPlayEnd

#Lisa SouthFL quest
tmpQ1 = $story_stats["RecQuestLisa"] == 5
tmpQ4 = $story_stats["RecQuestSouthFLMain"] == 11
return get_character(0).call_balloon(28,-1) if tmpQ1 && tmpQ4
