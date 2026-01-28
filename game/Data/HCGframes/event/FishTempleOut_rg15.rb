return if $story_stats["RecQuestFishInn"] >= 4
if ($story_stats["RecQuestSeaWitch"] <= 1 || $story_stats["RecQuestSeaWitch"] >= 4) && $story_stats["UniqueCharUniqueSeaWitch"] != -1 && $story_stats["RecQuestFishInn"] == 3
	tmpSwX,tmpSwY,tmpSwID=$game_map.get_storypoint("SeaWitch")
	tmpRpX,tmpRpY,tmpRpID=$game_map.get_storypoint("RapePoint")
	tmpVicX,tmpVicY,tmpVicID=$game_map.get_storypoint("Victim")
	tmpQg0X,tmpQg0Y,tmpQg0ID=$game_map.get_storypoint("QueenGuard")
	
	chcg_background_color(0,0,0,0,7)
		get_character(tmpSwID).npc_story_mode(true)
		get_character(tmpVicID).npc_story_mode(true)
		get_character(tmpQg0ID).npc_story_mode(true)
		#get_character(tmpSwID).animation = get_character(tmpSwID).animation_stun
		get_character(tmpSwID).moveto(tmpRpX,tmpRpY)
		get_character(tmpVicID).moveto(tmpRpX,tmpRpY+4)
		get_character(tmpQg0ID).moveto(tmpRpX,tmpRpY+5)
		get_character(tmpSwID).opacity = 5
		get_character(tmpSwID).zoom_x = 3
		get_character(tmpSwID).zoom_y = 3
		cam_follow(tmpQg0ID,0)
	chcg_background_color(0,0,0,255,-7)
	
	get_character(tmpVicID).call_balloon(5) ; cam_follow(tmpVicID,0) ; SndLib.FishkindSmSpot ; wait(40)
	wait(30)
	get_character(tmpQg0ID).animation = get_character(tmpQg0ID).animation_atk_mh
	wait(5)
	SndLib.sound_punch_hit(100)
	get_character(tmpVicID).jump_to(tmpRpX,tmpRpY+3)
	get_character(tmpVicID).direction = 2
	get_character(tmpQg0ID).call_balloon(20) ; cam_follow(tmpQg0ID,0) ; SndLib.FishkindSmSpot ; wait(40)
	get_character(tmpVicID).call_balloon(5) ; cam_follow(tmpVicID,0) ; SndLib.FishkindSmSpot ; wait(40)
	get_character(tmpQg0ID).move_forward
	get_character(tmpVicID).direction = 8 ; get_character(tmpVicID).move_forward ; get_character(tmpVicID).direction = 2
	get_character(tmpVicID).call_balloon(8) ; cam_follow(tmpVicID,0) ; SndLib.FishkindSmSpot ; wait(40)
	get_character(tmpQg0ID).move_forward
	get_character(tmpVicID).direction = 8 ; get_character(tmpVicID).move_forward ; get_character(tmpVicID).direction = 2
	3.times{
		wait(60)
		SndLib.FishkindSmSpot
		SndLib.FishkindLgSpot
		$game_map.npcs.each{
		|event|
			next unless event.summon_data
			next unless event.summon_data[:FishF]
			next if event.deleted?
			event.call_balloon(20)
		}
	get_character(tmpVicID).turn_random
	}
	get_character(tmpVicID).direction = 8
	
	SndLib.buff_life(80,80)
	20.times{
		get_character(tmpSwID).opacity += 10
		get_character(tmpSwID).zoom_x -= 0.1
		get_character(tmpSwID).zoom_y -= 0.1
		wait(2)
	}
	
	get_character(tmpSwID).opacity = 255
	get_character(tmpVicID).call_balloon(2) ; cam_follow(tmpVicID,0) ; SndLib.FishkindSmSpot ; wait(40)
	wait(60)
	get_character(tmpSwID).animation = get_character(tmpSwID).animation_grabber_qte(get_character(tmpVicID))
	get_character(tmpVicID).animation = get_character(tmpVicID).animation_grabbed_qte
	SndLib.sound_equip_armor
	get_character(tmpSwID).call_balloon(20) ; cam_follow(tmpSwID,0) ; SndLib.FishkindSmSpot ; wait(40)
	wait(60)
	SndLib.sound_chs_buchu
	get_character(tmpVicID).moveto(get_character(tmpSwID).x,get_character(tmpSwID).y)
	npc_sex_service_main(get_character(tmpVicID),get_character(tmpSwID),"vag",1,0)
	get_character(tmpSwID).call_balloon(20) ; cam_follow(tmpSwID,0) ; SndLib.FishkindSmSpot ; wait(40)
	wait(60)
	4.times{
		wait(60)
		SndLib.FishkindSmSpot
		SndLib.FishkindLgSpot
		$game_map.npcs.each{
		|event|
			next unless event.summon_data
			next unless event.summon_data[:FishF]
			next if event.deleted?
			event.call_balloon(20)
		}
	}
	wait(60)
	chcg_background_color(0,0,0,0,7)
		get_character(tmpSwID).unset_event_chs_sex
		get_character(tmpVicID).unset_event_chs_sex
		get_character(tmpVicID).animation = nil
		get_character(tmpVicID).setup_cropse_graphics
		get_character(tmpSwID).npc_story_mode(false)
		get_character(tmpVicID).npc_story_mode(false)
		get_character(tmpQg0ID).npc_story_mode(false)
		get_character(tmpSwID).delete
		get_character(tmpQg0ID).delete
		cam_center(0)
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapFishTempleOut:this/3to4")
	SndLib.bgm_play("CB_Barren Combat LOOP",70,120)
	$story_stats["RecQuestFishInn"] = 4
else
	call_msg("TagMapFishTempleOut:this/3to4")
	SndLib.bgm_play("CB_Barren Combat LOOP",70,120)
	$story_stats["RecQuestFishInn"] = 4
end

eventPlayEnd
get_character(0).erase