if $story_stats["Captured"] >= 1
	SndLib.bgm_play("D/Sinking_Feeling_120bpm_121s",75,90)
else
	SndLib.bgm_play("dock_Barren Settlement",80,150)
end
#SndLib.bgs_play("WATER_Sea_Waves_Small_20sec_loop_stereo",80,100)
inDoor = [55,14,56].include?($game_player.region_id)
if inDoor
	$game_map.shadows.set_color(120, 120, 120) if $game_date.day?
	$game_map.shadows.set_opacity(200)  if $game_date.day?
else
	$game_map.set_fog("mountainUP")
	$game_map.shadows.set_color(120, 120, 120) if $game_date.day?
	$game_map.shadows.set_opacity(110)  if $game_date.day?
end
map_background_color(135,128,128,20)
enter_static_tag_map
summon_companion
tmpP = $story_stats["BackStreetArrearsPrincipal"]
tmpInt = $story_stats["BackStreetArrearsInterest"]
if tmpInt >= tmpP && $story_stats["BackStreetArrearsPrincipal"] != 0
	$story_stats["Captured"] = 1
end
if $game_player.actor.stat["SlaveBrand"] == 1
	$story_stats["SlaveOwner"] = "NoerBackStreet"
	$story_stats["Captured"] = 1
end
#############################################################################################################################################
tmpH_BIOS_ID = $game_map.get_storypoint("H_BIOS")[2]
get_character(tmpH_BIOS_ID).summon_data[:AnalSpec] = nil #set to default
get_character(tmpH_BIOS_ID).summon_data[:WorkerMode] = false if $story_stats["Captured"] != 0 || $story_stats["RapeLoop"] != 0
tmpDoRngRapeloopEV = nil
if $story_stats["Captured"] >= 1
	get_character(tmpH_BIOS_ID).summon_data[:RapeLoopEvCount] -= 1
	tmpDoRngRapeloopEV = get_character(tmpH_BIOS_ID).summon_data[:RapeLoopEvCount] <= 0
end
#tmpDoRngRapeloopEV = true######################################################################  test
if ($game_player.actor.stat["SlaveBrand"] == 1 || $story_stats["SlaveOwner"] == "NoerBackStreet") && $game_player.actor.stat["DrugAddiction"] !=5 && $story_stats["Captured"] == 1 && $game_date.night?
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		tmpU1X,tmpU1Y,tmpU1ID=$game_map.get_storypoint("stGang1")
		if $story_stats["UniqueCharUniqueGangBoss"] == -1
			tmpU2X,tmpU2Y,tmpU2ID=$game_map.get_storypoint("GangBossREP")
		else
			tmpU2X,tmpU2Y,tmpU2ID=$game_map.get_storypoint("UniqueGangBoss")
		end
		get_character(tmpU1ID).npc_story_mode(true)
		get_character(tmpU2ID).npc_story_mode(true)
		set_event_force_page(tmpU1ID,1,0)
		get_character(tmpU1ID).moveto($game_player.x,$game_player.y)
		get_character(tmpU2ID).moveto($game_player.x,$game_player.y)
		get_character(tmpU1ID).direction = 6 ; get_character(tmpU1ID).move_forward_force
		get_character(tmpU1ID).direction = 4 ; get_character(tmpU2ID).move_forward_force
	chcg_background_color(0,0,0,255,-7)
	get_character(tmpU1ID).turn_toward_character($game_player)
	get_character(tmpU2ID).turn_toward_character($game_player)
	SndLib.sound_equip_armor
	get_character(tmpU1ID).animation = get_character(tmpU1ID).animation_grabber_qte($game_player)
	$game_player.animation = $game_player.animation_grabbed_qte
	if $story_stats["RecordBackStreetFirstTimeSlaveDrug"] == 0
		$story_stats["RecordBackStreetFirstTimeSlaveDrug"] =1
		$story_stats["UniqueCharUniqueGangBoss"] == -1 ? call_msg("TagMapNoerBackStreet:nap/drug_begin_FristTime_REP") : call_msg("TagMapNoerBackStreet:nap/drug_begin_FristTime")
	else
		$story_stats["UniqueCharUniqueGangBoss"] == -1 ? call_msg("TagMapNoerBackStreet:nap/drug_begin_SecondTime_REP") : call_msg("TagMapNoerBackStreet:nap/drug_begin_SecondTime")
	end
	
		$game_map.popup(0,"1",$data_items[24].icon_index,-1)
		$game_player.actor.itemUseBatch("ItemHiPotionLV2")
		$game_player.actor.drug_addiction_damage += rand(300)
	$story_stats["UniqueCharUniqueGangBoss"] == -1 ? call_msg("TagMapNoerBackStreet:nap/drug_begin_Eat_REP") : call_msg("TagMapNoerBackStreet:nap/drug_begin_Eat")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpU1ID).animation = nil
		$game_player.animation = nil
		get_character(tmpU1ID).npc_story_mode(false)
		get_character(tmpU2ID).npc_story_mode(false)
		get_character(tmpU1ID).moveto(1,1)
		get_character(tmpU2ID).moveto(tmpU2X,tmpU2Y)
		get_character(tmpU2ID).direction = 2
	chcg_background_color(0,0,0,255,-7)
elsif $story_stats["Captured"] == 1 && tmpDoRngRapeloopEV && ($game_player.actor.stat["SlaveBrand"] == 1 || $story_stats["SlaveOwner"] == "NoerBackStreet" )
	stGang1_X,stGang1_y,stGang1_ID=$game_map.get_storypoint("stGang1")
	stGang2_X,stGang2_y,stGang2_ID=$game_map.get_storypoint("stGang2")
	tmpRapeBed_X,tmpRapeBed_y,tmpRapeBed_ID=$game_map.get_storypoint("SexPoint8")
	tmpWakeUp_X,tmpWakeUp_Y,tmpWakeUpID=$game_map.get_storypoint("WakeUp")
	tmpCapPt_X,tmpCapPt_Y,tmpCapPtID=$game_map.get_storypoint("CapturedPoint")
	tmpEnemaPT_X,tmpEnemaPT_Y,tmpEnemaPTID=$game_map.get_storypoint("EnemaPT")
	get_character(tmpH_BIOS_ID).summon_data[:RapeLoopEvCount] = 2+rand(2)
	get_character(stGang1_ID).npc_story_mode(true)
	get_character(stGang2_ID).npc_story_mode(true)
	set_event_force_page(stGang1_ID,1,0)
	set_event_force_page(stGang2_ID,1,0)
	get_character(stGang1_ID).set_npc("GangHumanCommon")
	get_character(stGang2_ID).set_npc("GangHumanCommon")
	get_character(stGang1_ID).npc.fucker_condition={"sex"=>[65535, "="]}
	get_character(stGang2_ID).npc.fucker_condition={"sex"=>[65535, "="]}
	SndLib.bgm_scene_on
	tmpEVs = [
		"RngRape",
		"RngCustomer"
	]
	tmpEVs << "Enema" if $story_stats["Setup_ScatEffect"] >= 1
	tmpEVs << "PeeWash" if $story_stats["Setup_UrineEffect"] >= 1
	tgtEV = tmpEVs.sample
	if get_character(tmpH_BIOS_ID).summon_data[:LastRapeLoopRngEv] == tgtEV #reroll EV if same EV
		tmpEVs.delete(tgtEV)
		tgtEV = tmpEVs.sample
	end
	#tgtEV = "Enema"######################################################################  test
	get_character(tmpH_BIOS_ID).summon_data[:LastRapeLoopRngEv] = tgtEV
	case tgtEV
		when "RngCustomer"
			tmpEVs=$game_map.npcs.select{|event|
				next if event.summon_data == nil
				next if !event.summon_data[:RngCustomer]
				true
			}
			tgtEv = tmpEVs.sample
			tgtEv.moveto($game_player.x,$game_player.y+1)
			$game_player.direction = 2
			call_msg("TagMapNoerBackStreet:wakeup_rapeloop/RngCustomer_begin0")
			call_msg("TagMapNoerBackStreet:wakeup_rapeloop/RngRape0_wakeupCall_ans")
			chcg_background_color(0,0,0,255,-7)
			tgtEv.call_balloon(20)
			call_msg("TagMapNoerBackStreet:wakeup_rapeloop/RngCustomer_begin1")
			tgtEv.call_balloon(20)
			call_msg("TagMapNoerBackStreet:wakeup_rapeloop/RngCustomer_begin2")
			portrait_off
			slotTGT = ["vag","mouth","anal"].sample
			poseTGT = [1,2,5].sample
			play_sex_service_main(ev_target=tgtEv,temp_tar_slot=slotTGT,passive=true,tmpCumIn=true,forcePose=poseTGT,tmpAniStage=0,plus=1,loopAniMode=false)
			half_event_key_cleaner
			play_sex_service_main(ev_target=tgtEv,temp_tar_slot=slotTGT,passive=true,tmpCumIn=true,forcePose=poseTGT,tmpAniStage=1,plus=1,loopAniMode=false)
			half_event_key_cleaner
			play_sex_service_main(ev_target=tgtEv,temp_tar_slot=slotTGT,passive=true,tmpCumIn=true,forcePose=poseTGT,tmpAniStage=1,plus=1,loopAniMode=false)
			half_event_key_cleaner
			play_sex_service_main(ev_target=tgtEv,temp_tar_slot=slotTGT,passive=true,tmpCumIn=true,forcePose=poseTGT,tmpAniStage=2,plus=1,loopAniMode=false)
			portrait_off
			call_msg("TagMapNoerBackStreet:wakeup_rapeloop/RngCustomer_begin_end")
			portrait_off
			case slotTGT
				when "vag"
					$game_player.actor.stat["EventVagRace"] =  tgtEv.npc.race
					$game_player.actor.stat["EventVag"] = "CumInside1"
					load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
				when "mouth"
					$game_player.actor.stat["EventMouthRace"] =  tgtEv.npc.race
					$game_player.actor.stat["EventMouth"] = "CumInside1"
					load_script("Data/HCGframes/EventMouth_CumInside_Overcum.rb")
				when "anal"
					$game_player.actor.stat["EventAnalRace"] =  tgtEv.npc.race
					$game_player.actor.stat["EventAnal"] = "CumInside1"
					load_script("Data/HCGframes/EventAnal_CumInside_Overcum.rb")
			end
			portrait_off
			chcg_background_color(0,0,0,0,7)
				portrait_off
				$game_player.unset_event_chs_sex
				tgtEv.unset_event_chs_sex
				tgtEv.delete
			chcg_background_color(0,0,0,255,-7)
		when "PeeWash"
			portrait_hide
			call_msg("TagMapNoerBackStreet:wakeup_rapeloop/Peeon_begin0")
			call_msg("TagMapNoerBackStreet:wakeup_rapeloop/Peeon_begin1")
			portrait_off
			tmpTgtSlot = rand(4)+1
			tmpPrevSta = $game_player.actor.sta
			$game_player.actor.sta = 0
			$game_player.actor.stat["EventExt#{tmpTgtSlot}Race"]  = "Human"
			$game_player.actor.stat["EventExt#{tmpTgtSlot}"] ="Peeon"
			lona_mood "#{chcg_decider_peeon}fuck_#{chcg_shame_mood_decider}"
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -229 ; $game_player.actor.stat["chcg_y"] = -147 end
				if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -84 ; $game_player.actor.stat["chcg_y"] = -76 end
					$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
					$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
					load_script("Data/Batch/peeon_control.rb")
					check_over_event
					call_msg("commonH:Lona/frame_overfatigue#{rand(10)}")
					$story_stats["sex_record_golden_shower"] +=1
			call_msg("TagMapNoerBackStreet:wakeup_rapeloop/Peeon_begin_end")
			$game_player.actor.sta = tmpPrevSta

		when "Enema"
			call_msg("TagMapNoerBackStreet:wakeup_rapeloop/RngRape0_wakeupCall_begin0")
			get_character(tmpH_BIOS_ID).summon_data[:AnalSpec] = true
			get_character(tmpEnemaPTID).delete
			count = 0
			countXY_ary =[
					-2,
					-1,
					1,
					2
				]
			$game_map.npcs.each{|event|
				next if event.summon_data == nil
				next if !event.summon_data[:BsWhore]
				event.setup_audience
				event.summon_data[:tmpX] = event.x
				event.summon_data[:tmpY] = event.y
				event.summon_data[:tmpDir] = event.direction
				event.summon_data[:tmpMoveType] = event.move_type
				event.summon_data[:tmpCharacter_Index] = event.character_index
				event.moveto(tmpEnemaPT_X+countXY_ary[count],tmpEnemaPT_Y)
				event.character_index = 3
				event.animation = nil
				event.direction = 8
				count += 1
				break if count >= 3
			}
			cam_center(0)
			$game_player.moveto(tmpEnemaPT_X,tmpEnemaPT_Y)
			$game_player.direction = 8
			$game_player.character_index = 3
			$game_player.animation = $game_player.aniCustom([[10,3,0,0,0]],-1)
			get_character(stGang1_ID).moveto(tmpEnemaPT_X-3,tmpEnemaPT_Y+1)
			get_character(stGang1_ID).direction = 6
			$game_map.set_fog("mountainUP")
			$game_map.shadows.set_color(120, 120, 120) if $game_date.day?
			$game_map.shadows.set_opacity(110)  if $game_date.day?
			portrait_hide
			chcg_background_color(0,0,0,255,-7)
			portrait_off
			call_msg("TagMapNoerBackStreet:wakeup_rapeloop/RngRape0_wakeupCall_ans")
			call_msg("TagMapNoerBackStreet:wakeup_rapeloop/EnemaEV_begin0")
			count = 0
			portrait_hide
			wait(20)
			portrait_off
			2.times{
				get_character(stGang1_ID).direction = 6
				get_character(stGang1_ID).move_forward_force
				until !get_character(stGang1_ID).moving?
					wait(1)
				end
				get_character(stGang1_ID).direction = 8
				get_character(stGang1_ID).animation = get_character(stGang1_ID).animation_atk_sh
				SndLib.sound_Bubble(80,50)
				wait(40)
				count += 1
			}
				get_character(stGang1_ID).direction = 6
				get_character(stGang1_ID).move_forward_force
				until !get_character(stGang1_ID).moving?
					wait(1)
				end
				get_character(stGang1_ID).direction = 8
				wait(30)
				portrait_hide
				wait(10)
				portrait_off
				load_script("Data/HCGframes/UniqueEvent_Enema_BeginOnly.rb")
				count += 1
				portrait_off
			1.times{
				get_character(stGang1_ID).direction = 6
				get_character(stGang1_ID).move_forward_force
				until !get_character(stGang1_ID).moving?
					wait(1)
				end
				get_character(stGang1_ID).direction = 8
				get_character(stGang1_ID).animation = get_character(stGang1_ID).animation_atk_sh
				SndLib.sound_Bubble(80,50)
				wait(40)
				count += 1
			}
			get_character(stGang1_ID).direction = 6
			get_character(stGang1_ID).move_forward_force
			until !get_character(stGang1_ID).moving?
				wait(1)
			end
			get_character(stGang1_ID).direction = 4
			call_msg("TagMapNoerBackStreet:wakeup_rapeloop/EnemaEV_end")
			portrait_hide
			wait(10)
			portrait_off
			load_script("Data/HCGframes/OverEvent_Poo.rb")
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				portrait_off
				$game_player.animation = nil
				$game_player.direction = 6
				$game_player.move_normal
				#@anomally=Struct::FakeTarget.new(target.x,target.y)
				$game_map.npcs.each{|event|
					next if event.summon_data == nil
					next if !event.summon_data[:BsWhore]
					next if !event.summon_data[:tmpX]
					next if !event.summon_data[:tmpY]
					next if !event.summon_data[:tmpDir]
					event.animation = nil
					EvLib.sum("WastePoo1",event.x,event.y)
					event.direction = event.summon_data[:tmpDir]
					event.move_type = event.summon_data[:tmpMoveType]
					event.character_index = event.summon_data[:tmpCharacter_Index]
					event.actor.process_target_lost # move_type_return
				}
			chcg_background_color(0,0,0,255,-7)
		when "RngRape"
			call_msg("TagMapNoerBackStreet:wakeup_rapeloop/RngRape0_wakeupCall_begin0")
			get_character(stGang1_ID).moveto($game_player.x,$game_player.y)
			get_character(stGang2_ID).moveto($game_player.x,$game_player.y)
			get_character(stGang1_ID).move_forward_passable_dir
			get_character(stGang2_ID).move_forward_passable_dir
			until !get_character(stGang2_ID).moving? && !get_character(stGang1_ID).moving?
				wait(1)
			end
			get_character(stGang1_ID).turn_toward_character($game_player)
			get_character(stGang2_ID).turn_toward_character($game_player)
			until !get_character(stGang1_ID).moving? && !get_character(stGang2_ID).moving?
				wait(1)
			end
			portrait_hide
			chcg_background_color(0,0,0,255,-7)
			portrait_off
			call_msg("TagMapNoerBackStreet:wakeup_rapeloop/RngRape0_wakeupCall_rapeloop")
			call_msg("TagMapNoerBackStreet:wakeup_rapeloop/RngRape0_wakeupCall_ans")
			if inDoor
				portrait_hide
				chcg_background_color(0,0,0,0,7)
					portrait_off
					call_msg("TagMapNoerBackStreet:wakeup_rapeloop/RngRape1_to_Somewhere")
					$game_player.moveto(tmpRapeBed_X+1,tmpRapeBed_y)
					$game_player.animation = nil
					get_character(stGang1_ID).moveto($game_player.x,$game_player.y)
					get_character(stGang2_ID).moveto($game_player.x,$game_player.y)
					get_character(stGang1_ID).move_forward_passable_dir
					get_character(stGang2_ID).move_forward_passable_dir
					until !get_character(stGang2_ID).moving? && !get_character(stGang1_ID).moving?
						wait(1)
					end
					get_character(stGang1_ID).turn_toward_character($game_player)
					get_character(stGang2_ID).turn_toward_character($game_player)
					until !get_character(stGang1_ID).moving? && !get_character(stGang2_ID).moving?
						wait(1)
					end
				chcg_background_color(0,0,0,255,-7)
			end
			$game_player.animation = nil


			call_msg("TagMapNoerBackStreet:wakeup_rapeloop/RngRape2")
			$game_player.animation = $game_player.animation_grabbed_qte
			SndLib.sound_equip_armor(100)
			get_character(stGang1_ID).animation = get_character(stGang1_ID).animation_grabber_qte($game_player)
			wait(60)
			portrait_off
			slotTGT = ["vag","mouth","anal"].sample
			play_sex_service_main(ev_target=get_character(stGang1_ID),temp_tar_slot=slotTGT,passive=true,tmpCumIn=true,forcePose=nil,tmpAniStage=0,plus=1,loopAniMode=false)
			half_event_key_cleaner
			play_sex_service_main(ev_target=get_character(stGang1_ID),temp_tar_slot=slotTGT,passive=true,tmpCumIn=true,forcePose=nil,tmpAniStage=1,plus=1,loopAniMode=false)
			half_event_key_cleaner
			play_sex_service_main(ev_target=get_character(stGang1_ID),temp_tar_slot=slotTGT,passive=true,tmpCumIn=true,forcePose=nil,tmpAniStage=2,plus=1,loopAniMode=false)
			portrait_off
			call_msg("TagMapNoerBackStreet:wakeup_rapeloop/RngRape_cum#{rand(5)}")
			portrait_off
			case slotTGT
				when "vag"
					$game_player.actor.stat["EventVagRace"] =  "Human"
					$game_player.actor.stat["EventVag"] = "CumInside1"
					load_script("Data/HCGframes/EventVag_CumInside.rb")
				when "mouth"
					$game_player.actor.stat["EventMouthRace"] =  "Human"
					$game_player.actor.stat["EventMouth"] = "CumInside1"
					load_script("Data/HCGframes/EventMouth_CumInside.rb")
				when "anal"
					$game_player.actor.stat["EventAnalRace"] =  "Human"
					$game_player.actor.stat["EventAnal"] = "CumInside1"
					load_script("Data/HCGframes/EventAnal_CumInside.rb")
			end
			portrait_off
			$game_player.unset_event_chs_sex
			get_character(stGang1_ID).unset_event_chs_sex
			call_msg("TagMapNoerBackStreet:wakeup_rapeloop/RngRape3")
			event_key_cleaner



			$game_player.animation = $game_player.animation_grabbed_qte
			SndLib.sound_equip_armor(100)
			get_character(stGang2_ID).animation = get_character(stGang2_ID).animation_grabber_qte($game_player)
			wait(60)
			portrait_off
			slotTGT = ["vag","mouth","anal"].sample
			play_sex_service_main(ev_target=get_character(stGang2_ID),temp_tar_slot=slotTGT,passive=true,tmpCumIn=true,forcePose=nil,tmpAniStage=0,plus=1,loopAniMode=false)
			half_event_key_cleaner
			play_sex_service_main(ev_target=get_character(stGang2_ID),temp_tar_slot=slotTGT,passive=true,tmpCumIn=true,forcePose=nil,tmpAniStage=1,plus=1,loopAniMode=false)
			half_event_key_cleaner
			play_sex_service_main(ev_target=get_character(stGang2_ID),temp_tar_slot=slotTGT,passive=true,tmpCumIn=true,forcePose=nil,tmpAniStage=2,plus=1,loopAniMode=false)
			portrait_off
			call_msg("TagMapNoerBackStreet:wakeup_rapeloop/RngRape_cum#{rand(5)}")
			portrait_off
			case slotTGT
				when "vag"
					$game_player.actor.stat["EventVagRace"] =  "Human"
					$game_player.actor.stat["EventVag"] = "CumInside1"
					load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
				when "mouth"
					$game_player.actor.stat["EventMouthRace"] =  "Human"
					$game_player.actor.stat["EventMouth"] = "CumInside1"
					load_script("Data/HCGframes/EventMouth_CumInside_Overcum.rb")
				when "anal"
					$game_player.actor.stat["EventAnalRace"] =  "Human"
					$game_player.actor.stat["EventAnal"] = "CumInside1"
					load_script("Data/HCGframes/EventAnal_CumInside_Overcum.rb")
			end
			portrait_off
			$game_player.unset_event_chs_sex
			get_character(stGang2_ID).unset_event_chs_sex
			call_msg("TagMapNoerBackStreet:wakeup_rapeloop/RngRape_end#{rand(3)}")

	end

	chcg_background_color(0,0,0,0,7)
		portrait_off
		$game_player.animation = nil
		get_character(stGang1_ID).animation = nil
		get_character(stGang2_ID).animation = nil
		get_character(stGang1_ID).npc_story_mode(false)
		get_character(stGang2_ID).npc_story_mode(false)
		get_character(stGang1_ID).moveto(1,1)
		get_character(stGang2_ID).moveto(1,1)
		$game_map.delete_npc(get_character(stGang1_ID))
		$game_map.delete_npc(get_character(stGang2_ID))
		half_event_key_cleaner
		whole_event_end
		SndLib.scene_off
	chcg_background_color(0,0,0,255,-7)
	call_msg("commonH:Lona/frame#{talk_style}#{rand(10)}")

######################################### Normally wake up call to everyone to do their JOB
elsif $story_stats["Captured"] == 1 && $game_date.day?
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		if $story_stats["UniqueCharUniqueHappyMerchant"] != -1
			tmpHMX,tmpHMY,tmpHMID=$game_map.get_storypoint("HappyMerchant")
		else
			tmpHMX,tmpHMY,tmpHMID=$game_map.get_storypoint("HappyMerchantREP")
		end
		tmpTarBSslaveHX,tmpTarBSslaveHY,tmpTarBSslaveHID=$game_map.get_storypoint("TarBSslaveH")
		tmpDIR = get_character(tmpHMID).direction
		get_character(tmpHMID).moveto(tmpTarBSslaveHX,tmpTarBSslaveHY)
		get_character(tmpHMID).direction = 8
		$game_player.direction = 2
	chcg_background_color(0,0,0,255,-7)
	$story_stats["UniqueCharUniqueGangBoss"] == -1 ? call_msg("TagMapNoerBackStreet:nap/WhoreWakeUp_REP") : call_msg("TagMapNoerBackStreet:nap/WhoreWakeUp")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		cam_center(0)
		get_character(tmpHMID).moveto(tmpHMX,tmpHMY)
		get_character(tmpHMID).direction = tmpDIR
		tmpEVs=$game_map.npcs.select{|event|
			next if event.summon_data == nil
			next if !event.summon_data[:RngCustomer]
			true
		}
		tmpEVs = tmpEVs.shuffle
		tmpEVs.first.moveto($game_player.x,$game_player.y+2)
		tmpEVs.first.direction = 8
		tmpEVs.first.move_type = :move_toward_player_no_rng
		tmpEVs.first.set_manual_move_type(:move_toward_player_no_rng)
		tmpEVs.delete(tmpEVs.first)
		count = rand(3)+1
		tmpEVs.each{|event|
			count += 1
			next if count >= 4 # max 4 ppl
			event.moveto(tmpTarBSslaveHX,tmpTarBSslaveHY)
			event.move_type = :move_toward_player_no_rng
			event.set_manual_move_type(:move_toward_player_no_rng)
		}
	chcg_background_color(0,0,0,255,-7)
end

call_msg("TagMapNoerBackStreet:nap/SlavePrice") if $story_stats["Captured"] == 1 && $game_player.actor.stat["SlaveBrand"] == 1 && $story_stats["SlaveOwner"] == "NoerBackStreet"

eventPlayEnd
