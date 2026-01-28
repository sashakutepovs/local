
#check DateAmt
tmpSettled = ($game_date.dateAmt >= $story_stats["RecQuestSewerHoboAmt"] && $story_stats["RecQuestSewerHoboAmt"] != 0)

#check any hobo alive
tmpMobAlive = $game_map.npcs.any?{
|event| 
next unless event.summon_data
next unless event.summon_data[:WildnessNapEvent]
next if event.deleted?
next if event.npc.action_state == :death
true
} 
$story_stats["RapeLoop"] = 1 if tmpSettled && tmpMobAlive


if $story_stats["RapeLoop"] == 1
	#chcg_background_color(0,0,0,0,7)
	if $story_stats["Captured"] == 0
		call_msg("MainTownSewer:RapeLoopHobo/Begin0")
		$story_stats["Captured"] = 1
	end
	$story_stats["Ending_MainCharacter"] = "Ending_MC_HumanSlave" if $story_stats["Captured"] == 1
	$story_stats["RapeLoop"] =1
	portrait_hide
	
	##################### remove equip ################
	if $game_player.player_nude?
		call_msg("MainTownSewer:RapeLoopHobo/Begin1_remove_equip")
	end
	
	rape_loop_drop_item(false,false)  #解除玩家裝備批次黨
	
	################################## 控制區間 當玩家尚有體力則玩昏玩家 ############################
	if $game_player.actor.sta > -90 && rand(100)+1 >=50
		
		CapturedPointX,CapturedPointY=$game_map.get_storypoint("CapturedPoint")
		$game_player.moveto(CapturedPointX,CapturedPointY)
		
		$game_player.actor.setup_state("DoormatUp20",5)
		
		CapPointSpawn1X,CapPointSpawn1Y=$game_map.get_storypoint("CapPointSpawn1")
		$game_map.reserve_summon_event("MobHumanCommoner",CapPointSpawn1X,CapPointSpawn1Y,-1)
		$game_map.reserve_summon_event("MobMootCommoner",CapPointSpawn1X,CapPointSpawn1Y,-1)
		
		CapPointSpawn2X,CapPointSpawn2Y=$game_map.get_storypoint("CapPointSpawn2")
		$game_map.reserve_summon_event("MobHumanCommoner",CapPointSpawn2X,CapPointSpawn2Y,-1)
		$game_map.reserve_summon_event("MobMootCommoner",CapPointSpawn2X,CapPointSpawn2Y,-1)
		chcg_background_color(0,0,0,255,-7)
		
		player_cancel_nap
		call_msg("MainTownSewer:Lona/RapeLoopDragOut")
		call_msg("common:Lona/use_as_MeatToilet#{talk_style}")

	else
		################################################################################################################
		########################################    龐大的種族RAPE區塊    ##############################################
		########################################### 詳細請開RB編輯		#############################################
		$game_player.actor.record_lona_title = "Rapeloop/HoboMeatToilet"
		load_script("Data/HCGframes/event/HumanCave_NapGangRape.rb")
	
	################################################################################################################
	################################################################################################################
	check_over_event
	check_half_over_event
	handleNap(:point,map_id,"WakeUp")
	chcg_background_color(0,0,0,255,-7)
	end
else
	handleNap
	chcg_background_color(0,0,0,255,-7)
end
