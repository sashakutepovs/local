#可利用 EventMouth 預先設定事件類型 但變數本身與事件無關
#若KEY並不匹配則由單位之SWITCH2ID判斷之
#switchid == 1  = did  0 = not


if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if get_character(0).switch1_id == 1
	#check all other character's sw1, if all 1 do next story
	SndLib.sound_QuickDialog
	whole_event_end
	return call_msg_popup("TagMapNoerEastCp:whoreWork/QdoneMsg#{rand(3)}",get_character(0).id)
end

if ["Normal","Hairly","Smegma","Mega"].include?($game_player.actor.stat["EventMouth"])
	tmpPenisID =  $game_player.actor.stat["EventMouth"]
else
	case get_character(0).switch2_id
	when 0	; tmpPenisID = "Normal"
	when 1	; tmpPenisID = "Hairly"
	when 2	; tmpPenisID = "Smegma"
	when 3	; tmpPenisID = "Mega"
	else	; tmpPenisID = "Normal"
	end
end

withSTD = get_character(0).actor && get_character(0).actor.with_std?
tmpSTD = ""
tmpSTD = "_STD" if withSTD

tmpRace = $game_player.actor.stat["EventMouthRace"]

tmpFailed = false
get_character(0).animation = nil
get_character(0).switch1_id =1
get_character(0).call_balloon(0)
prev_gold = $game_party.gold
$game_portraits.setLprt("#{tmpRace}Penis#{tmpPenisID}#{tmpSTD}")
$game_portraits.lprt.shake
call_msg("commonH:Lona/SuckDick#{tmpPenisID}")
call_msg("commonH:Lona/SuckDick1#{talk_persona}")
if $game_temp.choice != 0
	$game_portraits.setLprt("nil")
	tmpFailed = true
end

if !tmpFailed
	get_character(0).set_event_fuck_a_target($game_player,temp_tar_slot="mouth",forcePose=nil,tmpAniStage=0) if get_character(0).actor && !tmpSTD.empty?
	if get_character(0).actor && !tmpSTD.empty?
		$game_player.state_sex_spread_to_fucker([get_character(0)]) 
		$game_player.state_sex_spread_to_reciver([get_character(0)]) if [true,false].sample
	end
	
	portrait_hide
	chcg_background_color
	
	lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["mouth"] = 7
	$game_player.actor.portrait.update
	$game_player.actor.portrait.angle=90
	$game_portraits.rprt.set_position(-100,880)
	$game_portraits.setLprt("#{tmpRace}Penis#{tmpPenisID}#{tmpSTD}_CHCG")
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
	$game_portraits.setLprt("#{tmpRace}Penis#{tmpPenisID}#{tmpSTD}_CHCG")
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
		$game_portraits.setLprt("#{tmpRace}Penis#{tmpPenisID}#{tmpSTD}_CHCG")
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
		$game_portraits.setLprt("#{tmpRace}Penis#{tmpPenisID}#{tmpSTD}_CHCG")
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
		$game_portraits.setLprt("#{tmpRace}Penis#{tmpPenisID}#{tmpSTD}_CHCG")
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
		$game_portraits.setLprt("#{tmpRace}Penis#{tmpPenisID}#{tmpSTD}_CHCG")
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
	
	if get_character(0).actor && !tmpSTD.empty?
		$game_player.unset_chs_sex
		get_character(0).unset_chs_sex
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

#############################################################SUCKA PART END

#############################################################QA
if !tmpFailed

	call_msg("commonH:Lona/SuckDick_#{tmpRace}QA#{rand(3)}")
	$game_temp.choice = -1
	
	tmpGoodText = [$game_text["commonH:Lona/SuckDick_GoodQA0"],$game_text["commonH:Lona/SuckDick_GoodQA1"],$game_text["commonH:Lona/SuckDick_GoodQA2"]]
	tmpBad1Text = [$game_text["commonH:Lona/SuckDick_Bad1QA0"],$game_text["commonH:Lona/SuckDick_Bad1QA1"],$game_text["commonH:Lona/SuckDick_Bad1QA2"]]
	tmpBad2Text = [$game_text["commonH:Lona/SuckDick_Bad2QA0"],$game_text["commonH:Lona/SuckDick_Bad2QA1"],$game_text["commonH:Lona/SuckDick_Bad2QA2"]]
	
	tmpCMD = []
	tmpCMD << [tmpGoodText.sample,true]
	tmpCMD << [tmpBad1Text.sample,false]
	tmpCMD << [tmpBad2Text.sample,false]
	tmpCMD = tmpCMD.shuffle
	
	cmd_text =""
	for i in 0...tmpCMD.length
		cmd_text.concat(tmpCMD[i].first+",")
	end
	call_msg("\\optD[#{cmd_text}]")
	
	
	if $game_temp.choice >= 0 && tmpCMD[$game_temp.choice][1]
		call_msg("commonH:Lona/SuckDick_#{tmpRace}Win#{rand(3)}")
		optain_gold(100)
	else
		tmpFailed = true
	end
end


if tmpFailed
	call_msg("commonH:Lona/SuckDick_Failed")
	call_msg("commonH:Lona/SuckDick_#{tmpRace}Failed#{rand(3)}")
	$game_portraits.setLprt("nil")
	$game_player.actor.stat["EventMouthRace"]= tmpRace
	$game_player.actor.stat["EventVagRace"] =  tmpRace
	$game_player.actor.stat["EventAnalRace"] = tmpRace
	$game_player.actor.stat["EventExt1Race"] = tmpRace
	$game_player.actor.stat["EventExt2Race"] = tmpRace
	$game_player.actor.stat["EventExt3Race"] = tmpRace
	$game_player.actor.stat["EventExt4Race"] = tmpRace
	load_script("Data/batch/common_MCtorture_FunBeaten_event.rb")
	whole_event_end
end
#############################################################QA END


tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
get_character(tmpDualBiosID).summon_data[:MeatToiletCur] += 1
if get_character(tmpDualBiosID).summon_data[:MeatToiletCur] >= get_character(tmpDualBiosID).summon_data[:MeatToiletCount]
	get_character(tmpDualBiosID).summon_data[:MeatToiletCur] = 0
	get_character(tmpDualBiosID).summon_data[:JobDone] = true
	call_msg("TagMapNorthFL_INN:JobOpt/Done")
end


$game_portraits.setLprt("nil")
lona_mood "normal"
portrait_hide
chcg_background_color_off
whole_event_end
player_force_update
eventPlayEnd
