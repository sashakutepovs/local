


tmpMobAlive = $game_map.npcs.any?{
|event| 
next unless event.summon_data
next unless event.summon_data[:WildnessNapEvent] == "BanditMobs"
next if event.deleted?
next if event.npc.action_state == :death
true
}

if !tmpMobAlive
	$story_stats["Captured"] = 0
	$story_stats["RapeLoop"] = 0
	portrait_hide
	return handleNap
end

tmpWakeUpX,tmpWakeUpY,tmpWakeUpID=$game_map.get_storypoint("WakeUp")
tmpG1X,tmpG1Y,tmpG1ID = $game_map.get_storypoint("Gate1")
tmpG1HP = get_character(tmpG1ID).switch1_id
tmpG1HPmax = get_character(tmpG1ID).summon_data[:staNeed]
if tmpMobAlive && (tmpG1HP >= tmpG1HPmax || $story_stats["RecQuestPigBobo"] >= 1 || $story_stats["UniqueCharUniquePigBobo"] == -1)
	$story_stats["RapeLoopTorture"] = 1
	if  $story_stats["RecQuestPigBobo"] >= 1 || $story_stats["UniqueCharUniquePigBobo"] == -1
		$story_stats["RapeLoop"] = 1
		$story_stats["Captured"] = 1 
	end
	call_msg("TagMapNoerMobHouse:Doors/LockReset")
	get_character(tmpG1ID).switch1_id = 0
	get_character(tmpG1ID).moveto(tmpG1X,tmpG1Y)
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
	if tmp_fucker_id
		#chcg_background_color(0,0,0,255,-7)
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
		goto_sex_point_with_character(get_character(tmp_fucker_id),nil,tmpMoveToCharAtEnd=false)
		do_ret = false
		$game_player.turn_toward_character(get_character(tmp_fucker_id))
		$game_player.call_balloon(0)
		$game_player.animation = nil
		call_msg("common:Lona/NapRape3")
		get_character(tmp_fucker_id).call_balloon(20)
		call_msg("TagMapNoerMobHouse:Rogue/NapRape3_#{rand(3)}")
		if $game_player.actor.sta > 0
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
		sameLocNapRape = true
		tmpSexPT = sameLocNapRape ? nil : "closest"
		get_character(tmp_fucker_id).moveto($game_player.x,$game_player.y)
		play_sex_service_menu(get_character(tmp_fucker_id),0,tmpSexPT,true)
		get_character(tmp_fucker_id).turn_toward_character($game_player)
		$game_player.animation = $game_player.animation_stun
	end
end #until


#if torture  ################################################## First time capture player
if tmpMobAlive && $story_stats["Captured"] == 0
	chcg_background_color(0,0,0,0,7)
	map_background_color(0,0,0,255,0)
	call_msg("TagMapBanditCamp2:Rogue/NapSpot")
	rape_loop_drop_item(false,false)
	$story_stats["Captured"] = 1
	$story_stats["RapeLoop"] = 0
	$story_stats["RapeLoopTorture"] = 0
	$game_player.actor.change_equip(0, nil)
	$game_player.actor.change_equip(1, nil)
	$game_player.actor.change_equip(5, nil)
	rape_loop_drop_item(tmpEquip=false,tmpSummon=false,lostItem=true,keepInBox=false)
	load_script("Data/Batch/Put_HeavyestBondage_no_dialog.rb")
	
#if torture  ################################################## Kill player because play trying to escape.
elsif tmpMobAlive && $story_stats["Captured"] == 1 && $story_stats["RapeLoop"] == 1 && ($story_stats["RapeLoopTorture"] == 1 || get_character(tmpWakeUpID).summon_data[:job] != nil || $story_stats["UniqueCharUniquePigBobo"] == -1 || $story_stats["RecQuestPigBobo"] >= 1)
	$story_stats["DreamPTSD"] = "Bandit" if $game_player.actor.mood <= -50
	tmpNoBobo = $story_stats["RecQuestPigBobo"] >= 1 || $story_stats["UniqueCharUniquePigBobo"] == -1 
	SndLib.bgm_stop
	SndLib.bgs_stop
	portrait_hide
	chcg_background_color(20,0,0,0,2)
	portrait_off
	call_msg("TagMapBanditCamp2:GameOver/begin0_noBobo") if tmpNoBobo
	call_msg("TagMapBanditCamp2:GameOver/begin0") if !tmpNoBobo
	SndLib.sound_gore(100)
	SndLib.sound_combat_hit_gore(70)
	$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true) ; wait(20+rand(20))
	SndLib.sound_combat_hit_gore(70)
	$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true) ; wait(20+rand(20))
	SndLib.sound_combat_hit_gore(70)
	$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true) ; wait(20+rand(20))
	wait(60)
	call_msg("TagMapBanditCamp2:GameOver/begin1_noBobo") if tmpNoBobo
	call_msg("TagMapBanditCamp2:GameOver/begin1") if !tmpNoBobo
	SndLib.sound_gore(100)
	SndLib.sound_combat_hit_gore(70)
	$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true) ; wait(20+rand(20))
	SndLib.sound_combat_hit_gore(70)
	$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true) ; wait(20+rand(20))
	SndLib.sound_combat_hit_gore(70)
	$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true) ; wait(20+rand(20))
	wait(60)
	SndLib.sound_step_chain(100)
	wait(10)
	SndLib.sys_close
	wait(90)
	8.times{
		$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
		SndLib.SwineSpot if rand(100) >=60 && !tmpNoBobo
		SndLib.sound_gore(100)
		SndLib.sound_combat_hit_gore(70)
		wait(20+rand(20))
	}
	chcg_background_color(0,0,0,255)
	wait(90)
	return load_script("Data/HCGframes/OverEvent_Death.rb")
else
	portrait_hide
	return handleNap
end

if !tmp_fucker_id
	portrait_hide
	handleNap
end
