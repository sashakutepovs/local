SndLib.WaterIn(80,100+rand(30))
survivalEffect = 8 #diffcult
$game_player.animation = $game_player.animation_mc_pick_up
tmpRate = rand(100) + (survivalEffect * $game_player.actor.survival)
$game_player.actor.sta -= rand(5+1)

if tmpRate >= 60
	common_pickup_item("ItemFish")
	get_character(0).delete
else
	$game_map.popup(0,"QuickMsg:Lona/CatchAnimal_failed#{rand(2)}",0,0)
	get_character(0).move_random_water
end