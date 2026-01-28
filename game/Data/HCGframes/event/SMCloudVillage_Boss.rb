if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

tmpRG2id = $game_map.get_storypoint("RG2")[2]
tmpRG28id = $game_map.get_storypoint("rg28")[2]
tmpDualBiosID=$game_map.get_storypoint("DualBios")[2]
tmpBossAtkX,tmpBossAtkY,tmpBossAtkID=$game_map.get_storypoint("BossAtk")
get_character(tmpDualBiosID).summon_data[:NoToQuest] = true if $story_stats["SMCloudVillage_KillTheKid"] >= 1 || $story_stats["SMCloudVillage_KidRevange"] >= 3
if $story_stats["SMCloudVillage_KillTheKid"] == 2
	call_msg("TagMapSMCloudVillage:Boss/Talked#{rand(3)}")

elsif [0,1].include?($story_stats["SMCloudVillage_KillTheKid"])
	if $story_stats["SMCloudVillage_KillTheKid"] == 0
		call_msg("TagMapSMCloudVillage:Boss/begin0")
	else
		call_msg("TagMapSMCloudVillage:Boss/KillTheKid1_alreadyAccepted")
	end
		tmpPicked = ""
		tmpTarList = []
		tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]							,"Cancel"]
		tmpTarList << [$game_text["TagMapSMCloudVillage:Boss/beginOPT_TheKidDeadLie"]	,"beginOPT_TheKidDeadLie"] if $story_stats["SMCloudVillage_KillTheKid"] >= 1 && $story_stats["SMCloudVillage_KidRevange"] >= 3 && $game_player.actor.wisdom_trait >= 15
		tmpTarList << [$game_text["TagMapSMCloudVillage:Boss/beginOPT_TheKidDead"]		,"beginOPT_TheKidDead"] if $story_stats["SMCloudVillage_KillTheKid"] >= 1 && $story_stats["UniqueCharNoerRelayOut_PoorBoy"] == -1
		tmpTarList << [$game_text["TagMapSMCloudVillage:Boss/beginOPT_TheKidSaid"]		,"beginOPT_TheKidSaid"] if $story_stats["SMCloudVillage_KidRevange"] >= 3 && get_character(tmpDualBiosID).summon_data[:NoToQuest] == true
		tmpTarList << [$game_text["TagMapSMCloudVillage:Boss/beginOPT_KilltheKid"]		,"beginOPT_KilltheKid"] if $story_stats["SMCloudVillage_KillTheKid"] == 0
		cmd_sheet = tmpTarList
		cmd_text =""
		for i in 0...cmd_sheet.length
			cmd_text.concat(cmd_sheet[i].first+",")
			p cmd_text
		end
		call_msg("\\optB[#{cmd_text}]")
		$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
		$game_temp.choice = -1
	case tmpPicked
		when "beginOPT_TheKidDeadLie","beginOPT_TheKidDead"
			#turn off exit allow
			p "do it #{get_character(tmpRG2id).erased?}"
			get_character(tmpRG2id).set_region_trigger(2)
			$story_stats["SMCloudVillage_KillTheKid"] = 2
			get_character(tmpRG28id).set_region_trigger(28)
			tmpTrapHouseID = $game_map.get_storypoint("TrapHouse")[2]
			get_character(tmpDualBiosID).summon_data[:BossfirstTimeTalked] = true
			call_msg("TagMapSMCloudVillage:Boss/SMCloudVillage_KillTheKid2_1")
			portrait_hide
			cam_center(0)
			get_character(0).npc_story_mode(true)
			tmpXYchk = get_character(0).y == $game_player.y-1
			if tmpXYchk
				1.times{
					get_character(0).direction = 4 ; get_character(0).move_forward_force
					get_character(0).direction = 6
					get_character(0).move_speed = 3
					until !get_character(0).moving? ; wait(1) end
				}
			else
				1.times{
					get_character(0).direction = 2 ; get_character(0).move_forward_force
					get_character(0).direction = 8
					get_character(0).move_speed = 3
					until !get_character(0).moving? ; wait(1) end
				}
			end
			get_character(0).npc_story_mode(false)
			call_msg("TagMapSMCloudVillage:Boss/SMCloudVillage_KillTheKid2_2")
			get_character(tmpTrapHouseID).call_balloon(28,-1)
			if $story_stats["UniqueCharSMCloudVillage_BossAtk"] != -1
				get_character(tmpBossAtkID).moveto(tmpBossAtkX,tmpBossAtkY-2)
				get_character(tmpBossAtkID).direction = 8
			end
			optain_exp(4000)
		when "beginOPT_TheKidSaid"
			call_msg("TagMapSMCloudVillage:Boss/TheKidSaid_play")
			call_msg("TagMapSMCloudVillage:Boss/CatcheLona")
			$story_stats["SMCloudVillage_KillTheKid"] = -1
			tmpAggroID=$game_map.get_storypoint("aggro")[2]
			get_character(tmpAggroID).start
			optain_exp(4000)
			
		when "beginOPT_KilltheKid"
			$game_temp.choice = 0
			call_msg("TagMapSMCloudVillage:Boss/SMCloudVillage_KillTheKid0_1")
			savedDIRp = $game_player.direction
			savedDIR = get_character(0).direction
			$game_player.direction = 4
			get_character(0).direction = 4
			call_msg("TagMapSMCloudVillage:Boss/SMCloudVillage_KillTheKid0_2")
			$game_player.direction = savedDIRp
			get_character(0).direction = savedDIR
			call_msg("TagMapSMCloudVillage:Boss/SMCloudVillage_KillTheKid0_3")
			call_msg("TagMapSMCloudVillage:Boss/SMCloudVillage_KillTheKid0_4_brd")
			call_msg("common:Lona/Decide_optB")
			if $game_temp.choice == 1
				get_character(tmpDualBiosID).summon_data[:AcceptQuest] = true
				call_msg("TagMapSMCloudVillage:Boss/SMCloudVillage_KillTheKid1_A")
				call_msg("TagMapSMCloudVillage:Boss/SMCloudVillage_KillTheKid1_yes")
				$story_stats["SMCloudVillage_KillTheKid"] = 1
			else
				call_msg("TagMapSMCloudVillage:Boss/SMCloudVillage_KillTheKid1_A")
				call_msg("TagMapSMCloudVillage:Boss/SMCloudVillage_KillTheKid1_no")
				get_character(tmpDualBiosID).summon_data[:NoToQuest] = true
			end
	end
#elsif get_character(tmpDualBiosID).summon_data[:TalkedGuard] == true && !get_character(tmpDualBiosID).summon_data[:BossfirstTimeTalked]
#elsif get_character(tmpDualBiosID).summon_data[:BossfirstTimeTalked]
#	call_msg("TagMapSMCloudVillage:Boss/Talked#{rand(3)}")
#	
else
	call_msg("TagMapSMCloudVillage:Boss/aggro0")
	get_character(0).direction = 4
		tmpAggroID=$game_map.get_storypoint("aggro")[2]
		get_character(tmpAggroID).start
	$game_player.call_balloon(19)
	get_character(0).move_type = 1
	call_msg("TagMapSMCloudVillage:Boss/aggro1")
end
eventPlayEnd


tmpQ1 = $story_stats["SMCloudVillage_Aggroed"] == 0
tmpQ2 = $story_stats["UniqueCharNoerRelayOut_PoorBoy"] == -1
tmpQ3 = $story_stats["SMCloudVillage_KillTheKid"] == 1
tmpQ4 = $story_stats["UniqueCharSMCloudVillage_Boss"] != -1
tmpQ5 = $story_stats["SMCloudVillage_KidRevange"] >= 3
tmpQ6 = $game_player.actor.wisdom_trait >= 15
return get_character(0).call_balloon(28,-1) if tmpQ1 && tmpQ2 && tmpQ3 && (tmpQ4|| (!tmpQ4 && tmpQ5 && tmpQ6))
return get_character(0).call_balloon(28,-1) if $story_stats["SMCloudVillage_KillTheKid"] == 0
