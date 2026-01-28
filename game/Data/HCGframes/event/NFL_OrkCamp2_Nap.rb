
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

tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
if $story_stats["RapeLoop"] == 1
	chcg_background_color(0,0,0,0,7)
	map_background_color(0,0,0,255,0)
	$story_stats["DreamPTSD"] = "Orkind" if $game_player.actor.mood <= -50
		##################################本區間控制玩家是否被抓住了的對白差分############################
	#cg_random = ["temp/map_OrkinGonnaRape","temp/event_WartsDick"]
	#$cg = TempCG.new([cg_random[rand(cg_random.length)]])
	$cg = TempCG.new(["event_OrkindGonnaRape"])
	if $story_stats["Captured"] == 0
		$story_stats["RapeLoopTorture"] = 0
		call_msg("TagMapNFL_OrkCamp2:NFL_OrkCamp2/RapeLoopNonCapture")
		call_msg("common:Lona/use_as_MeatToilet#{talk_style}")
	elsif get_character(tmpDualBiosID).summon_data[:JobSelect] == "None"
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
	
	
	
	if (get_character(tmpDualBiosID).summon_data[:JobSelect]= "None" && [true,false].sample) || $story_stats["RapeLoopTorture"] == 1
		$game_player.actor.record_lona_title = "Rapeloop/OrkindCaveRapeLoop"
		load_script("Data/HCGframes/event/OrkindCave_NapGangRape.rb")
		check_over_event
		check_half_over_event
	end
	if $game_player.actor.preg_level == 5
		load_script("Data/Batch/birth_trigger.rb")
	end
	handleNap(:point,map_id,"WakeUp")
	chcg_background_color(0,0,0,255,-7)
	
else
	##如果在安全區
	handleNap
	chcg_background_color(0,0,0,255,-7)
end
