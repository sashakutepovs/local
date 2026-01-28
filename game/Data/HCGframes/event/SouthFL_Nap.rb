
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
	tmp_fucker_id = event.id
}
if tmp_fucker_id
	do_ret = false
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
			event.summon_data[:NapFucker] = false
			play_sex = true
			tmp_fucker_id = event.id
		}
		break if !tmp_fucker_id
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
			goto_sex_point_with_character(get_character(tmp_fucker_id),"closest",tmpMoveToCharAtEnd=false)
			do_ret = false
			$game_player.turn_toward_character(get_character(tmp_fucker_id))
			$game_player.call_balloon(0)
			$game_player.animation = nil
			call_msg("common:Lona/NapRape3")
			get_character(tmp_fucker_id).call_balloon(20)
			call_msg("common:Noer/NapRape3#{tmpRACE}#{rand(3)}")
			if $game_player.actor.sta > 0
				$game_player.call_balloon(0)
				$game_player.actor.add_state("DoormatUp20")
				$game_player.actor.add_state("DoormatUp20")
				$game_player.animation = nil
				$game_player.actor.cancel_holding
				$game_player.actor.reset_skill(true)
				call_msg("common:Lona/NapRape_withSta") #\optD[我是便器<t=3>,反抗]
				do_ret = false
				case $game_temp.choice
					when 0
						call_msg("common:Lona/NapRape_withSta_NoFight1#{talk_persona}")
						call_msg("common:Noer/NapRape_withSta_NoFight2#{tmpRACE}#{rand(3)}")
					when 1
						player_cancel_nap
						do_ret = true
						get_character(tmp_fucker_id).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
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
			$game_player.animation = $game_player.animation_stun
			get_character(tmp_fucker_id).actor.process_target_lost
		end
	end #until
end #if tmp Fucker ID

if tmp_fucker_id == nil
	if $game_player.actor.morality < 1
		portrait_hide
		chcg_background_color(0,0,0,0,7)
		portrait_off
		call_msg("TagMapSouthFL:Nap/GameOver0")
		3.times{
			$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
			SndLib.sound_gore(100)
			SndLib.sound_combat_hit_gore(70)
			wait(20+rand(20))
		}
		return load_script("Data/HCGframes/OverEvent_Death.rb")
	
	else
		handleNap
	end
end
