tmpMobAlive = $game_map.npcs.any?{
|event| 
next unless event.summon_data
next unless event.summon_data[:WildnessNapEvent] == "BanditMobs"
next if event.deleted?
next if event.npc.action_state == :death
true
}

if !tmpMobAlive
	$story_stats["Captured"] = 0
	$story_stats["RapeLoop"] = 0
	portrait_hide
	return handleNap
end

chcg_background_color(0,0,0,0,7)

#若BS腳色都還活著 則被賣到BS 若否則去盜賊屋
if [17,18,19,20].include?($story_stats["QuProgSaveCecily"])
	SndLib.bgm_stop
	SndLib.bgs_stop
	portrait_hide
	portrait_off
	$story_stats["UniqueCharUniqueMaani"] != -1 ? call_msg("CompCecily:Nap/failed_onCecilyQuest0_Maani") : call_msg("CompCecily:Nap/failed_onCecilyQuest0_Bandit")
	portrait_hide
	4.times{
		$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
		SndLib.sound_gore(100)
		SndLib.sound_combat_hit_gore(70)
		wait(20+rand(20))
	}
	chcg_background_color(0,0,0,255)
	wait(30)
	return load_script("Data/HCGframes/OverEvent_Death.rb")
	
elsif $story_stats["UniqueCharUniqueGangBoss"] != -1 && $story_stats["UniqueCharUniqueHappyMerchant"] != -1
	call_msg("TagMapNoerGangBase:Nap/failed0_normal")
	if $game_player.actor.stat["SlaveBrand"] !=1
		$game_player.actor.stat["EventExt1Race"] = "Human"
		$game_player.actor.stat["EventExt1"] ="Grab"
		call_msg("TagMapNoerGangBase:Nap/failed_normal_if_Non_Slave")
		call_msg("TagMapNoerMobHouse:Sold/begin5")
		$game_player.actor.mood = -100
		$game_player.actor.add_state("SlaveBrand") #51
		event_key_cleaner
		$cg.erase
		portrait_hide
	end 
	$story_stats["OverMapForceTrans"] = "NoerBackStreet"
	$story_stats["SlaveOwner"] = "NoerBackStreet"
	rape_loop_drop_item(false,false)
	$game_player.actor.change_equip(0, nil)
	$game_player.actor.change_equip(1, nil)
	$game_player.actor.change_equip(5, nil)
	load_script("Data/Batch/Put_BondageItemsON.rb")
	$story_stats["dialog_cuff_equiped"]=0
	SndLib.sound_equip_armor(125)
	$game_party.lose_item("ItemCuff", 99, include_equip =true)
	$game_party.lose_item("ItemChainCuff", 99, include_equip =true)
	$game_party.lose_item("ItemCollar", 99, include_equip =true)
	$game_party.lose_item("ItemChainCollar", 99, include_equip =true)
	#call_msg("adsfasdfasdfasdfasdf")
	#傳送主角至定點
	$game_player.move_normal
	$game_map.interpreter.chcg_background_color(0,0,0,255)
	$game_player.actor.sta = -99 if $game_player.actor.sta <= -99
	change_map_leave_tag_map
	$story_stats["RapeLoop"] = 1
	$story_stats["RapeLoopTorture"] = 0
	$story_stats["Captured"] = 1
	$story_stats["BackStreetArrearsWhorePrincipal"] = 600+($story_stats["WorldDifficulty"]*3).round
else 
	$story_stats["OverMapForceTrans"] = "NoerMobHouse"
	$game_player.actor.change_equip(5, nil)
	rape_loop_drop_item(false,false)

	load_script("Data/Batch/Put_BondageItemsON.rb")
	$story_stats["dialog_collar_equiped"] =0
	SndLib.sound_equip_armor(125)
	call_msg("TagMapCargoSaveCecily:QuestFailed/Nap3")
	player_force_update
	call_msg("TagMapCargoSaveCecily:QuestFailed/Nap1")
	$game_player.move_normal
	$game_player.actor.sta = -99 if $game_player.actor.sta <= -99
	change_map_leave_tag_map
	$story_stats["Captured"] = 1
end
return portrait_hide
