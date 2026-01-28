
tmpAbm1X,tmpAbm1Y,tmpAbm1ID = $game_map.get_storypoint("ABman1")
tmpAbm2X,tmpAbm2Y,tmpAbm2ID = $game_map.get_storypoint("ABman2")
tmpSgX,tmpSgY,tmpSgID = $game_map.get_storypoint("cpSGT")
tmpTgtX,tmpTgtY,tmpTgtID = $game_map.get_storypoint("TarOut")
posi1=$game_map.region_map[30].sample
posi2=$game_map.region_map[30].sample
chcg_background_color(0,0,0,0,7)
	call_msg("TagMapDoomFortEastCP:CPofficer/overrunning_begin3_clearNarr0")
	get_character(tmpAbm1ID).moveto(posi1[0],posi1[1])
	get_character(tmpAbm2ID).moveto(posi2[0],posi2[1])
	get_character(tmpAbm1ID).direction = 4
	get_character(tmpAbm2ID).direction = 4
chcg_background_color(0,0,0,255,-7)
	cam_follow(tmpAbm1ID,0)
	get_character(tmpAbm1ID).call_balloon(20)
	SndLib.sound_ManagerSpot
	wait(60)
	cam_follow(tmpAbm2ID,0)
	get_character(tmpAbm2ID).call_balloon(20)
	SndLib.sound_ManagerSpot
	wait(60)
call_msg("TagMapDoomFortEastCP:CPofficer/overrunning_begin3_clearNarr1")
if !get_character(tmpSgID).nil? && get_character(tmpSgID).npc? && get_character(tmpSgID).npc.action_state != :death
	get_character(tmpSgID).moveto(tmpTgtX,tmpTgtY)
	get_character(tmpSgID).direction = 6
end
portrait_hide
cam_center(0)
set_this_event_force_page(4)
