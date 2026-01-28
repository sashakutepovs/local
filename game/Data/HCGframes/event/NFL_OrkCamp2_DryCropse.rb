
if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if $story_stats["RapeLoopTorture"] >= 1
	call_msg_popup(".......",get_character(0).id)
	return
end

tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
#tmpcg event_DryCropse
call_msg("TagMapNFL_OrkCamp2:NFL_OrkCamp2/Rapeloop_DryCropse0")
#tmpcg event_WartsDick
call_msg("TagMapNFL_OrkCamp2:NFL_OrkCamp2/Rapeloop_DryCropse1")
#tmpcg gob Mock
call_msg("TagMapNFL_OrkCamp2:NFL_OrkCamp2/Rapeloop_DryCropse2") # [是，不要!]
$cg.erase
if $game_temp.choice == 1
	if get_character(tmpDualBiosID).summon_data[:JobSelect] == "DryCropse"
		portrait_hide
		$game_map.npcs.each{|event|
			next unless event.summon_data
			next unless event.summon_data[:GroupTop]
			next unless [nil,:none].include?(event.npc.action_state)
			event.call_balloon(5)
			event.animation = nil
			event.set_manual_move_type(0)
			event.move_type = 0
		}
		2.times{SndLib.sound_goblin_roar}
		wait(60)
		$story_stats["RapeLoopTorture"] = 1
		get_character(tmpDualBiosID).summon_data[:RapeLoopJobDid] = true
		call_msg("TagMapNFL_OrkCamp2:NFL_OrkCamp2/Rapeloop_show_no")
		get_character(0).call_balloon(0)
		return 
	end
end

$game_map.npcs.each{|event|
	next unless event.summon_data
	next unless event.summon_data[:GroupTop]
	next unless [nil,:none].include?(event.npc.action_state)
	event.npc_story_mode(true)
	event.move_type = 0
	event.animation = event.animation_masturbation
}
call_msg("TagMapNFL_OrkCamp2:NFL_OrkCamp2/Rapeloop_DryCropse2_yes")
get_character(0).call_balloon(0)
tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
get_character(tmpDualBiosID).summon_data[:RapeLoopJobDid] = true if get_character(tmpDualBiosID).summon_data[:JobSelect] == "DryCropse"
tmpAniStage1 = "animation_event_sex"
tmpAniStage2 = "animation_event_sex_fast"
tmpAniStage3 = "animation_event_sex_cumming"
tmpAniStage = 0
	
tmpPlayerX = $game_player.x
tmpPlayerY = $game_player.y
$game_player.moveto(get_character(0).x,get_character(0).y)
get_character(0).npc_story_mode(true)
pose = 5
$game_player.set_event_chs_sex(pose,0)

$story_stats["sex_record_vaginal_count"] +=1
$game_player.actor.stat["vagopen"] = 1
$game_player.actor.stat["EventVagRace"] = "Abomination"
$game_player.actor.stat["EventVag"] = "CumInside1"
$story_stats.sex_record_vag(["DataNpcName:race/Abomination" , "DataNpcName:name/AbomCreatureZombie" , "DataNpcName:part/penis"])
get_character(0).forced_y = -4
get_character(0).forced_x = 0

	$game_player.animation = eval"$game_player.#{tmpAniStage1}($game_player,#{pose})"
	get_character(0).animation = eval"get_character(0).#{tmpAniStage1}(get_character(0),0)"
	tmpAniStage = 1
	6.times{
		case tmpAniStage
			when 1 ; wait(30)
			when 2 ; wait(15)
			when 3 ; wait(40)
		end
		lona_mood "p5shame"
		load_script("Data/Batch/chcg_whorework_frame_vag.rb")
		check_over_event
		$game_player.actor.stat["SexEventLast"] =  "Vag"
	}
	$game_player.animation = eval"$game_player.#{tmpAniStage2}($game_player,#{pose})"
	get_character(0).animation = eval"get_character(0).#{tmpAniStage2}(get_character(0),0)"
	tmpAniStage = 2
	call_msg("TagMapNFL_OrkCamp2:NFL_OrkCamp2/Rapeloop_DryCropse3")
	10.times{
		case tmpAniStage
			when 1 ; wait(30)
			when 2 ; wait(15)
			when 3 ; wait(40)
		end
		lona_mood "p5shame"
		load_script("Data/Batch/chcg_whorework_frame_vag.rb")
		check_over_event
		$game_player.actor.stat["SexEventLast"] =  "Vag"
	}
	
	
	$game_player.animation = eval"$game_player.#{tmpAniStage3}($game_player,#{pose})"
	get_character(0).animation = eval"get_character(0).#{tmpAniStage3}(get_character(0),0)"
	tmpAniStage = 3
	call_msg("TagMapNFL_OrkCamp2:NFL_OrkCamp2/Rapeloop_DryCropse3")
	3.times{
		case tmpAniStage
			when 1 ; wait(30)
			when 2 ; wait(15)
			when 3 ; wait(40)
		end
		lona_mood "p5shame"
		load_script("Data/Batch/chcg_whorework_frame_vag.rb")
		check_over_event
		$game_player.actor.stat["SexEventLast"] =  "Vag"
	}
	
	
	#tmpAniStage = 2
	#6.times{
	#	case tmpAniStage
	#		when 1 ; wait(30)
	#		when 2 ; wait(15)
	#		when 3 ; wait(40)
	#	end
	#	lona_mood "p5shame"
	#	load_script("Data/Batch/chcg_whorework_frame_vag.rb")
	#	check_over_event
	#	$game_player.actor.stat["SexEventLast"] =  "Vag"
	#}




SndLib.sound_ZombieATK(100,200)
$game_player.actor.stat["EventVagRace"] =  "Abomination"
$game_player.actor.stat["EventVag"] = "CumInside1"
SndLib.sound_ZombieDED(100,50)
load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
$game_player.actor.add_state("ParasitedMoonWorm")
$game_player.actor.add_state("ParasitedPotWorm")
portrait_off
jobDid = nil
if get_character(tmpDualBiosID).summon_data[:JobSelect] == "DryCropse" 
	get_character(tmpDualBiosID).summon_data[:RapeLoopJobDid] = true
	jobDid = true
	call_msg("TagMapNFL_OrkCamp2:NFL_OrkCamp2/Rapeloop_show_end")
	tarNpcs = $game_map.npcs.select{|event|
		next unless event.summon_data
		next unless event.summon_data[:GroupTop]
		next unless [nil,:none].include?(event.npc.action_state)
		true
	}
	$cg.erase
	if tarNpcs.length >= 3
		posiTOP=$game_map.region_map[12].clone
		
		tmpTarNpc = tarNpcs.sample
		tarNpcs.delete(tmpTarNpc)
		SndLib.sound_combat_whoosh
		tmpTarNpc.animation = [tmpTarNpc.animation_atk_mh,tmpTarNpc.animation_atk_sh].sample
		posi = posiTOP.sample
		posiTOP.delete(posi)
		EvLib.sum("ItemHumanoidFlesh",tmpTarNpc.x,tmpTarNpc.y,{:toX=>posi[0],:toY=>posi[1]})
		
		tmpTarNpc = tarNpcs.sample
		tarNpcs.delete(tmpTarNpc)
		SndLib.sound_combat_whoosh
		tmpTarNpc.animation = [tmpTarNpc.animation_atk_mh,tmpTarNpc.animation_atk_sh].sample
		posi = posiTOP.sample
		posiTOP.delete(posi)
		EvLib.sum("ItemMutantFlesh",tmpTarNpc.x,tmpTarNpc.y,{:toX=>posi[0],:toY=>posi[1]})
		
		tmpTarNpc = tarNpcs.sample
		tarNpcs.delete(tmpTarNpc)
		SndLib.sound_combat_whoosh
		tmpTarNpc.animation = [tmpTarNpc.animation_atk_mh,tmpTarNpc.animation_atk_sh].sample
		posi = posiTOP.sample
		posiTOP.delete(posi)
		EvLib.sum("ItemHumanFlesh",tmpTarNpc.x,tmpTarNpc.y,{:toX=>posi[0],:toY=>posi[1]})
	end
end
$game_map.npcs.each{|event|
	next unless event.summon_data
	next unless event.summon_data[:GroupTop]
	next unless [nil,:none].include?(event.npc.action_state)
	event.npc_story_mode(false)
	event.move_type = 3
	event.summon_data[:ThrowMode] = true if jobDid
	event.animation = nil
}
get_character(0).forced_z = 1
get_character(0).forced_y = 8
get_character(0).npc_story_mode(false)
$game_player.moveto(tmpPlayerX,tmpPlayerY)
$game_player.unset_chs_sex
get_character(0).animation = get_character(0).aniCustom(get_character(0).summon_data[:aniData],-1)
event_key_cleaner_whore_work

#EvLib.sum("EffectOverKill",get_character(0).x,get_character(0).y)
#get_character(0).delete
