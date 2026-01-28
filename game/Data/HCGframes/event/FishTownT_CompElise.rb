if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

	call_msg("CompElise:FishResearch1/15_begin7_opt")
	case $game_temp.choice 
		when 0,-1
		when 1
			
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
				$story_stats["RecQuestElise"] = 16
				get_character(0).animation = nil
				call_msg("CompElise:FishResearch1/16_begin1")
				portrait_hide
				chcg_background_color(0,0,0,0,7)
					tmpRG13X,tmpRG13Y,tmpRG13ID=$game_map.get_storypoint("RG13")
					tmpBbX,tmpBbY,tmpBbID=$game_map.get_storypoint("BB")
					tmpBbR1X,tmpBbR1Y,tmpBbR1ID=$game_map.get_storypoint("BBRnd1")
					tmpBbR2X,tmpBbR2Y,tmpBbR2ID=$game_map.get_storypoint("BBRnd2")
					tmpBbR3X,tmpBbR3Y,tmpBbR3ID=$game_map.get_storypoint("BBRnd3")
					tmpSwX,tmpSwY,tmpSwID=$game_map.get_storypoint("Swirl")
					
					get_character(tmpBbID).moveto(tmpSwX,tmpSwY)
					get_character(tmpBbR1ID).moveto(tmpSwX,tmpSwY)
					get_character(tmpBbR2ID).moveto(tmpSwX,tmpSwY)
					get_character(tmpBbR3ID).moveto(tmpSwX,tmpSwY)
					get_character(tmpBbID).move_type = 3
					get_character(tmpBbR1ID).move_type = 3
					get_character(tmpBbR2ID).move_type = 3
					get_character(tmpBbR3ID).move_type = 3
					get_character(tmpBbR1ID).set_manual_move_type(3)
					get_character(tmpBbR2ID).set_manual_move_type(3)
					get_character(tmpBbR3ID).set_manual_move_type(3)
					get_character(tmpRG13ID).set_region_trigger(13)
					
					get_character(0).set_this_event_companion_ext("CompExtUniqueElise",false)
					get_character(0).delete
					$game_map.reserve_summon_event("CompExtUniqueElise",$game_player.x,$game_player.y)
					wait(20)
					$game_map.npcs.each do |event| 
						next if event.summon_data == nil
						next unless event.summon_data[:UniqueNpc] == "Elise"
						event.npc.fated_enemy = [8]
					end
					$game_map.npcs.each do |event| 
						next if event.summon_data == nil
						next unless event.summon_data[:FishDude]
						event.npc.death_event="EffectCharDed"
					end
					
				chcg_background_color(0,0,0,255,-7)
				call_msg("CompElise:FishResearch1/16_begin2")
			end
	end