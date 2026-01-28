temp_value_roll =0
case $game_player.actor.stat["EventMouthRace"]
	when "Human" 			; temp_value_roll =rand(7) ; raceVal=0.3
	when "Moot" 			; temp_value_roll =rand(6) ; raceVal=0.6
	when "Orkind"			; temp_value_roll =rand(2) ; raceVal=1
	when "Goblin"			; temp_value_roll =rand(2) ; raceVal=1.1
	when "Abomination"		; temp_value_roll =rand(5) ; raceVal=1
	when "Deepone"			; temp_value_roll =rand(4) ; raceVal=0.5
	when "Fishkind"			; temp_value_roll =rand(4) ; raceVal=0.7
	when "Troll"			; temp_value_roll =rand(2) ; raceVal=1
	when "Others" 			; temp_value_roll =rand(5) ; raceVal=1
	else ; temp_value_roll =rand(7)
end
temp_value_roll2 = [(rand(100+$game_player.actor.dirt)*raceVal),100].min >= 50
$game_player.actor.add_wound("head") if temp_value_roll ==1 && temp_value_roll2
$game_map.reserve_summon_event("WasteBlood") if temp_value_roll ==1 && !$game_map.isOverMap