fadeout=$story_stats["ReRollHalfEvents"] == 1
enter_static_tag_map(nil,fadeout) if $story_stats["ReRollHalfEvents"] == 1
summon_companion
return if $story_stats["OverMapForceTrans"] != 0
tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
get_character(tmpWakeUpID).switch2_id = 1 #1 how many days, 2 do rape?
tarRleaseDate=rand(5)+2
tarDate=tarRleaseDate+get_character(tmpWakeUpID).switch1_id
#chcg_background_color(0,0,0,255,-7) if $story_stats["ReRollHalfEvents"] ==1

if $story_stats["SMCloudVillage_Aggroed"] == 1
 tmpAggroID=$game_map.get_storypoint("aggro")[2]
 get_character(tmpAggroID).start
end
####map unique set aggro
tmpQ1 = $story_stats["UniqueCharSMCloudVillage_BossAtk"] == -1
tmpQ2 = $story_stats["UniqueCharSMCloudVillage_Boss"] == -1
if tmpQ2 && tmpQ1 # if both warboss dead.   dudes dont know what to do .
	eventPlayEnd
	return get_character(0).erase
end


######################################## SoldEvent ###############################################
if $story_stats["Captured"] == 1 && $game_date.dateAmt >= tarDate
	tmpFucker1X,tmpFucker1Y,tmpFucker1ID = $game_map.get_storypoint("Raper1")
	tmpTraderX,tmpTraderY,tmpTraderID = $game_map.get_storypoint("Trader")
	tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
	get_character(tmpFucker1ID).npc_story_mode(true)
	get_character(tmpFucker1ID).moveto(get_character(tmpWakeUpID).x+1,get_character(tmpWakeUpID).y)
	get_character(tmpFucker1ID).turn_toward_character($game_player)
	get_character(tmpTraderID).moveto(get_character(tmpWakeUpID).x,get_character(tmpWakeUpID).y+1)
	get_character(tmpFucker1ID).turn_toward_character($game_player)
	call_msg("TagMapNoerMobHouse:Sold/begin1")
	$game_map.interpreter.chcg_background_color(0,0,0,255,-7)
	#do dialog
	get_character(tmpFucker1ID).turn_toward_character(get_character(tmpTraderID))
	call_msg("TagMapNoerMobHouse:Sold/begin2")
	get_character(tmpFucker1ID).turn_toward_character($game_player)
	call_msg("TagMapNoerMobHouse:Sold/begin3")
	get_character(tmpFucker1ID).turn_toward_character(get_character(tmpTraderID))
	call_msg("TagMapNoerMobHouse:Sold/begin4")
	$game_map.interpreter.chcg_background_color(40,0,40,0,7)
	
	if $game_player.actor.stat["SlaveBrand"] !=1
		$game_player.actor.stat["EventExt1Race"] = "Human"
		$game_player.actor.stat["EventExt1"] ="Grab"
		call_msg("TagMapNoerMobHouse:Sold/begin5")
		$game_player.actor.mood = -100
		$game_player.actor.add_state("SlaveBrand") #51
		whole_event_end
		#call_msg("TagMapNoerMobHouse:Sold/begin6")
	end
	$game_player.actor.morality_lona = 29
	
	#被賣到哪去?
	tmpTar = ["MinerPrison"]
	tmpTar << "NoerBackStreet" if $story_stats["UniqueCharUniqueGangBoss"] != -1 && $story_stats["UniqueCharUniqueHappyMerchant"] != -1 && !$DEMO
	tmpTar << "DoomFortressR" if !$DEMO
	tmpTar << "FishTownR" if !$DEMO
	tmpTar << "NoerArenaB1" if !$DEMO
	tmpTar << "NorthFL_INN" if !$DEMO
	tmpTar = tmpTar.sample
	$story_stats["OverMapForceTrans"] = tmpTar
	$story_stats["SlaveOwner"] = tmpTar
	case tmpTar
	when "MinerPrison"
			rape_loop_drop_item(false,false)
			$game_party.gain_item($data_armors[22], 1) 
			$game_player.actor.change_equip(5, $data_armors[22])
			$story_stats["dialog_collar_equiped"] =0
			call_msg("TagMapNoerMobHouse:Sold/begin7_#{tmpTar}")
			get_character(tmpFucker1ID).npc_story_mode(false)
			#傳送主角至定點
			$game_player.move_normal
			$game_map.interpreter.chcg_background_color(0,0,0,255)
			$game_player.actor.sta = -99 if $game_player.actor.sta <= -99
			change_map_leave_tag_map
			$story_stats["Captured"] = 1
			SndLib.sound_equip_armor(125)
			
	when "NoerBackStreet"
			rape_loop_drop_item(false,false)
			$game_player.actor.change_equip(0, nil)
			$game_player.actor.change_equip(1, nil)
			$game_player.actor.change_equip(5, nil)
			load_script("Data/Batch/Put_BondageItemsON.rb")
			$story_stats["dialog_cuff_equiped"]=0
			SndLib.sound_equip_armor(125)
			call_msg("TagMapNoerMobHouse:Sold/begin7_#{tmpTar}")
			get_character(tmpFucker1ID).npc_story_mode(false)
			#傳送主角至定點
			$game_player.move_normal
			$game_map.interpreter.chcg_background_color(0,0,0,255)
			$game_player.actor.sta = -99 if $game_player.actor.sta <= -99
			change_map_leave_tag_map
			$story_stats["RapeLoop"] =1
			$story_stats["RapeLoopTorture"] =0
			$story_stats["Captured"] = 1
			$story_stats["BackStreetArrearsWhorePrincipal"] = 600+($story_stats["WorldDifficulty"]*3).round
			
		when "NorthFL_INN"
			rape_loop_drop_item(false,false)

			load_script("Data/Batch/Put_BondageItemsON.rb")
			$story_stats["dialog_collar_equiped"] =0
			$story_stats["dialog_cuff_equiped"]=0
			call_msg("TagMapNoerMobHouse:Sold/begin7_#{tmpTar}")
			get_character(tmpFucker1ID).npc_story_mode(false)
			#傳送主角至定點
			$game_player.move_normal
			$game_map.interpreter.chcg_background_color(0,0,0,255)
			$game_player.actor.sta = -99 if $game_player.actor.sta <= -99
			change_map_leave_tag_map
			$story_stats["Captured"] = 1
			$story_stats["RapeLoop"] = 1
			$story_stats["RapeLoopTorture"] = 0
			SndLib.sound_equip_armor(125)
			
		when "DoomFortressR"
			rape_loop_drop_item(false,false)

			load_script("Data/Batch/Put_BondageItemsON.rb")
			$story_stats["dialog_collar_equiped"] =0
			$story_stats["dialog_cuff_equiped"]=0
			call_msg("TagMapNoerMobHouse:Sold/begin7_#{tmpTar}")
			get_character(tmpFucker1ID).npc_story_mode(false)
			#傳送主角至定點
			$game_player.move_normal
			$game_map.interpreter.chcg_background_color(0,0,0,255)
			$game_player.actor.sta = -99 if $game_player.actor.sta <= -99
			change_map_leave_tag_map
			$story_stats["Captured"] = 1
			$story_stats["RapeLoop"] = 1
			$story_stats["RapeLoopTorture"] = 0
			SndLib.sound_equip_armor(125)
			
			
		when "FishTownR"
			rape_loop_drop_item(false,false)

			load_script("Data/Batch/Put_BondageItemsON.rb")
			$story_stats["dialog_collar_equiped"] =0
			$story_stats["dialog_cuff_equiped"]=0
			call_msg("TagMapNoerMobHouse:Sold/begin7_#{tmpTar}")
			get_character(tmpFucker1ID).npc_story_mode(false)
			#傳送主角至定點
			$game_player.move_normal
			$game_map.interpreter.chcg_background_color(0,0,0,255)
			$game_player.actor.sta = -99 if $game_player.actor.sta <= -99
			change_map_leave_tag_map
			$story_stats["Captured"] = 1
			$story_stats["RapeLoop"] = 1
			$story_stats["RapeLoopTorture"] = 0
			SndLib.sound_equip_armor(125)
			
		when "NoerArenaB1"
			$game_player.actor.change_equip(0, nil)
			rape_loop_drop_item(false,false)
			$game_party.gain_item($data_armors[22], 1)
			$game_player.actor.change_equip(5, $data_armors[22])
			$story_stats["dialog_collar_equiped"] =0
			$story_stats["dialog_cuff_equiped"]=0
			call_msg("TagMapNoerMobHouse:Sold/begin7_#{tmpTar}")
			get_character(tmpFucker1ID).npc_story_mode(false)
			#傳送主角至定點
			$game_player.move_normal
			$game_map.interpreter.chcg_background_color(0,0,0,255)
			$game_player.actor.sta = -99 if $game_player.actor.sta <= -99
			change_map_leave_tag_map
			$story_stats["Captured"] = 1
			$story_stats["RapeLoop"] = 1
			$story_stats["RapeLoopTorture"] = 0
			SndLib.sound_equip_armor(125)
			
	end
	eventPlayEnd
	return #get_character(0).erase #should not erase in a map transfer event
end



######################################## begin event ###############################################################
if $story_stats["Captured"] == 1 && tarDate-tarRleaseDate == $game_date.dateAmt #$story_stats["ReRollHalfEvents"] ==1
	$game_player.moveto(tmpWakeUpX,tmpWakeUpY)
	$game_player.direction = 2
	tmpFucker1X,tmpFucker1Y,tmpFucker1ID = $game_map.get_storypoint("Raper1")
	get_character(tmpFucker1ID).moveto($game_player.x,$game_player.y+1)
	$game_map.interpreter.chcg_background_color(0,0,0,255,-7)
	get_character(tmpFucker1ID).call_balloon(5)
	call_msg("TagMapSMCloudVillage:beginEvent/begin")
	$game_map.interpreter.chcg_background_color(0,0,0,0,7)
	get_character(tmpFucker1ID).moveto(tmpFucker1X,tmpFucker1Y)
	eventPlayEnd
	return get_character(0).erase
	
######################################### 二哥處刑  ###############################################################
elsif $story_stats["Captured"] == 1 && $story_stats["ReRollHalfEvents"] ==0 && $game_date.night? && $story_stats["UniqueCharSMCloudVillage_BossAtk"] != -1 && $story_stats["UniqueCharSMCloudVillage_Boss"] == -1
	$game_player.moveto(tmpWakeUpX,tmpWakeUpY)
	tmpBossAtkID=$game_map.get_storypoint("BossAtk")[2]
	get_character(tmpBossAtkID).moveto($game_player.x,$game_player.y+1)
	get_character(tmpBossAtkID).turn_toward_character($game_player)
	$game_player.turn_toward_character(get_character(tmpBossAtkID))
	get_character(tmpBossAtkID).npc.add_fated_enemy([0])
	portrait_hide
	call_msg("TagMapSMCloudVillage:Common/WakeUpCall#{rand(3)}")
	$game_map.interpreter.chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapSMCloudVillage:BossAtk/NightRng_revenge")
	
######################################## Food event ###############################################################
elsif $story_stats["Captured"] == 1 && $story_stats["ReRollHalfEvents"] ==0 && $game_date.day? && $story_stats["RapeLoopTorture"] != 1
	$game_player.moveto(tmpWakeUpX,tmpWakeUpY)
	$game_player.direction = 2
	call_msg("TagMapSMCloudVillage:Common/PlaceFood0")
	call_msg("TagMapNoerMobHouse:Rogue/PlaceFood1")
	EvLib.sum("ItemBread",tmpWakeUpX,tmpWakeUpY+1)
	EvLib.sum("ItemBread",tmpWakeUpX,tmpWakeUpY+1)
	EvLib.sum("ItemBread",tmpWakeUpX,tmpWakeUpY+1)
	eventPlayEnd
	return get_character(0).erase
	
######################################### 二哥定期強暴  ###############################################################
elsif [true,false].sample && $story_stats["Captured"] == 1 && $story_stats["ReRollHalfEvents"] ==0 && $game_date.night? && $story_stats["RapeLoopTorture"] != 1 && $story_stats["UniqueCharSMCloudVillage_BossAtk"] != -1
	$game_player.moveto(tmpWakeUpX,tmpWakeUpY)
	$story_stats["DreamPTSD"] = "Bandit" if $game_player.actor.mood <= -50
	tmpBossAtkID=$game_map.get_storypoint("BossAtk")[2]
	get_character(tmpBossAtkID).moveto($game_player.x,$game_player.y+1)
	get_character(tmpBossAtkID).turn_toward_character($game_player)
	$game_player.turn_toward_character(get_character(tmpBossAtkID))
	get_character(tmpBossAtkID).npc.fucker_condition={"sex"=>[0, "="]}
	portrait_hide
	call_msg("TagMapSMCloudVillage:Common/WakeUpCall#{rand(3)}")
	$game_map.interpreter.chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapSMCloudVillage:BossAtk/NightRngRape")
	
	
######################################## 雜魚強暴  ###############################################################
elsif [true,false].sample && $story_stats["Captured"] == 1 && $story_stats["ReRollHalfEvents"] ==0 && $game_date.night?
	if !get_character(tmpFucker1ID).nil? && !get_character(tmpFucker2ID).nil?
		$game_player.moveto(tmpWakeUpX,tmpWakeUpY)
		tmpFucker1X,tmpFucker1Y,tmpFucker1ID = $game_map.get_storypoint("Raper1")
		tmpFucker2X,tmpFucker2Y,tmpFucker2ID = $game_map.get_storypoint("Raper2")
		$story_stats["DreamPTSD"] = "Bandit" if $game_player.actor.mood <= -50
		get_character(tmpFucker1ID).npc_story_mode(true)					
		get_character(tmpFucker1ID).moveto($game_player.x,$game_player.y+1)	
		get_character(tmpFucker1ID).turn_toward_character($game_player)		
		get_character(tmpFucker2ID).npc_story_mode(true)					
		get_character(tmpFucker2ID).moveto($game_player.x,$game_player.y+1)	
		get_character(tmpFucker2ID).item_jump_to							
		get_character(tmpFucker2ID).turn_toward_character($game_player)		
		portrait_hide
		call_msg("TagMapSMCloudVillage:Common/WakeUpCall#{rand(3)}")
		$game_map.interpreter.chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapSMCloudVillage:Common/NapRape")
	end
end

eventPlayEnd
get_character(0).erase
