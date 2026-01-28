if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if $story_stats["Captured"] == 0
	call_msg("TagMapFishTown:QuestGiver/NonCapture")
	return eventPlayEnd
end
if $story_stats["Captured"] == 1 && get_character(0).move_type == 0
	get_character(0).move_type = 3
	get_character(0).set_manual_move_type(3)
end
tmpMCid = $game_map.get_storypoint("MapCont")[2]
tmpH1Did = $game_map.get_storypoint("House1Door")[2]
tmpH2Did = $game_map.get_storypoint("House2Door")[2]
tmpHd1id = $game_map.get_storypoint("house1Dude")[2]
tmpHd2id = $game_map.get_storypoint("house2Dude")[2]
tmpWuid = $game_map.get_storypoint("WakeUp")[2]
tmpSWx,tmpSWy,tmpSWid = $game_map.get_storypoint("SeaWitch")
tmpSlaveHouseid = $game_map.get_storypoint("ToSlaveHouse")[2]
get_character(0).call_balloon(0)

############################################################################## PREG CHECK
if $game_player.actor.empregnanted? && !["Deepone","Fishkind"].include?($game_player.actor.baby_race)
		call_msg("TagMapFishTown:QuestGiver/pregCheck0")
		portrait_off
		$game_player.actor.stat["EventAnal"] = "AnalTouch"
		$game_player.actor.stat["EventVag"] = "Snuff"
		$game_player.actor.stat["EventExt1"] = "Grab"
		if $story_stats["sex_record_baby_birth"] >=1 || $story_stats["sex_record_miscarriage"] >=1
		call_msg("common:Lona/MonsterPregCheckbegin1_exped")
		else
		call_msg("common:Lona/MonsterPregCheckbegin1_unexped")
		end
		check_over_event
		call_msg("common:Lona/MonsterPregCheckbegin2#{talk_style}")
		check_over_event
		call_msg("common:Lona/MonsterPregCheckbegin3")
		check_over_event
	whole_event_end
	$game_temp.choice = -1
	call_msg("TagMapFishTown:QuestGiver/pregCheck1") #Drink,Don't drink...]
	if $game_temp.choice == 0
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			SndLib.sound_drink3
			wait(60)
			SndLib.sound_drink2
			wait(60)
			SndLib.sound_drink3
			wait(60)
			$game_player.actor.itemUseBatch("ItemAbortion")
			$game_player.actor.itemUseBatch("ItemHiPotionLV5")
			$game_player.actor.itemUseBatch("ItemBluePotion")
			$game_player.actor.baby_health = 0
			$game_player.actor.refresh
			$game_player.actor.update_lonaStat
		chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapFishTown:QuestGiver/pregCheck2")
		check_half_over_event
		$game_player.actor.sta -=20
		player_force_update
		call_msg("TagMapFishTown:QuestGiver/pregCheck3")
		$game_player.actor.force_stun("Stun1")
		get_character(0).call_balloon(28,-1) if get_character(tmpMCid).summon_data[:JobDone] == false
	else
		call_msg("TagMapFishTown:QuestGiver/Aggro")
		get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],600)
		return eventPlayEnd
	end

############################################################################## Vag Training
elsif get_character(0).summon_data[:vagTrained] == false && $game_date.night? && $game_player.actor.stat["VaginalDamaged"] != 1
	if $game_player.actor.empregnanted? && ["Deepone","Fishkind"].include?($game_player.actor.baby_race)
		call_msg("TagMapFishTown:QuestGiver/pregCheck0")
		portrait_off
		$game_player.actor.stat["EventAnal"] = "AnalTouch"
		$game_player.actor.stat["EventVag"] = "Snuff"
		$game_player.actor.stat["EventExt1"] = "Grab"
		if $story_stats["sex_record_baby_birth"] >=1 || $story_stats["sex_record_miscarriage"] >=1
		call_msg("common:Lona/MonsterPregCheckbegin1_exped")
		else
		call_msg("common:Lona/MonsterPregCheckbegin1_unexped")
		end
		check_over_event
		call_msg("common:Lona/MonsterPregCheckbegin2#{talk_style}")
		check_over_event
		call_msg("common:Lona/MonsterPregCheckbegin3")
		check_over_event
		whole_event_end
		get_character(0).summon_data[:vagTrained] = true
		call_msg("TagMapFishTown:QuestGiver/VagTraining_preg")
		$game_player.actor.force_stun("Stun1")
		get_character(0).call_balloon(28,-1) if get_character(tmpMCid).summon_data[:JobDone] == false
		whole_event_end
		return eventPlayEnd
	end
	
	$game_temp.choice = -1
	call_msg("TagMapFishTown:QuestGiver/VagTraining0") #[是,不要,]
	if $game_temp.choice == 0
		get_character(0).summon_data[:vagTrained] = true
		unique_event_VagDilatation("Fishkind")
		whole_event_end
		$game_player.actor.force_stun("Stun1")
		get_character(0).call_balloon(28,-1) if get_character(tmpMCid).summon_data[:JobDone] == false
	else
		call_msg("TagMapFishTown:QuestGiver/Aggro")
		get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],600)
		whole_event_end
		return eventPlayEnd
	end

############################################################################## Pick a job
elsif get_character(tmpMCid).summon_data[:JobPick] == "" && get_character(tmpMCid).summon_data[:JobDone] == false
	get_character(tmpMCid).summon_data[:JobPick] = get_character(tmpMCid).summon_data[:JobRandGen]
	case get_character(tmpMCid).summon_data[:JobPick]
		when "House1"
			cam_follow(tmpH1Did,0)
			get_character(tmpH1Did).call_balloon(19)
			get_character(tmpHd1id).summon_data[:QuestPicked] = true
			call_msg("TagMapFishTown:QuestGiver/Job_House")
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:House1InTag]
				event[1].call_balloon(28,-1)
			}
			
		when "House2"
			cam_follow(tmpH2Did,0)
			get_character(tmpH2Did).call_balloon(19)
			get_character(tmpHd2id).summon_data[:QuestPicked] = true
			call_msg("TagMapFishTown:QuestGiver/Job_House")
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:House2InTag]
				event[1].call_balloon(28,-1)
			}
		when "FindParnter"
			tmpid = get_character(0).id
			tmpAry = []
			$game_map.npcs.each{|event|
				next if !event.summon_data
				next if !event.summon_data[:guard]
				next if !event.summon_data[:SexTradeble] == true
				next if event.deleted? || event.actor.action_state == :death
				event.call_balloon(28,-1)
				tmpid= event.id
				tmpAry << event.id

			}
			call_msg("TagMapFishTown:Guards/OfferSex0")
			cam_follow(tmpAry.sample,0)
			call_msg("TagMapFishTown:Guards/OfferSex1")
			
		when "sexParty"
			$game_player.actor.record_lona_title = "Rapeloop/FishTownR"
			call_msg("TagMapFishTown:QuestGiver/sexParty0")
			get_character(tmpMCid).summon_data[:JobDone] = true
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				portrait_off
				get_character(0).moveto(tmpSWx,tmpSWy+1)
				get_character(0).npc.remove_skill("killer","NpcMarkMoralityDown")
				get_character(0).npc.remove_skill("assaulter","NpcMarkMoralityDown")
				get_character(0).trigger = -1
				get_character(0).set_manual_trigger(-1)
				#get_character(0).npc.fucker_condition={"sex"=>[0, "="]}
				get_character(0).npc.no_aggro = true
				get_character(0).direction = 2
				posi=$game_map.region_map[6].sample
				$game_player.moveto(posi[0],posi[1])
				$game_player.direction  = 8
				$game_map.npcs.each{|event|
					next if !event.summon_data
					next unless event.summon_data[:slave] == true
					next unless !event.summon_data[:slave2]
					next if event.deleted? || event.actor.action_state == :death
					event.delete
				}
				$game_map.npcs.each{|event|
					next if !event.summon_data
					next if !event.summon_data[:slave2] == true
					next if event.deleted? || event.actor.action_state == :death
					event.npc_story_mode(true)
					event.npc.remove_skill("killer","NpcMarkMoralityDown")
					event.npc.remove_skill("assaulter","NpcMarkMoralityDown")
					event.set_manual_move_type(0)
					event.move_type = 0
					posi=$game_map.region_map[6].sample
					event.moveto(posi[0],posi[1])
					event.item_jump_to
					event.direction = 8
				}
				wait(20)
				$game_map.npcs.each{|event|
					next if !event.summon_data
					next if !event.summon_data[:slave2] == true
					next if event.deleted?
					next if event.deleted? || event.actor.action_state == :death
					event.npc_story_mode(false)
				}
				$game_map.npcs.each{|event|
					next if !event.summon_data
					next if !event.summon_data[:gangRape]
					next if event.deleted? || event.actor.action_state == :death
					posi=$game_map.region_map[3].sample
					event.npc.remove_skill("killer","NpcMarkMoralityDown")
					event.npc.remove_skill("assaulter","NpcMarkMoralityDown")
					event.moveto(posi[0],posi[1])
					event.turn_toward_character($game_player)
					event.npc.fucker_condition={"sex"=>[0, "="]}
					event.npc.no_aggro = true
					event.animation = nil
					event.set_manual_move_type(2)
					event.move_type = 2
					event.direction = 8
				}
			chcg_background_color(0,0,0,255,-7)
			call_msg("TagMapFishTown:QuestGiver/sexParty1") ; portrait_hide
				$game_map.npcs.each{|event|
					next if !event.summon_data
					next if !event.summon_data[:gangRape]
					next if event.deleted? || event.actor.action_state == :death
					event.call_balloon(20)
				}
			call_msg("TagMapFishTown:QuestGiver/sexParty2") ; portrait_hide
				$game_map.npcs.each{|event|
					next if !event.summon_data
					next if !event.summon_data[:gangRape]
					next if event.deleted? || event.actor.action_state == :death
					event.call_balloon(20)
				}
			call_msg("TagMapFishTown:QuestGiver/sexParty3") ; portrait_hide
			get_character(0).animation = get_character(0).animation_dance
		else #None
			call_msg("TagMapFishTown:QuestGiver/NoWorkToday")
			get_character(tmpMCid).summon_data[:JobDone] = true
			
	end
	
############################################################################## check job done or not
elsif get_character(tmpMCid).summon_data[:JobPick] != "" && get_character(tmpMCid).summon_data[:JobDone] == false
	call_msg("TagMapFishTown:QuestGiver/GotoWork")
	if !$game_map.events[tmpHd1id].nil? && get_character(tmpHd1id).summon_data[:QuestDone] == true && get_character(tmpMCid).summon_data[:JobPick] == "House1"
		get_character(tmpMCid).summon_data[:JobDone] = true
		call_msg("TagMapFishTown:QuestGiver/GotoDone")
		call_msg("TagMapFishTown:QuestGiver/GotoRest")
			get_character(tmpWuid).call_balloon(28,-1)
	elsif !$game_map.events[tmpHd2id].nil? && get_character(tmpHd2id).summon_data[:QuestDone] == true && get_character(tmpMCid).summon_data[:JobPick] == "House2"
		call_msg("TagMapFishTown:QuestGiver/GotoDone")
		call_msg("TagMapFishTown:QuestGiver/GotoRest")
			get_character(tmpWuid).call_balloon(28,-1)
		get_character(tmpMCid).summon_data[:JobDone] = true
	elsif get_character(tmpMCid).summon_data[:JobPick] == "FindParnter"
		tmpCount = 0
		$game_map.npcs.each{
			|event|
			next unless event.summon_data
			next unless event.summon_data[:SexTradeble] == false
			next unless event.summon_data[:FindParnter_Did] == true
			next if event.deleted?
			tmpCount += 1
		}
		if tmpCount >= 2
			call_msg("TagMapFishTown:QuestGiver/GotoDone")
			call_msg("TagMapFishTown:QuestGiver/GotoRest")
			get_character(tmpWuid).call_balloon(28,-1)
			get_character(tmpMCid).summon_data[:JobDone] = true
		else
			call_msg("TagMapFishTown:QuestGiver/GotoWork_yes")
		end
	else
		call_msg("TagMapFishTown:QuestGiver/GotoWork_yes")
	end
else
	call_msg("TagMapFishTown:QuestGiver/GotoRest")
	get_character(tmpWuid).call_balloon(28,-1)
end

eventPlayEnd
