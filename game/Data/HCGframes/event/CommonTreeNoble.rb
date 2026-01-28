if $game_map.threat
	SndLib.sys_ChangeMapFailed(80,80)
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
elsif $game_actors[1].sta <=0
	SndLib.sys_ChangeMapFailed(80,80)
	$game_map.popup(0,"QuickMsg:Lona/sta_too_low#{rand(2)}",0,0)
else
	get_character(0).switch1_id = rand(3)+1 if !get_character(0).switch1_id
	get_character(0).switch2_id = 3 if !get_character(0).switch2_id
	get_character(0).effects=["CutTree",0,false,nil,nil,[true,false].sample]
	$game_player.animation = $game_player.animation_atk_mh
	$game_player.actor.sta -= 5
	get_character(0).switch2_id -= 1
	SndLib.sys_WoodChop
	
	return if get_character(0).switch2_id != 0
	get_character(0).switch2_id = 3
	get_character(0).switch1_id -= 1
	$game_player.actor.add_state("MoralityDown30")
	$game_player.call_balloon(19)
	EvLib.sum("ItemMhWoodenClub",$game_player.x,$game_player.y)
	if get_character(0).switch1_id <= 0
		SndLib.sys_TreeFalling
		get_character(0).effects=["CutTreeFall",0,false,nil,nil,[true,false].sample]
		get_character(0).set_event_terrain_tag(0)
		get_character(0).through = true
		get_character(0).trigger = -1
		tmpData = {
			:forced_x => get_character(0).forced_x,
			:forced_y => get_character(0).forced_y,
			:zoom_x   => get_character(0).zoom_x,
			:zoom_y   => get_character(0).zoom_y
		}
		EvLib.sum("ChopedTreeBig",get_character(0).x,get_character(0).y,tmpData)
	end
end
