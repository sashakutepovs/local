

tmpMobAlive = $game_map.npcs.any?{
|event| 
next unless event.summon_data
next unless event.summon_data[:WildnessNapEvent]
next if event.deleted?
next if event.npc.action_state == :death
true
}

if tmpMobAlive
	call_msg("TagMapNoerMobHouse:Rogue/NapSpot") if $story_stats["Captured"] == 0
	rape_loop_drop_item(false,false)
	$story_stats["Captured"] = 1
	$story_stats["RapeLoop"] = 0
else
	portrait_hide
	return handleNap 
end
tmpG1X,tmpG1Y,tmpG1ID = $game_map.get_storypoint("Gate1")
tmpG2X,tmpG2Y,tmpG2ID = $game_map.get_storypoint("Gate2")
tmpG3X,tmpG3Y,tmpG3ID = $game_map.get_storypoint("Gate3")
tmpG4X,tmpG4Y,tmpG4ID = $game_map.get_storypoint("Gate4")
tmpG1HP = get_character(tmpG1ID).switch1_id
tmpG2HP = get_character(tmpG2ID).switch1_id
tmpG3HP = get_character(tmpG3ID).switch1_id
tmpG4HP = get_character(tmpG4ID).switch1_id
tmpG1HPmax = get_character(tmpG1ID).summon_data[:staNeed]
tmpG2HPmax = get_character(tmpG2ID).summon_data[:staNeed]
tmpG3HPmax = get_character(tmpG3ID).summon_data[:staNeed]
tmpG4HPmax = get_character(tmpG4ID).summon_data[:staNeed]
if tmpG1HP >= tmpG1HPmax || tmpG2HP >= tmpG2HPmax || tmpG3HP >= tmpG3HPmax || tmpG4HP >= tmpG4HPmax
	rape_loop_drop_item(false,false)
	$story_stats["RapeLoopTorture"] = 1
	call_msg("TagMapNoerMobHouse:Doors/LockReset")
	get_character(tmpG1ID).switch1_id = 0
	get_character(tmpG2ID).switch1_id = 0
	get_character(tmpG3ID).switch1_id = 0
	get_character(tmpG4ID).switch1_id = 0
	get_character(tmpG1ID).moveto(tmpG1X,tmpG1Y)
	get_character(tmpG2ID).moveto(tmpG2X,tmpG2Y)
	get_character(tmpG3ID).moveto(tmpG3X,tmpG3Y)
	get_character(tmpG4ID).moveto(tmpG4X,tmpG4Y)
end
#if torture 

###########################################################	NAP FUCKER	#########################################
tmp_fucker_id = nil
tmpFucker1X,tmpFucker1Y,tmpFucker1ID = $game_map.get_storypoint("Raper1")
tmpFucker2X,tmpFucker2Y,tmpFucker2ID = $game_map.get_storypoint("Raper2")
tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
tmpDoRape =  get_character(tmpWakeUpID).switch2_id #1 how many days, 2 do rape?
$story_stats["Ending_MainCharacter"] = "Ending_MC_HumanSlave" if $story_stats["Captured"] == 1
if (tmpDoRape ==1 && rand(100) >= 60) || $story_stats["RapeLoopTorture"] ==1
	$story_stats["DreamPTSD"] = "Bandit" if $game_player.actor.mood <= -50
	rape_loop_drop_item(false,false)
	$game_player.actor.record_lona_title = "Rapeloop/NoerMobHouse"
	get_character(tmpWakeUpID).switch2_id = 0
	$game_map.interpreter.chcg_background_color(0,0,0,255)
	get_character(tmpFucker1ID).npc_story_mode(true)					if !get_character(tmpFucker1ID).nil?
	get_character(tmpFucker1ID).moveto($game_player.x,$game_player.y+1)	if !get_character(tmpFucker1ID).nil?
	get_character(tmpFucker1ID).turn_toward_character($game_player)		if !get_character(tmpFucker1ID).nil?
	
	get_character(tmpFucker2ID).npc_story_mode(true)					if !get_character(tmpFucker2ID).nil?
	get_character(tmpFucker2ID).moveto($game_player.x,$game_player.y+1)	if !get_character(tmpFucker2ID).nil?
	get_character(tmpFucker2ID).item_jump_to							if !get_character(tmpFucker2ID).nil?
	get_character(tmpFucker2ID).turn_toward_character($game_player)		if !get_character(tmpFucker2ID).nil?
	
	call_msg("TagMapNoerMobHouse:Rogue/NapRape") if $story_stats["RapeLoopTorture"] ==0
	call_msg("TagMapNoerMobHouse:Rogue/NapTorture1") if $story_stats["RapeLoopTorture"] ==1
	
	get_character(tmpFucker1ID).npc_story_mode(false)		if !get_character(tmpFucker1ID).nil?
	get_character(tmpFucker2ID).npc_story_mode(false)		if !get_character(tmpFucker2ID).nil?
	$game_map.interpreter.chcg_background_color(0,0,0,255,-7)
	
	
	if $story_stats["RapeLoopTorture"] == 1
	
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
		
		
	$game_map.npcs.each do |event| 
		next if event.summon_data == nil
		next if event.summon_data[:NapFucker] == nil
		next if !event.summon_data[:NapFucker]
		next if event.actor.action_state != nil && event.actor.action_state !=:none
		next if !event.near_the_target?($game_player,3)
		next if !event.actor.target.nil?
		next if event.opacity != 255
		next if event.actor.sensors[0].get_signal(event,$game_player)[2] <=5 #[target,distance,signal_strength,sensortype]
		event.summon_data[:NapFucker] = false
		play_sex = true
		tmp_fucker_id = event.id
	end
	
	
tmp_on_sight = false
$game_map.npcs.each do |event| 
	next unless event.summon_data
	next unless event.summon_data[:WildnessNapEvent] == "BanditMobs"
	next if event.npc.fraction !=7
	next if event.npc.sex !=1
	next if event.actor.action_state != nil && event.actor.action_state !=:none
	next if !event.near_the_target?($game_player,3)
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
		get_character(tmp_fucker_id).turn_toward_character($game_player)
		get_character(tmp_fucker_id).call_balloon(4)
		wait(60)
		
		get_character(tmp_fucker_id).npc_story_mode(false,false)
		get_character(tmp_fucker_id).turn_toward_character($game_player)
		call_msg("TagMapNoerMobHouse:Rogue/NapRape1")
		goto_sex_point_with_character(get_character(tmp_fucker_id),nil)
		call_msg("common:Lona/NapRape3")
		call_msg("TagMapNoerMobHouse:Rogue/NapRape3_#{rand(3)}")
		if $game_player.actor.sta > 0
			player_cancel_nap
			call_msg("common:Lona/NapRape_withSta") #\optD[我是便器<t=3>,反抗]
			do_ret = false
			case $game_temp.choice
				when 0
					call_msg("common:Lona/NapRape_withSta_NoFight1#{talk_persona}")
					call_msg("TagMapNoerMobHouse:Rogue/NapRape_withSta_NoFight2")
				when 1
					do_ret = true
					get_character(tmp_fucker_id).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
					SndLib.sound_punch_hit(100)
					SndLib.sound_punch_hit(100)
					SndLib.sound_punch_hit(100)
					$game_player.animation = $game_player.animation_atk_mh
					get_character(tmp_fucker_id).npc_story_mode(true,false)
					get_character(tmp_fucker_id).push_away
					$game_player.turn_toward_character(get_character(tmp_fucker_id))
					get_character(tmp_fucker_id).turn_toward_character($game_player)
					until !get_character(tmp_fucker_id).moving?
						wait(1)
					end
					get_character(tmp_fucker_id).npc_story_mode(false,false)
					call_msg("common:Lona/NapRape_withSta_Fight1#{talk_persona}")
					call_msg("TagMapNoerMobHouse:Rogue/NapRape_withSta_NoFight2")
			end
			$game_temp.choice = -1
			return if do_ret
		else
		call_msg("common:Lona/NapRape_noSta")
		$story_stats["sex_record_coma_sex"] +=1 if $game_player.actor.sta <=-100
		end
		play_sex_service_menu(get_character(tmp_fucker_id),0,nil,true)
		get_character(tmpFucker1ID).turn_toward_character($game_player)
	end

if tmp_fucker_id == nil
	if $story_stats["RapeLoop"] ==1 && tmp_on_sight# && $game_player.actor.morality_lona <= 50
		$story_stats["DreamPTSD"] = "Bandit" if $game_player.actor.mood <= -50
		$game_map.interpreter.chcg_background_color(40,0,35,0,7)
		load_script("Data/HCGframes/event/HumanCave_NapGangRape.rb")
	end
	$story_stats["RapeLoop"] =0
	portrait_hide
	handleNap
end
