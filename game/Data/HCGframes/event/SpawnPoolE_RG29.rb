
if $story_stats["RecQuestSouthFLMain"] == 4
	eventPlayStart
	$game_map.events.each{|event|
		next if !event[1].summon_data
		next unless event[1].summon_data[:RG29Blocker]
		event[1].delete
	}
	tmpAbomZombieX,tmpAbomZombieY,tmpAbomZombieID = $game_map.get_storypoint("AbomZombie")
	tmpVictimX,tmpVictimY,tmpVictimID = $game_map.get_storypoint("victim")
	tmpCamX,tmpCamY,tmpCamID = $game_map.get_storypoint("Cam")
	tmpManager1X,tmpManager1Y,tmpManager1ID = $game_map.get_storypoint("Manager1")
	tmpManager2X,tmpManager2Y,tmpManager2ID = $game_map.get_storypoint("Manager2")
	tmpHiveX,tmpHiveY,tmpHiveID = $game_map.get_storypoint("Hive")
	tmpBlk1X,tmpBlk1Y,tmpBlk1ID = $game_map.get_storypoint("block1")
	tmpBlk2X,tmpBlk2Y,tmpBlk2ID = $game_map.get_storypoint("block2")
	tmpQuestCountX,tmpQuestCountY,tmpQuestCountID = $game_map.get_storypoint("QuestCount")
	tmpWallTarX,tmpWallTarY,tmpWallTarID = $game_map.get_storypoint("WallTar")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpManager1ID).npc_story_mode(true)
		get_character(tmpManager2ID).npc_story_mode(true)
		set_event_force_page(tmpVictimID,1)
		get_character(tmpVictimID).npc_story_mode(true)
		get_character(tmpVictimID).character_index = 3
		$game_player.moveto(tmpAbomZombieX,tmpAbomZombieY+1)
		$game_player.direction = 4
	chcg_background_color(0,0,0,255,-7)
	get_character(tmpAbomZombieID).call_balloon(0)
	wait(35)
	$game_player.direction = 8
	$game_player.call_balloon(1)
	wait(50)
	$game_player.call_balloon(8)
	wait(50)
	call_msg("TagMapSpawnPoolE:Qprog3/begin3") ; portrait_hide
	$game_player.move_forward_force
	wait(20)
	get_character(tmpCamID).moveto($game_player.x,$game_player.y)
	call_msg("TagMapSpawnPoolE:Qprog3/begin4") ; portrait_hide
	SndLib.sound_MaleWarriorDed(80)
	$game_player.call_balloon(1)
	wait(35)
	$game_player.direction = 4
	call_msg("TagMapSpawnPoolE:Qprog3/begin5") ; portrait_hide
	cam_follow(tmpCamID,0)
	get_character(tmpCamID).npc_story_mode(true)
	get_character(tmpVictimID).npc_story_mode(true)
	get_character(tmpVictimID).move_type = 3
	get_character(tmpVictimID).move_speed = 1
	$hudForceHide = true
	$balloonForceHide = true
	1.times{get_character(tmpCamID).direction = 8 ; get_character(tmpCamID).move_forward_force ;  wait(32)}
	SndLib.bgm_play("/D/Between two worlds",80)
	get_character(tmpVictimID).move_type = 3
	7.times{get_character(tmpCamID).direction = 4 ; get_character(tmpCamID).move_forward_force ;  wait(32)}
	get_character(tmpManager1ID).direction = 4 ; get_character(tmpManager1ID).move_forward_force ; get_character(tmpManager1ID).call_balloon(1)
	get_character(tmpManager2ID).direction = 4 ; get_character(tmpManager2ID).move_forward_force ; get_character(tmpManager2ID).call_balloon(1)
	SndLib.sound_ManagerSpot(80)
	2.times{get_character(tmpCamID).direction = 4 ; get_character(tmpCamID).move_forward_force ;  wait(32)}
	get_character(tmpManager1ID).direction = 4 ; get_character(tmpManager1ID).move_forward_force
	get_character(tmpManager2ID).direction = 4 ; get_character(tmpManager2ID).move_forward_force
	2.times{get_character(tmpCamID).direction = 4 ; get_character(tmpCamID).move_forward_force ;  wait(32)}
	get_character(tmpManager1ID).direction = 4 ; get_character(tmpManager1ID).move_forward_force
	get_character(tmpManager2ID).direction = 4 ; get_character(tmpManager2ID).move_forward_force
	2.times{get_character(tmpCamID).direction = 4 ; get_character(tmpCamID).move_forward_force ;  wait(32)}
	get_character(tmpManager1ID).direction = 4 ; get_character(tmpManager1ID).move_forward_force
	get_character(tmpManager2ID).direction = 4 ; get_character(tmpManager2ID).move_forward_force
	2.times{get_character(tmpCamID).direction = 4 ; get_character(tmpCamID).move_forward_force ;  wait(32)}
	get_character(tmpManager1ID).direction = 4 ; get_character(tmpManager1ID).move_forward_force
	get_character(tmpManager2ID).direction = 4 ; get_character(tmpManager2ID).move_forward_force
	2.times{get_character(tmpCamID).direction = 4 ; get_character(tmpCamID).move_forward_force ;  wait(32)}
	get_character(tmpManager1ID).direction = 4 ; get_character(tmpManager1ID).move_forward_force
	get_character(tmpManager2ID).direction = 4 ; get_character(tmpManager2ID).move_forward_force
	2.times{get_character(tmpCamID).direction = 2 ; get_character(tmpCamID).move_forward_force ;  wait(32)}
	get_character(tmpVictimID).move_type = 0
	SndLib.sound_ManagerSpot(80)
	get_character(tmpManager2ID).direction = 2
	get_character(tmpManager1ID).direction = 8
	call_msg("TagMapSpawnPoolE:Qprog3/begin6") ; portrait_hide
	get_character(tmpManager2ID).move_forward_force ;  wait(72)
	call_msg("TagMapSpawnPoolE:Qprog3/begin7") ; portrait_hide
	get_character(tmpManager2ID).set_animation("animation_atk_sh")
	SndLib.sound_ManagerAtk(80)
	wait(10)
	SndLib.sound_gore(100) ; SndLib.sound_combat_hit_gore(80)
	EvLib.sum("EffectOverKill",get_character(tmpVictimID).x,get_character(tmpVictimID).y)
	get_character(tmpVictimID).jump_to(get_character(tmpVictimID).x,get_character(tmpVictimID).y)
	get_character(tmpManager1ID).set_animation("animation_atk_mh")
	SndLib.sound_ManagerAtk(80)
	wait(10)
	SndLib.sound_MaleWarriorDed(80)
	SndLib.sound_gore(100) ; SndLib.sound_combat_hit_gore(80)
	EvLib.sum("EffectOverKill",get_character(tmpVictimID).x,get_character(tmpVictimID).y)
	call_msg("TagMapSpawnPoolE:Qprog3/begin8") ; portrait_hide
	get_character(tmpManager2ID).set_animation("animation_atk_mh")
	get_character(tmpVictimID).jump_to(get_character(tmpVictimID).x,get_character(tmpVictimID).y)
	SndLib.sound_ManagerAtk(80)
	wait(10)
		SndLib.sound_gore(100) ; SndLib.sound_combat_hit_gore(80)
	EvLib.sum("EffectOverKill",get_character(tmpVictimID).x,get_character(tmpVictimID).y)
	get_character(tmpManager1ID).set_animation("animation_atk_sh")
	SndLib.sound_ManagerAtk(80)
	wait(10)
	SndLib.sound_MaleWarriorDed(80)
	SndLib.sound_gore(100) ; SndLib.sound_combat_hit_gore(80)
	get_character(tmpVictimID).jump_to(get_character(tmpVictimID).x,get_character(tmpVictimID).y)
	EvLib.sum("EffectOverKill",get_character(tmpVictimID).x,get_character(tmpVictimID).y)
	call_msg("TagMapSpawnPoolE:Qprog3/begin9") ; portrait_hide
	get_character(tmpManager2ID).set_animation("animation_atk_mh")
	SndLib.sound_ManagerAtk(80)
	wait(10)
	SndLib.sound_gore(100) ; SndLib.sound_combat_hit_gore(80)
	EvLib.sum("EffectOverKill",get_character(tmpVictimID).x,get_character(tmpVictimID).y)
	get_character(tmpManager1ID).set_animation("animation_atk_sh")
	SndLib.sound_ManagerAtk(80)
	wait(10)
	SndLib.sound_gore(100) ; SndLib.sound_combat_hit_gore(80)
	get_character(tmpVictimID).jump_to(get_character(tmpVictimID).x,get_character(tmpVictimID).y)
	EvLib.sum("EffectOverKill",get_character(tmpVictimID).x,get_character(tmpVictimID).y)
	set_event_force_page(tmpVictimID,2)
	call_msg("TagMapSpawnPoolE:Qprog3/begin10") ; portrait_hide
	get_character(tmpVictimID).npc_story_mode(true)
	cam_follow(tmpManager1ID,0)
	1.times{
		get_character(tmpManager1ID).direction = 6 ; get_character(tmpManager1ID).move_forward_force
		get_character(tmpManager2ID).direction = 6 ; get_character(tmpManager2ID).move_forward_force
		wait(72)
	}
	2.times{
		get_character(tmpManager1ID).direction = 6 ; get_character(tmpManager1ID).move_forward_force
		get_character(tmpManager2ID).direction = 6 ; get_character(tmpManager2ID).move_forward_force
		#get_character(tmpVictimID).summon_npc_chase_character_back(get_character(tmpManager1ID))
		get_character(tmpVictimID).movetoRolling(get_character(tmpManager1ID).x-1,get_character(tmpManager1ID).y)
		wait(72)
	}
	1.times{
		get_character(tmpManager1ID).direction = 6 ; get_character(tmpManager1ID).move_forward_force
		get_character(tmpManager2ID).direction = 8 ; get_character(tmpManager2ID).move_forward_force
		#get_character(tmpVictimID).summon_npc_chase_character_back(get_character(tmpManager1ID))
		get_character(tmpVictimID).movetoRolling(get_character(tmpManager1ID).x-1,get_character(tmpManager1ID).y)
		wait(72)
	}
	1.times{
		get_character(tmpManager1ID).direction = 6 ; get_character(tmpManager1ID).move_forward_force
		get_character(tmpManager2ID).direction = 6 ; get_character(tmpManager2ID).move_forward_force
		#get_character(tmpVictimID).summon_npc_chase_character_back(get_character(tmpManager1ID))
		get_character(tmpVictimID).movetoRolling(get_character(tmpManager1ID).x-1,get_character(tmpManager1ID).y)
		wait(72)
	}
	1.times{
		get_character(tmpManager1ID).direction = 6 ; get_character(tmpManager1ID).move_forward_force
		get_character(tmpManager2ID).direction = 8 ; get_character(tmpManager2ID).move_forward_force
		wait(72)
	}
	1.times{
		get_character(tmpManager1ID).direction = 4
		get_character(tmpManager1ID).set_animation("animation_atk_mh")
		SndLib.sound_gore(100) ; SndLib.sound_combat_hit_gore(80)
		get_character(tmpManager2ID).direction = 6 ; get_character(tmpManager2ID).move_forward_force
		get_character(tmpVictimID).jump_to(tmpHiveX,tmpHiveY)
		wait(72)
	}
	1.times{
		get_character(tmpManager1ID).direction = 8
		get_character(tmpManager1ID).set_animation("animation_atk_mh")
		SndLib.sound_gore(100) ; SndLib.sound_combat_hit_gore(80)
		EvLib.sum("EffectOverKill",get_character(tmpVictimID).x,get_character(tmpVictimID).y)
		get_character(tmpManager2ID).direction = 6 ; get_character(tmpManager2ID).move_forward_force
		get_character(tmpVictimID).jump_to(tmpHiveX,tmpHiveY)
		wait(72)
	}
	1.times{
		get_character(tmpManager1ID).direction = 8
		get_character(tmpManager1ID).set_animation("animation_atk_mh")
		SndLib.sound_gore(100) ; SndLib.sound_combat_hit_gore(80)
		EvLib.sum("EffectOverKill",get_character(tmpVictimID).x,get_character(tmpVictimID).y)
		get_character(tmpManager2ID).direction = 2 ; get_character(tmpManager2ID).move_forward_force
		get_character(tmpVictimID).jump_to(tmpHiveX,tmpHiveY)
		wait(72)
	}
	1.times{
		SndLib.sound_gore(100) ; SndLib.sound_combat_hit_gore(80)
		EvLib.sum("EffectOverKill",get_character(tmpVictimID).x,get_character(tmpVictimID).y)
		get_character(tmpManager2ID).set_animation("animation_atk_mh")
		get_character(tmpVictimID).jump_to(tmpHiveX,tmpHiveY)
		wait(40)
	}
	1.times{
		SndLib.sound_gore(100) ; SndLib.sound_combat_hit_gore(80)
		EvLib.sum("EffectOverKill",get_character(tmpVictimID).x,get_character(tmpVictimID).y)
		get_character(tmpManager1ID).set_animation("animation_atk_mh")
		get_character(tmpVictimID).jump_to(tmpHiveX,tmpHiveY)
		wait(40)
	}
	1.times{
		SndLib.sound_gore(100) ; SndLib.sound_combat_hit_gore(80)
		EvLib.sum("EffectOverKill",get_character(tmpVictimID).x,get_character(tmpVictimID).y)
		get_character(tmpManager2ID).set_animation("animation_atk_mh")
		get_character(tmpVictimID).jump_to(tmpHiveX,tmpHiveY)
		wait(40)
	}
	EvLib.sum("EffectOverKill",get_character(tmpVictimID).x,get_character(tmpVictimID).y)
	SndLib.sound_gore(100) ; SndLib.sound_combat_hit_gore(80)
	get_character(tmpVictimID).delete
	wait(60)
	get_character(tmpManager1ID).move_forward_force
	wait(72)
	SndLib.sound_gore(100) ; SndLib.sound_combat_hit_gore(80)
	EvLib.sum("EffectOverKill",get_character(tmpManager1ID).x,get_character(tmpManager1ID).y)
	25.times{
		get_character(tmpManager1ID).opacity -=10
		wait(3)
	}
	get_character(tmpManager1ID).delete
	wait(30)
	call_msg("TagMapSpawnPoolE:Qprog3/begin11") ; portrait_hide
	$hudForceHide = false
	$balloonForceHide = false
	$game_player.direction = 8
	$game_player.call_balloon(8)
	wait(60)
	call_msg("TagMapSpawnPoolE:Qprog3/begin12") ; portrait_hide
	get_character(tmpAbomZombieID).call_balloon(8)
	wait(60)
	call_msg("TagMapSpawnPoolE:Qprog3/begin12_1") ; portrait_hide
	set_event_force_page(tmpAbomZombieID,1)
	
	SndLib.BreedlingSpot(80)
	$game_player.jump_to($game_player.x,$game_player.y+1)
	$game_player.direction = 8
	wait(15)
	call_msg("TagMapSpawnPoolE:Qprog3/begin13") ; portrait_hide
	12.times{
	get_character(tmpAbomZombieID).forced_x = 1
	wait(3)
	get_character(tmpAbomZombieID).forced_x = -1
	wait(3)
	}
	SndLib.BreedlingSpot(100)
	EvLib.sum("EffectOverKill",get_character(tmpAbomZombieID).x,get_character(tmpAbomZombieID).y)
	SndLib.sound_gore(100) ; SndLib.sound_combat_hit_gore(80)
	
	tmpBrID = $game_map.get_storypoint("BreedLing1")[2]
	get_character(tmpBrID).set_npc("AbomCreatureBreedling")
	get_character(tmpBrID).moveto(get_character(tmpAbomZombieID).x,get_character(tmpAbomZombieID).y)
	get_character(tmpBrID).summon_data[:runner] = true
	get_character(tmpBrID).summon_data[:MainEnemy] = true
	get_character(tmpBrID).summon_data[:hiveDudes] = true
	get_character(tmpAbomZombieID).delete
	
	
	call_msg("TagMapSpawnPoolE:Qprog3/begin14") ; portrait_hide
	SndLib.bgm_play("CB_Danger LOOP")
	cam_follow(tmpManager2ID,0)
	wait(5)
	get_character(tmpManager2ID).direction = 6
	get_character(tmpManager2ID).call_balloon(1)
	SndLib.sound_ManagerSpot(80)
	wait(60)
	call_msg("TagMapSpawnPoolE:Qprog3/begin15") ; portrait_hide
	$game_player.direction = 6 ; $game_player.move_forward_force
	wait(10)
	SndLib.stoneCollapsed(100)
	get_character(tmpBlk1ID).opacity = 255
	get_character(tmpBlk1ID).moveto(tmpWallTarX,tmpWallTarY)
	wait(5)
	SndLib.stoneCollapsed(100)
	get_character(tmpBlk2ID).opacity = 255
	get_character(tmpBlk2ID).moveto(tmpWallTarX,tmpWallTarY+1)
	wait(5)
	$game_player.jump_to(tmpAbomZombieX-1,tmpAbomZombieY+1)
	$game_player.direction = 6
	wait(20)
	call_msg("TagMapSpawnPoolE:Qprog3/begin16") ; portrait_hide
	
	get_character(tmpCamID).npc_story_mode(false)
	#get_character(tmpManager1ID).npc_story_mode(false)
	get_character(tmpManager2ID).npc_story_mode(false)
	get_character(tmpManager2ID).set_manual_move_type(2)
	get_character(tmpManager2ID).move_type = 2
	set_event_force_page(tmpQuestCountID,2)
	
end
eventPlayEnd
