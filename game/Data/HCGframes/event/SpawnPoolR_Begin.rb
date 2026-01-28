
if $story_stats["RecQuestSouthFLMain"] == 8
	#chcg_background_color(0,0,0,255,-7) if $story_stats["ReRollHalfEvents"] ==1
	SndLib.bgm_play("Murky Dungeon LOOP",85)
	tmpStartPointX,tmpStartPointY=$game_map.get_storypoint("StartPoint")
	tmpBlk1X,tmpBlk1Y,tmpBlk1ID = $game_map.get_storypoint("block1")
	tmpBlk2X,tmpBlk2Y,tmpBlk2ID = $game_map.get_storypoint("block2")
	tmpBlk3X,tmpBlk3Y,tmpBlk3ID = $game_map.get_storypoint("block3")
	tmpExitX,tmpExitY,tmpExitID = $game_map.get_storypoint("Exit")
	get_character(tmpExitID).call_balloon(28,-1)
	$game_player.direction = 8
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapSpawnPoolR:Qprog8/RaidOnEast1") ; portrait_hide
	SndLib.stepBush(100)
	wait(5)
	SndLib.stepBush(100)
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:WildnessNapEvent] == "HumanGuard"
		next if event.deleted?
		event.direction = 2
		event.call_balloon(1)
	}
	call_msg("TagMapSpawnPoolR:Qprog8/RaidOnEast2") ; portrait_hide
	$game_player.opacity = 0
	$game_player.moveto(tmpStartPointX,tmpStartPointY+1)
	cam_center(0)
	25.times{
		$game_player.opacity += 10
		wait(2)
	}
	$game_player.opacity = 255
	call_msg("TagMapSpawnPoolR:Qprog8/RaidOnEast3") ; portrait_hide
	#SndLib.bgm_play("CB_Epic Drums (Looped)",80,100)
	wait(10)
	SndLib.stoneCollapsed(100)
	get_character(tmpBlk1ID).opacity = 255
	get_character(tmpBlk1ID).moveto(tmpStartPointX-1,tmpStartPointY+1)
	wait(5)
	SndLib.stoneCollapsed(100)
	get_character(tmpBlk2ID).opacity = 255
	get_character(tmpBlk2ID).moveto(tmpStartPointX,tmpStartPointY+1)
	wait(5)
	SndLib.stoneCollapsed(100)
	get_character(tmpBlk3ID).opacity = 255
	get_character(tmpBlk3ID).moveto(tmpStartPointX+1,tmpStartPointY+1)
	wait(5)
	$game_player.jump_to(tmpStartPointX,tmpStartPointY-1)
	$game_player.direction = 2
	wait(20)
	call_msg("TagMapSpawnPoolR:Qprog8/RaidOnEast4") ; portrait_hide
	$game_player.direction = 8
	call_msg("TagMapSpawnPoolR:Qprog8/RaidOnEast5") ; portrait_hide
	call_msg("TagMapSpawnPoolR:Qprog8/RaidOnEast6") ; portrait_hide
	call_msg("TagMapSpawnPoolR:Qprog8/RaidOnEast7") ; portrait_hide
	call_msg("TagMapSpawnPoolR:Qprog8/RaidOnEast8") ; portrait_hide
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:WildnessNapEvent] == "HumanGuard"
		next if event.deleted?
		$game_player.set_follower(event.event.id)
		event.follower = [1,1,0,0]
		event.set_manual_move_type(3)
		event.npc.death_event = "EffectRefugeeCharDed"
		event.move_type = 3 if [0,1,2].include?(event.move_type)
	}
	eventPlayEnd
	
end