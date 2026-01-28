
if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end


if $story_stats["RecQuestLisa"] == 12 && $story_stats["RecQuestLisaAmt"] >= $game_date.dateAmt && $story_stats["UniqueCharUniqueElise"] != -1
	
	call_msg("CompLisa:Lisa12/triggerHer0")
	questDate = 14
	$story_stats["HiddenOPT1"] = questDate/2 #quest timer
	call_msg("CompLisa:Lisa12/triggerHer0_board")
	$story_stats["HiddenOPT1"] = 0
	$game_temp.choice = -1
	call_msg("common:Lona/Decide_optB")
	if $game_temp.choice == 1
		set_comp=false
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
			call_msg("CompLisa:Lisa12/triggerHer1")
			$story_stats["RecQuestLisa"] = 14
			portrait_hide
			chcg_background_color(0,0,0,0,7)
			get_character(0).set_this_event_companion_ext("CompExtUniqueLisaDown",false,questDate+$game_date.dateAmt)
			get_character(0).delete
			$game_map.reserve_summon_event("CompExtUniqueLisaDown",$game_player.x,$game_player.y)
			get_character($game_map.get_storypoint("ExitPoint")[2]).call_balloon(28,-1)
			chcg_background_color(0,0,0,255,-7)
		end
	end
elsif $story_stats["RecQuestLisa"] == 13
	SndLib.sound_QuickDialog
	call_msg_popup("CompLisa:Lisa13/Qmsg#{rand(3)}")
	
else #lisa deaD QUEST FAILED
	get_character(0).call_balloon(0)
	$story_stats["RecQuestLisa"] = 13
	$story_stats["UniqueCharUniqueLisa"] = -1
	call_msg("CompLisa:Lisa13/triggerHer0")
	call_msg("CompLisa:Lisa13/triggerHer1")
	call_msg("CompLisa:Lisa/dead")
	optain_exp(1)
end
eventPlayEnd