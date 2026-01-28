

tmpSgX,tmpSgY,tmpSgID = $game_map.get_storypoint("securityGuard")
tmpDtX,tmpDtY,tmpDtID = $game_map.get_storypoint("DormTable")
tmpCcX,tmpCcY,tmpCcID = $game_map.get_storypoint("CorpseCart")
tmpWakeX,tmpWakeY,tmpWakeID = $game_map.get_storypoint("WakeUp")
tmpTpX,tmpTpY,tmpTpID = $game_map.get_storypoint("TorturePoint")
tmpNb1X,tmpNb1Y,tmpNb1ID = $game_map.get_storypoint("noob1")
tmpNb2X,tmpNb2Y,tmpNb2ID = $game_map.get_storypoint("noob2")
tmpNb3X,tmpNb3Y,tmpNb3ID = $game_map.get_storypoint("noob3")
tmpNbSgtX,tmpNbSgtY,tmpNbSgtID = $game_map.get_storypoint("noobSGT")
tmpShit1X,tmpShit1Y,tmpShit1ID = $game_map.get_storypoint("Shit1")
tmpShit2X,tmpShit2Y,tmpShit2ID = $game_map.get_storypoint("Shit2")
tmpShit3X,tmpShit3Y,tmpShit3ID = $game_map.get_storypoint("Shit3")
tmpShit4X,tmpShit4Y,tmpShit4ID = $game_map.get_storypoint("Shit4")
tmpTableX,tmpTableY,tmpTableID=$game_map.get_storypoint("tableSGT")
$story_stats["OnRegionMapSpawnRace"] = "HumanGuard"

#TODO 奴隸的情況下工作為何 如何引發Rapeloop
if $story_stats["Captured"] == 1
	$story_stats["DreamPTSD"] = "Slave" if $game_player.actor.mood <= -50
	tmpNightPatrolAlive = $game_map.npcs.any?{
	|event| 
		next unless event.summon_data
		next unless event.summon_data[:NightPatrol] == true
		next if event.deleted?
		next if event.npc.action_state == :death
		true
	}

	$story_stats["RapeLoopTorture"] = 1 if get_character(tmpTableID).summon_data[:WorkDone] == false && $game_date.day?
	$story_stats["RapeLoopTorture"] = 1 if get_character(tmpShit1ID).summon_data[:Opt_DoomFortress_toilet] == 1
	$story_stats["RapeLoopTorture"] = 1 if get_character(tmpShit2ID).summon_data[:Opt_DoomFortress_toilet] == 1
	$story_stats["RapeLoopTorture"] = 1 if get_character(tmpShit3ID).summon_data[:Opt_DoomFortress_toilet] == 1
	$story_stats["RapeLoopTorture"] = 1 if get_character(tmpShit4ID).summon_data[:Opt_DoomFortress_toilet] == 1
	$story_stats["RapeLoopTorture"] = 1 if tmpNightPatrolAlive
end

#######################################################  RapeLoopTorture  #######################################################
if $story_stats["Captured"] == 1 && $story_stats["RapeLoopTorture"] ==1
	$story_stats["RapeLoopTorture"] =0
	$story_stats["RapeLoop"] = 1
	portrait_hide
		chcg_background_color(0,0,0,0,7)
			#delete all walker so they wont block the way
			$game_map.events.each{|event|
				next if event[1].deleted?
				next if !event[1].summon_data
				next event[1].delete if event[1].summon_data && [true,false].include?(event[1].summon_data[:NightPatrol])
			}
		
			set_event_force_page(tmpTpID,1)
			set_event_force_page(tmpNb1ID,1)
			set_event_force_page(tmpNb2ID,1)
			set_event_force_page(tmpNb3ID,1)
			set_event_force_page(tmpNbSgtID,1)
			get_character(tmpNb1ID).force_update = true
			get_character(tmpNb2ID).force_update = true
			get_character(tmpNb3ID).force_update = true
			get_character(tmpNbSgtID).force_update = true
			get_character(tmpNb1ID).moveto(tmpTpX-1,tmpTpY+3)
			get_character(tmpNb2ID).moveto(tmpTpX,tmpTpY+3)
			get_character(tmpNb3ID).moveto(tmpTpX+1,tmpTpY+3)
			get_character(tmpNbSgtID).moveto(tmpTpX+1,tmpTpY+1)
			get_character(tmpNb1ID).direction = 8
			get_character(tmpNb2ID).direction = 8
			get_character(tmpNb3ID).direction = 8
			get_character(tmpNbSgtID).direction = 2
			$game_player.moveto(tmpWakeX,tmpWakeY)
			$game_player.direction = 6
			cam_follow(tmpTpID,0)
		chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapDoomFortress:DormGuard/SlaveBegin_Torture0")
		get_character(tmpNbSgtID).direction = 4
		get_character(tmpNbSgtID).move_forward
		wait(60)
		
		get_character(tmpNbSgtID).direction = 8
		call_msg("TagMapDoomFortress:DormGuard/SlaveBegin_Torture1")
		get_character(tmpNbSgtID).animation = get_character(tmpNbSgtID).animation_atk_mh
		$game_player.actor.stat["EventVagRace"] = "Human"
		load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
		call_msg("commonH:Lona/beaten#{rand(10)}")
		
		get_character(tmpNbSgtID).direction = 6
		get_character(tmpNbSgtID).move_forward
		wait(60)
		
		get_character(tmpNbSgtID).direction = 2
		call_msg("TagMapDoomFortress:DormGuard/SlaveBegin_Torture2")
		
		get_character(tmpNb3ID).move_forward
		wait(30)
		get_character(tmpNb3ID).direction = 4
		get_character(tmpNb3ID).move_forward
		wait(30)
		get_character(tmpNb3ID).direction = 8
		get_character(tmpNb3ID).move_forward
		wait(30)
		get_character(tmpNb3ID).direction = 8
		get_character(tmpNb3ID).animation = get_character(tmpNb3ID).animation_atk_mh
		$game_player.actor.stat["EventVagRace"] = "Human"
		load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
		call_msg("commonH:Lona/beaten#{rand(10)}")
		call_msg("TagMapDoomFortress:DormGuard/SlaveBegin_Torture3")
		
		get_character(tmpNb3ID).direction = 4
		get_character(tmpNb3ID).move_forward
		get_character(tmpNb2ID).direction = 8
		get_character(tmpNb2ID).move_forward
		wait(30)
		get_character(tmpNb3ID).direction = 4
		get_character(tmpNb3ID).move_forward
		get_character(tmpNb2ID).direction = 8
		get_character(tmpNb2ID).move_forward
		wait(30)
		get_character(tmpNb3ID).direction = 8
		get_character(tmpNb3ID).move_forward
		wait(30)
		get_character(tmpNb3ID).direction = 6
		get_character(tmpNb2ID).animation = get_character(tmpNb2ID).animation_atk_mh
		$game_player.actor.stat["EventVagRace"] = "Human"
		load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
		call_msg("commonH:Lona/beaten#{rand(10)}")
		call_msg("TagMapDoomFortress:DormGuard/SlaveBegin_Torture4")
		
		get_character(tmpNb2ID).direction = 4
		get_character(tmpNb2ID).move_forward
		get_character(tmpNb1ID).direction = 8
		get_character(tmpNb1ID).move_forward
		wait(30)
		get_character(tmpNb2ID).direction = 4
		get_character(tmpNb2ID).move_forward
		get_character(tmpNb1ID).direction = 6
		get_character(tmpNb1ID).move_forward
		wait(30)
		get_character(tmpNb2ID).direction = 6
		get_character(tmpNb1ID).direction = 8
		get_character(tmpNb1ID).move_forward
		wait(30)
		get_character(tmpNb1ID).direction = 8
		call_msg("TagMapDoomFortress:DormGuard/SlaveBegin_Torture5")
		get_character(tmpNb1ID).animation = get_character(tmpNb1ID).animation_atk_mh
		$game_player.actor.stat["EventVagRace"] = "Human"
		load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
		call_msg("commonH:Lona/beaten#{rand(10)}")
		call_msg("TagMapDoomFortress:DormGuard/SlaveBegin_Torture6")
		get_character(tmpNbSgtID).direction = 4
		call_msg("TagMapDoomFortress:DormGuard/SlaveBegin_Torture7")
		get_character(tmpNb1ID).animation = get_character(tmpNb1ID).animation_atk_sh
		$game_player.actor.stat["EventVagRace"] = "Human"
		load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
		#call_msg("TagMapDoomFortress:DormGuard/SlaveBegin_Torture8") # deleted msg
		#get_character(tmpNb1ID).animation = get_character(tmpNb1ID).animation_atk_mh
		#$game_player.actor.stat["EventVagRace"] = "Human"
		#load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
		call_msg("TagMapDoomFortress:DormGuard/SlaveBegin_Torture9")
		get_character(tmpNb1ID).animation = get_character(tmpNb1ID).animation_atk_sh
		$game_player.actor.stat["EventVagRace"] = "Human"
		load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
		get_character(tmpNb1ID).animation = get_character(tmpNb1ID).animation_stun
		call_msg("TagMapDoomFortress:DormGuard/SlaveBegin_Torture10")
		call_msg("TagMapDoomFortress:DormGuard/SlaveBegin_Torture11")
		
		chcg_background_color(0,0,0,0,7)
			get_character(tmpNb1ID).moveto(tmpNb1X,tmpNb1Y)
			get_character(tmpNb2ID).moveto(tmpNb2X,tmpNb2Y)
			get_character(tmpNb3ID).moveto(tmpNb3X,tmpNb3Y)
			get_character(tmpNbSgtID).moveto(tmpNbSgtX,tmpNbSgtY)
			get_character(tmpNb1ID).force_update = false
			get_character(tmpNb2ID).force_update = false
			get_character(tmpNb3ID).force_update = false
			get_character(tmpNbSgtID).force_update = false
			portrait_hide
			cam_center(0)
			set_event_force_page(tmpTpID,2)
		chcg_background_color(0,0,0,255,-7)
		
		whole_event_end
end

do_ret = false
no_more_until = nil
until do_ret
#######################################################  Normal Rape  #######################################################
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
	if tmp_fucker_id != nil && !$game_map.threat #&& $story_stats["RapeLoopTorture"] !=1
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
			call_msg("common:Lona/NapRape_withSta") #\optD[我是便器<t=3>,反抗]
			case $game_temp.choice
				when 0
					call_msg("common:Lona/NapRape_withSta_NoFight1#{talk_persona}")
					get_character(tmp_fucker_id).call_balloon(20)
					call_msg("common:Noer/NapRape_withSta_NoFight2#{tmpRACE}#{rand(3)}")
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
		get_character(tmp_fucker_id).actor.process_target_lost
		get_character(tmp_fucker_id).turn_toward_character($game_player)
		$game_player.animation = $game_player.animation_stun
	end
end #until
	

if $story_stats["Captured"] == 1
	$game_player.actor.record_lona_title = "Rapeloop/DoomFort"
	$story_stats["Ending_MainCharacter"] = "Ending_MC_HumanSlave"
	rape_loop_drop_item(false,false)
	handleNap if tmp_fucker_id == nil
else
	#if check_enemy_survival?("HumanGuard",false)
	#	$story_stats["RapeLoop"] = 1
	#	$story_stats["RapeLoopTorture"] = 1
	#end
	region_map_wildness_nap if tmp_fucker_id == nil
end
