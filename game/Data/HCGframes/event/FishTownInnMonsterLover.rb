if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if $story_stats["RecQuestSeaWitch"] == 3 && $story_stats["UniqueCharUniqueSeaWitch"] != -1 && $game_player.record_companion_name_ext != "FishTownInnCompExtConvoy"
					call_msg("CompSeaWitch:3to4/traveler_begin0")
					call_msg("CompSeaWitch:3to4/traveler_begin1")
					set_comp=false
					
					if $game_player.record_companion_name_ext == nil
					
						set_comp = true
					elsif $game_player.record_companion_name_ext != nil
					
						$game_temp.choice = -1
						call_msg("commonComp:notice/ExtOverWrite")
						call_msg("common:Lona/Decide_optD")
						if $game_temp.choice ==1
						set_comp=true
						end
					end
					if set_comp
						chcg_background_color(0,0,0,0,7)
							tmpEV = get_character(0)
							tmpEV.set_this_event_companion_ext("FishTownInnCompExtConvoy",false,4+$game_date.dateAmt)
							$game_map.reserve_summon_event("FishTownInnCompExtConvoy",tmpEV.x,tmpEV.y)
							tmpEV.set_this_event_follower_remove
							tmpEV.delete
						chcg_background_color(0,0,0,255,-7)
						call_msg("CompSeaWitch:3to4/traveler_begin2")
					end
	
else
	call_msg("TagMapFishTownInn:traveler/Rand#{rand(3)}")
end
eventPlayEnd