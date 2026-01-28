if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).call_balloon(0)
if $story_stats["SMCloudVillage_KidRevange"] == 1
	call_msg("TagMapNoerRelayOut:Griot/Begin0")
	portrait_hide
	get_character(0).animation = nil
	get_character(0).call_balloon(8)
	wait(60)
	$story_stats["SMCloudVillage_KidRevange"] = 2
end
tmpPicked = ""
tmpLeave = false
call_msg("TagMapNoerRelayOut:Griot/Begin1",0,2,0)
until [false,"Cancel","OPT_KillTheKid"].include?(tmpPicked)
	tmpPicked = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]								,"Cancel"]
	tmpTarList << [$game_text["TagMapNoerRelayOut:Griot/OPT_About"]						,"OPT_About"]
	tmpTarList << [$game_text["TagMapNoerRelayOut:Griot/OPT_Letter"]					,"OPT_Letter"] if $story_stats["SMCloudVillage_KidRevange"] == 3 && !$game_system.mails["SMCloudVillage"].nil?
	tmpTarList << [$game_text["TagMapNoerRelayOut:Griot/OPT_HelpTheKid"]				,"OPT_HelpTheKid"] if $story_stats["SMCloudVillage_KidRevange"] == 3
	tmpTarList << [$game_text["TagMapNoerRelayOut:Griot/OPT_GiveUP"]					,"OPT_GiveUP"] if $story_stats["SMCloudVillage_KidRevange"] == 3 && $game_player.actor.wisdom_trait >= 15
	tmpTarList << [$game_text["TagMapNoerRelayOut:Griot/OPT_HelpTheKid_FattieKilled"]	,"OPT_HelpTheKid_FattieKilled"] if $story_stats["SMCloudVillage_KidRevange"] >= 3 && $story_stats["UniqueCharSMCloudVillage_Boss"] == -1
	tmpTarList << [$game_text["TagMapNoerRelayOut:Griot/OPT_HelpTheKid_aggroed"]	,"OPT_HelpTheKid_aggroed"] if $story_stats["SMCloudVillage_KidRevange"] >= 3 && $story_stats["UniqueCharSMCloudVillage_Boss"] == -1
	tmpTarList << [$game_text["TagMapNoerRelayOut:Griot/OPT_KillTheKid"]				,"OPT_KillTheKid"] if $story_stats["SMCloudVillage_KillTheKid"] == 1 #&& $story_stats["SMCloudVillage_Aggroed"] != 1
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1

	case tmpPicked
		when "OPT_About"
			call_msg("TagMapNoerRelayOut:Griot/OPT_About_play0")
			call_msg("TagMapNoerRelayOut:Griot/OPT_About_play1")
			$story_stats["SMCloudVillage_KidRevange"] = 3 if $story_stats["SMCloudVillage_KidRevange"] == 2
			
		when "OPT_HelpTheKid_aggroed"
			call_msg("TagMapNoerRelayOut:Griot/OPT_HelpTheKid_aggroed_play")
			call_msg("TagMapNoerRelayOut:Griot/MAD_loop")
			
		when "OPT_HelpTheKid_FattieKilled"
			call_msg("TagMapNoerRelayOut:Griot/OPT_HelpTheKid_FattieKilled_play")
			call_msg("TagMapNoerRelayOut:Griot/MAD_loop")
			
		when "OPT_Letter"
			tmpPicked = "Cancel"
			call_msg("TagMapNoerRelayOut:Griot/OPT_Letter_Play0")
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				portrait_off
				call_msg("\\narr.....")
			chcg_background_color(0,0,0,255,-7)
			call_msg("TagMapNoerRelayOut:Griot/OPT_Letter_Play1")
			$story_stats["SMCloudVillage_KidRevange"] = 99 if $story_stats["SMCloudVillage_KidRevange"] == 3
			tmpLeave = true
			call_msg("TagMapNoerRelayOut:Griot/OPT_GiveUP_play0")
			get_character(0).npc_story_mode(true)
		
		when "OPT_KillTheKid"
			$story_stats["SMCloudVillage_KidRevange"] = -1
			call_msg("TagMapNoerRelayOut:Griot/OPT_KillTheKid_play")
			get_character(0).npc.add_fated_enemy([0])
			get_character(0).set_manual_move_type(3)
			get_character(0).move_type = 3
			get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],600)
			
		when "OPT_GiveUP"
			tmpPicked = "Cancel"
			call_msg("TagMapNoerRelayOut:Griot/OPT_GiveUP_play0")
			get_character(0).npc_story_mode(true)
			get_character(0).animation = get_character(0).animation_atk_mh
			wait(7)
			SndLib.sound_punch_hit(100,90)
			wait(2)
			$game_player.animation = $game_player.animation_stun
			call_msg("TagMapNoerRelayOut:Griot/OPT_GiveUP_play1")
			$story_stats["SMCloudVillage_KidRevange"] = 98 if $story_stats["SMCloudVillage_KidRevange"] == 3
			tmpLeave = true
		when "OPT_HelpTheKid"
			call_msg("TagMapNoerRelayOut:Griot/OPT_HelpTheKid_play")
			#call_msg("TagMapNoerRelayOut:Griot/OPT_HelpTheKid_play_brd")
			#call_msg("common:Lona/Decide_optB")
			#if $game_temp.choice == 1
			#	tmpPicked = "Cancel"
			#	call_msg("TagMapNoerRelayOut:Griot/OPT_HelpTheKid_play_yes")
			#	$story_stats["SMCloudVillage_KidRevange"] = 4
			#	call_msg("DEV map isnt finish")
			#else
			#	tmpPicked = "Cancel"
			#	call_msg("TagMapNoerRelayOut:Griot/OPT_HelpTheKid_play_no")
			#end
	end
end #until

if tmpLeave
	cam_center(0)
	portrait_hide
	3.times{
		get_character(0).direction = 2 ; get_character(0).move_forward_force
		get_character(0).move_speed = 2.8
		until !get_character(0).moving? ; wait(1) end
	}
	get_character(0).direction = 2 ; get_character(0).move_forward_force
	get_character(0).move_speed = 2.8
	get_character(0).effects=["FadeOutDelete",0,false,nil,nil,[true,false].sample]
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		cam_center(0)
		get_character(0).npc_story_mode(false)
		get_character(0).delete
		$game_player.animation = nil
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapNoerRelayOut:Griot/OPT_GiveUP_play2")
	optain_exp(4000) if $story_stats["SMCloudVillage_KidRevange"] == 98
	optain_exp(8000) if $story_stats["SMCloudVillage_KidRevange"] == 99
end

eventPlayEnd
#chk quest balloon
#tmpQ1 = $story_stats["SMCloudVillage_Aggroed"] != 1
return get_character(0).call_balloon(28,-1) if [0,1,2,3].include?($story_stats["SMCloudVillage_KidRevange"])
return get_character(0).call_balloon(28,-1) if $story_stats["SMCloudVillage_KillTheKid"] == 1 #&& tmpQ1
