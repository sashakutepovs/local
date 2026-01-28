return if $story_stats["Captured"] == 0

tmpMamaX,tmpMamaY,tmpMamaID = $game_map.get_storypoint("mama")
tmpPapaX,tmpPapaY,tmpPapaID = $game_map.get_storypoint("papa")
tmpSonX,tmpSonY,tmpSonID = $game_map.get_storypoint("son")
tmpMcX,tmpMcY,tmpMcID = $game_map.get_storypoint("MapCont")
tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUpSexBed")
tmpMaBedX,tmpMaBedY,tmpMaBedID = $game_map.get_storypoint("MamaBed")
tmpTorX,tmpTorY,tmpTorID = $game_map.get_storypoint("torturePT")

# 	@summon_data={
# 	:PapaRaped=>false,
# 	:Breakfast=>false,
# 	:Cooked=>false,
# 	:Clearned=>false,
# 	:Whored=>false
# 	}
tmpFamilyCount = 0
$game_map.npcs.each{|event|
	next unless event.summon_data
	next unless event.summon_data[:family]
	next if event.npc.action_state == :death
	next if event.deleted?
	tmpFamilyCount +=1
}

tmpPapaRaped	=	get_character(tmpMcID).summon_data[:PapaRaped]
tmpBreakfast	=	get_character(tmpMcID).summon_data[:Breakfast]
tmpWorked		=	get_character(tmpMcID).summon_data[:Worked]
tmpWorkType		=	get_character(tmpMcID).summon_data[:WorkType]
tmpNeedWork		=	get_character(tmpMcID).summon_data[:NeedWork]
tmpMerryed = $story_stats["RecQuestDoomFarmAWaifu"] == 1

#結婚
if tmpFamilyCount == 3 && $story_stats["Captured"] == 1 && !tmpMerryed
	rape_loop_drop_item(tmpEquip=true,tmpSummon=false,lostItem=true,keepInBox=true)
	portrait_hide
	$story_stats["RecQuestDoomFarmAWaifu"] = 1
	$game_player.moveto(tmpWakeUpX,tmpWakeUpY+1)
	$game_player.transparent = true
	get_character(tmpSonID).forced_x = -9
	get_character(tmpSonID).forced_y = -10
	cam_follow(tmpWakeUpID,0)
	#get_character(tmpSonID).character_index = 0
	#get_character(tmpMamaID).character_index = 0
	#get_character(tmpPapaID).character_index = 0
	get_character(tmpSonID).animation = nil
	get_character(tmpMamaID).animation = nil
	move_type_tmpMamaID = get_character(tmpMamaID).move_type
	move_type_tmpPapaID = get_character(tmpPapaID).move_type
	move_type_tmpSonID = get_character(tmpSonID).move_type
	get_character(tmpMamaID).npc_story_mode(true)
	get_character(tmpPapaID).npc_story_mode(true)
	get_character(tmpSonID).npc_story_mode(true)
	get_character(tmpMamaID).move_type = 0
	get_character(tmpPapaID).move_type = 0
	get_character(tmpSonID).move_type = 0
	set_event_force_page(tmpWakeUpID,1)
	tmp_mcw = get_character(tmpWakeUpID).manual_cw
	tmp_mch = get_character(tmpWakeUpID).manual_ch
	tmp_mcp = get_character(tmpWakeUpID).pattern
	tmp_mcd = get_character(tmpWakeUpID).direction
	get_character(tmpWakeUpID).manual_cw = 1 #canvas witdh(how many item in this PNG's witdh)
	get_character(tmpWakeUpID).manual_ch = 1 #canvas height(how many item in this PNG's height)
	get_character(tmpWakeUpID).pattern = 0 #force 0 because only 1x1
	get_character(tmpWakeUpID).direction = 2 #force to 2 because only 1x1
	get_character(tmpWakeUpID).character_index =0 #force 0 because only 1x1
	if ["Deepone","Moot"].include?($game_player.actor.stat["Race"])
		get_character(tmpWakeUpID).character_name = "LonaEXT/LonaMootBondageOnBed.png"
	else
		get_character(tmpWakeUpID).character_name = "LonaEXT/LonaBondageOnBed.png"
	end
	get_character(tmpWakeUpID).chs_need_update=true
	get_character(tmpMamaID).moveto(tmpWakeUpX,tmpWakeUpY+2)
	get_character(tmpPapaID).moveto(tmpWakeUpX-1,tmpWakeUpY+2)
	get_character(tmpSonID).moveto(tmpWakeUpX-1,tmpWakeUpY)
	get_character(tmpMamaID).direction = 8
	get_character(tmpPapaID).direction = 8
	get_character(tmpSonID).direction = 2
	
	call_msg("TagMapDoomFarmA:merry/begin_0")
	chcg_background_color(0,0,0,255,-4)
	get_character(tmpWakeUpID).call_balloon(8)
	wait(60)
	call_msg("TagMapDoomFarmA:merry/begin_1")
	get_character(tmpSonID).direction = 6
	call_msg("TagMapDoomFarmA:merry/begin_2")
	portrait_off
	get_character(tmpSonID).move_forward
	wait(75)
	get_character(tmpSonID).direction = 8
	wait(10)
	3.times{
		$game_player.actor.stat["EventVagRace"] =  "Human"
		$game_player.actor.stat["EventVag"] = "Snuff"
		lona_mood "p5shame"
		$game_player.actor.portrait.update
		load_script("Data/Batch/harassment_frame_VagLick.rb")
		wait(50)
			get_character(tmpSonID).forced_y -=2
		wait(8)
			get_character(tmpSonID).forced_y +=2
		wait(2)
		check_over_event
	}
	half_event_key_cleaner
	call_msg("TagMapDoomFarmA:merry/begin_3")
	
	
	$game_player.moveto(tmpWakeUpX,tmpWakeUpY-1)
	get_character(tmpWakeUpID).manual_cw = tmp_mcw
	get_character(tmpWakeUpID).manual_ch = tmp_mch
	get_character(tmpWakeUpID).pattern   = tmp_mcp
	get_character(tmpWakeUpID).direction = tmp_mcd
	set_event_force_page(tmpWakeUpID,2)
	$game_player.transparent = false
	$game_player.forced_x = get_character(tmpSonID).forced_x
	$game_player.forced_y = get_character(tmpSonID).forced_y
	cam_center(0)
	
	portrait_off
	play_sex_service_main(ev_target=get_character(tmpSonID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2)
	half_event_key_cleaner
	play_sex_service_main(ev_target=get_character(tmpSonID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2)
	portrait_off
	call_msg("TagMapDoomFarmA:merry/begin_4")
	half_event_key_cleaner
	get_character(tmpPapaID).animation = get_character(tmpPapaID).animation_masturbation if rand(100) >= 50
	portrait_off
	play_sex_service_main(ev_target=get_character(tmpSonID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2)
	half_event_key_cleaner
	play_sex_service_main(ev_target=get_character(tmpSonID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2)
	half_event_key_cleaner
	play_sex_service_main(ev_target=get_character(tmpSonID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2)
	portrait_off
	call_msg("TagMapDoomFarmA:merry/begin_5")
	portrait_off
	$game_player.actor.stat["EventVagRace"] =  "Human"
	$game_player.actor.stat["EventVag"] = "CumInside1"
	load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
	portrait_off
	$game_player.force_update = false
	call_msg("TagMapDoomFarmA:merry/begin_6")
	portrait_off
	get_character(tmpMamaID).move_forward_force
	until !get_character(tmpMamaID).moving?
		wait(1)
	end
	get_character(tmpMamaID).forced_z = 4
	get_character(tmpMamaID).move_forward_force
	get_character(tmpMamaID).call_balloon(5)
	until !get_character(tmpMamaID).moving?
		wait(1)
	end
	get_character(tmpMamaID).animation = get_character(tmpMamaID).animation_atk_hook_hold
	SndLib.sound_equip_armor(90)
	SndLib.sound_chs_buchu(125)
	wait(10)
	portrait_off
	call_msg("TagMapDoomFarmA:merry/begin_7")
	$game_player.actor.stat["EventVagRace"] =  "Human"
	$game_player.actor.stat["EventVag"] = "CumInside1"
	$game_player.force_update = true
	load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
	$game_player.force_update = false
	portrait_off
	call_msg("TagMapDoomFarmA:merry/begin_8")
	portrait_off
	$game_player.actor.stat["EventVagRace"] =  "Human"
	$game_player.actor.stat["EventVag"] = "CumInside1"
	$game_player.force_update = true
	load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
	$game_player.force_update = false
	$game_player.actor.addCums("CumsCreamPie",1000,"Human")
	get_character(tmpMamaID).animation = nil
	portrait_off
	$game_player.force_update = false
	call_msg("TagMapDoomFarmA:merry/begin_9")
	portrait_off
	$game_player.force_update = true
	
	#unset_event_chs_sex
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		cam_center(0)
		$game_player.force_update = true
		$game_player.direction = 2
		$game_player.actor.set_action_state(:none)
		$game_player.unset_event_chs_sex
		get_character(tmpSonID).unset_event_chs_sex
		get_character(tmpMamaID).animation = nil
		get_character(tmpPapaID).animation = nil
		get_character(tmpMamaID).moveto(tmpMamaX,tmpMamaY)
		get_character(tmpMamaID).moveto(tmpMaBedX,tmpMaBedY) if $game_date.night?
		get_character(tmpPapaID).moveto(tmpPapaX,tmpPapaY)
		get_character(tmpSonID).moveto(tmpSonX,tmpSonY)
		get_character(tmpSonID).moveto(tmpWakeUpX,tmpWakeUpY-1) if $game_date.night?
		get_character(tmpMamaID).npc_story_mode(false)
		get_character(tmpPapaID).npc_story_mode(false)
		get_character(tmpSonID).npc_story_mode(false)
		get_character(tmpMamaID).move_type = move_type_tmpMamaID
		get_character(tmpPapaID).move_type = move_type_tmpPapaID
		get_character(tmpSonID).move_type = move_type_tmpSonID
		get_character(tmpMamaID).direction = 2
		get_character(tmpPapaID).direction = 2
		get_character(tmpSonID).direction = 2
		get_character(tmpMamaID).forced_z = 0
		$game_player.forced_x = 0
		$game_player.forced_y = 0
		get_character(tmpSonID).forced_x = 0
		get_character(tmpSonID).forced_y = 0
	chcg_background_color(0,0,0,255,-7)
	get_character(tmpMcID).summon_data[:Breakfast] = true
	get_character(tmpMcID).summon_data[:Worked] = true
	get_character(tmpMcID).summon_data[:NeedWork] = false
	
#bobo Killed everyone 嘴炮烙娜
elsif tmpFamilyCount == 3 && $story_stats["Captured"] == 1 && get_character(tmpMcID).summon_data[:BoboKill] && $game_date.night?
	call_msg("TagMapDoomFarmA:son/Capture_Kill0")
	portrait_off
	$game_map.npcs.each{
	|event|
		next unless event.summon_data
		next unless event.summon_data[:family]
		next if event.npc.action_state == :death
		next if event.deleted?
		event.npc.stat.set_stat("health",-300)
		if event.summon_data[:son]
			event.npc.stat.set_stat("health",-1)
			event.npc.stat.set_stat("sta",-99)
		end
		event.npc.refresh
	}
	wait(60)
	$game_player.moveto(tmpWakeUpX,tmpWakeUpY)
	$game_player.direction = 2
	get_character(tmpSonID).moveto(tmpWakeUpX,tmpWakeUpY+1)
	get_character(tmpSonID).direction = 8
	chcg_background_color(0,0,0,255,-4)
	call_msg("TagMapDoomFarmA:son/Capture_Kill1")
	get_character(tmpSonID).npc.stat.set_stat("health",-1)
	get_character(tmpSonID).npc.refresh
	

#強制精液注入
elsif tmpFamilyCount == 3 && $story_stats["Captured"] == 1 && tmpMerryed && $game_player.actor.getDisplayCumsAmt["vag"] < 600
	portrait_hide
	$story_stats["Captured"] = 1
	$story_stats["RapeLoop"] = 1
	$story_stats["RecQuestDoomFarmAWaifu"] = 1
	$game_player.moveto(tmpWakeUpX,tmpWakeUpY+1)
	$game_player.transparent = true
	cam_follow(tmpWakeUpID,0)
	get_character(tmpSonID).forced_x = -9
	get_character(tmpSonID).forced_y = -10
	get_character(tmpSonID).animation = nil
	get_character(tmpMamaID).animation = nil
	move_type_tmpMamaID = get_character(tmpMamaID).move_type
	move_type_tmpPapaID = get_character(tmpPapaID).move_type
	move_type_tmpSonID = get_character(tmpSonID).move_type
	get_character(tmpMamaID).npc_story_mode(true)
	get_character(tmpPapaID).npc_story_mode(true)
	get_character(tmpSonID).npc_story_mode(true)
	get_character(tmpMamaID).move_type = 0
	get_character(tmpPapaID).move_type = 0
	get_character(tmpSonID).move_type = 0
	set_event_force_page(tmpWakeUpID,1)
	tmp_mcw = get_character(tmpWakeUpID).manual_cw
	tmp_mch = get_character(tmpWakeUpID).manual_ch
	tmp_mcp = get_character(tmpWakeUpID).pattern
	tmp_mcd = get_character(tmpWakeUpID).direction
	get_character(tmpWakeUpID).manual_cw = 1 #canvas witdh(how many item in this PNG's witdh)
	get_character(tmpWakeUpID).manual_ch = 1 #canvas height(how many item in this PNG's height)
	get_character(tmpWakeUpID).pattern = 0 #force 0 because only 1x1
	get_character(tmpWakeUpID).direction = 2 #force to 2 because only 1x1
	get_character(tmpWakeUpID).character_index =0 #force 0 because only 1x1
	if ["Deepone","Moot"].include?($game_player.actor.stat["Race"])
		get_character(tmpWakeUpID).character_name = "LonaEXT/LonaMootBondageOnBed.png"
	else
		get_character(tmpWakeUpID).character_name = "LonaEXT/LonaBondageOnBed.png"
	end
	get_character(tmpMamaID).moveto(tmpWakeUpX,tmpWakeUpY+2)
	get_character(tmpPapaID).moveto(tmpWakeUpX-1,tmpWakeUpY+2)
	get_character(tmpSonID).moveto(tmpWakeUpX-1,tmpWakeUpY)
	get_character(tmpMamaID).direction = 8
	get_character(tmpPapaID).direction = 8
	get_character(tmpSonID).direction = 6
	
	call_msg("TagMapDoomFarmA:SemenCheck/begin_0")
	chcg_background_color(0,0,0,255,-4)
	get_character(tmpWakeUpID).call_balloon(8)
	call_msg("TagMapDoomFarmA:SemenCheck/begin_1")
	get_character(tmpSonID).direction = 6
	get_character(tmpSonID).move_forward
	wait(75)
	get_character(tmpSonID).direction = 8
	wait(10)
	call_msg("TagMapDoomFarmA:SemenCheck/begin_1")
	$game_player.moveto(tmpWakeUpX,tmpWakeUpY-1)
	get_character(tmpWakeUpID).manual_cw = tmp_mcw
	get_character(tmpWakeUpID).manual_ch = tmp_mch
	get_character(tmpWakeUpID).pattern   = tmp_mcp
	get_character(tmpWakeUpID).direction = tmp_mcd
	set_event_force_page(tmpWakeUpID,2)
	$game_player.transparent = false
	$game_player.forced_x = get_character(tmpSonID).forced_x
	$game_player.forced_y = get_character(tmpSonID).forced_y
	cam_center(0)
	
	portrait_off
	play_sex_service_main(ev_target=get_character(tmpSonID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2)
	play_sex_service_main(ev_target=get_character(tmpSonID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2)
	portrait_off
	call_msg("TagMapDoomFarmA:SemenCheck/begin_3")
	portrait_off
	$game_player.actor.stat["EventVagRace"] =  "Human"
	$game_player.actor.stat["EventVag"] = "CumInside1"
	load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
	$game_player.force_update = false
	portrait_off
	call_msg("TagMapDoomFarmA:SemenCheck/begin_4")
	portrait_off
	get_character(tmpPapaID).animation = get_character(tmpPapaID).animation_masturbation if rand(100) >= 50
	$game_player.force_update = true
	play_sex_service_main(ev_target=get_character(tmpSonID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2)
	play_sex_service_main(ev_target=get_character(tmpSonID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2)
	play_sex_service_main(ev_target=get_character(tmpSonID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=2)
	portrait_off
	call_msg("TagMapDoomFarmA:SemenCheck/begin_3")
	portrait_off
	$game_player.actor.stat["EventVagRace"] =  "Human"
	$game_player.actor.stat["EventVag"] = "CumInside1"
	load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
	$game_player.actor.addCums("CumsCreamPie",1000,"Human")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		cam_center(0)
		$game_player.force_update = true
		$game_player.direction = 2
		$game_player.actor.set_action_state(:none)
		$game_player.unset_event_chs_sex
		get_character(tmpSonID).unset_event_chs_sex
		get_character(tmpMamaID).animation = nil
		get_character(tmpPapaID).animation = nil
		get_character(tmpMamaID).moveto(tmpMamaX,tmpMamaY)
		get_character(tmpMamaID).moveto(tmpMaBedX,tmpMaBedY) if $game_date.night?
		get_character(tmpPapaID).moveto(tmpPapaX,tmpPapaY)
		get_character(tmpSonID).moveto(tmpSonX,tmpSonY)
		get_character(tmpSonID).moveto(tmpWakeUpX,tmpWakeUpY) if $game_date.night?
		get_character(tmpMamaID).npc_story_mode(false)
		get_character(tmpPapaID).npc_story_mode(false)
		get_character(tmpSonID).npc_story_mode(false)
		get_character(tmpMamaID).move_type = move_type_tmpMamaID
		get_character(tmpPapaID).move_type = move_type_tmpPapaID
		get_character(tmpSonID).move_type = move_type_tmpSonID
		get_character(tmpMamaID).direction = 2
		get_character(tmpPapaID).direction = 2
		get_character(tmpSonID).direction = 2
		get_character(tmpMamaID).direction = 2
		get_character(tmpPapaID).direction = 2
		get_character(tmpSonID).direction = 2
		get_character(tmpMamaID).forced_z = 0
	chcg_background_color(0,0,0,255,-7)
	get_character(tmpMcID).summon_data[:NeedWork] = true
	
#工作未完成處罰 todo +#偷情處罰 todo
elsif tmpFamilyCount == 3 && $story_stats["Captured"] == 1 && tmpMerryed && ($story_stats["RapeLoopTorture"] == 1 || tmpPapaRaped)
	$story_stats["Captured"] = 1
	$story_stats["RapeLoop"] = 1
	$story_stats["RapeLoopTorture"] = 0
	$game_player.transparent = true
	portrait_off
	$story_stats["RecQuestDoomFarmAWaifu"] = 1
	$game_player.moveto(1,1)
	$game_player.direction = 2
	cam_follow(tmpTorID,0)
	get_character(tmpSonID).animation = nil
	get_character(tmpMamaID).animation = nil
	move_type_tmpMamaID = get_character(tmpMamaID).move_type
	move_type_tmpPapaID = get_character(tmpPapaID).move_type
	move_type_tmpSonID = get_character(tmpSonID).move_type
	get_character(tmpMamaID).npc_story_mode(true)
	get_character(tmpPapaID).npc_story_mode(true)
	get_character(tmpSonID).npc_story_mode(true)
	get_character(tmpMamaID).move_type = 0
	get_character(tmpPapaID).move_type = 0
	get_character(tmpSonID).move_type = 0
	set_event_force_page(tmpTorID,1)
	#tmp_mcw = get_character(tmpWakeUpID).manual_cw
	#tmp_mch = get_character(tmpWakeUpID).manual_ch
	#tmp_mcp = get_character(tmpWakeUpID).pattern
	#tmp_mcd = get_character(tmpWakeUpID).direction
	#get_character(tmpWakeUpID).manual_cw = 1 #canvas witdh(how many item in this PNG's witdh)
	#get_character(tmpWakeUpID).manual_ch = 1 #canvas height(how many item in this PNG's height)
	#get_character(tmpWakeUpID).pattern = 0 #force 0 because only 1x1
	#get_character(tmpWakeUpID).direction = 2 #force to 2 because only 1x1
	#get_character(tmpWakeUpID).character_index =0 #force 0 because only 1x1
	#if ["Deepone","Moot"].include?($game_player.actor.stat["Race"])
	#	get_character(tmpWakeUpID).character_name = "LonaEXT/LonaMootBondageOnBed.png"
	#else
	#	get_character(tmpWakeUpID).character_name = "LonaEXT/LonaBondageOnBed.png"
	#end
	get_character(tmpMamaID).moveto(tmpTorX,tmpTorY+2)
	get_character(tmpPapaID).moveto(tmpTorX-1,tmpTorY+2)
	get_character(tmpSonID).moveto(tmpTorX+1,tmpTorY+2)
	get_character(tmpMamaID).direction = 8
	get_character(tmpPapaID).direction = 8
	get_character(tmpSonID).direction = 8
	if get_character(tmpMcID).summon_data[:PapaRaped] #todo basic torture dialog (raped by papa or not)
		call_msg("TagMapDoomFarmA:Torture/begin_0_PapaRaped")
	else
		call_msg("TagMapDoomFarmA:Torture/begin_0_Basic")
	end
	call_msg("TagMapDoomFarmA:Torture/begin_2")
	chcg_background_color(0,0,0,255,-4)
	get_character(tmpMamaID).move_forward
	call_msg("TagMapDoomFarmA:Torture/begin_3")
	portrait_hide
	
	load_script("Data/Batch/whip_add_body_wound.rb")
	$game_player.actor.health -= 1+rand(2)
	get_character(tmpMamaID).animation = get_character(tmpMamaID).animation_atk_whip
	SndLib.sound_hit_whip
	lona_mood "p5health_damage"
	$game_portraits.rprt.shake
	wait(55+rand(10))
	call_msg("TagMapDoomFarmA:Torture/begin_4")
	load_script("Data/Batch/whip_add_body_wound.rb")
	$game_player.actor.health -= 1+rand(2)
	get_character(tmpMamaID).animation = get_character(tmpMamaID).animation_atk_whip
	SndLib.sound_hit_whip
	lona_mood "p5health_damage"
	$game_portraits.rprt.shake
	get_character(tmpPapaID).animation = get_character(tmpPapaID).animation_masturbation if rand(100) >= 50
	wait(55+rand(10))
	load_script("Data/Batch/whip_add_body_wound.rb")
	$game_player.actor.health -= 1+rand(2)
	get_character(tmpMamaID).animation = get_character(tmpMamaID).animation_atk_whip
	SndLib.sound_hit_whip
	lona_mood "p5health_damage"
	$game_portraits.rprt.shake
	wait(55+rand(10))
	call_msg("TagMapDoomFarmA:Torture/begin_5")
	load_script("Data/Batch/whip_add_body_wound.rb")
	$game_player.actor.health -= 1+rand(2)
	get_character(tmpMamaID).animation = get_character(tmpMamaID).animation_atk_whip
	SndLib.sound_hit_whip
	lona_mood "p5health_damage"
	$game_portraits.rprt.shake
	wait(55+rand(10))
	call_msg("TagMapDoomFarmA:Torture/begin_6")
	chcg_background_color(0,0,0,0,7)
		lona_mood "p5health_damage"
		$game_portraits.rprt.shake
		SndLib.sound_hit_whip
		wait(55+rand(10))
		lona_mood "p5health_damage"
		$game_portraits.rprt.shake
		SndLib.sound_hit_whip
		wait(55+rand(10))
		lona_mood "p5health_damage"
		$game_portraits.rprt.shake
		SndLib.sound_hit_whip
		wait(55+rand(10))
		cam_center(0)
		$game_player.moveto(tmpWakeUpX,tmpWakeUpY)
		$game_player.transparent = false
		#get_character(tmpWakeUpID).manual_cw = tmp_mcw
		#get_character(tmpWakeUpID).manual_ch = tmp_mch
		#get_character(tmpWakeUpID).pattern   = tmp_mcp
		#get_character(tmpWakeUpID).direction = tmp_mcd
		set_event_force_page(tmpTorID,2)
		get_character(tmpMamaID).animation = nil
		get_character(tmpPapaID).animation = nil
		get_character(tmpMamaID).moveto(tmpMamaX,tmpMamaY)
		get_character(tmpMamaID).moveto(tmpMaBedX,tmpMaBedY) if $game_date.night?
		get_character(tmpPapaID).moveto(tmpPapaX,tmpPapaY)
		get_character(tmpSonID).moveto(tmpSonX,tmpSonY)
		get_character(tmpSonID).moveto(tmpWakeUpX,tmpWakeUpY) if $game_date.night?
		get_character(tmpMamaID).npc_story_mode(false)
		get_character(tmpPapaID).npc_story_mode(false)
		get_character(tmpSonID).npc_story_mode(false)
		get_character(tmpMamaID).move_type = move_type_tmpMamaID
		get_character(tmpPapaID).move_type = move_type_tmpPapaID
		get_character(tmpSonID).move_type = move_type_tmpSonID
		get_character(tmpMamaID).direction = 2
		get_character(tmpPapaID).direction = 2
		get_character(tmpSonID).direction = 2
	chcg_background_color(0,0,0,255,-7)
	get_character(tmpMcID).summon_data[:PapaRaped] = false
	get_character(tmpMcID).summon_data[:NeedWork] = true
	
#全工作完成 胖胖的每日強暴
elsif tmpFamilyCount == 3 && $story_stats["Captured"] == 1 && tmpNeedWork && tmpMerryed && $story_stats["RapeLoopTorture"] == 0 && rand(100) > 50
	$game_player.actor.record_lona_title = "Rapeloop/DoomFarmA"
	$story_stats["Captured"] = 1
	$story_stats["RapeLoop"] = 1
	get_character(tmpSonID).animation = nil
	portrait_hide
	#chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpSonID).npc_story_mode(true)
		tmp_SonMtype = get_character(tmpSonID).move_type
		get_character(tmpSonID).moveto($game_player.x,$game_player.y)
		get_character(tmpSonID).move_type = 0
		get_character(tmpSonID).item_jump_to
		get_character(tmpSonID).turn_toward_character($game_player)
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapDoomFarmA:DailyRapeWake/begin#{rand(3)}")

	SndLib.sound_equip_armor
	$game_player.animation = $game_player.animation_grabbed_qte
	get_character(tmpSonID).animation = get_character(tmpSonID).animation_hold_shield
	get_character(tmpSonID).call_balloon(1)
	$game_player.actor.stat["EventExt1Race"] = "Human"
	load_script("Data/HCGframes/Grab_EventExt1_Grab.rb")
	call_msg("commonH:Lona/grab#{talk_style}#{rand(3)}")
	get_character(tmpSonID).moveto($game_player.x,$game_player.y)
	portrait_hide
	get_character(tmpSonID).move_type = tmp_SonMtype
	play_sex_service_menu(get_character(tmpSonID),0,nil,true)
	get_character(tmpSonID).npc_story_mode(false)
	$game_player.actor.stat["EventExt1Race"] = "Human"
	load_script("Data/Batch/common_MCtorture_DoomFarmABobo.rb") if rand(100) > 70
	whole_event_end
	portrait_off
	call_msg("TagMapDoomFarmA:DailyRapeEnd/Begin#{rand(3)}")
	cam_center(0)
	
	chcg_background_color(0,0,0,0,7)
		get_character(tmpSonID).moveto(tmpSonX,tmpSonY)
		get_character(tmpSonID).moveto(tmpWakeUpX,tmpWakeUpY) if $game_date.night?
	chcg_background_color(0,0,0,255,-7)
	get_character(tmpMcID).summon_data[:NeedWork] = true
end

#晚上不用工作
if $game_date.day? && tmpNeedWork
	get_character(tmpMcID).summon_data[:Breakfast] = true
	get_character(tmpMcID).summon_data[:Worked] = true
	get_character(tmpMcID).summon_data[:WorkType] = nil
else
	get_character(tmpMcID).summon_data[:Breakfast] = false
	get_character(tmpMcID).summon_data[:Worked] = false
	get_character(tmpMcID).summon_data[:WorkType] = nil
end

portrait_hide
cam_center(0)


