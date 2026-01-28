if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

#我有帶賽希莉時阻擋 避免同陣營單位暗殺
#if $game_player.record_companion_name_back == "UniqueCecily"
#	SndLib.sound_QuickDialog
#	$game_map.popup(0,"CompMilo:Milo/CecilyGroupQmsg#{rand(2)}",0,0)
#	return
#end

get_character(0).call_balloon(0)

if $story_stats["QuProgSaveCecily"] >= 12
	call_msg("CompMilo:Milo/QuestMilo_9_Ignore")
	$story_stats["RecQuestMilo"] = 10
	return eventPlayEnd
end
if $story_stats["RecQuestMilo"] == 0
	$story_stats["RecQuestMilo"] = 1
	$story_stats["RecQuestMiloAmt"] = $game_date.dateAmt
	call_msg("CompMilo:Milo/InBarBegin_unknow0")
elsif $story_stats["RecQuestMilo"] == 1
	call_msg("CompMilo:Milo/InBarBegin_know")
elsif $story_stats["RecQuestMilo"] == 2
	$story_stats["RecQuestMilo"] = 3
	call_msg("CompMilo:Milo/QuestMilo_2to3_1")
elsif $story_stats["RecQuestMilo"] == 3
	call_msg("CompMilo:Milo/QuestMilo_3to4_1")
	call_msg("CompMilo:Milo/QuestMilo_3to4_QuBoard")
	$game_temp.choice = -1
	call_msg("common:Lona/Decide_optB") #\optB[算了,決定]
	case $game_temp.choice
	when 0
		call_msg("CompMilo:Milo/QuestMilo_3to4_no")
	when 1
		$story_stats["RecQuestMilo"] = 4
		call_msg("CompMilo:Milo/QuestMilo_3to4_yes")
	
		#若Adam已死
		if $story_stats["UniqueCharUniqueAdam"] == -1
			call_msg("CompMilo:Milo/QuestMilo_3to4_yes_adamDed0")
			if $game_party.has_item?($data_items[101]) #戰士的頭顱
				optain_lose_item($data_items[101],1)
			end
			call_msg("CompMilo:Milo/QuestMilo_3to4_yes_adamDed1")
			$story_stats["RecQuestMilo"] = 7
			optain_item($data_items[51],5)
			wait(30)
			optain_exp(5000*2)
			wait(30)
			optain_morality(5)
			$story_stats["RecQuestMiloAmt"] = $game_date.dateAmt
		end
	
	end
elsif $story_stats["RecQuestMilo"] == 6 || ([4,5].include?($story_stats["RecQuestMilo"]) && $story_stats["UniqueCharUniqueAdam"] == -1)
	call_msg("CompMilo:Milo/QuestMilo_6to7")
	if $game_party.has_item?($data_items[101]) #戰士的頭顱
		$story_stats["RecQuestMilo"] = 7
		call_msg("CompMilo:Milo/QuestMilo_6to7_withHead0")
		optain_lose_item($data_items[101],1)
		call_msg("CompMilo:Milo/QuestMilo_6to7_withHead1")
		optain_item($data_items[51],5)
		call_msg("CompMilo:Milo/QuestMilo_6to7_withHead2")
	else
		$story_stats["RecQuestMilo"] = 8
		call_msg("CompMilo:Milo/QuestMilo_6to7_NoHead0")
		optain_item($data_items[51],5)
		call_msg("CompMilo:Milo/QuestMilo_6to7_NoHead1")
		$game_player.direction = 2
		call_msg("CompMilo:Milo/QuestMilo_6to7_NoHead2")
	end
	optain_exp(5000*2)
	wait(30)
	optain_morality(5)
	$story_stats["RecQuestMiloAmt"] = $game_date.dateAmt

elsif $story_stats["RecQuestMilo"] == 9 #分支串
	call_msg("CompMilo:Milo/QuestMilo_9to10_1") #不好,好
	if $game_temp.choice == 1
		call_msg("CompMilo:Milo/QuestMilo_9to10_2_0")
		call_msg("CompMilo:Milo/QuestMilo_9to10_2_1") #不好,好
	end
	if $game_temp.choice == 1
		call_msg("CompMilo:Milo/QuestMilo_9to10_3")
		call_msg("CompMilo:Milo/QuestMilo_9to10_3board")
		call_msg("CompMilo:Milo/QuestMilo_9to10_3opt") #不好,好
	end
	
	if $game_temp.choice == 1 #背叛CECILy
		call_msg("CompMilo:Milo/QuestMilo_9to10_yes0")
		optain_item($data_items[52],10)
		call_msg("CompMilo:Milo/QuestMilo_9to10_yes1")
		$story_stats["RecQuestMilo"] = 11
		$story_stats["RecQuestMiloAmt"] = $game_date.dateAmt
	elsif $game_temp.choice == 0 #不同意
		call_msg("CompMilo:Milo/QuestMilo_9to10_refuse")
		$story_stats["RecQuestMilo"] = 10
		$story_stats["RecQuestMiloAmt"] = $game_date.dateAmt
	end
	
else
	$game_temp.choice = -1
	call_msg("CompMilo:Milo/elseBegin") #\optB[沒事,盧德辛,諾爾鎮,席芭莉絲]
	case $game_temp.choice
	when 1
		call_msg("CompMilo:Milo/elseBegin_Rudesind")
	when 2
		call_msg("CompMilo:Milo/elseBegin_Noer")
	when 3
		call_msg("CompMilo:Milo/elseBegin_Sybaris")
	end
end

eventPlayEnd
$story_stats["HiddenOPT0"] = "0" 


#### CHECK BALLOON
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestMilo"] == 2
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestMilo"] == 3
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestMilo"] == 6
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestMilo"] == 9