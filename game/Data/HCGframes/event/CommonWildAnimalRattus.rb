survivalEffect = 8
get_character(-1).animation = get_character(-1).animation_mc_pick_up
tmpRoll = rand(100) + (survivalEffect *$game_actors[1].survival)
$game_actors[1].sta -= rand(2+1)
if tmpRoll >= 60 || get_character(0).summon_data[:RollHP] == 0
	common_pickup_item("AnimalRattus")
	get_character(0).delete
else
	get_character(0).summon_data[:RollHP] -= 1
	$game_map.popup(0,"QuickMsg:Lona/CatchAnimal_failed#{rand(2)}",0,0)
	SndLib.sys_buzzer
	get_character(0).actor.play_sound(:sound_alert1,100)
	get_character(0).item_jump_to
	get_character(0).turn_away_from_character($game_player)
end