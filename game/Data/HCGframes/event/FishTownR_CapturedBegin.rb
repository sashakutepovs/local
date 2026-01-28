tmpFish2X,tmpFish2Y,tmpFish2ID=$game_map.get_storypoint("FishGp2")
tmpTorX,tmpTorY,tmpTorID=$game_map.get_storypoint("TorOBJ")
tmpQugX,tmpQugY,tmpQugID=$game_map.get_storypoint("QuestGiver")
tmpWk5X,tmpWk5Y,tmpWk5ID=$game_map.get_storypoint("WalkPT5")
tmpMCid=$game_map.get_storypoint("MapCont")[2]

if $story_stats["Captured"] == 1 && !$game_player.player_cuffed?
	rape_loop_drop_item(false,false)
	load_script("Data/Batch/Put_BondageItemsON.rb") #上銬批次檔
	$story_stats["dialog_cuff_equiped"]=0
	SndLib.sound_equip_armor(125)
end

######################################## begin event ###############################################################

	
if $story_stats["Captured"] == 1 && $story_stats["ReRollHalfEvents"] == 1 && $story_stats["RapeLoop"] == 1 && $story_stats["RapeLoopTorture"] == 0
	$game_player.moveto(tmpWk5X+2,tmpWk5Y)
	$game_player.direction = 6
	get_character(tmpQugID).moveto(tmpWk5X+3,tmpWk5Y)
	get_character(tmpQugID).npc_story_mode(true)
	get_character(tmpQugID).direction = 4
	portrait_hide
	chcg_background_color(0,0,0,255,-7)
		portrait_off
		call_msg("TagMapFishTown:capture/begin0")
		portrait_hide
		get_character(tmpQugID).direction = 6
		get_character(tmpQugID).move_forward
		wait(45)
		get_character(tmpQugID).direction = 4
		call_msg("TagMapFishTown:capture/begin1")
		portrait_hide
	chcg_background_color(0,0,0,0,7)
	get_character(tmpQugID).moveto(tmpFish2X+1,tmpFish2Y-1)
	get_character(tmpQugID).direction = 8
	$game_player.moveto(tmpFish2X+1,tmpFish2Y)
	$game_player.direction = 8
	portrait_hide
	chcg_background_color(0,0,0,255,-7)
		portrait_off
		get_character(tmpQugID).move_forward
		wait(45)
		get_character(tmpQugID).direction = 2
		call_msg("TagMapFishTown:capture/begin2")
		portrait_hide
	chcg_background_color(0,0,0,0,7)
	get_character(tmpQugID).moveto(tmpQugX,tmpQugY)
	get_character(tmpQugID).direction = 2
	$game_player.moveto(tmpQugX,tmpQugY+1)
	$game_player.direction = 8
	portrait_hide
	chcg_background_color(0,0,0,255,-7)
		portrait_off
		get_character(tmpQugID).move_forward
		wait(45)
		get_character(tmpQugID).direction = 2
		call_msg("TagMapFishTown:capture/begin3")
		portrait_hide
		chcg_background_color(0,0,0,0,7)
	portrait_off
	$game_player.direction = 2
	get_character(tmpQugID).npc_story_mode(false)
	get_character(tmpQugID).moveto(tmpQugX,tmpQugY)
	get_character(tmpQugID).direction = 2
	get_character(tmpQugID).call_balloon(28,-1)
		


######################################## torture ###############################################################
elsif $story_stats["Captured"] == 1 && $story_stats["RapeLoopTorture"] ==1
	$story_stats["RapeLoopTorture"] = 0
	if get_character(tmpMCid).summon_data[:BirthRecoverDay] == true
		get_character(tmpMCid).summon_data[:BirthRecoverDay] = false
		call_msg("TagMapFishTown:NearLabor/begin#{rand(2)}")
	elsif $game_player.actor.laborDate_to_dateAmt && $game_player.actor.laborDate_to_dateAmt >= $game_date.dateAmt-4 && ["Deepone","Fishkind"].include?($game_player.actor.baby_race)
		get_character(tmpMCid).summon_data[:BirthRecoverDay] = true
		call_msg("TagMapFishTown:NearLabor/begin#{rand(2)}")
	else
		get_character(tmpFish2ID).delete if $game_date.day?
		get_character(tmpTorID).moveto(tmpFish2X,tmpFish2Y-2)
		$game_player.moveto(1,1)
		$game_player.direction = 2
		cam_follow(tmpTorID,0)
		get_character(tmpQugID).moveto(tmpFish2X,tmpFish2Y)
		get_character(tmpQugID).npc_story_mode(true)
		get_character(tmpQugID).direction = 8
		tmpNpcCount = 0
		$game_map.npcs.each do |event|
			next unless event.summon_data
			next unless event.summon_data[:slave]
			next if event.actor.action_state == :death
			event.animation = nil
			event.move_type = 0
			event.moveto(tmpFish2X-2,tmpFish2Y-2) if tmpNpcCount == 0
			event.moveto(tmpFish2X-2,tmpFish2Y-1) if tmpNpcCount == 1
			event.moveto(tmpFish2X+2,tmpFish2Y-2) if tmpNpcCount == 2
			event.moveto(tmpFish2X+2,tmpFish2Y-1) if tmpNpcCount == 3
			tmpNpcCount += 1
			event.turn_toward_character(get_character(tmpTorID))
		end
		portrait_hide
		chcg_background_color(0,0,0,255,-7)
			portrait_off
			call_msg("TagMapFishTown:torture/begin0")
			get_character(tmpQugID).direction = 8
			get_character(tmpQugID).move_forward
			wait(60)
			SndLib.sound_equip_armor(100)
			get_character(tmpQugID).animation = get_character(tmpQugID).animation_hold_sh
			call_msg("TagMapFishTown:torture/begin1")
			unique_event_AnalNeedle("Fishkind")
			unique_event_AnalDilatation("Fishkind")
			portrait_off
			get_character(tmpQugID).direction = 2
			call_msg("TagMapFishTown:torture/begin2")
			get_character(tmpQugID).animation = nil
			portrait_hide
		chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpQugID).moveto(tmpQugX,tmpQugY)
		get_character(tmpQugID).direction = 2
		get_character(tmpQugID).npc_story_mode(false)
		$game_map.npcs.each do |event|
			next unless event.summon_data
			next unless event.summon_data[:slave]
			next if event.actor.action_state == :death
			event.move_type = 1
		end
		cam_center(0)
		get_character(tmpTorID).delete
		get_character(tmpQugID).call_balloon(28,-1)
		whole_event_end
	end
######################################## Normal Rape ###############################################################
elsif $story_stats["Captured"] == 1 && rand(100) >= 50
	tmpEVfucker = nil
	$game_map.npcs.any? {|event|
		next unless event.summon_data
		next unless event.summon_data[:NapFucker]
		next if rand(100) >= 50
		tmpEVfucker = event
	}
	if tmpEVfucker != nil
		tmpReturnX = tmpEVfucker.x
		tmpReturnY = tmpEVfucker.y
		tmpMoveType = tmpEVfucker.move_type
		tmpEVfucker.npc_story_mode(true)
		tmpEVfucker.moveto($game_player.x,$game_player.y)
		tmpEVfucker.move_type = 0
		tmpEVfucker.item_jump_to
		tmpEVfucker.turn_toward_character($game_player)
		$game_player.animation = $game_player.animation_stun
		portrait_hide
		whole_event_end
		chcg_background_color(0,0,0,255,-7)
			portrait_off
			$game_player.turn_toward_character(tmpEVfucker)
			cam_follow(tmpEVfucker.id,0)
			tmpEVfucker.call_balloon(20)
			call_msg("TagMapFishTown:wakeUpRape/begin0")
			$game_player.animation = nil
			tmpEVfucker.animation = tmpEVfucker.animation_hold_sh
			cam_follow(tmpEVfucker.id,0)
			tmpEVfucker.call_balloon(20)
			call_msg("TagMapFishTown:wakeUpRape/begin1")
				portrait_off
				play_sex_service_main(ev_target=tmpEVfucker,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=nil)
				play_sex_service_main(ev_target=tmpEVfucker,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=nil)
				portrait_off
				tmpEVfucker.call_balloon(20)
				call_msg("TagMapFishTown:wakeUpRape/begin2_#{rand(3)}")
				portrait_off
				play_sex_service_main(ev_target=tmpEVfucker,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=nil)
				play_sex_service_main(ev_target=tmpEVfucker,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=nil)
				play_sex_service_main(ev_target=tmpEVfucker,temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=nil)
				portrait_off
				tmpEVfucker.call_balloon(20)
				call_msg("TagMapFishTown:wakeUpRape/begin3_#{rand(3)}")
				portrait_off
				$game_player.actor.stat["EventVagRace"] =  "Fishkind"
				$game_player.actor.stat["EventVag"] = "CumInside1"
				load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
				portrait_off
				wait(40)
		chcg_background_color(0,0,0,0,7)
		$game_player.unset_event_chs_sex
		$game_player.animation = nil
		$game_player.actor.set_action_state(:none)
		tmpEVfucker.unset_event_chs_sex
		tmpEVfucker.animation = nil
		tmpEVfucker.npc_story_mode(false)
		tmpEVfucker.moveto(tmpReturnX,tmpReturnY)
		tmpEVfucker.move_type = tmpMoveType
		call_msg("TagMapFishTown:wakeUpRape/begin4_#{rand(3)}")
		call_msg("TagMapFishTown:wakeUpRape/begin5")
		whole_event_end
	end
end

############################################################################ Gen JobList
if $story_stats["Captured"] == 1
	get_character(tmpMCid).summon_data[:JobDone] = false #turn off the job
	if $game_date.day?
		get_character(tmpMCid).summon_data[:JobList] = ["House1","House2","none","none"]
	else # night
		tmpNightEve = ["FindParnter","none"]
		tmpNightEve << "sexParty" if rand(($game_player.actor.health/2).to_i) > 50
		get_character(tmpMCid).summon_data[:JobList] = tmpNightEve
	end
	get_character(tmpMCid).summon_data[:JobPick] = ""
	get_character(tmpMCid).summon_data[:JobRandGen] = get_character(tmpMCid).summon_data[:JobList].sample
	get_character(tmpQugID).call_balloon(28,-1)
end
######################################## end ###############################################################
portrait_hide
cam_center(0)
