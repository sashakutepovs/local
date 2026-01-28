

tmpOpeningCAM1Id=$game_map.get_storypoint("OpeningCAM1")[2]
tmpOpeningCAM2Id=$game_map.get_storypoint("OpeningCAM2")[2]
tmpOpeningCAM3Id=$game_map.get_storypoint("OpeningCAM3")[2]
$game_map.set_fog("SubStay")
$game_map.shadows.set_color(120, 120, 120)
$game_map.shadows.set_opacity(110)
$game_map.interpreter.map_background_color

$hudForceHide = true
$balloonForceHide = true

cam_follow(tmpOpeningCAM1Id,0)

$game_map.events.each{|ev|
	next unless ev[1].summon_data
	next unless ev[1].summon_data[:OPgroup1]
	ev[1].move_type = 3
	ev[1].force_update = true
}
chcg_background_color(0,0,0,255,-4)
wait(240)
chcg_background_color(0,0,0,0,4)
	cam_follow(tmpOpeningCAM2Id,0)
	$game_map.events.each{|ev|
		next unless ev[1].summon_data
		next unless ev[1].summon_data[:OPgroup1]
		ev[1].delete
	}
	$game_map.events.each{|ev|
		next unless ev[1].summon_data
		next unless ev[1].summon_data[:OPgroup2]
		ev[1].move_type = 3
		ev[1].force_update = true
	}
chcg_background_color(0,0,0,255,-4)
wait(260)
chcg_background_color(0,0,0,0,4)
	eventPlayEnd
	cam_follow(tmpOpeningCAM3Id,0)
	$game_map.events.each{|ev|
		next unless ev[1].summon_data
		next unless ev[1].summon_data[:OPgroup2]
		ev[1].delete
	}
	$game_map.events.each{|ev|
		next unless ev[1].summon_data
		next unless ev[1].summon_data[:OPgroup3]
		ev[1].move_type = 3
		ev[1].force_update = true
	}
chcg_background_color(0,0,0,255,-4)
wait(300)
chcg_background_color(0,0,0,0,7)
	$game_map.events.each{|ev|
		next unless ev[1].summon_data
		next unless ev[1].summon_data[:OPgroup3] || ev[1].summon_data[:OPgroup2] || ev[1].summon_data[:OPgroup1]
		ev[1].delete
	}

	enter_static_tag_map
	$game_player.opacity = 255
chcg_background_color(0,0,0,255,-7)
$hudForceHide = false
$balloonForceHide = false
eventPlayEnd
