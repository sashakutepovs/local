
tmpData = [120, 90, 70, $game_date.day? ? 120 : 190,  #shadow
           nil, #Fog
           "cave_dust", 1, "WhiteDot",  #weather
           128, 128, 40, 60, 1,  #MAP BG
           "D/ChurchSolemn1F",90,120, RPG::BGM.last.pos, #BGM name volume pitch pos
           nil, nil, nil, nil] #BGS
set_BG_EFX_data(tmpData)
$story_stats["BG_EFX_data"] = get_BG_EFX_data_Indoor
$game_player.direction = 8 if $story_stats["ReRollHalfEvents"] ==1
tmpDualBiosX,tmpDualBiosY,tmpDualBiosID=$game_map.get_storypoint("DualBios")



if $story_stats["RapeLoop"] >= 1 #so the region can works
	tmpWakeUpX,tmpWakeUpY,tmpWakeUpID=$game_map.get_storypoint("WakeUp")
	tmp2fGuard1X,tmp2fGuard1Y,tmp2fGuard1ID=$game_map.get_storypoint("2fGuard1")
	tmp2fGuard2X,tmp2fGuard2Y,tmp2fGuard2ID=$game_map.get_storypoint("2fGuard2")
	tmp2fNunMainX,tmp2fNunMainY,tmp2fNunMainID=$game_map.get_storypoint("2fNunMain")
	tmp2FRU_X,tmp2FRU_Y=$game_map.get_storypoint("2FRU")
	tmp2FRD_X,tmp2FRD_Y=$game_map.get_storypoint("2FRD")
	$game_player.moveto(tmpWakeUpX,tmpWakeUpY)
	get_character(tmp2fGuard1ID).moveto(tmp2FRU_X,tmp2FRU_Y)
	get_character(tmp2fGuard1ID).direction = 2
	get_character(tmp2fGuard1ID).move_type = 0
	get_character(tmp2fGuard2ID).moveto(tmp2FRD_X,tmp2FRD_Y)
	get_character(tmp2fGuard1ID).direction = 8
	get_character(tmp2fGuard2ID).move_type = 0
end
#26~29  2f UG light
if (26..29).include?($game_player.region_id)
	#$game_map.set_fog(nil)
	#weather_stop
	#map_background_color_off
	tmpData = ["UnderGround",nil,nil,nil,
	           nil,
	           nil,nil,nil,
	           nil,nil,nil,nil,nil,
				RPG::BGM.last.name,80,80,RPG::BGM.last.pos]
	set_BG_EFX_data(tmpData)
	#$game_map.set_underground_light
end
#begin of captured. rapeloop, normal mode
#todo  sold as slave.
#todo  recuff is lona isnt cuffed

if false #$story_stats["RapeLoop"] == 1  && $story_stats["Captured"] == 1 && get_character(tmpDualBiosID).summon_data[:Captured]
	#after first begin, daily event
elsif false #$story_stats["RapeLoop"] == 1  && $story_stats["Captured"] != 1 && get_character(tmpDualBiosID).summon_data[:Captured]
	$story_stats["Captured"] = 1
	call_msg("TagMapSaintMonastery:RapeLoop/CapturedBegin1")
	portrait_hide
	$game_player.direction = 2
	tmp2fGuard1DIR = get_character(tmp2fGuard1ID).direction
	tmp2fGuard2DIR = get_character(tmp2fGuard2ID).direction
	tmp2fNunMainDIR = get_character(tmp2fNunMainID).direction
	tmp2fGuard1MT = get_character(tmp2fGuard1ID).move_type
	tmp2fGuard2MT = get_character(tmp2fGuard2ID).move_type
	tmp2fNunMainMT = get_character(tmp2fNunMainID).move_type
	get_character(tmp2fGuard1ID).moveto(tmpWakeUpX+1,tmpWakeUpY)
	get_character(tmp2fGuard2ID).moveto(tmpWakeUpX-1,tmpWakeUpY)
	get_character(tmp2fNunMainID).moveto(tmpWakeUpX-1,tmpWakeUpY+3)
	get_character(tmp2fGuard1ID).turn_toward_character($game_player)
	get_character(tmp2fGuard2ID).turn_toward_character($game_player)
	get_character(tmp2fNunMainID).turn_toward_character($game_player)
	get_character(tmp2fGuard1ID).npc_story_mode(true)
	get_character(tmp2fGuard2ID).npc_story_mode(true)
	get_character(tmp2fNunMainID).npc_story_mode(true)
	get_character(tmp2fGuard1ID).animation = nil
	get_character(tmp2fGuard2ID).animation = nil
	get_character(tmp2fNunMainID).animation = nil
	get_character(tmp2fGuard1ID).move_type = 0
	get_character(tmp2fGuard2ID).move_type = 0
	get_character(tmp2fNunMainID).move_type = 0
	get_character(tmp2fNunMainID).direction = 8
	get_character(tmp2fGuard1ID).animation = get_character(tmp2fGuard1ID).animation_grabber_qte($game_player)
	get_character(tmp2fGuard2ID).animation = get_character(tmp2fGuard2ID).animation_grabber_qte($game_player)
	$game_player.animation = $game_player.animation_grabbed_qte
	enter_static_tag_map #to WakeUp PT

	$game_player.actor.stat["EventExt1"] = "Grab"
	portrait_hide
	chcg_background_color(0,0,0,255,-7)
	portrait_off
	call_msg("TagMapSaintMonastery:RapeLoop/CapturedBegi1_2")
	portrait_hide
	until get_character(tmp2fNunMainID).report_range($game_player) <= 1
		get_character(tmp2fNunMainID).move_toward_xy($game_player.x,$game_player.y)
		until !get_character(tmp2fNunMainID).moving?
			wait(1)
		end
	end
	get_character(tmp2fNunMainID).turn_toward_character($game_player)
	call_msg("TagMapSaintMonastery:RapeLoop/CapturedBegin2")

	if $game_player.actor.stat["SlaveBrand"] !=1
		$story_stats["SlaveOwner"] = "SaintMonastery"
		$game_player.actor.stat["EventExt1"] = "Grab"
		call_msg("TagMapSaintMonastery:RapeLoop/Slave_brand")
		$game_player.actor.mood = -100
		$game_player.actor.add_state("SlaveBrand") #51
		whole_event_end
	end

	if !$game_player.player_full_nun_dressed?
		get_character(tmp2fNunMainID).animation = get_character(tmp2fNunMainID).animation_atk_sh
		call_msg("TagMapSaintMonastery:RapeLoop/CapturedBegin2_changeToNunDress")
		if !$game_party.has_item?("ItemNunSexyMid",true) && $game_player.actor.stat["Prostitute"] >= 1
			$game_party.gain_item("ItemNunSexyMid", 1)
			SndLib.sound_equip_armor(125)
			$game_player.actor.change_equip("Mid", $data_ItemName["ItemNunSexyMid"])
			wait(30)
			player_force_update
		end
		get_character(tmp2fNunMainID).animation = get_character(tmp2fNunMainID).animation_atk_mh
		if !$game_party.has_item?("ItemNunMidExtra",true)
			$game_party.gain_item("ItemNunMidExtra", 1)
			SndLib.sound_equip_armor(125)
			$game_player.actor.change_equip("MidExt", $data_ItemName["ItemNunMidExtra"])
			wait(30)
			player_force_update
		end
		get_character(tmp2fNunMainID).animation = get_character(tmp2fNunMainID).animation_atk_sh
		if !$game_party.has_item?("ItemNunVeilHeadEquip",true)
			$game_party.gain_item("ItemNunVeilHeadEquip", 1)
			SndLib.sound_equip_armor(125)
			$game_player.actor.change_equip("Head", $data_ItemName["ItemNunVeilHeadEquip"])
			wait(30)
			player_force_update
		end
	end
	call_msg("TagMapSaintMonastery:RapeLoop/CapturedBegin3")
	get_character(tmp2fNunMainID).turn_toward_character($game_player)
	call_msg("TagMapSaintMonastery:RapeLoop/CapturedEnd")

	portrait_hide
	chcg_background_color(0,0,0,7)
		portrait_off
		get_character(tmp2fGuard1ID).direction = tmp2fGuard1DIR
		get_character(tmp2fGuard2ID).direction = tmp2fGuard2DIR
		get_character(tmp2fNunMainID).direction = tmp2fNunMainDIR
		get_character(tmp2fGuard1ID).moveto(tmp2fGuard1X,tmp2fGuard1Y)
		get_character(tmp2fGuard2ID).moveto(tmp2fGuard2X,tmp2fGuard2Y)
		get_character(tmp2fNunMainID).moveto(tmp2fNunMainX,tmp2fNunMainY)
		get_character(tmp2fGuard1ID).move_type = tmp2fGuard1MT
		get_character(tmp2fGuard2ID).move_type = tmp2fGuard2MT
		get_character(tmp2fNunMainID).move_type = tmp2fNunMainMT
		get_character(tmp2fGuard1ID).animation = nil
		get_character(tmp2fGuard2ID).animation = nil
		get_character(tmp2fNunMainID).animation = nil
		get_character(tmp2fGuard1ID).npc_story_mode(false)
		get_character(tmp2fGuard2ID).npc_story_mode(false)
		get_character(tmp2fNunMainID).npc_story_mode(false)

		get_character(tmp2fGuard1ID).moveto(tmp2FRU_X,tmp2FRU_Y)
		get_character(tmp2fGuard1ID).direction = 2
		get_character(tmp2fGuard1ID).move_type = 0
		get_character(tmp2fGuard2ID).moveto(tmp2FRD_X,tmp2FRD_Y)
		get_character(tmp2fGuard1ID).direction = 8
		get_character(tmp2fGuard2ID).move_type = 0
		$game_player.animation = nil
		$game_player.direction = 2
	chcg_background_color(0,0,0,255,-7)
	get_character(0).erase
	whole_event_end
	eventPlayEnd
end


if $story_stats["RapeLoop"] >= 1
	get_character(tmp2fNunMainID).call_balloon(28,-1)
end
return if $story_stats["RapeLoop"] >= 1
##################################### COCONA QUEST
if $story_stats["RecQuestCocona"] == 14
	$game_NPCLayerMain.stat["Cocona_Dress"] = cocona_maid? ? "Maid" : "Necro"
	$game_NPCLayerSub.stat["Cocona_Dress"] = cocona_maid? ? "Maid" : "Necro"
	$game_player.opacity = 0
	chcg_background_color(0,0,0,255,-7)
	tmpC14x,tmpC14y,tmpC14id=$game_map.get_storypoint("C14Cocona")
	tmpMPx,tmpMPy,tmpMPid=$game_map.get_storypoint("MainPriest")
	tmpSTx,tmpSTy,tmpSTid=$game_map.get_storypoint("StartPoint")
	get_character(tmpC14id).opacity = 255
	get_character(tmpC14id).npc_story_mode(true)
	get_character(tmpMPid).npc_story_mode(true)
	get_character(tmpC14id).moveto(tmpSTx,tmpSTy)
	cam_follow(tmpC14id,0)
	wait(35)
	get_character(tmpC14id).call_balloon(8)

	4.times{
		get_character(tmpC14id).move_forward_force
	until !get_character(tmpC14id).moving?
	wait(1)
	end
	}
	wait(35)
	get_character(tmpC14id).call_balloon(8)
	wait(60)
	get_character(tmpC14id).direction = 4
	get_character(tmpC14id).call_balloon(6)
	wait(60)
	get_character(tmpC14id).direction = 6
	get_character(tmpC14id).call_balloon(6)
	wait(60)
	get_character(tmpC14id).direction = 8
	get_character(tmpC14id).call_balloon(6)
	call_msg("CompCocona:cocona/RecQuestCocona_14_1")
	portrait_hide
	3.times{
		get_character(tmpC14id).move_forward_force
	until !get_character(tmpC14id).moving?
	wait(1)
	end
	}
	wait(60)
	get_character(tmpC14id).direction = 4
	get_character(tmpC14id).call_balloon(6)
	wait(60)
	get_character(tmpC14id).direction = 6
	get_character(tmpC14id).call_balloon(6)
	wait(60)
	get_character(tmpC14id).direction = 2
	get_character(tmpC14id).call_balloon(6)
	call_msg("CompCocona:cocona/RecQuestCocona_14_2")
	portrait_hide
	get_character(tmpMPid).call_balloon(2)
	wait(60)
	get_character(tmpMPid).direction = 4 ; get_character(tmpMPid).move_forward_force
	get_character(tmpC14id).direction = 2
	wait(35)
	get_character(tmpMPid).direction = 4 ; get_character(tmpMPid).move_forward_force
	wait(35)
	get_character(tmpMPid).direction = 2 ; get_character(tmpMPid).move_forward_force
	get_character(tmpC14id).direction = 4
	wait(35)
	get_character(tmpMPid).direction = 2 ; get_character(tmpMPid).move_forward_force
	wait(35)
	get_character(tmpMPid).direction = 6 ; get_character(tmpMPid).move_forward_force
	get_character(tmpC14id).direction = 6
	wait(35)
	get_character(tmpMPid).direction = 6 ; get_character(tmpMPid).move_forward_force
	wait(35)
	get_character(tmpMPid).direction = 2 ; get_character(tmpMPid).move_forward_force
	get_character(tmpC14id).direction = 2
	wait(35)
	get_character(tmpC14id).direction = 8
	call_msg("CompCocona:cocona/RecQuestCocona_14_3")
	cam_follow(tmpMPid,0)
	portrait_hide
	3.times{
		get_character(tmpMPid).direction = 4 ; get_character(tmpMPid).move_forward_force
	get_character(tmpC14id).move_toward_xy(get_character(tmpMPid).x,get_character(tmpMPid).y)
	wait(35)
	}
	3.times{
		get_character(tmpMPid).direction = 8 ; get_character(tmpMPid).move_forward_force
	get_character(tmpC14id).move_toward_xy(get_character(tmpMPid).x,get_character(tmpMPid).y)
	wait(35)
	}
	portrait_hide
	chcg_background_color(0,0,0,0,7)
	cam_follow(tmpSTid,0)
	$game_player.opacity = 255
	get_character(tmpC14id).delete
	get_character(tmpMPid).delete
	$story_stats["RecQuestCocona"] = 15

elsif $story_stats["RecQuestCocona"] == 17 && $story_stats["UniqueCharUniqueCocona"] != -1 && $game_player.record_companion_name_back == "UniqueCoconaMaid"
	SndLib.bgm_stop
	call_msg("CompCocona:cocona/RecQuestCocona_17_gb2_1f_noVag") if $story_stats["RecQuestCoconaVagTaken"] >= 1
	call_msg("TagMapSaintMonastery:Enter/AggroMode")
	call_msg("CompCocona:cocona/RecQuestCocona_17_gb2_1f")
	SndLib.bgm_play("CB_-_Zombies_Everywhere",70,95)
	$game_player.actor.morality_lona = 0
	$story_stats["RecQuestCocona"] == 18
elsif $story_stats["RecQuestSMRefugeeCampFindChild"] == 8 && $game_player.record_companion_name_ext == "MonasteryFindChild_Qobj"
	#do all watcher to enemy

	call_msg("TagMapSaintMonastery:Enter/AggroMode")
	SndLib.bgm_play("CB_-_Zombies_Everywhere",70,95)
	$game_map.npcs.each do |event|
		next unless event.summon_data
		next unless event.summon_data[:watcher]
		event.npc.add_fated_enemy([0])
	end
end
$game_map.interpreter.map_background_color(128,128,40,60)
fadeout=$story_stats["ReRollHalfEvents"] == 1
enter_static_tag_map(nil,fadeout) if $story_stats["ReRollHalfEvents"] == 1
summon_companion
#$story_stats["LimitedNeedsSkill"] =1
eventPlayEnd
get_character(0).erase
