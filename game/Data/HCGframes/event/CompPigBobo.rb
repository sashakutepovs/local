get_character(0).turn_toward_character($game_player)
get_character(0).prelock_direction = get_character(0).direction

savedMove_type = nil

tmpMobAlive = $game_map.npcs.any?{
|event|
	next unless event.summon_data
	next unless event.summon_data[:WildnessNapEvent]
	next if event.deleted?
	next if event.npc.action_state == :death
	true
}
tmpCanExtension = !tmpMobAlive && !$game_map.threat && $story_stats["Captured"] == 0 && ($game_player.actor.stat["Prostitute"] == 1 || $game_player.actor.stat["Nymph"] == 1)

tmpPicked = ""
tmpQuestList = []
tmpQuestList << [$game_text["commonComp:Companion/Follow"]			,"Follow"]
tmpQuestList << [$game_text["commonComp:Companion/Wait"]			,"Wait"]
tmpQuestList << [$game_text["commonComp:Companion/SetFoe"]			,"SetFoe"]
tmpQuestList << [$game_text["commonComp:Companion/Extension"]		,"Extension"] if tmpCanExtension
tmpQuestList << [$game_text["commonComp:Companion/Disband"]			,"Disband"]
		cmd_sheet = tmpQuestList
		cmd_text =""
		for i in 0...cmd_sheet.length
			cmd_text.concat(cmd_sheet[i].first+",")
			p cmd_text
		end
		call_msg("CompPigBobo:UniquePigBobo/begin",0,2,0)
		show_npc_info(get_character(0),extra_info=false,"\\optB[#{cmd_text}]")

		$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
		$game_temp.choice = -1




case tmpPicked
	when "Follow"
		SndLib.SwineAtk
		get_character(0).follower[1] =1

	when "Wait"
		SndLib.SwineAtk
		get_character(0).follower[1] =0
		
	when "SetFoe"
		#fraction" 3 Human nature side							中立
		#fraction" 4 nature										自然生物
		#fraction" 5 goblin/orkind								類獸人
		#fraction" 6 Guard										諾爾守衛
		#fraction" 7 human Slave Trader(or any evil human)		不法份子
		#fraction" 8 fishkind/deepone							漁人
		#fraction" 9 Abomination								肉魔
		#fraction" 10 Undead									不死生物
		#fraction" 11 Elise										伊莉希
		#fraction" 12 sybaris									席芭莉絲
		$game_temp.choice = 0
		!get_character(0).npc.fated_enemy.include?(4)	? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
		!get_character(0).npc.fated_enemy.include?(5)	? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
		!get_character(0).npc.fated_enemy.include?(8)	? $story_stats["HiddenOPT2"] = "1" : $story_stats["HiddenOPT2"] = "0"
		!get_character(0).npc.fated_enemy.include?(9)	? $story_stats["HiddenOPT3"] = "1" : $story_stats["HiddenOPT3"] = "0"
		!get_character(0).npc.fated_enemy.include?(10)	? $story_stats["HiddenOPT4"] = "1" : $story_stats["HiddenOPT4"] = "0"
		call_msg("CompPigBobo:UniquePigBobo/SetupFateEnemy") #[還原預設,邪惡生物,正義生物,動物<r=HiddenOPT0>,類獸人<r=HiddenOPT1>,魚人<r=HiddenOPT2>,肉魔<r=HiddenOPT3>,不死<r=HiddenOPT4>]
		case $game_temp.choice
		when 0 #default
			get_character(0).npc.set_fated_enemy([])
			get_character(0).npc.fucker_condition={"sex"=>[65535, "="]}
			get_character(0).npc.killer_condition={"sex"=>[65535, "="]}
			get_character(0).npc.assaulter_condition={"sex"=>[65535, "="]}
		when 1 #attack evil
			get_character(0).npc.set_fated_enemy([])
			get_character(0).npc.fucker_condition={"sex"=>[65535, "="]}
			get_character(0).npc.killer_condition={"morality"=>[0, "<"]}
			get_character(0).npc.assaulter_condition={"morality"=>[0, "<"]}
		when 2 #attack justice
			get_character(0).npc.set_fated_enemy([])
			get_character(0).npc.fucker_condition={"sex"=>[65535, "="]}
			get_character(0).npc.killer_condition={"morality"=>[49, ">"]}
			get_character(0).npc.assaulter_condition={"morality"=>[49, ">"]}
		when 3 #nature animal 4
			get_character(0).npc.add_fated_enemy([4])
			get_character(0).npc.fucker_condition={"sex"=>[65535, "="]}
			get_character(0).npc.killer_condition={"sex"=>[65535, "="]}
			get_character(0).npc.assaulter_condition={"sex"=>[65535, "="]}
		when 4 #goblin 5
			get_character(0).npc.add_fated_enemy([5])
			get_character(0).npc.fucker_condition={"sex"=>[65535, "="]}
			get_character(0).npc.killer_condition={"sex"=>[65535, "="]}
			get_character(0).npc.assaulter_condition={"sex"=>[65535, "="]}
		when 5 #fishkind 8
			get_character(0).npc.add_fated_enemy([8,14])
			get_character(0).npc.fucker_condition={"sex"=>[65535, "="]}
			get_character(0).npc.killer_condition={"sex"=>[65535, "="]}
			get_character(0).npc.assaulter_condition={"sex"=>[65535, "="]}
		when 6 #abom 9
			get_character(0).npc.add_fated_enemy([9])
			get_character(0).npc.fucker_condition={"sex"=>[65535, "="]}
			get_character(0).npc.killer_condition={"sex"=>[65535, "="]}
			get_character(0).npc.assaulter_condition={"sex"=>[65535, "="]}
		when 7 #undead 10
			get_character(0).npc.add_fated_enemy([10])
			get_character(0).npc.fucker_condition={"sex"=>[65535, "="]}
			get_character(0).npc.killer_condition={"sex"=>[65535, "="]}
			get_character(0).npc.assaulter_condition={"sex"=>[65535, "="]}
		end
	when "Disband"
		call_msg("CompPigBobo:UniquePigBobo/Comp_disband")
		call_msg("common:Lona/Decide_optB")
		cam_center(0)
		if $game_temp.choice == 1
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				portrait_off
				get_character(0).set_this_companion_disband
			chcg_background_color(0,0,0,255,-7)
		else
			SndLib.pigQuestion
		end
		
	when "Extension"
			savedMove_type = get_character(0).move_type
			call_msg("CompPigBobo:UniquePigBobo/Comp_win")
			get_character(0).npc_story_mode(true)
			3.times{
			get_character(0).jump_to(get_character(0).x,get_character(0).y)
			SndLib.SwineAtk(100,150)
			wait(20)
			}
			get_character(0).npc_story_mode(false)
			if $story_stats["RecQuestPigBoboMated"] >= 1
				call_msg("CompPigBobo:UniquePigBobo/Extension0_k0_MatedB4")
			else
				call_msg("CompPigBobo:UniquePigBobo/Extension0_k0_NotMated")
			end
			call_msg("CompPigBobo:UniquePigBobo/Extension0_k1")
			call_msg("common:Lona/Decide_optB")
			if $game_temp.choice == 1

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

				if equips_Top_id != -1#檢查裝備 並脫裝
					$game_player.actor.change_equip("Top", nil)
					SndLib.sound_equip_armor(125)
					player_force_update
					wait(30)
				end

				if equips_MidExt_id != -1#檢查裝備 並脫裝
					$game_player.actor.change_equip("MidExt", nil)
					SndLib.sound_equip_armor(125)
					player_force_update
					wait(30)
				end
				if equips_Bot_id != -1#檢查裝備 並脫裝
					$game_player.actor.change_equip("Bot", nil)
					SndLib.sound_equip_armor(125)
					player_force_update
					wait(30)
				end
				if equips_Anal_id != -1#檢查裝備 並脫裝
					$game_player.actor.change_equip("Anal", nil)
					SndLib.sound_equip_armor(100)
					player_force_update
					wait(30)
				end
				if equips_Vag_id != -1#檢查裝備 並脫裝
					$game_player.actor.change_equip("Vag", nil)
					SndLib.sound_equip_armor(100)
					player_force_update
					wait(30)
				end
				$story_stats["RecQuestPigBoboMated"] += 1
				tmpQuestList = []
				tmpQuestList << [$game_text["commonNPC:prostituation/Blowjob"]			,"Blowjob"]
				tmpQuestList << [$game_text["commonNPC:prostituation/Anal"]				,"Anal"]
				tmpQuestList << [$game_text["commonNPC:prostituation/Vaginal"]			,"Vaginal"]
				cmd_sheet = tmpQuestList
				cmd_text =""
				for i in 0...cmd_sheet.length
					cmd_text.concat(cmd_sheet[i].first+",")
					p cmd_text
				end
				call_msg("CompPigBobo:UniquePigBobo/Extension1",0,2,0)
				call_msg("\\optD[#{cmd_text}]")
				$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
				$game_temp.choice = -1
				case tmpPicked
					when "Anal"
						get_character(0).move_type = 0
						$game_portraits.setLprt("BoboNormal")
						$game_portraits.lprt.shake
						get_character(0).npc_story_mode(true)
						call_msg("TagMapBanditCamp2:RapeLoop/DailyJob_PlayBegin1")
						#get_character(0).moveto($game_player.x,$game_player.y)
						call_msg("TagMapBanditCamp2:RapeLoop/DailyJob_PlayAnal0")
						get_character(0).npc_story_mode(false)
						portrait_off
						play_sex_service_main(ev_target=get_character(0),temp_tar_slot="anal",passive=true,tmpCumIn=true,forcePose=1,tmpAniStage=2) ; get_character(0).force_update = true
						SndLib.SwineAtk
						half_event_key_cleaner
							$game_portraits.setLprt("BoboYell")
							$game_portraits.lprt.shake
							wait(40)
							portrait_hide
							wait(10)
							portrait_off
						play_sex_service_main(ev_target=get_character(0),temp_tar_slot="anal",passive=true,tmpCumIn=true,forcePose=1,tmpAniStage=0) ; get_character(0).force_update = true
						SndLib.SwineAtk
						half_event_key_cleaner
							$game_portraits.setLprt("BoboNormal")
							$game_portraits.lprt.shake
							wait(40)
							portrait_hide
							wait(10)
							portrait_off
						play_sex_service_main(ev_target=get_character(0),temp_tar_slot="anal",passive=true,tmpCumIn=true,forcePose=1,tmpAniStage=1) ; get_character(0).force_update = true
						SndLib.SwineAtk
						half_event_key_cleaner
							$game_portraits.setLprt("BoboYell")
							$game_portraits.lprt.shake
							wait(40)
							portrait_hide
							wait(10)
							portrait_off
						$game_player.actor.stat["EventAnalRace"] =  "Others"
						$game_player.actor.stat["EventAnal"] = "CumInside1"
						chcg_decider_basic(pose=5)
						$game_player.actor.addCums("CumsMoonPie",700,"Others")
						SndLib.SwineAtk
						load_script("Data/HCGframes/EventAnal_CumInside_Overcum.rb")
						SndLib.SwineAtk
						portrait_off
						whole_event_end
						$game_player.unset_event_chs_sex
						$game_player.actor.set_action_state(:none)
						get_character(0).unset_event_chs_sex
						get_character(0).actor.set_action_state(:none)
						$game_player.record_companion_front_date += 1 if $game_player.record_companion_front_date
						
					when "Blowjob"
						get_character(0).move_type = 0
						$game_portraits.setLprt("BoboNormal")
						$game_portraits.lprt.shake
						get_character(0).npc_story_mode(true)
						#get_character(0).moveto($game_player.x,$game_player.y)
						call_msg("TagMapBanditCamp2:RapeLoop/DailyJob_PlayMouth0")
						get_character(0).npc_story_mode(false)
						portrait_off
						play_sex_service_main(ev_target=get_character(0),temp_tar_slot="mouth",passive=true,tmpCumIn=true,forcePose=2,tmpAniStage=2) ; get_character(0).force_update = true
						SndLib.SwineAtk
						half_event_key_cleaner
							$game_portraits.setLprt("BoboYell")
							$game_portraits.lprt.shake
							wait(40)
							portrait_hide
							wait(10)
							portrait_off
						play_sex_service_main(ev_target=get_character(0),temp_tar_slot="mouth",passive=true,tmpCumIn=true,forcePose=2,tmpAniStage=0) ; get_character(0).force_update = true
						SndLib.SwineAtk
						half_event_key_cleaner
							$game_portraits.setLprt("BoboNormal")
							$game_portraits.lprt.shake
							wait(40)
							portrait_hide
							wait(10)
							portrait_off
						play_sex_service_main(ev_target=get_character(0),temp_tar_slot="mouth",passive=true,tmpCumIn=true,forcePose=2,tmpAniStage=1) ; get_character(0).force_update = true
						SndLib.SwineAtk
						half_event_key_cleaner
							$game_portraits.setLprt("BoboYell")
							$game_portraits.lprt.shake
							wait(40)
							portrait_hide
							wait(10)
							portrait_off
						$game_player.actor.stat["EventMouthRace"] =  "Others"
						$game_player.actor.stat["EventMouth"] = "CumInside1"
						chcg_decider_basic(pose=5)
						SndLib.SwineAtk
						load_script("Data/HCGframes/EventMouth_CumInside_Overcum.rb")
						SndLib.SwineAtk
						portrait_off
						whole_event_end
						$game_player.unset_event_chs_sex
						$game_player.actor.set_action_state(:none)
						get_character(0).unset_event_chs_sex
						get_character(0).actor.set_action_state(:none)
						$game_player.record_companion_front_date += 1 if $game_player.record_companion_front_date
				
					when "Vaginal"
						get_character(0).move_type = 0
						$game_portraits.setLprt("BoboNormal")
						$game_portraits.lprt.shake
						get_character(0).npc_story_mode(true)
						get_character(0).turn_toward_character($game_player)
						get_character(0).jump_to(get_character(0).x,get_character(0).y)
						SndLib.SwineAtk
						get_character(0).call_balloon(4)
						wait(50)
						call_msg("CompPigBobo:UniquePigBobo/Extension2"); portrait_hide
						SndLib.sound_punch_hit(80)
						get_character(0).animation = get_character(0).animation_grabber_qte($game_player)
						$game_player.animation = $game_player.animation_grabbed_qte
						wait(8)
						call_msg("TagMapBanditCamp2:RapeLoop/DailyJob6") ; portrait_hide
						cam_center(0)
						get_character(0).animation = get_character(0).animation_atk_heavy ; wait(5) ; SndLib.SwineAtk ; wait(5)
						$game_player.animation = $game_player.animation_stun
						SndLib.sound_punch_hit(100)
						lona_mood "p5crit_damage"
						$game_player.actor.portrait.shake
						$game_player.jump_to($game_player.x,$game_player.y)
						call_msg("!!!!!!!!!!")
						call_msg("TagMapBanditCamp2:RapeLoop/DailyJob7") ; portrait_hide ; cam_center(0)
						get_character(0).animation = get_character(0).animation_grabber_qte($game_player)
						SndLib.sound_punch_hit(80)
						wait(60)
						portrait_off
						get_character(0).npc_story_mode(false)
						$game_player.animation = 0
						tmpPose = [0,4].sample
						#get_character(0).moveto($game_player.x,$game_player.y)
						play_sex_service_main(ev_target=get_character(0),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=tmpPose,tmpAniStage=2) ; get_character(0).force_update = true ; SndLib.SwineAtk
						half_event_key_cleaner
							$game_portraits.setLprt("BoboNormal")
							$game_portraits.lprt.shake
							wait(40)
							portrait_hide
							wait(10)
							portrait_off
						play_sex_service_main(ev_target=get_character(0),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=tmpPose,tmpAniStage=0) ; get_character(0).force_update = true ; SndLib.SwineAtk
						half_event_key_cleaner
							$game_portraits.setLprt("BoboYell")
							$game_portraits.lprt.shake
							wait(40)
							portrait_hide
							wait(10)
							portrait_off
						play_sex_service_main(ev_target=get_character(0),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=tmpPose,tmpAniStage=1) ; get_character(0).force_update = true ; SndLib.SwineAtk
						half_event_key_cleaner
							$game_portraits.setLprt("BoboNormal")
							$game_portraits.lprt.shake
							wait(40)
							portrait_hide
							wait(10)
							portrait_off
						play_sex_service_main(ev_target=get_character(0),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=tmpPose,tmpAniStage=1) ; get_character(0).force_update = true ; SndLib.SwineAtk
						half_event_key_cleaner
							$game_portraits.setLprt("BoboYell")
							$game_portraits.lprt.shake
							wait(40)
							portrait_hide
							wait(10)
							portrait_off
						$game_player.actor.stat["EventVagRace"] =  "Others"
						$game_player.actor.stat["EventVag"] = "CumInside1"
						SndLib.SwineAtk
						tmpPose == 0 ? chcg_decider_basic_vag(pose=3) : chcg_decider_basic_vag(pose=1)
						load_script("Data/HCGframes/EventVag_CumInside_OvercumStay.rb")
						SndLib.SwineAtk
						$game_player.actor.addCums("CumsCreamPie",350,"Others")
						portrait_off
						play_sex_service_main(ev_target=get_character(0),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=tmpPose,tmpAniStage=1) ; get_character(0).force_update = true ; SndLib.SwineAtk
						half_event_key_cleaner
							$game_portraits.setLprt("BoboNormal")
							$game_portraits.lprt.shake
							wait(40)
							portrait_hide
							wait(10)
							portrait_off
						play_sex_service_main(ev_target=get_character(0),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=tmpPose,tmpAniStage=1) ; get_character(0).force_update = true ; SndLib.SwineAtk
						half_event_key_cleaner
							$game_portraits.setLprt("BoboYell")
							$game_portraits.lprt.shake
							wait(40)
							portrait_hide
							wait(10)
							portrait_off
						play_sex_service_main(ev_target=get_character(0),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=tmpPose,tmpAniStage=1) ; get_character(0).force_update = true ; SndLib.SwineAtk
						half_event_key_cleaner
							$game_portraits.setLprt("BoboNormal")
							$game_portraits.lprt.shake
							wait(40)
							portrait_hide
							wait(10)
							portrait_off
						play_sex_service_main(ev_target=get_character(0),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=tmpPose,tmpAniStage=2) ; get_character(0).force_update = true ; SndLib.SwineAtk
						SndLib.SwineAtk(100,200)
						half_event_key_cleaner
							$game_portraits.setLprt("BoboYell")
							$game_portraits.lprt.shake
							wait(40)
							portrait_hide
							wait(10)
							portrait_off
						wait(5)
						SndLib.SwineAtk(100,200)
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
						$game_player.unset_event_chs_sex
						$game_player.actor.set_action_state(:none)
						get_character(0).unset_event_chs_sex
						get_character(0).actor.set_action_state(:none)
						event_key_cleaner_whore_work
						whole_event_end
						$game_player.actor.record_lona_title = "WhoreJob/BoboWife"
						$game_player.record_companion_front_date += 4 if $game_player.record_companion_front_date
					end#case pose picker
				
			else
				get_character(0).call_balloon(7)
			end
end
get_character(0).move_type = savedMove_type if savedMove_type


$story_stats["HiddenOPT0"] = "0"
$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT2"] = "0"
$story_stats["HiddenOPT3"] = "0"
$story_stats["HiddenOPT4"] = "0"
SndLib.pigQuestion
eventPlayEnd
