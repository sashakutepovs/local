
######################################## begin event ###############################################################
if $story_stats["Captured"] == 1 && $story_stats["ReRollHalfEvents"] == 1
	tmpWarX,tmpWarY,tmpWarID=$game_map.get_storypoint("Warden")
	tmpTorX,tmpTorY,tmpTorID=$game_map.get_storypoint("Torturer")
	tmpDorX,tmpDorY,tmpDorID=$game_map.get_storypoint("doorTopB")
	tmpRap1X,tmpRap1Y,tmpRap1ID=$game_map.get_storypoint("RaperTop")
	tmpRap2X,tmpRap2Y,tmpRap2ID=$game_map.get_storypoint("RaperBot")
	tmpRap3X,tmpRap3Y,tmpRap3ID=$game_map.get_storypoint("RaperLeft")
	tmpRap4X,tmpRap4Y,tmpRap4ID=$game_map.get_storypoint("RaperRight")
	portrait_hide
	
	
	get_character(tmpRap1ID).moveto(tmpDorX,tmpDorY-1)
	get_character(tmpRap2ID).moveto(tmpDorX-1,tmpDorY-1)
	get_character(tmpRap3ID).moveto(tmpDorX-2,tmpDorY-1)
	get_character(tmpRap4ID).moveto(tmpDorX-4,tmpDorY-1)
	
	get_character(tmpRap1ID).direction = 2
	get_character(tmpRap2ID).direction = 2
	get_character(tmpRap3ID).direction = 2
	get_character(tmpRap4ID).direction = 2
	
	
	
	get_character(tmpWarID).moveto(tmpDorX+1,tmpDorY+1)
	get_character(tmpTorID).moveto(tmpDorX-1,tmpDorY+1)
	$game_player.moveto(tmpDorX,tmpDorY+1)
	get_character(tmpWarID).direction = 4
	get_character(tmpTorID).direction = 4
	$game_player.direction = 4
	get_character(tmpWarID).npc_story_mode(true)
	get_character(tmpTorID).npc_story_mode(true)
	portrait_hide
	$game_map.interpreter.chcg_background_color(0,0,0,255,-7)
		portrait_off
		call_msg("TagMapNoerPrison:Enter/begin1")
		portrait_hide
		wait(60)
		get_character(tmpWarID).move_forward
		get_character(tmpTorID).move_forward
		$game_player.move_forward
		wait(60)
		call_msg("TagMapNoerPrison:Enter/begin2")
		portrait_hide
		get_character(tmpWarID).move_forward
		get_character(tmpTorID).move_forward
		$game_player.move_forward
		wait(60)
		call_msg("TagMapNoerPrison:Enter/begin3")
		portrait_hide
		get_character(tmpWarID).move_forward
		get_character(tmpTorID).move_forward
		$game_player.move_forward
		wait(60)
		call_msg("TagMapNoerPrison:Enter/begin4")
		portrait_hide
		get_character(tmpWarID).move_forward
		get_character(tmpTorID).move_forward
		$game_player.move_forward
		wait(60)
		get_character(tmpWarID).direction = 8
		get_character(tmpTorID).direction = 8
		$game_player.direction = 8
		call_msg("TagMapNoerPrison:Enter/begin5")
		call_msg("TagMapNoerPrison:Enter/end")
		portrait_hide
	$game_map.interpreter.chcg_background_color(0,0,0,0,7)
	portrait_off
	$game_temp.choice = -1
	get_character(tmpWarID).moveto(tmpWarX,tmpWarY)
	get_character(tmpTorID).moveto(tmpTorX,tmpTorY)
	get_character(tmpWarID).npc_story_mode(false)
	get_character(tmpTorID).npc_story_mode(false)
end


######################################## Food event ###############################################################
if $story_stats["Captured"] == 1 && $story_stats["ReRollHalfEvents"] ==0 && $game_date.day? # && $story_stats["RapeLoopTorture"] !=1
	tmpA_X,tmpA_Y,tmpA_ID=$game_map.get_storypoint("doorTopA")
	tmpB_X,tmpB_Y,tmpB_ID=$game_map.get_storypoint("doorTopB")
	tmpC_X,tmpC_Y,tmpC_ID=$game_map.get_storypoint("doorTopC")
	tmpD_X,tmpD_Y,tmpD_ID=$game_map.get_storypoint("doorTopD")
	tmpE_X,tmpE_Y,tmpE_ID=$game_map.get_storypoint("CapturedPoint")
	tmpF_X,tmpF_Y,tmpF_ID=$game_map.get_storypoint("SexPoint1")
	tmpG_X,tmpG_Y,tmpG_ID=$game_map.get_storypoint("SexPoint2")
	tmpH_X,tmpH_Y,tmpH_ID=$game_map.get_storypoint("SexPoint3")
	call_msg("TagMapNoerPrison:Warden/PlaceFood0")
	call_msg("TagMapNoerPrison:Warden/PlaceFood1")
	$game_map.reserve_summon_event("ItemBread",tmpA_X,tmpA_Y-1) 
	$game_map.reserve_summon_event("ItemBread",tmpB_X,tmpB_Y-1) 
	$game_map.reserve_summon_event("ItemBread",tmpC_X,tmpC_Y-1) 
	$game_map.reserve_summon_event("ItemBread",tmpD_X,tmpD_Y-1) 
	$game_map.reserve_summon_event("ItemBread",tmpE_X,tmpE_Y-1) if rand(100) >50
	$game_map.reserve_summon_event("ItemBread",tmpF_X,tmpF_Y-1) if rand(100) >50
	$game_map.reserve_summon_event("ItemBread",tmpG_X,tmpG_Y-1) if rand(100) >50
	$game_map.reserve_summon_event("ItemBread",tmpH_X,tmpH_Y-1) if rand(100) >50
end


#######################################################  RapeLoopTorture  #######################################################
if $story_stats["Captured"] == 1 && $story_stats["RapeLoopTorture"] ==1
	chcg_background_color(0,0,0,255,255)
	$game_player.opacity = 0
	$story_stats["RapeLoopTorture"] =0
	#setup
	tortX,tortY,tortID=$game_map.get_storypoint("Torturer")
	warX,warY,warID=$game_map.get_storypoint("Warden")
	tor2X,tor2Y,tor2ID=$game_map.get_storypoint("Torture2")
	Rap1X,Rap1Y,Rap1ID=$game_map.get_storypoint("RaperTop")
	Rap2X,Rap2Y,Rap2ID=$game_map.get_storypoint("RaperBot")
	Rap3X,Rap3Y,Rap3ID=$game_map.get_storypoint("RaperLeft")
	Rap4X,Rap4Y,Rap4ID=$game_map.get_storypoint("RaperRight")
	extTX,extTY,extTID=$game_map.get_storypoint("ExitToilet")
	get_character(Rap1ID).moveto(tor2X,tor2Y-3)
	get_character(Rap2ID).moveto(tor2X+1,tor2Y-3)
	get_character(Rap3ID).moveto(tor2X+2,tor2Y-3)
	get_character(Rap4ID).moveto(tor2X-1,tor2Y-3)
	get_character(tortID).moveto(tor2X-1,tor2Y)
	get_character(warID).moveto(tor2X+1,tor2Y)
	get_character(tortID).direction = 6
	get_character(warID).direction = 4
	get_character(tortID).npc_story_mode(true)
	get_character(warID).npc_story_mode(true)
	set_event_force_page(tor2ID,1,0)
	cam_follow(tor2ID,0)
	
	combat_remove_random_equip(0)
	combat_remove_random_equip(1)
	combat_remove_random_equip(2)
	combat_remove_random_equip(3)
	combat_remove_random_equip(4)
	combat_remove_random_equip(5)
	combat_remove_random_equip(6)
	combat_remove_random_equip(7)
	combat_remove_random_equip(8)
	combat_remove_random_equip(9)
	rape_loop_drop_item(false,false)
	
	call_msg("TagMapNoerPrison:Warden/torture1")
	$game_map.interpreter.chcg_background_color(0,0,0,255,-7)

	call_msg("TagMapNoerPrison:Warden/torture2")
	load_script("Data/Batch/whip_add_body_wound.rb")
	$game_actors[1].health -= 1+rand(2)
	$game_map.popup(tor2ID,"TagMapNoerPrison:Torture2/popup#{rand(3)}",0,0)
	get_character(tortID).animation = get_character(tortID).animation_atk_whip
	wait(60)
	load_script("Data/Batch/whip_add_body_wound.rb")
	$game_actors[1].health -= 1+rand(2)
	$game_map.popup(tor2ID,"TagMapNoerPrison:Torture2/popup#{rand(3)}",0,0)
	get_character(tortID).animation = get_character(tortID).animation_atk_whip
	wait(60)
	load_script("Data/Batch/whip_add_body_wound.rb")
	$game_actors[1].health -= 1+rand(2)
	$game_map.popup(tor2ID,"TagMapNoerPrison:Torture2/popup#{rand(3)}",0,0)
	get_character(tortID).animation = get_character(tortID).animation_atk_whip
	wait(60)

	$game_map.interpreter.chcg_background_color(0,0,0,0,7)
	call_msg("TagMapNoerPrison:Warden/torture_end0")
	load_script("Data/Batch/whip_add_body_wound.rb")
	$game_actors[1].health -= 1+rand(2)
	get_character(tortID).animation = get_character(tortID).animation_atk_whip
	wait(60)
	$game_actors[1].health -= 1+rand(2)
	get_character(tortID).animation = get_character(tortID).animation_atk_whip
	wait(60)
	$game_actors[1].health -= 1+rand(2)
	get_character(tortID).animation = get_character(tortID).animation_atk_whip
	wait(60)
	call_msg("TagMapNoerPrison:Warden/torture_end1")
	SndLib.sound_equip_armor
	call_msg("TagMapNoerPrison:Warden/torture_end2")
	portrait_hide
	get_character(tortID).moveto(tortX,tortY)
	get_character(warID).moveto(warX,warY)
	get_character(tortID).npc_story_mode(false)
	get_character(warID).npc_story_mode(false)
	set_event_force_page(tor2ID,4,0)
				get_character(tor2ID).manual_cw = 3 #canvas witdh(how many item in this PNG's witdh)
				get_character(tor2ID).manual_ch = 1 #canvas height(how many item in this PNG's height)
				get_character(tor2ID).pattern = 0 #force 0 because only 1x1
				get_character(tor2ID).direction = 2 #force to 2 because only 1x1
				get_character(tor2ID).character_index =0 #force 0 because only 1x1
				if ["Deepone","Moot"].include?($game_player.actor.stat["Race"])
					get_character(tor2ID).character_name = "LonaEXT/WoodenBondageMoot.png"
				else
					get_character(tor2ID).character_name = "LonaEXT/WoodenBondage.png"
				end
				get_character(tor2ID).chs_need_update=true
	cam_center(0)
	#get_character(extTID).switch1_id = 1
	$game_player.opacity = 255
	#torture
end
