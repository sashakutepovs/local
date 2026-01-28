tmpMobAlive = $game_map.npcs.any?{|event|
	next unless event.summon_data
	next if event.deleted?
	event.summon_data[:IsBatHive]
}

tmpHumAlive = $game_map.npcs.any?{|event|
	next unless event.summon_data
	next if event.deleted?
	next if event.npc.action_state == :death
	event.summon_data[::HumanGuard]]
}

tmpFuckerInRange = $game_map.npcs.select{|event|
	next if event.summon_data == nil
	next if event.summon_data[:NapFucker] == nil
	next if !event.summon_data[:NapFucker]
	next if event.actor.action_state != nil && event.actor.action_state !=:none
	next if !event.near_the_target?($game_player,5)
	next if !event.actor.target.nil?
	next if event.opacity != 255
	next if event.actor.sensors[0].get_signal(event,$game_player)[2] <=15 #[target,distance,signal_strength,sensortype]
	event
}


if tmpMobAlive
	region_map_wildness_nap(tmpForce="AbomBat")
elsif tmpFuckerInRange
	load_script("Data/HCGframes/event/NoerTag_Nap.rb")
elsif tmpHumAlive
	call_msg("common:Lona/NarrDriveAway")
	change_map_leave_tag_map
	portrait_hide
else
	handleNap
end

