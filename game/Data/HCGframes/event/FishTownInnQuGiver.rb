if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if $game_player.actor.stat["SlaveBrand"] == 1
	call_msg("TagMapFishTown:Guard/spot")
	get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
	return eventPlayEnd
	
elsif $game_player.player_slave? || $game_player.actor.weak >= 50
	call_msg("TagMapFishTownInn:InnQuGiver/TooWeak")

elsif $story_stats["RecQuestFishInn"] == 0
	call_msg("TagMapFishTownInn:InnQuGiver/0_begin0")
	call_msg("TagMapFishTownInn:InnQuGiver/0_begin1")
	$game_temp.choice = -1
	call_msg("common:Lona/Decide_optB")
	if $game_temp.choice == 1
		$story_stats["RecQuestFishInn"] = 1
		call_msg("TagMapFishTownInn:InnQuGiver/0_begin1_yes")
	else
		call_msg("TagMapFishTownInn:InnQuGiver/0_begin1_no")
	end

elsif $story_stats["RecQuestFishEscSlaveKilled"] >= 1 && $story_stats["RecQuestFishInn"] == 1
	$story_stats["RecQuestFishInn"] = 2
	call_msg("TagMapFishTownInn:InnQuGiver/1_begin1")
	optain_item($data_items[51],3)
	wait(30)
	optain_exp(4500)
	call_msg("TagMapFishTownInn:InnQuGiver/1_begin1_askQ")
	if $story_stats["RecQuestFishEscSlaveKilled"] == 2
		call_msg("TagMapFishTownInn:InnQuGiver/1_begin1_Killed")
		optain_item($data_items[51],2)
		wait(30)
		optain_exp(3500)
	else
		#lona didnt kill them all
		call_msg("TagMapFishTownInn:InnQuGiver/1_begin1_noKill")
		optain_morality(3)
		$story_stats["RecQuestFishEscSlaveKilled"] = 3
	end
	
elsif $story_stats["RecQuestFishInn"] == 2
	call_msg("TagMapFishTownInn:InnQuGiver/2_begin0")
	call_msg("TagMapFishTownInn:InnQuGiver/2_begin1")
	$game_temp.choice = -1
	call_msg("common:Lona/Decide_optB")
	if $game_temp.choice == 1
		$story_stats["RecQuestFishInn"] = 3
		call_msg("TagMapFishTownInn:InnQuGiver/2_begin1_yes")
	else
		call_msg("TagMapFishTownInn:InnQuGiver/0_begin1_no")
	end
elsif $story_stats["RecQuestFishInn"] == 5
	$story_stats["RecQuestFishInn"] = 6
	call_msg("TagMapFishTownInn:InnQuGiver/5_win1")
	optain_item($data_items[51],2)
	wait(30)
	optain_exp(3500)
	call_msg("TagMapFishTownInn:InnQuGiver/5_win2")
	
##################################################################重複任務
elsif $story_stats["RecQuestFishInn"] >= 6 && $story_stats["RecQuestFishHuntF"] == 0 && $game_date.dateAmt > $story_stats["RecQuestFishHuntFAmt"]
	call_msg("TagMapFishTownInn:InnQuGiver/FishFHuntLoop0_begin0")
	call_msg("TagMapFishTownInn:InnQuGiver/FishFHuntLoop0_begin2")
	call_msg("common:Lona/Decide_optB")
	if $game_temp.choice == 1
		$story_stats["RecQuestFishHuntF"] = 1
		call_msg("TagMapFishTownInn:InnQuGiver/FishFHuntLoop0_yes")
	else
		call_msg("TagMapFishTownInn:InnQuGiver/0_begin1_no")
	end
	
elsif $story_stats["RecQuestFishInn"] >= 6 && $story_stats["RecQuestFishHuntF"] == 1 && $game_party.item_number($data_items[128]) >=10 #ItemQuestDeeponeEyesF
	$story_stats["RecQuestFishHuntFAmt"] = $game_date.dateAmt+2
	$story_stats["RecQuestFishHuntF"] = 0
	call_msg("TagMapFishTownInn:InnQuGiver/FishFHuntLoop_win0")
	optain_lose_item($data_items[128],$game_party.item_number($data_items[128]))
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapFishTownInn:InnQuGiver/FishFHuntLoop_win1")
	call_msg("TagMapFishTownInn:InnQuGiver/5_win2")
	cam_center(0)
	optain_item($data_items[51],2) if !$game_player.player_slave?
	wait(30) if !$game_player.player_slave?
	optain_exp(1500*2)
	wait(30)
	optain_morality(1)
##################################################################重複任務 END
else
	if $story_stats["RecQuestFishInn"] >= 6
		call_msg("TagMapFishTownInn:InnQuGiver/5_win2")
	else
		call_msg("TagMapFishTownInn:RichFish/Rand#{rand(3)}")
	end
end

eventPlayEnd

#checkBalloon
get_character(0).call_balloon(0)
tmpQ0 = $story_stats["RecQuestFishInn"] == 0
tmpQ1 = !$game_player.player_slave?
tmpQ2 = $game_player.actor.weak >= 50
return get_character(0).call_balloon(28,-1) if tmpQ0 && tmpQ1 && !tmpQ2

tmpQ4 = $story_stats["RecQuestFishEscSlaveKilled"] >= 1
tmpQ5 = $story_stats["RecQuestFishInn"] == 1
return get_character(0).call_balloon(28,-1) if tmpQ4 && tmpQ5 && tmpQ1 && !tmpQ2

tmpQ5 = $story_stats["RecQuestFishInn"] == 2
return get_character(0).call_balloon(28,-1) if tmpQ1 && !tmpQ2 && tmpQ5

tmpQ5 = $story_stats["RecQuestFishInn"] == 5
return get_character(0).call_balloon(28,-1) if tmpQ1 && !tmpQ2 && tmpQ5

tmpQ6 = $story_stats["RecQuestFishInn"] >= 6 && $story_stats["RecQuestFishHuntF"] == 0
tmpQ7 = $game_date.dateAmt > $story_stats["RecQuestFishHuntFAmt"]
return get_character(0).call_balloon(28,-1) if tmpQ1 && !tmpQ2 && tmpQ6 && tmpQ7