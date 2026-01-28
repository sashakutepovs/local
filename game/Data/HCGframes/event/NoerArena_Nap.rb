portrait_hide
#尋找對玩家有興趣的NPC

tmpBiosID = $game_map.get_storypoint("DualBios")[2]
tmpPlayedOP = get_character(tmpBiosID).summon_data[:PlayedOP]
tmpMatchEnd = get_character(tmpBiosID).summon_data[:MatchEnd]
tmpPlayerMatch = get_character(tmpBiosID).summon_data[:PlayerMatch]
tmpPlayerMatchOpp = get_character(tmpBiosID).summon_data[:PlayerMatchOpp]
tmpPlayerMatchRace = get_character(tmpBiosID).summon_data[:PlayerMatchRace]
tmpPlayerMatchRaceRapeBeginEV = get_character(tmpBiosID).summon_data[:PlayerMatchRaceRapeBeginEV]
tmpPlayerMatchRaceRapeEndEV = get_character(tmpBiosID).summon_data[:PlayerMatchRaceRapeEndEV]
tmpPlayerMatchLosPlayedOP = get_character(tmpBiosID).summon_data[:PlayerMatchLosPlayedOP]

tmpPlayerMatchLosChk = tmpPlayedOP == true && tmpMatchEnd == false && tmpPlayerMatch == true

###################################################################################### 若玩家是猜賽者 宣布勝利者為
if tmpPlayerMatchLosChk && !tmpPlayerMatchLosPlayedOP
	portrait_hide
	get_character(tmpBiosID).summon_data[:PlayerMatchLosPlayedOP] = true
	
	$game_map.npcs.any?{|event| 
		next if event.summon_data == nil
		next if event.summon_data[:ArenaTeamID] != tmpPlayerMatchOpp
		next if event.actor.action_state == :death
		event.end_combo_skill
		event.actor.process_target_lost
		event.character_index = event.chs_definition.chs_default_index[event.charset_index]
		event.npc.battle_stat.set_stat_m("sta",1000,[0,2,3])
		cam_follow(event.id,0)
		event.call_balloon(19)
	}
	$game_map.npcs.any?{|event| 
		next if event.summon_data == nil
		next if event.summon_data[:ArenaTeamID] != tmpPlayerMatchOpp
		next if event.actor.action_state == :death
		cam_follow(event.id,0)
		event.call_balloon(19)
		event.actor.play_sound(:sound_alert1,100)
	}
	SndLib.ppl_CheerGroup(100)
	$story_stats["HiddenOPT0"] = $game_text["TagMapNoerArena:name/#{tmpPlayerMatchOpp}"]
	call_msg("TagMapNoerArena:NewMatch/WinnerIS") ; portrait_off
	$story_stats["HiddenOPT0"] = "0"
	
	$game_map.npcs.each do |event| 
		next if event.summon_data == nil
		next if event.summon_data[:ArenaTeamID] != tmpPlayerMatchOpp
		next if event.actor.action_state == :death
		event.unset_chs_sex if event.npc.action_state == :sex
		event.cancel_stun_effect if event.npc.action_state == :stun
		event.actor.cancel_holding if event.npc.action_state == :skill
		event.move_type =0
		event.move_speed = 4
		event.opacity = 255
		event.animation = nil
		event.call_balloon(2)
		event.turn_toward_character($game_player)
		event.npc_story_mode(true)
	end	
	$game_map.npcs.each do |event| 
		next if event.summon_data == nil
		next if event.summon_data[:ArenaTeamID] != tmpPlayerMatchOpp
		next if event.actor.action_state == :death
		event.call_balloon(1)
	end
	5.times{
		$game_map.npcs.each do |event| 
			next if event.summon_data == nil
			next if event.summon_data[:ArenaTeamID] != tmpPlayerMatchOpp
			next if event.actor.action_state == :death
			event.move_speed  = 3.5
			event.move_goto_xy($game_player.x,$game_player.y)
		end
		wait(15)
	}
	#units jump to Lona
	SndLib.sys_equip
	$game_map.npcs.each do |event| 
		next if event.summon_data == nil
		next if event.summon_data[:ArenaTeamID] != tmpPlayerMatchOpp
		next if event.actor.action_state == :death
		event.move_type = 0
		event.manual_move_type = 0
		tmpX,tmpY = $game_player.get_item_jump_xy
		event.jump_to(tmpX,tmpY)
		event.turn_toward_character($game_player)
		wait(5)
	end
	wait(15)
	
	
	call_msg("TagMapNoerArena:PlayerMatch/LostRngRape0") ; portrait_hide
	$game_map.npcs.each do |event| 
		next if event.summon_data == nil
		next if event.summon_data[:ArenaTeamID] != tmpPlayerMatchOpp
		next if event.actor.action_state == :death
		event.call_balloon(5)
		event.turn_toward_character($game_player)
	end	
	wait(30)
	call_msg("TagMapNoerArena:PlayerMatch/LostRngRapeTorture") ; portrait_hide
	call_msg("common:Lona/NapRape3") ; portrait_hide
	3.times{
		$game_map.npcs.each do |event| 
			next if event.summon_data == nil
			next if event.summon_data[:ArenaTeamID] != tmpPlayerMatchOpp
			next if event.actor.action_state == :death
			next if !event.near_the_target?($game_player, 3)
			event.turn_toward_character($game_player)
			event.actor.play_sound(:sound_skill,100) if rand(100) >= 80
			rand(100) > 50 ? event.set_animation("animation_atk_sh") : event.set_animation("animation_atk_mh")
		end	
		$game_player.actor.hit_effect_mood_fix
		lona_mood "p5sta_damage"
		$game_player.actor.portrait.shake
		SndLib.sound_punch_hit(80)
		wait(25+rand(10))
	}
	rape_loop_drop_item(tmpEquip=false,tmpSummon=false,lostItem=false) # 將物品丟到箱子裡
	chcg_set_all_race(tmpPlayerMatchRace)
	load_script("Data/#{tmpPlayerMatchRaceRapeBeginEV}")
	whole_event_end
	check_over_event
	check_half_over_event
	
	$game_map.npcs.each do |event| 
		next if event.summon_data == nil
		next if event.summon_data[:ArenaTeamID] != tmpPlayerMatchOpp
		next if event.actor.action_state == :death
		event.npc_story_mode(false)
	end	
	call_msg("common:Lona/cuff_on#{talk_style}") ; portrait_hide
	####################################################### 性獸特別專區
	if tmpPlayerMatchOpp == "ArenaSexBeast"
		call_msg("TagMapNoerArena:SexBeast/Lose0_#{rand(3)}")
		SndLib.MaleWarriorGruntSpot(100)
		call_msg("TagMapNoerArena:SexBeast/Lose1")
		chcg_set_all_race(tmpPlayerMatchRace)
		load_script("Data/#{tmpPlayerMatchRaceRapeEndEV}")
		whole_event_end
		check_over_event
		check_half_over_event
		SndLib.MaleWarriorGruntSpot(100)
		call_msg("TagMapNoerArena:SexBeast/Lose2")
		call_msg("TagMapNoerArena:firstTime/firstMatch22_1")
		cam_center(0)
	end
end

do_ret = false
no_more_until = nil
until do_ret
	tmp_fucker_id = nil
	if tmpPlayerMatchLosChk
		$game_map.npcs.any?{|event|
			next if event.summon_data == nil
			next if event.summon_data[:NapFucker] == nil
			next if !event.summon_data[:NapFucker]
			next if !event.near_the_target?($game_player,10) #競技中距離為10
			next if event.opacity != 255
			next if event.actor.action_state == :death
			event.summon_data[:NapFucker] = false
			tmp_fucker_id = event.id
		}
	else
		tmpFuckerNPCs = $game_map.npcs.select{|event| 
			next if event.summon_data == nil
			next if event.summon_data[:NapFucker] == nil
			next if !event.summon_data[:NapFucker]
			next if event.actor.action_state != nil && event.actor.action_state !=:none
			next if !event.near_the_target?($game_player,4)
			next if !event.actor.target.nil?
			next if event.opacity != 255
			next if event.actor.sensors[0].get_signal(event,$game_player)[2] <=15 
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
		
	end
	tmpReward = 0
	
	break if !tmp_fucker_id
	########################################################################################################################################## NAP
	########################################################################################################################################## NAP
	########################################################################################################################################## NAP
	########################################################################################################################################## NAP
	########################################################################################################################################## NAP
	########################################################################################################################################## NAP
	########################################################################################################################################## NAP
	########################################################################若是玩家競技中 
	if tmp_fucker_id != nil && tmpPlayerMatchLosChk
		$story_stats["DreamPTSD"] = "Bandit" if $game_player.actor.mood <= -50
		SndLib.ppl_CheerGroup(100)
		get_character(tmp_fucker_id).setup_audience
		tmpB4X = get_character(tmp_fucker_id).x
		tmpB4Y = get_character(tmp_fucker_id).y
		get_character(tmp_fucker_id).move_type =0
		get_character(tmp_fucker_id).opacity = 255
		get_character(tmp_fucker_id).animation = nil
		get_character(tmp_fucker_id).call_balloon(2)
		get_character(tmp_fucker_id).turn_toward_character($game_player)
	
		get_character(tmp_fucker_id).npc_story_mode(true,false)
		get_character(tmp_fucker_id).move_goto_xy($game_player.x,$game_player.y)
		wait(20)
		get_character(tmp_fucker_id).jump_to($game_player.x,$game_player.y)
		get_character(tmp_fucker_id).turn_toward_character($game_player)
		get_character(tmp_fucker_id).item_jump_to
		get_character(tmp_fucker_id).turn_toward_character($game_player)
		wait(15)
		get_character(tmp_fucker_id).call_balloon(4)
		get_character(tmp_fucker_id).npc_story_mode(false,false)
		get_character(tmp_fucker_id).turn_toward_character($game_player)
		get_character(tmp_fucker_id).actor.play_sound(:sound_alert2,100)
		wait(30)
		goto_sex_point_with_character(get_character(tmp_fucker_id),nil)
		get_character(tmp_fucker_id).actor.play_sound(:sound_alert2,100)
		call_msg("TagMapNoerArena:PlayerMatch/LostRngRape1")
		call_msg("common:Lona/NapRape_noSta")
		get_character(tmp_fucker_id).actor.play_sound(:sound_alert2,100)
		
	
		play_sex_service_menu(get_character(tmp_fucker_id),0,nil,true)
		get_character(tmp_fucker_id).jump_to(tmpB4X,tmpB4Y)
		get_character(tmp_fucker_id).turn_toward_character($game_player)
		wait(10)
		get_character(tmp_fucker_id).moveto($game_player.x,$game_player.y)
		get_character(tmp_fucker_id).move_type =0
		get_character(tmp_fucker_id).npc_story_mode(true,false)
		get_character(tmp_fucker_id).item_jump_to
		get_character(tmp_fucker_id).turn_toward_character($game_player)
		get_character(tmp_fucker_id).set_animation("animation_masturbation")
		wait(30)
		break
	elsif tmp_fucker_id != nil && !$game_map.threat
		$story_stats["DreamPTSD"] = "Bandit"
		get_character(tmp_fucker_id).setup_audience
		tmpB4X = get_character(tmp_fucker_id).x
		tmpB4Y = get_character(tmp_fucker_id).y
		get_character(tmp_fucker_id).move_type =0
		get_character(tmp_fucker_id).opacity = 255
		get_character(tmp_fucker_id).animation = nil
		get_character(tmp_fucker_id).call_balloon(2)
		get_character(tmp_fucker_id).turn_toward_character($game_player)
		call_msg("TagMapNoerTavern:CommonPPL/NapRape")
		get_character(tmp_fucker_id).npc_story_mode(true,false)
		wait(80)
		3.times{
			get_character(tmp_fucker_id).move_goto_xy($game_player.x,$game_player.y)
			wait(35)
		}
		get_character(tmp_fucker_id).call_balloon(4)
		get_character(tmp_fucker_id).npc_story_mode(false,false)
		get_character(tmp_fucker_id).turn_toward_character($game_player)
		call_msg("TagMapNoerTavern:CommonPPL/NapRape1")
		call_msg("TagMapNoerTavern:CommonPPL/NapRape2")
		goto_sex_point_with_character(get_character(tmp_fucker_id),"rand",tmpMoveToCharAtEnd=false)
		do_ret = false
		$game_player.turn_toward_character(get_character(tmp_fucker_id))
		$game_player.call_balloon(0)
		$game_player.animation = nil
		call_msg("common:Lona/NapRape3")
		get_character(tmp_fucker_id).call_balloon(20)
		call_msg("TagMapNoerTavern:CommonPPL/NapRape3")
		if $game_player.actor.sta > 0
			call_msg("common:Lona/NapRape_withSta") #\optD[我是便器<t=3>,反抗]
			do_ret = false
			case $game_temp.choice
				when 0
					call_msg("common:Lona/NapRape_withSta_NoFight1#{talk_persona}")
					call_msg("TagMapNoerTavern:CommonPPL/NapRape_withSta_NoFight2")
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
					call_msg("TagMapNoerTavern:CommonPPL/NapRape_withSta_Fight2")
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
		get_character(tmp_fucker_id).actor.process_target_lost
		$game_player.animation = $game_player.animation_stun
	end
end #until

#############################################################################################	 NAP
#############################################################################################	 NAP
#############################################################################################	 NAP
#############################################################################################	 NAP
#############################################################################################	 NAP
#############################################################################################	 NAP
#############################################################################################			 競技完成 睡覺區塊 對手女奴版
if tmp_fucker_id == nil && tmpPlayerMatchLosChk && tmpPlayerMatchOpp == "ArenaTeamRBQ" && tmpPlayerMatchOpp != "GameOver"
	$story_stats["DreamPTSD"] = "Bandit" if $game_player.actor.mood <= -50
	get_character(tmpBiosID).summon_data[:PlayerMatchOpp] = "GameOver"
	2.times{
		2.times{
			$game_map.npcs.each do |event| 
				next if event.summon_data == nil
				next if event.summon_data[:ArenaTeamID] != tmpPlayerMatchOpp
				next if event.actor.action_state == :death
				event.npc_story_mode(true)
				next if !event.near_the_target?($game_player, 2)
				event.turn_toward_character($game_player)
				event.actor.play_sound(:sound_skill,100) if rand(100) >= 80
				rand(100) > 50 ? event.set_animation("animation_atk_sh") : event.set_animation("animation_atk_mh")
			end	
			$game_player.actor.hit_effect_mood_fix
			lona_mood "p5sta_damage"
			$game_player.actor.portrait.shake
			SndLib.sound_punch_hit(80)
			wait(25+rand(10))
		}
		chcg_set_all_race(tmpPlayerMatchRace)
		load_script("Data/#{tmpPlayerMatchRaceRapeEndEV}")
		whole_event_end
		check_over_event
		check_half_over_event
	}
	$game_map.npcs.each do |event| 
		next if event.summon_data == nil
		next if event.summon_data[:ArenaTeamID] != tmpPlayerMatchOpp
		next if event.actor.action_state == :death
		event.npc_story_mode(false)
	end	
	chcg_background_color(0,0,0,0,7) ; portrait_hide
	
#############################################################################################			 競技完成 睡覺區塊性獸版
elsif tmp_fucker_id == nil && tmpPlayerMatchLosChk && tmpPlayerMatchOpp == "ArenaSexBeast" && tmpPlayerMatchOpp != "GameOver"
	$story_stats["DreamPTSD"] = "Bandit" if $game_player.actor.mood <= -50
	get_character(tmpBiosID).summon_data[:PlayerMatchOpp] = "GameOver"
	$game_player.actor.sta = 200
	$game_player.animation = nil
	tarEvID = 1
		$game_map.npcs.any?{|event| 
		next if event.summon_data == nil
		next if event.summon_data[:ArenaTeamID] != tmpPlayerMatchOpp
		cam_follow(event.id,0)
		event.npc_story_mode(false)
		event.call_balloon(5)
		event.actor.play_sound(:sound_alert1,100)
		event.animation = nil
		event.moveto($game_player.x,$game_player.y)
		tarEvID = event.id
	}

	call_msg("TagMapNoerArena:PlayerMatch/LostRngRape1")
	call_msg("common:Lona/NapRape_noSta")
	play_sex_service_menu(get_character(tarEvID),0,nil,true)
	
	call_msg("TagMapNoerArena:SexBeast/Lose1")
	call_msg("TagMapNoerArena:SexBeast/Lose2_1")
	portrait_off
	play_sex_service_main(ev_target=get_character(tarEvID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=0)
	half_event_key_cleaner ; SndLib.ppl_CheerGroup(100)
	play_sex_service_main(ev_target=get_character(tarEvID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=0)
	half_event_key_cleaner ; SndLib.ppl_CheerGroup(100)
	play_sex_service_main(ev_target=get_character(tarEvID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=1)
	half_event_key_cleaner ; SndLib.ppl_CheerGroup(100)
	play_sex_service_main(ev_target=get_character(tarEvID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=1)
	half_event_key_cleaner ; SndLib.ppl_CheerGroup(100)
	play_sex_service_main(ev_target=get_character(tarEvID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=1)
	portrait_off
	call_msg("TagMapNoerArena:SexBeast/Lose3")
	half_event_key_cleaner ; SndLib.ppl_CheerGroup(100)
	portrait_off
	play_sex_service_main(ev_target=get_character(tarEvID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=2)
	$game_player.actor.stat["EventVagRace"] =  "Human"
	$game_player.actor.stat["EventVag"] = "CumInside1"
	load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
	$game_player.actor.addCums("CumsCreamPie",1000,"Human")
	$game_player.actor.addCums("CumsCreamPie",1000,"Human")
	portrait_off
	call_msg("TagMapNoerArena:SexBeast/Lose4")
	portrait_off
	play_sex_service_main(ev_target=get_character(tarEvID),temp_tar_slot="anal",passive=true,tmpCumIn=true,forcePose=1,tmpAniStage=1)
	half_event_key_cleaner ; SndLib.ppl_CheerGroup(100)
	play_sex_service_main(ev_target=get_character(tarEvID),temp_tar_slot="anal",passive=true,tmpCumIn=true,forcePose=1,tmpAniStage=1)
	half_event_key_cleaner ; SndLib.ppl_CheerGroup(100)
	play_sex_service_main(ev_target=get_character(tarEvID),temp_tar_slot="anal",passive=true,tmpCumIn=true,forcePose=1,tmpAniStage=2)
	portrait_off
	call_msg("TagMapNoerArena:SexBeast/Lose5")
	portrait_off
	$game_player.actor.stat["EventAnalRace"] =  "Human"
	$game_player.actor.stat["EventAnal"] = "CumInside1"
	load_script("Data/HCGframes/EventAnal_CumInside_Overcum.rb")
	$game_player.actor.addCums("CumsMoonPie",1000,"Human")
	$game_player.actor.addCums("CumsMoonPie",1000,"Human")
	portrait_off
	call_msg("TagMapNoerArena:SexBeast/Lose6")
	portrait_off
	play_sex_service_main(ev_target=get_character(tarEvID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=1)
	half_event_key_cleaner ; SndLib.ppl_CheerGroup(100)
	play_sex_service_main(ev_target=get_character(tarEvID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=1)
	half_event_key_cleaner ; SndLib.ppl_CheerGroup(100)
	play_sex_service_main(ev_target=get_character(tarEvID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=2)
	half_event_key_cleaner ; SndLib.ppl_CheerGroup(100)
	$game_player.actor.stat["EventVagRace"] =  "Human"
	$game_player.actor.stat["EventVag"] = "CumInside1"
	load_script("Data/HCGframes/EventVag_CumInside_Overcum_Peein.rb")
	$game_player.actor.addCums("CumsCreamPie",1000,"Human")
	$game_player.actor.addCums("CumsCreamPie",1000,"Human")
	play_sex_service_main(ev_target=get_character(tarEvID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=0)
	play_sex_service_main(ev_target=get_character(tarEvID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=1)
	play_sex_service_main(ev_target=get_character(tarEvID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=1)
	portrait_off
	call_msg("TagMapNoerArena:SexBeast/Lose7")
	portrait_off
	$game_player.actor.sta = -100
	$game_player.actor.addCums("CumsCreamPie",1000,"Human")
	$game_player.actor.addCums("CumsCreamPie",1000,"Human")
	$game_player.actor.addCums("CumsCreamPie",1000,"Human")
	$game_player.actor.addCums("CumsMoonPie",1000,"Human")
	$game_player.actor.addCums("CumsMoonPie",1000,"Human")
	$game_player.actor.addCums("CumsMoonPie",1000,"Human")
	chcg_background_color(0,0,0,0,7) ; portrait_hide
#############################################################################################			競技完成 其他對手
elsif tmp_fucker_id == nil && tmpPlayerMatchLosChk && tmpPlayerMatchOpp != "GameOver"
	$story_stats["DreamPTSD"] = "Bandit" if $game_player.actor.mood <= -50
	get_character(tmpBiosID).summon_data[:PlayerMatchOpp] = "GameOver"
	chcg_set_all_race(tmpPlayerMatchRace)
	load_script("Data/#{tmpPlayerMatchRaceRapeEndEV}")
	whole_event_end
	check_over_event
	check_half_over_event
	chcg_background_color(0,0,0,0,7) ; portrait_hide
	
#############################################################################################			領取回報
elsif tmp_fucker_id == nil && tmpPlayerMatchLosChk && tmpPlayerMatchOpp == "GameOver" && $story_stats["RapeLoop"] == 0
	call_msg("TagMapNoerArena:PlayerMatch/LostRngRape2") ; portrait_hide
	tmpReward = 2000 - $game_timer.count
	handleNap(:point,@map_id,"StartPointArena")
	tmpReward = 200 if tmpReward < 200
	optain_item_chain(tmpReward,["ItemCoin1","ItemCoin2","ItemCoin3"],false)
	
#############################################################################################			領取回報 但為奴隸
elsif tmp_fucker_id == nil && tmpPlayerMatchLosChk && tmpPlayerMatchOpp == "GameOver" && $story_stats["RapeLoop"] == 1
	#########################時間限定以內  回牢房
	if $game_timer.count <= 5 && $story_stats["RapeLoopTorture"] != 1
		$game_player.actor.record_lona_title = "Arena/SlaveWinner"
		cam_center(0)
		call_msg("TagMapNoerArena:PlayerMatch/LostRngRape2") ; portrait_hide
		change_map_enter_tagSub("NoerArenaB1")
		rape_loop_drop_item(tmpEquip=false,tmpSummon=false)
		change_map_captured_story_stats_fix
		
	#########################時間限定以外  GameOver
	else
		call_msg("TagMapNoerArena:PlayerMatch/LostRngRape2_IfSlave_NotInTime0")
		call_msg("TagMapNoerArena:PlayerMatch/LostRngRape2_IfSlave_NotInTime1") ; portrait_hide
		12.times{
			$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
			SndLib.dogSpot(100) if rand(100) >=60
			SndLib.dogAtk(100) if rand(100) >=60
			SndLib.sound_gore(100)
			SndLib.sound_combat_hit_gore(70)
			wait(20+rand(20))
		}
		chcg_background_color(0,0,0,255)
		$cg.erase
		call_msg("commonEnding:wolf/Eaten")
		return load_script("Data/HCGframes/OverEvent_Death.rb")
	end
#############################################################################################			傳統執行緒
elsif tmp_fucker_id == nil
	tmpBiosID = $game_map.get_storypoint("DualBios")[2]
	tmpArenaPT = get_character(tmpBiosID).summon_data[:HowMuch]
	if tmpArenaPT >= 1 || $game_player.actor.stat["SlaveBrand"] == 1
		$story_stats["RecQuestNoerArena"] = 2 if $story_stats["RecQuestNoerArena"] == 1
		$game_party.lose_item($data_items[123],1) #BetTricket
		call_msg("TagMapNoerArena:Guard/NapSlave0")
		if $game_player.actor.stat["SlaveBrand"] == 1
			call_msg("TagMapNoerArena:Guard/NapSlave1IsSlave")
		else
			call_msg("TagMapNoerArena:Guard/NapSlave1NoPay")
		end
		call_msg("TagMapNoerArena:Guard/NapSlave2")
		rape_loop_drop_item(false,false)
		$story_stats["SlaveOwner"] = "NoerArenaB1"
		$story_stats["OnRegionMapSpawnRace"] = "HumanGuard"
		$game_player.actor.add_state("SlaveBrand") #51
		$story_stats["RapeLoop"] = 1
		$story_stats["Kidnapping"] =1
		$game_player.actor.sta =-100
		$game_player.actor.mood = -100
		region_map_wildness_nap
		
	else
		call_msg("common:Lona/NarrDriveAway")
		$story_stats["TagSubTrans"] = "StartPoint2"
		$story_stats["TagSubForceDir"] = 2
		change_map_enter_tagSub("NoerRing")
		portrait_hide
	end
end
