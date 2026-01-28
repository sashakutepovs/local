tmpCHK = false
tmpCHK = true if $story_stats["UniqueCharUniqueGrayRat"] == -1
tmpCHK = true if $story_stats["UniqueCharUniqueCecily"] == -1
tmpCHK = true if $game_player.record_companion_name_back != "UniqueCecily" 
tmpCHK = true if $game_player.record_companion_name_front != "UniqueGrayRat"
if tmpCHK == true
	get_character(0).call_balloon(0)
	return SndLib.sys_buzzer 
end

tmpFwCecilyID=$game_player.get_followerID(0)
tmpFwGrayRarID=$game_player.get_followerID(1)

tmpCecilyID=$game_map.get_storypoint("Cecily")[2]
tmpGrayRarID=$game_map.get_storypoint("GrayRat")[2]
tmpSc1ID=$game_map.get_storypoint("SlaveCart1")[2]
tmpSc2ID=$game_map.get_storypoint("SlaveCart2")[2]
tmpSc3ID=$game_map.get_storypoint("SlaveCart3")[2]
tmpWakeUpX,tmpWakeUpY,tmpWakeUpID=$game_map.get_storypoint("WakeUp")
tmpSlave1_X,tmpSlave1_Y,tmpSlave1_ID=$game_map.get_storypoint("Slave1")
tmpSlave2_X,tmpSlave2_Y,tmpSlave2_ID=$game_map.get_storypoint("Slave2")
tmpSlave3_X,tmpSlave3_Y,tmpSlave3_ID=$game_map.get_storypoint("Slave3")
tmpSlave4_X,tmpSlave4_Y,tmpSlave4_ID=$game_map.get_storypoint("Slave4")
tmpSlave5_X,tmpSlave5_Y,tmpSlave5_ID=$game_map.get_storypoint("Slave5")
tmpSlave6_X,tmpSlave6_Y,tmpSlave6_ID=$game_map.get_storypoint("Slave6")
tmpMilo_X,tmpMilo_Y,tmpMilo_ID=$game_map.get_storypoint("Milo")
tmpTreeMilo_X,tmpTreeMilo_Y,tmpTreeMilo_ID=$game_map.get_storypoint("TreeMilo")
tmpTreePals_X,tmpTreePals_Y,tmpTreePals_ID=$game_map.get_storypoint("TreePals")
tmpTreeTop_X,tmpTreeTop_Y,tmpTreeTop_ID=$game_map.get_storypoint("TreeTop")
tmpAdam_X,tmpAdam_Y,tmpAdam_ID=$game_map.get_storypoint("Adam")
tmpFire_X,tmpFire_Y,tmpFire_ID=$game_map.get_storypoint("Fire")
tmpFire2_X,tmpFire2_Y,tmpFire2_ID=$game_map.get_storypoint("Fire2")
if $story_stats["UniqueCharUniqueMaani"] != -1
tmpMaani_X,tmpMaani_Y,tmpMaani_ID=$game_map.get_storypoint("MaaniRF")
else
tmpMaani_X,tmpMaani_Y,tmpMaani_ID=$game_map.get_storypoint("GuardL1")
end
tmpRifleR1_X,tmpRifleR1_Y,tmpRifleR1_ID=$game_map.get_storypoint("RifleR1")
tmpRifleR2_X,tmpRifleR2_Y,tmpRifleR2_ID=$game_map.get_storypoint("RifleR2")
tmpRifleR3_X,tmpRifleR3_Y,tmpRifleR3_ID=$game_map.get_storypoint("RifleR3")
tmpGuardL2_X,tmpGuardL2_Y,tmpGuardL2_ID=$game_map.get_storypoint("GuardL2")
tmpFollowerTop1_X,tmpFollowerTop1_Y,tmpFollowerTop1_ID=$game_map.get_storypoint("FollowerTop1")


optain_exp(20000*2)
wait(30)

chcg_background_color(0,0,0,0,7)
	portrait_hide
	get_character(tmpFwCecilyID).delete
	get_character(tmpFwGrayRarID).delete
	get_character(tmpCecilyID).follower[1] =0
	get_character(tmpGrayRarID).follower[1] =0
	get_character(tmpCecilyID).moveto(tmpWakeUpX,tmpWakeUpY)
	get_character(tmpGrayRarID).moveto(tmpWakeUpX-1,tmpWakeUpY)
	get_character(tmpCecilyID).direction = 2
	get_character(tmpGrayRarID).direction = 2
	
	$game_map.events.each{|event|
		next if !event[1].summon_data
		next if event[1].summon_data[:cart] != true
		event[1].trigger = -1
		event[1].call_balloon(0)
	}
	SndLib.sound_step_chain(100)
	wait(30)
	SndLib.sound_step_chain(100)
	wait(30)
	SndLib.sound_step_chain(100)
###############################################################################################################
###############################################################################################################
############################################################################################################### 背叛狀態
###############################################################################################################
if $story_stats["UniqueCharUniqueMilo"] != -1 && $story_stats["RecQuestMilo"] == 11
		$story_stats["DreamPTSD"] = "CecilyBetray"
		$story_stats["UniqueCharUniqueGrayRat"] = -1
		$story_stats["UniqueCharUniqueCecily"] = -1
		remove_companion(1)
		remove_companion(0)
		$story_stats["RecQuestMilo"] = 12
		wait(60)
		call_msg("TagMapCecilyHijack:Part2/EndMilo_0")
		portrait_hide
		wait(5+rand(10))
		SndLib.sound_GunSingle(30+rand(40),80+rand(10))
		wait(5+rand(10))
		flash_screen(Color.new(255,255,255,200),8,false)
		SndLib.sound_GunSingle(80+rand(40),100+rand(50))
		wait(5+rand(10))
		SndLib.sound_GunSingle(30+rand(40),80+rand(10))
		wait(5+rand(10))
		flash_screen(Color.new(255,255,255,200),8,false)
		SndLib.sound_GunSingle(80+rand(40),100+rand(50))
		wait(5+rand(10))
		SndLib.sound_GunSingle(30+rand(40),80+rand(10))
		wait(5+rand(10))
		flash_screen(Color.new(255,255,255,200),8,false)
		SndLib.sound_GunSingle(80+rand(40),100+rand(50))
		wait(5+rand(10))
		SndLib.sound_GunSingle(30+rand(40),80+rand(10))
		wait(5+rand(10))
		flash_screen(Color.new(255,255,255,200),8,false)
		SndLib.sound_GunSingle(80+rand(40),100+rand(50))
		SndLib.MaleWarriorGruntDed
		wait(5+rand(10))
		SndLib.sound_GunSingle(30+rand(40),80+rand(10))
		wait(5+rand(10))
		SndLib.sound_GunSingle(30+rand(40),80+rand(10))
		wait(5+rand(10))
		SndLib.sound_GunSingle(30+rand(40),80+rand(10))
		wait(5+rand(5))
		SndLib.sound_GunSingle(30+rand(40),70+rand(10))
		wait(5+rand(5))
		SndLib.sound_GunSingle(30+rand(40),70+rand(10))
		wait(5+rand(5))
		SndLib.sound_GunSingle(30+rand(40),70+rand(10))
		wait(5+rand(5))
		SndLib.sound_GunSingle(30+rand(40),70+rand(10))
		wait(5+rand(5))
		SndLib.sound_GunSingle(30+rand(40),60+rand(10))
		call_msg("TagMapCecilyHijack:Part2/EndMilo_1")
		portrait_hide
		$game_player.moveto(tmpWakeUpX-1,tmpWakeUpY+4)
		get_character(tmpGrayRarID).npc_story_mode(true)
		get_character(tmpCecilyID).npc_story_mode(true)
		get_character(tmpCecilyID).direction = 4
		get_character(tmpCecilyID).moveto(tmpWakeUpX+1,tmpWakeUpY)
		get_character(tmpGrayRarID).animation = get_character(tmpGrayRarID).animation_corpsen
	chcg_background_color(0,0,0,255,-7)
	cam_follow(tmpCecilyID,0)
	get_character(tmpCecilyID).move_forward
	call_msg("TagMapCecilyHijack:Part2/EndMilo_2")
	$game_player.direction = 8
	call_msg("TagMapCecilyHijack:Part2/EndMilo_3")
	portrait_hide
	get_character(tmpMilo_ID).npc_story_mode(true)
	get_character(tmpMaani_ID).npc_story_mode(true)
	get_character(tmpGuardL2_ID).npc_story_mode(true)
	get_character(tmpRifleR1_ID).npc_story_mode(true)
	get_character(tmpRifleR2_ID).npc_story_mode(true)
	get_character(tmpRifleR3_ID).npc_story_mode(true)
	get_character(tmpFollowerTop1_ID).npc_story_mode(true)
	get_character(tmpMilo_ID).moveto(tmpTreeMilo_X-3,tmpTreeMilo_Y)
	get_character(tmpMaani_ID).moveto(tmpTreeMilo_X-3,tmpTreeMilo_Y+1)
	get_character(tmpGuardL2_ID).moveto(tmpTreeMilo_X-3,tmpTreeMilo_Y)
	
	get_character(tmpRifleR1_ID).moveto(tmpTreePals_X+1,tmpTreePals_Y+1)
	get_character(tmpRifleR2_ID).moveto(tmpTreePals_X+1,tmpTreePals_Y+3)
	get_character(tmpRifleR3_ID).moveto(tmpTreePals_X+1,tmpTreePals_Y+5)
	get_character(tmpFollowerTop1_ID).moveto(tmpTreeTop_X-2,tmpTreeTop_Y)
	get_character(tmpRifleR1_ID).jump_to(tmpTreePals_X-1,tmpTreePals_Y+1)
	get_character(tmpRifleR2_ID).jump_to(tmpTreePals_X-1,tmpTreePals_Y+3)
	get_character(tmpRifleR3_ID).jump_to(tmpTreePals_X-1,tmpTreePals_Y+5)
	get_character(tmpMilo_ID).jump_to(tmpTreeMilo_X,tmpTreeMilo_Y)
	get_character(tmpMaani_ID).jump_to(tmpTreeMilo_X+1,tmpTreeMilo_Y+1)
	get_character(tmpGuardL2_ID).jump_to(tmpTreeMilo_X+1,tmpTreeMilo_Y)
	get_character(tmpMilo_ID).move_speed = 2
	get_character(tmpMaani_ID).move_speed = 2
	get_character(tmpGuardL2_ID).move_speed = 2
	get_character(tmpRifleR1_ID).move_speed = 2
	get_character(tmpRifleR2_ID).move_speed = 2
	get_character(tmpRifleR3_ID).move_speed = 2
	SndLib.stepBush(100)
	wait(10)
	get_character(tmpMilo_ID).move_forward
	get_character(tmpMaani_ID).move_forward
	get_character(tmpGuardL2_ID).move_forward
	get_character(tmpRifleR1_ID).move_forward
	get_character(tmpRifleR2_ID).move_forward
	get_character(tmpRifleR3_ID).move_forward
	wait(65)
	call_msg("TagMapCecilyHijack:Part2/EndMilo_4")
	portrait_hide
	get_character(tmpMilo_ID).move_forward
	get_character(tmpMaani_ID).move_forward
	get_character(tmpGuardL2_ID).move_forward
	get_character(tmpRifleR1_ID).move_forward
	get_character(tmpRifleR2_ID).move_forward
	get_character(tmpRifleR3_ID).move_forward
	wait(65)
	call_msg("TagMapCecilyHijack:Part2/EndMilo_4")
	portrait_hide
	get_character(tmpMilo_ID).move_forward
	get_character(tmpMaani_ID).move_forward
	get_character(tmpGuardL2_ID).move_forward
	get_character(tmpRifleR1_ID).move_forward
	get_character(tmpRifleR2_ID).move_forward
	get_character(tmpRifleR3_ID).move_forward
	wait(40)
	get_character(tmpRifleR1_ID).animation = get_character(tmpRifleR1_ID).animation_hold_shield
	SndLib.sound_Reload
	wait(1+rand(5))
	get_character(tmpRifleR2_ID).animation = get_character(tmpRifleR2_ID).animation_hold_shield
	SndLib.sound_Reload
	wait(1+rand(5))
	get_character(tmpRifleR3_ID).animation = get_character(tmpRifleR3_ID).animation_hold_shield
	SndLib.sound_Reload
	wait(1+rand(5))
	get_character(tmpMaani_ID).animation = get_character(tmpMaani_ID).animation_hold_shield
	SndLib.sound_Reload
	wait(60)
	call_msg("TagMapCecilyHijack:Part2/EndMilo_5")
	get_character(tmpMilo_ID).move_forward
	call_msg("TagMapCecilyHijack:Part2/EndMilo_5_1")
	portrait_hide
	call_msg("TagMapCecilyHijack:Part2/EndMilo_6")
	get_character(tmpFollowerTop1_ID).move_forward
	wait(15)
	get_character(tmpFollowerTop1_ID).move_forward
	wait(15)
	get_character(tmpFollowerTop1_ID).move_forward
	wait(15)
	call_msg("TagMapCecilyHijack:Part2/EndMilo_7")
	get_character(tmpFollowerTop1_ID).move_forward
	wait(15)
	get_character(tmpFollowerTop1_ID).move_forward
	wait(15)
	get_character(tmpFollowerTop1_ID).move_forward
	wait(15)
	get_character(tmpFollowerTop1_ID).direction = 6
	get_character(tmpFollowerTop1_ID).call_balloon(1)
	wait(60)
	get_character(tmpFollowerTop1_ID).direction = 4
	get_character(tmpFollowerTop1_ID).call_balloon(8)
	#call_msg("TagMapCecilyHijack:Part2/EndMilo_8")
	wait(20)
	get_character(tmpMaani_ID).animation =  get_character(tmpMaani_ID).animation_casting_musket
	flash_screen(Color.new(255,255,255,200),8,false)
	get_character(tmpFire_ID).moveto(get_character(tmpMaani_ID).x+2,get_character(tmpMaani_ID).y)
	get_character(tmpFire_ID).npc_story_mode(true)
	get_character(tmpFire_ID).move_type = 3
	wait(5)
	get_character(tmpFollowerTop1_ID).animation =  get_character(tmpFollowerTop1_ID).animation_overkill_melee_reciver
	get_character(tmpFollowerTop1_ID).setup_cropse_graphics(2)
	SndLib.sound_MaleWarriorDed
	wait(90)
	SndLib.sound_Reload
	get_character(tmpMaani_ID).animation = get_character(tmpMaani_ID).animation_hold_shield
	if $story_stats["UniqueCharUniqueMaani"] != -1
		call_msg("TagMapCecilyHijack:Part2/EndMilo_8_manni")
	end
	SndLib.sound_equip_armor
	$game_player.jump_to(tmpWakeUpX-1,tmpWakeUpY+1)
	wait(10)
	call_msg("TagMapCecilyHijack:Part2/EndMilo_9")
	$game_player.direction = 6
	$game_player.call_balloon(2)
	wait(45)
	$game_player.direction = 4
	$game_player.call_balloon(1)
	wait(45)
	call_msg("TagMapCecilyHijack:Part2/EndMilo_10")
	call_msg("TagMapCecilyHijack:Part2/EndMilo_10_opt") #[過去,你這個騙子]
	if $game_temp.choice ==1
		call_msg("TagMapCecilyHijack:Part2/EndMilo_1_optNo1")
		portrait_hide
		wait(40)
		get_character(tmpMaani_ID).animation =  get_character(tmpMaani_ID).animation_casting_musket
		flash_screen(Color.new(255,255,255,200),8,false)
		get_character(tmpFire2_ID).moveto(get_character(tmpMaani_ID).x+2,get_character(tmpMaani_ID).y)
		get_character(tmpFire2_ID).npc_story_mode(true)
		get_character(tmpFire2_ID).move_type = 3
		wait(5)
		$game_player.animation =  $game_player.animation_stun
		$game_player.jump_to($game_player.x,$game_player.y)
		$game_player.actor.health = 0
		wait(90)
		call_msg("TagMapCecilyHijack:Part2/EndMilo_1_optNo2")
		return load_script("Data/HCGframes/event/Ending_loaderBad.rb")
	end
	$game_player.direction = 6
	call_msg("TagMapCecilyHijack:Part2/EndMilo_11")
	get_character(tmpCecilyID).move_forward
	wait(10)
	SndLib.sound_equip_armor
	$game_player.direction = 4
	$game_player.jump_to($game_player.x-1,$game_player.y)
	$game_player.direction = 6
	get_character(tmpCecilyID).animation =  get_character(tmpCecilyID).animation_atk_mh
	call_msg("TagMapCecilyHijack:Part2/EndMilo_12")
	portrait_hide
	wait(20)
	get_character(tmpMaani_ID).animation =  get_character(tmpMaani_ID).animation_casting_musket
	flash_screen(Color.new(255,255,255,200),8,false)
	get_character(tmpFire2_ID).moveto(get_character(tmpMaani_ID).x+2,get_character(tmpMaani_ID).y)
	get_character(tmpFire2_ID).npc_story_mode(true)
	get_character(tmpFire2_ID).move_type = 3
	wait(5)
	SndLib.sound_combat_sword_hit_sword(100)
	SndLib.sound_combat_sword_hit_sword(100)
	SndLib.sound_combat_sword_hit_sword(100)
	get_character(tmpCecilyID).animation =  get_character(tmpCecilyID).animation_stun
	get_character(tmpCecilyID).jump_to(get_character(tmpCecilyID).x,get_character(tmpCecilyID).y)
	wait(60)
	call_msg("TagMapCecilyHijack:Part2/EndMilo_13")
	$game_player.direction = 4
	$game_player.actor.mood = -100
	call_msg("TagMapCecilyHijack:Part2/EndMilo_14")
	optain_item($data_items[52],5)
	call_msg("TagMapCecilyHijack:Part2/EndMilo_15")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		$game_player.direction = 6
		$game_player.moveto(get_character(tmpMaani_ID).x+1,get_character(tmpMaani_ID).y)
		get_character(tmpMaani_ID).animation =  get_character(tmpMaani_ID).animation_hold_shield
		get_character(tmpRifleR1_ID).animation = nil
		get_character(tmpRifleR2_ID).animation = nil
		get_character(tmpRifleR3_ID).animation = nil
		get_character(tmpRifleR1_ID).moveto(get_character(tmpCecilyID).x-1,get_character(tmpCecilyID).y)
		get_character(tmpRifleR2_ID).moveto(get_character(tmpCecilyID).x+1,get_character(tmpCecilyID).y)
		get_character(tmpRifleR3_ID).moveto(get_character(tmpCecilyID).x,get_character(tmpCecilyID).y+1)
		get_character(tmpRifleR1_ID).direction = 6
		get_character(tmpRifleR2_ID).direction = 4
		get_character(tmpRifleR3_ID).direction = 8
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapCecilyHijack:Part2/EndMilo_16")
	call_StoryHevent("RecHevCecilyHijack1","HevCecilyHijack1")
	get_character(tmpRifleR1_ID).direction = 4
	portrait_off
	call_msg("TagMapCecilyHijack:Part2/EndMilo_17")
	$game_player.direction = 4
	call_msg("TagMapCecilyHijack:Part2/EndMilo_18")
	cam_center(0)
	portrait_hide
	change_map_leave_tag_map
	GabeSDK.getAchievement("RecQuestMilo_12")
	
###############################################################################################################
###############################################################################################################
############################################################################################################### 解放狀態
###############################################################################################################
else
		$story_stats["QuProgSaveCecily"] = 12
		$story_stats["RecQuestSaveCecilyAmt"] = $game_date.dateAmt + 4
		set_event_force_page(tmpSc1ID,1)
		set_event_force_page(tmpSc2ID,1)
		set_event_force_page(tmpSc3ID,1)
		get_character(tmpSlave1_ID).moveto(tmpWakeUpX-2,tmpWakeUpY+2)
		get_character(tmpSlave2_ID).moveto(tmpWakeUpX-1,tmpWakeUpY+2)
		get_character(tmpSlave3_ID).moveto(tmpWakeUpX,tmpWakeUpY+2)
		get_character(tmpSlave4_ID).moveto(tmpWakeUpX+1,tmpWakeUpY+2)
		get_character(tmpSlave5_ID).moveto(tmpWakeUpX-1,tmpWakeUpY+3)
		get_character(tmpSlave6_ID).moveto(tmpWakeUpX+1,tmpWakeUpY+3)
		$game_player.direction = 2
		$game_player.moveto(tmpWakeUpX+1,tmpWakeUpY)
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapCecilyHijack:Part2/EndCecily_1")
	cam_center(0)
	get_character(tmpSlave1_ID).move_type = 3
	get_character(tmpSlave2_ID).move_type = 3
	get_character(tmpSlave3_ID).move_type = 3
	get_character(tmpSlave4_ID).move_type = 3
	get_character(tmpSlave5_ID).move_type = 3
	get_character(tmpSlave6_ID).move_type = 3
	get_character(tmpSlave1_ID).npc_story_mode(true)
	get_character(tmpSlave2_ID).npc_story_mode(true)
	get_character(tmpSlave3_ID).npc_story_mode(true)
	get_character(tmpSlave4_ID).npc_story_mode(true)
	get_character(tmpSlave5_ID).npc_story_mode(true)
	get_character(tmpSlave6_ID).npc_story_mode(true)
	wait(45)
	call_msg("TagMapCecilyHijack:Part2/EndCecily_2")
	$game_player.direction = 4
	call_msg("TagMapCecilyHijack:Part2/EndCecily_3")
	get_character(tmpGrayRarID).direction = 6
	call_msg("TagMapCecilyHijack:Part2/EndCecily_4")
	optain_item($data_items[52],3)
	call_msg("TagMapCecilyHijack:Part2/EndCecily_5")
	remove_companion(1)
	remove_companion(0)
	call_msg("common:Lona/Follower_disbanded")
	cam_center(0)
	portrait_hide
	change_map_leave_tag_map
	GabeSDK.getAchievement("QuProgSaveCecily_12")
end
