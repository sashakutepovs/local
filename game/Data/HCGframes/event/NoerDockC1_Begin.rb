
if $story_stats["RecQuestLeeruoiStatue"] == 1
	$story_stats["RecQuestLeeruoiStatue"] = 2
	tmpFishStopID = $game_map.get_storypoint("FishStop")[2]
	tmpFishBeatID = $game_map.get_storypoint("FishBeat")[2]
	tmpChk6X,tmpChk6Y,tmpChk6ID = $game_map.get_storypoint("Chk6")
	tmpStatueX,tmpStatueY,tmpStatueID = $game_map.get_storypoint("Statue")
	set_event_force_page(tmpFishStopID,1)
	set_event_force_page(tmpFishBeatID,1)
	get_character(tmpFishStopID).moveto(tmpChk6X,tmpChk6Y-2)
	get_character(tmpFishBeatID).moveto(tmpChk6X,tmpChk6Y-1)
	get_character(tmpFishStopID).direction = 2
	get_character(tmpFishBeatID).direction = 8
	get_character(tmpFishStopID).npc_story_mode(true)
	get_character(tmpFishBeatID).npc_story_mode(true)
	get_character(tmpStatueID).npc_story_mode(true)
	cam_follow(tmpFishBeatID,0)
	portrait_hide
	chcg_background_color(0,0,0,255,-7)
	portrait_off
	get_character(tmpFishStopID).call_balloon(20) ; cam_follow(tmpFishStopID,0) ;SndLib.FishkindSmSpot
	wait(80)
	get_character(tmpFishBeatID).call_balloon(20) ; cam_follow(tmpFishBeatID,0) ;SndLib.FishkindSmSpot
	wait(60)
	get_character(tmpFishBeatID).direction = 2
	get_character(tmpFishBeatID).call_balloon(5) ; cam_follow(tmpFishBeatID,0) ;SndLib.FishkindSmSpot
	wait(60)
	get_character(tmpFishStopID).call_balloon(6) ; cam_follow(tmpFishStopID,0) ;SndLib.FishkindSmSpot
	wait(30)
	cam_follow(tmpFishBeatID,0);SndLib.FishkindSmSpot
	get_character(tmpFishBeatID).move_forward_force
	wait(35)
	get_character(tmpFishBeatID).move_forward_force
	wait(35)
	get_character(tmpFishBeatID).call_balloon(15) ; cam_follow(tmpFishBeatID,0) ;SndLib.FishkindSmSpot
	wait(60)
	get_character(tmpFishBeatID).set_animation("animation_atk_mh") ; wait(5) ; SndLib.FishkindSmHurt ; wait(5) ; SndLib.sound_punch_hit(80)
	get_character(tmpStatueID).jump_to_low(get_character(tmpStatueID).x,get_character(tmpStatueID).y)
	wait(30)
	get_character(tmpFishBeatID).set_animation("animation_atk_sh") ; wait(5) ; SndLib.FishkindSmHurt ; wait(5) ; SndLib.sound_punch_hit(80)
	get_character(tmpStatueID).jump_to_low(get_character(tmpStatueID).x,get_character(tmpStatueID).y)
	wait(30)
	get_character(tmpFishBeatID).call_balloon(15) ; cam_follow(tmpFishBeatID,0) ;SndLib.FishkindSmSpot
	wait(60)
	get_character(tmpFishStopID).call_balloon(20) ; cam_follow(tmpFishStopID,0) ;SndLib.FishkindSmSpot
	cam_follow(tmpFishStopID,0);SndLib.FishkindSmSpot
	get_character(tmpFishStopID).move_forward_force
	wait(35)
	get_character(tmpFishStopID).move_forward_force
	get_character(tmpFishBeatID).set_animation("animation_atk_mh") ; wait(5) ; SndLib.FishkindSmHurt ; wait(5) ; SndLib.sound_punch_hit(80)
	get_character(tmpStatueID).jump_to_low(get_character(tmpStatueID).x,get_character(tmpStatueID).y)
	wait(35)
	get_character(tmpFishStopID).animation = get_character(tmpFishStopID).animation_grabber_qte(get_character(tmpFishBeatID))
	get_character(tmpFishBeatID).animation = get_character(tmpFishBeatID).animation_grabbed_qte
	get_character(tmpFishStopID).move_speed = 2
	get_character(tmpFishBeatID).move_speed = 2
	wait(30)
	get_character(tmpFishStopID).call_balloon(20) ; cam_follow(tmpFishStopID,0) ;SndLib.FishkindSmSpot
	wait(60)
	get_character(tmpFishBeatID).call_balloon(15) ; cam_follow(tmpFishBeatID,0) ;SndLib.FishkindSmSpot
	wait(60)
	get_character(tmpFishStopID).call_balloon(6) ; cam_follow(tmpFishStopID,0) ;SndLib.FishkindSmSpot
	wait(60)
	get_character(tmpFishStopID).direction = 8
	get_character(tmpFishBeatID).direction = 8
	2.times{
		get_character(tmpFishStopID).move_forward_force
		get_character(tmpFishBeatID).move_forward_force
		SndLib.sound_equip_armor(80,50)
		wait(60)
	}
	get_character(tmpFishStopID).call_balloon(6) ; cam_follow(tmpFishStopID,0) ;SndLib.FishkindSmSpot
	wait(60)
	get_character(tmpFishBeatID).call_balloon(15) ; cam_follow(tmpFishBeatID,0) ;SndLib.FishkindSmSpot
	wait(60)
	get_character(tmpFishStopID).animation = nil
	get_character(tmpFishBeatID).animation = nil
	get_character(tmpFishStopID).direction = 2
	get_character(tmpFishBeatID).direction = 8
	wait(20)
	get_character(tmpFishStopID).call_balloon(6) ; cam_follow(tmpFishStopID,0) ;SndLib.FishkindSmSpot
	wait(60)
	get_character(tmpFishBeatID).call_balloon(7) ; cam_follow(tmpFishBeatID,0) ;SndLib.FishkindSmSpot
	wait(90)
	
	chcg_background_color(0,0,0,0,7)
	get_character(tmpStatueID).npc_story_mode(false)
	get_character(tmpFishStopID).delete
	get_character(tmpFishBeatID).delete
	get_character(tmpStatueID).call_balloon(28,-1)
end
