
if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end


################## Noer to PirateBane
if $story_stats["QuProgNoerToPirate"] == 1
	$story_stats["GuildCompletedCount"] +=1
	$story_stats["QuProgNoerToPirate"] = 2
	$story_stats["GuildQuestCurrent"] = 0
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed0")
	optain_item($data_items[50],5) if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	optain_exp(2000)
	wait(30)
	optain_morality(1)

######################################################################################################## #類獸人巢穴
elsif $story_stats["QuProgPB_OrkDen4"] == 1 && $game_party.item_number($data_items[131]) >=1
	$story_stats["GuildCompletedCount"] +=1
	$story_stats["QuProgPB_OrkDen4"] = 2
	$story_stats["GuildQuestCurrent"] = 0
	call_msg("TagMapPirateBane:MercenaryGuild/PB_OrkDen4_win1")
	optain_lose_item($data_items[131],$game_party.item_number($data_items[131]))
	
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapPirateBane:MercenaryGuild/PB_OrkDen4_win2")
	
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	cam_center(0)
	optain_item($data_items[51],3) if !$game_player.player_slave?
	wait(30) if !$game_player.player_slave?
	optain_exp(4000)
	wait(30)
	optain_morality(1)
######################################################################################################## 亂葬崗的邪惡
elsif $story_stats["QuProgPB_MassGrave"] == 2
	$story_stats["QuProgPB_MassGrave"] = 3
	$story_stats["GuildCompletedCount"] +=1
	$story_stats["GuildQuestCurrent"] = 0
	$story_stats["RecQuestDedOne"] += 1
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapPirateBane:MercenaryGuild/PB_MassGrave_done")
	optain_item($data_items[51],2) if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	optain_exp(2000*2)
	wait(30)
	optain_morality(1)
######################################################################################################## 漁人狩獵2
elsif $story_stats["RecQuestFishCaveHunt2"] == 5
	$story_stats["RecQuestFishCaveHunt2"] = 6
	$story_stats["GuildCompletedCount"] +=1
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed0")
	optain_item($data_items[51],3) if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	optain_exp(1800*2)
	wait(30)
	optain_morality(1)
	
######################################################################################################## #挖出牠的眼
elsif $story_stats["QuProgPB_DeeponeEyes"] == 1 && $game_party.item_number($data_items[115]) >=8
	$story_stats["GuildCompletedCount"] +=1
	$story_stats["QuProgPB_DeeponeEyes"] = 0
	$story_stats["GuildQuestCurrent"] = 0
	call_msg("TagMapPirateBane:MercenaryGuild/Report_DeeponeEyes_win1")
	optain_lose_item($data_items[115],$game_party.item_number($data_items[115]))
	
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapPirateBane:MercenaryGuild/Report_DeeponeEyes_win2")
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	cam_center(0)
	optain_item($data_items[51],1) if !$game_player.player_slave?
	wait(30) if !$game_player.player_slave?
	optain_item($data_items[50],5) if !$game_player.player_slave?
	wait(30) if !$game_player.player_slave?
	optain_exp(1500*2)
	wait(30)
	optain_morality(1)
	
######################################################################################################## #北哨點的訊息
elsif $story_stats["QuProgPB_NorthCP"] == 2
	$story_stats["GuildCompletedCount"] +=1
	$story_stats["GuildQuestCurrent"] = 0
	$story_stats["RecQuestDedOne"] += 1
	$story_stats["QuProgPB_NorthCP"] = 3
	call_msg("TagMapPirateBane:MercenaryGuild/Report_NorthCP_win1")
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	cam_center(0)
	optain_item($data_items[51],1) if !$game_player.player_slave?
	wait(30) if !$game_player.player_slave?
	optain_exp(1000*2)
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
				#msgbox "aadsasdasdasD" if $story_stats["QuProgPB_OrkDen4"] == 1
			
			
			else
				call_msg("TagMapNoerTavernQuest:QuestBoard/decide2_lose")
			end
	end
	$story_stats["GuildQuestBeforeAccept"] = 0
	
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
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgPB_MassGrave"] == 2
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgPB_NorthCP"] == 2
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgPB_DeeponeEyes"] == 1 && $game_party.item_number($data_items[115]) >=8
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgPB_OrkDen4"] == 1 && $game_party.item_number($data_items[131]) >=1
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestFishCaveHunt2"] == 5
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgNoerToPirate"] == 1
##########################
