if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

tmpDev = false #remove this when theres any quest doned

################## Noer to DoomFort
if $story_stats["QuProgNoerToDoom"] == 1
	$story_stats["GuildCompletedCount"] +=1
	$story_stats["QuProgNoerToDoom"] = 2
	$story_stats["GuildQuestCurrent"] = 0
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed0")
	optain_item($data_items[50],5) if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	optain_exp(2000)
	wait(30)
	optain_morality(1)
	
#如果殺光了伍德森家族
elsif $story_stats["QuProgDF_Woodson"] == 3
	$story_stats["GuildCompletedCount"] +=1
	$story_stats["QuProgDF_Woodson"] = 4
	$story_stats["GuildQuestCurrent"] = 0
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed0")
	optain_item($data_items[51],9) if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	optain_exp(5000*2)
	wait(30)
	optain_morality(1)
	
elsif $story_stats["RecQuestPenisTribeHelp"] == -1 && $story_stats["QuProgDF_WipeTribe"] == 1
	$story_stats["QuProgDF_WipeTribe"] = 2
	$story_stats["GuildCompletedCount"] +=1
	$story_stats["GuildQuestCurrent"] = 0
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed0")
	optain_item($data_items[51],2) if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	optain_exp(5000*2)
	wait(30)
	optain_morality(1)
	
elsif $story_stats["QuProgDF_BanditHunt"] == 2
	$story_stats["QuProgDF_BanditHunt"] = 0
	$story_stats["QuProgDF_BanditHuntAMT"] = $game_date.dateAmt
	$story_stats["GuildCompletedCount"] +=1
	$story_stats["GuildQuestCurrent"] = 0
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapDoomFortress:QuProgDF_BanditHunt/done")
	if !$game_player.player_slave?
		optain_item($data_items[50],7)
		wait(30)
		optain_item($data_items[51],1)
	end
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	optain_exp(5000*2)
	wait(30)
	optain_morality(1)

####################################################################################################### 野外人質
elsif $story_stats["HostageSaved"].any? { |_, v| v >= 1 }
	call_msg("TagMapNoerTavernQuest:QuestBoard/saved_hostage")
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	reward_returned_hostage
######################################################################################################## 告示牌任務
elsif $story_stats["GuildQuestBeforeAccept"] !=0
	call_msg("TagMapNoerTavernQuest:QuestBoard/decide2")  #\optB[算了,決定]
	case $game_temp.choice
		when 0,-1
		when 1
			if $story_stats["GuildQuestCurrent"] == 0
				$story_stats["GuildQuestCurrent"] = $story_stats["GuildQuestBeforeAccept"]
				$story_stats["QuProg#{$story_stats["GuildQuestCurrent"]}"] = 1
				p "Quest Progress name => QuProg#{$story_stats["GuildQuestCurrent"]}  == #{$story_stats["QuProg#{$story_stats["GuildQuestCurrent"]}"]}"
				call_msg("TagMapNoerTavernQuest:QuestBoard/decide2_win")
				
				
				#特殊任務設定
			
			else
				call_msg("TagMapNoerTavernQuest:QuestBoard/decide2_lose")
			end
	end
	$story_stats["GuildQuestBeforeAccept"] = 0
	#####################DF 伍德森家族特殊設定
	if $story_stats["QuProgDF_Woodson"] == 1
		call_msg("TagMapDoomFortress:QuProgDF_Woodson/prog1_emp")
		tmpExtD = $game_map.get_storypoint("ExitPoint")[2]
		get_character(tmpExtD).call_balloon(28,-1)
	end
	
######################################################################################################## 都沒有
else
	$story_stats["GuildQuestCurrent"] !=0 ? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
	call_msg("TagMapNoerTavernQuest:QuestBoard/other") #\optB[沒事,關於,取消任務<r=HiddenOPT0>]
	case $game_temp.choice
		when 0,-1
		when 1
			call_msg("TagMapNoerTavernQuest:QuestBoard/other_about")
		when 2
			$story_stats["QuProg#{$story_stats["GuildQuestCurrent"]}"] =0
			$story_stats["GuildQuestCurrent"] = 0 
			call_msg("TagMapNoerTavernQuest:QuestBoard/other_quest_cancel")
	end
end



cam_center(0)
$story_stats["HiddenOPT0"] = "0"
portrait_hide
$game_temp.choice = -1


########################## check balloon
get_character(0).call_balloon(0)
return get_character(0).call_balloon(28,-1) if $story_stats["HostageSavedCommoner"] > 0
return get_character(0).call_balloon(28,-1) if $story_stats["HostageSavedMoot"] > 0
return get_character(0).call_balloon(28,-1) if $story_stats["HostageSavedRich"] > 0
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgDF_Woodson"] == 3
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgDF_BanditHunt"] == 2
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgNoerToDoom"] == 1
##########################
