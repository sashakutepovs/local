return if $story_stats["RecQuestSeaWitch"] != 0
return if $story_stats["Captured"] == 1 && $story_stats["RecQuestElise"] != 14
$story_stats["RecQuestSeaWitch"] = 1

tmpCFX,tmpCFY,tmpCFID=$game_map.get_storypoint("CenterFish")
tmpSWX,tmpSWY,tmpSWID=$game_map.get_storypoint("SeaWitch")
tmpGM1X,tmpGM1Y,tmpGM1ID=$game_map.get_storypoint("GuardM1")
tmpGM2X,tmpGM2Y,tmpGM2ID=$game_map.get_storypoint("GuardM2")
tmpGM3X,tmpGM3Y,tmpGM3ID=$game_map.get_storypoint("GuardM3")
tmpQG1X,tmpQG1Y,tmpQG1ID=$game_map.get_storypoint("QueenG1")
tmpQG2X,tmpQG2Y,tmpQG2ID=$game_map.get_storypoint("QueenG2")
tmpQG3X,tmpQG3Y,tmpQG3ID=$game_map.get_storypoint("QueenG3")

#portrait_hide
#chcg_background_color(0,0,0,0,7)
	#portrait_off
	#get_character(tmpSWID).call_balloon(0)
	#cam_follow(tmpGM1ID,0)
	set_event_force_page(tmpGM1ID,1)
	set_event_force_page(tmpGM2ID,1)
	set_event_force_page(tmpGM3ID,1)
	set_event_force_page(tmpQG1ID,1)
	set_event_force_page(tmpQG2ID,1)
	set_event_force_page(tmpQG3ID,1)
	#get_character(tmpGM1ID).npc_story_mode(true)
	#get_character(tmpGM2ID).npc_story_mode(true)
	#get_character(tmpGM3ID).npc_story_mode(true)
	#get_character(tmpQG1ID).npc_story_mode(true)
	#get_character(tmpQG2ID).npc_story_mode(true)
	#get_character(tmpQG3ID).npc_story_mode(true)
	get_character(tmpGM1ID).moveto(tmpCFX-1,tmpCFY)
	get_character(tmpGM2ID).moveto(tmpCFX,tmpCFY)
	get_character(tmpGM3ID).moveto(tmpCFX+1,tmpCFY)
#	get_character(tmpGM3ID).give_light("lantern")
#chcg_background_color(0,0,0,255,-7)
#call_msg("CompSeaWitch:0to1/begin0")
#get_character(tmpGM2ID).move_forward
#wait(20)
#call_msg("CompSeaWitch:0to1/begin1")
#get_character(tmpGM3ID).move_forward
#wait(20)
#call_msg("CompSeaWitch:0to1/begin2")
#get_character(tmpGM1ID).move_forward
#wait(20)
#call_msg("CompSeaWitch:0to1/begin3")
#wait(20)
#call_msg("CompSeaWitch:0to1/begin4")
#get_character(tmpGM1ID).move_forward
#get_character(tmpGM2ID).move_forward
#get_character(tmpGM3ID).move_forward
#wait(20)
#get_character(tmpGM1ID).move_forward
#get_character(tmpGM3ID).move_forward
#wait(20)
#get_character(tmpGM1ID).direction = 6
#get_character(tmpGM3ID).direction = 4
#call_msg("CompSeaWitch:0to1/begin5")
#SndLib.FishkindSmSpot
#wait(20)
#SndLib.sound_WaterSpla
#get_character(tmpQG1ID).moveto(tmpCFX,tmpCFY-10)
#get_character(tmpQG2ID).moveto(tmpCFX,tmpCFY-10)
#get_character(tmpQG3ID).moveto(tmpCFX,tmpCFY-10)
#get_character(tmpQG1ID).jump_to(tmpCFX,tmpCFY-1)
#get_character(tmpQG1ID).direction = 8
#get_character(tmpQG2ID).jump_to(tmpCFX+2,tmpCFY-2)
#get_character(tmpQG2ID).direction = 4
#get_character(tmpQG3ID).jump_to(tmpCFX-2,tmpCFY-2)
#get_character(tmpQG3ID).direction = 6
#wait(60)
#get_character(tmpGM1ID).direction = 4
#get_character(tmpGM2ID).direction = 2
#get_character(tmpGM3ID).direction = 6
#call_msg("CompSeaWitch:0to1/begin6")
#
#portrait_hide
#chcg_background_color(0,0,0,0,7)
	cam_center(0)
	portrait_off
	get_character(tmpGM1ID).setup_cropse_graphics(rand(3))
	get_character(tmpGM2ID).setup_cropse_graphics(rand(3))
	get_character(tmpGM3ID).setup_cropse_graphics(rand(3))
	get_character(tmpQG1ID).setup_cropse_graphics(rand(3))
	get_character(tmpQG2ID).setup_cropse_graphics(rand(3))
	get_character(tmpQG3ID).setup_cropse_graphics(rand(3))
	get_character(tmpGM1ID).through = true
	get_character(tmpGM2ID).through = true
	get_character(tmpGM3ID).through = true
	get_character(tmpQG1ID).through = true
	get_character(tmpQG2ID).through = true
	get_character(tmpQG3ID).through = true
	
	get_character(tmpGM1ID).moveto(tmpSWX-2,tmpSWY-1)
	get_character(tmpGM2ID).moveto(tmpSWX+3,tmpSWY-1)
	get_character(tmpGM3ID).moveto(tmpSWX,tmpSWY+1)
	
	#get_character(tmpGM1ID).npc_story_mode(false)
	#get_character(tmpGM2ID).npc_story_mode(false)
	#get_character(tmpGM3ID).npc_story_mode(false)
	#get_character(tmpQG1ID).npc_story_mode(false)
	#get_character(tmpQG2ID).npc_story_mode(false)
	#get_character(tmpQG3ID).npc_story_mode(false)
	#get_character(tmpGM3ID).drop_light
	

		
#		8.times{
#			SndLib.sound_combat_whoosh(60) if [true,false].sample
#			SndLib.sound_combat_sword_hit_sword(60) if [true,false].sample
#			SndLib.sound_gore(60) if [true,false].sample
#			SndLib.FishkindSmDed(60) if [true,false].sample
#			SndLib.sound_combat_hit_gore(70)
#			wait(20+rand(20))
#		}
#chcg_background_color(0,0,0,255,-7)
get_character(tmpSWID).call_balloon(28,-1)
#call_msg("CompSeaWitch:0to1/begin7")

eventPlayEnd
