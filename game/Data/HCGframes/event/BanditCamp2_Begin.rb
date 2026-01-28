########################################################################################################################################## Fix the Gate
tmpWakeUpX,tmpWakeUpY,tmpWakeUpID=$game_map.get_storypoint("WakeUp")
tmpG1X,tmpG1Y,tmpG1ID = $game_map.get_storypoint("Gate1")
tmpInHouseRGpt2X,tmpInHouseRGpt2Y,tmpInHouseRGpt2ID = $game_map.get_storypoint("InHouseRGpt2")
tmpBossX,tmpBossY,tmpBossID = $game_map.get_storypoint("Boss")
tmpOutPT5X,tmpOutPT5Y,tmpOutPT5ID = $game_map.get_storypoint("OutPT5")
tmpGuard1X,tmpGuard1Y,tmpGuard1ID = $game_map.get_storypoint("guard1")
tmpGuard2X,tmpGuard2Y,tmpGuard2ID = $game_map.get_storypoint("guard2")
tmpGuard3X,tmpGuard3Y,tmpGuard3ID = $game_map.get_storypoint("guard3")
tmpGuard4X,tmpGuard4Y,tmpGuard4ID = $game_map.get_storypoint("guard4")
tmpPiggyX,tmpPiggyY,tmpPiggyID = $game_map.get_storypoint("Piggy")
get_character(tmpWakeUpID).switch1_id = $game_date.dateAmt if !get_character(tmpWakeUpID).switch1_id
tarRleaseDate=rand(5)+12
tarDate=tarRleaseDate+get_character(tmpWakeUpID).switch1_id
tmpG1HP = get_character(tmpG1ID).switch1_id
tmpG1HPmax = get_character(tmpG1ID).summon_data[:staNeed]

if tmpG1HP >= tmpG1HPmax 
	$story_stats["RapeLoopTorture"] = 1
	call_msg("TagMapNoerMobHouse:Doors/LockReset")
	get_character(tmpG1ID).switch1_id = 0
	get_character(tmpG1ID).moveto(tmpG1X,tmpG1Y)
end
if $story_stats["CapturedStatic"] == 1 && $story_stats["Captured"] == 1
	$story_stats["CapturedStatic"] = 0
	$story_stats["RapeLoop"] = 0
	$story_stats["RapeLoopTorture"] = 0
end
if ($story_stats["UniqueCharUniquePigBobo"] == -1 || $story_stats["RecQuestPigBobo"] >= 1) && $story_stats["Captured"] == 1
	tmpNoBobo = $story_stats["RecQuestPigBobo"] >= 1 || $story_stats["UniqueCharUniquePigBobo"] == -1 
	SndLib.bgm_stop
	SndLib.bgs_stop
	portrait_hide
	chcg_background_color(20,0,0,255)
	portrait_off
	call_msg("TagMapBanditCamp2:GameOver/begin0_noBobo")
	SndLib.sound_gore(100)
	SndLib.sound_combat_hit_gore(70)
	$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true) ; wait(20+rand(20))
	SndLib.sound_combat_hit_gore(70)
	$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true) ; wait(20+rand(20))
	SndLib.sound_combat_hit_gore(70)
	$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true) ; wait(20+rand(20))
	wait(60)
	call_msg("TagMapBanditCamp2:GameOver/begin1_noBobo")
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
		#SndLib.SwineSpot if rand(100) >=60
		SndLib.sound_gore(100)
		SndLib.sound_combat_hit_gore(70)
		wait(20+rand(20))
	}
	chcg_background_color(0,0,0,255)
	wait(90)
	return load_script("Data/HCGframes/OverEvent_Death.rb")
end

#####Roll BOBO fucker stats
if [false,true,true,true].sample && get_character(tmpPiggyID) && get_character(tmpPiggyID).npc?
	get_character(tmpPiggyID).npc.fucker_condition={"sex"=>[65535, "="]}
	get_character(tmpPiggyID).npc.killer_condition={"sex"=>[65535, "="]}
	get_character(tmpPiggyID).npc.assaulter_condition={"sex"=>[65535, "="]}
	get_character(tmpPiggyID).move_type = 0
	get_character(tmpPiggyID).set_manual_move_type(0)
	get_character(tmpPiggyID).moveto(tmpWakeUpX-1,tmpWakeUpY+1)
	get_character(tmpPiggyID).animation = get_character(tmpPiggyID).animation_stun
end

########################################################################################################################################### 以RAPELOOP偵測是否是第一次被抓
if $story_stats["Captured"] == 1 && $story_stats["RapeLoop"] == 0
	$story_stats["RecQuestPigBoboMated"] += 1
	$story_stats["RapeLoop"] = 1
	$story_stats["Ending_MainCharacter"] = "Ending_MC_HumanSlave"
	tmpBossOD = get_character(tmpBossID).direction
	tmpGuard1OD = get_character(tmpGuard1ID).direction
	tmpGuard2OD = get_character(tmpGuard2ID).direction
	tmpGuard3OD = get_character(tmpGuard3ID).direction
	tmpGuard4OD = get_character(tmpGuard4ID).direction
	$game_player.moveto(tmpOutPT5X+2,tmpOutPT5Y)
	get_character(tmpBossID).moveto(tmpOutPT5X+2,tmpOutPT5Y-2)
	get_character(tmpGuard1ID).moveto(tmpOutPT5X-1+2,tmpOutPT5Y)
	get_character(tmpGuard2ID).moveto(tmpOutPT5X+1+2,tmpOutPT5Y)
	$game_player.direction = 8
	get_character(tmpGuard1ID).direction = 8
	get_character(tmpGuard2ID).direction = 8
	get_character(tmpBossID).direction = 2
	get_character(tmpBossID).move_type = 0
	get_character(tmpG1ID).opacity = 0
	#if $story_stats["RecBanditCamp2FirstPigRape"] == 0 ###################################本事件僅撥放一次?
	#	$story_stats["RecBanditCamp2FirstPigRape"] = 1
		###################################################### 被抓訊息
		###################################################### 老大喊話
		portrait_off
		chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapBanditCamp2:Wake/FirstRape0")
		get_character(tmpBossID).npc_story_mode(true)
		get_character(tmpBossID).move_forward_force ; wait(35)
		call_msg("TagMapBanditCamp2:Wake/FirstRape1")
		get_character(tmpBossID).npc_story_mode(false)
		get_character(tmpBossID).call_balloon(8) ; wait(50)
		call_msg("TagMapBanditCamp2:Wake/FirstRape2")			
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			cam_center(0)
			portrait_off
			$game_player.moveto(tmpInHouseRGpt2X+2,tmpInHouseRGpt2Y-3)
			get_character(tmpGuard1ID).moveto(tmpInHouseRGpt2X+2,tmpInHouseRGpt2Y-1)
			get_character(tmpGuard2ID).moveto(tmpInHouseRGpt2X+3,tmpInHouseRGpt2Y-1)
			get_character(tmpPiggyID).moveto(tmpPiggyX+2,tmpPiggyY)
			get_character(tmpPiggyID).animation = get_character(tmpPiggyID).animation_stun
			$game_player.direction= 2
			get_character(tmpGuard1ID).direction = 8
			get_character(tmpGuard2ID).direction = 8
			get_character(tmpPiggyID).direction = 4
			$game_map.set_fog(nil)
			weather_stop
			$game_map.set_underground_light
	
		#################################################### 送到監獄 豬豬
		chcg_background_color(0,0,0,255,-7)
			call_msg("TagMapBanditCamp2:Wake/FirstRape3") ; portrait_hide
			get_character(tmpGuard1ID).npc_story_mode(true)
			get_character(tmpGuard1ID).move_forward_force ; wait(30)
			get_character(tmpGuard1ID).animation = get_character(tmpGuard1ID).animation_atk_mh
			cam_center(0)
			wait(8)
			SndLib.sound_punch_hit(90)
			lona_mood "p5crit_damage"
			$game_player.actor.portrait.shake
			$game_player.jump_to($game_player.x,$game_player.y-1)
			$game_player.direction = 2
			wait(30)
			call_msg("TagMapBanditCamp2:Wake/FirstRape4") ; portrait_hide
			SndLib.sound_step_chain(100)
			get_character(tmpG1ID).opacity = 255
			wait(10)
			SndLib.sys_close
			wait(30)
			call_msg("TagMapBanditCamp2:Wake/FirstRape5") ; portrait_hide
			get_character(tmpPiggyID).npc_story_mode(true)
			get_character(tmpPiggyID).move_type = 0
			get_character(tmpPiggyID).call_balloon(2)
			get_character(tmpPiggyID).animation = nil
			wait(10)
			$game_portraits.setLprt("BoboNormal")
			$game_portraits.lprt.shake
			SndLib.SwineAggro(100)
			get_character(tmpPiggyID).call_balloon(20)
			$game_player.turn_toward_character(get_character(tmpPiggyID))
			$game_player.call_balloon(1)
			call_msg("...") ; portrait_hide
			
			get_character(tmpPiggyID).direction = 4 ; get_character(tmpPiggyID).move_forward_force ; $game_player.turn_toward_character(get_character(tmpPiggyID)) ;wait(65)
			get_character(tmpPiggyID).direction = 4 ; get_character(tmpPiggyID).move_forward_force ; $game_player.turn_toward_character(get_character(tmpPiggyID)) ;wait(65)
			get_character(tmpPiggyID).direction = 4 ; get_character(tmpPiggyID).move_forward_force ; $game_player.turn_toward_character(get_character(tmpPiggyID)) ;wait(65)
			get_character(tmpPiggyID).direction = 2
			
			$game_portraits.setLprt("BoboYell")
			$game_portraits.lprt.shake
			SndLib.SwineSpot
			get_character(tmpPiggyID).call_balloon(4)
			wait(50)
			call_msg("TagMapBanditCamp2:Wake/FirstRape6") ; portrait_hide
			SndLib.sound_punch_hit(80)
			get_character(tmpPiggyID).animation = get_character(tmpPiggyID).animation_grabber_qte($game_player)
			$game_player.animation = $game_player.animation_grabbed_qte
			wait(8)
			$game_portraits.setLprt("BoboYell")
			$game_portraits.lprt.shake
			SndLib.SwineAggro(100)
			call_msg("TagMapBanditCamp2:Wake/FirstRape7") ; portrait_hide
			get_character(tmpPiggyID).direction = 8 ; get_character(tmpPiggyID).move_forward_force
			$game_player.direction = 8 ; $game_player.move_forward_force
			SndLib.sound_equip_armor(80,50)
			wait(65)
			$game_portraits.setLprt("BoboYell")
			$game_portraits.lprt.shake
			SndLib.SwineAggro(100)
			get_character(tmpPiggyID).direction = 2
			get_character(tmpPiggyID).animation = get_character(tmpPiggyID).animation_atk_heavy ; wait(5) ; SndLib.SwineAtk ; wait(5)
			$game_player.animation = $game_player.animation_stun
			SndLib.sound_punch_hit(100)
			lona_mood "p5crit_damage"
			$game_player.actor.portrait.shake
			$game_player.jump_to($game_player.x,$game_player.y)
			$game_player.direction = 2
			wait(30)
			call_msg("TagMapBanditCamp2:Wake/FirstRape8") ; portrait_hide
	
			get_character(tmpPiggyID).animation = get_character(tmpPiggyID).animation_grabber_qte($game_player)
			SndLib.sound_punch_hit(80)
			call_msg("TagMapBanditCamp2:Wake/FirstRape9") ; portrait_hide
			wait(30)
			get_character(tmpPiggyID).moveto($game_player.x,$game_player.y)
			play_sex_service_main(ev_target=get_character(tmpPiggyID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=0,tmpAniStage=2) ; get_character(tmpPiggyID).force_update = true
			$game_portraits.setLprt("BoboYell")
			$game_portraits.lprt.shake
			SndLib.SwineAtk
			call_msg("TagMapBanditCamp2:Wake/FirstRape10") ; cam_center(0) ; portrait_hide
			half_event_key_cleaner
			play_sex_service_main(ev_target=get_character(tmpPiggyID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=0,tmpAniStage=1) ; get_character(tmpPiggyID).force_update = true
			$game_portraits.setLprt("BoboYell")
			$game_portraits.lprt.shake
			SndLib.SwineAtk
			portrait_off
			call_msg("TagMapBanditCamp2:Wake/FirstRape11") ; cam_center(0)
			portrait_off
			chcg_background_color(0,0,0,0,7)
				get_character(tmpGuard1ID).moveto(tmpInHouseRGpt2X+1,tmpInHouseRGpt2Y-1)
				get_character(tmpGuard2ID).moveto(tmpInHouseRGpt2X+2,tmpInHouseRGpt2Y-1)
				get_character(tmpGuard3ID).moveto(tmpInHouseRGpt2X+3,tmpInHouseRGpt2Y-1)
				get_character(tmpGuard4ID).moveto(tmpInHouseRGpt2X+4,tmpInHouseRGpt2Y-1)
				get_character(tmpBossID).moveto(tmpInHouseRGpt2X+3,tmpInHouseRGpt2Y-2)
				get_character(tmpGuard1ID).direction = 8
				get_character(tmpGuard2ID).direction = 8
				get_character(tmpGuard3ID).direction = 8
				get_character(tmpGuard4ID).direction = 8
				get_character(tmpBossID).direction = 8
				3.times{
					wait(60)
					SndLib.SwineAggro(100)
				}
			chcg_background_color(0,0,0,255,-7)
			$game_portraits.setLprt("BoboYell")
			$game_portraits.lprt.shake
			SndLib.SwineAtk
			call_msg("TagMapBanditCamp2:Wake/FirstRape12") ; cam_center(0)
			portrait_off
			half_event_key_cleaner
			play_sex_service_main(ev_target=get_character(tmpPiggyID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=0,tmpAniStage=1) ; get_character(tmpPiggyID).force_update = true
			SndLib.SwineAtk
			portrait_off
			$game_portraits.setLprt("BoboNormal")
			$game_portraits.lprt.shake
			SndLib.SwineAtk
			wait(40)
			portrait_hide
			call_msg("TagMapBanditCamp2:Wake/FirstRape12_1") ; cam_center(0)
			get_character(tmpGuard1ID).animation = get_character(tmpGuard1ID).animation_masturbation ; get_character(tmpGuard1ID).npc_story_mode(true)
			portrait_off
			half_event_key_cleaner
			play_sex_service_main(ev_target=get_character(tmpPiggyID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=0,tmpAniStage=2) ; get_character(tmpPiggyID).force_update = true
			$game_portraits.setLprt("BoboYell")
			$game_portraits.lprt.shake
			SndLib.SwineAtk
			wait(40)
			portrait_hide
			half_event_key_cleaner
			get_character(tmpGuard4ID).animation = get_character(tmpGuard4ID).animation_masturbation ; get_character(tmpGuard4ID).npc_story_mode(true)
			play_sex_service_main(ev_target=get_character(tmpPiggyID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=0,tmpAniStage=1) ; get_character(tmpPiggyID).force_update = true
			$game_portraits.setLprt("BoboNormal")
			$game_portraits.lprt.shake
			SndLib.SwineAtk
			wait(40)
			portrait_hide
			half_event_key_cleaner
			get_character(tmpGuard3ID).animation = get_character(tmpGuard3ID).animation_masturbation ; get_character(tmpGuard3ID).npc_story_mode(true)
			play_sex_service_main(ev_target=get_character(tmpPiggyID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=0,tmpAniStage=2) ; get_character(tmpPiggyID).force_update = true
			$game_portraits.setLprt("BoboYell")
			$game_portraits.lprt.shake
			SndLib.SwineAtk
			wait(40)
			portrait_hide
			$game_player.actor.stat["EventVagRace"] =  "Others"
			$game_player.actor.stat["EventVag"] = "CumInside1"
			SndLib.SwineAtk
			wait(40)
			portrait_hide
			chcg_decider_basic(pose=3) ; load_script("Data/HCGframes/EventVag_CumInside_OvercumStay.rb")
			SndLib.SwineAtk
			$game_player.actor.addCums("CumsCreamPie",350,"Others")
			call_msg("TagMapBanditCamp2:Wake/FirstRape13")
			get_character(tmpGuard2ID).animation = get_character(tmpGuard2ID).animation_masturbation ; get_character(tmpGuard2ID).npc_story_mode(true)
			play_sex_service_main(ev_target=get_character(tmpPiggyID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=0,tmpAniStage=1)
			get_character(tmpPiggyID).force_update = true
			$game_portraits.setLprt("BoboNormal")
			$game_portraits.lprt.shake
			SndLib.SwineAtk
			wait(40)
			portrait_hide
			$game_player.actor.stat["EventVagRace"] =  "Others"
			$game_player.actor.stat["EventVag"] = "CumInside1"
			$game_portraits.setLprt("BoboYell")
			$game_portraits.lprt.shake
			SndLib.SwineAtk
			wait(40)
			portrait_off
			chcg_decider_basic(pose=3) ; load_script("Data/HCGframes/EventVag_CumInside_OvercumStay.rb")
			SndLib.SwineAtk
			$game_player.actor.addCums("CumsCreamPie",350,"Others")
			call_msg("TagMapBanditCamp2:Wake/FirstRape14")
			play_sex_service_main(ev_target=get_character(tmpPiggyID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=0,tmpAniStage=2) ; get_character(tmpPiggyID).force_update = true
			SndLib.SwineAtk
			$game_player.actor.stat["EventVagRace"] =  "Others"
			$game_player.actor.stat["EventVag"] = "CumInside1"
			SndLib.SwineAtk
			chcg_decider_basic(pose=3) ; load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
			SndLib.SwineAtk
			$game_player.actor.addCums("CumsCreamPie",350,"Others")
			portrait_off
			whole_event_end
			get_character(tmpBossID).direction = 2
			get_character(tmpGuard1ID).animation = nil
			get_character(tmpGuard2ID).animation = nil
			get_character(tmpGuard3ID).animation = nil
			get_character(tmpGuard4ID).animation = nil
			call_msg("TagMapBanditCamp2:Wake/FirstRape15")
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			############################################### 還原物件至預設
			call_msg("TagMapBanditCamp2:Wake/FirstRape15_1")
			call_msg("TagMapBanditCamp2:Wake/FirstRape16")
			$game_player.actor.sta = -100
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
			get_character(tmpPiggyID).npc_story_mode(false)
			get_character(tmpBossID).direction = tmpBossOD
			get_character(tmpBossID).moveto(tmpBossX,tmpBossY)
			get_character(tmpBossID).move_type = 3
			get_character(tmpPiggyID).move_type = 1
			get_character(tmpG1ID).opacity = 255
			$game_player.unset_event_chs_sex
			get_character(tmpPiggyID).unset_event_chs_sex
	#end #if $story_stats["RecBanditCamp2FirstPigRape"] == 0
########################################################################################################################################### 上銬模組
########################################################################################################################################### 上銬模組
######################################## SoldEvent ###############################################
elsif $story_stats["Captured"] == 1 && $story_stats["RapeLoop"] == 1 && $game_date.dateAmt >= tarDate
	get_character(tmpGuard4ID).npc_story_mode(true)
	get_character(tmpGuard4ID).moveto(get_character(tmpWakeUpID).x+1,get_character(tmpWakeUpID).y-1)
	get_character(tmpGuard2ID).moveto(get_character(tmpWakeUpID).x+1,get_character(tmpWakeUpID).y)
	get_character(tmpGuard4ID).turn_toward_character($game_player)
	get_character(tmpGuard2ID).turn_toward_character($game_player)
	$game_player.turn_toward_character(get_character(tmpGuard4ID))
	call_msg("TagMapBanditCamp1:Trans/begin1")
	
			$story_stats["OverMapForceTrans"] = "NoerMobHouse"
			rape_loop_drop_item(false,false)
			$game_party.gain_item($data_armors[22], 1) 
			$game_player.actor.change_equip(5, $data_armors[22])
			$story_stats["dialog_collar_equiped"] =0
			call_msg("TagMapBanditCamp1:Trans/begin2")
			get_character(tmpGuard4ID).npc_story_mode(false)
			#傳送主角至定點
			$game_player.move_normal
			$game_map.interpreter.chcg_background_color(0,0,0,255)
			$game_player.actor.sta = -99 if $game_player.actor.sta <= -99
			change_map_leave_tag_map
			$story_stats["Captured"] = 1
			SndLib.sound_equip_armor(100)
	return eventPlayEnd
	
####################################################################################### PIG SEX FREAK SHOW
elsif $story_stats["Captured"] == 1 && $story_stats["RapeLoop"] == 1 && [false,true].sample && $game_date.day?
	portrait_off
			$game_player.direction = 2
			get_character(tmpGuard1ID).moveto(tmpInHouseRGpt2X+1,tmpInHouseRGpt2Y-2)
			get_character(tmpGuard2ID).moveto(tmpInHouseRGpt2X+2,tmpInHouseRGpt2Y-2)
			get_character(tmpGuard3ID).moveto(tmpInHouseRGpt2X+3,tmpInHouseRGpt2Y-2)
			get_character(tmpGuard4ID).moveto(tmpInHouseRGpt2X+5,tmpInHouseRGpt2Y-2)
			get_character(tmpGuard1ID).direction = 8
			get_character(tmpGuard2ID).direction = 8
			get_character(tmpGuard3ID).direction = 8
			get_character(tmpGuard4ID).direction = 8
			get_character(tmpPiggyID).npc.fucker_condition={"sex"=>[65535, "="]}
			get_character(tmpPiggyID).npc.killer_condition={"sex"=>[65535, "="]}
			get_character(tmpPiggyID).npc.assaulter_condition={"sex"=>[65535, "="]}
			get_character(tmpPiggyID).move_type = 0
			get_character(tmpPiggyID).set_manual_move_type(0)
			get_character(tmpPiggyID).moveto(tmpWakeUpX-1,tmpWakeUpY+1)
			get_character(tmpPiggyID).animation = get_character(tmpPiggyID).animation_stun
			call_msg("TagMapBanditCamp2:RapeLoop/DailyJob1")
		chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapBanditCamp2:RapeLoop/DailyJob2")
		tmpPickJob = ["Vag","Anal","Mouth","RimJob","Dance"].sample
		get_character(tmpWakeUpID).summon_data[:job] = tmpPickJob
		call_msg("TagMapBanditCamp2:RapeLoop/DailyJob3_#{tmpPickJob}")
		call_msg("TagMapBanditCamp2:RapeLoop/DailyJob4")
		get_character(tmpPiggyID).call_balloon(28,-1)
		get_character(tmpPiggyID).trigger = 0
		set_event_force_page(tmpG1ID,1,4)
end


enter_static_tag_map
summon_companion
if $story_stats["OverMapForceTrans"] == 0
	chcg_background_color(0,0,0,255,-7) if $story_stats["ReRollHalfEvents"] ==1
end
eventPlayEnd
get_character(0).erase
