if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

$game_temp.choice  = -1
tmpPriestX,tmpPriestY,tmpPriestID=$game_map.get_storypoint("MainPriest")
tmpBedX,tmpBedY,tmpBedID=$game_map.get_storypoint("SexPoint3")

slotList = $data_system.equip_type_name
!equip_slot_removetable?("MH")		? equips_MH_id = -1 :		equips_MH_id =		$game_player.actor.equips[slotList["MH"]].item_name		#0
!equip_slot_removetable?("SH")		? equips_SH_id = -1 :		equips_SH_id =		$game_player.actor.equips[slotList["SH"]].item_name		#1
!equip_slot_removetable?("Top")		? equips_Top_id = -1 :		equips_Top_id =		$game_player.actor.equips[slotList["Top"]].item_name	#2
!equip_slot_removetable?("Mid")		? equips_Mid_id = -1 :		equips_Mid_id =		$game_player.actor.equips[slotList["Mid"]].item_name	#3
!equip_slot_removetable?("Bot")		? equips_Bot_id = -1 :		equips_Bot_id =		$game_player.actor.equips[slotList["Bot"]].item_name	#4
!equip_slot_removetable?("TopExt")	? equips_TopExt_id = -1 :	equips_TopExt_id =	$game_player.actor.equips[slotList["TopExt"]].item_name	#5
!equip_slot_removetable?("MidExt")	? equips_MidExt_id = -1 :	equips_MidExt_id =	$game_player.actor.equips[slotList["MidExt"]].item_name	#6
!equip_slot_removetable?("Hair")	? equips_Hair_id = -1 :		equips_Hair_id =	$game_player.actor.equips[slotList["Hair"]].item_name	#7
!equip_slot_removetable?("Head")	? equips_Head_id = -1 :		equips_Head_id =	$game_player.actor.equips[slotList["Head"]].item_name	#8
!equip_slot_removetable?("Neck")	? equips_Neck_id = -1 :		equips_Neck_id =	$game_player.actor.equips[slotList["Neck"]].item_name	#14
!equip_slot_removetable?("Vag")		? equips_Vag_id = -1 :		equips_Vag_id =		$game_player.actor.equips[slotList["Vag"]].item_name	#15
!equip_slot_removetable?("Anal")	? equips_Anal_id = -1 :		equips_Anal_id =	$game_player.actor.equips[slotList["Anal"]].item_name	#16
if $story_stats["QuProgScoutCampOrkind2"] ==2
	call_msg("TagMapSaintMonastery:priest/QuProgScoutCampOrkind2_done")
	$story_stats["QuProgScoutCampOrkind2"] = 3
	get_character(0).call_balloon(0)
else
	tmpAbout = $story_stats["RecordBaptizeByPriest"] == 0
	tmpMoreGrace = $story_stats["RecordBaptizeByPriest"] >= 1
	tmp_Begging = $game_player.actor.weak >= 50 && get_character(0).summon_data[:SexTradeble]
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"]
	tmpTarList << [$game_text["TagMapSaintMonastery:opt/about"]			,"about"]		if tmpAbout
	tmpTarList << [$game_text["TagMapSaintMonastery:opt/moreGrace"]		,"moreGrace"]	if tmpMoreGrace
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("TagMapSaintMonastery:priest/common",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
	
	
	case tmpPicked
		when "Barter"
			call_msg("TagMapSaintMonastery:priest/trade")
			manual_barters("SaintMonasteryMainPriest")
			
			
		when "about" #關於聖徒會
			call_msg("TagMapSaintMonastery:priest/about") 
			
			
			if $game_temp.choice == 0
				call_msg("TagMapSaintMonastery:priest/about_optY")
				chcg_background_color(0,0,0,0,7)
					portrait_hide
					$game_player.moveto(tmpBedX,tmpBedY)
					$game_player.direction = 4
					get_character(0).npc_story_mode(true)
					get_character(0).moveto(tmpBedX-1,tmpBedY)
					get_character(0).direction = 6
				chcg_background_color(0,0,0,255,-7)
				call_msg("TagMapSaintMonastery:priest/BaptizePlayer1")
				get_character(0).jump_to(tmpBedX+1,tmpBedY)
				get_character(0).direction=4
				$game_player.direction = 6
				call_msg("TagMapSaintMonastery:priest/BaptizePlayer2")
				get_character(0).jump_to(tmpBedX,tmpBedY+1)
				get_character(0).direction=8
				$game_player.direction = 2
				
				#remove a dress
				$game_temp.choice == -1
				if equips_Mid_id == -1 && equips_Bot_id == -1 && equips_Vag_id == -1 && equips_MidExt_id == -1
					$game_temp.choice = 1
				else
				call_msg("TagMapSaintMonastery:priest/BaptizePlayer3") #\optD[不要,脫]
				end
				
				if $game_temp.choice == 0
					get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],6000)
					call_msg("TagMapSaintMonastery:priest/BaptizePlayer3_N")
				else
					get_character(0).switch1_id = 1
					$story_stats["RecordBaptizeByPriest"] =1
					call_msg("TagMapSaintMonastery:priest/BaptizePlayer3_Y")
					if equips_Head_id != -1#檢查裝備 並脫裝
						$game_player.actor.change_equip("Head", nil)
						SndLib.sound_equip_armor(125)
						player_force_update
						wait(30)
					end
					if equips_MidExt_id != -1#檢查裝備 並脫裝
						$game_player.actor.change_equip("MidExt", nil)
						SndLib.sound_equip_armor(125)
						player_force_update
						wait(30)
					end
					if equips_Top_id != -1#檢查裝備 並脫裝
						$game_player.actor.change_equip("Top", nil)
						SndLib.sound_equip_armor(125)
						player_force_update
						wait(30)
					end
					if equips_Bot_id != -1#檢查裝備 並脫裝
						$game_player.actor.change_equip("Bot", nil)
						SndLib.sound_equip_armor(125)
						player_force_update
						wait(30)
					end
					if equips_Mid_id != -1#檢查裝備 並脫裝
						$game_player.actor.change_equip("Mid", nil)
						SndLib.sound_equip_armor(125)
						player_force_update
						wait(30)
					end
					if equips_Anal_id != -1#檢查裝備 並脫裝
						$game_player.actor.change_equip("Anal", nil)
						SndLib.sound_equip_armor(125)
						player_force_update
						wait(30)
					end
					if equips_Vag_id != -1#檢查裝備 並脫裝
						$game_player.actor.change_equip("Vag", nil)
						SndLib.sound_equip_armor(125)
						player_force_update
						wait(30)
					end
					
					event_key_cleaner
					$game_player.actor.stat["EventVagRace"] = "Human"
					$game_player.actor.stat["EventAnalRace"] = "Human"
					$game_player.actor.stat["EventMouthRace"] = "Human"
					call_msg("TagMapSaintMonastery:priest/BaptizePlayer3_touch0")
					load_script("Data/HCGframes/Grab_EventAnal_AnalTouch.rb")
					call_msg("TagMapSaintMonastery:priest/BaptizePlayer3_touch1")
					load_script("Data/HCGframes/Grab_EventVag_VagTouch.rb")
					call_msg("TagMapSaintMonastery:priest/BaptizePlayer3_touch2")
					load_script("Data/HCGframes/Grab_EventMouth_kissed.rb")
					call_msg("TagMapSaintMonastery:priest/BaptizePlayer3_touch3")
					event_key_cleaner
					
					
					############################################################## Deep t
					
					call_msg("TagMapSaintMonastery:priest/BaptizePlayer4")
					$game_portraits.setLprt("nil")
					$game_player.actor.stat["EventMouthRace"] = "Human"
					load_script("Data/HCGframes/UniqueEvent_DeepThroat.rb")
					event_key_cleaner
					call_msg("TagMapSaintMonastery:priest/BaptizePlayer5")
					check_half_over_event
					
					##############################################################本番
					get_character(0).moveto($game_player.x,$game_player.y)
					ev_target = get_character(0)
					temp_race=ev_target.actor.race
					plus = 1
					$game_player.manual_sex = true
					$game_player.actor.stat["SexEventScore"] = 0
					$game_player.actor.stat["SexEventLast"] =0
					$game_player.actor.stat["SexEventTotalScore"] = 0
					play_sex_service_main(ev_target,"vag",true)
					play_sex_service_get_reward(plus)
					play_sex_service_main(ev_target,"vag",true)
					play_sex_service_get_reward(plus)
					play_sex_service_main(ev_target,"vag",true)
					play_sex_service_get_reward(plus)
					play_sex_service_main(ev_target,"vag",true)
					play_sex_service_chcg(ev_target)
					play_sex_service_get_reward(plus)
					
					$game_player.actor.stat["SexEventScore"] = 0
					$game_player.actor.stat["SexEventTotalScore"] = 0
					$game_player.actor.stat["SexEventInput"] = 0
					$game_player.actor.stat["SexEventLast"] = 0
					$game_player.actor.set_action_state(:none)
					$game_player.unset_event_chs_sex
					$game_player.manual_sex = false
					ev_target.unset_event_chs_sex
					event_key_cleaner_whore_work
					$game_player.actor.prtmood("normal")
					$game_portraits.lprt.hide
					$game_portraits.rprt.hide
					##############################################################本番 end
					get_character(0).npc_story_mode(true)
					1.times{
						get_character(0).direction = 2 ; get_character(0).move_forward_force
						get_character(0).move_speed = 3
						until !get_character(0).moving? ; wait(1) end
					}
					get_character(0).direction = 8
					get_character(0).npc_story_mode(false)
					$game_player.direction = 2
					call_msg("TagMapSaintMonastery:priest/BaptizePlayer6")
					
					#if !Input.press?(:SHIFT)
						if equips_Anal_id != -1#檢查裝備 並穿裝
							$game_player.actor.change_equip("Anal", $data_ItemName[equips_Anal_id])
							SndLib.sound_equip_armor(100)
							player_force_update
							wait(30)
						end
						if equips_Vag_id != -1#檢查裝備 並穿裝
							$game_player.actor.change_equip("Vag", $data_ItemName[equips_Vag_id])
							SndLib.sound_equip_armor(100)
							player_force_update
							wait(30)
						end
						if equips_Mid_id != -1#檢查裝備 並穿裝
							$game_player.actor.change_equip("Mid", $data_ItemName[equips_Mid_id])
							SndLib.sound_equip_armor(100)
							player_force_update
							wait(30)
						end
						if equips_Bot_id != -1#檢查裝備 並穿裝
							$game_player.actor.change_equip("Bot", $data_ItemName[equips_Bot_id])
							SndLib.sound_equip_armor(100)
							player_force_update
							wait(30)
						end
						if equips_Top_id != -1#檢查裝備 並穿裝
							$game_player.actor.change_equip("Top", $data_ItemName[equips_Top_id])
							SndLib.sound_equip_armor(100)
							player_force_update
							wait(30)
						end
						if equips_MidExt_id != -1#檢查裝備 並穿裝
							$game_player.actor.change_equip("MidExt", $data_ItemName[equips_MidExt_id])
							SndLib.sound_equip_armor(100)
							player_force_update
							wait(30)
						end
						if equips_Head_id != -1#檢查裝備 並穿裝
							$game_player.actor.change_equip("Head", $data_ItemName[equips_Head_id])
							SndLib.sound_equip_armor(100)
							player_force_update
							wait(30)
						end
					#end
					
					chcg_background_color(0,0,0,0,7)
						portrait_hide
						get_character(0).moveto(tmpPriestX,tmpPriestY)
						get_character(0).direction = 2
						$game_player.moveto(tmpPriestX+1,tmpPriestY)
						$game_player.direction = 2
					chcg_background_color(0,0,0,255,-7)
					call_msg("TagMapSaintMonastery:priest/BaptizePlayer_end")
				end
				$story_stats["RecordBaptizeByPriestAmt"] = $game_date.dateAmt
				get_character(0).npc_story_mode(false)
			
			elsif $game_temp.choice ==1
				get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],6000)
				call_msg("TagMapSaintMonastery:priest/about_optN")
			end
			#####################################################################################################################################################################################
			#####################################################################################################################################################################################
			#####################################################################################################################################################################################
			######################################################################      更多的聖徒恩惠       ##################################################################################################
			#####################################################################################################################################################################################
			#####################################################################################################################################################################################
			#####################################################################################################################################################################################
		when "moreGrace"# 更多的聖徒恩惠
			if !($game_date.dateAmt >= $story_stats["RecordBaptizeByPriestAmt"] +2)
				call_msg("TagMapSaintMonastery:priest/GraceAgain_date_block")
				return eventPlayEnd
			end
			call_msg("TagMapSaintMonastery:priest/GraceAgain0")
			chcg_background_color(0,0,0,0,7)
				portrait_hide
				$game_player.moveto(tmpBedX,tmpBedY)
				$game_player.direction = 8
				get_character(0).npc_story_mode(true)
				get_character(0).moveto(tmpBedX,tmpBedY-1)
				get_character(0).direction = 2
				get_character(0).animation = get_character(0).animation_peeing
			chcg_background_color(0,0,0,255,-7)
			

			if equips_Head_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("Head", nil)
				SndLib.sound_equip_armor(125)
				player_force_update
				wait(30)
			end
			if equips_MidExt_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("MidExt", nil)
				SndLib.sound_equip_armor(125)
				player_force_update
				wait(30)
			end
			if equips_Top_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("Top", nil)
				SndLib.sound_equip_armor(125)
				player_force_update
				wait(30)
			end
			if equips_Bot_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("Bot", nil)
				SndLib.sound_equip_armor(125)
				player_force_update
				wait(30)
			end
			if equips_Mid_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("Mid", nil)
				SndLib.sound_equip_armor(125)
				player_force_update
				wait(30)
			end
			if equips_Anal_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("Anal", nil)
				SndLib.sound_equip_armor(125)
				player_force_update
				wait(30)
			end
			if equips_Vag_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("Vag", nil)
				SndLib.sound_equip_armor(125)
				player_force_update
				wait(30)
			end

			call_msg("TagMapSaintMonastery:priest/GraceAgain2")
			$game_player.actor.stat["EventMouthRace"] = "Human"
			tmpRace = $game_player.actor.stat["EventMouthRace"]
			tmpPenisID = "Hairly"
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
			check_half_over_event
			call_msg("TagMapSaintMonastery:priest/GraceAgain3")
			$game_player.actor.add_wound("head")
			
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
			tempTxtData =  ["DataNpcName:race/#{$game_player.actor.stat["EventMouthRace"]}" , "DataNpcName:part/penis"]
			$story_stats.sex_record_mouth(tempTxtData)
			check_half_over_event
			call_msg("TagMapSaintMonastery:priest/GraceAgain4")
			$game_portraits.setLprt("nil")
			$game_player.actor.stat["EventMouthRace"] = "Human"
			load_script("Data/HCGframes/EventMouth_CumInside_Overcum.rb")
			#############################################################SUCKA PART END
			
			
			$game_portraits.setLprt("nil")
			$game_portraits.setRprt("nil")
			call_msg("TagMapSaintMonastery:priest/GraceAgain5")
			portrait_hide
			##############################################################本番
			get_character(0).moveto($game_player.x,$game_player.y)
			ev_target = get_character(0)
			temp_race=ev_target.actor.race
			plus = 1
			$game_player.manual_sex = true
			$game_player.actor.stat["SexEventScore"] = 0
			$game_player.actor.stat["SexEventLast"] =0
			$game_player.actor.stat["SexEventTotalScore"] = 0
			play_sex_service_main(ev_target,"vag",true)
			play_sex_service_get_reward(plus)
			play_sex_service_main(ev_target,"vag",true)
			play_sex_service_get_reward(plus)
			play_sex_service_main(ev_target,"vag",true)
			play_sex_service_get_reward(plus)
			play_sex_service_main(ev_target,"vag",true)
			play_sex_service_chcg(ev_target)
			play_sex_service_get_reward(plus)
			
			$game_player.actor.stat["SexEventScore"] = 0
			$game_player.actor.stat["SexEventTotalScore"] = 0
			$game_player.actor.stat["SexEventInput"] = 0
			$game_player.actor.stat["SexEventLast"] = 0
			$game_player.actor.set_action_state(:none)
			$game_player.unset_event_chs_sex
			$game_player.manual_sex = false
			ev_target.unset_event_chs_sex
			event_key_cleaner_whore_work
			$game_player.actor.prtmood("normal")
			$game_portraits.lprt.hide
			$game_portraits.rprt.hide
			##############################################################本番 end
			
					get_character(0).npc_story_mode(true)
					1.times{
						get_character(0).direction = 2 ; get_character(0).move_forward_force
						get_character(0).move_speed = 3
						until !get_character(0).moving? ; wait(1) end
					}
					get_character(0).direction = 8
					$game_player.direction = 2
					get_character(0).npc_story_mode(false)
			
					call_msg("TagMapSaintMonastery:priest/GraceAgain6")

					#if !Input.press?(:SHIFT)
						if equips_Anal_id != -1#檢查裝備 並穿裝
							$game_player.actor.change_equip("Anal", $data_ItemName[equips_Anal_id])
							SndLib.sound_equip_armor(100)
							player_force_update
							wait(30)
						end
						if equips_Vag_id != -1#檢查裝備 並穿裝
							$game_player.actor.change_equip("Vag", $data_ItemName[equips_Vag_id])
							SndLib.sound_equip_armor(100)
							player_force_update
							wait(30)
						end
						if equips_Mid_id != -1#檢查裝備 並穿裝
							$game_player.actor.change_equip("Mid", $data_ItemName[equips_Mid_id])
							SndLib.sound_equip_armor(100)
							player_force_update
							wait(30)
						end
						if equips_Bot_id != -1#檢查裝備 並穿裝
							$game_player.actor.change_equip("Bot", $data_ItemName[equips_Bot_id])
							SndLib.sound_equip_armor(100)
							player_force_update
							wait(30)
						end
						if equips_Top_id != -1#檢查裝備 並穿裝
							$game_player.actor.change_equip("Top", $data_ItemName[equips_Top_id])
							SndLib.sound_equip_armor(100)
							player_force_update
							wait(30)
						end
						if equips_MidExt_id != -1#檢查裝備 並穿裝
							$game_player.actor.change_equip("MidExt", $data_ItemName[equips_MidExt_id])
							SndLib.sound_equip_armor(100)
							player_force_update
							wait(30)
						end
						if equips_Head_id != -1#檢查裝備 並穿裝
							$game_player.actor.change_equip("Head", $data_ItemName[equips_Head_id])
							SndLib.sound_equip_armor(100)
							player_force_update
							wait(30)
						end
					#end
			call_msg("TagMapSaintMonastery:priest/GraceAgain7")
			
			chcg_background_color(0,0,0,0,7)
				portrait_hide
				$game_player.moveto(tmpPriestX,tmpPriestY+2)
				$game_player.direction = 8
				get_character(0).moveto(tmpPriestX,tmpPriestY)
				get_character(0).direction = 2
				get_character(0).animation = nil
				get_character(0).npc_story_mode(false)
			chcg_background_color(0,0,0,255,-7)
			if $game_player.actor.record_lona_title != "WhoreJob/SaintBeliever"
				$game_player.actor.record_lona_title = "WhoreJob/SaintBeliever"
				call_msg("TagMapSaintMonastery:priest/add_title1")
			end
			$story_stats["RecordBaptizeByPriest"] += 1
			$story_stats["RecordBaptizeByPriestAmt"] = $game_date.dateAmt
			if $game_player.actor.record_lona_title == "WhoreJob/SaintBeliever" && $story_stats["RecordBaptizeByPriest"] >= 4 && $story_stats["RecordRelicByPriest"] == 0
				$story_stats["RecordRelicByPriest"] = 1
				call_msg("TagMapSaintMonastery:priest/get_sexReward")
				optain_morality(5)
				wait(30)
				optain_item($data_ItemName["ItemShSaintPurge"],1)
				wait(30)
				optain_item($data_ItemName["ItemShSaintProtect"],1)
			end
	end
end


eventPlayEnd
