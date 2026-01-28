return if $story_stats["UniqueCharUniqueCecily"] == -1 || $story_stats["UniqueCharUniqueGrayRat"] == -1

if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end


#################################################################################################################### GR 的委託
if $story_stats["QuProgSaveCecily"] == 44 && $game_date.dateAmt >= $story_stats["RecQuestSaveCecilyAmt"]
	call_msg("CompGrayRat:44/0_begin0")
	call_msg("CompGrayRat:44/1")
	call_msg("CompGrayRat:44/2")
	call_msg("CompGrayRat:44/3")
	

	get_character($game_map.get_storypoint("ToGYM")[2]).call_balloon(28,-1)
	$story_stats["QuProgSaveCecily"] = 45
	return eventPlayEnd
	
#################################################################################################################### CEC 去2F
elsif [22,43].include?($story_stats["QuProgSaveCecily"]) && $game_date.dateAmt >= $story_stats["RecQuestSaveCecilyAmt"]
	call_msg("CompGrayRat:GrayRat/23-43_0")
	return eventPlayEnd
#################################################################################################################### CEC對洛娜的提問
elsif $story_stats["QuProgSaveCecily"] == 12 && $game_date.dateAmt >= $story_stats["RecQuestSaveCecilyAmt"]
	call_msg("CompCecily:GrayRat/QuestHikack12")
elsif $story_stats["RecQuestSaveCecily"] == 1 #完成解救後對白
	call_msg("CompGrayRat:GrayRat/KnownBegin_opt")
	case $game_temp.choice
		when 0		; call_msg("CompGrayRat:GrayRat/KnownBegin_Break")
		when 1		; call_msg("CompGrayRat:GrayRat/KnownBegin_WhyMe")
	end
	return eventPlayEnd
end


#賽希莉救出任務
$story_stats["HiddenOPT0"] = "0"
$story_stats["HiddenOPT1"] = "0"
tmpCeX,tmpCeY,tmpCeID=$game_map.get_storypoint("Cecily")
if $story_stats["GuildCompletedScoutCampOrkind"] >=1 && $story_stats["RecQuestSaveCecily"] == 0 && $story_stats["QuProgSaveCecily"] == 0 && get_character(tmpCeID).deleted?
	if $story_stats["RecordGrayRatsFirstTimeTalked"] == 0
		$story_stats["RecordGrayRatsFirstTimeTalked"] =1 
		call_msg("CompGrayRat:GrayRat/SaveCecilyQuest_begin1")
		call_msg("CompGrayRat:GrayRat/SaveCecilyQuest_begin2")
		call_msg("CompGrayRat:GrayRat/SaveCecilyQuest_begin3")
	end
	call_msg("CompGrayRat:GrayRat/SaveCecilyQuestInfo")
	call_msg("common:Lona/Decide_optB")
	case $game_temp.choice 
		when 0,-1
			get_character(0).call_balloon(28,-1)
			return eventPlayEnd
		when 1
			call_msg("CompGrayRat:GrayRat/SaveCecilyQuestAccept")
			optain_item($data_items[50],5)
			optain_item($data_items[51],2)
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				portrait_off
				get_character(0).delete
				$cg.erase
				$story_stats["QuProgSaveCecily"] = 1
				get_character(0).call_balloon(0)
			chcg_background_color(0,0,0,255,-7)
	end
	return eventPlayEnd
end


#未做任務前之通用對白
if $story_stats["RecQuestSaveCecily"] == 0
	call_msg("CompGrayRat:GrayRat/UnknowBegin")
	return eventPlayEnd
end

eventPlayEnd
