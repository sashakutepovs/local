tmpNapMode = nil
tmpWarbossEV = nil
if $story_stats["UniqueCharUniqueOgreWarBoss"] != -1
	tmpMobAlive = $game_map.npcs.any?{|event| 
		next unless event.summon_data
		next unless event.summon_data[:IsWarBoss]
		next if event.deleted?
		next if event.npc.action_state == :death
		tmpWarbossEV = event
		true
	}
	tmpMobAlive = true
	$story_stats["RapeLoop"] = 1 if tmpMobAlive
end

#if $story_stats["tmpData"] == "WarBossRapeLoop" && $story_stats["UniqueCharUniqueOgreWarBoss"] != -1
#	$story_stats["tmpData"] = nil
#	$story_stats["RapeLoop"] = 1
#	$story_stats["Captured"] = 1
#end
tmp_backgrounded = false
###########################################正片
if $story_stats["RapeLoop"] >= 1 && tmpMobAlive && tmpWarbossEV
	$story_stats["DreamPTSD"] = "Orkind" if $game_player.actor.mood <= -50
	################################################ use capture to check first time capture dialog
	if $story_stats["Captured"] == 0
		$story_stats["Captured"] = 1
		############################################################################## STORY MODE. LOST OGRE WARBOSS. HC RAPE BY WARBOSS
		############################################################################## STORY MODE. LOST OGRE WARBOSS. HC RAPE BY WARBOSS
		############################################################################## STORY MODE. LOST OGRE WARBOSS. HC RAPE BY WARBOSS
		############################################################################## STORY MODE. LOST OGRE WARBOSS. HC RAPE BY WARBOSS
		if tmpWarbossEV.summon_data[:StoryMode] == true
			$hudForceHide = true
			SndLib.bgm_stop
			SndLib.bgs_stop
			SndLib.bgs_play("D/ATMO EERIE Cave, Water Drips, Emptyness, Howling Interior Wind, Oppressive, LOOP",50)
			tmpWarbossEV.end_combo_skill
			tmpWarbossEV.actor.process_target_lost
			tmpWarbossEV.character_index = tmpWarbossEV.chs_definition.chs_default_index[tmpWarbossEV.charset_index]
			tmpWarbossEV.animation = nil
			tmpWarbossEV.move_type = 0
			tmpWarbossEV.npc.battle_stat.set_stat_m("sta",1000,[0,2,3])
			tmpWarbossEV.manual_move_type = 0
			tmpWarbossEV.npc_story_mode(true)
			call_msg("TagMapSyb_WarBossRoom:Warboss/rapeloop_begin1") ; portrait_hide
			tarX,tarY=[$game_player.x,$game_player.y]
			tarRange = tmpWarbossEV.report_range($game_player)
			5.times{
				tmpWarbossEV.move_goto_xy(tarX,tarY) if tarRange >= 2
				tmpWarbossEV.move_speed  = 3.5
				until !tmpWarbossEV.moving?; wait(1) end
			}
			tmpX,tmpY = $game_player.get_item_jump_xy
			SndLib.sys_equip
			tmpWarbossEV.jump_to(tmpX,tmpY)
			tmpWarbossEV.turn_toward_character($game_player)
			
			#warboss yelling
			wait(60)
			call_msg("TagMapSyb_WarBossRoom:Warboss/rapeloop_begin2") ; portrait_hide
			
			##Boob Touch Grab 
			tmpWarbossEV.call_balloon(3)
			SndLib.sound_OgreSpot(100)
			wait(60)
			tmpWarbossEV.animation = tmpWarbossEV.animation_grabber_qte($game_player)
			$game_player.animation = $game_player.animation_grabbed_qte
			combat_Hevent_Grab_BoobTouch("Orkind",20)
			wait(30)
			call_msg("TagMapSyb_WarBossRoom:Warboss/rapeloop_begin3") ; portrait_hide
			#todo  remove mid  bot midext and put to chest
			whole_event_end
			lona_mood "p5shame"
			tmpWarbossEV.animation = tmpWarbossEV.animation_melee_touch_target($game_player)
			SndLib.sound_DressTear

			slotList = $data_system.equip_type_name
			!equip_slot_removetable?("MH")		? equips_MH_id = -1 :		equips_MH_id =		$game_player.actor.equips[slotList["MH"]].item_name		#0
			!equip_slot_removetable?("SH")		? equips_SH_id = -1 :		equips_SH_id =		$game_player.actor.equips[slotList["SH"]].item_name		#1
			!equip_slot_removetable?("Top")		? equips_Top_id = -1 :		equips_Top_id =		$game_player.actor.equips[slotList["Top"]].item_name	#2
			!equip_slot_removetable?("Mid")		? equips_Mid_id = -1 :		equips_Mid_id =		$game_player.actor.equips[slotList["Mid"]].item_name	#3
			!equip_slot_removetable?("Bot")		? equips_Bot_id = -1 :		equips_Bot_id =		$game_player.actor.equips[slotList["Bot"]].item_name	#4
			!equip_slot_removetable?("TopExt")	? equips_TopExt_id = -1 :	equips_TopExt_id =	$game_player.actor.equips[slotList["TopExt"]].item_name	#5
			!equip_slot_removetable?("MidExt")	? equips_MidExt_id = -1 :	equips_MidExt_id =	$game_player.actor.equips[slotList["MidExt"]].item_name	#6
			!equip_slot_removetable?("Hair")	? equips_Hair_id = -1 :		equips_Hair_id =	$game_player.actor.equips[slotList["Hair"]].item_name	#7
			!equip_slot_removetable?("Head")	? equips_Head_id = -1 :		equips_Head_id =	$game_player.actor.equips[slotList["Head"]].item_name	#8
			!equip_slot_removetable?("Neck")	? equips_Neck_id = -1 :		equips_Neck_id =	$game_player.actor.equips[slotList["Neck"]].item_name	#14
			!equip_slot_removetable?("Vag")		? equips_Vag_id = -1 :		equips_Vag_id =		$game_player.actor.equips[slotList["Vag"]].item_name	#15
			!equip_slot_removetable?("Anal")	? equips_Anal_id = -1 :		equips_Anal_id =	$game_player.actor.equips[slotList["Anal"]].item_name	#16


			#!equip_slot_removetable?(1) ? equips_1_id = -1 : equips_1_id = $game_player.actor.equips[1].id #SH
			#!equip_slot_removetable?(0) ? equips_0_id = -1 : equips_0_id = $game_player.actor.equips[0].id #MH
			$game_party.lose_item($data_ItemName[equips_MidExt_id],1,true) if equips_MidExt_id != -1
			$game_party.lose_item($data_ItemName[equips_Bot_id],1,true) if equips_Bot_id != -1
			$game_party.lose_item($data_ItemName[equips_Mid_id],1,true) if equips_Mid_id != -1
			$game_party.lose_item($data_ItemName[equips_Anal_id],1,true) if equips_Anal_id != -1
			$game_party.lose_item($data_ItemName[equips_Vag_id],1,true) if equips_Vag_id != -1
			$game_party.lose_item($data_ItemName[equips_Head_id],1,true) if equips_Head_id != -1
			#$game_party.lose_item($data_armors[equips_1_id],1,true) if equips_1_id != -1
			#$game_party.lose_item($data_armors[equips_0_id],1,true) if equips_0_id != -1
			#put item to storage
			$game_boxes.box(System_Settings::STORAGE_TEMP_MAP)[$data_ItemName[equips_MidExt_id]] = 1 if equips_MidExt_id != -1
			$game_boxes.box(System_Settings::STORAGE_TEMP_MAP)[$data_ItemName[equips_Bot_id]] = 1 if equips_Bot_id != -1
			$game_boxes.box(System_Settings::STORAGE_TEMP_MAP)[$data_ItemName[equips_Mid_id]] = 1 if equips_Mid_id != -1
			$game_boxes.box(System_Settings::STORAGE_TEMP_MAP)[$data_ItemName[equips_Anal_id]] = 1 if equips_Anal_id != -1
			$game_boxes.box(System_Settings::STORAGE_TEMP_MAP)[$data_ItemName[equips_Vag_id]] = 1 if equips_Vag_id != -1
			$game_boxes.box(System_Settings::STORAGE_TEMP_MAP)[$data_ItemName[equips_Head_id]] = 1 if equips_Head_id != -1
			#$game_boxes.box(System_Settings::STORAGE_TEMP_MAP)[$data_armors[equips_1_id]] = 1 if equips_1_id != -1
			#$game_boxes.box(System_Settings::STORAGE_TEMP_MAP)[$data_armors[equips_0_id]] = 1 if equips_0_id != -1
			SndLib.sound_equip_armor(100)
			player_force_update
			$story_stats["dialog_dress_out"] = 1
			
			#Lona tried  pushwarboss away
			call_msg("TagMapSyb_WarBossRoom:Warboss/rapeloop_begin4") ; portrait_hide
			$game_player.turn_toward_character(tmpWarbossEV)
			$game_player.animation = $game_player.animation_atk_mh
			SndLib.sound_whoosh 
			wait(5)
			SndLib.sound_punch_hit(100)
			tmpWarbossEV.jump_to(tmpWarbossEV.x,tmpWarbossEV.y)
			wait(60)
			tmpWarbossEV.call_balloon(8)
			tmpWarbossEV.animation = tmpWarbossEV.animation_grabber_qte($game_player)
			$game_player.animation = $game_player.animation_grabbed_qte
			wait(60)
			SndLib.sound_OgreQuestion(50)
			$game_portraits.setLprt("ogre_warboss")
			$game_portraits.lprt.shake
			tmpWarbossEV.call_balloon(5)
			wait(60)
			
			#ogre mad and do belly punch
			tmpWarbossEV.call_balloon(5)
			SndLib.sound_OgreSkill(50)
			tmpWarbossEV.animation = tmpWarbossEV.animation_atk_sh
			wait(10)
				whole_event_end
				$game_player.actor.add_wound("belly")
				$game_player.actor.add_wound("belly")
				combat_Hevent_Grab_Punch("Orkind",20)
				wait(10)
				tmpWarbossEV.animation = tmpWarbossEV.animation_grabber_qte($game_player)
				$game_player.animation = $game_player.animation_grabbed_qte
				$game_player.jump_to($game_player.x,$game_player.y) ; #$game_player.animation = $game_player.animation_stun
				lona_mood "p5crit_damage"
				call_msg("commonH:Lona/beaten#{rand(10)}")
				whole_event_end
					$game_player.actor.add_wound("belly")
					$game_player.actor.add_wound("belly")
				combat_Hevent_Grab_Punch("Orkind",20)
				tmpWarbossEV.animation = tmpWarbossEV.animation_atk_sh
				SndLib.sound_OgreSkill(50,120+rand(20))
				$game_player.jump_to($game_player.x,$game_player.y) ; #$game_player.animation = $game_player.animation_stun
				wait(40)
				tmpWarbossEV.animation = tmpWarbossEV.animation_grabber_qte($game_player)
				$game_player.animation = $game_player.animation_grabbed_qte
				whole_event_end
				$game_player.jump_to($game_player.x,$game_player.y) ; #$game_player.animation = $game_player.animation_stun
				lona_mood "p5crit_damage"
				call_msg("commonH:Lona/beaten#{rand(10)}")
				wait(40)
				whole_event_end
			$game_player.actor.stat["EventMouthRace"] = "Orkind"
			load_script("Data/HCGframes/UniqueEvent_FacePunch.rb")
			load_script("Data/HCGframes/OverEvent_Pee.rb")
			portrait_off
			$game_player.animation = $game_player.animation_stun
			wait(60)
			tmpWarbossEV.call_balloon(8)
			wait(60)
			
			
			
			call_msg("TagMapSyb_WarBossRoom:Warboss/rapeloop_begin5") ; portrait_hide
			#call_msg("commonH:Lona/beaten#{rand(10)}")
			#SndLib.sound_OgreQuestion(100)
			#$game_portraits.setLprt("ogre_warboss")
			#$game_portraits.lprt.shake
			#$game_portraits.rprt.fade
			#tmpWarbossEV.call_balloon(4)
			
			
			######### lick vag  taste pee
			wait(60)
			SndLib.sys_equip
			tmpWarbossEV.animation = tmpWarbossEV.animation_grabber_qte($game_player)
			$game_player.animation = $game_player.animation_grabbed_qte
			portrait_hide
			combat_Hevent_Grab_VagLick("Orkind",20)
			wait(60)
			call_msg("TagMapSyb_WarBossRoom:Warboss/rapeloop_begin6") ; portrait_hide
			portrait_hide
			3.times{
				combat_Hevent_Grab_VagLick("Orkind",20)
				wait(60)
			}
			
			
			#npc_sex_service_main(tmpWarbossEV,$game_player,"mouth",0,2)
			#call_msg("Lona says >w< 2")
			#$game_player.actor.stat["EventMouthRace"] = "Orkind"
			#load_script("Data/HCGframes/UniqueEvent_DeepThroat.rb")
			#whole_event_end
			#check_over_event
			#check_half_over_event
			#call_msg("Lona says >w< 1")
			#call_msg("Lona says >w< 2")
			
			###############  decide to test her VAG
			call_msg("TagMapSyb_WarBossRoom:Warboss/rapeloop_begin7") ; portrait_hide
			$game_player.actor.stat["EventVagRace"] = "Orkind"
			$game_player.animation = $game_player.animation_stun
			load_script("Data/HCGframes/UniqueEvent_VagDilatation.rb")
			whole_event_end
			check_over_event
			check_half_over_event
			portrait_hide
			
			
			
			#tmpWarbossEV.unset_chs_sex
			#$game_player.unset_chs_sex
			wait(30)
			tmpWarbossEV.animation = tmpWarbossEV.animation_grabber_qte($game_player)
			$game_player.animation = $game_player.animation_grabbed_qte
			wait(30)
			tmpWarbossEV.animation = tmpWarbossEV.animation_melee_touch_target($game_player)
			wait(30)
			call_msg("TagMapSyb_WarBossRoom:Warboss/rapeloop_begin8") ; portrait_hide
			portrait_off
			half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
			play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=0,tmpAniStage=0)
			half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
			play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=0,tmpAniStage=0)
			half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
			play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=0,tmpAniStage=0)
			half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
			play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=0,tmpAniStage=1)
			half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
			play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=0,tmpAniStage=1)
			half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
			play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=0,tmpAniStage=1)
			portrait_off
			half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
			play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=0,tmpAniStage=2)
			$game_player.actor.stat["EventVagRace"] =  "Orkind"
			$game_player.actor.stat["EventVag"] = "CumInside1"
			tmpWarbossEV.actor.play_sound(:sound_death,100,110)
			load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
			$game_player.actor.addCums("CumsCreamPie",1000,"Orkind")
			$game_player.actor.addCums("CumsCreamPie",1000,"Orkind")
			portrait_off
			
			call_msg("TagMapSyb_WarBossRoom:Warboss/rapeloop_begin9") ; portrait_hide
			portrait_off
			play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="anal",passive=true,tmpCumIn=true,forcePose=1,tmpAniStage=1)
			half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
			play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="anal",passive=true,tmpCumIn=true,forcePose=1,tmpAniStage=1)
			half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
			play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="anal",passive=true,tmpCumIn=true,forcePose=1,tmpAniStage=2)
			portrait_off
			$game_player.actor.stat["EventAnalRace"] =  "Orkind"
			$game_player.actor.stat["EventAnal"] = "CumInside1"
			tmpWarbossEV.actor.play_sound(:sound_death,100,110)
			load_script("Data/HCGframes/EventAnal_CumInside_Overcum.rb")
			$game_player.actor.addCums("CumsMoonPie",1000,"Orkind")
			$game_player.actor.addCums("CumsMoonPie",1000,"Orkind")
			portrait_off
			
			call_msg("TagMapSyb_WarBossRoom:Warboss/rapeloop_begin10") ; portrait_hide
			portrait_off
			tmpWarbossEV.forced_z = 10
			play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=1)
			half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
			play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=1)
			half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
			play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=2)
			half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
			$game_player.actor.stat["EventVagRace"] =  "Orkind"
			$game_player.actor.stat["EventVag"] = "CumInside1"
			tmpWarbossEV.actor.play_sound(:sound_death,100,110)
			load_script("Data/HCGframes/EventVag_CumInside_Overcum_Peein.rb")
			$game_player.actor.addCums("CumsCreamPie",1000,"Orkind")
			$game_player.actor.addCums("CumsCreamPie",1000,"Orkind")
			play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=0)
			play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=1)
			play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=1)
			portrait_off
			$game_player.actor.sta = -100
			$game_player.actor.addCums("CumsCreamPie",1000,"Orkind")
			$game_player.actor.addCums("CumsCreamPie",1000,"Orkind")
			$game_player.actor.addCums("CumsCreamPie",1000,"Orkind")
			$game_player.actor.addCums("CumsMoonPie",1000,"Orkind")
			$game_player.actor.addCums("CumsMoonPie",1000,"Orkind")
			$game_player.actor.addCums("CumsMoonPie",1000,"Orkind")
			
			npc_sex_service_main(tmpWarbossEV,$game_player,"vag",4,2)
			portrait_off
			call_msg("common:Lona/NapRape_noSta")
			call_msg("TagMapSyb_WarBossRoom:Warboss/rapeloop_begin11") ; portrait_hide
			tmp_backgrounded = true
			chcg_background_color(0,0,0,0,7)
			map_background_color(0,0,0,255,0)
			portrait_hide
			$game_player.actor.sta = -100
			$game_player.actor.health = $game_player.actor.battle_stat.get_stat("health",2)
			$hudForceHide = false
			call_msg("TagMapSyb_WarBossRoom:Warboss/rapeloop_begin12") ; portrait_hide
			
		############################################################################## not story mode. common rape loop by gobs. captured by warboss
		else #!tmpWarbossEV.summon_data[:StoryMode]
			tmp_backgrounded = true
			chcg_background_color(0,0,0,0,7) if !tmp_backgrounded
			map_background_color(0,0,0,255,0)
			load_script("Data/HCGframes/event/OrkindCave_NapGangRape.rb")
		end
		

	############################################################################## Already captured.  Warboss rape whole nap time
	############################################################################## Already captured.  Warboss rape whole nap time
	############################################################################## Already captured.  Warboss rape whole nap time
	############################################################################## Already captured.  Warboss rape whole nap time
	elsif $story_stats["Captured"] >= 1 && $game_player.npc_control_mode?
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			tmpWarbossEV.actor.player_control_mode(false)
			tmpWarbossEV.end_combo_skill
			tmpWarbossEV.actor.process_target_lost
			tmpWarbossEV.character_index = tmpWarbossEV.chs_definition.chs_default_index[tmpWarbossEV.charset_index]
			tmpWarbossEV.animation = nil
			tmpWarbossEV.move_type = 0
			tmpWarbossEV.npc.battle_stat.set_stat_m("sta",1000,[0,2,3])
			tmpWarbossEV.manual_move_type = 0
			tmpWarbossEV.unset_chs_sex
			$game_player.unset_chs_sex
			
			$game_player.actor.is_object = false
			$game_player.actor.is_a_ProtectShield = false
			$game_player.transparent = false
			$game_player.opacity = 255
			
			tmpChoose = rand(15)
			case tmpChoose
				when 0..6	; forcePose = 1 ; temp_tar_slot = "anal"
				when 7..12	; forcePose = 0 ; temp_tar_slot = "mouth"
				else		; forcePose = 4 ; temp_tar_slot = "vag"
			end
			npc_sex_service_main(tmpWarbossEV,$game_player,temp_tar_slot,forcePose,0)
			call_msg("TagMapSyb_WarBossRoom:Warboss/rapeloop_nap1")
		chcg_background_color(0,0,0,255,-7)
		tmpWarbossEV.npc_story_mode(true)
		case tmpChoose
			when 0..6
				##########################################do anal
				portrait_off
				play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="anal",passive=true,tmpCumIn=true,forcePose,tmpAniStage=0)
				half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
				play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="anal",passive=true,tmpCumIn=true,forcePose,tmpAniStage=0)
				half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
				play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="anal",passive=true,tmpCumIn=true,forcePose,tmpAniStage=1)
				half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
				play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="anal",passive=true,tmpCumIn=true,forcePose,tmpAniStage=2)
				portrait_off
				$game_player.actor.stat["EventAnalRace"] =  "Orkind"
				$game_player.actor.stat["EventAnal"] = "CumInside1"
				tmpWarbossEV.actor.play_sound(:sound_death,100,110)
				load_script("Data/HCGframes/EventAnal_CumInside_Overcum.rb")
				portrait_off
				
			when 7..12
				##########################################do mouth
				portrait_off
				play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="mouth",passive=true,tmpCumIn=true,forcePose,tmpAniStage=0)
				half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
				play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="mouth",passive=true,tmpCumIn=true,forcePose,tmpAniStage=0)
				half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
				play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="mouth",passive=true,tmpCumIn=true,forcePose,tmpAniStage=1)
				half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
				play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="mouth",passive=true,tmpCumIn=true,forcePose,tmpAniStage=2)
				portrait_off
				$game_player.actor.stat["EventMouthRace"] =  "Orkind"
				$game_player.actor.stat["EventMouth"] = "CumInside1"
				tmpWarbossEV.actor.play_sound(:sound_death,100,110)
				load_script("Data/HCGframes/EventMouth_CumInside_OvercumStay.rb")
				portrait_off
				
			else
				##########################################do vag
				portrait_off
				play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=0)
				half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
				play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=0)
				half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
				play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=1)
				half_event_key_cleaner ; SndLib.sound_OgreSkill(100)
				play_sex_service_main(ev_target=tmpWarbossEV,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4,tmpAniStage=2)
				portrait_off
				$game_player.actor.stat["EventMouthRace"] =  "Orkind"
				$game_player.actor.stat["EventMouth"] = "CumInside1"
				tmpWarbossEV.actor.play_sound(:sound_death,100,110)
				load_script("Data/HCGframes/EventVag_CumInside_OvercumStay.rb")
				portrait_off
		end
		temp_record_anal_count 		= rand(2)	;$story_stats["sex_record_anal_count"] 			+= temp_record_anal_count
		temp_record_vaginal_count	= rand(2)	;$story_stats["sex_record_vaginal_count"] 		+= temp_record_vaginal_count
		temp_record_mouth_count 	= rand(2)	;$story_stats["sex_record_mouth_count"] 		+= temp_record_mouth_count
		temp_record_cumin_anal 		= rand(2)	;$story_stats["sex_record_cumin_anal"] 			+= temp_record_cumin_anal
		temp_record_cumin_mouth 	= rand(2)	;$story_stats["sex_record_cumin_mouth"] 		+= temp_record_cumin_mouth
		temp_record_cumin_vaginal	= rand(2)	;$story_stats["sex_record_cumin_vaginal"] 		+= temp_record_cumin_vaginal
		temp_record_cumshotted 		= rand(2)	;$story_stats["sex_record_cumshotted"] 			+= temp_record_cumshotted
		temp_record_anal_wash 		= rand(2)	;$story_stats["sex_record_anal_wash"] 			+= temp_record_anal_wash	if $story_stats["Setup_UrineEffect"] >=1
		temp_record_piss_drink		= rand(2)	;$story_stats["sex_record_piss_drink"] 			+= temp_record_piss_drink	if $story_stats["Setup_UrineEffect"] >=1
		temp_record_pussy_wash		= rand(2)	;$story_stats["sex_record_pussy_wash"]			+= temp_record_pussy_wash	if $story_stats["Setup_UrineEffect"] >=1
		$game_player.actor.addCums("CumsCreamPie",1000,"Orkind")
		$game_player.actor.addCums("CumsMoonPie",1000,"Orkind")
		$game_player.actor.addCums("CumsMouth",1000,"Orkind")
		half_event_key_cleaner
		call_msg("TagMapSyb_WarBossRoom:Warboss/rapeloop_nap2")
		portrait_hide
	end # $story_stats["Captured"] == 0
	
	chcg_background_color(0,0,0,0,7) if !tmp_backgrounded
	map_background_color(0,0,0,255,0)
	$story_stats["Ending_MainCharacter"] = "Ending_MC_OrkindCampCaptured"
	
	######################上銬模組################
	rape_loop_drop_item(tmpEquip=false,tmpSummon=false,lostItem=true,keepInBox=true)  #解除玩家裝備批次黨
	!equip_slot_removetable?(5) ? equips_5_id = -1 : equips_5_id = $game_player.actor.equips[5].id #TOP EXT
	!equip_slot_removetable?(0) ? equips_0_id = -1 : equips_0_id = $game_player.actor.equips[0].id #Weapon
	call_msg("TagMapRandOrkindCave:Lona/RapeLoopBondage") if ![21,20].include?(equips_0_id) && ![22,21].include?(equips_5_id)
	if ![21,20].include?(equips_0_id) && ![22,21].include?(equips_5_id)
		tmp = $story_stats["WorldDifficulty"]
		$story_stats["WorldDifficulty"] = 100
		load_script("Data/Batch/Put_HeavyestBondage.rb") #上銬批次檔
		$story_stats["WorldDifficulty"] = tmp
		$cg.erase
	end
	#################################  懷孕檢查  #############################
	if $story_stats["Record_CapturedPregCheckPassed"] !=1 && rand(100)+1 >= 75 || $game_actors[1].preg_level >=2
		load_script("Data/HCGframes/event/OrkindMonsterPregCheck.rb")
	end
	
	
	
	if rand(100) > 50 || ($story_stats["Record_CapturedPregCheckPassed"] == 1 && ["Goblin","Orkind"].include?($game_player.actor.baby_race)) #$game_player.actor.sat <=20   #強制餵食
		$game_player.actor.stat["EventMouthRace"] = "Orkind"
		call_msg("commonH:Lona/ForceFeeding_OrkindRapeLoop")
		load_script("Data/HCGframes/UniqueEvent_ForceFeed.rb")
		$game_player.actor.baby_health += 500 if ["Goblin","Orkind"].include?($game_player.actor.baby_race)
	end
	
	
	
	
	if $game_player.actor.preg_level ==5
		load_script("Data/Batch/birth_trigger.rb")
	end
	tmpNapMode = "rapeloop"
else
	##如果在安全區
	tmpNapMode = "normal"
end

if tmpNapMode
	case tmpNapMode
		when "normal"		;handleNap
		when "rapeloop"		;handleNap(:point,map_id,"OgreWarBoss")
	end
	#chcg_background_color(0,0,0,255,-7)
end
