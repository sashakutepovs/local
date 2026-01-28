
if $story_stats["RecQuestFishBeach"] == 0
	portrait_off
	$story_stats["RecQuestFishBeach"] = 1
	tmpStartPointX,tmpStartPointY,tmpStartPointID = $game_map.get_storypoint("StartPoint")
	tmpCfPointX,tmpCfPointY,tmpCfPointID = $game_map.get_storypoint("CfPoint")
	tmpCfdMainX,tmpCfdMainY,tmpCfdMainID = $game_map.get_storypoint("CfdMain")
	tmpCfdX,tmpCfdY,tmpCfdID = $game_map.get_storypoint("Cfd")
	tmpCfd1X,tmpCfd1Y,tmpCfd1ID = $game_map.get_storypoint("Cfd1")
	tmpCfd2X,tmpCfd2Y,tmpCfd2ID = $game_map.get_storypoint("Cfd2")
	tmpCfd3X,tmpCfd3Y,tmpCfd3ID = $game_map.get_storypoint("Cfd3")
	tmpCfd4X,tmpCfd4Y,tmpCfd4ID = $game_map.get_storypoint("Cfd4")
	tmpQuGiverID = $game_map.get_storypoint("QuGiver")[2]
	get_character(tmpCfdID).moveto(tmpCfPointX,tmpCfPointY-1)
	get_character(tmpCfdMainID).moveto(tmpCfPointX-2,tmpCfPointY-1)
	get_character(tmpCfd1ID).moveto(tmpCfPointX-1,tmpCfPointY-1)
	get_character(tmpCfd2ID).moveto(tmpCfPointX-1,tmpCfPointY)
	get_character(tmpCfd3ID).moveto(tmpCfPointX+1,tmpCfPointY-1)
	get_character(tmpCfd4ID).moveto(tmpCfPointX+1,tmpCfPointY)
	$game_player.moveto(tmpStartPointX,tmpStartPointY)
	$game_player.direction = 6
	get_character(tmpQuGiverID).opacity = 0
	SndLib.bgm_play("D/Tribal_Warfare_Drums_Only_LOOP",75,100) #80
	chcg_background_color(0,0,0,255,-7)
		$game_map.events.each{|event|
			next if !event[1].summon_data
			next if !event[1].summon_data[:CfDancer]
			event[1].force_update = true
		}
		
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:CfDancer]
				od = event[1].direction
				event[1].direction = 4
				event[1].move_forward_force
				event[1].direction = od
			}
			wait(60)
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:CfDancer]
				event[1].jump_to(event[1].x,event[1].y)
			}
			wait(20)
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:CfDancer]
				od = event[1].direction
				event[1].direction = 4
				event[1].move_forward_force
				event[1].direction = od
			}
			wait(60)
		###################################################turn
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:CfPPL]
				event[1].direction = 8
			}
		wait(8)
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:CfPPL]
				event[1].direction = 6
			}
		wait(8)
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:CfPPL]
				event[1].direction = 2
			}
		wait(8)
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:CfPPL]
				event[1].direction = 4
			}
		wait(8)
		$game_player.direction = 2 ; $game_player.call_balloon(8)
		######################################################### turn end
		2.times{
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:CfDancer]
				od = event[1].direction
				event[1].direction = 4
				event[1].move_forward_force
				event[1].direction = od
				}
			wait(60)
		}
		$game_map.events.each{|event|
			next if !event[1].summon_data
			next if !event[1].summon_data[:CfDancer]
			event[1].jump_to(event[1].x,event[1].y)
		}
		wait(10)
		###################################################turn
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:CfPPL]
				event[1].direction = 2
			}
		wait(8)
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:CfPPL]
				event[1].direction = 6
			}
		wait(8)
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:CfPPL]
				event[1].direction = 8
			}
		wait(8)
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:CfPPL]
				event[1].direction = 4
			}
		wait(8)
		######################################################### turn end
		2.times{
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:CfDancer]
				od = event[1].direction
				event[1].direction = 4
				event[1].move_forward_force
				event[1].direction = od
				}
			wait(60)
		}
		$game_map.events.each{|event|
			next if !event[1].summon_data
			next if !event[1].summon_data[:CfDancer]
			event[1].jump_to(event[1].x,event[1].y)
		}
		wait(10)
		$game_player.direction = 4 ; $game_player.call_balloon(8)
		###################################################turn
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:CfPPL]
				event[1].direction = 2
			}
		wait(8)
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:CfPPL]
				event[1].direction = 6
			}
		wait(8)
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:CfPPL]
				event[1].direction = 8
			}
		wait(8)
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:CfPPL]
				event[1].direction = 4
			}
		wait(8)
		######################################################### turn end
		2.times{
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:CfDancer]
				od = event[1].direction
				event[1].direction = 4
				event[1].move_forward_force
				event[1].direction = od
				}
			wait(60)
		}
		$game_map.events.each{|event|
			next if !event[1].summon_data
			next if !event[1].summon_data[:CfDancer]
			event[1].jump_to(event[1].x,event[1].y)
		}
		wait(10)
		get_character(tmpCfdMainID).direction = 4
		3.times{
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:CfDancer]
				od = event[1].direction
				event[1].direction = 4
				event[1].move_forward_force
				event[1].direction = od
				}
			wait(60)
		}
		$game_map.events.each{|event|
			next if !event[1].summon_data
			next if !event[1].summon_data[:CfDancer]
			event[1].jump_to(event[1].x,event[1].y)
		}
		wait(10)
		5.times{
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:CfDancer]
				od = event[1].direction
				event[1].direction = 4
				event[1].move_forward_force
				event[1].direction = od
				}
			wait(60)
		}
	call_msg("TagMapFishBeach:begin/Begin0")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
	call_msg("TagMapFishBeach:begin/Begin1")
	portrait_hide
	SndLib.bgm_stop
	get_character(tmpQuGiverID).opacity = 255
	get_character(tmpQuGiverID).call_balloon(28,-1)
end


$game_map.events.each{|event|
	next if !event[1].summon_data
	next if !event[1].summon_data[:CfDancer]
	event[1].delete
}
$game_map.events.each{|event|
	next if !event[1].summon_data
	next if !event[1].summon_data[:Watcher]
	event[1].set_npc("DeeponeCommonM")
	event[1].set_manual_move_type(1)
}

enter_static_tag_map if $story_stats["ReRollHalfEvents"] ==1
summon_companion
chcg_background_color(0,0,0,255,-7) if $story_stats["ReRollHalfEvents"] ==1
eventPlayEnd


########### aggro player if player are slave. #############
return get_character(0).erase if $game_player.actor.stat["SlaveBrand"] != 1
$game_map.npcs.each{
|event|
 next unless event.summon_data
 next unless event.summon_data[:watcher]
 next if event.deleted?
 event.npc.add_fated_enemy([0])
}
get_character(0).erase