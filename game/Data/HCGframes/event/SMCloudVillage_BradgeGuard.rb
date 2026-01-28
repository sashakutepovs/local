if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
tmpDualBiosID=$game_map.get_storypoint("DualBios")[2]

############################################################接受任務 放LONA出去
if get_character(tmpDualBiosID).summon_data[:LetLonaLeave]
	call_msg("TagMapSMCloudVillage:BradgeGuard/letLeaveLoop")
elsif get_character(tmpDualBiosID).summon_data[:AcceptQuest]
	tmpRG2id = $game_map.get_storypoint("RG2")[2]
	tmpRG3id = $game_map.get_storypoint("RG3")[2]
	get_character(tmpDualBiosID).summon_data[:LetLonaLeave] = true
	get_character(tmpRG2id).set_region_trigger(65535)
	get_character(tmpRG3id).erase
	#get_character(0).summon_data[:GateOpened] = true
	call_msg("TagMapSMCloudVillage:BradgeGuard/letLeave")
	get_character(0).npc_story_mode(true)
	default_MT = get_character(0).move_type
	get_character(0).move_type = 0
	2.times{
		get_character(0).direction = 4 ; get_character(0).move_forward_force
		get_character(0).move_speed = 3
		until !get_character(0).moving? ; wait(1) end
	}
	get_character(0).direction = 8 ; get_character(0).move_forward_force
	get_character(0).move_speed = 3
	get_character(0).direction = 2
	get_character(0).summon_data[:GateOpened] = true
	get_character(tmpDualBiosID).summon_data[:TalkedGuard] = true
	get_character(tmpDualBiosID).summon_data[:RG2aggro] = false
	get_character(0).move_type = default_MT
	until !get_character(0).moving? ; wait(1) end
	get_character(0).npc_story_mode(false)
############################################################ AGGROED
elsif get_character(0).summon_data[:GateOpened] == true || !get_character(tmpDualBiosID).summon_data[:RG2aggro]
	call_msg("TagMapSMCloudVillage:BradgeGuard/Opened")
	return eventPlayEnd
############################################################ 來過 且非敵對
elsif [1,2].include?($story_stats["SMCloudVillage_KillTheKid"]) && $story_stats["SMCloudVillage_Aggroed"] != 1#若曾經來過 且非敵對
	call_msg("TagMapSMCloudVillage:BradgeGuard/Already")
	get_character(0).npc_story_mode(true)
	default_MT = get_character(0).move_type
	get_character(0).move_type = 0
	portrait_hide
	cam_center(0)
	3.times{
		get_character(0).direction = 4 ; get_character(0).move_forward_force
		get_character(0).move_speed = 3
		$game_player.turn_toward_character(get_character(0))
		until !get_character(0).moving? ; wait(1) end
	}
	get_character(0).direction = 8 ; get_character(0).move_forward_force
	get_character(0).move_speed = 3
	get_character(0).direction = 2
	get_character(0).summon_data[:GateOpened] = true
	get_character(tmpDualBiosID).summon_data[:TalkedGuard] = true
	get_character(tmpDualBiosID).summon_data[:RG2aggro] = false
	get_character(0).move_type = default_MT
	until !get_character(0).moving? ; wait(1) end
	$game_player.direction = 6
	get_character(0).npc_story_mode(false)
	
	tmpBossID=$game_map.get_storypoint("Boss")[2]
	get_character(tmpBossID).call_balloon(28,-1) if $story_stats["SMCloudVillage_Aggroed"] == 0 && $story_stats["SMCloudVillage_KillTheKid"] == 0
	get_character(0).summon_data[:GateOpened] = true
	get_character(tmpDualBiosID).summon_data[:TalkedGuard] = true
	get_character(tmpDualBiosID).summon_data[:RG2aggro] = false
	return eventPlayEnd
############################################################ 初次到來
else
	call_msg("TagMapSMCloudVillage:BradgeGuard/Begin0")
	portrait_hide
	get_character(0).npc_story_mode(true)
	default_MT = get_character(0).move_type
	get_character(0).move_type = 0
		10.times{
			get_character(0).direction = 6 ; get_character(0).move_forward_force
			get_character(0).move_speed = 4.5
			until !get_character(0).moving? ; wait(1) end
		}
		3.times{
			$game_player.call_balloon(8)
			wait(60)
		}
		10.times{
			get_character(0).direction = 4 ; get_character(0).move_forward_force
			get_character(0).move_speed = 4.5
			until !get_character(0).moving? ; wait(1) end
		}
		call_msg("TagMapSMCloudVillage:BradgeGuard/Begin1")
		portrait_hide
		3.times{
			get_character(0).direction = 4 ; get_character(0).move_forward_force
			get_character(0).move_speed = 3
			until !get_character(0).moving? ; wait(1) end
		}
		get_character(0).direction = 8 ; get_character(0).move_forward_force
		get_character(0).move_speed = 3
		get_character(0).direction = 2
		until !get_character(0).moving? ; wait(1) end
		$game_player.direction = 8
	get_character(0).move_type = default_MT
	get_character(0).npc_story_mode(false)
	call_msg("TagMapSMCloudVillage:BradgeGuard/CecilyExtra") if $game_player.record_companion_name_back == "UniqueCecily"
	tmpBossID=$game_map.get_storypoint("Boss")[2]
	get_character(tmpBossID).call_balloon(28,-1) if $story_stats["SMCloudVillage_Aggroed"] == 0 && $story_stats["SMCloudVillage_KillTheKid"] == 0
	get_character(0).summon_data[:GateOpened] = true
	get_character(tmpDualBiosID).summon_data[:TalkedGuard] = true
	get_character(tmpDualBiosID).summon_data[:RG2aggro] = false
	#chcg_background_color(0,0,0,0,7)
	#chcg_background_color(0,0,0,255,-7)
	
end
eventPlayEnd