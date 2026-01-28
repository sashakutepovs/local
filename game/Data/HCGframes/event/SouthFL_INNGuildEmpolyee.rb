if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

get_character(0).call_balloon(0)
if $story_stats["QuProgSybBarn"] == 4
	$story_stats["QuProgSybBarn"] = 5
	$story_stats["GuildCompletedCount"] +=1
	$story_stats["GuildQuestCurrent"] = 0
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapSouthFL:MercenaryGuild/QuProgSybBarn5")
	optain_item($data_items[51],3) if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	optain_exp(7500)
	wait(30)
	optain_morality(1)


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
				
				##特殊任務設定
				#$story_stats["GuildQuestCurrent"] = 0 if $story_stats["GuildQuestCurrent"] == "CataUndeadHunt2" #墓地調查 非LOOP 需要排除任務板
			
			
			else
				call_msg("TagMapNoerTavernQuest:QuestBoard/decide2_lose")
			end
	end
	$story_stats["GuildQuestBeforeAccept"] = 0

######################################################################################################## #大型魔物的大骨
elsif $story_stats["QuProgSFL_MonsterBone"] == 1 && $game_party.item_number("ItemQuestMonsterBone") >= 8
	$story_stats["RecQuestSouthFL_LoopQU"] += 1 if $story_stats["RecQuestSouthFL_LoopQU"] < 3 #地區紀錄用
	$story_stats["GuildCompletedCount"] +=1
	$story_stats["QuProgSFL_MonsterBone"] = 0
	$story_stats["GuildQuestCurrent"] = 0
	call_msg("TagMapSouthFL:MercenaryGuild/MonsterBone_win1")
	optain_lose_item("ItemQuestMonsterBone",$game_party.item_number("ItemQuestMonsterBone"))
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapPirateBane:MercenaryGuild/Report_DeeponeEyes_win2")
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	cam_center(0)
	optain_item($data_items[51],4) if !$game_player.player_slave?
	wait(30) if !$game_player.player_slave?
	optain_item($data_items[50],5) if !$game_player.player_slave?
	wait(30) if !$game_player.player_slave?
	optain_exp(2500*2)
	wait(30)
	optain_morality(1)
	
######################################################################################################## #奔行者的肉
elsif $story_stats["QuProgSFL_BreedLingMeat"] == 1 && $game_party.item_number("ItemQuestBreedLingMeat") >= 10
	$story_stats["RecQuestSouthFL_LoopQU"] += 1 if $story_stats["RecQuestSouthFL_LoopQU"] < 2 #地區紀錄用
	$story_stats["GuildCompletedCount"] +=1
	$story_stats["QuProgSFL_BreedLingMeat"] = 0
	$story_stats["GuildQuestCurrent"] = 0
	call_msg("TagMapSouthFL:MercenaryGuild/BreedLingMeat_win1")
	optain_lose_item("ItemQuestBreedLingMeat",$game_party.item_number("ItemQuestBreedLingMeat"))
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapPirateBane:MercenaryGuild/Report_DeeponeEyes_win2")
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	cam_center(0)
	optain_item($data_items[51],2) if !$game_player.player_slave?
	wait(30) if !$game_player.player_slave?
	optain_exp(2000*2)
	wait(30)
	optain_morality(1)
	
######################################################################################################## #異變蜘蛛腿
elsif $story_stats["QuProgSFL_SpiderLeg"] == 1 && $game_party.item_number("ItemQuestSpiderLeg") >= 10
	$story_stats["RecQuestSouthFL_LoopQU"] += 1 if $story_stats["RecQuestSouthFL_LoopQU"] < 1 #地區紀錄用
	$story_stats["GuildCompletedCount"] +=1
	$story_stats["QuProgSFL_SpiderLeg"] = 0
	$story_stats["GuildQuestCurrent"] = 0
	call_msg("TagMapSouthFL:MercenaryGuild/SpiderLeg_win1")
	optain_lose_item("ItemQuestSpiderLeg",$game_party.item_number("ItemQuestSpiderLeg"))
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapPirateBane:MercenaryGuild/Report_DeeponeEyes_win2")
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	cam_center(0)
	optain_item($data_items[51],2) if !$game_player.player_slave?
	wait(30) if !$game_player.player_slave?
	optain_exp(2000*2)
	wait(30)
	optain_morality(1)
	
	####################################################################################################### 野外人質
elsif $story_stats["HostageSaved"].any? { |_, v| v >= 1 }
	call_msg("TagMapNoerTavernQuest:QuestBoard/saved_hostage")
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	reward_returned_hostage
	
######################################################################################################## 都沒有
else
	$story_stats["GuildQuestCurrent"] !=0 ? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
	call_msg("TagMapSouthFL:QuestBoard/other") #\optB[沒事,關於,取消任務<r=HiddenOPT0>]
	case $game_temp.choice
		when 0,-1
		when 1
			if $story_stats["RecQuestSouthFLMain"] >= 9
				call_msg("TagMapSouthFL:QuestBoard/other_about")
			else
				call_msg("TagMapSouthFL:QuestBoard/other_about_Prog10")
			end
		when 2
			$story_stats["QuProg#{$story_stats["GuildQuestCurrent"]}"] =0
			$story_stats["GuildQuestCurrent"] = 0 
			call_msg("TagMapSouthFL:QuestBoard/GiveUp")
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
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgSybBarn"] == 4


return get_character(0).call_balloon(28,-1) if $story_stats["QuProgSFL_MonsterBone"] == 1 && $game_party.item_number("ItemQuestMonsterBone") >= 8
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgSFL_BreedLingMeat"] == 1 && $game_party.item_number("ItemQuestBreedLingMeat") >= 10
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgSFL_SpiderLeg"] == 1 && $game_party.item_number("ItemQuestSpiderLeg") >= 10
##########################
