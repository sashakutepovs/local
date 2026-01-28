if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
tmp_move_away = 0
tmp_SuckDick = 0
tmp_do_sex = false
tmpToSaltGateX,tmpToSaltGateY,tmpToSaltGateID=$game_map.get_storypoint("ToSaltGate")
####################################################### IS slave?
if $game_player.actor.stat["SlaveBrand"] == 1 || $game_player.player_slave? || $game_player.actor.morality < 1
	call_msg("TagMapNorthFL_Dock:FL_GateGuard/IsSlave")
	call_msg("OvermapNoer:GateGuard/enter_failed#{talk_persona}")
	SndLib.sound_punch_hit(100)
	lona_mood "p5crit_damage"
	$game_player.actor.portrait.shake
	$game_player.actor.force_stun("Stun1")
	$game_player.jump_to($game_player.x,$game_player.y+1)
	$story_stats["SlaveOwner"] = "NorthFL_INN"
	$story_stats["RapeLoopTorture"] = 1
	$game_map.reserve_summon_event("RandomHuman",tmpToSaltGateX,tmpToSaltGateY+1)
	$game_player.actor.add_state("MoralityDown30")
	$game_player.call_balloon(19)
	
	####################################################### IS Normal
elsif $story_stats["RecQuestNorthFL_DockPass"] == 1 || get_character(tmpToSaltGateID).summon_data[:FreePass]
	#if $game_player.actor.sexy >= 25
	#else
		call_msg("TagMapNorthFL_Dock:FL_GateGuard/already_passed")
	#end
	####################################################### IS Normal
else
	call_msg("TagMapNorthFL_Dock:FL_GateGuard/Begin0_opt") #[都不是,傭兵,妓女]
	case $game_temp.choice
		when 1 #mer
			call_msg("TagMapNorthFL_Dock:FL_GateGuard/Begin1_ans_mer_yes")
			if $game_player.actor.weak >= 50
				call_msg("TagMapNorthFL_Dock:FL_GateGuard/Begin1_ans_mer_fail")
				if $game_player.record_companion_name_back == "UniqueCecily"
					call_msg("CompCecily:Cecily/DoomFortFuckOff")
					get_character(tmpToSaltGateID).summon_data[:FreePass] = true
					get_character(tmpToSaltGateID).call_balloon(6)
					tmp_move_away = 1
				else
					tmp_do_sex = 1
				end
			else
				call_msg("TagMapNorthFL_Dock:FL_GateGuard/Begin1_ans_mer_pass1")
				get_character(tmpToSaltGateID).summon_data[:FreePass] = true
				tmp_move_away = 1
			end
		when 2 #whore
			call_msg("TagMapNorthFL_Dock:FL_GateGuard/Begin1_ans_whore_yes")
			tmp_do_sex = true
		else #cancel
			call_msg("TagMapNorthFL_Dock:FL_GateGuard/Begin1_ans_cancel")
			eventPlayEnd
			return
	end
end


if tmp_do_sex
	call_msg("TagMapNorthFL_Dock:FL_GateGuard/DickSuck0")
	whole_event_end
	tmpPenisID = "Smegma"
	$game_player.actor.stat["EventMouthRace"] = "Human"
	tmpRace = $game_player.actor.stat["EventMouthRace"]
	

	tmpFailed = false
	get_character(0).animation = nil
	get_character(0).call_balloon(0)
	prev_gold = $game_party.gold
	$game_portraits.setLprt("#{tmpRace}Penis#{tmpPenisID}")
	$game_portraits.lprt.shake
	call_msg("commonH:Lona/SuckDick#{tmpPenisID}")
	call_msg("commonH:Lona/SuckDick1#{talk_persona}")
	if $game_temp.choice != 0
		$game_portraits.setLprt("nil")
		tmpFailed = true
		call_msg("TagMapNorthFL_Dock:FL_GateGuard/Begin1_ans_cancel")
		return eventPlayEnd
	end
	
	if !tmpFailed
		portrait_hide
		chcg_background_color
		
		lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
		$game_player.actor.stat["mouth"] = 7
		$game_player.actor.portrait.update
		$game_player.actor.portrait.angle=90
		$game_portraits.rprt.set_position(-100,880)
		$game_portraits.setLprt("#{tmpRace}Penis#{tmpPenisID}_CHCG")
		$game_portraits.lprt.set_position(263+rand(4),-177+rand(4))
		SndLib.sound_chcg_full(rand(100)+50)
		call_msg("commonH:Lona/SuckDick2_#{tmpPenisID}")
		
		lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
		$game_player.actor.stat["mouth"] = [9,4].sample
		$game_player.actor.stat["HeadGround"] =0
		$game_player.actor.portrait.update
		$game_player.actor.portrait.angle=90
		$game_portraits.rprt.set_position(-110,850)
		SndLib.sound_chcg_full(rand(100)+50)
		$game_portraits.setLprt("#{tmpRace}Penis#{tmpPenisID}_CHCG")
		$game_portraits.lprt.set_position(263+rand(4),-177+rand(4))
		call_msg("commonH:Lona/SuckDick3_#{tmpPenisID}")
		
		#############################################################SUCKA PART
		tmp_loop_time= 5
		tmp_current_loop = 0
		until tmp_current_loop >= tmp_loop_time
			tmp_current_loop +=1
			
			lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
			$game_player.actor.stat["mouth"] = [3,5,6,7,8].sample
			$game_player.actor.stat["HeadGround"] =1
			$game_player.actor.portrait.update
			$game_player.actor.portrait.angle=90
			$game_portraits.rprt.set_position(-100+rand(5),880+rand(5))
			$game_portraits.setLprt("#{tmpRace}Penis#{tmpPenisID}_CHCG")
			$game_portraits.lprt.set_position(263+rand(4),-177+rand(4))
			wait(37+rand(5))
			SndLib.sound_chcg_full(rand(100)+50)
			$game_portraits.rprt.set_position(-100+rand(5),880+rand(5))
			wait(2+rand(3))
			
			lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
			$game_player.actor.stat["mouth"] = [9,4].sample
			$game_player.actor.stat["HeadGround"] =0
			$game_player.actor.portrait.update
			$game_player.actor.portrait.angle=90
			$game_portraits.rprt.set_position(-100-rand(5),850-rand(5))
			$game_portraits.setLprt("#{tmpRace}Penis#{tmpPenisID}_CHCG")
			$game_portraits.lprt.set_position(263+rand(4),-177+rand(4))
			load_script("Data/Batch/chcg_basic_frame_mouth.rb") if tmp_current_loop % 2 == 0 
			wait(17+rand(5))
			$game_portraits.rprt.set_position(-100-rand(5),850-rand(5))
			wait(2+rand(3))
		end
		tempTxtData =  ["DataNpcName:race/#{$game_player.actor.stat["EventMouthRace"]}" , "DataNpcName:part/penis"]
		$story_stats.sex_record_mouth(tempTxtData)
		call_msg("commonH:Lona/SuckDick4_#{tmpRace}#{rand(3)}")
		
		#################
		case tmpPenisID
		when "Hairly"	; 
							load_script("Data/Batch/FacePunch_control.rb")
		when "Smegma"	; 
							load_script("Data/Batch/FloorClearnScat_control.rb")
		when "Mega"		; 
							load_script("Data/Batch/DeepThroat_control.rb")
		end
		#################
		
		
		
		tmp_loop_time= 8
		tmp_current_loop = 0
		until tmp_current_loop >= tmp_loop_time
			tmp_current_loop +=1
			
			lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
			$game_player.actor.stat["mouth"] = [3,5,6,7,8].sample
			$game_player.actor.stat["HeadGround"] =1
			$game_player.actor.portrait.update
			$game_player.actor.portrait.angle=90
			$game_portraits.rprt.set_position(-100+rand(5),880+rand(5))
			$game_portraits.setLprt("#{tmpRace}Penis#{tmpPenisID}_CHCG")
			$game_portraits.lprt.set_position(263+rand(4),-177+rand(4))
			wait(27+rand(4))
			SndLib.sound_chcg_full(rand(100)+50)
			$game_portraits.rprt.set_position(-100+rand(5),880+rand(5))
			wait(2+rand(3))
			
			lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
			$game_player.actor.stat["mouth"] = [9,4].sample
			$game_player.actor.stat["HeadGround"] =0
			$game_player.actor.portrait.update
			$game_player.actor.portrait.angle=90
			$game_portraits.rprt.set_position(-100-rand(5),850-rand(5))
			$game_portraits.setLprt("#{tmpRace}Penis#{tmpPenisID}_CHCG")
			$game_portraits.lprt.set_position(263+rand(4),-177+rand(4))
			load_script("Data/Batch/chcg_basic_frame_mouth.rb") if tmp_current_loop % 2 == 0 
			wait(17+rand(4))
			$game_portraits.rprt.set_position(-100-rand(5),850-rand(5))
			wait(2+rand(3))
		end
		
		
		
		
		case rand(2)
			when 0 ;
					call_msg("commonH:Lona/SuckDick_#{tmpRace}CumOutside#{rand(3)}")
					chcg_decider_basic_mouth(5)
					$game_player.actor.stat["EventMouthRace"] = "Human"
					$game_portraits.setLprt("nil")
								$game_player.actor.stat["EventMouth"] ="CumOutside2"
								lona_mood "#{chcg_decider_basic_mouth}fuck_#{chcg_mood_decider}"
											#mouth
											if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -170 ; $game_player.actor.stat["chcg_y"] = -28 end
											if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -12 ; $game_player.actor.stat["chcg_y"] = -11 end
											if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -290 ; $game_player.actor.stat["chcg_y"] = -166 end
											if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -86 ; $game_player.actor.stat["chcg_y"] = -21 end
											if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -151 ; $game_player.actor.stat["chcg_y"] = -114 end
											$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
											$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
								load_script("Data/Batch/chcg_basic_frame_mouth.rb")
								chcg_add_cums("EventMouthRace","CumsHead")
								#stats_batch4
								#stats_batch5
								load_script("Data/Batch/take_sex_wound_head.rb")
								check_over_event
								#add head cums
								#message control
								$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
								$game_map.interpreter.wait_for_message
								$game_player.actor.stat["EventTargetPart"] = nil
								$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false
								$story_stats["sex_record_cumshotted"] +=1
					optain_gold(100)
			when 1 ;
					call_msg("commonH:Lona/SuckDick_#{tmpRace}CumInside#{rand(3)}")
					if $game_temp.choice == 0
						chcg_decider_basic_mouth(5)
						$game_player.actor.stat["EventMouthRace"] = "Human"
						$game_portraits.setLprt("nil")
						if tmpPenisID == "Mega"
							load_script("Data/HCGframes/EventMouth_CumInside_Overcum.rb")
						else
							load_script("Data/HCGframes/EventMouth_CumInside.rb")
						end
						optain_gold(100)
					else
						chcg_decider_basic_mouth(5)
						$game_player.actor.stat["EventMouthRace"] = "Human"
						$game_portraits.setLprt("nil")
								$game_player.actor.stat["EventMouth"] ="CumOutside2"
								lona_mood "#{chcg_decider_basic_mouth}fuck_#{chcg_mood_decider}"
											#mouth
											if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -170 ; $game_player.actor.stat["chcg_y"] = -28 end
											if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -12 ; $game_player.actor.stat["chcg_y"] = -11 end
											if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -290 ; $game_player.actor.stat["chcg_y"] = -166 end
											if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -86 ; $game_player.actor.stat["chcg_y"] = -21 end
											if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -151 ; $game_player.actor.stat["chcg_y"] = -114 end
											$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
											$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
								load_script("Data/Batch/chcg_basic_frame_mouth.rb")
								chcg_add_cums("EventMouthRace","CumsHead")
								#stats_batch4
								#stats_batch5
								load_script("Data/Batch/take_sex_wound_head.rb")
								check_over_event
								#add head cums
								#message control
								$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
								$game_map.interpreter.wait_for_message
								$game_player.actor.stat["EventTargetPart"] = nil
								$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false
								$story_stats["sex_record_cumshotted"] +=1
						tmpFailed = true
					end
		end
	end
	
	if !tmpFailed && $story_stats["Setup_UrineEffect"] ==1
		case rand(3)
			when 0 
					call_msg("commonH:Lona/SuckDick_#{tmpRace}PeeInside#{rand(3)}")
					if $game_temp.choice == 0
						$game_portraits.setLprt("nil")
						chcg_decider_basic_mouth(5)
						$game_player.actor.stat["EventMouthRace"] = "Human"
						load_script("Data/HCGframes/UniqueEvent_PeeonTavernHead.rb")
						optain_gold(200)
					else
						$game_portraits.setLprt("nil")
						tmpFailed = true
					end
		end
	end
	
	call_msg("TagMapNorthFL_Dock:FL_GateGuard/DickSuck1")
	tmp_move_away = 1
	whole_event_end
end
if tmp_move_away == 1
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		$story_stats["RecQuestNorthFL_DockPass"] = 1
		get_character(0).moveto(tmpToSaltGateX+1,tmpToSaltGateY+1)
		get_character(0).direction = 4
		$game_player.moveto(tmpToSaltGateX,tmpToSaltGateY+1)
		$game_player.direction = 8
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapFishEscSlave:alert/MainGuard_passByAns")
end
get_character(0).call_balloon(28,-1) if $story_stats["RecQuestNorthFL_DockPass"] == 0
eventPlayEnd
