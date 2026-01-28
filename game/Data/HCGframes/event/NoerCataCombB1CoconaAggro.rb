return if $story_stats["UniqueCharUniqueCocona"] == -1
tmpCoX,tmpCoY,tmpCoID=$game_map.get_storypoint("Cocona")
tmpFd2X,tmpFd2Y,tmpFd2ID=$game_map.get_storypoint("Food2")
tmpTsX,tmpTsY,tmpTsID=$game_map.get_storypoint("ToSurface")
tmpGh1X,tmpGh1Y,tmpGh1ID=$game_map.get_storypoint("GoblinHole1")
tmpGh2X,tmpGh2Y,tmpGh2ID=$game_map.get_storypoint("GoblinHole2")
tmpGh3X,tmpGh3Y,tmpGh3ID=$game_map.get_storypoint("GoblinHole3")
tmpTarB2X,tmpTarB2Y,tmpTarB2ID=$game_map.get_storypoint("TarB2")
#tmpRock1X,tmpRock1Y,tmpRock1ID=$game_map.get_storypoint("Rock1")
#tmpRock2X,tmpRock2Y,tmpRock2ID=$game_map.get_storypoint("Rock2")
#tmpRock3X,tmpRock3Y,tmpRock3ID=$game_map.get_storypoint("Rock3")
#tmpRock4X,tmpRock4Y,tmpRock4ID=$game_map.get_storypoint("Rock4")
get_character(tmpCoID).npc.cancel_holding
get_character(tmpCoID).npc.reset_skill(true)
get_character(tmpCoID).animation = nil
get_character(tmpCoID).call_balloon(0)
call_msg("TagMapNoerCatacombB1:Cocona/aggro")
if get_character(0).switch1_id == 1
	
	
	$story_stats["QuProgCataUndeadHunt2"] = 5
	get_character(tmpCoID).npc.process_target_lost
	get_character(tmpCoID).npc.set_fated_enemy([5,6,9])
	get_character(tmpCoID).npc.fraction_mode =2
	get_character(tmpCoID).npc.master = $game_player
	get_character(tmpCoID).npc.cancel_holding
	get_character(tmpCoID).npc.reset_skill(true)
	get_character(tmpCoID).call_balloon(0)
	get_character(tmpCoID).animation = nil
	call_msg("TagMapNoerCatacombB1:Cocona/aggro_FdSide1")
	get_character(tmpCoID).set_this_event_companion_back("UniqueCocona",true,$game_date.dateAmt+3)
	set_event_force_page(tmpCoID,3)
	
	chcg_background_color(0,0,0,0,7)
	$game_player.moveto(tmpFd2X-1,tmpFd2Y)
	get_character(tmpCoID).moveto(tmpFd2X+1,tmpFd2Y)
	$game_player.direction = 6
	get_character(tmpCoID).direction = 4
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapNoerCatacombB1:Cocona/aggro_FdSide2")
	chcg_background_color(0,0,0,0,7)
	call_msg("TagMapNoerCatacombB1:Cocona/aggro_FdSide3")
	$game_player.actor.mood = $game_player.actor.attr_dimensions["mood"][2]
	$game_player.actor.sta = $game_player.actor.attr_dimensions["sta"][2]
	$game_player.actor.sat = $game_player.actor.attr_dimensions["sat"][2]
	chcg_background_color(0,0,0,255,-7)
	
	
	#get_character(tmpRock1ID).moveto(tmpTarB2X-1,tmpTarB2Y-1)
	#get_character(tmpRock2ID).moveto(tmpTarB2X,tmpTarB2Y-1)
	#get_character(tmpRock3ID).moveto(tmpTarB2X-1,tmpTarB2Y)
	#get_character(tmpRock4ID).moveto(tmpTarB2X,tmpTarB2Y)
	#get_character(tmpRock1ID).opacity = 255
	#get_character(tmpRock2ID).opacity = 255
	#get_character(tmpRock3ID).opacity = 255
	#get_character(tmpRock4ID).opacity = 255
	
	call_msg("TagMapNoerCatacombB1:Cocona/aggro_FdSide4")
	$game_map.interpreter.screen.start_shake(1,7,60)
	SndLib.sound_FlameCast(60,70)
	wait(60)
	$game_player.turn_random
	get_character(tmpCoID).turn_random
	call_msg("TagMapNoerCatacombB1:Cocona/aggro_FdSide5")
	$game_map.interpreter.screen.start_shake(5,10,60)
	SndLib.sound_FlameCast(80,70)
	wait(60)
	$game_player.turn_random
	get_character(tmpCoID).turn_random
	call_msg("TagMapNoerCatacombB1:Cocona/aggro_FdSide6") ; portrait_hide
	$game_map.interpreter.screen.start_shake(5,10,60)
	SndLib.sound_FlameCast(100,70)
	wait(60)
	
	
	
	cam_follow(tmpGh1ID,0)
	$game_map.interpreter.screen.start_shake(5,10,60)
	SndLib.sound_FlameCast(100,70)
	set_event_force_page(tmpGh1ID,1)
	wait(10)
	EvLib.sum("GoblinClub",tmpGh1X,tmpGh1Y,{:OrkArmy=>true})
	wait(10)
	EvLib.sum("GoblinSpear",tmpGh1X,tmpGh1Y+1,{:OrkArmy=>true})
	call_msg("TagMapNoerCatacombB1:Orkind/Gob1") ; portrait_hide
	wait(60)
	
	cam_follow(tmpGh2ID,0)
	$game_map.interpreter.screen.start_shake(5,10,60)
	SndLib.sound_FlameCast(100,70)
	set_event_force_page(tmpGh2ID,1)
	wait(10)
	EvLib.sum("GoblinWarrior",tmpGh2X,tmpGh2Y,{:OrkArmy=>true})
	wait(10)
	EvLib.sum("GoblinBow",tmpGh2X,tmpGh2Y+1)
	EvLib.sum("GoblinBow",tmpGh2X+1,tmpGh2Y+1)
	call_msg("TagMapNoerCatacombB1:Orkind/Gob2") ; portrait_hide
	wait(60)
	
	cam_follow(tmpGh3ID,0)
	$game_map.interpreter.screen.start_shake(5,10,60)
	SndLib.sound_FlameCast(100,70)
	set_event_force_page(tmpGh3ID,1)
	wait(10)
	EvLib.sum("GoblinWarrior",tmpGh3X,tmpGh3Y,{:OrkArmy=>true})
	wait(10)
	EvLib.sum("OrcClub",tmpGh3X-1,tmpGh3Y-1,{:OrkArmy=>true})
	EvLib.sum("OrcClub",tmpGh3X-1,tmpGh3Y,{:OrkArmy=>true})
	call_msg("TagMapNoerCatacombB1:Orkind/Gob3") ; portrait_hide
	wait(60)
	
	portrait_hide
	$game_player.direction = 6
	get_character(tmpCoID).direction = 4
	call_msg("TagMapNoerCatacombB1:Cocona/aggro_FdSide7")
	wait(10)
	call_msg("TagMapNoerCatacombB1:Cocona/aggro_FdSide8")
	
	
	get_character(tmpTsID).call_balloon(28,-1)
	
	
	SndLib.bgm_play("CB_Danger LOOP",70)
	eventPlayEnd
	set_this_event_force_page(3)
else
	set_event_force_page(tmpCoID,2)
	eventPlayEnd
	get_character(0).erase
end