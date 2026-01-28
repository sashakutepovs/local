
do_ret = false
no_more_until = nil
until do_ret
	tmp_fucker_id = nil
	tmpFuckerNPCs = $game_map.npcs.select{|event| 
		next if event.summon_data == nil
		next if event.summon_data[:NapFucker] == nil
		next if !event.summon_data[:NapFucker]
		next if event.actor.action_state != nil && event.actor.action_state !=:none
		next if !event.near_the_target?($game_player,5)
		next if !event.actor.target.nil?
		next if event.opacity != 255
		next if event.actor.sensors[0].get_signal(event,$game_player)[2] <=15 #[target,distance,signal_strength,sensortype]
		event
	}
	if !tmpFuckerNPCs.empty?
		tgtEV = tmpFuckerNPCs.sample
		tgtEV.summon_data[:NapFucker] = false
		tmp_fucker_id = tgtEV.id
	end
	break if !tmp_fucker_id
	tmpFuckerNPCs.each{|event|
		event.call_balloon([1,4,8,3].sample)
		event.moveto(event.x,event.y)
	}
	
	if tmp_fucker_id != nil && !$game_map.threat
		get_character(tmp_fucker_id).setup_audience
		get_character(tmp_fucker_id).move_type =0
		get_character(tmp_fucker_id).opacity = 255
		get_character(tmp_fucker_id).animation = nil
		get_character(tmp_fucker_id).call_balloon(2)
		get_character(tmp_fucker_id).turn_toward_character($game_player)
		tmpRACE= "_#{get_character(tmp_fucker_id).actor.race}"
		call_msg("common:Noer/NapRape#{tmpRACE}#{rand(2)}")
		get_character(tmp_fucker_id).npc_story_mode(true,false)
		wait(80)
			10.times{
				if get_character(tmp_fucker_id).report_range($game_player) > 1
					get_character(tmp_fucker_id).move_speed = 2.8
					get_character(tmp_fucker_id).move_toward_TargetSmartAI($game_player)
					get_character(tmp_fucker_id).call_balloon(8)
					until !get_character(tmp_fucker_id).moving?
						wait(1)
					end
				end
			}
		get_character(tmp_fucker_id).call_balloon(4)
		get_character(tmp_fucker_id).npc_story_mode(false,false)
		get_character(tmp_fucker_id).turn_toward_character($game_player)
		call_msg("common:Noer/NapRape1#{tmpRACE}")
		call_msg("common:Noer/NapRape2#{tmpRACE}")
		goto_sex_point_with_character(get_character(tmp_fucker_id),"rand",tmpMoveToCharAtEnd=false)
		do_ret = false
		$game_player.turn_toward_character(get_character(tmp_fucker_id))
		$game_player.call_balloon(0)
		$game_player.animation = nil
		call_msg("common:Lona/NapRape3")
		get_character(tmp_fucker_id).call_balloon(20)
		call_msg("common:Noer/NapRape3#{tmpRACE}#{rand(3)}")
		if $game_player.actor.sta > 0
			call_msg("common:Lona/NapRape_withSta") #\optD[我是便器<t=3>,反抗]
			do_ret = false
			case $game_temp.choice
				when 0
					call_msg("common:Lona/NapRape_withSta_NoFight1#{talk_persona}")
					call_msg("TagMapNoerTavern:CommonPPL/NapRape_withSta_NoFight2")
				when 1
					player_cancel_nap
					do_ret = true
					get_character(tmp_fucker_id).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
					$game_player.turn_toward_character(get_character(tmp_fucker_id))
					$game_player.animation = $game_player.animation_atk_charge
					$game_player.actor.sta -= 5
					wait(15)
					SndLib.sound_punch_hit(100)
					SndLib.sound_punch_hit(100)
					SndLib.sound_punch_hit(100)
					get_character(tmp_fucker_id).npc_story_mode(true,false)
						get_character(tmp_fucker_id).push_away
						$game_player.turn_toward_character(get_character(tmp_fucker_id))
						get_character(tmp_fucker_id).turn_toward_character($game_player)
						until !get_character(tmp_fucker_id).moving?
							wait(1)
						end
					get_character(tmp_fucker_id).npc_story_mode(false,false)
					call_msg("common:Lona/NapRape_withSta_Fight1#{talk_persona}")
					get_character(tmp_fucker_id).call_balloon(20)
					call_msg("common:Noer/NapRape_withSta_Fight2#{tmpRACE}#{rand(3)}")
			end
			$game_temp.choice = -1
			get_character(tmp_fucker_id).actor.process_target_lost if !do_ret
			return eventPlayEnd if do_ret
		else
			call_msg("common:Lona/NapRape_noSta")
			$story_stats["sex_record_coma_sex"] +=1 if $game_player.actor.sta <=-100
		end
		get_character(tmp_fucker_id).moveto($game_player.x,$game_player.y)
		play_sex_service_menu(get_character(tmp_fucker_id),0,nil,true)
		get_character(tmp_fucker_id).turn_toward_character($game_player)
		get_character(tmp_fucker_id).actor.process_target_lost
		$game_player.animation = $game_player.animation_stun
	end
end #until


if tmp_fucker_id == nil
	if $game_player.actor.stat["SlaveBrand"] == 1
		return handleNap if !check_enemy_survival?("FishPPL",false)
		$story_stats["SlaveOwner"] = "FishTownR"
		$story_stats["OnRegionMapSpawnRace"] = "FishPPL"
		call_msg("TagMapFishTown:Guard/NapSlave")
		$story_stats["RapeLoop"] = 1
		$story_stats["Kidnapping"] =1
		$game_player.actor.sta =-100
		region_map_wildness_nap
		
	elsif $game_player.actor.morality < 1
		return handleNap if !check_enemy_survival?("FishPPL",false)
		$story_stats["OnRegionMapSpawnRace"] = "FishPPL"
		call_msg("TagMapFishTown:Guard/NapLowMora")
		$story_stats["RapeLoop"] = 1
		$story_stats["Kidnapping"] =1
		$game_player.actor.sta =-100
		region_map_wildness_nap
	else
		handleNap
	end
end
