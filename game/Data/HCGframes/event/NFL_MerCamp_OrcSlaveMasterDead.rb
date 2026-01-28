return if $story_stats["UniqueChar_OrcSlaveMaster"] == -1
$story_stats["UniqueChar_OrcSlaveMaster"] = -1
#SndLib.bgm_stop
SndLib.me_play("/ME/Frantic Battle LOOP END")
tgtEV = get_character(0).summon_data[:user]
tgtEV.character_index = 4
tgtEV.npc_story_mode(true)
set_event_force_page(tgtEV.id,3)
tgtEV.move_type = 0

tmpHorseCockID = $game_map.get_storypoint("HorseCock")[2]
tmpCamX,tmpCamY,tmpCamID = $game_map.get_storypoint("Cam")
get_character(tmpCamID).moveto(tgtEV.x,tgtEV.y)
cam_follow(tmpCamID,0)
SndLib.sound_OrcSkill
tmpAni =	[
	[9,4,2,-5,-1],
	[9,4,1,-6,0],
	[9,4,5,-7,-1]
]
tgtEV.call_balloon(6)
tgtEV.animation = tgtEV.aniCustom(tmpAni,-1)
SndLib.sound_OrcSkill


SndLib.sound_OrcSpot
$game_portraits.setLprt("OrcSlaveMaster_normal")
$game_portraits.lprt.shake
call_msg("?????????")
wait(60)


wait(60)

call_msg("TagMapNFL_MerCamp:Invade/4_BossDefeat0")
portrait_hide

SndLib.sound_OrcDeath
$game_portraits.setRprt("OrcSlaveMaster_sad")
$game_portraits.rprt.shake
tmpAni =	[
	[6,6,2,-5,-1],
	[6,6,1,-6,0],
	[6,6,5,-7,-1]
]
tgtEV.call_balloon(2)
tgtEV.animation = tgtEV.aniCustom(tmpAni,-1)
SndLib.sound_OrcSkill
wait(90)
tmpAni =	[
	[6,5,2,-5,-1],
	[6,5,1,-6,0],
	[6,5,5,-7,-1]
]
tgtEV.call_balloon(1)
tgtEV.animation = tgtEV.aniCustom(tmpAni,-1)

call_msg("TagMapNFL_MerCamp:Invade/4_BossDefeat1") if $story_stats["UniqueChar_NFL_MerCamp_Leader"] != -1
portrait_hide
cam_center(0)
tgtEV.animation = nil
tmpAni =	[
	[0,6,20,-5,-1],
	[1,6,10,-6,0],
	[2,6,5,-7,-1]
]
tgtEV.animation = tgtEV.aniCustom(tmpAni,-1)
get_character(tmpHorseCockID).force_update = true
get_character(tmpHorseCockID).moveto(tgtEV.x,tgtEV.y)
get_character(tmpHorseCockID).move_type = 3
get_character(tmpHorseCockID).call_balloon(28,-1)
SndLib.sound_OrcDeath(100,120)
$game_portraits.setRprt("OrcSlaveMaster_sad")
$game_portraits.rprt.fade
	tmpCount =0
	20.times{
		tmpCount += 1
		tgtEV.direction = 6 ; tgtEV.move_forward_force
		tgtEV.move_speed = 5.2
		if tmpCount >= 2
			tmpCount = 0
			SndLib.sound_step(tgtEV.report_distance_to_vol_close,50)
		end
		until !tgtEV.moving? ; wait(1) end
	}
portrait_hide
tgtEV.npc_story_mode(false)
tgtEV.delete
