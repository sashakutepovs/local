

module GIM_CHCG
		def commonEvents_Overevent_MainStats
			if $game_player.reqUpdateHomNormal
				$game_player.reqUpdateHomNormal = false
				check_over_event(parallel=true)
				check_half_over_event(parallel=true)
			end
			check_MainStats_event(parallel=true)
		end
		def commonEvents_Dialog_Options
			$game_message.add($game_temp.preserved_message)
		end
		def commonEvents_Load_RubyScript
			tmpRB = $game_temp.load_RB_Frame
			$game_temp.load_RB_Frame = nil
			load_script(tmpRB)
		end
		def commonEvents_Dropitem
			#commonEV_drop_items
			return if $story_stats.data["record_dropped_items"].nil?
			return $story_stats.data["record_dropped_items"].clear if $game_map.isOverMap
			$story_stats.data["record_dropped_items"].each{|items|
				#[items,召喚腳色]
				items[0].each{|item|
					EvLib.sum(item,items[1].x,items[1].y,{:user=>$game_player})
				}
			}
			$story_stats.data["record_dropped_items"]=nil
		end
		def commonEvents_SummonEvent
			return if $game_temp.summon_events.length==0
			$game_temp.summon_events.each{|s_ev|
				ev = $game_map.summon_event(s_ev[0],s_ev[1],s_ev[2],s_ev[3],s_ev[4])
			}
			$game_temp.summon_events.clear
		end
		def commonEvents_reserve_storypoint
			$game_map.get_story_event($game_temp.reserved_story).start
			$game_temp.reserved_story=nil
		end
		def commonEvents_reserve_region_event
			#return if $game_temp.region_event_id==0
			#load_script("Data/MapConfig/OverMapRegion_#{$game_temp.region_event_id}.rb")

			return if $game_temp.region_event_id==0
			p "OverMapRegion #{$game_temp.region_event_id}"
			overmap_event_EnterMap
		end
		def commonEvents_HOM_OverMap
			check_over_event
			check_half_over_event
			check_overmap_event
		end
		def commonEvents_Load_MSG
			call_msg("#{$game_temp.load_MSG}")
			$game_temp.load_MSG = nil
		end
		def commonEvents_Load_Eval
			eval($game_temp.load_EVAL)
			$game_temp.load_EVAL = nil
		end
end
