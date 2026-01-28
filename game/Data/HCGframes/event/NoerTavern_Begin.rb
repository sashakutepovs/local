if $story_stats["RecQuestCocona"] == 26 && $story_stats["UniqueCharUniqueCocona"] != -1 &&  $story_stats["UniqueCharUniqueTavernWaifu"] != -1
	tmpStartPointX,tmpStartPointY,tmpStartPointID=$game_map.get_storypoint("StartPoint")
	tmpTavernWaifuX,tmpTavernWaifuY,tmpTavernWaifuID=$game_map.get_storypoint("TavernWaifu")
	tmpUniqueCoconaX,tmpUniqueCoconaY,tmpUniqueCoconaID=$game_map.get_storypoint("UniqueCocona")
	get_character(tmpUniqueCoconaID).opacity = 0
	get_character(tmpTavernWaifuID).opacity = 0
end
tmpLP = RPG::BGM.last.pos
SndLib.bgm_play("TavernD_Highland_Holdfast",40,125,tmpLP) if $game_date.day?
SndLib.bgm_play("TavernD_Highland_Holdfast",40,100,tmpLP) if $game_date.night?
SndLib.bgs_play("AMBIENCE_Public_Hall_Chatter_01_loop_stereo",50,100)
$game_map.shadows.set_color(120, 90, 70) if $game_date.day?
$game_map.shadows.set_opacity(120) if $game_date.day?
$game_map.shadows.set_color(50, 70, 160) if $game_date.night?
$game_map.shadows.set_opacity(160) if $game_date.night?
$game_map.interpreter.map_background_color
fadeout=$story_stats["ReRollHalfEvents"] == 1
enter_static_tag_map(nil,fadeout)
if $game_player.record_companion_name_ext != nil
 summon_companion(tmpX=$game_player.x,tmpY=$game_player.y,false,-1)
end
$story_stats["LimitedNeedsSkill"] =1
$story_stats["InNoerTavern2F"] =0
eventPlayEnd
################################################################## 給予可可娜票
if $story_stats["RecQuestCocona"] == 26 && $story_stats["UniqueCharUniqueCocona"] != -1 &&  $story_stats["UniqueCharUniqueTavernWaifu"] != -1
	tmpStartPointX,tmpStartPointY,tmpStartPointID=$game_map.get_storypoint("StartPoint")
	tmpTavernWaifuX,tmpTavernWaifuY,tmpTavernWaifuID=$game_map.get_storypoint("TavernWaifu")
	tmpUniqueCoconaX,tmpUniqueCoconaY,tmpUniqueCoconaID=$game_map.get_storypoint("UniqueCocona")
	tmpCoconaStaffX,tmpCoconaStaffY,tmpCoconaStaffID=$game_map.get_storypoint("CoconaStaff")
	tmpTavernWaifuOX,tmpTavernWaifuOY,tmpTavernWaifuOMT = [get_character(tmpTavernWaifuID).x,get_character(tmpTavernWaifuID).y,get_character(tmpTavernWaifuID).move_type]
	tmpUniqueCoconaOX,tmpUniqueCoconaOY,tmpUniqueCoconaOMT = [get_character(tmpUniqueCoconaID).x,get_character(tmpUniqueCoconaID).y,get_character(tmpUniqueCoconaID).move_type]
	get_character(tmpUniqueCoconaID).npc_story_mode(true)
	get_character(tmpTavernWaifuID).npc_story_mode(true)
	get_character(tmpUniqueCoconaID).move_type = 0
	get_character(tmpUniqueCoconaID).opacity = 0
	get_character(tmpTavernWaifuID).animation = nil
	get_character(tmpTavernWaifuID).call_balloon(0)
	get_character(tmpTavernWaifuID).opacity = 0
	get_character(tmpTavernWaifuID).move_type = 0
	$story_stats["RecQuestCocona"] = 28
	1.times{
		$game_player.direction = 8 ; $game_player.move_forward_force
		$game_player.move_speed = 2.8
		until !$game_player.moving? ; wait(1) end
	}
	get_character(tmpUniqueCoconaID).moveto(tmpStartPointX,tmpStartPointY)
	get_character(tmpUniqueCoconaID).direction = 8
	get_character(tmpUniqueCoconaID).opacity = 255
	3.times{
		$game_player.direction = 8 ; $game_player.move_forward_force
		$game_player.move_speed = 2.8
		get_character(tmpUniqueCoconaID).direction = 8 ; get_character(tmpUniqueCoconaID).move_forward_force
		get_character(tmpUniqueCoconaID).move_speed = 2.8
		until !get_character(tmpUniqueCoconaID).moving? ; wait(1) end
	}
	$game_player.turn_toward_character(get_character(tmpUniqueCoconaID))
	call_msg("CompCocona:DualEndTavern/0") ; portrait_hide
	$game_player.direction = 4
	$game_player.call_balloon(8)
	wait(60)
	$game_player.direction = 6
	$game_player.call_balloon(8)
	wait(60)
	call_msg("CompCocona:DualEndTavern/1") ; portrait_hide
	get_character(tmpTavernWaifuID).moveto(tmpStartPointX,tmpStartPointY)
	get_character(tmpTavernWaifuID).direction = 8
	get_character(tmpTavernWaifuID).opacity = 255
	2.times{
		get_character(tmpTavernWaifuID).direction = 8 ; get_character(tmpTavernWaifuID).move_forward_force
		get_character(tmpTavernWaifuID).move_speed = 2.8
		until !get_character(tmpTavernWaifuID).moving? ; wait(1) end
	}
	wait(20)
	$game_player.call_balloon(1)
	get_character(tmpUniqueCoconaID).call_balloon(1)
	$game_player.turn_toward_character(get_character(tmpTavernWaifuID))
	get_character(tmpUniqueCoconaID).turn_toward_character(get_character(tmpTavernWaifuID))
	get_character(tmpTavernWaifuID).call_balloon(14)
	SndLib.sound_punch_hit(100)
	#SndLib.sound_HumanFemaleGruntDed
	get_character(tmpTavernWaifuID).animation = get_character(tmpTavernWaifuID).animation_stun
	call_msg("CompCocona:DualEndTavern/2") ; portrait_hide
	1.times{
		$game_player.direction = 2 ; $game_player.move_forward_force
		$game_player.move_speed = 2.8
		get_character(tmpUniqueCoconaID).direction = 6 ; get_character(tmpUniqueCoconaID).move_forward_force
		get_character(tmpUniqueCoconaID).move_speed = 2.8
		until !$game_player.moving? ; wait(1) end
	}
	1.times{
		get_character(tmpUniqueCoconaID).direction = 2 ; get_character(tmpUniqueCoconaID).move_forward_force
		get_character(tmpUniqueCoconaID).move_speed = 2.8
		until !$game_player.moving? ; wait(1) end
	}
	get_character(tmpUniqueCoconaID).turn_toward_character(get_character(tmpTavernWaifuID))
	call_msg("CompCocona:DualEndTavern/3") ; portrait_hide
	get_character(tmpTavernWaifuID).animation = nil
	get_character(tmpTavernWaifuID).direction = 6
	get_character(tmpTavernWaifuID).call_balloon(8)
	wait(60)
	call_msg("CompCocona:DualEndTavern/4") ; portrait_hide
	cam_center(0)
	1.times{
		$game_player.direction = 6 ; $game_player.move_forward_force
		$game_player.move_speed = 2.8
		get_character(tmpTavernWaifuID).direction = 8 ; get_character(tmpTavernWaifuID).move_forward_force
		get_character(tmpTavernWaifuID).move_speed = 2.8
		until !get_character(tmpTavernWaifuID).moving? ; wait(1) end
	}
	2.times{
		get_character(tmpTavernWaifuID).direction = 8 ; get_character(tmpTavernWaifuID).move_forward_force
		get_character(tmpTavernWaifuID).move_speed = 2.8
		get_character(tmpUniqueCoconaID).turn_toward_character(get_character(tmpTavernWaifuID))
		$game_player.turn_toward_character(get_character(tmpTavernWaifuID))
		until !get_character(tmpTavernWaifuID).moving? ; wait(1) end
	}
	get_character(tmpTavernWaifuID).direction = 8 ; get_character(tmpTavernWaifuID).move_forward_force
	get_character(tmpTavernWaifuID).move_speed = 2.8
	get_character(tmpUniqueCoconaID).turn_toward_character(get_character(tmpTavernWaifuID))
	until get_character(tmpTavernWaifuID).opacity <= 0
		get_character(tmpTavernWaifuID).opacity -=5
		wait(1)
	end
	$game_player.turn_toward_character(get_character(tmpTavernWaifuID))
	call_msg("CompCocona:DualEndTavern/5")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpTavernWaifuID).opacity = 255
		get_character(tmpTavernWaifuID).forced_x = 16
		get_character(tmpTavernWaifuID).direction = 2
		get_character(tmpTavernWaifuID).moveto(tmpTavernWaifuOX,tmpTavernWaifuOY)
		$game_player.moveto(tmpTavernWaifuX,tmpTavernWaifuY+2)
		get_character(tmpUniqueCoconaID).moveto(tmpTavernWaifuX+1,tmpTavernWaifuY+2)
		$game_player.direction = 8
		get_character(tmpUniqueCoconaID).direction = 8
	chcg_background_color(0,0,0,255,-7)
	call_msg("CompCocona:DualEndTavern/6")
	if $story_stats["RecQuestCoconaDefeatBossMama"] == 1
		call_msg("CompCocona:DualEndTavern/7_win")
	else
		call_msg("CompCocona:DualEndTavern/7_lose")
	end
	call_msg("CompCocona:DualEndTavern/8")
	get_character(tmpTavernWaifuID).animation = get_character(tmpTavernWaifuID).animation_atk_sh
	portrait_hide
	wait(6)
	optain_item("ItemQuestCoconaShip",1) #98
	wait(60)
	call_msg("CompCocona:DualEndTavern/9")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		cam_center(0)
		set_event_force_page(tmpCoconaStaffID,2)
		get_character(tmpUniqueCoconaID).opacity = 255
		get_character(tmpTavernWaifuID).forced_x = 0
		get_character(tmpUniqueCoconaID).move_type = tmpUniqueCoconaOMT
		get_character(tmpTavernWaifuID).move_type = tmpTavernWaifuOMT
		get_character(tmpUniqueCoconaID).moveto(tmpUniqueCoconaOX,tmpUniqueCoconaOY)
		get_character(tmpTavernWaifuID).moveto(tmpTavernWaifuOX,tmpTavernWaifuOY)
		get_character(tmpUniqueCoconaID).npc_story_mode(false)
		get_character(tmpTavernWaifuID).npc_story_mode(false)
		get_character(tmpTavernWaifuID).call_balloon(28,-1) if $game_party.has_item?("ItemQuestMhKatana")
	chcg_background_color(0,0,0,255,-7)
	optain_exp(40000)
	wait(30)
	#ADD COCONA ACH
end
get_character(0).erase