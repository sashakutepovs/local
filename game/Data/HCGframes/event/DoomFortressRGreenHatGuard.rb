if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

#$story_stats["RecQuestDFR_GreenHat"] == 0
if $story_stats["RecQuestDFR_GreenHat"] == 0
	get_character(0).animation = nil
	call_msg("TagMapDoomFortress:GreenHat/Quest_Begin1") #[聽下去]
	if $game_temp.choice == 0
		call_msg("TagMapDoomFortress:GreenHat/Quest_Begin2")
		call_msg("TagMapDoomFortress:GreenHat/Quest_BeginBoard")
		call_msg("TagMapDoomFortress:GreenHat/Quest_BeginOpt")
		if $game_temp.choice == 1
			call_msg("TagMapDoomFortress:GreenHat/Quest_BeginAgree")
			$story_stats["RecQuestDFR_GreenHat"] =1
			cam_center(0)
			$game_map.popup(0,1,235,1)
			SndLib.sound_equip_armor
			$game_system.add_mail("DFR_LoveLetter1")
			wait(30)
			optain_item($data_items[50],1)
			wait(30)
			optain_item($data_items[51],1)
		else
			call_msg("TagMapDoomFortress:GreenHat/Quest_BeginDis")
		end
	end
elsif $story_stats["RecQuestDFR_GreenHat"] == 2
	get_character(0).animation = nil
	$story_stats["HiddenOPT1"] = "0"
	$story_stats["HiddenOPT1"] = "1" if $game_player.actor.wisdom_trait >= 10
	call_msg("TagMapDoomFortress:GreenHat/Quest3_OPT") #[你是個好人,說謊<r=HiddenOPT1>]
	case $game_temp.choice
		when 0
			call_msg("TagMapDoomFortress:GreenHat/Quest3_Truth0")
			$story_stats["RecQuestDFR_GreenHat"] = 3
			chcg_background_color(0,0,0,0,7)
				call_msg("TagMapDoomFortress:GreenHat/Quest3_Truth1")
			chcg_background_color(0,0,0,255,-7)
			call_msg("TagMapDoomFortress:GreenHat/Quest3_Truth2")
			get_character($game_map.get_storypoint("SleepRoom")[2]).call_balloon(0)
			get_character(0).npc.fraction_mode = 3
			get_character(0).npc.stat.set_stat("mood",-100)
			optain_exp(2000*2)
			
		when 1
			call_msg("TagMapDoomFortress:GreenHat/Quest3_Lie0")
			call_msg("TagMapDoomFortress:GreenHat/Quest3_Lie1")
			call_msg("TagMapDoomFortress:GreenHat/Quest3_Lie2")
			get_character($game_map.get_storypoint("SleepRoom")[2]).call_balloon(0)
			$story_stats["RecQuestDFR_GreenHat"] = 4
			optain_exp(4000*2)
			
	end
	
elsif $story_stats["RecQuestDFR_GreenHat"] == 1
	get_character(0).animation = nil
	SndLib.sound_QuickDialog
	call_msg_popup("TagMapDoomFortress:GreenHat/Quest2_Qmsg#{rand(3)}",get_character(0).id)
end



cam_center(0)
portrait_hide
$game_temp.choice = -1

############################Check balloon
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestDFR_GreenHat"] == 0
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestDFR_GreenHat"] == 2