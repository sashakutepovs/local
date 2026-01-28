if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

tmpWakeUpX,tmpWakeUpY,tmpWakeUpID=$game_map.get_storypoint("WakeUp")
tmpDualBiosX,tmpDualBiosY,tmpDualBiosID=$game_map.get_storypoint("DualBios")

$game_portraits.setLprt("BoboNormal")
$game_portraits.lprt.shake
SndLib.SwineSpot
############################################################沒被抓住 BOBO 離開此地
if ($story_stats["Captured"] == 0 || $story_stats["RapeLoop"] == 0) && $story_stats["RecQuestPigBobo"] == 0
	get_character(0).call_balloon(0)
	get_character(0).animation = nil
	call_msg("CompPigBobo:PigBoboQu0/WhenPlayerNotCap0") ; portrait_hide
	get_character(0).npc_story_mode(true)
	$game_portraits.setLprt("BoboYell")
	$game_portraits.lprt.shake
	2.times{
		get_character(0).jump_to(get_character(0).x,get_character(0).y)
		get_character(0).call_balloon(4)
		SndLib.SwineAtk
		wait(20)
	}
	wait(20)
	$game_portraits.lprt.fade
	get_character(0).animation = get_character(0).animation_grabber_qte($game_player)
	$game_player.animation = $game_player.animation_grabbed_qte
	SndLib.sound_equip_armor(100)
	portrait_hide
	call_msg("CompPigBobo:PigBoboQu0/WhenPlayerNotCap1") ; portrait_hide
	$game_portraits.setLprt("BoboNormal")
	$game_portraits.lprt.shake
	2.times{
		$game_portraits.setLprt("BoboYell")
		$game_portraits.lprt.shake
		get_character(0).animation = get_character(0).animation_grabber_qte($game_player)
		SndLib.sound_chs_dopyu(100)
		SndLib.SwineSpot
		wait(30)
		get_character(0).animation = nil
		wait(10)
	}
	$game_player.animation = nil
	$game_portraits.lprt.fade
	call_msg("CompPigBobo:PigBoboQu0/WhenPlayerNotCap2") ; portrait_hide
	SndLib.SwineAtk
	get_character(0).call_balloon(4)
	$game_portraits.setLprt("BoboNormal")
	$game_portraits.lprt.shake
	wait(60)
	$game_portraits.lprt.fade
	call_msg("CompPigBobo:PigBoboQu0/WhenPlayerNotCap3") ; portrait_hide
	get_character(0).set_manual_move_type(2)
	get_character(0).move_type = 2
	get_character(0).set_this_event_follower
	$story_stats["RecQuestPigBobo"] = 2
	get_character(0).npc_story_mode(false)
	$game_portraits.setLprt("BoboNormal")
	$game_portraits.lprt.fade
	SndLib.SwineAtk(100)
	get_character(0).call_balloon(4)
	return
end
if !get_character(tmpWakeUpID).summon_data[:job]
	if get_character(tmpDualBiosID).summon_data[:fuckedDate] >= 1 && get_character(tmpDualBiosID).summon_data[:PigTalked] == 0
		 get_character(tmpDualBiosID).summon_data[:PigTalked] = 1
		get_character(0).animation = nil
		get_character(0).npc_story_mode(true)
		2.times{
			get_character(0).jump_to(get_character(0).x,get_character(0).y)
			get_character(0).call_balloon(20)
			SndLib.SwineAtk
			wait(20)
		}
		call_msg("CompPigBobo:PigBoboQu0/begin0")
		get_character(0).animation = get_character(0).animation_grabber_qte($game_player)
		$game_player.animation = $game_player.animation_grabbed_qte
		SndLib.sound_equip_armor(100)
		call_msg("CompPigBobo:PigBoboQu0/begin1") ; portrait_hide
		get_character(0).animation = nil
		2.times{
			get_character(0).animation = get_character(0).animation_grabber_qte($game_player)
			SndLib.sound_chs_dopyu(100)
			SndLib.SwineSpot
			wait(30)
			get_character(0).animation = nil
			wait(10)
		}
		$game_player.animation = nil
		call_msg("CompPigBobo:PigBoboQu0/begin2")
		call_msg("CompPigBobo:PigBoboQu0/begin3")
		get_character(0).call_balloon(28,-1)
		get_character(0).npc_story_mode(false)
		################################################################################################################################## BOBO表示幫忙
	elsif get_character(tmpDualBiosID).summon_data[:fuckedDate] >= 1 && get_character(tmpDualBiosID).summon_data[:PigTalked] >= 1
		get_character(0).animation = nil
		get_character(0).npc_story_mode(true)
		2.times{
			get_character(0).jump_to(get_character(0).x,get_character(0).y)
			get_character(0).call_balloon(20)
			SndLib.SwineSpot
			wait(20)
		}
		call_msg("CompPigBobo:PigBoboQu0/follower_0")
		call_msg("CompPigBobo:PigBoboQu0/follower_1")
		call_msg("common:Lona/Decide_optB")
		if $game_temp.choice == 1 ################################################################# 接受BOBO的任務
			$story_stats["RecQuestPigBobo"] = 1
			call_msg("CompPigBobo:PigBoboQu1/accept0")
			get_character(0).jump_to(get_character(0).x,get_character(0).y)
			get_character(0).call_balloon(4)
			get_character(0).animation = get_character(0).animation_grabber_qte($game_player)
			$game_player.animation = $game_player.animation_grabbed_qte
			SndLib.sound_equip_armor(100)
			SndLib.sound_step_chain(100)

			######################## remove all Bondage Equip
			tmpChkBondageList = []
			$game_player.actor.equips.each{|tmpEQP|
				next if !tmpEQP
				next if !tmpEQP.type_tag
				next if tmpEQP.type_tag != "Bondage"
				tmpChkBondageList << tmpEQP.etype_id
			}
			tmpChkBondageList.each{|tmpEQP_id|
				$game_player.actor.change_equip(tmpEQP_id, nil)
			}

			call_msg("CompPigBobo:PigBoboQu0/begin4") ; portrait_hide
			get_character(0).animation = nil
			$game_player.animation = nil
			SndLib.SwineAtk
			wait(60)
			tmpG1X,tmpG1Y,tmpG1ID = $game_map.get_storypoint("Gate1")
			SndLib.sound_equip_armor(100)
			get_character(0).jump_to(tmpG1X,tmpG1Y-1) ; get_character(0).direction = 2
			wait(30)
			$game_player.turn_toward_character(get_character(0))
			4.times{
				get_character(0).animation = get_character(0).animation_atk_mh
				SndLib.SwineAtk
				wait(7)
				SndLib.sys_close(100,170)
				SndLib.sound_punch_hit(100,90)
				get_character(tmpG1ID).forced_y += 1
				get_character(tmpG1ID).angle += 3
				wait(30)
			}
			get_character(0).animation = get_character(0).animation_atk_mh
			SndLib.SwineAtk
			wait(7)
			SndLib.sys_close(100,170)
			SndLib.sound_punch_hit(100,90)
			10.times{
				get_character(tmpG1ID).forced_y += 30
				wait(1)
			}
			get_character(tmpG1ID).moveto(1,1)
			SndLib.stoneCollapsed(100)
			get_character(tmpG1ID).switch1_id += 999
			get_character(tmpG1ID).moveto(1,1)
				get_character(tmpG1ID).forced_y = 0
				get_character(tmpG1ID).angle = 0
			wait(60)
			get_character(0).turn_toward_character($game_player)
			get_character(0).call_balloon(4)
			$game_portraits.setLprt("BoboYell")
			$game_portraits.lprt.shake
			SndLib.SwineAtk(100)
			get_character(0).call_balloon(4)
			wait(40)
			call_msg("CompPigBobo:PigBoboQu1/accept1")
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				portrait_off
				$game_player.record_companion_name_front = "UniquePigBobo"
				$game_player.record_companion_front_date = $game_date.dateAmt+1
				get_character(0).moveto(1,1)
				$story_stats["Captured"] = 0
				wait(1)
				EvLib.sum("UniquePigBobo",tmpG1X,tmpG1Y-1)
				wait(1)
				$story_stats["Captured"] = 1
				
			chcg_background_color(0,0,0,255,-7)
		else
			get_character(0).call_balloon(28,-1)
		end
		get_character(0).npc_story_mode(false)
	end
	portrait_off
	return eventPlayEnd
end
tmpGuard1X,tmpGuard1Y,tmpGuard1ID = $game_map.get_storypoint("guard1")
tmpGuard2X,tmpGuard2Y,tmpGuard2ID = $game_map.get_storypoint("guard2")
tmpGuard3X,tmpGuard3Y,tmpGuard3ID = $game_map.get_storypoint("guard3")
tmpGuard4X,tmpGuard4Y,tmpGuard4ID = $game_map.get_storypoint("guard4")
tmpPiggyX,tmpPiggyY,tmpPiggyID = $game_map.get_storypoint("Piggy")
tmpG1X,tmpG1Y,tmpG1ID = $game_map.get_storypoint("Gate1")
tmpGuard1OD = get_character(tmpGuard1ID).direction
tmpGuard2OD = get_character(tmpGuard2ID).direction
tmpGuard3OD = get_character(tmpGuard3ID).direction
tmpGuard4OD = get_character(tmpGuard4ID).direction
get_character(0).move_type = 1
get_character(0).set_manual_move_type(1)
get_character(0).animation = nil
get_character(0).call_balloon(0)
call_msg("TagMapBanditCamp2:RapeLoop/DailyJob_PlayBegin0") #\optD[算了,決定]
if $game_temp.choice == 1
	$story_stats["RecQuestPigBoboMated"] += 1
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(0).moveto(tmpPiggyX,tmpPiggyY)
		get_character(0).direction = 6
		$game_player.moveto(tmpPiggyX+1,tmpPiggyY)
		$game_player.direction = 4
	chcg_background_color(0,0,0,255,-7)
	2.times{
		tmpBalloon = [3,4,20].sample
		tmpCharID = [tmpGuard1ID,tmpGuard2ID,tmpGuard3ID,tmpGuard4ID].sample
		cam_follow(tmpCharID,0)
		get_character(tmpCharID).call_balloon(tmpBalloon)
		call_msg("TagMapBanditCamp2:RapeLoop/DailyJob_EndRng#{rand(9)}") ; cam_center(0)
	}
	get_character(0).npc_story_mode(true)
	get_character(0).move_type = 0
	case get_character(tmpWakeUpID).summon_data[:job]
		when "Dance"
			$game_player.direction = 2
			call_msg("TagMapBanditCamp2:RapeLoop/DailyJob_PlayDance0")
			$game_player.animation = $game_player.animation_dance
			4.times{
				wait(60)
				SndLib.sound_equip_armor(100)
				lona_mood "p5shame"
				$game_player.actor.portrait.shake
				wait(60)
				SndLib.sound_equip_armor(100)
				lona_mood "p5shame"
				$game_player.actor.portrait.shake
				tmpBalloon = [3,4,20].sample
				tmpCharID = [tmpGuard1ID,tmpGuard2ID,tmpGuard3ID,tmpGuard4ID].sample
				cam_follow(tmpCharID,0)
				get_character(tmpCharID).call_balloon(tmpBalloon)
				$game_player.actor.sta -= 10
				call_msg("TagMapBanditCamp2:RapeLoop/DailyJob_EndRng#{rand(9)}")
				cam_center(0)
			}
			$game_portraits.setLprt("BoboNormal")
			$game_portraits.lprt.fade
			SndLib.SwineAtk(100)
			get_character(0).call_balloon(8)
			$game_player.direction = 4
			wait(60)
		
		when "Anal"
			wait(50)
			$game_portraits.setLprt("BoboNormal")
			$game_portraits.lprt.shake
			SndLib.SwineAtk(100)
			wait(40)
			$game_portraits.lprt.fade
			call_msg("TagMapBanditCamp2:RapeLoop/DailyJob_PlayBegin1")
			get_character(0).moveto($game_player.x,$game_player.y)
			wait(50)
			$game_portraits.setLprt("BoboYell")
			$game_portraits.lprt.shake
			SndLib.SwineAtk(100)
			wait(40)
			$game_portraits.lprt.fade
			call_msg("TagMapBanditCamp2:RapeLoop/DailyJob_PlayAnal0")
			portrait_hide
			wait(10)
			portrait_off
			play_sex_service_main(ev_target=get_character(0),temp_tar_slot="anal",passive=true,tmpCumIn=true,forcePose=1,tmpAniStage=2) ; get_character(0).force_update = true
			SndLib.SwineAtk
			half_event_key_cleaner
			play_sex_service_main(ev_target=get_character(0),temp_tar_slot="anal",passive=true,tmpCumIn=true,forcePose=1,tmpAniStage=0) ; get_character(0).force_update = true
			SndLib.SwineAtk
			half_event_key_cleaner
			play_sex_service_main(ev_target=get_character(0),temp_tar_slot="anal",passive=true,tmpCumIn=true,forcePose=1,tmpAniStage=1) ; get_character(0).force_update = true
			SndLib.SwineAtk
			half_event_key_cleaner
			$game_player.actor.stat["EventAnalRace"] =  "Others"
			$game_player.actor.stat["EventAnal"] = "CumInside1"
			chcg_decider_basic(pose=5)
			$game_player.actor.addCums("CumsMoonPie",700,"Others")
			SndLib.SwineAtk
			load_script("Data/HCGframes/EventAnal_CumInside_Overcum.rb")
			SndLib.SwineAtk
			portrait_off
			whole_event_end
			$game_portraits.setLprt("BoboNormal")
			$game_portraits.lprt.fade
			SndLib.SwineAtk(100)
			get_character(0).call_balloon(4)
			wait(10)
			
		when "Mouth"
			$game_portraits.setLprt("BoboNormal")
			$game_portraits.lprt.shake
			SndLib.SwineAtk(100)
			wait(40)
			$game_portraits.lprt.fade
			call_msg("TagMapBanditCamp2:RapeLoop/DailyJob_PlayBegin1")
			get_character(0).moveto($game_player.x,$game_player.y)
			wait(50)
			$game_portraits.setLprt("BoboYell")
			$game_portraits.lprt.shake
			SndLib.SwineAtk(100)
			wait(40)
			$game_portraits.lprt.fade
			call_msg("TagMapBanditCamp2:RapeLoop/DailyJob_PlayMouth0")
			portrait_hide
			wait(10)
			portrait_off
			play_sex_service_main(ev_target=get_character(0),temp_tar_slot="mouth",passive=true,tmpCumIn=true,forcePose=2,tmpAniStage=2) ; get_character(0).force_update = true
			SndLib.SwineAtk
			half_event_key_cleaner
			play_sex_service_main(ev_target=get_character(0),temp_tar_slot="mouth",passive=true,tmpCumIn=true,forcePose=2,tmpAniStage=0) ; get_character(0).force_update = true
			SndLib.SwineAtk
			half_event_key_cleaner
			play_sex_service_main(ev_target=get_character(0),temp_tar_slot="mouth",passive=true,tmpCumIn=true,forcePose=2,tmpAniStage=1) ; get_character(0).force_update = true
			SndLib.SwineAtk
			half_event_key_cleaner
			$game_player.actor.stat["EventMouthRace"] =  "Others"
			$game_player.actor.stat["EventMouth"] = "CumInside1"
			chcg_decider_basic(pose=5)
			SndLib.SwineAtk
			load_script("Data/HCGframes/EventMouth_CumInside_Overcum.rb")
			SndLib.SwineAtk
			portrait_off
			whole_event_end
			$game_portraits.setLprt("BoboNormal")
			$game_portraits.lprt.fade
			SndLib.SwineAtk(100)
			get_character(0).call_balloon(4)
			wait(10)
		
		when "RimJob"
			$game_portraits.setLprt("BoboNormal")
			$game_portraits.lprt.shake
			SndLib.SwineAtk(100)
			wait(40)
			$game_portraits.lprt.fade
			call_msg("TagMapBanditCamp2:RapeLoop/DailyJob_PlayBegin1")
			get_character(0).moveto($game_player.x,$game_player.y)
			wait(50)
			$game_portraits.setLprt("BoboYell")
			$game_portraits.lprt.shake
			SndLib.SwineAtk(100)
			wait(40)
			$game_portraits.lprt.fade
			call_msg("TagMapBanditCamp2:RapeLoop/DailyJob_PlayRimJob0")
			portrait_hide
			wait(10)
			portrait_off
			get_character(0).moveto($game_player.x-1,$game_player.y)
			get_character(0).move_type = 0
			get_character(0).set_manual_move_type(0)
			get_character(0).npc_story_mode(true)
			
			get_character(0).forced_z = 10
			get_character(0).direction = 4
			tmpAniDataMC1 = [[9,1, 20,-2,-3],
							[10,1,10,-3,-2],
							[11,1,5,-4,-3]
			]
			tmpAniDataPig1 =	[
								[6,5,20,-5,-1],
								[6,5,10,-6,0],
								[6,5,5,-7,-1]
			]
			$game_player.animation = $game_player.aniCustom(tmpAniDataMC1,-1)
			get_character(0).animation = get_character(0).aniCustom(tmpAniDataPig1,-1)
			5.times{
				$game_player.actor.sta -= 1
				if rand(100) >= 60
					$game_portraits.setLprt("BoboYell")
					$game_portraits.lprt.shake
					SndLib.SwineAtk(100)
					get_character(0).call_balloon(4)
				end
				lona_mood "p5sta_damage"
				$game_player.actor.portrait.shake
				$game_player.actor.dirt += rand(3)+8
				$game_player.actor.puke_value_normal += rand(100)
				SndLib.sound_chs_buchu(100)
				wait(70)
				$game_portraits.setLprt("BoboNormal")
				$game_portraits.lprt.fade
				}
			call_msg("TagMapBanditCamp2:RapeLoop/DailyJob_PlayRimJob1")
			call_msg("TagMapBanditCamp2:RapeLoop/DailyJob_PlayRimJob2") if rand(100) >= 60
			1.times{
				tmpBalloon = [3,4,20].sample
				tmpCharID = [tmpGuard1ID,tmpGuard2ID,tmpGuard3ID,tmpGuard4ID].sample
				cam_follow(tmpCharID,0)
				get_character(tmpCharID).call_balloon(tmpBalloon)
				call_msg("TagMapBanditCamp2:RapeLoop/DailyJob_EndRng#{rand(9)}") ; cam_center(0)
			}
			tmpAniDataMC2 = [[9,1,10,-2,-3],
							[10,1,5,-3,-2],
							[11,1,2,-4,-3]
			]
			tmpAniDataPig2 =	[
								[6,5,10,-5,-1],
								[6,5,5,-6,-0],
								[6,5,2,-7,-1]
			]
			$game_player.animation = $game_player.aniCustom(tmpAniDataMC2,-1)
			get_character(0).animation = get_character(0).aniCustom(tmpAniDataPig2,-1)
			10.times{
				$game_player.actor.sta -= 1
				if rand(100) >= 60
					$game_portraits.setLprt("BoboYell")
					$game_portraits.lprt.shake
					SndLib.SwineAtk(100)
					get_character(0).call_balloon(4)
				end
				lona_mood "p5sta_damage"
				$game_player.actor.portrait.shake
				$game_player.actor.dirt += rand(3)+8
				$game_player.actor.puke_value_normal += rand(100)
				SndLib.sound_chs_buchu(100)
				wait(34)
				$game_portraits.setLprt("BoboNormal")
				$game_portraits.lprt.fade
			}
			1.times{
				tmpBalloon = [3,4,20].sample
				tmpCharID = [tmpGuard1ID,tmpGuard2ID,tmpGuard3ID,tmpGuard4ID].sample
				cam_follow(tmpCharID,0)
				get_character(tmpCharID).call_balloon(tmpBalloon)
				call_msg("TagMapBanditCamp2:RapeLoop/DailyJob_EndRng#{rand(9)}") ; cam_center(0)
			}
			checkOev_CumsSwallow
			get_character(0).forced_z = 0
			$game_player.animation = nil
			get_character(0).animation = nil
			get_character(0).npc_story_mode(false)
			get_character(0).direction = 6
			get_character(0).call_balloon(4)
			$game_portraits.setLprt("BoboNormal")
			$game_portraits.lprt.fade
			SndLib.SwineAtk(100)
			get_character(0).call_balloon(4)
			wait(10)
	end
	2.times{
		tmpBalloon = [3,4,20].sample
		tmpCharID = [tmpGuard1ID,tmpGuard2ID,tmpGuard3ID,tmpGuard4ID].sample
		cam_follow(tmpCharID,0)
		get_character(tmpCharID).call_balloon(tmpBalloon)
		call_msg("TagMapBanditCamp2:RapeLoop/DailyJob_EndRng#{rand(9)}") ; cam_center(0)
	}
	###############################################lust  todo
			$game_player.unset_event_chs_sex
			get_character(0).unset_event_chs_sex
			get_character(0).turn_toward_character($game_player)
			get_character(0).jump_to($game_player.x-1,$game_player.y)
			get_character(0).direction = 6
			SndLib.SwineSpot
			get_character(0).call_balloon(4)
			wait(50)
			$game_portraits.setLprt("BoboYell")
			$game_portraits.lprt.shake
			SndLib.SwineAtk(100)
			wait(40)
			portrait_hide
			wait(10)
			call_msg("TagMapBanditCamp2:RapeLoop/DailyJob5") ; portrait_hide
			SndLib.sound_punch_hit(80)
			get_character(0).animation = get_character(0).animation_grabber_qte($game_player)
			$game_player.animation = $game_player.animation_grabbed_qte
			wait(8)
			$game_portraits.setLprt("BoboYell")
			$game_portraits.lprt.shake
			SndLib.SwineAtk(100)
			wait(40)
			portrait_hide
			wait(10)
			call_msg("TagMapBanditCamp2:RapeLoop/DailyJob6") ; portrait_hide
			$game_portraits.setLprt("BoboNormal")
			$game_portraits.lprt.fade
			get_character(0).call_balloon(8)
			2.times{
				tmpBalloon = [3,4,20].sample
				tmpCharID = [tmpGuard1ID,tmpGuard2ID,tmpGuard3ID,tmpGuard4ID].sample
				cam_follow(tmpCharID,0)
				get_character(tmpCharID).call_balloon(tmpBalloon)
				$game_portraits.lprt.fade
				call_msg("TagMapBanditCamp2:RapeLoop/DailyJob_EndRng#{rand(9)}") ; cam_center(0)
			}
			cam_center(0)
			get_character(0).animation = get_character(0).animation_atk_heavy ; wait(5) ; SndLib.SwineAtk ; wait(5)
			$game_player.animation = $game_player.animation_stun
			SndLib.sound_punch_hit(100)
			lona_mood "p5crit_damage"
			$game_player.actor.portrait.shake
			$game_player.jump_to($game_player.x,$game_player.y)
			$game_player.direction = 2
			$game_portraits.setLprt("BoboYell")
			$game_portraits.lprt.shake
			SndLib.SwineAtk(100)
			call_msg("!!!!!!!!!!")
			$game_portraits.setLprt("BoboYell")
			$game_portraits.lprt.shake
			SndLib.SwineAtk(100)
			wait(40)
			call_msg("TagMapBanditCamp2:RapeLoop/DailyJob7") ; portrait_hide ; cam_center(0)
			get_character(0).animation = get_character(0).animation_grabber_qte($game_player)
			SndLib.sound_punch_hit(80)
			wait(60)
			tmpPose = [0,4].sample
			$game_player.animation = 0
			get_character(0).moveto($game_player.x,$game_player.y)
			play_sex_service_main(ev_target=get_character(0),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=tmpPose,tmpAniStage=2) ; get_character(0).force_update = true ; SndLib.SwineAtk
			half_event_key_cleaner
			play_sex_service_main(ev_target=get_character(0),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=tmpPose,tmpAniStage=0) ; get_character(0).force_update = true ; SndLib.SwineAtk
			half_event_key_cleaner
			play_sex_service_main(ev_target=get_character(0),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=tmpPose,tmpAniStage=1) ; get_character(0).force_update = true ; SndLib.SwineAtk
			half_event_key_cleaner
			$game_player.actor.stat["EventVagRace"] =  "Others"
			$game_player.actor.stat["EventVag"] = "CumInside1"
			SndLib.SwineAtk
			tmpPose == 0 ? chcg_decider_basic_vag(pose=3) : chcg_decider_basic_vag(pose=1)
			portrait_off
			load_script("Data/HCGframes/EventVag_CumInside_OvercumStay.rb")
			SndLib.SwineAtk
			$game_player.actor.addCums("CumsCreamPie",350,"Others")
			portrait_off
			tmpCharID = [tmpGuard1ID,tmpGuard2ID,tmpGuard3ID,tmpGuard4ID].sample
			get_character(tmpCharID).npc_story_mode(true)
			get_character(tmpCharID).animation = get_character(tmpCharID).animation_masturbation
			2.times{
				tmpBalloon = [3,4,20].sample
				tmpCharID = [tmpGuard1ID,tmpGuard2ID,tmpGuard3ID,tmpGuard4ID].sample
				cam_follow(tmpCharID,0)
				get_character(tmpCharID).call_balloon(tmpBalloon)
				$game_portraits.lprt.fade
				call_msg("TagMapBanditCamp2:RapeLoop/DailyJob_EndRng#{rand(9)}") ; cam_center(0)
			}
			portrait_off
			$game_portraits.setLprt("BoboNormal")
			$game_portraits.lprt.shake
			SndLib.SwineAtk(100)
			wait(40)
			portrait_hide
			wait(10)
			portrait_off
			play_sex_service_main(ev_target=get_character(0),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=tmpPose,tmpAniStage=1) ; get_character(0).force_update = true ; SndLib.SwineAtk
			half_event_key_cleaner
			$game_portraits.setLprt("BoboYell")
			$game_portraits.lprt.shake
			SndLib.SwineAtk(100)
			wait(40)
			portrait_hide
			wait(10)
			portrait_off
			play_sex_service_main(ev_target=get_character(0),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=tmpPose,tmpAniStage=1) ; get_character(0).force_update = true ; SndLib.SwineAtk
			half_event_key_cleaner
			$game_portraits.setLprt("BoboNormal")
			$game_portraits.lprt.shake
			SndLib.SwineAtk(100)
			wait(40)
			portrait_hide
			wait(10)
			portrait_off
			play_sex_service_main(ev_target=get_character(0),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=tmpPose,tmpAniStage=1) ; get_character(0).force_update = true ; SndLib.SwineAtk
			half_event_key_cleaner
			$game_portraits.setLprt("BoboYell")
			$game_portraits.lprt.shake
			SndLib.SwineAtk(100)
			wait(40)
			portrait_hide
			wait(10)
			portrait_off
			$game_player.actor.stat["EventVagRace"] =  "Others"
			$game_player.actor.stat["EventVag"] = "CumInside1"
			SndLib.SwineAtk
			tmpPose == 0 ? chcg_decider_basic_vag(pose=3) : chcg_decider_basic_vag(pose=1)
			load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
			SndLib.SwineAtk
			portrait_off
			rand(3).times{
				call_msg("CompPigBobo:UniquePigBobo/Extension3_loop")
				play_sex_service_main(ev_target=get_character(0),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=tmpPose,tmpAniStage=2) ; get_character(0).force_update = true ; SndLib.SwineAtk
				half_event_key_cleaner
				$game_player.actor.stat["EventVagRace"] =  "Others"
				$game_player.actor.stat["EventVag"] = "CumInside1"
				SndLib.SwineAtk
				load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
				SndLib.SwineAtk
				portrait_off
			}
			call_msg("TagMapBanditCamp2:RapeLoop/DailyJob9") ; portrait_hide
			portrait_off
	###############################################end
			$game_player.actor.sta = -100
			get_character(tmpDualBiosID).summon_data[:fuckedDate] += 1
			call_msg("TagMapBanditCamp2:Wake/FirstRape16")
			set_event_force_page(tmpG1ID,2,4)
			return handleNap
		chcg_background_color(0,0,0,0,7)
			$game_player.actor.set_action_state(:none)
			get_character(tmpWakeUpID).summon_data[:job] = nil
			get_character(0).npc_story_mode(false)
			get_character(0).unset_event_chs_sex
			$game_player.unset_event_chs_sex
			$game_player.animation = $game_player.animation_stun
			get_character(tmpGuard1ID).direction = tmpGuard1OD
			get_character(tmpGuard2ID).direction = tmpGuard2OD
			get_character(tmpGuard3ID).direction = tmpGuard3OD
			get_character(tmpGuard4ID).direction = tmpGuard4OD
			get_character(tmpGuard1ID).moveto(tmpGuard1X,tmpGuard1Y)
			get_character(tmpGuard2ID).moveto(tmpGuard2X,tmpGuard2Y)
			get_character(tmpGuard3ID).moveto(tmpGuard3X,tmpGuard3Y)
			get_character(tmpGuard4ID).moveto(tmpGuard4X,tmpGuard4Y)
			get_character(tmpGuard1ID).animation = nil
			get_character(tmpGuard2ID).animation = nil
			get_character(tmpGuard3ID).animation = nil
			get_character(tmpGuard4ID).animation = nil
			get_character(tmpGuard1ID).npc_story_mode(false)
			get_character(tmpGuard2ID).npc_story_mode(false)
			get_character(tmpGuard3ID).npc_story_mode(false)
			get_character(tmpGuard4ID).npc_story_mode(false)
			get_character(0).npc_story_mode(false)
		chcg_background_color(0,0,0,255,-7)
	
end

get_character(0).call_balloon(28,-1) if get_character(tmpWakeUpID).summon_data[:job]
eventPlayEnd
