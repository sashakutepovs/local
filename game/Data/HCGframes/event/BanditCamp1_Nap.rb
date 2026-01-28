

tmpMobAlive = $game_map.npcs.any?{
|event| 
next unless event.summon_data
next unless event.summon_data[:WildnessNapEvent] == "BanditMobs"
next if event.deleted?
next if event.npc.action_state == :death
true
}

if tmpMobAlive
	call_msg("TagMapBanditCamp1:Rogue/NapSpot") if $story_stats["Captured"] == 0
	rape_loop_drop_item(false,false)
	$story_stats["Captured"] = 1
	$story_stats["RapeLoop"] =0
else
	portrait_hide
	$story_stats["RapeLoopTorture"] = 0
	$story_stats["Captured"] = 0
	$story_stats["RapeLoop"] =0
	return handleNap
end
#if torture 

###########################################################	NAP FUCKER	#########################################
tmpFucker1X,tmpFucker1Y,tmpFucker1ID = $game_map.get_storypoint("Raper1")
tmpFucker2X,tmpFucker2Y,tmpFucker2ID = $game_map.get_storypoint("Raper2")
tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
tmpDoRape =  get_character(tmpWakeUpID).switch2_id[0] #1 how many days, 2 do rape?
tmpDoRape2 =  rand(100) >= 60 #1 how many days, 2 do rape?
$story_stats["Ending_MainCharacter"] = "Ending_MC_HumanSlave" if $story_stats["Captured"] == 1
sameLocNapRape = false

if (tmpDoRape ==1 && tmpDoRape2) || $story_stats["RapeLoopTorture"] ==1
	sameLocNapRape = true
	$story_stats["DreamPTSD"] = "Bandit" if $game_player.actor.mood <= -50
	$game_player.actor.record_lona_title = "Rapeloop/NoerMobHouse"
	get_character(tmpWakeUpID).switch2_id[0] = 0
	$game_map.interpreter.chcg_background_color(0,0,0,255)
	get_character(tmpFucker1ID).npc_story_mode(true)					if !get_character(tmpFucker1ID).nil?
	#get_character(tmpFucker1ID).moveto($game_player.x+1,$game_player.y)	if !get_character(tmpFucker1ID).nil?
	get_character(tmpFucker1ID).moveto($game_player.x,$game_player.y)	if !get_character(tmpFucker1ID).nil?
	get_character(tmpFucker1ID).turn_toward_character($game_player)		if !get_character(tmpFucker1ID).nil?
	get_character(tmpFucker1ID).item_jump_to
	get_character(tmpFucker1ID).move_away_from_character($game_player)
	get_character(tmpFucker1ID).turn_toward_character($game_player)		if !get_character(tmpFucker1ID).nil?
	
	get_character(tmpFucker2ID).npc_story_mode(true)					if !get_character(tmpFucker2ID).nil?
	#get_character(tmpFucker2ID).moveto($game_player.x+1,$game_player.y-1)	if !get_character(tmpFucker2ID).nil?
	get_character(tmpFucker2ID).moveto($game_player.x,$game_player.y)	if !get_character(tmpFucker2ID).nil?
	get_character(tmpFucker2ID).item_jump_to
	get_character(tmpFucker2ID).move_away_from_character($game_player)
	get_character(tmpFucker2ID).turn_toward_character($game_player)		if !get_character(tmpFucker2ID).nil?
	
	call_msg("TagMapBanditCamp1:Rogue/NapRape") if $story_stats["RapeLoopTorture"] ==0
	call_msg("TagMapBanditCamp1:Rogue/NapTorture1") if $story_stats["RapeLoopTorture"] ==1
	
	get_character(tmpFucker1ID).npc_story_mode(false)		if !get_character(tmpFucker1ID).nil?
	get_character(tmpFucker2ID).npc_story_mode(false)		if !get_character(tmpFucker2ID).nil?
	chcg_background_color(0,0,0,255,-7)
	
	
	
	if $story_stats["RapeLoopTorture"] ==1
		player_cancel_nap
		$game_player.actor.stat["EventVagRace"] =  "Human"
		$game_player.actor.stat["EventAnalRace"] = "Human"
		$game_player.actor.stat["EventMouthRace"] ="Human"
		$game_player.actor.stat["EventExt1Race"] = "Human"
		$game_player.actor.stat["EventExt2Race"] = "Human"
		$game_player.actor.stat["EventExt3Race"] = "Human"
		$game_player.actor.stat["EventExt4Race"] = "Human"
		get_character(tmpFucker2ID).moveto($game_player.x,$game_player.y-1)
		get_character(tmpFucker2ID).direction = 2
		get_character(tmpFucker2ID).animation = get_character(tmpFucker2ID).animation_grabber_qte($game_player)
		$game_player.animation = $game_player.animation_grabbed_qte
		get_character(tmpFucker1ID).direction = 8
		call_msg("TagMapNoerMobHouse:Rogue/NapTorture2")
		wait(60)
		load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
		get_character(tmpFucker1ID).animation = get_character(tmpFucker1ID).animation_atk_mh
		wait(60)
		load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
		get_character(tmpFucker1ID).animation = get_character(tmpFucker1ID).animation_atk_sh
		wait(60)
		load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
		get_character(tmpFucker1ID).animation = get_character(tmpFucker1ID).animation_atk_mh
		wait(60)
		load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
		get_character(tmpFucker1ID).animation = get_character(tmpFucker1ID).animation_atk_sh
		wait(60)
		call_msg("TagMapNoerMobHouse:Rogue/NapTorture3")
		
		load_script("Data/Batch/common_MCtorture_FunBeaten_event.rb")
		load_script("Data/Batch/common_MCtorture_FunBeaten_event.rb")
		load_script("Data/Batch/common_MCtorture_End_event.rb")
		
		get_character(tmpFucker2ID).moveto($game_player.x,$game_player.y)
		get_character(tmpFucker2ID).animation = nil
		$game_player.animation = nil
		
	end
	
	whole_event_end
	check_over_event
	check_half_over_event
	$story_stats["RapeLoopTorture"] =0
	$story_stats["RapeLoop"] =1
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
		
	tmp_on_sight = false
	$game_map.npcs.each do |event| 
		next unless event.summon_data
		next unless event.summon_data[:WildnessNapEvent] == "BanditMobs"
		next if event.npc.fraction !=7
		next if event.npc.sex !=1
		next if event.actor.action_state != nil && event.actor.action_state !=:none
		next if !event.near_the_target?($game_player,4)
		next if event.actor.sensors[0].get_signal(event,$game_player)[2] <=5 #[target,distance,signal_strength,sensortype]
		tmp_on_sight = true
	end
	$story_stats["RapeLoop"] =1 if tmp_on_sight
		#Nap fucker開幹
	if tmp_fucker_id != nil
		$story_stats["DreamPTSD"] = "Bandit" if $game_player.actor.mood <= -50
		#get_character(tmp_fucker_id).setup_audience
		#get_character(tmp_fucker_id).move_type =0
		get_character(tmp_fucker_id).opacity = 255
		get_character(tmp_fucker_id).animation = nil
		get_character(tmp_fucker_id).call_balloon(2)
		get_character(tmp_fucker_id).turn_toward_character($game_player)
		call_msg("TagMapNoerPrison:Prisoner/NapRape_#{rand(3)}")
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
		call_msg("TagMapNoerMobHouse:Rogue/NapRape1")
		tmpSexPT = sameLocNapRape ? nil : "rand"
		goto_sex_point_with_character(get_character(tmp_fucker_id),sex_point=tmpSexPT,tmpMoveToCharAtEnd=false)
		do_ret = false
		$game_player.turn_toward_character(get_character(tmp_fucker_id))
		$game_player.call_balloon(0)
		$game_player.animation = nil
		call_msg("common:Lona/NapRape3")
		get_character(tmp_fucker_id).call_balloon(20)
		call_msg("TagMapNoerMobHouse:Rogue/NapRape3_#{rand(3)}")
		if $game_player.actor.sta > 0
			#player_cancel_nap if $story_stats["Captured"] == 0
			call_msg("common:Lona/NapRape_withSta") #\optD[我是便器<t=3>,反抗]
			case $game_temp.choice
				when 0
					call_msg("common:Lona/NapRape_withSta_NoFight1#{talk_persona}")
					get_character(tmp_fucker_id).call_balloon(20)
					call_msg("TagMapNoerMobHouse:Rogue/NapRape_withSta_NoFight2")
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
					call_msg("TagMapNoerMobHouse:Rogue/NapRape_withSta_NoFight2")
			end
			$game_temp.choice = -1
			return eventPlayEnd if do_ret
		else
			call_msg("common:Lona/NapRape_noSta")
			$story_stats["sex_record_coma_sex"] +=1 if $game_player.actor.sta <=-100
		end
		portrait_hide
		tmpSexPT = sameLocNapRape ? nil : "closest"
		get_character(tmp_fucker_id).moveto($game_player.x,$game_player.y)
		play_sex_service_menu(get_character(tmp_fucker_id),0,sex_point=tmpSexPT,true)
		get_character(tmpFucker1ID).turn_toward_character($game_player)
		$game_player.animation = $game_player.animation_stun
	end
end #until
if tmp_fucker_id == nil
	tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
	if $story_stats["RapeLoop"] ==1 && tmp_on_sight && get_character(tmpWakeUpID).switch2_id[3] != 1 #若非狗狗事件 則檢測是否RAPELOOP
		$game_map.interpreter.chcg_background_color(40,0,35,0,7)
		load_script("Data/HCGframes/event/HumanCave_NapGangRape.rb")
	end
	$story_stats["RapeLoop"] =0
	portrait_hide
	return handleNap
end
