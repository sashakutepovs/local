return if $story_stats["UniqueCharUniqueCecily"] == -1 || $story_stats["UniqueCharUniqueGrayRat"] == -1

#when battle
if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

#未做任務前之通用對白
if $story_stats["RecQuestSaveCecily"] == 0
	call_msg("CompCecily:Cecily/UnknowBegin")
	return portrait_hide
end

tmpGRx,tmpGRy,tmpGRid = $game_map.get_storypoint("UniqueGrayRat")
tmpCEx,tmpCEy,tmpCEid = $game_map.get_storypoint("Cecily")

#救賽希莉任務完成  領取回報
if $story_stats["QuProgSaveCecily"] == 5
	get_character(0).call_balloon(0)
	$story_stats["RecQuestSaveCecilyAmt"] = $game_date.dateAmt + 10
	$story_stats["QuProgSaveCecily"] = 6
	#do reward
	optain_exp(6800*2)
	call_msg("CompCecily:Cecily/SaveQuest_reward1")
	if $story_stats["RecQuestSaveCecilyRaped"] == 0
		optain_item($data_items[52],1) #gold x1
		call_msg("CompCecily:Cecily/SaveQuest_reward2")
	else
		optain_item($data_items[51],2) #big brozen *2
		call_msg("CompCecily:Cecily/SaveQuest_reward3")
	end
	GabeSDK.getAchievement("QuProgSaveCecily_6")
	return eventPlayEnd

############################ 搶劫 5D
elsif $story_stats["QuProgSaveCecily"] == 6 && [7,8].include?($story_stats["RecQuestMilo"]) && $game_date.dateAmt >= $story_stats["RecQuestSaveCecilyAmt"]
		call_msg("CompCecily:Cecily/QuestHikack7_1")
		call_msg("CompCecily:Cecily/QuestHikack7_2")
		get_character(0).call_balloon(0)
		$story_stats["RecQuestSaveCecilyAmt"] = $game_date.dateAmt + 10
		$story_stats["QuProgSaveCecily"] = 7
		cam_center(0)
		return portrait_hide

############################# 搶劫 決定
elsif $story_stats["QuProgSaveCecily"] == 7 && $game_date.dateAmt >= $story_stats["RecQuestSaveCecilyAmt"]
		call_msg("CompCecily:Cecily/QuestHikack8_1")
		call_msg("CompCecily:Cecily/QuestHikack8_2_opt") #\optB[再考慮一下,好！]
		if $game_temp.choice == 1
			call_msg("CompCecily:Cecily/QuestHikack8_2_yes")
			get_character(0).call_balloon(0)
			$story_stats["RecQuestSaveCecilyAmt"] = $game_date.dateAmt
			$story_stats["QuProgSaveCecily"] = 8
			cam_center(0)
			return portrait_hide
		else
			cam_center(0)
			return portrait_hide
		end
############################################################################################################################################# 返回酒館
elsif $story_stats["QuProgSaveCecily"] == 15
	$story_stats["QuProgSaveCecily"] = 16
	$story_stats["RecQuestSaveCecilyAmt"] = $game_date.dateAmt + 6
	get_character(0).call_balloon(0)
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		$game_player.moveto(tmpCEx,tmpCEy+1)
		$game_player.direction = 8
		get_character(tmpCEid).moveto(tmpCEx,tmpCEy)
		get_character(tmpGRid).moveto(tmpGRx,tmpGRy)
		get_character(tmpGRid).animation = nil
		get_character(tmpCEid).animation = nil
	chcg_background_color(0,0,0,255,-7)
	
	call_msg("CompCecily:Cecily/15to16_1")
	get_character(0).direction = 6
	call_msg("CompCecily:Cecily/15to16_2")
	get_character(0).direction = 2
	call_msg("CompCecily:Cecily/15to16_3")
	$game_player.jump_to($game_player.x,$game_player.y)
	call_msg("CompCecily:Cecily/15to16_4") ; portrait_hide
	get_character(tmpGRid).npc_story_mode(true)
	get_character(tmpGRid).direction = 6 ; get_character(tmpGRid).move_forward_force ; wait(48)
	get_character(tmpGRid).direction = 4
	get_character(0).direction = 6
	call_msg("CompCecily:Cecily/15to16_5") ; portrait_hide
	get_character(tmpGRid).direction = 6 ; get_character(tmpGRid).move_forward_force ; wait(48)
	get_character(tmpGRid).direction = 2 ; get_character(tmpGRid).move_forward_force ; wait(48)
	
	#刪除GR
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpGRid).npc_story_mode(false)
		get_character(tmpGRid).delete
	chcg_background_color(0,0,0,255,-7)
	
	#若有隊伍則解散隊伍
	if $game_player.getComB_Name == "UniqueCecily"
		$game_player.record_companion_name_front = nil
		$game_player.record_companion_front_date= nil
		$game_player.record_companion_name_back = nil
		$game_player.record_companion_back_date= nil
		call_msg("common:Lona/Follower_disbanded")
	end
	
	return eventPlayEnd
############################################################################################################################################# GrayRat離隊
elsif $story_stats["QuProgSaveCecily"] == 16 && !($game_date.dateAmt >= $story_stats["RecQuestSaveCecilyAmt"])
	call_msg("CompCecily:Cecily/QuestMilo_4and5")
	return eventPlayEnd
	
####################################################################################################################################### 18 >> CECILY 偷盜文件成功 刪減版 回報
####################################################################################################################################### 21 >> CECILY 偷盜文件成功 完整故事 回報
elsif [18,21].include?($story_stats["QuProgSaveCecily"])
	#若有隊伍則解散隊伍
	if $game_player.getComB_Name == "UniqueCecily"
		$game_player.record_companion_name_front = nil
		$game_player.record_companion_front_date= nil
		$game_player.record_companion_name_back = nil
		$game_player.record_companion_back_date= nil
		call_msg("common:Lona/Follower_disbanded")
	end
	call_msg("CompCecily:QuProg/18_begin1") ; portrait_hide
	$game_player.animation = $game_player.animation_atk_sh
	optain_lose_item("ItemQuestCecilyProg17",1)
	call_msg("CompCecily:QuProg/18_begin2")
	portrait_hide
	call_msg("commonCommands:Lona/CampActionBuildCamp2") #Narr ...
	call_msg("CompCecily:QuProg/18_begin3")
	portrait_hide
	call_msg("CompCecily:QuProg/18_begin3_narr") #Narr ..
	get_character(0).call_balloon(8)
	wait(60)
	if $story_stats["QuProgSaveCecily"] == 18 # 18 >> CECILY 偷盜文件成功 刪減版 回報
		call_msg("CompCecily:QuProg/18to22_1")
	elsif $story_stats["QuProgSaveCecily"] == 21 # 21 >> CECILY 偷盜文件成功 完整故事 回報
		call_msg("CompCecily:QuProg/21to43_1")
		
	end
	call_msg("CompCecily:QuProg/18_begin4")
	get_character(0).direction = 6
	call_msg("CompCecily:QuProg/18_begin5")
	get_character(0).direction = 2
	call_msg("CompCecily:QuProg/18_begin6")
	
	if $story_stats["QuProgSaveCecily"] == 18 # 18 >> CECILY 偷盜文件成功 刪減版 回報
		$story_stats["QuProgSaveCecily"] = 22
		optain_item($data_items[52],1) #gold
		wait(30)
		optain_exp(10000)
		
	elsif $story_stats["QuProgSaveCecily"] == 21 # 21 >> CECILY 偷盜文件成功 完整故事 回報
		$story_stats["QuProgSaveCecily"] = 43
		optain_item($data_items[52],2) #gold
		wait(30)
		optain_item($data_items[51],5)
		wait(30)
		optain_exp(18000)
	end
	call_msg("CompCecily:QuProg/18_begin7")
	$story_stats["RecQuestSaveCecilyAmt"] = $game_date.dateAmt + 6
	return eventPlayEnd
end

#美祿任務串於 45時阻擋 避免用同陣營單位去暗殺亞當 以及決定執行搶劫任務之前
if [4,5].include?($story_stats["RecQuestMilo"]) || [7].include?($story_stats["QuProgSaveCecily"])
	call_msg("CompCecily:Cecily/QuestMilo_4and5")
	cam_center(0)
	return portrait_hide
end

if [12,13,14].include?($story_stats["QuProgSaveCecily"])
	call_msg("CompCecily:Cecily/KnownBegin12SAD")
else
	call_msg("CompCecily:Cecily/KnownBegin")
end
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonComp:Companion/TeamUp"]			,"TeamUp"]		if $game_player.record_companion_name_back != "UniqueCecily"
	tmpTarList << [$game_text["commonComp:Companion/Disband"]			,"Disband"]		if $game_player.record_companion_name_back == "UniqueCecily"
	tmpTarList << [$game_text["CompCecily:Cecily/16to17_opt"]			,"16to17_opt"]	if $story_stats["QuProgSaveCecily"] == 16 && $game_date.dateAmt >= $story_stats["RecQuestSaveCecilyAmt"]
	tmpTarList << [$game_text["CompCecily:Cecily/12_opt"]				,"12_opt"]		if $story_stats["QuProgSaveCecily"] == 12 && $game_date.dateAmt >= $story_stats["RecQuestSaveCecilyAmt"]
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("CompCecily:Cecily/BasicOpt",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
	
	case tmpPicked
		when 0,-1
		when "16to17_opt"   #GR 回來後 繼續任務
			call_msg("CompCecily:Cecily/16to17_1")
			call_msg("CompCecily:Cecily/16to17_2") ; portrait_hide
			$cg.erase
			get_character(0).npc_story_mode(true)
			get_character(0).animation = get_character(0).animation_atk_sh
			SndLib.sound_equip_armor
			wait(10)
			$game_player.jump_to($game_player.x,$game_player.y)
			optain_item($data_items[51],5)
			wait(5)
			call_msg("CompCecily:Cecily/16to17_3")
			call_msg("CompCecily:Cecily/16to17_4")
			#刪除GR CE
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				portrait_off
				get_character(0).delete
				get_character(tmpGRid).delete
				$game_player.direction = 6
				$story_stats["QuProgSaveCecily"] = 17
			chcg_background_color(0,0,0,255,-7)
			call_msg("CompCecily:Cecily/16to17_END")
			call_msg("CompCecily:Cecily/16to17_END_brd")
			return eventPlayEnd
		
		when "12_opt" ################# 對洛娜的提問
			call_msg("CompCecily:Cecily/KnownBegin12SAD")
			call_msg("CompCecily:Cecily/KnownBegin_12")
			call_msg("CompCecily:Cecily/QuestHikack12_OPT") #[不知道，跟我來]
			if $game_temp.choice == 1
				$story_stats["QuProgSaveCecily"] = 13
				call_msg("CompCecily:Cecily/QuestHikack12_OPT_ANS")
				call_msg("CompCecily:Cecily/QuestHikack12_OPT_ANS_BRD")
				get_character(0).call_balloon(28,-1) if [13,14].include?($story_stats["QuProgSaveCecily"]) && $game_player.record_companion_name_back != "UniqueCecily"
			else
				call_msg("CompCecily:Cecily/QuestHikack12_OPT_cancel")
			end
		
		when "TeamUp"
			call_msg("CompCecily:Cecily/CompData")
			call_msg("CompGrayRat:GrayRat/CompData")
			show_npc_info(get_character(0),extra_info=false,"commonComp:Companion/Accept") 			#\optD[算了，確定]
			case $game_temp.choice
				when 0,-1
				when 1
					if $game_player.actor.weak > 100 && $story_stats["RecQuestSaveCecilyRaped"] ==1
						call_msg("CompCecily:Cecily/Comp_failed_Raped")
					elsif $game_player.actor.weak > 100 && $game_date.dateAmt > $story_stats["CecilyCoinSupport"] +1
						$story_stats["CecilyCoinSupport"] = $game_date.dateAmt
						call_msg("CompCecily:Cecily/Comp_failed_Coin")
						optain_item($data_items[50],2)
					elsif $game_player.actor.weak > 100 && $story_stats["CecilyCoinSupport"] +1 >= $game_date.dateAmt
						call_msg("CompCecily:Cecily/Comp_failed_CoinAgain")
					else
						get_character(0).set_this_event_companion_back("UniqueCecily",false,$game_date.dateAmt+10)
						get_character(tmpGRid).set_this_event_companion_front("UniqueGrayRat",false,$game_date.dateAmt+10)
						call_msg("CompCecily:Cecily/Comp_win")
					end
			end
	when "Disband"
		call_msg("commonComp:Companion/Accept") 			#\optD[算了，確定]
			case $game_temp.choice
				when 0,-1
				when 1
					call_msg("CompCecily:Cecily/Comp_disband")
					remove_companion(1)
					remove_companion(0)
					#call_msg("common:Lona/Group_disbanded")
					#get_character(0).set_this_companion_disband(false)
			end
end #case

eventPlayEnd

################################# Quest check ########################################
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgSaveCecily"] == 6 && [7,8].include?($story_stats["RecQuestMilo"]) && $game_date.dateAmt >= $story_stats["RecQuestSaveCecilyAmt"]
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgSaveCecily"] == 7 && $game_date.dateAmt >= $story_stats["RecQuestSaveCecilyAmt"]
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgSaveCecily"] == 8 && $game_player.record_companion_name_back != "UniqueCecily"
return get_character(0).call_balloon(28,-1) if [13,14].include?($story_stats["QuProgSaveCecily"]) && $game_player.record_companion_name_back != "UniqueCecily"
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgSaveCecily"] == 16 && $game_date.dateAmt >= $story_stats["RecQuestSaveCecilyAmt"]
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgSaveCecily"] == 12 && $game_date.dateAmt >= $story_stats["RecQuestSaveCecilyAmt"]
return get_character(0).call_balloon(28,-1) if [18,21].include?($story_stats["QuProgSaveCecily"])
