tmpMamaX,tmpMamaY,tmpMamaID = $game_map.get_storypoint("mama")
tmpPapaX,tmpPapaY,tmpPapaID = $game_map.get_storypoint("papa")
tmpSonX,tmpSonY,tmpSonID = $game_map.get_storypoint("son")
tmpMcX,tmpMcY,tmpMcID = $game_map.get_storypoint("MapCont")

tmpMobAlive = $game_map.npcs.any?{
|event| 
next unless event.summon_data
next unless event.summon_data[:family]
next if event.deleted?
next if event.npc.action_state == :death
next if event.npc.action_state == :stun
true
}
tmpFamilyCount = 0
$game_map.npcs.each{
|event|
	next unless event.summon_data
	next unless event.summon_data[:family]
	next if event.npc.action_state == :death
	next if event.deleted?
	tmpFamilyCount +=1
}


tmpPapaRaped	=	get_character(tmpMcID).summon_data[:PapaRaped]
tmpBreakfast	=	get_character(tmpMcID).summon_data[:Breakfast]
tmpWorked		=	get_character(tmpMcID).summon_data[:Worked]
tmpWorkType		=	get_character(tmpMcID).summon_data[:WorkType]
tmpNeedWork		=	get_character(tmpMcID).summon_data[:NeedWork]
tmpBoboKill		=	get_character(tmpMcID).summon_data[:BoboKill]
tmpMerryed = $story_stats["RecQuestDoomFarmAWaifu"] == 1
#check torture or not
if tmpFamilyCount == 3 && tmpMobAlive && $story_stats["Captured"] == 1 && $story_stats["RapeLoopTorture"] == 0 && tmpNeedWork && (tmpPapaRaped || tmpWorked)
	$story_stats["RapeLoopTorture"] = 1
end

$story_stats["Ending_MainCharacter"] = "Ending_MC_HumanSlave" if $story_stats["Captured"] == 1

#frist time capture
if tmpFamilyCount == 3 && tmpMobAlive && $story_stats["Captured"] == 0 && $story_stats["RapeLoopTorture"] == 0# && $story_stats["RecQuestDoomFarmAWaifu"] == 0
	portrait_hide
	chcg_background_color(0,0,0,0,7)
	portrait_off
	$story_stats["Captured"] = 1
	call_msg("TagMapDoomFarmA:Capture/FristTime_0")
	load_script("Data/Batch/Put_BondageItemsON.rb")
	$story_stats["dialog_cuff_equiped"]=0
	SndLib.sound_equip_armor(125)
	
	handleNap
	
#second time capture
elsif tmpFamilyCount == 3 && tmpMobAlive && $story_stats["Captured"] == 0 && $story_stats["RapeLoopTorture"] == 1#
	portrait_hide
	chcg_background_color(0,0,0,0,7)
	portrait_off
	$story_stats["Captured"] = 1
	call_msg("TagMapDoomFarmA:Capture/SecondTime_0")
	load_script("Data/Batch/Put_BondageItemsON.rb") #上銬批次檔
	$story_stats["dialog_cuff_equiped"]=0
	SndLib.sound_equip_armor(125)
	map_background_color(0,0,0,255,0)
	get_character(tmpMcID).summon_data[:NeedWork] = true
	handleNap
	
#nap capture
elsif tmpFamilyCount == 3 && tmpMobAlive && $story_stats["Captured"] == 0
	portrait_hide
	chcg_background_color(0,0,0,0,7)
	portrait_off
	$story_stats["Captured"] = 1
	call_msg("TagMapDoomFarmA:Capture/SecondTime_0")
	load_script("Data/Batch/Put_BondageItemsON.rb") #上銬批次檔
	load_script("Data/Batch/Put_BondageItemsON") #上銬批次檔
	$story_stats["dialog_cuff_equiped"]=0
	SndLib.sound_equip_armor(125)
	get_character(tmpMcID).summon_data[:NeedWork] = true
	handleNap

#胖胖的每日強暴
elsif tmpFamilyCount == 3 && tmpMobAlive && $story_stats["Captured"] == 1 && tmpNeedWork && tmpMerryed && rand(100) > 50
	$story_stats["DreamPTSD"] = "Bandit" if $game_player.actor.mood <= -50
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpSonID).animation = nil
		get_character(tmpSonID).npc_story_mode(true)
		tmp_SonX = get_character(tmpSonID).x
		tmp_SonY = get_character(tmpSonID).y
		tmp_SonMtype = get_character(tmpSonID).move_type
		get_character(tmpSonID).moveto($game_player.x,$game_player.y)
		get_character(tmpSonID).move_type = 0
		get_character(tmpSonID).item_jump_to
		get_character(tmpSonID).turn_toward_character($game_player)
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapDoomFarmA:DailyRapeNap/begin#{rand(3)}")
	
	SndLib.sound_equip_armor
	$game_player.animation = $game_player.animation_grabbed_qte
	get_character(tmpSonID).animation = get_character(tmpSonID).animation_hold_shield
	get_character(tmpSonID).call_balloon(1)
	$game_player.actor.stat["EventExt1Race"] = "Human"
	load_script("Data/HCGframes/Grab_EventExt1_Grab.rb")
	call_msg("commonH:Lona/grab#{talk_style}#{rand(3)}")
	get_character(tmpSonID).moveto($game_player.x,$game_player.y)
	portrait_hide
	get_character(tmpSonID).move_type = tmp_SonMtype
	play_sex_service_menu(get_character(tmpSonID),0,nil,true)
	get_character(tmpSonID).npc_story_mode(false)
	$game_player.actor.stat["EventExt1Race"] = "Human"
	load_script("Data/Batch/common_MCtorture_DoomFarmABobo.rb") if rand(100) > 70
	whole_event_end
	portrait_off
	call_msg("TagMapDoomFarmA:DailyRapeEnd/Begin#{rand(3)}")
	get_character(tmpMcID).summon_data[:NeedWork] = true
	handleNap
	
elsif [1,2].include?(tmpFamilyCount)
	portrait_hide
	chcg_background_color(0,0,0,0,7)
	portrait_off
	call_msg("TagMapDoomFarmA:Ded/Nap")
	6.times{
		$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
		SndLib.sound_gore(100)
		SndLib.sound_combat_hit_gore(70)
		wait(20+rand(20))
	}
	map_background_color(0,0,0,255,0)
	load_script("Data/HCGframes/event/Ending_loaderBad.rb")
	
# if they all dead, fill with orkinds, check Orkind Nap
elsif tmpFamilyCount == 0
	tmpMobAlive = $game_map.npcs.any?{
	|event| 
	next unless event.summon_data
	next unless event.summon_data[:WildnessNapEvent]
	next if event.deleted?
	next if event.npc.action_state == :death
	true
	}
	$story_stats["RapeLoop"] = 1 if tmpMobAlive
	if $story_stats["OnRegionMapSpawnRace"] != "Orkind" && $story_stats["RapeLoop"] != 1
		tmpMobAlive = $game_map.npcs.any?{
		|event| 
		next unless event.summon_data
		next unless event.summon_data[:Mercenary]
		next if event.deleted?
		next if event.npc.action_state == :death
		tmpEvent = event
		true
		}
		$game_boxes.box(System_Settings::STORAGE_TEMP_MAP).clear if tmpMobAlive
		handleNap
	elsif $story_stats["RapeLoop"] == 1
		tmp_x,tmp_y=$game_map.get_storypoint("WakeUp")
		$game_player.moveto(tmp_x,tmp_y)
		$story_stats["RapeLoop"] =1
		$story_stats["OnRegionMapSpawnRace"] = "Orkind"
		$story_stats["Kidnapping"] =1
		$game_player.actor.sta =-100
		region_map_wildness_nap
	else
		handleNap
	end
else
	get_character(tmpMcID).summon_data[:NeedWork] = true if tmpFamilyCount == 3 && $story_stats["Captured"] == 1
	handleNap
	
end
