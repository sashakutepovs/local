tmpLP = RPG::BGM.last.pos
if [44].include?($game_player.region_id)
 SndLib.bgm_play("D/Secrets of Kingdom (looped)",80,60,tmpLP)
 SndLib.bgs_play("AMBIENCE_Public_Hall_Chatter_01_loop_stereo",30,80)
else
 SndLib.bgm_play("D/Secrets of Kingdom (looped)",80,115,tmpLP) if $game_date.day?
 SndLib.bgm_play("D/Secrets of Kingdom (looped)",80,100,tmpLP) if $game_date.night?
 SndLib.bgs_play("AMBIENCE_Public_Hall_Chatter_01_loop_stereo",50,100)
end
$game_map.shadows.set_color(50, 70, 180) if $game_date.day?
$game_map.shadows.set_opacity(180) if $game_date.day?
$game_map.shadows.set_color(50, 70, 180) if $game_date.night?
$game_map.shadows.set_opacity(220) if $game_date.night?
map_background_color(40,80,128,80,0)

tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
tmpG1X,tmpG1Y,tmpG1id = $game_map.get_storypoint("Guard1")
tmpG2X,tmpG2Y,tmpG2id = $game_map.get_storypoint("Guard2")
tmpMeatToiletX,tmpMeatToiletY,tmpMeatToiletPTid = $game_map.get_storypoint("MeatToiletPT")
tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
tmpRaper0id = $game_map.get_storypoint("Raper0")[2]
tmpRaper1id = $game_map.get_storypoint("Raper1")[2]
tmpRaper2id = $game_map.get_storypoint("Raper2")[2]
tmpRaper3id = $game_map.get_storypoint("Raper3")[2]
tmpRaper4id = $game_map.get_storypoint("Raper4")[2]
################################################################################### 
################################################################################### Torture
if $story_stats["RapeLoopTorture"] == 1
	SndLib.bgm_stop
	tmpTurX,tmpTurY,tmpTurID = $game_map.get_storypoint("Torture1")
	tmpG1X,tmpG1Y,tmpG1id = $game_map.get_storypoint("Guard1")
	tmpG2X,tmpG2Y,tmpG2id = $game_map.get_storypoint("Guard2")
	tmpWakeUpX,tmpWakeUpY,tmpWakeUpid = $game_map.get_storypoint("WakeUp")
	tmpCenterID = $game_map.get_storypoint("center")[2]
	$story_stats["SlaveOwner"] == "NorthFL_INN"
	$story_stats["Captured"] = 1
	$story_stats["RapeLoopTorture"] = 0
	lonaOx = $game_player.x
	lonaOy = $game_player.y
	$game_player.transparent = true
	portrait_hide
	cam_follow(tmpTurID,0)
	set_event_force_page(tmpTurID,1)
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:WildnessNapEvent] == "HumanGuard" || event.summon_data[:BsWhore]
		next if event.deleted?
		event.summon_data[:OriginD] = event.direction
		event.turn_toward_character(get_character(tmpTurID))
	}
	get_character(tmpG1id).opacity = 255
	get_character(tmpG2id).opacity = 255
	get_character(tmpG1id).npc_story_mode(true)
	get_character(tmpG2id).npc_story_mode(true)
	get_character(tmpG1id).moveto(tmpTurX-1,tmpTurY+1)
	get_character(tmpG2id).moveto(tmpTurX+1,tmpTurY+1)
	get_character(tmpG1id).direction = 6
	get_character(tmpG2id).direction = 4
	$game_player.moveto(tmpG1X,tmpG1Y)
	3.times{
		wait(30)
		SndLib.sound_step_chain(100)
	}
	call_msg("TagMapNorthFL_INN:Torture/begin0") ; portrait_hide
	################################### THE SHOW
	################################### THE SHOW
		chcg_background_color(0,0,0,255,-3)
			call_msg("TagMapNorthFL_INN:Torture/begin1") ; portrait_hide
			get_character(tmpG1id).direction = 2
			get_character(tmpG2id).direction = 2
			call_msg("TagMapNorthFL_INN:Torture/begin2") ; portrait_hide
			cam_follow(tmpCenterID,0)
			2.times{
				$game_map.npcs.each{|event|
					next unless event.summon_data
					next unless event.summon_data[:WildnessNapEvent] == "HumanGuard"
					next if event.deleted?
					next if [true,false].sample
					event.call_balloon(20)
				}
				SndLib.ppl_CheerGroup
				wait(60)
			}
			call_msg("TagMapNorthFL_INN:Torture/begin3") ; portrait_hide
			get_character(tmpG1id).direction = 6
			get_character(tmpG2id).direction = 4
			get_character(tmpG2id).direction = 4 ; get_character(tmpG2id).move_forward_force ; wait(35)
			get_character(tmpG2id).direction = 8
			get_character(tmpG2id).animation = get_character(tmpG2id).animation_atk_shoot_hold
			SndLib.sound_equip_armor(100)
			wait(45)
			call_msg("TagMapNorthFL_INN:Torture/begin4") ; portrait_hide
			
			$game_player.actor.stat["EventVagRace"] =  "Human"
			$game_player.actor.stat["EventAnalRace"] = "Human"
			$game_player.actor.stat["EventMouthRace"] ="Human"
			$game_player.actor.stat["EventExt1Race"] = "Human"
			$game_player.actor.stat["EventExt2Race"] = "Human"
			$game_player.actor.stat["EventExt3Race"] = "Human"
			$game_player.actor.stat["EventExt4Race"] = "Human"
			temp_value= [
				"Data/HCGframes/UniqueEvent_BellyPunch.rb",
				"Data/HCGframes/UniqueEvent_FacePunch.rb"
			]
			load_script("#{temp_value[rand(temp_value.length)]}")
			lona_mood "terror"
			1.times{
				$game_map.npcs.each{|event|
					next unless event.summon_data
					next unless event.summon_data[:WildnessNapEvent] == "HumanGuard"
					next if event.deleted?
					next if [true,false].sample
					event.call_balloon(20)
				}
				SndLib.ppl_CheerGroup
				wait(60)
			}
			whole_event_end
			check_over_event
			get_character(tmpG1id).direction = 2
			call_msg("TagMapNorthFL_INN:Torture/begin5")
			1.times{
				$game_map.npcs.each{|event|
					next unless event.summon_data
					next unless event.summon_data[:WildnessNapEvent] == "HumanGuard"
					next if event.deleted?
					next if [true,false].sample
					event.call_balloon(20)
				}
				SndLib.ppl_CheerGroup
				wait(60)
			}
			call_msg("TagMapNorthFL_INN:Torture/begin6") ; portrait_off
			$game_player.actor.stat["EventVagRace"] =  "Human"
			$game_player.actor.stat["EventAnalRace"] = "Human"
			$game_player.actor.stat["EventMouthRace"] ="Human"
			$game_player.actor.stat["EventExt1Race"] = "Human"
			$game_player.actor.stat["EventExt2Race"] = "Human"
			$game_player.actor.stat["EventExt3Race"] = "Human"
			$game_player.actor.stat["EventExt4Race"] = "Human"
			temp_value = [
				"Data/HCGframes/UniqueEvent_VagDilatation.rb",
				"Data/HCGframes/UniqueEvent_UrinaryDilatation.rb",
				"Data/HCGframes/UniqueEvent_AnalDilatation.rb",
				"Data/HCGframes/UniqueEvent_Peeon.rb",
				"Data/HCGframes/UniqueEvent_VagNeedle.rb"
			]
			load_script("#{temp_value[rand(temp_value.length)]}")
			lona_mood "tired"
			1.times{
				$game_map.npcs.each{|event|
					next unless event.summon_data
					next unless event.summon_data[:WildnessNapEvent] == "HumanGuard"
					next if event.deleted?
					next if [true,false].sample
					event.call_balloon(20)
				}
				SndLib.ppl_CheerGroup
				wait(60)
			}
			whole_event_end
			check_over_event
			call_msg("TagMapNorthFL_INN:Torture/begin7") ; portrait_hide
		chcg_background_color(0,0,0,0,7)
	##################################### THE SHOW
	##################################### THE SHOW
	
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:WildnessNapEvent] == "HumanGuard" || event.summon_data[:BsWhore]
		next if event.deleted?
		event.direction = event.summon_data[:OriginD]
	}
	get_character(tmpG1id).opacity = 0
	get_character(tmpG2id).opacity = 0
	get_character(tmpG1id).npc_story_mode(false)
	get_character(tmpG2id).npc_story_mode(false)
	get_character(tmpG1id).moveto(tmpG1X,tmpG1Y)
	get_character(tmpG2id).moveto(tmpG2X,tmpG2Y)
	$game_player.moveto(lonaOx,lonaOy)
	$game_player.transparent = false
	set_event_force_page(tmpTurID,2)
	cam_center(0)
	$game_player.moveto(tmpWakeUpX,tmpWakeUpY)
	call_msg("TagMapNorthFL_INN:Torture/begin8") ; portrait_hide
	SndLib.bgm_play_prev
################################################################################### capture
elsif $game_player.player_slave? && $story_stats["Captured"] == 0
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:WildnessNapEvent] == "HumanGuard"
		next if event.deleted?
		event.npc.fucker_condition={"sex"=>[65535, "="]}
		event.npc.killer_condition={"morality"=>[10, "<"]}
		event.npc.assaulter_condition={"morality"=>[30, "<"]}
		event.npc.refresh
	}
	$story_stats["Captured"] = 1
	$story_stats["RapeLoopTorture"] = 1
	$story_stats["SlaveOwner"] == "NorthFL_INN"
end
################################################################################### capture

enter_static_tag_map
summon_companion #this isnt a real inn yet. will summon follower

##################################################################################################################### if slave, Pick a job
##################################################################################################################### if slave, Pick a job
##################################################################################################################### if slave, Pick a job
##################################################################################################################### if slave, Pick a job
##################################################################################################################### if slave, Pick a job
##################################################################################################################### if slave, Pick a job
##################################################################################################################### if slave, Pick a job
##################################################################################################################### if slave, Pick a job
if get_character(tmpDualBiosID).summon_data[:IsSlave] && get_character(tmpDualBiosID).summon_data[:Qtaken] == false && $story_stats["Captured"] == 1 && $story_stats["SlaveOwner"] == "NorthFL_INN"
	get_character(tmpDualBiosID).summon_data[:Job] = ["MeatToilet","Whore","Suck","Whore","Suck","None","None"].sample
	$story_stats["Ending_MainCharacter"] = "Ending_MC_HumanSlave"
	$game_player.actor.record_lona_title = "Rapeloop/DoomFort"
		##################################################################################################### debug test area
		##################################################################################################### debug test area
		##################################################################################################### debug test area
		#get_character(tmpDualBiosID).summon_data[:Job] = "MeatToilet"
		##################################################################################################### debug test area
		##################################################################################################### debug test area
		##################################################################################################### debug test area
		##################################################################################################### debug test area
	if get_character(tmpDualBiosID).summon_data[:Job] == "None"
		get_character(tmpDualBiosID).summon_data[:Qtaken] = true
		get_character(tmpDualBiosID).summon_data[:JobDone] = true
		call_msg("TagMapNorthFL_INN:Job/NoWork")
	
	else ###############################################if with work
		#chcg_background_color(0,0,0,0,7)
			get_character(tmpG1id).opacity = 255
			get_character(tmpG2id).opacity = 255
			get_character(tmpG1id).direction = 8
			get_character(tmpG2id).direction = 6
			get_character(tmpG1id).moveto($game_player.x,$game_player.y+1)
			get_character(tmpG2id).moveto($game_player.x-1,$game_player.y)
		chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapNorthFL_INN:Job/Begin0")
		
		#####################################################################################################MeatToilet JOB
		#####################################################################################################MeatToilet JOB
		#####################################################################################################MeatToilet JOB
		#####################################################################################################MeatToilet JOB
		#####################################################################################################MeatToilet JOB
		#####################################################################################################MeatToilet JOB
		case get_character(tmpDualBiosID).summon_data[:Job]
			when "MeatToilet"
				call_msg("TagMapNorthFL_INN:Job/MeatToiletJob0")
				get_character(tmpG2id).animation = get_character(tmpG2id).animation_grabber_qte($game_player)
				$game_player.animation = $game_player.animation_grabbed_qte
				SndLib.sound_equip_armor(100)
				call_msg("TagMapNorthFL_INN:Job/MeatToiletJob1")
				portrait_hide
				chcg_background_color(0,0,0,0,7)
					portrait_off
					3.times{
						wait(30)
						SndLib.sound_step_chain(100)
					}
					cam_follow(tmpMeatToiletPTid,0)
					set_event_force_page(tmpMeatToiletPTid,1)
					tmp_mcw = get_character(tmpMeatToiletPTid).manual_cw
					tmp_mch = get_character(tmpMeatToiletPTid).manual_ch
					tmp_mcp = get_character(tmpMeatToiletPTid).pattern
					tmp_mcd = get_character(tmpMeatToiletPTid).direction
					get_character(tmpMeatToiletPTid).manual_cw = 1 #canvas witdh(how many item in this PNG's witdh)
					get_character(tmpMeatToiletPTid).manual_ch = 1 #canvas height(how many item in this PNG's height)
					get_character(tmpMeatToiletPTid).pattern = 0 #force 0 because only 1x1
					get_character(tmpMeatToiletPTid).direction = 2 #force to 2 because only 1x1
					get_character(tmpMeatToiletPTid).character_index =0 #force 0 because only 1x1
					if ["Deepone","Moot"].include?($game_player.actor.stat["Race"])
						get_character(tmpMeatToiletPTid).character_name = "LonaEXT/LonaMootBondageOnBed.png"
					else
						get_character(tmpMeatToiletPTid).character_name = "LonaEXT/LonaBondageOnBed.png"
					end
					$game_player.animation = nil
					$game_player.transparent = true
					$game_player.moveto(tmpMeatToiletX+1,tmpMeatToiletY)
					get_character(tmpG2id).animation = nil
					get_character(tmpRaper0id).opacity = 255
					get_character(tmpRaper1id).opacity = 255
					get_character(tmpRaper2id).opacity = 255
					get_character(tmpRaper3id).opacity = 255
					get_character(tmpRaper4id).opacity = 255
					get_character(tmpRaper0id).moveto(tmpMeatToiletX+1,tmpMeatToiletY+2)	; get_character(tmpRaper0id).direction = 8 ; get_character(tmpRaper0id).forced_x = -16 ; get_character(tmpRaper0id).forced_y = -4
					get_character(tmpRaper1id).moveto(tmpMeatToiletX+1,tmpMeatToiletY+3)	; get_character(tmpRaper1id).direction = 8
					get_character(tmpRaper2id).moveto(tmpMeatToiletX+1,tmpMeatToiletY+4)	; get_character(tmpRaper2id).direction = 8
					get_character(tmpRaper3id).moveto(tmpMeatToiletX+2,tmpMeatToiletY+4)	; get_character(tmpRaper3id).direction = 4
					get_character(tmpRaper4id).moveto(tmpMeatToiletX+2,tmpMeatToiletY+5)	; get_character(tmpRaper4id).direction = 8
					get_character(tmpG1id).moveto(tmpMeatToiletX+3,tmpMeatToiletY+5)		; get_character(tmpG1id).direction = 4
					get_character(tmpG2id).moveto(tmpMeatToiletX+4,tmpMeatToiletY+5)		; get_character(tmpG2id).direction = 4
					get_character(tmpRaper0id).npc_story_mode(true)
					get_character(tmpRaper1id).npc_story_mode(true)
					get_character(tmpRaper2id).npc_story_mode(true)
					get_character(tmpRaper3id).npc_story_mode(true)
					get_character(tmpRaper4id).npc_story_mode(true)
					get_character(tmpG1id).npc_story_mode(true)
					get_character(tmpG2id).npc_story_mode(true)
					get_character(tmpRaper0id).set_npc("NeutralHumanEmptyGuard")
					get_character(tmpRaper1id).set_npc("NeutralHumanEmptyGuard")
					get_character(tmpRaper2id).set_npc("NeutralHumanEmptyGuard")
					get_character(tmpRaper3id).set_npc("NeutralHumanEmptyGuard")
					get_character(tmpRaper4id).set_npc("NeutralHumanEmptyGuard")
				chcg_background_color(0,0,0,255,-7)
				call_msg("TagMapNorthFL_INN:Job/MeatToiletJob2_#{rand(2)}") ; portrait_hide
				get_character(tmpRaper0id).move_forward_force
				wait(30)
				call_msg("TagMapNorthFL_INN:Job/MeatToiletJob3") ; portrait_hide
				tmpVirgin = $story_stats["sex_record_vaginal_count"] == 0
				################################################################################################################################################## tier1
				portrait_off
				play_sex_service_main(ev_target=get_character(tmpRaper0id),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2)
				half_event_key_cleaner
				if tmpVirgin
					call_msg("TagMapNorthFL_INN:Job/MeatToiletJob3_virgin0") ; portrait_hide
					SndLib.ppl_CheerGroup
					get_character(tmpRaper1id).call_balloon(20)
					get_character(tmpRaper2id).call_balloon(20)
					get_character(tmpRaper3id).call_balloon(20)
					get_character(tmpRaper4id).call_balloon(20)
					call_msg("TagMapNorthFL_INN:Job/MeatToiletJob3_virgin1") ; portrait_hide
				end
				play_sex_service_main(ev_target=get_character(tmpRaper0id),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2)
				portrait_off
				half_event_key_cleaner
				play_sex_service_main(ev_target=get_character(tmpRaper0id),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2)
				portrait_off
				half_event_key_cleaner
				portrait_off
				play_sex_service_main(ev_target=get_character(tmpRaper0id),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2,0)
				half_event_key_cleaner
				play_sex_service_main(ev_target=get_character(tmpRaper0id),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2,1)
				half_event_key_cleaner
				play_sex_service_main(ev_target=get_character(tmpRaper0id),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2,2)
				portrait_off
				call_msg("TagMapNorthFL_INN:Job/MeatToiletJob4") ; portrait_hide
				portrait_off
				$game_player.actor.stat["EventVagRace"] =  "Human"
				$game_player.actor.stat["EventVag"] = "CumInside1"
				chcg_decider_basic_arousal(pose=4)
				load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
				portrait_off
				################################################################################################################################################################# tier1 leave
				$game_player.unset_event_chs_sex
				get_character(tmpRaper0id).unset_event_chs_sex
				call_msg("TagMapNorthFL_INN:Job/MeatToiletJob5") ; portrait_hide
				get_character(tmpRaper0id).jump_to(tmpMeatToiletX,tmpMeatToiletY) ; get_character(tmpRaper0id).direction = 6  ; get_character(tmpRaper0id).forced_x = -10
				wait(5)
				get_character(tmpRaper0id).animation = get_character(tmpRaper0id).animation_masturbation
				get_character(tmpRaper1id).direction = 8 ; get_character(tmpRaper1id).move_forward_force ; get_character(tmpRaper1id).forced_x = -16 ; get_character(tmpRaper1id).forced_y = -8
				get_character(tmpRaper2id).direction = 8 ; get_character(tmpRaper2id).move_forward_force
				get_character(tmpRaper3id).direction = 4 ; get_character(tmpRaper3id).move_forward_force ; get_character(tmpRaper3id).direction = 8
				get_character(tmpRaper4id).direction = 8 ; get_character(tmpRaper4id).move_forward_force ; get_character(tmpRaper3id).direction = 4
				get_character(tmpG1id).direction = 4 ; get_character(tmpG1id).move_forward_force
				get_character(tmpG2id).direction = 4 ; get_character(tmpG2id).move_forward_force
				wait(35)
				get_character(tmpRaper1id).direction = 8 ; get_character(tmpRaper1id).move_forward_force
				wait(35)
				################################################################################################################################################################## tier2 start
				call_msg("TagMapNorthFL_INN:Job/MeatToiletJob6") ; portrait_hide
				portrait_off
				play_sex_service_main(ev_target=get_character(tmpRaper1id),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2)
				half_event_key_cleaner
				play_sex_service_main(ev_target=get_character(tmpRaper1id),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2)
				half_event_key_cleaner
				play_sex_service_main(ev_target=get_character(tmpRaper1id),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2,1)
				half_event_key_cleaner
				play_sex_service_main(ev_target=get_character(tmpRaper1id),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2,2)
				portrait_off
				call_msg("TagMapNorthFL_INN:Job/MeatToiletJob7") ; portrait_hide
				portrait_off
				$game_player.actor.stat["EventVagRace"] =  "Human"
				$game_player.actor.stat["EventVag"] = "CumInside1"
				chcg_decider_basic_arousal(pose=4)
				load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
				portrait_off
				################################################################################################################################################################# tier2 leave
				$game_player.unset_event_chs_sex
				get_character(tmpRaper1id).unset_event_chs_sex
				call_msg("TagMapNorthFL_INN:Job/MeatToiletJob8") ; portrait_hide
				get_character(tmpRaper1id).jump_to(tmpMeatToiletX+1,tmpMeatToiletY) ; get_character(tmpRaper1id).direction = 4  ; get_character(tmpRaper1id).forced_x = 10
				wait(5)
				get_character(tmpRaper1id).animation = get_character(tmpRaper1id).animation_masturbation
				get_character(tmpRaper2id).direction = 8 ; get_character(tmpRaper2id).move_forward_force ; get_character(tmpRaper2id).forced_x = -16 ; get_character(tmpRaper2id).forced_y = -8
				get_character(tmpRaper3id).direction = 8 ; get_character(tmpRaper3id).move_forward_force
				get_character(tmpRaper4id).direction = 4 ; get_character(tmpRaper4id).move_forward_force
				get_character(tmpG1id).direction = 4 ; get_character(tmpG1id).move_forward_force
				get_character(tmpG2id).direction = 4 ; get_character(tmpG2id).move_forward_force
				wait(35)
				get_character(tmpRaper2id).direction = 8 ; get_character(tmpRaper2id).move_forward_force
				wait(35)
				################################################################################################################################################################## tier3 start
				call_msg("TagMapNorthFL_INN:Job/MeatToiletJob9") ; portrait_hide
				portrait_off
				play_sex_service_main(ev_target=get_character(tmpRaper2id),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2,2)
				half_event_key_cleaner
				play_sex_service_main(ev_target=get_character(tmpRaper2id),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2,1)
				half_event_key_cleaner
				play_sex_service_main(ev_target=get_character(tmpRaper2id),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2,1)
				half_event_key_cleaner
				play_sex_service_main(ev_target=get_character(tmpRaper2id),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2,2)
				portrait_off
				call_msg("TagMapNorthFL_INN:Job/MeatToiletJob10") ; portrait_hide
				portrait_off
				$game_player.actor.stat["EventVagRace"] =  "Human"
				$game_player.actor.stat["EventVag"] = "CumInside1"
				chcg_decider_basic_arousal(pose=4)
				load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
				portrait_off
				################################################################################################################################################################# tier3 leave
				$game_player.unset_event_chs_sex
				get_character(tmpRaper2id).unset_event_chs_sex
				call_msg("TagMapNorthFL_INN:Job/MeatToiletJob11") ; portrait_hide
				get_character(tmpRaper2id).jump_to(tmpMeatToiletX,tmpMeatToiletY+1) ; get_character(tmpRaper2id).direction = 6  ; get_character(tmpRaper2id).forced_x = -7 ; get_character(tmpRaper2id).forced_y = -9
				wait(5)
				get_character(tmpRaper2id).animation = get_character(tmpRaper2id).animation_masturbation
				call_msg("TagMapNorthFL_INN:Job/MeatToiletJob12") ; portrait_hide
				get_character(tmpRaper3id).direction = 8 ; get_character(tmpRaper3id).move_forward_force
				get_character(tmpRaper4id).direction = 8 ; get_character(tmpRaper4id).move_forward_force
				call_msg("TagMapNorthFL_INN:Job/MeatToiletJob13") ; portrait_hide
				get_character(tmpG1id).direction = 8 ; get_character(tmpG1id).move_forward_force
				get_character(tmpG2id).direction = 4 ; get_character(tmpG2id).move_forward_force
				wait(35)
				get_character(tmpRaper3id).direction = 8 ; get_character(tmpRaper3id).move_forward_force
				get_character(tmpRaper3id).direction = 4 ; get_character(tmpRaper3id).animation = get_character(tmpRaper3id).animation_masturbation ;  ; get_character(tmpRaper3id).forced_x = 6 ; get_character(tmpRaper3id).forced_y = -12 ; 
				get_character(tmpRaper4id).direction = 8 ; get_character(tmpRaper4id).move_forward_force
				get_character(tmpG1id).direction = 8 ; get_character(tmpG1id).move_forward_force
				get_character(tmpG2id).direction = 8 ; get_character(tmpG2id).move_forward_force
				get_character(tmpRaper4id).direction = 8 ; get_character(tmpRaper4id).move_forward_force
				get_character(tmpG1id).direction = 8 ; get_character(tmpG1id).move_forward_force
				get_character(tmpG2id).direction = 8 ; get_character(tmpG2id).move_forward_force
				wait(35)
				get_character(tmpRaper4id).jump_to(tmpMeatToiletX,tmpMeatToiletY+1) ; get_character(tmpRaper4id).direction = 8 ; get_character(tmpRaper4id).forced_x = -8 ; get_character(tmpRaper4id).forced_y = 6
				get_character(tmpG1id).jump_to(tmpMeatToiletX,tmpMeatToiletY+1) ; get_character(tmpG1id).direction = 8 ; get_character(tmpG1id).forced_x = 16 ; get_character(tmpG1id).forced_y = 12
				get_character(tmpG2id).jump_to(tmpMeatToiletX+1,tmpMeatToiletY+1) ; get_character(tmpG2id).direction = 8 ; get_character(tmpG2id).forced_x = 8 ; get_character(tmpG2id).forced_y = 6
				wait(5)
				get_character(tmpRaper4id).animation = get_character(tmpRaper4id).animation_masturbation
				get_character(tmpG1id).animation = get_character(tmpG1id).animation_masturbation
				get_character(tmpG2id).animation = get_character(tmpG2id).animation_masturbation
				call_msg("TagMapNorthFL_INN:Job/MeatToiletJob14") ; portrait_hide
				chcg_set_all_race("Human")
					portrait_hide
					chcg_background_color(0,0,0,0,7)
					portrait_off
					SndLib.sound_chcg_fapper(80)
					SndLib.sound_chcg_full(80)
					wait(45)
					SndLib.sound_chcg_fapper(80)
					SndLib.sound_chcg_full(80)
					wait(45)
					SndLib.sound_chcg_fapper(80)
					SndLib.sound_chcg_full(80)
					wait(45)
					SndLib.sound_chcg_fapper(80)
					SndLib.sound_chcg_full(80)
					wait(45)
					SndLib.sound_chcg_fapper(80)
					SndLib.sound_chcg_full(80)
					wait(180)
					
					#$game_player.actor.stat["pose"] = "chcg#{rand(4)+1}"
					temp_record_anal_count 		= rand(3)+1   ;$story_stats["sex_record_anal_count"] 		+= temp_record_anal_count
					temp_record_vaginal_count	= rand(3)+1   ;$story_stats["sex_record_vaginal_count"] 	+= temp_record_vaginal_count
					temp_record_mouth_count 	= rand(3)+1   ;$story_stats["sex_record_mouth_count"] 		+= temp_record_mouth_count
					temp_record_cumin_anal 		= rand(3)+1    ;$story_stats["sex_record_cumin_anal"] 		+= temp_record_cumin_anal
					temp_record_cumin_mouth 	= rand(1)+1    ;$story_stats["sex_record_cumin_mouth"] 		+= temp_record_cumin_mouth
					temp_record_cumin_vaginal	= rand(1)+1    ;$story_stats["sex_record_cumin_vaginal"] 	+= temp_record_cumin_vaginal
					temp_record_cumshotted 		= rand(10)+1   ;$story_stats["sex_record_cumshotted"] 		+= temp_record_cumshotted
					temp_record_anal_wash 		= rand(1)+1    ;$story_stats["sex_record_anal_wash"] 		+= temp_record_anal_wash 		if $story_stats["Setup_UrineEffect"] >=1
					temp_record_piss_drink		= rand(1)+1    ;$story_stats["sex_record_piss_drink"] 		+= temp_record_piss_drink		if $story_stats["Setup_UrineEffect"] >=1
					temp_record_pussy_wash		= rand(1)+1    ;$story_stats["sex_record_pussy_wash"]		+= temp_record_pussy_wash		if $story_stats["Setup_UrineEffect"] >=1
					$story_stats["sex_record_biggest_gangbang"] +=1
					check_over_event
					
					
					chcg_background_color
					#各Slot的key1
					$game_player.actor.stat["EventMouth"] = "CumInside1"
					$game_player.actor.stat["EventVag"] = "CumInside1"
					$game_player.actor.stat["EventAnal"] = "CumInside1"
					$game_player.actor.stat["EventExt1"] = "FapperCuming1"
					$game_player.actor.stat["EventExt2"] = "FapperCuming1"
					$game_player.actor.stat["EventExt3"] = "FapperCuming1"
					$game_player.actor.stat["EventExt4"] = "FapperCuming1"
					
					#強制設定SLOT開關
					$game_player.actor.stat["analopen"] = 1 if $game_player.actor.stat["EventAnalRace"] != nil
					$game_player.actor.stat["vagopen"] = 1 if $game_player.actor.stat["EventVagRace"]   != nil
					temp_CumStyle=[
					"_CumOutside", ##human only
					"_CumInside",
					"_CumInside_Overcum"
					]
					#rb loader
					chcg_decider_basic_arousal(pose=rand(5+1))
					chcg_decider_basic_mouth(pose=rand(5+1))
					load_script("Data/HCGframes/EventMouth#{temp_CumStyle[rand(temp_CumStyle.length)]}.rb")
					chcg_decider_basic_anal(pose=rand(5+1))
					load_script("Data/HCGframes/EventAnal#{temp_CumStyle[rand(temp_CumStyle.length)]}.rb")
					chcg_decider_basic_vag(pose=rand(5+1))
					load_script("Data/HCGframes/EventVag#{temp_CumStyle[rand(temp_CumStyle.length)]}.rb")
					chcg_decider_basic_fapper(pose=rand(5+1))
					load_script("Data/HCGframes/Ext1_Fapper.rb")
					load_script("Data/HCGframes/Ext2_Fapper.rb")
					load_script("Data/HCGframes/Ext3_Fapper.rb")
					load_script("Data/HCGframes/Ext4_Fapper.rb")
					half_event_key_cleaner
					chcg_set_all_race("Human")
					load_script("Data/HCGframes/UniqueEvent_Peeon.rb")
					check_over_event
					check_half_over_event
					#==========================================清稿設定====================================
					whole_event_end
				portrait_hide
				chcg_background_color(0,0,0,0,7)
					call_msg("TagMapNorthFL_INN:Job/MeatToiletJob15")
					get_character(tmpG1id).moveto(1,1)
					get_character(tmpG2id).moveto(1,1)
					get_character(tmpG1id).npc_story_mode(false)
					get_character(tmpG2id).npc_story_mode(false)
					get_character(tmpG1id).animation = nil
					get_character(tmpG2id).animation = nil
					$game_player.transparent = false
					get_character(tmpMeatToiletPTid).manual_cw = tmp_mcw
					get_character(tmpMeatToiletPTid).manual_ch = tmp_mch
					get_character(tmpMeatToiletPTid).pattern   = tmp_mcp
					get_character(tmpMeatToiletPTid).direction = tmp_mcd
					set_event_force_page(tmpMeatToiletPTid,2)
					$game_player.actor.sta = -100
					$game_player.moveto(tmpWakeUpX,tmpWakeUpY)
					$game_player.actor.set_action_state(:none)
					$game_player.unset_event_chs_sex
					$game_player.animation = $game_player.animation_stun
					3.times{
						wait(30)
						SndLib.sound_step_chain(100)
					}
					get_character(tmpRaper0id).delete
					get_character(tmpRaper1id).delete
					get_character(tmpRaper2id).delete
					get_character(tmpRaper3id).delete
					get_character(tmpRaper4id).delete
					$game_player.actor.addCums("CumsCreamPie",500,"moot")
					$game_player.actor.addCums("CumsCreamPie",500,"Human")
					$game_player.actor.addCums("CumsMoonPie",500,"moot")
					$game_player.actor.addCums("CumsMoonPie",500,"Human")
					$game_player.actor.addCums("CumsCreamPie",500,"moot")
					$game_player.actor.addCums("CumsCreamPie",500,"Human")
					$game_player.actor.addCums("CumsMoonPie",500,"moot")
					$game_player.actor.addCums("CumsMoonPie",500,"Human")
					$game_player.actor.addCums("CumsCreamPie",500,"moot")
					$game_player.actor.addCums("CumsCreamPie",500,"Human")
					$game_player.actor.addCums("CumsMoonPie",500,"moot")
					$game_player.actor.addCums("CumsMoonPie",500,"Human")
					portrait_off
				chcg_background_color(0,0,0,255,-7)
				get_character(tmpDualBiosID).summon_data[:Qtaken] = true
				get_character(tmpDualBiosID).summon_data[:JobDone] = true
				#get_character(tmpDualBiosID).summon_data[:Qtaken] = true
				#get_character(tmpDualBiosID).summon_data[:JobDone] = false
			when "Suck"
				call_msg("TagMapNorthFL_INN:Job/SuckJob0")
				get_character(tmpDualBiosID).summon_data[:Qtaken] = true
				get_character(tmpDualBiosID).summon_data[:JobDone] = false
			when "Whore"
				call_msg("TagMapNorthFL_INN:Job/WhoreJob0")
				get_character(tmpDualBiosID).summon_data[:Qtaken] = true
				get_character(tmpDualBiosID).summon_data[:JobDone] = false
			end
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			get_character(tmpG1id).moveto(tmpG1X,tmpG1Y)
			get_character(tmpG2id).moveto(tmpG2X,tmpG2Y)
			get_character(tmpG1id).opacity = 0
			get_character(tmpG2id).opacity = 0
	end
	
end


$story_stats["LimitedNeedsSkill"] =1
chcg_background_color(0,0,0,255,-7) if $story_stats["ReRollHalfEvents"] ==1
eventPlayEnd
get_character(0).erase
