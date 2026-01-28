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

##釋放腳色
if get_character(0).switch1_id >= get_character(0).summon_data[:staNeed]
	thisGateID = get_character(0).summon_data[:Wall]
	$game_map.events.each{|event|
		next unless event[1].summon_data
		next unless event[1].summon_data[:Wall] == thisGateID
		next unless event[1].summon_data[:isWall]
		event[1].set_event_terrain_tag(0)
	}
	$game_map.events.each{|event|
		next unless event[1].summon_data
		next unless event[1].summon_data[:Wall] == thisGateID
		next unless event[1].summon_data[:GateNPC]
		event[1].set_npc(event[1].summon_data[:GateNPC])
		event[1].set_manual_move_type(3)
		event[1].set_move_frequency(5)
		event[1].set_sensor_freq(360)
		event[1].move_type = 3
		event[1].move_frequency = 5
		event[1].direction = 2
		event[1].call_balloon(1)
		event[1].npc.death_event = "EffectCharDed"
		event[1].npc.fraction_mode = 4
		event[1].npc.set_morality(-99)
		event[1].npc.set_fraction(event[1].summon_data[:NPCfac]) if event[1].summon_data[:NPCfac]
	}
end







