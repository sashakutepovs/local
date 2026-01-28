
case $game_player.actor.stat["EventVagRace"]
when "Human" 			; $game_actors[1].vag_damage +=rand(40) 
when "Moot" 			; $game_actors[1].vag_damage +=rand(50) 
when "Orkind"			; $game_actors[1].vag_damage +=rand(70)
when "Goblin"			; $game_actors[1].vag_damage +=rand(50)
when "Abomination"		; $game_actors[1].vag_damage +=rand(70) 
when "Deepone"			; $game_actors[1].vag_damage +=rand(60) 
when "Fishkind"			; $game_actors[1].vag_damage +=rand(60) 
else 
$game_actors[1].vag_damage +=rand(40)
end
$game_actors[1].urinary_level +=rand(5)
$game_actors[1].urinary_level +=rand(5) if $game_actors[1].state_stack(42) ==1
