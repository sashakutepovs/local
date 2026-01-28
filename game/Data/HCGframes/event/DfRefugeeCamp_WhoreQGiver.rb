if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
################# RecQuestDf_Heresy done
if $story_stats["RecQuestDf_HeresyMomo"] == 2 && $game_player.record_companion_name_ext == "Df_Heresy4CompExtConvoy"
	$story_stats["RecQuestDf_HeresyMomo"] = 3
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		tmpWhoreQGiverX,tmpWhoreQGiverY,tmpWhoreQGiverID = $game_map.get_storypoint("WhoreQGiver")
		get_character($game_player.get_companion_id(-1)).moveto(tmpWhoreQGiverX,tmpWhoreQGiverY+1)
		get_character($game_player.get_companion_id(-1)).direction = 8
		get_character(0).moveto(tmpWhoreQGiverX,tmpWhoreQGiverY)
		get_character(0).direction = 2
		$game_player.moveto(tmpWhoreQGiverX-1,tmpWhoreQGiverY)
		$game_player.direction = 6
		$game_player.forced_y = 12
		get_character(0).call_balloon(0)
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapDfRefugeeCamp:Df_Heresy/4to5_0")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		cam_center(0)
		portrait_off
		$game_player.forced_y = 0
		get_character($game_player.get_companion_id(-1)).set_this_companion_disband
		$game_player.moveto(tmpWhoreQGiverX,tmpWhoreQGiverY+1)
		$game_player.direction = 8
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapDfRefugeeCamp:Df_Heresy/4to5_1")
	optain_item($data_items[50],1)
	wait(30)
	optain_exp(3000*2)
	wait(30)
	optain_morality(5)
	call_msg("TagMapDfRefugeeCamp:Df_Heresy/4to5_2")

################# Too weak   no quest for ya.
elsif $game_player.actor.weak >= 50
	call_msg("TagMapDfRefugeeCamp:Df_Heresy/1_0_weak")
	return eventPlayEnd
elsif $story_stats["RecQuestDf_HeresyMomo"] == 1
	call_msg("TagMapDfRefugeeCamp:Df_Heresy/1_0_normal")
	call_msg("TagMapDfRefugeeCamp:Df_Heresy/1_1")
	call_msg("TagMapDfRefugeeCamp:Df_Heresy/1_1_Cocona") if cocona_in_group?
	call_msg("TagMapDfRefugeeCamp:Df_Heresy/1_BRD")
	call_msg("TagMapDfRefugeeCamp:Df_Heresy/1_OPT") #no,yes
	if $game_temp.choice == 1
		#$story_stats["RecQuestDf_Heresy"] = 2
		$story_stats["RecQuestDf_HeresyMomo"] = 2
		tmpHeresyPriestID=$game_map.get_storypoint("HeresyPriest")[2]
		tmpRG2ID=$game_map.get_storypoint("rg2")[2]
		get_character(tmpRG2ID).set_region_trigger(2)
		canAcceptQuest = $story_stats["RecQuestDf_Heresy"] == 3 && ($story_stats["RecQuestDf_HeresyMomo"] == 2 || $story_stats["RecQuest_Df_TellerSide"] == 2) && !($story_stats["RecQuest_Df_TellerSide"] >2 || $story_stats["RecQuestDf_HeresyMomo"] >= 2)
		get_character(tmpHeresyPriestID).call_balloon(28,-1) if canAcceptQuest
		call_msg("TagMapDfRefugeeCamp:Df_Heresy/1_agreeEND")
		call_msg("TagMapDfRefugeeCamp:Df_Heresy/1_agreeEND_Cocona") if cocona_in_group?
		call_msg("TagMapDfRefugeeCamp:Df_Heresy/1_agreeEND_brd")
	else
		call_msg("TagMapDfRefugeeCamp:Df_Heresy/1_nopeEND")
	end
	eventPlayEnd
	
elsif $story_stats["RecQuestDf_HeresyMomo"] != 3 # done
	$game_map.popup(get_character(0).id,"TagMapDfRefugeeCamp:WhoreQgiver/Qmsg#{rand(2)}",0,0)
	SndLib.sound_QuickDialog
	
else
	$game_map.popup(get_character(0).id,"TagMapDfRefugeeCamp:Whore/Qmsg#{rand(3)}",0,0)
	SndLib.sound_QuickDialog
end

return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestDf_HeresyMomo"] == 1 || $game_player.record_companion_name_ext == "Df_Heresy4CompExtConvoy" #邪教徒 完成