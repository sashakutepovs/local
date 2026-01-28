
tmpCoX,tmpCoY,tmpCoID=$game_map.get_storypoint("Cocona")
tmpBrX,tmpBrY,tmpBrID=$game_map.get_storypoint("CoconaNapPT")
cam_follow(tmpCoID,0)
portrait_hide

tmpRG_AgroID=$game_map.get_storypoint("RG_forceAggro")[2]
#10 room1, 11 room2, 12 room3, 13 room4
#do room 2 3, rg 11 12
get_character(tmpRG_AgroID).erase


call_msg("TagMapNoerCatacombB1:Cocona/NapTime0") ; portrait_hide
get_character(tmpCoID).npc_story_mode(true)
tmpMoveType = get_character(tmpCoID).move_type
get_character(tmpCoID).move_type = 0

get_character(tmpCoID).move_goto_xy(get_character(tmpCoID).x,get_character(tmpCoID).y+1)
wait(35)
get_character(tmpCoID).move_goto_xy(get_character(tmpCoID).x+1,get_character(tmpCoID).y)
wait(35)
tmpCount = 0
until get_character(tmpCoID).x == tmpBrX && get_character(tmpCoID).y == tmpBrY-2
	get_character(tmpCoID).move_goto_xy(tmpBrX,tmpBrY-2)
	wait(35)
	tmpCount +=1
	get_character(tmpCoID).moveto(tmpBrX,tmpBrY-2) if tmpCount >= 20
end
get_character(tmpCoID).move_type = tmpMoveType
set_event_force_page(tmpCoID,6) #nap
get_character(tmpCoID).direction =2
get_character(tmpCoID).animation = get_character(tmpCoID).animation_stun
get_character(tmpCoID).call_balloon(12)
get_character(tmpCoID).npc_story_mode(false)
wait(90)
cam_center(0)
portrait_off
call_msg("TagMapNoerCatacombB1:Cocona/NapTime1") ; portrait_hide


portrait_hide