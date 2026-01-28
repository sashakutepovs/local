if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
	tmpLdoorX,tmpLdoorY,tmpLdoorID=$game_map.get_storypoint("Ldoor")
	tmpLexitX,tmpLexitY,tmpLexitID=$game_map.get_storypoint("Lexit")
	tmpRdoorX,tmpRdoorY,tmpRdoorID=$game_map.get_storypoint("Rdoor")
	tmpRexitX,tmpRexitY,tmpRexitID=$game_map.get_storypoint("Rexit")
	tmpApe1X,tmpApe1Y,tmpApe1ID=$game_map.get_storypoint("Ape1")
	tmpApe2X,tmpApe2Y,tmpApe2ID=$game_map.get_storypoint("Ape2")
	tmpApeGuard1X,tmpApeGuard1Y,tmpApeGuard1ID=$game_map.get_storypoint("ApeGuard1")
	tmpApeGuard2X,tmpApeGuard2Y,tmpApeGuard2ID=$game_map.get_storypoint("ApeGuard2")
	tmpPriestX,tmpPriestY,tmpPriestID=$game_map.get_storypoint("Priest")
	get_character(0).animation = nil
if $story_stats["RecQuestAriseVillageApe"] == 0
	###############################################################################################################
	if $game_player.actor.weak <= 25 || $game_player.actor.stat["SlaveBrand"] == 1
		call_msg("TagMapAriseVillage:Rho/begin0")
	else
		call_msg("TagMapAriseVillage:Rho/begin0_weak")
		return eventPlayEnd
	end
	call_msg("TagMapAriseVillage:Rho/begin1")
	call_msg("TagMapAriseVillage:Rho/begin2_brd")
	call_msg("common:Lona/Decide_optB")
	if $game_temp.choice == 1
		get_character(tmpApe1ID).moveto(tmpApe1X,tmpApe1Y)
		get_character(tmpApeGuard1ID).moveto(tmpApeGuard1X,tmpApeGuard1Y)
		get_character(tmpApeGuard2ID).moveto(tmpApeGuard2X,tmpApeGuard2Y)
		get_character(tmpApe1ID).call_balloon(28,-1)
		get_character(tmpRexitID).call_balloon(28,-1)
		get_character(tmpLdoorID).call_balloon(28,-1)
		get_character(tmpRdoorID).call_balloon(0)
		get_character(0).call_balloon(0)
		tmpRG14ID=$game_map.get_storypoint("rg14")[2]
		get_character(tmpRG14ID).set_region_trigger(14)
		$story_stats["RecQuestAriseVillageApe"] = 1
		call_msg("TagMapAriseVillage:Rho/begin3_yes")
	else
		call_msg("TagMapAriseVillage:Rho/begin3_no")
	end
elsif $story_stats["RecQuestAriseVillageApe"] == 2
	if !get_character(tmpApe1ID).nil? && get_character(tmpApe1ID).npc? && get_character(tmpApe1ID).near_the_target?(temp_target=$game_player,temp_range=5) && get_character(tmpApe1ID).summon_data && get_character(tmpApe1ID).summon_data[:Released] == true
		get_character(tmpLdoorID).call_balloon(0)
		get_character(tmpLexitID).call_balloon(0)
		get_character(tmpRdoorID).call_balloon(0)
		get_character(tmpRexitID).call_balloon(0)
		get_character(0).call_balloon(0)
		chcg_background_color(0,0,0,0,7)
			#$game_map.delete_npc(get_character(tmpApe1ID))
			#wait(1)
			#get_character(tmpApe1ID).set_npc("WildApeF")
			#wait(1)
			#get_character(tmpApe1ID).npc.add_fated_enemy([3])
			#get_character(0).npc.add_fated_enemy([4])
			#get_character(0).npc.add_fated_enemy([4])
			#wait(1)
			get_character(tmpApe1ID).set_manual_move_type(0)
			get_character(0).set_manual_move_type(0)
			get_character(tmpApe1ID).move_type = 0
			get_character(0).move_type = 0
			get_character(0).moveto(tmpPriestX,tmpPriestY)
			get_character(tmpApe1ID).moveto(tmpPriestX,tmpPriestY-2)
			$game_player.moveto(tmpPriestX+1,tmpPriestY-2)
			get_character(tmpApe1ID).direction = 2
			$game_player.direction = 2
			get_character(0).direction = 8
			get_character(0).npc_story_mode(true)
			get_character(tmpApe1ID).npc_story_mode(true)
			get_character(0).turn_toward_character($game_player)
		chcg_background_color(0,0,0,255,-7)
		wait(20)
		call_msg("TagMapAriseVillage:Rho/QuestDone0")
		get_character(0).direction = 8 ; get_character(0).move_speed = 3 ; get_character(0).move_forward_force ; wait(32)
		get_character(0).direction = 6 ; get_character(0).move_speed = 3 ; get_character(0).move_forward_force ; wait(32)
		get_character(0).direction = 8
		call_msg("TagMapAriseVillage:Rho/QuestDone1")
		get_character(0).direction = 4 ; get_character(0).move_speed = 3 ; get_character(0).move_forward_force ; wait(32)
		get_character(0).direction = 8
		call_msg("TagMapAriseVillage:Rho/QuestDone2")
		get_character(0).direction = 6 ; get_character(0).move_speed = 3 ; get_character(0).move_forward_force ; wait(32)
		get_character(0).direction = 8
		call_msg("TagMapAriseVillage:Rho/QuestDone3")
		get_character(0).direction = 4 ; get_character(0).move_speed = 3 ; get_character(0).move_forward_force ;
		get_character(0).direction = 8
		#get_character(tmpApe1ID).delete
		optain_morality(4)
		wait(30)
		optain_exp(5000)
		wait(30)
		optain_item("ItemCoin1", 10)
		
		get_character(0).npc_story_mode(false)
		get_character(tmpApe1ID).npc_story_mode(false)
		$story_stats["RecQuestAriseVillageApe"] = 3
		return eventPlayEnd
	else
		call_msg_popup("QuickMsg:CoverTar/NonNearLona")
		get_character(0).call_balloon(28,-1)
		return eventPlayEnd
	end
else
	call_msg("TagMapAriseVillage:Rho/Rng#{rand(2)}")
	return eventPlayEnd
end



eventPlayEnd
