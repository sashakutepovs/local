if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
canAcceptQuest = $story_stats["RecQuestDf_Heresy"] == 3 && ($story_stats["RecQuest_Df_TellerSide"] == 2 || $story_stats["RecQuestDf_HeresyMomo"] == 2) && !($story_stats["RecQuest_Df_TellerSide"] >2 || $story_stats["RecQuestDf_HeresyMomo"] > 2)

if $story_stats["RecQuestDf_Heresy"] == 3
	call_msg("TagMapDfRefugeeCamp:HeresyPriest/RnG#{rand(3)}")
	#$story_stats["RecQuestDf_Heresy"] => 4 ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
	canAcceptQuest ? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
	$game_player.actor.wisdom_trait >= 10 && canAcceptQuest ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
	$game_player.actor.combat_trait >= 10 && $game_player.actor.weak < 25 && canAcceptQuest ? $story_stats["HiddenOPT2"] = "1" : $story_stats["HiddenOPT2"] = "0"
	#$game_player.actor.sexy >= 70 ? $story_stats["HiddenOPT3"] = "1" : $story_stats["HiddenOPT3"] = "0"
	tmpSuccess = false
	call_msg("TagMapDfRefugeeCamp:Df_Heresy/3to4_1") #\optB[沒事,生育之母？,行賄<r=HiddenOPT0>,入教<r=HiddenOPT1>,威脅<r=HiddenOPT2>]
	case $game_temp.choice
		when 0,-1
			call_msg("TagMapDfRefugeeCamp:Df_Heresy/3to4_cancel")
			tmpSuccess = false
		
		when 1 
			call_msg("TagMapDfRefugeeCamp:Df_Heresy/3to4Mother")
			return eventPlayEnd
			
		when 2 #行賄
			call_msg("TagMapDfRefugeeCamp:Df_Heresy/3to4_pay0")
			$cg.erase
			$story_stats["HiddenOPT4"] = 2000 #how much should pay?
			portrait_hide
			get_character(0).direction =  2; get_character(0).call_balloon(8) ; wait(60)
			get_character(0).direction =  4; get_character(0).call_balloon(16) ; wait(60)
			get_character(0).direction =  6; get_character(0).call_balloon(8) ; wait(60)
			get_character(0).direction =  8; get_character(0).call_balloon(16) ; wait(60)
			get_character(0).turn_toward_character($game_player); get_character(0).call_balloon(8) ; wait(60)
			call_msg("TagMapDfRefugeeCamp:Df_Heresy/3to4_pay1")
			wait(1)
			SceneManager.goto(Scene_ItemStorage)
			SceneManager.scene.prepare(System_Settings::STORAGE_TEMP)
			wait(1)
			tmpPP = $game_boxes.get_price(System_Settings::STORAGE_TEMP)
			$game_boxes.box(System_Settings::STORAGE_TEMP).clear
			if tmpPP > $story_stats["HiddenOPT4"]
				call_msg("TagMapDfRefugeeCamp:Df_Heresy/3to4_pay2")
				tmpSuccess = true
			else
				tmpSuccess = false
			end
		when 3 #入教
			tmpSuccess = true
			call_msg("TagMapDfRefugeeCamp:Df_Heresy/3to4_join0")
		when 4 #ATK
			tmpSuccess = true
			call_msg("TagMapDfRefugeeCamp:Df_Heresy/3to4_atk0")
			get_character(0).npc_story_mode(true)
			get_character(0).move_type = 0
			get_character(0).move_type = 0
			$game_player.animation = $game_player.animation_atk_mh
			wait(10)
			get_character(0).call_balloon(14)
			get_character(0).jump_to(get_character(0).x,get_character(0).y)
			get_character(0).animation = get_character(0).animation_stun
			SndLib.sound_punch_hit(100)
			wait(120)
			get_character(0).animation = nil
			get_character(0).npc_story_mode(false)
			call_msg("TagMapDfRefugeeCamp:Df_Heresy/3to4_atk1")
			get_character(0).move_type = 3
	end
	if tmpSuccess
		if cocona_in_group?
			call_msg("TagMapDfRefugeeCamp:Df_Heresy/3to4_1_cocona0")
			get_character($game_player.get_followerID(0)).actor.set_aggro(get_character(0).actor,$data_arpgskills["BasicNormal"],3000)
		end
		call_msg("TagMapDfRefugeeCamp:Df_Heresy/3to4_1BRD") if $story_stats["RecQuestDf_HeresyMomo"] == 2
		call_msg("TagMapDfRefugeeCamp:Df_Heresy/3to4_1BRD2") if $story_stats["RecQuest_Df_TellerSide"] == 2
		optain_exp(2500)
		$story_stats["RecQuestDf_Heresy"] = 4
	else
		call_msg("TagMapDfRefugeeCamp:Df_Heresy/3to4_failed")
	end
else
	call_msg("TagMapDfRefugeeCamp:HeresyPriest/RnG#{rand(3)}")
end
$story_stats["HiddenOPT4"] = "0"
$story_stats["HiddenOPT3"] = "0"
$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT2"] = "0"
$story_stats["HiddenOPT0"] = "0"
get_character(0).call_balloon(0)
eventPlayEnd
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestDf_Heresy"] == 3 && ($story_stats["RecQuest_Df_TellerSide"] == 2 || $story_stats["RecQuestDf_HeresyMomo"] == 2) && !($story_stats["RecQuest_Df_TellerSide"] >2 || $story_stats["RecQuestDf_HeresyMomo"] >= 2)