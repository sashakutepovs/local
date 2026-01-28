


#非受刑人 被趕出去了
if $story_stats["Captured"] != 1
	call_msg("common:Lona/NarrDriveAway")
	portrait_hide
	return change_map_leave_tag_map 
end
isGangMode = rand(100) >= 50

#構築RAPE LOOP FUCKER
tmp_on_sight = false
$game_map.npcs.each do |event| 
	next if event.npc.fraction !=7
	next if event.npc.sex !=1
	next if event.actor.action_state != nil && event.actor.action_state !=:none
	next if !event.near_the_target?($game_player,3)
	next if event.actor.sensors[0].get_signal(event,$game_player)[2] <=15 #[target,distance,signal_strength,sensortype]
	tmp_on_sight = true
end
#構築FUCKER
do_ret = false
no_more_until = nil
until do_ret
	tmp_fucker_id = nil
	tmpFuckerNPCs = $game_map.npcs.select{|event| 
		next if event.summon_data == nil
		next if event.summon_data[:NapFucker] == nil
		next if !event.summon_data[:NapFucker]
		next if event.actor.action_state != nil && event.actor.action_state !=:none
		next if !event.near_the_target?($game_player,5)
		next if !event.actor.target.nil?
		next if event.opacity != 255
		next if event.actor.sensors[0].get_signal(event,$game_player)[2] <=19 #[target,distance,signal_strength,sensortype]
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
	#RapeLoop事件
	if tmp_fucker_id != nil && isGangMode && $game_player.actor.sta > -99
		$story_stats["DreamPTSD"] = "Bandit" if $game_player.actor.mood <= -50
		$game_player.actor.record_lona_title = "Rapeloop/PrisonerMeatToilet"
		$story_stats["RapeLoop"] =1
		
		##move to closet point
		st1_x,st1_y,st1_id=$game_map.get_storypoint("SexPoint1")
		st2_x,st2_y,st2_id=$game_map.get_storypoint("SexPoint2")
		st3_x,st3_y,st3_id=$game_map.get_storypoint("SexPoint3")
		st4_x,st4_y,st4_id=$game_map.get_storypoint("CapturedPoint")
		st1_range=get_character(st1_id).report_range
		st2_range=get_character(st2_id).report_range
		st3_range=get_character(st3_id).report_range
		st4_range=get_character(st4_id).report_range
		st_lowest= [st1_range,st2_range,st3_range,st4_range].min
		if st1_range == st_lowest
			$game_player.moveto(st1_x,st1_y)
		elsif st2_range == st_lowest
			$game_player.moveto(st2_x,st2_y)
		elsif st3_range == st_lowest
			$game_player.moveto(st3_x,st3_y)
		elsif st4_range == st_lowest
			$game_player.moveto(st4_x,st4_y)
		else
			$game_player.moveto(st4_x,st4_y)
		end
		
		ev1= get_character($game_map.get_storypoint("RaperGang1")[2])
		ev2= get_character($game_map.get_storypoint("RaperGang2")[2])
		ev1.moveto($game_player.x,$game_player.y)
		ev2.moveto($game_player.x,$game_player.y)
		ev1.push_away
		ev2.push_away
		ev1.moveto(ev1.x,ev1.y)
		ev2.moveto(ev2.x,ev2.y)
		ev1.turn_toward_character($game_player)
		ev2.turn_toward_character($game_player)
		
		get_character($game_map.get_storypoint("RaperTop")[2]).npc.sense_target($game_player,0)
		get_character($game_map.get_storypoint("RaperBot")[2]).npc.sense_target($game_player,0)
		
		$game_map.interpreter.chcg_background_color(0,0,0,255,-7)
		player_cancel_nap
		call_msg("TagMapHumanPrisonCave:HumanPrisonCave/RapeLoop_begin1")
		call_msg("common:Lona/use_as_MeatToilet#{talk_style}")
		portrait_hide
		return 
	#Nap fucker開幹
	elsif tmp_fucker_id != nil
		get_character(tmp_fucker_id).setup_audience
		get_character(tmp_fucker_id).move_type =0
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
		call_msg("TagMapNoerPrison:Prisoner/NapRape1")
		call_msg("TagMapNoerPrison:Prisoner/NapRape2")
		goto_sex_point_with_character(get_character(tmp_fucker_id),"rand",tmpMoveToCharAtEnd=false)
		do_ret = false
		$game_player.turn_toward_character(get_character(tmp_fucker_id))
		$game_player.call_balloon(0)
		$game_player.animation = nil
		call_msg("common:Lona/NapRape3")
		get_character(tmp_fucker_id).call_balloon(20)
		call_msg("TagMapNoerPrison:Prisoner/NapRape3_#{rand(3)}")
		if $game_player.actor.sta > 0
			call_msg("common:Lona/NapRape_withSta") #\optD[我是便器<t=3>,反抗]
			do_ret = false
			case $game_temp.choice
				when 0
					call_msg("common:Lona/NapRape_withSta_NoFight1#{talk_persona}")
					call_msg("TagMapNoerPrison:Prisoner/NapRape_withSta_NoFight2")
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
					call_msg("TagMapNoerPrison:Prisoner/NapRape_withSta_NoFight2")
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
		$game_player.animation = $game_player.animation_stun
		get_character(tmp_fucker_id).actor.process_target_lost
	end
end #until


#刑期已滿 出獄
if $game_player.actor.morality_lona >= 50
	portrait_hide
	chcg_background_color(0,0,0,255)
		portrait_off
		call_msg("TagMapNoerPrison:Warden/Release1")
		tmpWardenX,tmpWardenY,tmpWardenID = $game_map.get_storypoint("Warden")
		tmpTortureX,tmpTortureY,tmpTortureID = $game_map.get_storypoint("Torture1")
	chcg_background_color(0,0,0,255,-3)
	get_character(tmpWardenID).npc_story_mode(true)
	cam_follow(tmpWardenID,0)
	get_character(tmpWardenID).moveto($game_player.x+2,tmpTortureY-1)
	get_character(tmpWardenID).direction = 4
	get_character(tmpWardenID).move_forward
	wait(60)
	get_character(tmpWardenID).move_forward
	wait(60)
	get_character(tmpWardenID).direction = 8
	wait(60)
	get_character(tmpWardenID).npc_story_mode(false)
	call_msg("TagMapNoerPrison:Warden/Release2")
	cam_center(0)
	wait(60)
	call_msg("TagMapNoerPrison:Warden/Release3")
	$game_map.interpreter.chcg_background_color(0,0,0,0,7)
	wait(60)
	SndLib.sound_step_chain(100)
	wait(60)
	SndLib.sound_step_chain(100)
	wait(60)
	SndLib.sound_step_chain(100)
	wait(60)
	SndLib.sound_equip_armor(100)
	call_msg("TagMapNoerPrison:Warden/Release4")
#################################################解鎖手銬
	#$game_player.actor.change_equip(0, nil)
	#$game_player.actor.change_equip(5, nil)
	rape_loop_drop_item(false,false)
	chcg_background_color(0,0,0,255,-7)
	player_force_update
	wait(60)
	SndLib.sound_step_chain(100)
##############################################
	call_msg("TagMapNoerPrison:Warden/Release5")
	call_msg("TagMapNoerPrison:Warden/Release6")
	call_msg("common:Lona/NarrDriveAway")
	portrait_hide
	return change_map_leave_tag_map
end


#正常過日
if tmp_fucker_id == nil
	#正常強暴
	if $story_stats["RapeLoop"] ==1 && tmp_on_sight && $game_player.actor.morality_lona <= 50
		$story_stats["DreamPTSD"] = "Bandit" if $game_player.actor.mood <= -50
		$game_map.interpreter.chcg_background_color(40,0,35,0,7)
		load_script("Data/HCGframes/event/HumanCave_NapGangRape.rb")
	end
	$story_stats["RapeLoop"] =0
	optain_morality(2) if $game_player.actor.morality_lona <50
	difmora = 50-$game_player.actor.morality_lona
	halfdays = (difmora/2).ceil
	days = halfdays * 0.5
	# call_msg("#{$game_text["TagMapNoerPrison:Prison/term"]}#{(50-$game_player.actor.morality_lona)/4}#{$game_text["TagMapNoerPrison:Prison/termD"]}")
	call_msg("#{$game_text["TagMapNoerPrison:Prison/term"]}#{days}#{$game_text["TagMapNoerPrison:Prison/termD"]}")
	portrait_hide
	handleNap
end
