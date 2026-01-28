tmpInRapeLoop =  $story_stats["RapeLoop"] == 1 || $story_stats["RapeLoopTorture"] == 1 || $story_stats["Captured"] ==1
tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
tmpStoryFucker1 = $game_map.get_storypoint("StoryFucker1")[2]
tmpStoryFucker2 = $game_map.get_storypoint("StoryFucker2")[2]
tmpStoryFucker3 = $game_map.get_storypoint("StoryFucker3")[2]
tmpStoryFucker4 = $game_map.get_storypoint("StoryFucker4")[2]
tmpStoryFucker5 = $game_map.get_storypoint("StoryFucker5")[2]
tmpStoryFucker6 = $game_map.get_storypoint("StoryFucker6")[2]
tmpStoryFucker7 = $game_map.get_storypoint("StoryFucker7")[2]
tmpStoryFucker8 = $game_map.get_storypoint("StoryFucker8")[2]
tmpStoryFucker9 = $game_map.get_storypoint("StoryFucker9")[2]
tmpWardenMasterID = $game_map.get_storypoint("WardenMaster")[2]
tmpTorturePtX,tmpTorturePtY,tmpTorturePtID = $game_map.get_storypoint("TorturePt")

if !tmpInRapeLoop
	chcg_background_color(0,0,0,0,7)
	if  $story_stats["RecQuDirtyJohnson"] != -1 && get_character(tmpDualBiosID).summon_data[:DirtyJohnsonFirstTimeAggro] == true || get_character(tmpDualBiosID).summon_data[:DirtyJohnsonSecondTimeAggro] == true
		portrait_off
		call_msg("TagMapHumanPrisonCave:DirtyJohnson/Captured0")
		rape_loop_drop_item(true,false)
		#load_script("Data/Batch/Put_HeavyestBondage.rb") #上銬批次檔
		call_msg("TagMapHumanPrisonCave:Narr/Captured2")
		$story_stats["RapeLoop"] = 1
		$story_stats["RapeLoopTorture"] = 0
		$story_stats["Captured"] =1
	else
		call_msg("TagMapHumanPrisonCave:Narr/Captured0")
		call_msg("TagMapHumanPrisonCave:Narr/Captured1")
		rape_loop_drop_item(false,false)
		call_msg("TagMapHumanPrisonCave:Narr/Captured2")
		$story_stats["RapeLoop"] = 1
		$story_stats["RapeLoopTorture"] = 1
		$story_stats["Captured"] =1
	end
	eventPlayEnd
	return handleNap
end

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
		$story_stats["DreamPTSD"] = "Slave" if $game_player.actor.mood <= -50
		get_character(tmp_fucker_id).setup_audience
		get_character(tmp_fucker_id).move_type =0
		get_character(tmp_fucker_id).opacity = 255
		get_character(tmp_fucker_id).animation = nil
		get_character(tmp_fucker_id).call_balloon(2)
		get_character(tmp_fucker_id).turn_toward_character($game_player)
		call_msg("TagMapNoerTavern:CommonPPL/NapRape")
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
		call_msg("TagMapNoerTavern:CommonPPL/NapRape1")
		call_msg("TagMapNoerTavern:CommonPPL/NapRape2")
		goto_sex_point_with_character(get_character(tmp_fucker_id),nil,tmpMoveToCharAtEnd=false)
		do_ret = false
		$game_player.turn_toward_character(get_character(tmp_fucker_id))
		$game_player.call_balloon(0)
		$game_player.animation = nil
		call_msg("common:Lona/NapRape3")
		get_character(tmp_fucker_id).call_balloon(20)
		call_msg("TagMapNoerTavern:CommonPPL/NapRape3")
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
					call_msg("TagMapNoerTavern:CommonPPL/NapRape_withSta_Fight2")
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

 # public gangrape by miner,
if tmpInRapeLoop &&  tmp_fucker_id == nil
	$story_stats["DreamPTSD"] = "Slave" if $game_player.actor.mood <= -50
	tmp_on_sight = false
	$game_map.npcs.each do |event| 
		next if event.npc.fraction !=7
		next if event.npc.sex !=1
		next if event.actor.action_state != nil && event.actor.action_state !=:none
		next if !event.near_the_target?($game_player,3)
		next if event.actor.sensors[0].get_signal(event,$game_player)[2] <=15 #[target,distance,signal_strength,sensortype]
		tmp_on_sight = true
	end

	if $story_stats["Captured"] == 1
	$story_stats["Ending_MainCharacter"] = "Ending_MC_HumanSlave"
	end
	
	if tmp_on_sight == true && $story_stats["Captured_PrisonMiningNeed"]/2 > $story_stats["Captured_PrisonMiningPoint"]
		$story_stats["RapeLoop"] =1
	else
		$story_stats["RapeLoop"] =0
	end
	
	if $story_stats["Captured_PrisonMiningNeed"] > $story_stats["Captured_PrisonMiningPoint"]
		$story_stats["RapeLoopTorture"] = 1
	else
		$story_stats["RapeLoopTorture"] = 0
	end
	
	#setup and reset mine req
	if $game_date.day?
		whole_event_end
		able_to_nap =1
		$game_player.balloon_id = 0
		#$story_stats["RapeLoopTorture"] = 1 if $story_stats["Captured_PrisonMiningNeed"] > $story_stats["Captured_PrisonMiningPoint"]
		$story_stats["Captured_PrisonMiningNeed"] =9+rand(3)
		$story_stats["Captured_PrisonMiningPoint"] =0
		
		if $story_stats["RapeLoopTorture"] == 1
		$story_stats["DreamPTSD"] = "Slave" if $game_player.actor.mood <= -50
			$game_player.manual_sex = true
			if (rand(100) >50 && $game_player.actor.weak >= 60) || $game_player.player_cuffed?
			###################################################################### 排隊肉便器 #####################################################################
				 #清空雜人
				$game_map.npcs.each do |event|
					next if !event.summon_data
					next if !event.summon_data[:NormalNPC]
					event.delete
				end
				$game_player.moveto(tmpTorturePtX,tmpTorturePtY)
				$game_player.transparent = true
				$story_stats["RapeLoopTorture"] = 0
				rape_loop_drop_item(false,false)
				chcg_background_color(0,0,0,255,255)
				set_event_force_page(tmpTorturePtID,5,0)
				get_character(tmpTorturePtID).manual_cw = 3 #canvas witdh(how many item in this PNG's witdh)
				get_character(tmpTorturePtID).manual_ch = 1 #canvas height(how many item in this PNG's height)
				get_character(tmpTorturePtID).pattern = 0 #force 0 because only 1x1
				get_character(tmpTorturePtID).direction = 2 #force to 2 because only 1x1
				get_character(tmpTorturePtID).character_index =0 #force 0 because only 1x1
				if ["Deepone","Moot"].include?($game_player.actor.stat["Race"])
					get_character(tmpTorturePtID).character_name = "LonaEXT/WoodenBondageMoot.png"
				else
					get_character(tmpTorturePtID).character_name = "LonaEXT/WoodenBondage.png"
				end
				get_character(tmpTorturePtID).chs_need_update=true
				
				
				
				get_character(tmpWardenMasterID).set_npc("NeutralHumanPrisonTorturer")
				get_character(tmpWardenMasterID).moveto(55,46)
				get_character(tmpWardenMasterID).direction = 2
				get_character(tmpWardenMasterID).move_type = 0
				cam_follow(72,0)
				

				get_character(tmpStoryFucker1).force_update = true
				get_character(tmpStoryFucker2).force_update = true
				get_character(tmpStoryFucker3).force_update = true
				get_character(tmpStoryFucker4).force_update = true
				get_character(tmpStoryFucker5).force_update = true
				get_character(tmpStoryFucker6).force_update = true
				get_character(tmpStoryFucker7).force_update = true
				get_character(tmpStoryFucker8).force_update = true
				get_character(tmpStoryFucker9).force_update = true
				get_character(tmpWardenMasterID).npc_story_mode(true)
				get_character(tmpTorturePtID).npc_story_mode(true)
				
				
				get_character(tmpStoryFucker1).moveto(55,48)
				get_character(tmpStoryFucker2).moveto(56,48)
				get_character(tmpStoryFucker3).moveto(57,48)
				get_character(tmpStoryFucker4).moveto(55,49)
				get_character(tmpStoryFucker5).moveto(56,49)
				get_character(tmpStoryFucker6).moveto(57,49)
				get_character(tmpStoryFucker7).moveto(55,50)
				get_character(tmpStoryFucker8).moveto(56,50)
				get_character(tmpStoryFucker9).moveto(57,50)
				
				get_character(tmpStoryFucker1).set_npc("MobHumanCommoner")
				get_character(tmpStoryFucker2).set_npc("MobHumanCommoner")
				get_character(tmpStoryFucker3).set_npc("MobHumanCommoner")
				get_character(tmpStoryFucker4).set_npc("MobHumanCommoner")
				get_character(tmpStoryFucker5).set_npc("MobHumanCommoner")
				get_character(tmpStoryFucker6).set_npc("MobHumanCommoner")
				get_character(tmpStoryFucker7).set_npc("MobHumanCommoner")
				get_character(tmpStoryFucker8).set_npc("MobHumanCommoner")
				get_character(tmpStoryFucker9).set_npc("MobHumanCommoner")
				
				get_character(tmpStoryFucker1).direction = 8
				get_character(tmpStoryFucker2).direction = 8
				get_character(tmpStoryFucker3).direction = 8
				get_character(tmpStoryFucker4).direction = 8
				get_character(tmpStoryFucker5).direction = 8
				get_character(tmpStoryFucker6).direction = 8
				get_character(tmpStoryFucker7).direction = 8
				get_character(tmpStoryFucker8).direction = 8
				get_character(tmpStoryFucker9).direction = 8
				
				combat_remove_random_equip(0)
				combat_remove_random_equip(1)
				combat_remove_random_equip(2)
				combat_remove_random_equip(3)
				combat_remove_random_equip(4)
				combat_remove_random_equip(5)
				combat_remove_random_equip(6)
				combat_remove_random_equip(7)
				combat_remove_random_equip(8)
				combat_remove_random_equip(9)
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_begin1")
				chcg_background_color(0,0,0,255,-5)
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopMeattoilet_begin1")
				get_character(tmpTorturePtID).jump_to_low(get_character(tmpTorturePtID).x,get_character(tmpTorturePtID).y)
				get_character(tmpWardenMasterID).direction = 6 ; get_character(tmpWardenMasterID).animation = get_character(tmpWardenMasterID).animation_atk_whip
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopMeattoilet_begin1_1")
				get_character(tmpTorturePtID).jump_to_low(get_character(tmpTorturePtID).x,get_character(tmpTorturePtID).y)
				get_character(tmpWardenMasterID).direction = 6 ; get_character(tmpWardenMasterID).animation = get_character(tmpWardenMasterID).animation_atk_whip
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopMeattoilet_begin1_2")
				cam_follow(tmpTorturePtID,0)
				get_character(tmpStoryFucker1).direction = 8 ; get_character(tmpStoryFucker1).move_forward
				get_character(tmpWardenMasterID).direction = 8 ; get_character(tmpWardenMasterID).move_forward
				wait(68)
				get_character(tmpStoryFucker1).direction = 6 ; get_character(tmpStoryFucker1).move_forward
				get_character(tmpWardenMasterID).direction = 4 ; get_character(tmpWardenMasterID).move_forward
				wait(68)
				get_character(tmpWardenMasterID).direction = 6
				get_character(tmpStoryFucker1).direction = 8 ; get_character(tmpStoryFucker1).move_forward
				get_character(tmpStoryFucker2).move_forward
				get_character(tmpStoryFucker3).direction = 4 ; get_character(tmpStoryFucker3).move_forward
				wait(68)
				get_character(tmpStoryFucker3).direction = 8
				get_character(tmpStoryFucker4).move_toward_xy(56,45)
				get_character(tmpStoryFucker5).move_toward_xy(56,45)
				get_character(tmpStoryFucker6).move_toward_xy(56,45)
				get_character(tmpStoryFucker7).move_toward_xy(56,45)
				get_character(tmpStoryFucker8).move_toward_xy(56,45)
				get_character(tmpStoryFucker9).move_toward_xy(56,45)
				wait(68)
				get_character(tmpStoryFucker4).move_toward_xy(56,45)
				get_character(tmpStoryFucker5).move_toward_xy(56,45)
				get_character(tmpStoryFucker6).move_toward_xy(56,45)
				get_character(tmpStoryFucker7).move_toward_xy(56,45)
				get_character(tmpStoryFucker8).move_toward_xy(56,45)
				get_character(tmpStoryFucker9).move_toward_xy(56,45)
				wait(68)
				get_character(tmpStoryFucker4).move_toward_xy(56,45)
				get_character(tmpStoryFucker5).move_toward_xy(56,45)
				get_character(tmpStoryFucker6).move_toward_xy(56,45)
				get_character(tmpStoryFucker7).move_toward_xy(56,45)
				get_character(tmpStoryFucker8).move_toward_xy(56,45)
				get_character(tmpStoryFucker9).move_toward_xy(56,45)
				wait(68)
				get_character(tmpStoryFucker4).move_toward_xy(56,45)
				get_character(tmpStoryFucker5).move_toward_xy(56,45)
				get_character(tmpStoryFucker6).move_toward_xy(56,45)
				get_character(tmpStoryFucker7).move_toward_xy(56,45)
				get_character(tmpStoryFucker8).move_toward_xy(56,45)
				get_character(tmpStoryFucker9).move_toward_xy(56,45)
				wait(68)
				get_character(tmpStoryFucker1).turn_toward_character(get_character(tmpTorturePtID))
				get_character(tmpStoryFucker2).turn_toward_character(get_character(tmpTorturePtID))
				get_character(tmpStoryFucker3).turn_toward_character(get_character(tmpTorturePtID))
				get_character(tmpStoryFucker4).turn_toward_character(get_character(tmpTorturePtID))
				get_character(tmpStoryFucker5).turn_toward_character(get_character(tmpTorturePtID))
				get_character(tmpStoryFucker6).turn_toward_character(get_character(tmpTorturePtID))
				get_character(tmpStoryFucker7).turn_toward_character(get_character(tmpTorturePtID))
				get_character(tmpStoryFucker8).turn_toward_character(get_character(tmpTorturePtID))
				get_character(tmpStoryFucker9).turn_toward_character(get_character(tmpTorturePtID))
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopMeattoilet_begin1_3")
				
				get_character(tmpStoryFucker2).animation = get_character(tmpStoryFucker2).animation_masturbation
				get_character(tmpStoryFucker3).animation = get_character(tmpStoryFucker3).animation_masturbation
				get_character(tmpStoryFucker4).animation = get_character(tmpStoryFucker4).animation_masturbation
				get_character(tmpStoryFucker5).animation = get_character(tmpStoryFucker5).animation_masturbation
				get_character(tmpStoryFucker6).animation = get_character(tmpStoryFucker6).animation_masturbation
				get_character(tmpStoryFucker7).animation = get_character(tmpStoryFucker7).animation_masturbation
				get_character(tmpStoryFucker8).animation = get_character(tmpStoryFucker8).animation_masturbation
				get_character(tmpStoryFucker9).animation = get_character(tmpStoryFucker9).animation_masturbation
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopMeattoilet_begin2#{talk_persona}")
		
				##########################################################################################
				cam_follow(tmpTorturePtID,0)
				aniArr = [
					[0  , 0, 10],
					[0+1, 0, 10],
					[0+2, 0, 10]
				]
				get_character(tmpTorturePtID).animation = get_character(tmpTorturePtID).aniCustom(aniArr,-1)
				npc_sex_service_main(get_character(tmpStoryFucker1),$game_player,"vag",2,1)
				whole_event_end
				temp_loop_count = 0
				temp_tar = rand(100)
				case
					when 0..70
								$game_player.actor.stat["EventVag"]		="CumInside1"
								$game_player.actor.stat["EventVagRace"]	="Human"
								temp_batch =	"Data/Batch/chcg_basic_frame_vag.rb"
								temp_script =	"Data/HCGframes/EventVag_CumInside_Overcum.rb"
								$story_stats["sex_record_vaginal_count"] +=1
								$story_stats.sex_record_vag(["DataNpcName:name/NeutralHumanPrisonMinerM"])
					else
								$game_player.actor.stat["EventAnal"]	="CumInside1"
								$game_player.actor.stat["EventAnalRace"]="Human"
								temp_batch =	"Data/Batch/chcg_basic_frame_anal.rb"
								temp_script =	"Data/HCGframes/EventAnal_CumInside_Overcum.rb"
								$story_stats["sex_record_anal_count"] +=1
								$story_stats.sex_record_anal(["DataNpcName:name/NeutralHumanPrisonMinerM"])
				end
				until temp_loop_count == 6
					temp_loop_count +=1
					lona_mood "p5_#{chcg_cumming_mood_decider}"
					wait(30)
					load_script("#{temp_batch}")
					check_over_event
				end
				temp_loop_count = 0
				npc_sex_service_main(get_character(tmpStoryFucker1),$game_player,"vag",2,2)
				aniArr = [
					[0  , 0, 5],
					[0+1, 0, 5],
					[0+2, 0, 5]
				]
				get_character(tmpTorturePtID).animation = get_character(tmpTorturePtID).aniCustom(aniArr,-1)
				until temp_loop_count == 6
					temp_loop_count +=1
					wait(15)
					load_script("#{temp_batch}")
					check_over_event
				end
				load_script("#{temp_script}") ; portrait_off
				get_character(tmpTorturePtID).animation = nil
				get_character(tmpStoryFucker1).unset_event_chs_sex
				$game_player.unset_event_chs_sex
				wait(28)
				get_character(tmpStoryFucker1).jump_to(58,47) ; get_character(tmpStoryFucker1).direction = 4
				get_character(tmpStoryFucker2).move_forward
				wait(68)
				#######################################################################################
				cam_follow(tmpTorturePtID,0)
				npc_sex_service_main(get_character(tmpStoryFucker2),$game_player,"vag",2,1)
				aniArr = [
					[0  , 0, 10],
					[0+1, 0, 10],
					[0+2, 0, 10]
				]
				get_character(tmpTorturePtID).animation = get_character(tmpTorturePtID).aniCustom(aniArr,-1)
				whole_event_end
				temp_loop_count = 0
				temp_tar = rand(100)
				case
					when 0..70
								$game_player.actor.stat["EventVag"]		="CumInside1"
								$game_player.actor.stat["EventVagRace"]	="Human"
								temp_batch =	"Data/Batch/chcg_basic_frame_vag.rb"
								temp_script =	"Data/HCGframes/EventVag_CumInside_Overcum.rb"
								$story_stats["sex_record_vaginal_count"] +=1
								$story_stats.sex_record_vag(["DataNpcName:name/NeutralHumanPrisonMinerM"])
					else
								$game_player.actor.stat["EventAnal"]	="CumInside1"
								$game_player.actor.stat["EventAnalRace"]="Human"
								temp_batch =	"Data/Batch/chcg_basic_frame_anal.rb"
								temp_script =	"Data/HCGframes/EventAnal_CumInside_Overcum.rb"
								$story_stats["sex_record_anal_count"] +=1
								$story_stats.sex_record_anal(["DataNpcName:name/NeutralHumanPrisonMinerM"])
				end
				until temp_loop_count == 6
					temp_loop_count +=1
					lona_mood "p5_#{chcg_cumming_mood_decider}"
					wait(30)
					load_script("#{temp_batch}")
					check_over_event
				end
				temp_loop_count = 0
				npc_sex_service_main(get_character(tmpStoryFucker2),$game_player,"vag",2,2)
				aniArr = [
					[0  , 0, 5],
					[0+1, 0, 5],
					[0+2, 0, 5]
				]
				get_character(tmpTorturePtID).animation = get_character(tmpTorturePtID).aniCustom(aniArr,-1)
				until temp_loop_count == 6
					temp_loop_count +=1
					wait(15)
					load_script("#{temp_batch}")
					check_over_event
				end
				load_script("#{temp_script}") ; portrait_off
				get_character(tmpTorturePtID).animation = nil
				get_character(tmpStoryFucker2).unset_event_chs_sex
				$game_player.unset_event_chs_sex
				wait(28)
				get_character(tmpStoryFucker2).jump_to(57,44) ; get_character(tmpStoryFucker2).direction = 2
				get_character(tmpStoryFucker3).move_forward
				wait(68)
				###################################################################################
				cam_follow(tmpTorturePtID,0)
				npc_sex_service_main(get_character(tmpStoryFucker3),$game_player,"vag",2,1)
				get_character(tmpStoryFucker3).animation = get_character(tmpStoryFucker3).animation_event_sex(get_character(tmpTorturePtID),2)
				whole_event_end
				temp_loop_count = 0
				temp_tar = rand(100)
				case
					when 0..70
								$game_player.actor.stat["EventVag"]		="CumInside1"
								$game_player.actor.stat["EventVagRace"]	="Human"
								temp_batch =	"Data/Batch/chcg_basic_frame_vag.rb"
								temp_script =	"Data/HCGframes/EventVag_CumInside_Overcum.rb"
								$story_stats["sex_record_vaginal_count"] +=1
								$story_stats.sex_record_vag(["DataNpcName:name/NeutralHumanPrisonMinerM"])
					else
								$game_player.actor.stat["EventAnal"]	="CumInside1"
								$game_player.actor.stat["EventAnalRace"]="Human"
								temp_batch =	"Data/Batch/chcg_basic_frame_anal.rb"
								temp_script =	"Data/HCGframes/EventAnal_CumInside_Overcum.rb"
								$story_stats["sex_record_anal_count"] +=1
								$story_stats.sex_record_anal(["DataNpcName:name/NeutralHumanPrisonMinerM"])
				end
				until temp_loop_count == 6
					temp_loop_count +=1
					lona_mood "p5_#{chcg_cumming_mood_decider}"
					wait(30)
					load_script("#{temp_batch}")
					check_over_event
				end
				temp_loop_count = 0
				npc_sex_service_main(get_character(tmpStoryFucker3),$game_player,"vag",2,2)
				aniArr = [
					[0  , 0, 5],
					[0+1, 0, 5],
					[0+2, 0, 5]
				]
				get_character(tmpTorturePtID).animation = get_character(tmpTorturePtID).aniCustom(aniArr,-1)
				until temp_loop_count == 6
					temp_loop_count +=1
					wait(15)
					load_script("#{temp_batch}")
					check_over_event
				end
				load_script("#{temp_script}") ; portrait_off
				get_character(tmpTorturePtID).animation = nil
				get_character(tmpStoryFucker3).unset_event_chs_sex
				$game_player.unset_event_chs_sex
				wait(28)
				get_character(tmpStoryFucker3).jump_to(54,47) ; get_character(tmpStoryFucker3).direction = 6
				#############################################################################################################################################################
				
				$game_message.add("#{$game_text["TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture2_begin3"]} #{$story_stats["Captured_PrisonMiningNeed"]} #{$game_text["TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture2_begin3_reflag"]}")
				$game_map.interpreter.wait_for_message
				chcg_background_color(0,0,0,0,15)
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopMeattoilet_end")
				$story_stats.sex_record_vag(["DataNpcName:name/NeutralHumanPrisonMinerM"])
				$story_stats.sex_record_anal(["DataNpcName:name/NeutralHumanPrisonMinerM"])
				$story_stats.sex_record_mouth(["DataNpcName:name/NeutralHumanPrisonMinerM"])
				$story_stats["sex_record_vaginal_count"] += rand(10)+1
				$story_stats["sex_record_anal_count"] += rand(10)+1
				$story_stats["sex_record_kissed"] += rand(10)+1
				whole_event_end
				load_script("Data/HCGframes/event/HumanCave_NapGangRape.rb")
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_begin4")
				whole_event_end
				cam_center(0)
				able_to_nap = 1
			else
				###################################################################### 基本鞭打 #####################################################################
				 #清空雜人
				$game_map.npcs.each do |event|
					next if !event.summon_data
					next if !event.summon_data[:NormalNPC]
					event.delete
				end
				$story_stats["RapeLoopTorture"] = 0
				rape_loop_drop_item(false,false)
				chcg_background_color(0,0,0,255,255)
				set_event_force_page(tmpTorturePtID,1,0)

				
				get_character(tmpWardenMasterID).set_npc("NeutralHumanPrisonTorturer")
				get_character(tmpWardenMasterID).moveto(55,46)
				get_character(tmpWardenMasterID).direction = 2
				get_character(tmpWardenMasterID).move_type = 0
				cam_follow(72,0)
								
				get_character(tmpStoryFucker1).force_update = true
				get_character(tmpStoryFucker2).force_update = true
				get_character(tmpStoryFucker3).force_update = true
				get_character(tmpStoryFucker4).force_update = true
				get_character(tmpStoryFucker5).force_update = true
				get_character(tmpStoryFucker6).force_update = true
				get_character(tmpStoryFucker7).force_update = true
				get_character(tmpStoryFucker8).force_update = true
				get_character(tmpStoryFucker9).force_update = true
				get_character(tmpWardenMasterID).npc_story_mode(true)
				
				get_character(tmpStoryFucker1).moveto(55,48)
				get_character(tmpStoryFucker2).moveto(56,48)
				get_character(tmpStoryFucker3).moveto(57,48)
				get_character(tmpStoryFucker4).moveto(55,49)
				get_character(tmpStoryFucker5).moveto(56,49)
				get_character(tmpStoryFucker6).moveto(57,49)
				get_character(tmpStoryFucker7).moveto(55,50)
				get_character(tmpStoryFucker8).moveto(56,50)
				get_character(tmpStoryFucker9).moveto(57,50)
				
				get_character(tmpStoryFucker1).direction = 8
				get_character(tmpStoryFucker2).direction = 8
				get_character(tmpStoryFucker3).direction = 8
				get_character(tmpStoryFucker4).direction = 8
				get_character(tmpStoryFucker5).direction = 8
				get_character(tmpStoryFucker6).direction = 8
				get_character(tmpStoryFucker7).direction = 8
				get_character(tmpStoryFucker8).direction = 8
				get_character(tmpStoryFucker9).direction = 8

				combat_remove_random_equip(0)
				combat_remove_random_equip(1)
				combat_remove_random_equip(2)
				combat_remove_random_equip(3)
				combat_remove_random_equip(4)
				combat_remove_random_equip(5)
				combat_remove_random_equip(6)
				combat_remove_random_equip(7)
				combat_remove_random_equip(8)
				combat_remove_random_equip(9)
				rape_loop_drop_item(false,false)
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_begin1")
				get_character(tmpWardenMasterID).direction = 8
				chcg_background_color(0,0,0,255,-5)
				get_character(tmpTorturePtID).jump_to_low(get_character(tmpTorturePtID).x,get_character(tmpTorturePtID).y)
				get_character(tmpWardenMasterID).animation = get_character(tmpWardenMasterID).animation_atk_whip
				3.times{$game_damage_popups.add(rand(12)+1,get_character(tmpTorturePtID).x, get_character(tmpTorturePtID).y,2,5)}
				load_script("Data/Batch/whip_add_body_wound.rb")
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_begin2_1")
				get_character(tmpTorturePtID).jump_to_low(get_character(tmpTorturePtID).x,get_character(tmpTorturePtID).y)
				get_character(tmpWardenMasterID).animation = get_character(tmpWardenMasterID).animation_atk_whip
				3.times{$game_damage_popups.add(rand(12)+1,get_character(tmpTorturePtID).x, get_character(tmpTorturePtID).y,2,5)}
				load_script("Data/Batch/whip_add_body_wound.rb")
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_begin2_2")
				get_character(tmpTorturePtID).jump_to_low(get_character(tmpTorturePtID).x,get_character(tmpTorturePtID).y)
				get_character(tmpWardenMasterID).animation = get_character(tmpWardenMasterID).animation_atk_whip
				3.times{$game_damage_popups.add(rand(12)+1,get_character(tmpTorturePtID).x, get_character(tmpTorturePtID).y,2,5)}
				load_script("Data/Batch/whip_add_body_wound.rb")
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_begin2_3")
				get_character(tmpTorturePtID).jump_to_low(get_character(tmpTorturePtID).x,get_character(tmpTorturePtID).y)
				get_character(tmpWardenMasterID).animation = get_character(tmpWardenMasterID).animation_atk_whip
				3.times{$game_damage_popups.add(rand(12)+1,get_character(tmpTorturePtID).x, get_character(tmpTorturePtID).y,2,5)}
				load_script("Data/Batch/whip_add_body_wound.rb")
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_begin2_4")
				get_character(tmpTorturePtID).jump_to_low(get_character(tmpTorturePtID).x,get_character(tmpTorturePtID).y)
				get_character(tmpWardenMasterID).animation = get_character(tmpWardenMasterID).animation_atk_whip
				3.times{$game_damage_popups.add(rand(12)+1,get_character(tmpTorturePtID).x, get_character(tmpTorturePtID).y,2,5)}
				load_script("Data/Batch/whip_add_body_wound.rb")
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_begin2_5")
				get_character(tmpTorturePtID).jump_to_low(get_character(tmpTorturePtID).x,get_character(tmpTorturePtID).y)
				get_character(tmpWardenMasterID).animation = get_character(tmpWardenMasterID).animation_atk_whip
				3.times{$game_damage_popups.add(rand(12)+1,get_character(tmpTorturePtID).x, get_character(tmpTorturePtID).y,2,5)}
				load_script("Data/Batch/whip_add_body_wound.rb")
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_begin2_6")
				get_character(tmpWardenMasterID).direction=2
				$story_stats["sex_record_torture"] +=1
				$game_message.add("#{$game_text["TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_begin3"]} #{$story_stats["Captured_PrisonMiningNeed"]} #{$game_text["TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_begin3_reflag"]}")
				$game_map.interpreter.wait_for_message
				chcg_background_color(0,0,0,0,15)
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_begin4")
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_end")
				cam_center(0)
				able_to_nap = 1
			end
			
			

		else
			###################################################################### 警告  打路人 第一次入場 #####################################################################
				 #清空雜人
				$game_map.npcs.each do |event|
					next if !event.summon_data
					next if !event.summon_data[:NormalNPC]
					event.delete
				end
			prev_sta = $game_player.actor.sta
			chcg_background_color(0,0,0,255,255)
			set_event_force_page(tmpTorturePtID,2+rand(2),0)
			
			get_character(tmpWardenMasterID).set_npc("NeutralHumanPrisonTorturer")
			get_character(tmpWardenMasterID).moveto(55,46)
			get_character(tmpWardenMasterID).direction = 2
			get_character(tmpWardenMasterID).move_type = 0
			cam_follow(72,0)
			
				
				get_character(tmpStoryFucker1).force_update = true
				get_character(tmpStoryFucker2).force_update = true
				get_character(tmpStoryFucker3).force_update = true
				get_character(tmpStoryFucker4).force_update = true
				get_character(tmpStoryFucker5).force_update = true
				get_character(tmpStoryFucker6).force_update = true
				get_character(tmpStoryFucker7).force_update = true
				get_character(tmpStoryFucker8).force_update = true
				get_character(tmpStoryFucker9).force_update = true
				get_character(tmpWardenMasterID).npc_story_mode(true)
			
			get_character(tmpStoryFucker1).moveto(55,48)
			get_character(tmpStoryFucker2).moveto(56,48)
			get_character(tmpStoryFucker3).moveto(57,48)
			$game_player.moveto(55,49)
			get_character(tmpStoryFucker4).moveto(56,49)
			get_character(tmpStoryFucker6).moveto(57,49)
			get_character(tmpStoryFucker7).moveto(55,50)
			get_character(tmpStoryFucker8).moveto(56,50)
			get_character(tmpStoryFucker9).moveto(57,50)
			
				
			get_character(tmpStoryFucker1).direction = 8
			get_character(tmpStoryFucker2).direction = 8
			get_character(tmpStoryFucker3).direction = 8
			get_character(tmpStoryFucker4).direction = 8
			get_character(tmpStoryFucker5).direction = 8
			get_character(tmpStoryFucker6).direction = 8
			get_character(tmpStoryFucker7).direction = 8
			get_character(tmpStoryFucker8).direction = 8
			get_character(tmpStoryFucker9).direction = 8
			
			$game_player.actor.sta =100
			$game_player.animation = nil
			$game_player.direction = 8
			call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_nonplayer_begin1")
			get_character(tmpWardenMasterID).direction = 8
			chcg_background_color(0,0,0,255,-5)
			get_character(tmpWardenMasterID).animation = get_character(tmpWardenMasterID).animation_atk_whip
			get_character(tmpTorturePtID).jump_to_low(get_character(tmpTorturePtID).x,get_character(tmpTorturePtID).y)
			3.times{$game_damage_popups.add(rand(12)+1,get_character(tmpTorturePtID).x, get_character(tmpTorturePtID).y,2,5)}
			call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_nonplayer_begin2_1")
			get_character(tmpWardenMasterID).animation = get_character(tmpWardenMasterID).animation_atk_sh
			3.times{$game_damage_popups.add(rand(12)+1,get_character(tmpTorturePtID).x, get_character(tmpTorturePtID).y,2,5)}
			call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_nonplayer_begin2_2")
			get_character(tmpWardenMasterID).animation = get_character(tmpWardenMasterID).animation_atk_whip
			get_character(tmpTorturePtID).jump_to_low(get_character(tmpTorturePtID).x,get_character(tmpTorturePtID).y)
			3.times{$game_damage_popups.add(rand(12)+1,get_character(tmpTorturePtID).x, get_character(tmpTorturePtID).y,2,5)}
			call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_nonplayer_begin2_3")
			get_character(tmpWardenMasterID).animation = get_character(tmpWardenMasterID).animation_atk_sh
			3.times{$game_damage_popups.add(rand(12)+1,get_character(tmpTorturePtID).x, get_character(tmpTorturePtID).y,2,5)}
			call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_nonplayer_begin2_4")
			get_character(tmpWardenMasterID).direction=2
			call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_nonplayer_begin3_#{rand(2)}")
			$game_message.add("#{$game_text["TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_begin3"]} #{$story_stats["Captured_PrisonMiningNeed"]} #{$game_text["TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_begin3_reflag"]}")
			$game_map.interpreter.wait_for_message
			
			
			
			if $story_stats["RecordMinePrisonerTorturePlayed"] ==0
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_FristTime0")
				cam_center(8)
				get_character(tmpStoryFucker1).turn_toward_character($game_player)
				get_character(tmpStoryFucker2).turn_toward_character($game_player)
				get_character(tmpStoryFucker3).turn_toward_character($game_player)
				get_character(tmpStoryFucker4).turn_toward_character($game_player)
				get_character(tmpStoryFucker6).turn_toward_character($game_player)
				get_character(tmpStoryFucker7).turn_toward_character($game_player)
				get_character(tmpStoryFucker8).turn_toward_character($game_player)
				get_character(tmpStoryFucker9).turn_toward_character($game_player)
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_FristTime1")
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoopTorture_FristTime2")
				$story_stats["RecordMinePrisonerTorturePlayed"] =1
			end
			$game_player.manual_sex = false
			chcg_background_color(0,0,0,0,15)
			$game_player.actor.sta = prev_sta
			able_to_nap = 1
			$game_player.actor.record_lona_title = "Rapeloop/MineingCaveMeatToilet"
		end
	
	
	
	elsif $game_date.night?
		if $story_stats["RapeLoop"] ==1
			able_to_nap = 0
			if $game_actors[1].sta > -95
					$story_stats["DreamPTSD"] = "Slave" if $game_player.actor.mood <= -50
					CapturedPointX,CapturedPointY=$game_map.get_storypoint("CapturedPoint")
					$game_player.moveto(CapturedPointX,CapturedPointY)
					
					
					st_id=$game_map.get_storypoint("CapturedPoint")[2]
					temp_tar = get_character(st_id)
					get_character(tmpStoryFucker1).moveto(temp_tar.x-1,temp_tar.y+1)
					get_character(tmpStoryFucker2).moveto(temp_tar.x,temp_tar.y+1)
					get_character(tmpStoryFucker3).moveto(temp_tar.x+1,temp_tar.y+1)
					get_character(tmpStoryFucker4).moveto(temp_tar.x-1,temp_tar.y)
					get_character(tmpStoryFucker6).moveto(temp_tar.x+1,temp_tar.y)
					get_character(tmpStoryFucker7).moveto(temp_tar.x-1,temp_tar.y-1)
					get_character(tmpStoryFucker8).moveto(temp_tar.x,temp_tar.y-1)
					get_character(tmpStoryFucker9).moveto(temp_tar.x+1,temp_tar.y-1)
					
					get_character(tmpStoryFucker1).turn_toward_character($game_player)
					get_character(tmpStoryFucker2).turn_toward_character($game_player)
					get_character(tmpStoryFucker3).turn_toward_character($game_player)
					get_character(tmpStoryFucker4).turn_toward_character($game_player)
					get_character(tmpStoryFucker6).turn_toward_character($game_player)
					get_character(tmpStoryFucker7).turn_toward_character($game_player)
					get_character(tmpStoryFucker8).turn_toward_character($game_player)
					get_character(tmpStoryFucker9).turn_toward_character($game_player)
					
					get_character(tmpStoryFucker1).set_npc("MobHumanCommoner")
					get_character(tmpStoryFucker2).set_npc("MobHumanCommoner")
					get_character(tmpStoryFucker3).set_npc("MobHumanCommoner")
					get_character(tmpStoryFucker4).set_npc("MobHumanCommoner")
					get_character(tmpStoryFucker6).set_npc("MobHumanCommoner")
					get_character(tmpStoryFucker7).set_npc("MobHumanCommoner")
					get_character(tmpStoryFucker8).set_npc("MobHumanCommoner")
					get_character(tmpStoryFucker9).set_npc("MobHumanCommoner")
					chcg_background_color(0,0,0,255,-7)
					call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoop_begin1")
					player_cancel_nap
					call_msg("common:Lona/use_as_MeatToilet#{talk_style}")
					$game_player.actor.setup_state(161,10)
					return eventPlayEnd
					else
				if tmp_on_sight
					chcg_background_color(0,0,0,0,7)
					load_script("Data/HCGframes/event/HumanCave_NapGangRape.rb")
					$game_player.actor.record_lona_title = "Rapeloop/MineingCaveMeatToilet"
					check_over_event
					check_half_over_event
				end
				able_to_nap = 1
			end
			$story_stats["RapeLoop"] =0
		else
			able_to_nap = 1
		end
		
	end
	
end

if tmp_fucker_id == nil
	if able_to_nap ==1 && tmp_fucker_id == nil
		$game_player.opacity=255
		$game_player.transparent = false
		get_character(tmpTorturePtID).opacity= 255
		handleNap(:point,map_id,"WakeUp")
	else
		handleNap
	end
end
