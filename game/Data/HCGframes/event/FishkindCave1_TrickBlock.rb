
if get_character(0).summon_data[:flap] == false
 get_character(0).opacity = 255
 set_this_event_force_page(1)
 get_character(0).summon_data[:flap] = true
else
 get_character(0).opacity = 125
 set_this_event_force_page(2)
 get_character(0).summon_data[:flap] = false
end
tmpDoAction = $game_map.events.any?{|event|
	next if event[1].npc?
	next if !event[1].summon_data
	next unless event[1].summon_data[:card] == true
	next event[1].summon_data[:flap] == false
	true
}
if tmpDoAction
	$game_player.actor.sta -= 1
	$game_map.interpreter.screen.start_shake(1,7,20)
	SndLib.stoneCollapsed(80)
else
	$game_map.interpreter.screen.start_shake(1,7,60)
	SndLib.stoneCollapsed(100)
	wait(5)
	SndLib.stoneCollapsed(100)
	SndLib.sound_FlameCast(100,70)
	wait(5)
	SndLib.stoneCollapsed(100)
	$game_map.events.each{|event|
		next if !event[1].summon_data
		next unless event[1].summon_data[:card] == true
		event[1].trigger = -1
		event[1].effects=["FadeOutDelete",0,false,nil,nil,[true,false].sample]
	}
end
