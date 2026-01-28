
tmpCoX,tmpCoY,tmpCoID=$game_map.get_storypoint("Cocona")
tmpBrX,tmpBrY,tmpBrID=$game_map.get_storypoint("CoMama")
tmpFd1X,tmpFd1Y,tmpFd1ID=$game_map.get_storypoint("Food1")
tmpFd2X,tmpFd2Y,tmpFd2ID=$game_map.get_storypoint("Food2")
cam_follow(tmpCoID,0)
portrait_hide

tmpRG_AgroID=$game_map.get_storypoint("RG_forceAggro")[2]
#10 room1, 11 room2, 12 room3, 13 room4
#do room 2 3, rg 11 12
get_character(tmpRG_AgroID).set_region_trigger(12)

call_msg("TagMapNoerCatacombB1:Cocona/DinnerTime0") ; portrait_hide
get_character(tmpCoID).npc_story_mode(true)
tmpMoveType = get_character(tmpCoID).move_type
get_character(tmpCoID).move_type = 0
tmpCount = 0
until get_character(tmpCoID).x == tmpBrX && get_character(tmpCoID).y == tmpBrY+1
	get_character(tmpCoID).move_goto_xy(tmpBrX,tmpBrY+1)
	wait(35)
	tmpCount +=1
	get_character(tmpCoID).moveto(tmpBrX,tmpBrY+1) if tmpCount >= 20
end
get_character(tmpCoID).move_type = tmpMoveType
get_character(tmpCoID).direction =6
get_character(tmpCoID).npc_story_mode(false)
wait(20)
SndLib.sound_equip_armor(70)
get_character(tmpFd1ID).opacity = 255
wait(45)
SndLib.sound_equip_armor(70)
get_character(tmpFd2ID).opacity = 255
wait(45)
call_msg("TagMapNoerCatacombB1:Cocona/DinnerTime1") ; portrait_hide
get_character(tmpCoID).call_balloon(8)
wait(70)
get_character(tmpCoID).call_balloon(8)
wait(70)
get_character(tmpCoID).call_balloon(8)
wait(70)
call_msg("TagMapNoerCatacombB1:Cocona/DinnerTime2") ; portrait_hide


cam_center(0)
set_event_force_page(tmpCoID,5) #cooking
portrait_hide