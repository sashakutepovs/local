
whole_event_end
tmpPenisID = "Smegma"
$game_player.actor.stat["EventMouthRace"] = "Human"
tmpRace = $game_player.actor.stat["EventMouthRace"]

withSTD = get_character(0).actor && get_character(0).actor.with_std?
tmpSTD = ""
tmpSTD = "_STD" if withSTD

get_character(0).summon_data[:suckDickAggro] = false
get_character(0).animation = nil
get_character(0).call_balloon(0)
prev_gold = $game_party.gold
$game_portraits.setLprt("#{tmpRace}Penis#{tmpPenisID}#{tmpSTD}")
$game_portraits.lprt.shake
call_msg("commonH:Lona/SuckDick#{tmpPenisID}")
call_msg("commonH:Lona/SuckDick1#{talk_persona}")
if $game_temp.choice != 0
	$game_portraits.setLprt("nil")
	get_character(0).summon_data[:suckDickAggro] = true
	eventPlayEnd
	return
end

if !get_character(0).summon_data[:suckDickAggro]
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
	
	call_msg("TagMapHumanPrisonCave:DirtyJohnson/FirstTime_blowjob_to_deepthroat")
	portrait_off
	load_script("Data/HCGframes/UniqueEvent_DeepThroat.rb")
	$game_player.actor.add_state("STD_Leukorrhea")
	get_character(0).summon_data[:suckDickAggro] = false
	
	if get_character(0).actor && !tmpSTD.empty?
		$game_player.unset_chs_sex
		get_character(0).unset_chs_sex
	end
end
