#可利用 EventMouth 設定事件類型 但變數本身與事件無關
#
#if ["Normal","Hairly","Smegma","Mega"].include?($game_player.actor.stat["EventMouth"])
#	tmpPenisID =  $game_player.actor.stat["EventMouth"]
#else
#	tmpPenisID = ["Normal","Hairly","Smegma","Mega"].sample
#end

#種族由嘴部種族設定之
tmpPigManX,tmpPigManY,tmpPigManID = $game_map.get_storypoint("PigMan")
$game_player.actor.stat["EventMouthRace"]= "Human"
tmpPenisID = "Hairly"
tmpRace = $game_player.actor.stat["EventMouthRace"]

withSTD = get_character(tmpPigManID).actor && get_character(tmpPigManID).actor.with_std?
tmpSTD = ""
tmpSTD = "_STD" if withSTD

tmpFailed = false
$game_portraits.setLprt("#{tmpRace}Penis#{tmpPenisID}#{tmpSTD}")
$game_portraits.lprt.shake
call_msg("commonH:Lona/SuckDick#{tmpPenisID}")
call_msg("TagMapDfWaterCave:wakeUp/suckDick0_#{rand(3)}")
if !tmpFailed
	get_character(tmpPigManID).set_event_fuck_a_target($game_player,temp_tar_slot="mouth",forcePose=nil,tmpAniStage=0) if get_character(tmpPigManID).actor && !tmpSTD.empty?
	if get_character(tmpPigManID).actor && !tmpSTD.empty?
		$game_player.state_sex_spread_to_fucker([get_character(tmpPigManID)]) 
		$game_player.state_sex_spread_to_reciver([get_character(tmpPigManID)]) if [true,false].sample
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
	call_msg("TagMapDfWaterCave:wakeUp/suckDick1_#{rand(3)}")
	
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
				call_msg("TagMapDfWaterCave:SexPartyOP/2_2")
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
		when 1 ;
				call_msg("TagMapDfWaterCave:SexPartyOP/2_2")
				chcg_decider_basic_mouth(5)
				$game_player.actor.stat["EventMouthRace"] = "Human"
				$game_portraits.setLprt("nil")
				if tmpPenisID == "Mega"
					load_script("Data/HCGframes/EventMouth_CumInside_Overcum.rb")
				else
					load_script("Data/HCGframes/EventMouth_CumInside.rb")
				end
	end
	if get_character(tmpPigManID).actor && !tmpSTD.empty?
		$game_player.unset_chs_sex
		get_character(tmpPigManID).unset_chs_sex
	end
end

if $story_stats["Setup_UrineEffect"] ==1
	case rand(3)
		when 0 
		whole_event_end
		call_msg("TagMapDfWaterCave:wakeUp/suckDick1_pee}")
		$game_portraits.setLprt("nil")
		chcg_decider_basic_mouth(5)
		$game_player.actor.stat["EventMouthRace"] = "Human"
		load_script("Data/HCGframes/UniqueEvent_PeeonHeadNoOPT.rb")
	end
end
whole_event_end

$game_portraits.setLprt("nil")
$game_portraits.setLprt("nil")
$game_temp.choice = -1
