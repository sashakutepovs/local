if get_character(0).summon_data[:Locked] == false
	tmpID= get_character(0).id
	doorEV_setup(tmpID,tmpPG=1,tmpTG=0,tmpSnd="openDoor",[0,-24])
else
	if $game_map.threat
		SndLib.sys_buzzer
		$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
		return
	end
	if $game_player.direction != get_character(0).switch2_id
		SndLib.sound_step_chain
		if get_character(0).switch1_id >= get_character(0).summon_data[:staNeed]
			call_msg("TagMapNoerMobHouse:Door/Unlocked")
			case $game_temp.choice
			when 0,-1
			when 1
				$game_player.jump_to($game_player.x,$game_player.y-2) if $game_player.direction ==8
				$game_player.jump_to($game_player.x,$game_player.y+2) if $game_player.direction ==2
			end
		else
			
			
			
			
			if get_character(0).switch1_id ==0
			call_msg("TagMapNoerMobHouse:Door/FristTime")
			end
			
			$story_stats["HiddenOPT1"] = "0"
			$story_stats["HiddenOPT1"] = "1" if $game_player.actor.sta > 0
			call_msg("TagMapNoerMobHouse:Door/TryBrokeOpt1")
			
			
			if $game_temp.choice == 1
			$story_stats["HiddenOPT1"] = "0"
			$story_stats["HiddenOPT2"] = "0"
			$story_stats["HiddenOPT3"] = "0"
			$story_stats["HiddenOPT4"] = "0"
			$story_stats["HiddenOPT1"] = "1" if $game_player.actor.sta >=20
			$story_stats["HiddenOPT2"] = "1" if $game_player.actor.sta >=40
			$story_stats["HiddenOPT3"] = "1" if $game_player.actor.sta >=80
			$story_stats["HiddenOPT4"] = "1" if $game_player.actor.sta >=120
			call_msg("TagMapNoerMobHouse:Door/TryBrokeOpt2")
			case $game_temp.choice
				when 0,-1
				when 1 ;temp_cost = 10
				when 2 ;temp_cost = 20
				when 3 ;temp_cost = 40
				when 4 ;temp_cost = 80
				when 5 ;temp_cost = 120
			end
				if $game_temp.choice >=1
					$cg.erase
					chcg_background_color(0,0,0,1,7)
					wait(35)
					SndLib.sound_step_chain(100,90+rand(20))
					wait(35)
					SndLib.sound_step_chain(100,90+rand(20))
					wait(35)
					SndLib.sound_step_chain(100,90+rand(20))
					wait(35)
					SndLib.sound_step_chain(100,90+rand(20))
					get_character(0).switch1_id += temp_cost
					$game_player.actor.sta -= 1+temp_cost
					chcg_background_color(0,0,0,255,-7)
						if get_character(0).switch1_id >= get_character(0).summon_data[:staNeed]
						get_character(0).moveto(1,1)
						call_msg("TagMapHumanPrisonCave:HumanPrisonCave/Windcave_Opt_diged_open")
						else
						call_msg("TagMapNoerMobHouse:Door/TryBroke_still")
						end
				end
			end
			
			
			
			$story_stats["HiddenOPT1"] = "0" 
			$story_stats["HiddenOPT2"] = "0" 
			$story_stats["HiddenOPT3"] = "0" 
			$story_stats["HiddenOPT4"] = "0" 
			$game_temp.choice = -1
			
			
		end
		portrait_hide
	else
		call_msg("TagMapNoerMobHouse:Door/UnlockedOUT")
		if $game_temp.choice == 1
			chcg_background_color(0,0,0,1,7)
			wait(35)
			SndLib.sound_step_chain(100,90+rand(20))
			wait(35)
			SndLib.sound_step_chain(100,90+rand(20))
			wait(35)
			SndLib.sound_step_chain(100,90+rand(20))
			wait(35)
			SndLib.sound_step_chain(100,90+rand(20))
			call_msg("TagMapNoerMobHouse:Door/UnlockedOUT_win")
			get_character(0).switch1_id = get_character(0).summon_data[:staNeed]
			get_character(0).moveto(1,1)
			chcg_background_color(0,0,0,255,-7)
		end
		$game_temp.choice == -1
	end
end









