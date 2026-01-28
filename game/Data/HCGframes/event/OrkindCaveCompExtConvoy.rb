tmpEV = get_character(0)
if $story_stats["Captured"] ==1
	SndLib.sound_QuickDialog
	$game_map.popup(tmpEV.id,"QuickMsg:NPC/F_OrkindMeatToilet#{rand(12)}",0,0)

elsif $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)

elsif tmpEV.npc? && tmpEV.region_id == 50
	set_comp=false
	call_msg("commonNPC:victim/Convoy_start2")
	call_msg("common:Lona/Decide_optB")
	if $game_temp.choice ==1 && $game_player.record_companion_name_ext == nil
		set_comp=true
	elsif $game_temp.choice ==1 && $game_player.record_companion_name_ext != nil
		$game_temp.choice = -1
		call_msg("commonComp:notice/ExtOverWrite")
		call_msg("common:Lona/Decide_optD")
		if $game_temp.choice ==1
		set_comp=true
		end
	end
	if set_comp
		chcg_background_color(0,0,0,0,7)
		$story_stats["RecQuestConvoyTarget"] = [21,22] #Inside Noer
		tmpEV.set_this_event_companion_ext("OrkindCaveCompExtConvoy",false,10+$game_date.dateAmt)
		$game_map.reserve_summon_event("OrkindCaveCompExtConvoy",tmpEV.x,tmpEV.y)
		tmpEV.set_this_event_follower_remove
		tmpEV.delete
		chcg_background_color(0,0,0,255,-7)
	end

else
	 if !tmpEV.npc?
		$game_temp.choice = -1
		call_msg("commonNPC:victim/Convoy_opt")
		if $game_temp.choice == 1
			tmpEV.animation = nil
			tmpEV.call_balloon(0)
			call_msg("commonNPC:victim/Convoy_start0")
			call_msg("commonNPC:victim/Convoy_start1")
			tmpEV.set_npc("DungeonVictimHumanF_follower")
			$game_player.set_follower(tmpEV.id)
			tmpEV.set_this_event_follower(0)
			tmpEV.set_manual_move_type(3)
			tmpEV.move_type = 3
			tmpEV.npc.master = $game_player
			tmpEV.npc.no_aggro= true
			tmpEV.follower[1] = 1
			$game_temp.choice = -1
		end
	else
		if tmpEV.follower[1] == 0
			tmpEV.follower[1] = 1
		elsif tmpEV.follower[1] == 1
			tmpEV.follower[1] = 0
		end
		tmpEV.process_npc_DestroyForceRoute
		tmpMsg = tmpEV.follower[1] == 0 ? "NPC/CommandWait" : "NPC/CommandFollow"
		SndLib.sound_QuickDialog
		$game_map.popup(get_character(0).id,"QuickMsg:#{tmpMsg}#{rand(2)}",0,0)
	end
end
