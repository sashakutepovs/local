$game_player.actor.add_state("MoralityDown30")
$game_player.actor.morality_lona -=1
get_character(0).summon_data = {} if !get_character(0).summon_data 
get_character(0).summon_data[:fishHP] = 5 if !get_character(0).summon_data[:fishHP]
get_character(0).summon_data[:fishHP] -= 1
get_character(0).zoom_x -= 0.1
get_character(0).zoom_y -= 0.1
common_pickup_item("ItemFish")
if get_character(0).summon_data[:fishHP] <= 0
	tmpX=get_character(0).x
	tmpY=get_character(0).y
	$game_map.reserve_summon_event("EffectOverKill",tmpX,tmpY)
	get_character(0).delete
end

