if $story_stats["RecQuest_Df_TellerSide"] >= 3
	tmpMobAlive = $game_map.npcs.any?{|event|
	next unless event.summon_data
	next unless event.summon_data[:WildnessNapEvent]
	next if event.deleted?
	next if event.npc.action_state == :death
	true
	}
	$story_stats["RapeLoop"] = 1 if tmpMobAlive
	if $story_stats["OnRegionMapSpawnRace"] != "Orkind" && $story_stats["RapeLoop"] != 1
		tmpMobAlive = $game_map.npcs.any?{
		|event| 
		next unless event.summon_data
		next unless event.summon_data[:Mercenary]
		next if event.deleted?
		next if event.npc.action_state == :death
		tmpEvent = event
		true
		}
		$game_boxes.box(System_Settings::STORAGE_TEMP_MAP).clear if tmpMobAlive
		handleNap
	elsif $story_stats["RapeLoop"] == 1
		tmp_x,tmp_y=$game_map.get_storypoint("WakeUp")
		$game_player.moveto(tmp_x,tmp_y)
		$story_stats["RapeLoop"] =1
		$story_stats["OnRegionMapSpawnRace"] = "Orkind"
		$story_stats["Kidnapping"] =1
		$game_player.actor.sta =-100
		region_map_wildness_nap
	else
		handleNap
	end
	return
end

tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
tmpMobAlive = $game_map.npcs.any?{
|event| 
next unless event.summon_data
next unless event.summon_data[:Heretic]
next if event.deleted?
next if event.npc.action_state == :death
true
}
#if torture
do_ret = false
no_more_until = nil
until do_ret
	tmp_fucker_id = nil
	tmpFuckerNPCs = $game_map.npcs.select{|event| 
		next if event.summon_data == nil
		next if event.summon_data[:NapFucker] == nil
		next if !event.summon_data[:NapFucker]
		next if event.actor.action_state != nil && event.actor.action_state !=:none
		next if !event.near_the_target?($game_player,3)
		next if !event.actor.target.nil?
		next if event.opacity != 255
		next if event.actor.sensors[0].get_signal(event,$game_player)[2] <=5 #[target,distance,signal_strength,sensortype]
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
	if tmp_fucker_id != nil
		$story_stats["DreamPTSD"] = "Bandit" if $game_player.actor.mood <= -50
		get_character(tmp_fucker_id).setup_audience
		get_character(tmp_fucker_id).opacity = 255
		get_character(tmp_fucker_id).animation = nil
		get_character(tmp_fucker_id).call_balloon(2)
		get_character(tmp_fucker_id).turn_toward_character($game_player)
		call_msg("TagMapNoerPrison:Prisoner/NapRape_#{rand(3)}")
		get_character(tmp_fucker_id).npc_story_mode(true,false)
		wait(80)
		get_character(tmp_fucker_id).move_goto_xy($game_player.x,$game_player.y)
		get_character(tmp_fucker_id).call_balloon(8)
		wait(48)
		get_character(tmp_fucker_id).move_random
		get_character(tmp_fucker_id).call_balloon(8)
		wait(48)
		get_character(tmp_fucker_id).move_goto_xy($game_player.x,$game_player.y)
		get_character(tmp_fucker_id).call_balloon(8)
		wait(48)
		get_character(tmp_fucker_id).call_balloon(4)
		get_character(tmp_fucker_id).npc_story_mode(false,false)
		get_character(tmp_fucker_id).turn_toward_character($game_player)
		call_msg("TagMapDfWaterCave:NapRngRape/0_#{rand(2)}")
		goto_sex_point_with_character(get_character(tmp_fucker_id),nil,tmpMoveToCharAtEnd=false)
		do_ret = false
		$game_player.turn_toward_character(get_character(tmp_fucker_id))
		$game_player.call_balloon(0)
		$game_player.animation = nil
		call_msg("common:Lona/NapRape3")
		if $game_player.actor.sta > 0
			call_msg("common:Lona/NapRape_withSta") #\optD[我是便器<t=3>,反抗]
			case $game_temp.choice
				when 0
					call_msg("common:Lona/NapRape_withSta_NoFight1#{talk_persona}")
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
					call_msg("TagMapNoerMobHouse:NapRngRape/1_0_NO")
			end
			$game_temp.choice = -1
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

# nohting
#if tmpMobAlive && tmp_fucker_id
#####################################################處於RAPELOOP中  且需要與人交配
if tmpMobAlive && !tmp_fucker_id && get_character(tmpDualBiosID).summon_data[:BeginRaped] == true && $story_stats["Captured"] == 1
	rape_loop_drop_item(false,false)
	if get_character(tmpDualBiosID).summon_data[:SexWithSomeOne] == true
		get_character(tmpDualBiosID).summon_data[:SexWithSomeOne] = false
		tmpX,tmpY=$game_map.get_storypoint("WakeUp")
		$game_player.moveto(tmpX,tmpY)
		$story_stats["Captured"] = 1
		return handleNap
		
	else get_character(tmpDualBiosID).summon_data[:SexWithSomeOne] == false# && $game_player.actor.sta <=-100
		call_msg("TagMapDfWaterCave:actionRapeLoop/Sleep_opt") #[算了,睡覺]
		if $game_temp.choice == 0
			return player_cancel_nap
			call_msg("TagMapDfWaterCave:actionRapeLoop/Blocked#{rand(3)}")
		else
			get_character(tmpDualBiosID).summon_data[:RapeLoopDoNothingAggroLevel] += 1
			tmpX,tmpY=$game_map.get_storypoint("WakeUp")
			$game_player.moveto(tmpX,tmpY)
			if get_character(tmpDualBiosID).summon_data[:RapeLoopDoNothingAggroLevel] >= 3
				call_msg("TagMapDfWaterCave:actionRapeLoop/DidntDoSex_PlusAggroRate0_0")
				call_msg("TagMapDfWaterCave:actionRapeLoop/DidntDoSex_PlusAggroRate1_3")
				$story_stats["RapeLoopTorture"] = 1
			else
				call_msg("TagMapDfWaterCave:actionRapeLoop/DidntDoSex_PlusAggroRate0_0")
				case get_character(tmpDualBiosID).summon_data[:RapeLoopDoNothingAggroLevel]
					when 1 ;call_msg("TagMapDfWaterCave:actionRapeLoop/DidntDoSex_PlusAggroRate1_1")
					when 2 ;call_msg("TagMapDfWaterCave:actionRapeLoop/DidntDoSex_PlusAggroRate1_2")
					else   ;call_msg("TagMapDfWaterCave:actionRapeLoop/DidntDoSex_PlusAggroRate1_3")
				end
			end
			$cg.erase
			$story_stats["Captured"] = 1
			return handleNap
		end
	#else
	#	call_msg("TagMapDfWaterCave:actionRapeLoop/Blocked#{rand(3)}")
	#	return player_cancel_nap
	end
#####################################################被人抓了的狀態
elsif tmpMobAlive && !tmp_fucker_id && get_character(tmpDualBiosID).summon_data[:BeginRaped] == false
	rape_loop_drop_item(false,false)
	if $story_stats["Captured"] == 0
		call_msg("TagMapDfWaterCave:NapCapture/0")
		tmpX,tmpY=$game_map.get_storypoint("WakeUp")
		$game_player.moveto(tmpX,tmpY)
	end
	tmpX,tmpY=$game_map.get_storypoint("WakeUp")
	$game_player.moveto(tmpX,tmpY)
	$story_stats["Captured"] = 1
	return handleNap
else
	portrait_hide
	$story_stats["RapeLoopTorture"] = 0
	$story_stats["Captured"] = 0
	get_character(tmpDualBiosID).summon_data[:BeginRaped] = false
	get_character(tmpDualBiosID).summon_data[:GangRaped] = false
	return handleNap
end
