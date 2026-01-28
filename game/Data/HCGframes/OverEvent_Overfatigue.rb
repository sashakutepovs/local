
		if $story_stats["Kidnapping"] == 1
			$game_player.actor.sta = -99
		else
			$game_player.move_normal
			$game_player.actor.determine_death
			p "trigger auto nap"
			$story_stats["WildDangerous"] +=15 if $story_stats["OnRegionMap"] >=1
			if $game_player.actor.preg_level ==5
				load_script("Data/Batch/birth_trigger.rb")
			end
			$game_player.animation = $game_player.animation_overfatigue if $game_player.animation == nil && $game_player.actor.action_state == :death
			$game_player.moveto($game_player.x,$game_player.y)
			wait(130)
			$game_map.napEventId.nil? ?  handleNap : $game_map.call_nap_event
		end