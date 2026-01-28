

tmpMobAlive = $game_map.npcs.any?{|event| 
	next unless event.summon_data
	next unless event.summon_data[:WildnessNapEvent]
	next if event.deleted?
	next if event.npc.action_state == :death
	true
}
tmpMobAlive = true if $story_stats["Captured"] == 1
$story_stats["RapeLoop"] = 1 if tmpMobAlive

if $story_stats["RapeLoop"] == 1
	$story_stats["DreamPTSD"] = "Orkind" if $game_player.actor.mood <= -50
		##################################本區間控制玩家是否被抓住了的對白差分############################
	#cg_random = ["temp/map_OrkinGonnaRape","temp/event_WartsDick"]
	#$cg = TempCG.new([cg_random[rand(cg_random.length)]])
	$cg = TempCG.new(["event_OrkindGonnaRape"])
	if $story_stats["Captured"] == 0
		call_msg("TagMapRandOrkindCave:Lona/RapeLoopNonCapture")
		call_msg("common:Lona/use_as_MeatToilet#{talk_style}")
	else
		call_msg("TagMapRandOrkindCave:Lona/RapeLoopCaptured")
		call_msg("common:Lona/use_as_MeatToilet#{talk_style}")
	end
	
	$story_stats["Captured"] = 1
	$story_stats["Ending_MainCharacter"] = "Ending_MC_OrkindCampCaptured"
	
	#####################上銬模組################

	!equip_slot_removetable?(5) ? equips_5_id = -1 : equips_5_id = $game_player.actor.equips[5].id #TOP EXT
	!equip_slot_removetable?(0) ? equips_0_id = -1 : equips_0_id = $game_player.actor.equips[0].id #Weapon

	call_msg("TagMapRandOrkindCave:Lona/RapeLoopBondage") if ![21,20].include?(equips_0_id) && ![22,21].include?(equips_5_id)
	rape_loop_drop_item(false,false)  #解除玩家裝備批次黨
	load_script("Data/Batch/Put_BondageItemsON.rb") #上銬批次檔
	$cg.erase
	#################################  懷孕檢查  #############################
	if $story_stats["Record_CapturedPregCheckPassed"] !=1 && rand(100)+1 >= 75 || $game_actors[1].preg_level >=2
		load_script("Data/HCGframes/event/OrkindMonsterPregCheck.rb")
	end
	
	################################## 控制區間 當玩家尚有體力則玩昏玩家 ############################
	if $game_actors[1].sta > -90 && rand(100)+1 >=50
		
		CapturedPointX,CapturedPointY=$game_map.get_storypoint("CapturedPoint")
		$game_player.moveto(CapturedPointX,CapturedPointY)
		
		
		CapPointSpawnX,CapPointSpawnY=$game_map.get_storypoint("CapPointSpawn")
		$game_map.reserve_summon_event("RandomOrkindGroup",CapPointSpawnX,CapPointSpawnY,-1) if !$game_map.isOverMap
		
		chcg_background_color(0,0,0,255,-7)
		
		player_cancel_nap
		
		call_msg("TagMapRandOrkindCave:Lona/RapeLoopDragOut")  #they drag lona into ???
		call_msg("common:Lona/use_as_MeatToilet#{talk_style}")
		
		#$game_timer.count = 300 if $game_timer.count !=0 || $game_timer.count > 300
	else
		################################################################################################################
		########################################    龐大的種族RAPE區塊    ##############################################
		########################################### 詳細請開RB編輯		#############################################
	
		$game_player.actor.record_lona_title = "Rapeloop/OrkindCaveRapeLoop"
		load_script("Data/HCGframes/event/OrkindCave_NapGangRape.rb")
		
		if rand(100) > 50 || ($story_stats["Record_CapturedPregCheckPassed"] == 1 && ["Goblin","Orkind"].include?($game_player.actor.baby_race)) #$game_player.actor.sat <=20   #強制餵食
			$game_player.actor.stat["EventMouthRace"] = "Orkind"
			call_msg("commonH:Lona/ForceFeeding_OrkindRapeLoop")
			load_script("Data/HCGframes/UniqueEvent_ForceFeed.rb")
			$game_player.actor.baby_health += 500 if ["Goblin","Orkind"].include?($game_player.actor.baby_race)
		end
		
		################################################################################################################
		################################################################################################################
		check_over_event
		check_half_over_event
		if $game_actors[1].preg_level ==5
			load_script("Data/Batch/birth_trigger.rb")
		end
		handleNap(:point,map_id,"WakeUp")
		chcg_background_color(0,0,0,255,-7)
	end
else
	##如果在安全區
	handleNap
	chcg_background_color(0,0,0,255,-7)
end
