SndLib.bgs_play("WATER_Sea_Waves_Small_20sec_loop_stereo",70,150)
SndLib.bgm_stop
if $game_date.day?
	$game_map.shadows.set_color(80, 120, 160)
	$game_map.shadows.set_opacity(30)
	map_background_color(160,140,80,80,1)
end
if $game_date.night?
	$game_map.shadows.set_color(50, 70, 180)
	$game_map.shadows.set_opacity(180)
	map_background_color(20,60,170,50,0)
end


tmpSpotGuyX,tmpSpotGuyY,tmpSpotGuyID = $game_map.get_storypoint("SpotGuy")
tmpStartPointX,tmpStartPointY,tmpStartPointID = $game_map.get_storypoint("StartPoint")
tmpCamX,tmpCamY,tmpCamID = $game_map.get_storypoint("Cam")
tmpShipX,tmpShipY,tmpShipID = $game_map.get_storypoint("ship")
tmpRngGuy1X,tmpRngGuy1Y,tmpRngGuy1ID = $game_map.get_storypoint("RngGuy1")
tmpRngGuy2X,tmpRngGuy2Y,tmpRngGuy2ID = $game_map.get_storypoint("RngGuy2")
tmpRngGuy3X,tmpRngGuy3Y,tmpRngGuy3ID = $game_map.get_storypoint("RngGuy3")
tmpRngGuy4X,tmpRngGuy4Y,tmpRngGuy4ID = $game_map.get_storypoint("RngGuy4")
tmpRngGuy5X,tmpRngGuy5Y,tmpRngGuy5ID = $game_map.get_storypoint("RngGuy5")
tmpRngGuy6X,tmpRngGuy6Y,tmpRngGuy6ID = $game_map.get_storypoint("RngGuy6")
tmpRngGuyKidX,tmpRngGuyKidY,tmpRngGuyKidID = $game_map.get_storypoint("RngGuyKid")
tmpCapturedPointX,tmpCapturedPointY,tmpCapturedPointID = $game_map.get_storypoint("CapturedPoint")
tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
tmpDualBiosX,tmpDualBiosY,tmpDualBiosID = $game_map.get_storypoint("DualBios")
tmpCampFireX,tmpCampFireY,tmpCampFireID = $game_map.get_storypoint("CampFire")
tmpRG4X,tmpRG4Y,tmpRG4ID = $game_map.get_storypoint("RG4")
get_character(tmpCampFireID).moveto(1,1)
get_character(tmpDualBiosID).summon_data[:dayAMT] += 1

if get_character(tmpDualBiosID).summon_data[:AllDead] == true
	########################################################################## if all dead, delete all enemy
	$game_map.npcs.each{|ev|
		next if !ev.summon_data
		next if !ev.summon_data[:Commoner]
		ev.delete
	}
	$story_stats["OnRegionMapSpawnRace"] = "UndeadWalking"
	$story_stats["Ending_MainCharacter"] = 0
	3.times{
		posiX,posiY = $game_map.get_random_region(14)
		EvLib.sum("RandomUndead",posiX,posiY)
	}
	1.times{
		posiX,posiY = $game_map.get_random_region(14)
		EvLib.sum("RandomUndeadElite",posiX,posiY)
	}
else
	########################################################################## first time enter
	if get_character(tmpDualBiosID).summon_data[:dayAMT] == 1
		get_character(tmpCampFireID).moveto(tmpCampFireX,tmpCampFireY)
		tmpFirstTime = $story_stats["RecQuestDesertIsland1"] == 0
		$story_stats["RecQuestDesertIsland1"] =1
		$story_stats["Captured"] = 1
		$game_player.animation = $game_player.animation_overfatigue
		enter_static_region_map(false)
		portrait_hide
		#chcg_background_color(0,0,0,0,7)
			$game_player.actor.sta = -100
			get_character(tmpCamID).npc_story_mode(true)
			get_character(tmpRngGuy1ID).npc_story_mode(true)
			get_character(tmpRngGuy2ID).npc_story_mode(true)
			get_character(tmpRngGuy3ID).npc_story_mode(true)
			get_character(tmpRngGuy4ID).npc_story_mode(true)
			get_character(tmpRngGuy5ID).npc_story_mode(true)
			get_character(tmpRngGuy6ID).npc_story_mode(true)
			get_character(tmpRngGuyKidID).npc_story_mode(true)
			get_character(tmpSpotGuyID).npc_story_mode(true)
			get_character(tmpSpotGuyID).moveto(tmpCamX,tmpCamY)
			get_character(tmpRngGuy1ID).moveto(tmpCamX-1,tmpCamY+1) #reciver
			get_character(tmpRngGuy2ID).moveto(tmpCamX,tmpCamY+1) #fucker
			get_character(tmpRngGuy3ID).moveto(tmpCamX-2,tmpCamY) #reciver
			get_character(tmpRngGuy4ID).moveto(tmpCamX-1,tmpCamY) #fucker
			get_character(tmpRngGuy5ID).moveto(tmpCamX-1,tmpCamY-2) #fucker
			get_character(tmpRngGuy6ID).moveto(tmpCamX,tmpCamY-1) #fucker
			get_character(tmpRngGuyKidID).moveto(tmpCamX,tmpCamY-2) #reciver
			npc_sex_service_main(ev_target=get_character(tmpRngGuy2ID),tmpReciver=get_character(tmpRngGuy1ID),temp_tar_slot="anal",forcePose=nil,tmpAniStage=0)
			npc_sex_service_main(ev_target=get_character(tmpRngGuy4ID),tmpReciver=get_character(tmpRngGuy3ID),temp_tar_slot="mouth",forcePose=nil,tmpAniStage=1)
			npc_sex_service_main(ev_target=get_character(tmpRngGuy5ID),tmpReciver=get_character(tmpRngGuyKidID),temp_tar_slot="anal",forcePose=2,tmpAniStage=2)
			npc_sex_service_main(ev_target=get_character(tmpRngGuy6ID),tmpReciver=get_character(tmpRngGuyKidID),temp_tar_slot="mouth",forcePose=2,tmpAniStage=2)
			get_character(tmpSpotGuyID).direction = 4
			get_character(tmpRngGuy1ID).direction = 6
			get_character(tmpRngGuy2ID).direction = 6
			get_character(tmpRngGuy3ID).direction = 6
			get_character(tmpRngGuy4ID).direction = 6
			get_character(tmpRngGuy5ID).direction = 6
			get_character(tmpRngGuy6ID).direction = 6
			get_character(tmpRngGuyKidID).direction = 6
			get_character(tmpSpotGuyID).animation = get_character(tmpSpotGuyID).animation_masturbation
			get_character(tmpCamID).moveto(tmpStartPointX,tmpStartPointY)
			cam_follow(tmpSpotGuyID,0)
			portrait_off
		chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapDesertIsland1:OPevent/0")
		SndLib.sound_chcg_full(rand(100)+50)
		get_character(tmpSpotGuyID).animation = nil
		get_character(tmpSpotGuyID).direction = 6
		get_character(tmpSpotGuyID).call_balloon(1)
		call_msg("TagMapDesertIsland1:OPevent/1") ; portrait_hide
		wait(60)
		get_character(tmpSpotGuyID).call_balloon(8)
		wait(60)
		#cam_follow(tmpSpotGuyID,0)
		6.times{
			get_character(tmpSpotGuyID).direction = 6 ; get_character(tmpSpotGuyID).move_forward_force
			until !get_character(tmpSpotGuyID).moving?
				wait(1)
			end
		}
		get_character(tmpSpotGuyID).direction = 2
		get_character(tmpSpotGuyID).call_balloon(1)
		wait(60)
		get_character(tmpSpotGuyID).jump_to(get_character(tmpSpotGuyID).x,get_character(tmpSpotGuyID).y)
		call_msg("TagMapDesertIsland1:OPevent/2")
		if tmpFirstTime
			get_character(tmpSpotGuyID).jump_to(get_character(tmpSpotGuyID).x,get_character(tmpSpotGuyID).y)
			call_msg("TagMapDesertIsland1:OPevent/3_firsttime")
			get_character(tmpSpotGuyID).jump_to(get_character(tmpSpotGuyID).x,get_character(tmpSpotGuyID).y)
			call_msg("TagMapDesertIsland1:OPevent/4_firsttime")
			get_character(tmpSpotGuyID).direction = 4
			get_character(tmpSpotGuyID).jump_to(get_character(tmpSpotGuyID).x,get_character(tmpSpotGuyID).y)
			call_msg("TagMapDesertIsland1:OPevent/5_firsttime")
		else
			get_character(tmpSpotGuyID).jump_to(get_character(tmpSpotGuyID).x,get_character(tmpSpotGuyID).y)
			call_msg("TagMapDesertIsland1:OPevent/3")
			get_character(tmpSpotGuyID).jump_to(get_character(tmpSpotGuyID).x,get_character(tmpSpotGuyID).y)
			call_msg("TagMapDesertIsland1:OPevent/4")
			get_character(tmpSpotGuyID).direction = 4
			get_character(tmpSpotGuyID).jump_to(get_character(tmpSpotGuyID).x,get_character(tmpSpotGuyID).y)
			call_msg("TagMapDesertIsland1:OPevent/5")
		end
		get_character(tmpRngGuy1ID).unset_event_chs_sex
		get_character(tmpRngGuy2ID).unset_event_chs_sex
		get_character(tmpRngGuy3ID).unset_event_chs_sex
		get_character(tmpRngGuy4ID).unset_event_chs_sex
		get_character(tmpRngGuy5ID).unset_event_chs_sex
		get_character(tmpRngGuy6ID).unset_event_chs_sex
		get_character(tmpRngGuyKidID).unset_event_chs_sex
		
		get_character(tmpRngGuy1ID).call_balloon(1)
		get_character(tmpRngGuy2ID).call_balloon(1)
		get_character(tmpRngGuy3ID).call_balloon(1)
		get_character(tmpRngGuy4ID).call_balloon(1)
		get_character(tmpRngGuy5ID).call_balloon(1)
		get_character(tmpRngGuy6ID).call_balloon(1)
		get_character(tmpRngGuyKidID).call_balloon(1)
		call_msg("TagMapDesertIsland1:OPevent/6")
		if tmpFirstTime
			call_msg("TagMapDesertIsland1:OPevent/7_firsttime")
		else
			call_msg("TagMapDesertIsland1:OPevent/7")
		end
		call_msg("TagMapDesertIsland1:OPevent/8") ; portrait_hide
		7.times{
			get_character(tmpRngGuy1ID).move_goto_xy(tmpStartPointX,tmpStartPointY)
			get_character(tmpRngGuy2ID).move_goto_xy(tmpStartPointX,tmpStartPointY)
			get_character(tmpRngGuy3ID).move_goto_xy(tmpStartPointX,tmpStartPointY)
			get_character(tmpRngGuy4ID).move_goto_xy(tmpStartPointX,tmpStartPointY)
			get_character(tmpRngGuy5ID).move_goto_xy(tmpStartPointX,tmpStartPointY)
			get_character(tmpRngGuy6ID).move_goto_xy(tmpStartPointX,tmpStartPointY)
			get_character(tmpRngGuyKidID).move_goto_xy(tmpStartPointX,tmpStartPointY)
			wait(30)
		}
		get_character(tmpRngGuy1ID).turn_toward_character($game_player)
		get_character(tmpRngGuy2ID).turn_toward_character($game_player)
		get_character(tmpRngGuy3ID).turn_toward_character($game_player)
		get_character(tmpRngGuy4ID).turn_toward_character($game_player)
		get_character(tmpRngGuy5ID).turn_toward_character($game_player)
		get_character(tmpRngGuy6ID).turn_toward_character($game_player)
		get_character(tmpRngGuyKidID).turn_toward_character($game_player)
		call_msg("TagMapDesertIsland1:OPevent/9")
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			cam_center(0)
			$game_player.moveto(tmpCapturedPointX,tmpCapturedPointY)
			get_character(tmpRngGuy1ID).moveto(tmpCapturedPointX,tmpCapturedPointY+1)
			get_character(tmpRngGuy2ID).moveto(tmpCapturedPointX,tmpCapturedPointY-1)
			get_character(tmpRngGuy3ID).moveto(tmpCapturedPointX-1,tmpCapturedPointY)
			get_character(tmpRngGuy4ID).moveto(tmpCapturedPointX+1,tmpCapturedPointY)
			get_character(tmpRngGuy5ID).moveto(tmpCapturedPointX+1,tmpCapturedPointY+1)
			get_character(tmpRngGuy6ID).moveto(tmpCapturedPointX-1,tmpCapturedPointY+1)
			get_character(tmpRngGuyKidID).moveto(tmpCapturedPointX,tmpCapturedPointY+2)
			get_character(tmpRngGuy1ID).turn_toward_character($game_player)
			get_character(tmpRngGuy2ID).turn_toward_character($game_player)
			get_character(tmpRngGuy3ID).turn_toward_character($game_player)
			get_character(tmpRngGuy4ID).turn_toward_character($game_player)
			get_character(tmpRngGuy5ID).turn_toward_character($game_player)
			get_character(tmpRngGuy6ID).turn_toward_character($game_player)
			get_character(tmpRngGuyKidID).turn_toward_character($game_player)
		chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapDesertIsland1:FirstRape/0")
		get_character(tmpRngGuy1ID).animation = get_character(tmpRngGuy1ID).animation_masturbation
		get_character(tmpRngGuy2ID).animation = get_character(tmpRngGuy2ID).animation_masturbation
		get_character(tmpRngGuy3ID).animation = get_character(tmpRngGuy3ID).animation_masturbation
		get_character(tmpRngGuy4ID).animation = get_character(tmpRngGuy4ID).animation_masturbation
		get_character(tmpRngGuy5ID).animation = get_character(tmpRngGuy5ID).animation_masturbation
		get_character(tmpRngGuy6ID).animation = get_character(tmpRngGuy6ID).animation_masturbation
		get_character(tmpRngGuyKidID).animation = get_character(tmpRngGuyKidID).animation_masturbation
		SndLib.sound_equip_armor(125)
		SndLib.sound_chcg_full(rand(100)+50)
		npc_sex_service_main(ev_target=get_character(tmpRngGuy1ID),tmpReciver=$game_player,temp_tar_slot="vag",forcePose=0,tmpAniStage=0)
		lona_mood "p5_#{chcg_cumming_mood_decider}"
		load_script("Data/Batch/chcg_basic_frame_vag.rb")
		call_msg("TagMapDesertIsland1:FirstRape/1")
		SndLib.sound_equip_armor(125)
		SndLib.sound_chcg_full(rand(100)+50)
		lona_mood "p5_#{chcg_cumming_mood_decider}"
		load_script("Data/Batch/chcg_basic_frame_anal.rb")
		npc_sex_service_main(ev_target=get_character(tmpRngGuy1ID),tmpReciver=$game_player,temp_tar_slot="vag",forcePose=2,tmpAniStage=0)
		npc_sex_service_main(ev_target=get_character(tmpRngGuy2ID),tmpReciver=$game_player,temp_tar_slot="anal",forcePose=2,tmpAniStage=0)
		call_msg("TagMapDesertIsland1:FirstRape/2")
		SndLib.sound_equip_armor(125)
		SndLib.sound_chcg_full(rand(100)+50)
		lona_mood "p5_#{chcg_cumming_mood_decider}"
		load_script("Data/Batch/chcg_basic_frame_vag.rb")
		npc_sex_service_main(ev_target=get_character(tmpRngGuy1ID),tmpReciver=$game_player,temp_tar_slot="vag",forcePose=1,tmpAniStage=0)
		npc_sex_service_main(ev_target=get_character(tmpRngGuy2ID),tmpReciver=$game_player,temp_tar_slot="anal",forcePose=1,tmpAniStage=0)
		npc_sex_service_main(ev_target=get_character(tmpRngGuy3ID),tmpReciver=$game_player,temp_tar_slot="mouth",forcePose=1,tmpAniStage=0)
		call_msg("TagMapDesertIsland1:FirstRape/3")
		call_msg("TagMapDesertIsland1:FirstRape/3_1")
		portrait_hide
		map_background_color(0,0,0,255,0)
		chcg_background_color(0,0,0,0,7)
			portrait_off
			load_script("Data/HCGframes/event/HumanCave_NapGangRape.rb")
			get_character(tmpSpotGuyID).npc_story_mode(false)
			get_character(tmpRngGuy1ID).npc_story_mode(false)
			get_character(tmpRngGuy2ID).npc_story_mode(false)
			get_character(tmpRngGuy3ID).npc_story_mode(false)
			get_character(tmpRngGuy4ID).npc_story_mode(false)
			get_character(tmpRngGuy5ID).npc_story_mode(false)
			get_character(tmpRngGuy6ID).npc_story_mode(false)
			get_character(tmpRngGuyKidID).npc_story_mode(false)
			get_character(tmpCamID).npc_story_mode(false)
			$game_player.moveto(tmpCapturedPointX,tmpCapturedPointY)
			cam_center(0)
		$game_player.animation = nil
	###################################################################################################################################### 休息 &&  第一天
	#else
	elsif $story_stats["Captured"] == 1 && (get_character(tmpDualBiosID).summon_data[:dayAMT] == 2 || ((get_character(tmpDualBiosID).summon_data[:dayAMT]+1) % 3) != 0)
		tmpWakeFucker = $game_map.npcs.select{|ev|
			next if !ev.summon_data
			next if !ev.summon_data[:Commoner]
			ev
		}
		tmpWakeFucker = tmpWakeFucker.sample
		enter_static_region_map(false)
		$game_player.moveto(tmpCapturedPointX,tmpCapturedPointY)
		$game_player.direction = 2
		tmpWakeFucker.moveto($game_player.x,$game_player.y+1)
		tmpDailySex = rand(3)
		call_msg("TagMapDesertIsland1:FirstRape/3_1")
		2.times{
			lona_mood "p5health_damage"
			SndLib.sound_chcg_full(rand(100)+50)
			$game_portraits.rprt.shake
			$game_map.interpreter.flash_screen(Color.new(255,255,255,25),8,true)
			wait(20+rand(10))
		}
		case tmpDailySex
			when 0 ; npc_sex_service_main(ev_target=tmpWakeFucker,tmpReciver=$game_player,temp_tar_slot="vag",forcePose=nil,tmpAniStage=0)
					$game_player.actor.stat["EventVagRace"] = "Human"
					$game_player.actor.stat["EventVag"] = "CumInside1"
			when 1 ; npc_sex_service_main(ev_target=tmpWakeFucker,tmpReciver=$game_player,temp_tar_slot="anal",forcePose=nil,tmpAniStage=0)
					$game_player.actor.stat["EventAnalRace"] = "Human"
					$game_player.actor.stat["EventAnal"] = "CumInside1"
			when 2 ; npc_sex_service_main(ev_target=tmpWakeFucker,tmpReciver=$game_player,temp_tar_slot="mouth",forcePose=nil,tmpAniStage=0)
					$game_player.actor.stat["EventMouthRace"] = "Human"
					$game_player.actor.stat["EventMouth"] = "CumInside1"
		end
		chcg_background_color(0,0,0,255,-7)
		8.times{
			lona_mood "p5shame"
			SndLib.sound_chcg_full(rand(100)+50)
			$game_portraits.rprt.shake
			$game_map.interpreter.flash_screen(Color.new(255,255,255,25),8,true)
			wait(17+rand(10))
		}
		case tmpDailySex
			when 0 ; npc_sex_service_main(ev_target=tmpWakeFucker,tmpReciver=$game_player,temp_tar_slot="vag",forcePose=nil,tmpAniStage=1)
			when 1 ; npc_sex_service_main(ev_target=tmpWakeFucker,tmpReciver=$game_player,temp_tar_slot="anal",forcePose=nil,tmpAniStage=1)
			when 2 ; npc_sex_service_main(ev_target=tmpWakeFucker,tmpReciver=$game_player,temp_tar_slot="mouth",forcePose=nil,tmpAniStage=1)
		end
		8.times{
			lona_mood "p5shame"
			SndLib.sound_chcg_full(rand(100)+50)
			$game_portraits.rprt.shake
			$game_map.interpreter.flash_screen(Color.new(255,255,255,25),8,true)
			wait(10+rand(10))
		}
		case tmpDailySex
			when 0 ; npc_sex_service_main(ev_target=tmpWakeFucker,tmpReciver=$game_player,temp_tar_slot="vag",forcePose=nil,tmpAniStage=2)
			when 1 ; npc_sex_service_main(ev_target=tmpWakeFucker,tmpReciver=$game_player,temp_tar_slot="anal",forcePose=nil,tmpAniStage=2)
			when 2 ; npc_sex_service_main(ev_target=tmpWakeFucker,tmpReciver=$game_player,temp_tar_slot="mouth",forcePose=nil,tmpAniStage=2)
		end
		
		tmpStyle = ["_CumInside","_CumInside_Overcum","_CumInside_Overcum_Peein","_CumInside_Peein","_CumOutside"].sample
		case tmpDailySex
			when 0 ; load_script("Data/HCGframes/EventVag#{tmpStyle}.rb")
			when 1 ; load_script("Data/HCGframes/EventAnal#{tmpStyle}.rb")
			when 2 ; load_script("Data/HCGframes/EventMouth#{tmpStyle}.rb")
		end
		whole_event_end
		chcg_background_color(0,0,0,0,7)
			$game_player.unset_event_chs_sex
			tmpWakeFucker.unset_event_chs_sex
			$game_map.npcs.each{|ev|
				next if !ev.summon_data
				next if !ev.summon_data[:Commoner]
				ev.set_manual_move_type(3)
				ev.move_type = 3
				posi=$game_map.region_map[14].sample
				ev.moveto(posi[0],posi[1])
				ev.npc.fucker_condition={"sex"=>[65535, "="]}
				ev.npc.killer_condition={"morality"=> [100, ">"]}
				ev.npc.assaulter_condition={"sex"=>[65535, "="]}
				#ev.npc.fucker_condition={"sex"=>[0, "="],"weak"=>[50, ">"]}
				#ev.npc.killer_condition={"weak"=>[10, "<"]}
				#ev.npc.assaulter_condition={"weak"=>[10, ">"]}
			}
			
			tmpWakeFucker.summon_data[:Fucked] = true
			tmpWakeFucker.moveto(tmpCapturedPointX,tmpCapturedPointY+3)
			tmpWakeFucker.direction = 8
			tmpWakeFucker.set_manual_move_type(0)
			tmpWakeFucker.move_type = 0
		chcg_background_color(0,0,0,255,-7)
		tmpWakeFucker.npc_story_mode(true)
		tmpWakeFucker.call_balloon(20)
		call_msg("TagMapDesertIsland1:WakeRape/0_#{rand(3)}") ; portrait_hide
		3.times{
			tmpWakeFucker.direction = 2 ; tmpWakeFucker.move_forward_force
			until !tmpWakeFucker.moving?
				wait(1)
			end
		}
		tmpWakeFucker.effects=["FadeOutDelete",0,false,nil,nil,[true,false].sample]
		
		wait(60)
		cam_center(0)
		if get_character(tmpDualBiosID).summon_data[:dayAMT] == 2
			call_msg("TagMapDesertIsland1:Wakeup/0")
		end
		eventPlayEnd
	####################################################################################################################################### celebrity
	else
		
		enter_static_region_map(false)
		get_character(tmpCampFireID).moveto(tmpCampFireX,tmpCampFireY)
		get_character(tmpRG4ID).delete
		$game_player.moveto(tmpCampFireX,tmpCampFireY-1)
		get_character(tmpRngGuy1ID).moveto(tmpCampFireX,tmpCampFireY-2)
		get_character(tmpRngGuy2ID).moveto(tmpCampFireX-2,tmpCampFireY-1)
		get_character(tmpRngGuy3ID).moveto(tmpCampFireX-2,tmpCampFireY)
		get_character(tmpRngGuy4ID).moveto(tmpCampFireX+2,tmpCampFireY-1)
		get_character(tmpRngGuy5ID).moveto(tmpCampFireX+2,tmpCampFireY)
		get_character(tmpRngGuy6ID).moveto(tmpCampFireX,tmpCampFireY+1)
		get_character(tmpRngGuy1ID).turn_toward_character($game_player)
		get_character(tmpRngGuy2ID).turn_toward_character($game_player)
		get_character(tmpRngGuy3ID).turn_toward_character($game_player)
		get_character(tmpRngGuy4ID).turn_toward_character($game_player)
		get_character(tmpRngGuy5ID).turn_toward_character($game_player)
		get_character(tmpRngGuy6ID).turn_toward_character($game_player)
		
		$game_map.npcs.each{|ev|
			next if !ev.summon_data
			next if !ev.summon_data[:Commoner]
			next if ev.npc.action_state == :death
			ev.set_manual_move_type(2)
			ev.move_type = 2
			ev.npc.fucker_condition={"sex"=>[0, "="],"morality"=>[100, "<"]}
			ev.npc.killer_condition={"morality"=> [100, ">"]}
			ev.npc.assaulter_condition={"weak"=>[10, ">"]}
			}
			
		call_msg("TagMapDesertIsland1:celebrity/0") ; portrait_hide
		SndLib.sound_equip_armor(125)
		chcg_background_color(0,0,0,255,-7)
		$game_player.direction = 4
		$game_player.call_balloon(8)
		wait(60)
		$game_player.direction = 6
		$game_player.call_balloon(8)
		wait(60)
		call_msg("TagMapDesertIsland1:celebrity/1")
		eventPlayEnd
	end
end #get_character(tmpDualBiosID).summon_data[:AllDead] == true
summon_companion
eventPlayEnd