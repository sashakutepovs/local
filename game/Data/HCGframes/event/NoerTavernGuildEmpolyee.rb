p "Playing HCGframe : NoerTavernGuildEmpolyee.rb"
if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

######################################################################################################## 如果是初期打老鼠任務狀態
if $story_stats["RecQuestSewerSawGoblin"] == 2 
	$story_stats["RecQuestSewerSawGoblin"] = -2
	call_msg("TagMapNoerTavernQuest:MercenaryGuild/Report_rattail")
	if $game_party.item_number($data_items[103]) >=8
		$story_stats["RecQuestSewerMiceClean"] = -2
		optain_lose_item($data_items[103],$game_party.item_number($data_items[103]))
		call_msg("TagMapNoerTavernQuest:MercenaryGuild/Report_rattail_win")
		optain_item($data_items[51],2) if !$game_player.player_slave?
	else
		$story_stats["RecQuestSewerMiceClean"] = -1
		call_msg("TagMapNoerTavernQuest:MercenaryGuild/Report_rattail_lose")
	end
	call_msg("TagMapNoerTavernQuest:MercenaryGuild/Report_rattail_end")
	optain_exp(1000)
	point=$game_map.get_storypoint("QuestBoard")
	get_character(point[2]).call_balloon(28,-1) if !$game_map.events[point[2]].nil?
	get_character(point[2]).summon_data[:ForceQuest] = true
	$game_party.lose_item($data_items[103],$game_party.item_number($data_items[103]))
	$bg.erase
	portrait_hide
	
	
#任務回報
######################################################################################################## 白龍草收集任務
elsif $story_stats["QuProgStaHerbCollect"] == 2
	$story_stats["GuildCompletedCount"] +=1
	$story_stats["QuProgStaHerbCollect"] = 0
	$story_stats["GuildQuestCurrent"] = 0
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed0")
	optain_item($data_items[50],2) if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	optain_exp(1000*2)
	
######################################################################################################## 清理異變生物
elsif $story_stats["QuProgMineCaveAbomHunt"] == 3
	$story_stats["GuildCompletedCount"] +=1
	$story_stats["QuProgMineCaveAbomHunt"] = 0
	$story_stats["GuildQuestCurrent"] = 0
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed0")
	if !$game_player.player_slave?
		optain_item($data_items[51],2)
		wait(30)
		optain_item($data_items[50],3)
		call_msg("TagMapNoerTavernQuest:QuestBoard/completed1")
	else
		call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave")
	end
	optain_exp(1900*2)
	wait(30)
	optain_morality(1)
######################################################################################################## 不死生物20
elsif $story_stats["QuProgCataUndeadHunt"] == 3
	$story_stats["GuildCompletedCount"] +=1
	$story_stats["GuildCompletedCataUndeadHunt"] +=1
	$story_stats["QuProgCataUndeadHunt"] = 0
	$story_stats["QuProgCataUndeadHuntCount"] = 0
	$story_stats["GuildQuestCurrent"] = 0
	$story_stats["QuProgCataUndeadHuntAMT"] = $game_date.dateAmt
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed0")
	optain_item($data_items[50],7) if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	optain_exp(1900*2)
	wait(30)
	optain_morality(1)
######################################################################################################## 營地偵察任務
elsif $story_stats["QuProgScoutCampOrkind"] == 3
	$story_stats["GuildCompletedCount"] += 1
	$story_stats["GuildCompletedScoutCampOrkind"] = 1
	$story_stats["QuProgScoutCampOrkind"]= 0
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapScoutCampOrkind:Guild/completed")
	optain_item($data_items[51],1) if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	optain_exp(2900*2)
	wait(30)
	optain_morality(1)
	$story_stats["GuildQuestCurrent"] = 0 
######################################################################################################## 營地偵察任務2
elsif $story_stats["QuProgScoutCampOrkind2"]==3
	$story_stats["GuildCompletedCount"] +=1
	$story_stats["GuildCompletedScoutCampOrkind"] =2
	$story_stats["QuProgScoutCampOrkind2"]= 0
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapScoutCampOrkind:Guild/completed2")
	optain_item($data_items[51],2) if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	optain_exp(3500*2)
	wait(30)
	optain_morality(1)
	$story_stats["GuildQuestCurrent"] = 0 

######################################################################################################## 營地偵察任務3
elsif $story_stats["QuProgScoutCampOrkind3"]==2
	$story_stats["GuildCompletedCount"] +=1
	$story_stats["GuildCompletedScoutCampOrkind"] =3
	$story_stats["RecQuestMiloAmt"] = $game_date.dateAmt+2
	$story_stats["QuProgScoutCampOrkind3"]= 0
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapScoutCampOrkind:Guild/completed3")
	optain_item($data_items[52],1) if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	optain_exp(6000*2)
	wait(30)
	optain_morality(1)
	$story_stats["GuildQuestCurrent"] = 0
	GabeSDK.getAchievement("GuildCompletedScoutCampOrkind_3")
	
######################################################################################################## 墓穴探索
elsif $story_stats["QuProgCataUndeadHunt2"] >= 3 && $story_stats["GuildCompletedCataUndeadHunt2"] == 0
	#QuProgCataUndeadHunt2 =1 *於旅館接受任務
	#QuProgCataUndeadHunt2 =2 *與守墓人對話
	#QuProgCataUndeadHunt2 =3 0守墓人陣亡
	#QuProgCataUndeadHunt2 =4 1被COCONA抓走
	#QuProgCataUndeadHunt2 =5 2成功與COCONA對話
	#QuProgCataUndeadHunt2 =6 2成功與COCONA脫出
	#QuProgCataUndeadHunt2 =7 2掩埋洞窟
	$story_stats["GuildCompletedCataUndeadHunt2"] = 1
	
	call_msg("TagMapNoerTavernQuest:MercenaryGuild/CataUndeadHunt2")
	case $story_stats["QuProgCataUndeadHunt2"]
		when 3
			call_msg("TagMapNoerTavernQuest:MercenaryGuild/CataUndeadHunt2_3")
			call_msg("TagMapNoerTavernQuest:MercenaryGuild/CataUndeadHunt2_failed")
			$story_stats["GuildCompletedCount"] =0
			$game_player.actor.record_lona_title = "basic/mercenaryFailed"
			optain_exp(1)
		when 4
			call_msg("TagMapNoerTavernQuest:MercenaryGuild/CataUndeadHunt2_4")
			call_msg("TagMapNoerTavernQuest:MercenaryGuild/CataUndeadHunt2_win")
			$story_stats["GuildCompletedCount"] +=1
			$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
			optain_item($data_items[51],4) if !$game_player.player_slave?
			call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
			call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
			optain_exp(6000*2)
		when 5,6,7
			call_msg("TagMapNoerTavernQuest:MercenaryGuild/CataUndeadHunt2_567")
			call_msg("TagMapNoerTavernQuest:MercenaryGuild/CataUndeadHunt2_win")
			$story_stats["GuildCompletedCount"] +=1
			$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
			optain_item($data_items[51],4) if !$game_player.player_slave?
			call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
			call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
			optain_exp(8000*2)
	end
	if $game_party.has_item?($data_items[108])
		optain_lose_item($data_items[108],1) if !$game_player.player_slave?
		$game_player.actor.record_lona_title = "basic/mercenary"
		call_msg("TagMapNoerTavernQuest:MercenaryGuild/CataUndeadHunt2_withHead")
		optain_exp(10000*2)
		wait(30)
		optain_morality(20)
		GabeSDK.getAchievement("UniqueCharUniqueCocona_n1")
	end
######################################################################################################## 下水道的遊民
elsif $story_stats["QuProgSewerKickMobs"]== 2
	$story_stats["GuildCompletedCount"] +=1
	$story_stats["QuProgSewerKickMobs"] = 0
	$story_stats["RecQuestSewerHoboAmt"] = $game_date.dateAmt+15
	$story_stats["GuildQuestCurrent"] = 0
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed0")
	optain_item($data_items[51],1) if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1") if !$game_player.player_slave?
	call_msg("TagMapNoerTavernQuest:QuestBoard/completed1_slave") if $game_player.player_slave?
	optain_exp(1500*2)
	wait(30)
	optain_morality(1)
	
######################################################################################################## #牠們怕的是你
elsif $story_stats["QuProgOrkindEars"] == 1 && $game_party.item_number($data_items[121]) >=10
	$story_stats["GuildCompletedCount"] +=1
	$story_stats["QuProgOrkindEars"] = 0
	$story_stats["GuildQuestCurrent"] = 0
	call_msg("TagMapNoerTavernQuest:MercenaryGuild/Report_OrkindEar_win1")
	optain_lose_item($data_items[121],$game_party.item_number($data_items[121]))
	
	$game_player.actor.record_lona_title = "basic/mercenary" if $story_stats["GuildCompletedCount"] % 5 == 0
	call_msg("TagMapNoerTavernQuest:MercenaryGuild/Report_OrkindEar_win2")
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
	
######################################################################################################## 與 Milo會面
elsif $story_stats["GuildCompletedScoutCampOrkind"] >= 3 && $story_stats["UniqueCharUniqueMilo"] != -1 && $story_stats["RecQuestMilo"] < 2 && $game_date.dateAmt >= $story_stats["RecQuestMiloAmt"]
	call_msg("TagMapNoerTavernQuest:MercenaryGuild/MiloInvite1")
	$game_map.popup(0,1,235,1)
	SndLib.sound_equip_armor
	$game_system.add_mail("MiloInvite1")
	call_msg("TagMapNoerTavernQuest:MercenaryGuild/MiloInvite2")
	optain_item("ItemPassportNob",1) if !$game_party.has_item?("ItemPassportNob")#ItemPassportNob
	$story_stats["RecQuestMilo"] = 2
	
######################################################################################################## 與 Milo會面2
elsif $story_stats["UniqueCharUniqueMilo"] != -1 && $story_stats["RecQuestMilo"] == 7 && $story_stats["QuProgSaveCecily"] == 7 && $game_date.dateAmt > $story_stats["RecQuestSaveCecilyAmt"]
	call_msg("TagMapNoerTavernQuest:MercenaryGuild/MiloInvite2_1")
	$game_map.popup(0,1,235,1)
	SndLib.sound_equip_armor
	$game_system.add_mail("MiloInvite2")
	call_msg("TagMapNoerTavernQuest:MercenaryGuild/MiloInvite2_2")
	optain_item("ItemPassportNob",1) if !$game_party.has_item?("ItemPassportNob")#ItemPassportNob
	$story_stats["RecQuestMilo"] = 9
	
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
				$story_stats["GuildQuestCurrent"] = 0 if $story_stats["GuildQuestCurrent"] == "CataUndeadHunt2" #墓地調查 非LOOP 需要排除任務板
			
			
			else
				call_msg("TagMapNoerTavernQuest:QuestBoard/decide2_lose")
			end
	end
	$story_stats["GuildQuestBeforeAccept"] = 0
	if $story_stats["RecordFirstFollower"] == 0
		$story_stats["RecordFirstFollower"] = 1
		$game_map.events.each do |event| 
			next if event[1].summon_data == nil
			next if event[1].summon_data[:BeginGuide] == nil
			next if !event[1].summon_data[:BeginGuide]
			event[1].summon_data[:BeginGuideAble] = true
			event[1].call_balloon(8,-1)
		end
		call_msg("TagMapNoerTavernQuest:Tutorial/follower")
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
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestSewerSawGoblin"] ==2
return get_character(0).call_balloon(28,-1) if $story_stats["GuildQuestBeforeAccept"] !=0
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgStaHerbCollect"] == 2
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgMineCaveAbomHunt"]== 3
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgCataUndeadHunt"]==3
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgScoutCampOrkind"]==3
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgScoutCampOrkind2"] == 3
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgScoutCampOrkind3"]==2
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgSewerKickMobs"]== 2

#墓穴任務2
tmpQ0 = $story_stats["GuildCompletedCataUndeadHunt2"] == 0
tmpQ1 = $story_stats["QuProgCataUndeadHunt2"] >= 3
return get_character(0).call_balloon(28,-1) if tmpQ0 && tmpQ1

# 與 Milo會面
tmpQ0 = $story_stats["GuildCompletedScoutCampOrkind"] >= 3 
tmpQ1 = $story_stats["UniqueCharUniqueMilo"] != -1 
tmpQ2 = $story_stats["RecQuestMilo"] < 2
tmpQ3 = $game_date.dateAmt >= $story_stats["RecQuestMiloAmt"]
return get_character(0).call_balloon(28,-1) if tmpQ0 && tmpQ1 && tmpQ2 && tmpQ3

# 與 Milo會面2
tmpQ0 = $story_stats["UniqueCharUniqueMilo"] != -1
tmpQ1 = $story_stats["RecQuestMilo"] == 7
tmpQ2 = $story_stats["QuProgSaveCecily"] == 7
tmpQ3 = $game_date.dateAmt > $story_stats["RecQuestSaveCecilyAmt"]
return get_character(0).call_balloon(28,-1) if tmpQ0 && tmpQ1 && tmpQ2 && tmpQ3

#類獸人之耳
tmpQ0 = $story_stats["QuProgOrkindEars"] == 1
tmpQ1 = $game_party.item_number($data_items[121]) >=10
return get_character(0).call_balloon(28,-1) if tmpQ0 && tmpQ1
##########################

