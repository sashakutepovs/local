
########################################################################################### VAG
if $game_player.actor.stat["EventVagRace"] != nil && $game_player.actor.stat["VaginalDamaged"] != 1
	case $game_player.actor.stat["EventVagRace"]
		when "Human" 			; tmpVagRoll =rand(7) ; raceVal=0.3
		when "Moot" 			; tmpVagRoll =rand(6) ; raceVal=0.6
		when "Orkind"			; tmpVagRoll =rand(4) ; raceVal=1
		when "Goblin"			; tmpVagRoll =rand(6) ; raceVal=1.1
		when "Abomination"		; tmpVagRoll =rand(4) ; raceVal=1
		when "Fishkind"			; tmpVagRoll =rand(5) ; raceVal=0.5
		when "Deepone"			; tmpVagRoll =rand(6) ; raceVal=0.7
		when "Troll"			; tmpVagRoll =rand(2) ; raceVal=1
		else; 		 			; tmpVagRoll =rand(6) ; raceVal=1
	end
	temp_value_roll2 = [(rand(100+$game_player.actor.dirt)*raceVal),100].min >= 50
	if $game_player.actor.stat["EffectWet"] == 1 #wet
		$game_actors[1].add_wound("groin") if tmpVagRoll == 1 && temp_value_roll2
		$game_map.reserve_summon_event("WasteBlood") if tmpVagRoll == 1 && temp_value_roll2 && !$game_map.isOverMap
		$game_actors[1].add_state(37) if $game_player.actor.stat["WoundGroin"] == 3 && tmpVagRoll ==1 && temp_value_roll2 #add bleed if W_groin ==3
		
	elsif $game_player.actor.stat["CumsCreamPie"] >= 1#moon cream pie
		$game_actors[1].add_wound("groin") if tmpVagRoll == 1 && temp_value_roll2
		$game_map.reserve_summon_event("WasteBlood") if tmpVagRoll ==1 && temp_value_roll2 && !$game_map.isOverMap
		$game_actors[1].add_state(37) if $game_player.actor.stat["WoundGroin"] ==3 && tmpVagRoll ==1 && temp_value_roll2 #add bleed if W_groin ==3
		
	else
		$game_actors[1].add_wound("groin") if tmpVagRoll == 1
		$game_map.reserve_summon_event("WasteBlood") if tmpVagRoll ==1 && !$game_map.isOverMap
		$game_actors[1].add_state(37) if $game_player.actor.stat["WoundGroin"] ==3 && tmpVagRoll ==1#add bleed if W_groin ==3
		$game_actors[1].health -= rand(3) if $story_stats["Setup_Hardcore"] >= 1
	end
end


########################################################################################### Anal
if $game_player.actor.stat["EventAnalRace"] != nil && $game_player.actor.stat["SphincterDamaged"] != 1
	case $game_player.actor.stat["EventAnalRace"]
		when "Human" 			; tmpAnalRoll =rand(7) ; raceVal=0.3
		when "Moot" 			; tmpAnalRoll =rand(6) ; raceVal=0.6
		when "Orkind"			; tmpAnalRoll =rand(4) ; raceVal=1
		when "Goblin"			; tmpAnalRoll =rand(6) ; raceVal=1.1
		when "Abomination"		; tmpAnalRoll =rand(4) ; raceVal=1
		when "Fishkind"			; tmpAnalRoll =rand(5) ; raceVal=0.5
		when "Deepone"			; tmpAnalRoll =rand(6) ; raceVal=0.7
		when "Troll"			; tmpAnalRoll =rand(2) ; raceVal=1
		else; 		 			; tmpAnalRoll =rand(6) ; raceVal=1
	end
	temp_value_roll2 = [(rand(100+$game_player.actor.dirt)*raceVal),100].min >= 50
	if $game_player.actor.stat["EffectWet"] == 1 #wet
		$game_actors[1].add_wound("groin") if tmpAnalRoll == 1 && temp_value_roll2
		$game_map.reserve_summon_event("WasteBlood") if tmpAnalRoll == 1 && temp_value_roll2 && !$game_map.isOverMap
		$game_actors[1].add_state(40) if $game_player.actor.stat["WoundGroin"] == 3 && tmpAnalRoll ==1 && temp_value_roll2 #add bleed if W_groin ==3
		
	elsif $game_player.actor.stat["CumsMoonPie"] >= 1#moon cream pie
		$game_actors[1].add_wound("groin") if tmpAnalRoll == 1 && temp_value_roll2
		$game_map.reserve_summon_event("WasteBlood") if tmpAnalRoll == 1 && temp_value_roll2 && !$game_map.isOverMap
		$game_actors[1].add_state(40) if $game_player.actor.stat["WoundGroin"] ==3 && tmpAnalRoll ==1 && temp_value_roll2 #add bleed if W_groin ==3
		
	else
		$game_actors[1].add_wound("groin") if tmpAnalRoll == 1
		$game_map.reserve_summon_event("WasteBlood") if tmpAnalRoll == 1 && !$game_map.isOverMap
		$game_actors[1].add_state(40) if $game_player.actor.stat["WoundGroin"] == 3 && tmpAnalRoll ==1#add bleed if W_groin ==3
		$game_actors[1].health -= rand(3) if $story_stats["Setup_Hardcore"] >= 1
	end
end