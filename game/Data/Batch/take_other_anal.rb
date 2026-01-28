
case $game_player.actor.stat["EventAnalRace"]
when "Human" 			; $game_actors[1].anal_damage +=rand(40) 
when "Moot" 			; $game_actors[1].anal_damage +=rand(50) 
when "Orkind"			; $game_actors[1].anal_damage +=rand(70)
when "Goblin"			; $game_actors[1].anal_damage +=rand(60)
when "Abomination"		; $game_actors[1].anal_damage +=rand(70) 
when "Deepone"			; $game_actors[1].anal_damage +=rand(60) 
when "Fishkind"			; $game_actors[1].anal_damage +=rand(60) 
else 
$game_actors[1].anal_damage +=rand(40) 
end
$game_actors[1].add_state(40) if $game_actors[1].state_stack(40) !=1 && $game_actors[1].state_stack(43) !=1 #add anal bleed if anal isnt dmged
$game_actors[1].defecate_level +=rand(4)
$game_actors[1].defecate_level +=rand(5) if $game_actors[1].state_stack(43) ==1

