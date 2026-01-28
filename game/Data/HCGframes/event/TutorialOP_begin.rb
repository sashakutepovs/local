
#
#tmpOpeningCAM1Id=$game_map.get_storypoint("OpeningCAM1")[2]
#tmpOpeningCAM2Id=$game_map.get_storypoint("OpeningCAM2")[2]
#tmpOpeningCAM3Id=$game_map.get_storypoint("OpeningCAM3")[2]
#$game_map.set_fog("mountainUP")
#$game_map.shadows.set_color(120, 120, 120)
#$game_map.shadows.set_opacity(110)
#$game_map.interpreter.map_background_color
#
#
#cam_follow(tmpOpeningCAM1Id,0)
#
#$game_map.events.each{|ev|
#	next unless ev[1].summon_data
#	next unless ev[1].summon_data[:OPgroup1]
#	ev[1].move_type = 3
#	ev[1].force_update = true
#}
#chcg_background_color(0,0,0,255,-4)
#wait(240)
#chcg_background_color(0,0,0,0,4)
#	cam_follow(tmpOpeningCAM2Id,0)
#	$game_map.events.each{|ev|
#		next unless ev[1].summon_data
#		next unless ev[1].summon_data[:OPgroup1]
#		ev[1].delete
#	}
#	$game_map.events.each{|ev|
#		next unless ev[1].summon_data
#		next unless ev[1].summon_data[:OPgroup2]
#		ev[1].move_type = 3
#		ev[1].force_update = true
#	}
#chcg_background_color(0,0,0,255,-4)
#wait(260)
#chcg_background_color(0,0,0,0,4)
#	eventPlayEnd
#	cam_follow(tmpOpeningCAM3Id,0)
#	$game_map.events.each{|ev|
#		next unless ev[1].summon_data
#		next unless ev[1].summon_data[:OPgroup2]
#		ev[1].delete
#	}
#	$game_map.events.each{|ev|
#		next unless ev[1].summon_data
#		next unless ev[1].summon_data[:OPgroup3]
#		ev[1].move_type = 3
#		ev[1].force_update = true
#	}
#chcg_background_color(0,0,0,255,-4)
#wait(260)
#chcg_background_color(0,0,0,0,7)
	$game_map.events.each{|ev|
		next unless ev[1].summon_data
		next unless ev[1].summon_data[:OPgroup3] || ev[1].summon_data[:OPgroup2] || ev[1].summon_data[:OPgroup1]
		ev[1].delete
	}
	map_background_color(0,0,0,255,0)
	
	
	
	wait(30)
	@hint_sprite.dispose if @hint_sprite
	@hint_sprite = Sprite.new(@viewport)
	@hint_sprite.z = System_Settings::COMPANION_UI_Z
	@hint_sprite.bitmap= Bitmap.new(640,360)
	@hint_sprite.bitmap.font.outline = false
	@hint_sprite.opacity = 0
	@hint_sprite.x = 0
	@hint_sprite.y = 0
	tmpKey0 = $game_text["TagMapTutorialOP:OP/b4Begin0"]
	tmpKey1 = $game_text["TagMapTutorialOP:OP/b4Begin1"]
	tmpKey2 = $game_text["TagMapTutorialOP:OP/b4Begin2"]
	tmpKey3 = $game_text["TagMapTutorialOP:OP/b4Begin3"]
	@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
	@hint_sprite.bitmap.draw_text(0, 105,640,25,tmpKey0,1)
	@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
	@hint_sprite.bitmap.draw_text(0, 125,640,25,tmpKey1,1)
	@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
	@hint_sprite.bitmap.draw_text(0, 145,640,25,tmpKey2,1)
	@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
	@hint_sprite.bitmap.draw_text(0, 165,640,25,tmpKey3,1)
	until @hint_sprite.opacity >= 255
		wait(1)
		@hint_sprite.opacity += 5
	end
	wait(50)
	SndLib.sound_step(20,50)
	wait(50)
	SndLib.sound_step(40,50)
	wait(50)
	SndLib.sound_step(70,50)
	wait(70)
	
	until @hint_sprite.opacity <= 0
		wait(2)
		@hint_sprite.opacity -= 5
	end
	@hint_sprite.dispose if @hint_sprite
	
	SndLib.me_play("ME/Door - Medieval Open 16")
	wait(30)
	SndLib.bgs_play("Cave/Cavern Sound effect_Short",10,100)
	wait(30)
	SndLib.bgs_play("Cave/Cavern Sound effect_Short",20,101)
	wait(30)
	SndLib.bgs_play("Cave/Cavern Sound effect_Short",25,100)
	wait(30)
	SndLib.bgs_play("Cave/Cavern Sound effect_Short",30,101)
	wait(30)
	SndLib.bgs_play("Cave/Cavern Sound effect_Short",45,100)
	wait(30)
	SndLib.bgs_play("Cave/Cavern Sound effect_Short",40,101)
	wait(30)
	SndLib.bgs_play("Cave/Cavern Sound effect_Short",45,100)
	wait(30)
	SndLib.bgs_play("Cave/Cavern Sound effect_Short",50,101)
	wait(30)
	SndLib.bgs_play("Cave/Cavern Sound effect_Short",65,100)
	wait(60)
	SndLib.sound_step(80,50)
	wait(5)
	SndLib.sound_step(100,100)
	wait(50)
	#$game_player.slot_skill_normal		= nil
	#$game_player.slot_skill_heavy		= nil
	#$game_player.slot_skill_control	= nil
	#$game_player.slot_hotkey_0			= nil
	#$game_player.slot_hotkey_1			= nil
	#$game_player.slot_hotkey_2			= nil
	#$game_player.slot_hotkey_3			= nil
	#$game_player.slot_hotkey_4			= nil
	#$game_player.slot_hotkey_other		= nil
		$game_player.actor.forget_skill("BasicSlipped") #
		$game_player.actor.forget_skill("BasicNeeds") #
		$game_player.actor.forget_skill("BasicSubmit") #
		$game_player.actor.forget_skill("BasicSetDarkPot") #
		$game_player.actor.forget_skill("BasicThrow") #
		$game_player.actor.forget_skill("BasicQuickExt1") #
		$game_player.actor.forget_skill("BasicQuickExt2") #
		$game_player.actor.forget_skill("BasicQuickExt3") #
		$game_player.actor.forget_skill("BasicQuickExt4") #
		$game_player.actor.forget_skill("BasicQuickExt5") #
		$game_player.actor.forget_skill("BasicAssemblyCall") #
		$game_player.actor.forget_skill("BasicSteal") #
		$game_player.actor.forget_skill("BasicDodge") #
	$game_player.setup_SkillRoster(tmpRoster=4,nil,:slot_skill_normal)
	$game_player.setup_SkillRoster(tmpRoster=4,nil,:slot_skill_heavy)
	$game_player.setup_SkillRoster(tmpRoster=4,nil,:slot_skill_control)
	$game_player.setup_SkillRoster(tmpRoster=4,nil,:slot_hotkey_0)
	$game_player.setup_SkillRoster(tmpRoster=4,nil,:slot_hotkey_1)
	$game_player.setup_SkillRoster(tmpRoster=4,nil,:slot_hotkey_2)
	$game_player.setup_SkillRoster(tmpRoster=4,nil,:slot_hotkey_3)
	$game_player.setup_SkillRoster(tmpRoster=4,nil,:slot_hotkey_4)
	$game_player.setup_SkillRoster(tmpRoster=4,nil,:slot_hotkey_other)
	$story_stats["dialog_wet"] =0
	$story_stats["dialog_sta"] =0
	$story_stats["dialog_sat"] =0
	$story_stats["dialog_cumflation"] =0
	$story_stats["dialog_cuff"] =0
	$story_stats["dialog_collar"] =0
	$story_stats["dialog_dress_out"] =0
	$story_stats["dialog_defecate"] =0
	$story_stats["dialog_urinary"] =0
	$story_stats["dialog_defecated"] =0
	$story_stats["dialog_overweight"] =0
	$story_stats["dialog_lactation"] =0
	$story_stats["dialog_sick"] =0
	$story_stats["dialog_drug_addiction"] =0
	$story_stats["dialog_moon_worm_hit"] =0
	$story_stats["dialog_pot_worm_hit"] =0
	$story_stats["dialog_HookWorm_hit"]		=1
	$story_stats["dialog_PolypWorm_hit"]	=1
	$story_stats["dialog_parasited"] =0
	$story_stats["MenuSysSavegameOff"]		=1
	$story_stats["MenuSysHardcoreOff"]	=1
	$story_stats["MenuSysScatOff"]		=1
	$story_stats["MenuSysUrineOff"]		=1
	
	
	
	
	
	$game_map.shadows.set_color(0, 20, 40)
	$game_map.shadows.set_opacity(125)
	map_background_color(80,80,200,60,0)
	$game_map.set_fog("infested_Cave")
	#$game_map.clear_fog
	$game_player.actor.sat = 80
	$game_player.actor.change_equip(0, nil)
	$game_player.actor.change_equip(1, nil)
	$game_party.lose_item("Item2MhBareHand",1)
	$game_party.lose_item("ItemMhWoodenClub",1)
	$game_party.lose_item("ItemShLantern",1)
	$game_party.lose_item("ItemDryFood",3)
	$story_stats["LimitedNapSkill"] =1
	$game_system.menu_disabled = true
	$game_player.direction = 2
	enter_static_tag_map
	player_force_update
	$game_player.opacity = 255
chcg_background_color(0,0,0,255,-7)
eventPlayEnd
$hudForceHide = false
$balloonForceHide = false


portrait_hide
tmpTeacherId=$game_map.get_storypoint("teacher")[2]
tmpOPMoveToX,tmpOPMoveToY,tmpOPMoveToID=$game_map.get_storypoint("OPMoveTo")
tmpArrowKeyLanternX,tmpArrowKeyLanternY,tmpArrowKeyLanternID=$game_map.get_storypoint("ArrowKeyLantern")
get_character(tmpTeacherId).npc_story_mode(true)
$game_player.call_balloon(8)
wait(50)
get_character(tmpTeacherId).direction = 8 ; get_character(tmpTeacherId).move_forward_force ; wait(30)
$game_player.call_balloon(8)
wait(40)


@hint_sprite.dispose if @hint_sprite
@hint_sprite = Sprite.new(@viewport)
@hint_sprite.z = System_Settings::COMPANION_UI_Z
@hint_sprite.bitmap= Bitmap.new(640,360)
@hint_sprite.bitmap.font.outline = false
@hint_sprite.x = 0
@hint_sprite.y = 0
tmpKey0 = $game_text["TagMapTutorialOP:OP/ToTrigger1"]
tmpKey1 = $game_text["TagMapTutorialOP:OP/ToTrigger2"]
tmpKey2 = InputUtils.getKeyAndTranslateLong(:C)
@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
@hint_sprite.bitmap.draw_text(0, 5,640,25,tmpKey0,1)
@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
@hint_sprite.bitmap.draw_text(0, 25,640,25,tmpKey1,1)
@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
@hint_sprite.bitmap.draw_text(0, 45,640,25,tmpKey2,1)
get_character(tmpOPMoveToID).call_balloon(19,-1)
call_msg("TagMapTutorialOP:OP/begin0")
@hint_sprite.dispose if @hint_sprite
eventPlayEnd
#get_character(tmpOPMoveToID).give_light("green_torch_item")
set_event_force_page(tmpArrowKeyLanternID,1)
get_character(tmpArrowKeyLanternID).give_light("lantern")
SndLib.sound_flame(100)
$game_map.events.each{|ev|
	next unless ev[1].summon_data
	next unless ev[1].summon_data[:OPMoveTo]
	ev[1].give_light("green300_5")
}
get_character(tmpTeacherId).direction = 2 ; get_character(tmpTeacherId).move_forward_force ; wait(30)
get_character(tmpTeacherId).direction = 4 ; get_character(tmpTeacherId).move_forward_force ; wait(30)
get_character(tmpTeacherId).direction = 4 ; get_character(tmpTeacherId).move_forward_force ; wait(30)
get_character(tmpTeacherId).direction = 4 ; get_character(tmpTeacherId).move_forward_force ; wait(30)
chcg_background_color(0,0,0,0,7)

get_character(tmpTeacherId).moveto(tmpOPMoveToX-2,tmpOPMoveToY+1)
get_character(tmpTeacherId).direction = 6
get_character(tmpTeacherId).npc_story_mode(false)

@hint_sprite.dispose if @hint_sprite
@hint_sprite = Sprite.new(@viewport)
@hint_sprite.z = System_Settings::COMPANION_UI_Z
@hint_sprite.bitmap= Bitmap.new(640,360)
@hint_sprite.bitmap.font.outline = false
@hint_sprite.x = 0
@hint_sprite.y = 0
tmpKey0 = $game_text["TagMapTutorialOP:OP/UX_GOTO0"]
tmpKey1 = "#{InputUtils.getKeyAndTranslateLong(:UP)} #{InputUtils.getKeyAndTranslateLong(:DOWN)} #{InputUtils.getKeyAndTranslateLong(:LEFT)} #{InputUtils.getKeyAndTranslateLong(:RIGHT)}"
tmpKey2 = $game_text["TagMapTutorialOP:OP/UX_GOTO1"]
@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
@hint_sprite.bitmap.draw_text(0, 5,640,25,tmpKey0,1)
@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
@hint_sprite.bitmap.draw_text(0, 25,640,25,tmpKey1,1)
@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
@hint_sprite.bitmap.draw_text(0, 45,640,25,tmpKey2,1)
get_character(tmpOPMoveToID).call_balloon(19,-1)

tmpMapCountId=$game_map.get_storypoint("MapCount")[2]
set_event_force_page(tmpMapCountId,2)
eventPlayEnd
