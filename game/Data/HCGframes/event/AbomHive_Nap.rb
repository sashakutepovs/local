
tmpH_bios = get_character($game_map.get_storypoint("H_BIOS")[2])
tmpMobAlive = tmpH_bios.summon_data[:HiveDed] == false
if tmpMobAlive
$story_stats["RapeLoop"] = 1
else
$story_stats["RapeLoop"] = 0
end

if $story_stats["RapeLoop"] == 1
	$story_stats["DreamPTSD"] = "Abomination" if $game_player.actor.mood <= -50
	$game_player.actor.stat["EventVagRace"] =  "Abomination"
	$game_player.actor.stat["EventAnalRace"] = "Abomination"
	$game_player.actor.stat["EventMouthRace"] ="Abomination"
	$game_player.actor.stat["EventExt1Race"] = "Abomination"
	$game_player.actor.stat["EventExt2Race"] = "Abomination"
	$game_player.actor.stat["EventExt3Race"] = "Abomination"
	$game_player.actor.stat["EventExt4Race"] = "Abomination"





		##################################本區間控制玩家是否被抓住了的對白差分############################
	$cg = TempCG.new(["map_AbominationGroup"])
	if $story_stats["Captured"] == 0
		call_msg("commonH:Lona/grab#{talk_style}#{rand(3)}")
		SndLib.sound_chcg_chupa(120)
		lona_mood "p5shame"
		$game_player.actor.portrait.shake
		$game_player.actor.stat["EventVag"] = "VagTouch"
		call_msg("commonH:Lona/grab#{talk_style}#{rand(3)}")
		SndLib.sound_chcg_chupa(120)
		lona_mood "p5sta_damage"
		$game_player.actor.portrait.shake
		$game_player.actor.stat["EventAnal"] = "AnalTouch"
		call_msg("commonH:Lona/grab#{talk_style}#{rand(3)}")
		SndLib.sound_chcg_chupa(120)
		lona_mood "p5crit_damage"
		$game_player.actor.portrait.shake
		$game_player.actor.stat["EventExt1"] = "BoobTouch"
		call_msg("commonH:Lona/grab#{talk_style}#{rand(3)}")
		SndLib.sound_chcg_chupa(120)
		lona_mood "p5crit_damage"
		$game_player.actor.portrait.shake
		$game_player.actor.stat["EventMouth"] = "kissed"
		call_msg("commonH:Lona/grab#{talk_style}#{rand(3)}")
		
		SndLib.sound_chcg_chupa(120)
		call_msg("TagMapRandAbomHive:Lona/RapeLoopNonCapture")
		$game_player.actor.portrait.shake
		SndLib.sound_chcg_chupa(120)
		call_msg("commonH:Lona/beaten#{rand(10)}")
	else

		$game_player.actor.stat["EventVag"] = "VagTouch"
		$game_player.actor.stat["EventAnal"] = "AnalTouch"
		$game_player.actor.stat["EventExt1"] = "BoobTouch"
		$game_player.actor.stat["EventMouth"] = "kissed"
		SndLib.sound_chcg_chupa(120)
		call_msg("TagMapRandAbomHive:Lona/RapeLoopCaptured")
		$game_player.actor.portrait.shake
		SndLib.sound_chcg_chupa(120)
		call_msg("commonH:Lona/beaten#{rand(10)}")
	end
	
	tmpH_bios.switch2_id = 0 if $story_stats["Captured"] == 0
	$story_stats["Captured"] = 1
	$story_stats["Ending_MainCharacter"] = "Ending_MC_AbomHiveCaptured"
	
	#####################上銬模組################
	rape_loop_drop_item(false,false)  #解除玩家裝備批次黨
	$cg.erase
	
	################################################################################################################
	########################################    龐大的種族RAPE區塊    ##############################################
	########################################### 詳細請開RB編輯		#############################################

	$game_player.actor.record_lona_title = "Rapeloop/AbomHiveRapeLoop"
	load_script("Data/HCGframes/event/AbomHive_NapGangRape.rb")
	
	
	
	$game_player.actor.stat["EventMouthRace"] = "Abomination"
	#call_msg("commonH:Lona/ForceFeeding_AbomRapeLoop")
	load_script("Data/HCGframes/UniqueEvent_ForceFeed.rb")
	$game_player.actor.baby_health += 500 if ["Abomination"].include?($game_player.actor.baby_race)
	
	chcg_background_color(0,0,0,255)
	portrait_off
	call_msg("commonH:Lona/AbomRapeLoopEnd")
	$game_player.actor.sta -=10
	SndLib.sound_ManagerSpot
	SndLib.sound_chcg_fapper(80)
	SndLib.sound_chcg_full(80)
	wait(45)
	$game_player.actor.sta -=10
	SndLib.sound_ManagerSpot
	SndLib.sound_chcg_fapper(80)
	SndLib.sound_chcg_full(80)
	wait(45)
	$game_player.actor.sta -=10
	SndLib.sound_ManagerHurt
	SndLib.sound_chcg_fapper(80)
	SndLib.sound_chcg_full(80)
	wait(45)
	$game_player.actor.sta -=10
	SndLib.sound_ManagerAtk
	SndLib.sound_chcg_fapper(80)
	SndLib.sound_chcg_full(80)
	wait(45)
	$game_player.actor.sta -=10
	SndLib.sound_ManagerSpot
	SndLib.sound_chcg_fapper(80)
	SndLib.sound_chcg_full(80)
	wait(180)
	$game_player.actor.addCums("CumsCreamPie",1000,"Abomination")
	$game_player.actor.addCums("CumsCreamPie",1000,"Abomination")
	$game_player.actor.addCums("CumsCreamPie",1000,"Abomination")
	
	################################################################################################################
	################################################################################################################
	check_over_event
	check_half_over_event
	if $game_actors[1].preg_level ==5
		load_script("Data/Batch/birth_trigger.rb")
	end
	handleNap(:point,map_id,"WakeUp")
	chcg_background_color(0,0,0,255,-7)

else
##如果在安全區
handleNap
chcg_background_color(0,0,0,255,-7)
end
