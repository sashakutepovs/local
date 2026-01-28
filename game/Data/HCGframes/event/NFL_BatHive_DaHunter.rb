if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

get_character(0)
if get_character(0).region_id == 50 && $story_stats["NFL_BatHive_helpHunter"] == 2
	tmpPtEndX,tmpPtEndY,tmpPtEndID=$game_map.get_storypoint("PtEnd")
	chcg_background_color(0,0,0,0,7)
		get_character(0).character_index = 0
		get_character(0).move_type = 0
		get_character(0).set_manual_move_type(0)
		get_character(0).npc_story_mode(true)
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapNFL_BatHive:DaHunter/Qu_success0")
	portrait_hide
	get_character(0).animation = get_character(0).animation_atk_sh
	wait(12)
	optain_item("ItemCoin1", 1)
	wait(30)
	call_msg("TagMapNFL_BatHive:DaHunter/Qu_success0_1")
	cam_center(0)
	$game_player.call_balloon(8)
	portrait_hide
	3.times{
		get_character(0).character_index = 0
		get_character(0).move_toward_TargetSmartAI(get_character(tmpPtEndID))
		get_character(0).move_speed = 3.5
		$game_player.turn_toward_character(get_character(0))
		until !get_character(0).moving? ; wait(1) end
	}
	cecEVmode = $game_player.record_companion_name_back == "UniqueCecily" && follower_in_range?(0,4)
	if cecEVmode
		tmpCecily = get_character($game_player.get_followerID(0))
		tmpCecily.turn_toward_character(get_character(0))
		call_msg("TagMapNFL_BatHive:DaHunter/Qu_success2_end_Cecily1")
		tmpCecilyMoveType = tmpCecily.move_type
		tmpCecilytmpOX = tmpCecily.x
		tmpCecilytmpOY = tmpCecily.y
		tmpCecily.npc_story_mode(true)
		tmpCecily.move_type = 0
		portrait_hide
		10.times{
			if !tmpCecily.near_the_target?(get_character(0),3)
				get_character(0).character_index = 0
				tmpCecily.move_toward_TargetSmartAI(get_character(0))
				tmpCecily.move_speed = 3.5
				get_character(0).turn_toward_character(tmpCecily)
				$game_player.turn_toward_character(get_character(0))
				until !tmpCecily.moving? ; wait(1) end
			end
		}
		tmpCecily.turn_toward_character(get_character(0))
		get_character(0).turn_toward_character(tmpCecily)
		get_character(0).character_index = 0
		call_msg("TagMapNFL_BatHive:DaHunter/Qu_success2_end_Cecily2")
		tmpCecily.turn_toward_character(get_character(0))
		get_character(0).turn_toward_character(tmpCecily)
		get_character(0).character_index = 0
		call_msg("TagMapNFL_BatHive:DaHunter/Qu_success2_end_Cecily3")
		get_character(0).animation = get_character(0).animation_atk_sh
		wait(30)
		item = $data_ItemName["ItemCoin2"]
		$game_map.popup(tmpCecily.id,4,item.icon_index,1)
		wait(60)
		
	elsif $game_player.actor.stat["persona"] == "tsundere"
		call_msg("TagMapNFL_BatHive:DaHunter/Qu_success1")
		get_character(0).turn_toward_character($game_player)
		call_msg("TagMapNFL_BatHive:DaHunter/Qu_success2")
		portrait_hide
		call_msg("TagMapNFL_BatHive:DaHunter/Qu_success2_end_tsun0")
		portrait_hide
		10.times{
			if !$game_player.near_the_target?(get_character(0),2)
				$game_player.move_toward_character(get_character(0))
				$game_player.move_speed = 3.5
				$game_player.turn_toward_character(get_character(0))
				get_character(0).turn_toward_character($game_player)
				until !$game_player.moving? ; wait(1) end
			end
		}
		$game_player.turn_toward_character(get_character(0))
		get_character(0).turn_toward_character($game_player)
		$game_player.animation = $game_player.animation_atk_mh
		$game_player.call_balloon([15,7,5].sample)
		get_character(0).animation = get_character(0).animation_stun
		SndLib.sound_punch_hit(100)
		$game_player.call_balloon(5)
		wait(60)
		call_msg("TagMapNFL_BatHive:DaHunter/Qu_success2_end_tsun1")
		get_character(0).animation = get_character(0).animation_atk_sh
		wait(30)
		optain_item("ItemCoin2", 4)
		wait(60)
	else
		call_msg("TagMapNFL_BatHive:DaHunter/Qu_success1")
		get_character(0).turn_toward_character($game_player)
		call_msg("TagMapNFL_BatHive:DaHunter/Qu_success2")
		portrait_hide
		call_msg("TagMapNFL_BatHive:DaHunter/Qu_success2_end_other")
	end
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		if cecEVmode
			tmpCecily.moveto($game_player.x,$game_player.y)
			tmpCecily.item_jump_to
			wait(10)
			tmpCecily.turn_toward_character($game_player)
			$game_player.turn_toward_character(tmpCecily)
		end
		cam_center(0)
		portrait_off
		$story_stats["NFL_BatHive_helpHunter"] = 3
		get_character(0).npc_story_mode(false)
		get_character(0).delete
	chcg_background_color(0,0,0,255,-7)
	if cecEVmode
		
		tmpCecily.animation = tmpCecily.animation_atk_sh
		wait(30)
		optain_item("ItemCoin2", 4)
		wait(60)
		tmpCecily.move_type = tmpCecilyMoveType
		tmpCecily.npc_story_mode(false)
		call_msg("TagMapNFL_BatHive:DaHunter/Qu_success2_end_Cecily4")
	else
		call_msg("TagMapNFL_BatHive:DaHunter/Qu_success2_end_tsun2") if $game_player.actor.stat["persona"] == "tsundere"
	end
	optain_exp(10000)
	eventPlayEnd
	
elsif $story_stats["NFL_BatHive_helpHunter"] == 1
	call_msg("TagMapNFL_BatHive:DaHunter/begin1")
	call_msg("TagMapNFL_BatHive:DaHunter/begin1_brd")
	call_msg("common:Lona/Decide_optB") #### Y N
	if $game_temp.choice == 1
		call_msg("TagMapNFL_BatHive:DaHunter/begin2_OPTyes")
		$story_stats["NFL_BatHive_helpHunter"] = 2
		get_character(0).set_this_event_follower(0)
		get_character(0).follower[1] = 1
		get_character(0).call_balloon(0)
		get_character(0).npc.master = $game_player
		get_character(0).move_type = 3
		get_character(0).set_manual_move_type(3)
		get_character(0).through = false
	else
		call_msg("TagMapNFL_BatHive:DaHunter/begin2_OPTno")
		get_character(0).call_balloon(29,-1)
	end
elsif $story_stats["NFL_BatHive_helpHunter"] == 2
	if get_character(0).follower[1] == 0
		get_character(0).follower[1] = 1
	elsif get_character(0).follower[1] == 1
		get_character(0).follower[1] = 0
	end
	get_character(0).process_npc_DestroyForceRoute
	tmpMsg = get_character(0).follower[1] == 0 ? "NPC/CommandWait" : "NPC/CommandFollow"
	SndLib.sound_QuickDialog
	$game_map.popup(get_character(0).id,"QuickMsg:#{tmpMsg}#{rand(2)}",0,0)
end
eventPlayEnd
