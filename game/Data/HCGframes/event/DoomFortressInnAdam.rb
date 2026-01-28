if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

get_character(0).call_balloon(0)

#偷狗牌
if $story_stats["RecQuestAdam"] == 0
	#did milo quest
	if $story_stats["RecQuestMilo"] > 6
		call_msg("CompAdam:Adam/NonFristTimeBegin")
	end
	call_msg("CompAdam:Adam/0_Begin0")
	call_msg("CompAdam:Adam/0_Begin2") #我？\optB[不是,是]
	if $game_temp.choice == 1
		get_character(0).call_balloon(0)
		call_msg("CompAdam:Adam/1_Begin_yes")
		$story_stats["RecQuestAdam"] = 1
	end
	
#回報狗牌
elsif $story_stats["RecQuestAdam"] == 1 && $game_party.has_item?("ItemQuestDfSgtTag") #百人長的狗牌
		$story_stats["RecQuestAdam"] = 2
		$story_stats["RecQuestAdamAmt"] = $game_date.dateAmt+4
		get_character(0).call_balloon(28,-1)
		call_msg("CompAdam:Adam/1_Begin_done0")
		optain_lose_item("ItemQuestDfSgtTag",$game_party.item_number("ItemQuestDfSgtTag"))
		call_msg("CompAdam:Adam/1_Begin_done1")
		optain_item("ItemCoin2",1)
		wait(30)
		optain_exp(1500*2)
		call_msg("CompAdam:Adam/1_Begin_done2")
	
#偷槍
elsif $story_stats["RecQuestAdam"] == 2 && $game_date.dateAmt >= $story_stats["RecQuestAdamAmt"]
	$story_stats["RecQuestAdam"] = 3
	call_msg("CompAdam:Adam/2_begin_1")
	call_msg("CompAdam:Adam/2_begin_board")
	call_msg("CompAdam:Adam/2_begin_decide")
	if $game_temp.choice == 1
		call_msg("CompAdam:Adam/2_begin_accept1")
		$story_stats["RecQuestAdam"] = 4
		optain_item("ItemQuestDfSgtTag",1)
		wait(30)
		call_msg("CompAdam:Adam/2_begin_accept2")
	end
elsif $story_stats["RecQuestAdam"] == 3 && $game_date.dateAmt >= $story_stats["RecQuestAdamAmt"]
		call_msg("CompAdam:Adam/2_begin_board")
		call_msg("CompAdam:Adam/2_begin_decide")
		if $game_temp.choice == 1
			call_msg("CompAdam:Adam/2_begin_accept1")
		$story_stats["RecQuestAdam"] = 4
		optain_item("ItemQuestDfSgtTag",1)
		wait(30)
			call_msg("CompAdam:Adam/2_begin_accept2")
		end
#完成偷槍
elsif $story_stats["RecQuestAdam"] == 5
	call_msg("CompAdam:Adam/5_win1")
	$story_stats["RecQuestAdam"] = 6
	$story_stats["RecQuestAdamAmt"] = $game_date.dateAmt+6
	optain_lose_item("ItemQuestDfSgtTag",1)
	wait(30)
	optain_lose_item("ItemQuestMusket",1)
	wait(30)
	optain_exp(7000)
	call_msg("CompAdam:Adam/5_win2")
	optain_item("Item2MhMusket",1) #musket
	GabeSDK.getAchievement("RecQuestAdam_6")
	call_msg("CompAdam:Adam/5_win3")
else
	call_msg("CompAdam:Adam/else")
end


get_character(0).call_balloon(28,-1) if $story_stats["RecQuestAdam"] == 0
portrait_hide
cam_center(0)

########################## check balloon
get_character(0).call_balloon(0)
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestAdam"] == 0
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestAdam"] == 1 && $game_party.has_item?("ItemQuestDfSgtTag")
return get_character(0).call_balloon(28,-1) if [2,3].include?($story_stats["RecQuestAdam"]) && $game_date.dateAmt >= $story_stats["RecQuestAdamAmt"]
##########################
