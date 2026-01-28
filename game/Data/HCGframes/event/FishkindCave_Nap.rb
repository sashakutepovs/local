##########隨機CAVE RAPE LOOP 模型#############
chcg_background_color(0,0,0,1,7) #fade out

#any alive? any target player?
#tmpMobAlive = $game_map.npcs.any?{
#|event| 
#next unless event.summon_data
#next unless event.summon_data[:WildnessNapEvent]
#next if event.deleted?
#next if event.npc.action_state == :death
#tgt =event.npc.target
#next unless !tgt.nil?
#ply =$game_player
#if tgt == ply
# true
#elsif tgt != ply && tgt.follower[0] ==1
# true
#else
# false
#end
#}


tmpMobAlive = $game_map.npcs.any?{
|event| 
next unless event.summon_data
next unless event.summon_data[:WildnessNapEvent]
next if event.deleted?
next if event.npc.action_state == :death
true
}

tmpMobAlive = true if $story_stats["Captured"] == 1
$story_stats["RapeLoop"] = 1 if tmpMobAlive

if $story_stats["RapeLoop"] == 1
	$story_stats["DreamPTSD"] = "Fishkind" if $game_player.actor.mood <= -50
		##################################本區間控制玩家是否被抓住了的對白差分############################
	$cg = TempCG.new(["event_FishkindGonnaRape"])
	if $story_stats["Captured"] == 0
		call_msg("TagMapRandFishkindCave:Lona/RapeLoopNonCapture")
		call_msg("common:Lona/use_as_MeatToilet#{talk_style}")
	else
		call_msg("TagMapRandFishkindCave:Lona/RapeLoopCaptured")
		call_msg("common:Lona/use_as_MeatToilet#{talk_style}")
	end
	
	$story_stats["Captured"] = 1
	$story_stats["Ending_MainCharacter"] = "Ending_MC_FishkindCampCaptured"
	
	#####################上銬模組################  失智的魚類不懂這個  以下排除
	rape_loop_drop_item(false,false)  #解除玩家裝備批次黨
	$cg.erase
	#################################  懷孕檢查  #############################
	if $story_stats["Record_CapturedPregCheckPassed"] !=1 && rand(100)+1 >= 75 || $game_actors[1].preg_level >=2
		load_script("Data/HCGframes/event/FishkindMonsterPregCheck.rb")
	end
	
	################################## 控制區間 當玩家尚有體力則玩昏玩家 ############################
	if $game_actors[1].sta > -90 && rand(100)+1 >=50
		
		CapturedPointX,CapturedPointY=$game_map.get_storypoint("CapturedPoint")
		$game_player.moveto(CapturedPointX,CapturedPointY)
		
		
		CapPointSpawnX,CapPointSpawnY=$game_map.get_storypoint("CapPointSpawn")
		$game_map.reserve_summon_event("RandomFishkindGroup",CapPointSpawnX,CapPointSpawnY,-1) if !$game_map.isOverMap
		
		chcg_background_color(0,0,0,255,-7)
		
		player_cancel_nap
		
		call_msg("TagMapRandFishkindCave:Lona/RapeLoopDragOut")  #they drag lona into ???
		call_msg("common:Lona/use_as_MeatToilet#{talk_style}")
		
		#$game_timer.count = 300 if $game_timer.count !=0 || $game_timer.count > 300
	else
	################################################################################################################
	########################################    龐大的種族RAPE區塊    ##############################################
	########################################### 詳細請開RB編輯		#############################################

	$game_player.actor.record_lona_title = "Rapeloop/FishkindCaveRapeLoop"
	load_script("Data/HCGframes/event/FishkindCave_NapGangRape.rb")
	
	if $game_player.actor.sat <= 20    #強制餵食
		$game_player.actor.stat["EventMouthRace"] = "Fishkind"
		call_msg("commonH:Lona/ForceFeeding_FishkindRapeLoop")
		load_script("Data/HCGframes/UniqueEvent_ForceFeed.rb")
		$game_player.actor.baby_health += 500 if ["Fishkind","Deepone"].include?($game_player.actor.baby_race)
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
