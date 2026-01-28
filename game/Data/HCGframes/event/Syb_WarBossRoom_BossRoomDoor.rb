if $story_stats["UniqueCharUniqueOgreWarBoss"] != -1 && $story_stats["RapeLoop"] >= 1
	tmpGobRunnerX,tmpGobRunnerY,tmpGobRunnerID=$game_map.get_storypoint("GobRunner")
	tmpToBossRoomX,tmpToBossRoomY,tmpToBossRoomID=$game_map.get_storypoint("ToBossRoom")
		
	tmpMove_type = $game_player.actor.master.move_type
	$game_player.actor.master.npc_story_mode(true)
	$game_player.actor.master.move_type = 0
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		$game_player.actor.master.moveto(tmpToBossRoomX,tmpToBossRoomY-1)
		get_character(tmpGobRunnerID).moveto(tmpToBossRoomX,tmpToBossRoomY)
		get_character(tmpGobRunnerID).opacity = 255
		get_character(tmpGobRunnerID).npc_story_mode(true)
		$game_player.actor.master.direction = 2
		get_character(tmpGobRunnerID).direction = 8
	chcg_background_color(0,0,0,255,-7)
	SndLib.sound_goblin_spot(80,130)
	get_character(tmpGobRunnerID).jump_to(get_character(tmpGobRunnerID).x,get_character(tmpGobRunnerID).y)
	get_character(tmpGobRunnerID).call_balloon(6)
	wait(60)
	call_msg("TagMapSyb_WarBossRoom:rapeloopGo_out/begin1")
	call_msg("TagMapSyb_WarBossRoom:rapeloopGo_out/opt") #[叫他自己想辦法,殺了他們！]
	
	
	if $game_temp.choice == 1
		$story_stats["tmpData"] = "WarBossRapeLoop"
		portrait_hide
		chcg_background_color(0,0,0,0,7)
		map_background_color(0,0,0,255,0)
		portrait_off
		change_map_tag_sub("OrkindKeep1_Qu","STptTop",2,tmpChoice=true,tmpSkipOpt=true)
		return
	else
		$game_player.actor.master.call_balloon(5)
		SndLib.sound_OgreDed(80,120)
		wait(60)
		$game_player.actor.master.animation = $game_player.actor.master.animation_atk_mh
		wait(8)
		SndLib.sound_punch_hit(100)
		wait(8)
		SndLib.sound_goblin_spot(80,130)
		get_character(tmpGobRunnerID).jump_to(get_character(tmpGobRunnerID).x,get_character(tmpGobRunnerID).y)
		get_character(tmpGobRunnerID).animation = get_character(tmpGobRunnerID).animation_stun
		wait(90)
		chcg_background_color(0,0,0,0,7)
			$game_player.actor.master.move_type = tmpMove_type
			$game_player.actor.master.npc_story_mode(false)
			get_character(tmpGobRunnerID).animation = nil
			get_character(tmpGobRunnerID).npc_story_mode(false)
			get_character(tmpGobRunnerID).moveto(tmpGobRunnerX,tmpGobRunnerY)
			get_character(tmpGobRunnerID).opacity = 0
		chcg_background_color(0,0,0,255,-7)
	end
	

else #normal exit
	if get_character(0).summon_data[:locked]
		SndLib.sys_DoorLock
		call_msg_popup("TagMapNoerCatacomb:Necropolis/Locked#{rand(2)}")
		return
	end
	
	
	tmpData = [nil,nil,nil,nil,
	"cave_fall",
	nil,nil,nil]
	moveto_teleport_point("BossRoomToFloor",tmpData,2)
end