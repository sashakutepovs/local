if $game_map.threat
 SndLib.sys_buzzer
 $game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
 return
end
tmpDuabBiosID=$game_map.get_storypoint("DualBios")[2]
tmpCBThunterID=$game_map.get_storypoint("CBThunter")[2]
tmpHunterAlive = $game_map.npcs.any?{|event|
	next if event.summon_data == nil
	next if !event.summon_data[:Hunter]
	next if ![nil,:none].include?(event.actor.action_state)
	next if event.actor.action_state == :death
	next if !event.faced_character?($game_player)
	true
}


if $game_player.direction != 8
	SndLib.sound_QuickDialog
	$game_map.popup(0,"TagMapSMRefugeeCamp:CapGob/FaceIT",0,0)
	return
end
if get_character(tmpDuabBiosID).summon_data[:Payed] == false && tmpHunterAlive
	portrait_hide
	call_msg("TagMapSMRefugeeCamp:Hunter/NeedPay0")
	$game_player.turn_toward_character(get_character(tmpCBThunterID))
	call_msg("TagMapSMRefugeeCamp:Hunter/NeedPay1")
	return eventPlayEnd
end
tmpCurX,tmpCurY,tmpCurID=$game_map.get_storypoint("CannonCur")
tmpKickerCamX,tmpKickerCamY,tmpKickerCamID=$game_map.get_storypoint("KickerCam")
tmpCBTvictimX,tmpCBTvictimY,tmpCBTvictimID=$game_map.get_storypoint("CBTvictim")
tmpCBTvictimGrapID=$game_map.get_storypoint("CBTvictimGrap")[2]
tmpCBTlightID=$game_map.get_storypoint("CBTlight")[2]
tmpCurVictimID = get_character(tmpDuabBiosID).summon_data[:CurVictimID] = get_character(0).id



call_msg("TagMapSMRefugeeCamp:GoblinCBT/begin#{rand(2)}")
tmpTarList = []
tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]					,"Cancel"]
tmpTarList << [$game_text["TagMapSMRefugeeCamp:GoblinCBT/Kick"]			,"Kick"]
tmpTarList << [$game_text["TagMapSMRefugeeCamp:GoblinCBT/Release"]		,"Release"] if !tmpHunterAlive
cmd_sheet = tmpTarList
cmd_text =""
for i in 0...cmd_sheet.length
	cmd_text.concat(cmd_sheet[i].first+",")
end
call_msg("commonNPC:MaleHumanRandomNpc/CommonHuman_CommonNpcOpt",0,2,0)
call_msg("\\optB[#{cmd_text}]")
$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
$game_temp.choice = -1

case tmpPicked
	when "Kick"
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			SndLib.bgm_play("/D/Platform Action LOOP",80)
			get_character(tmpCBTlightID).move_type = 3
			get_character(tmpCBTlightID).force_update = true
			portrait_off
			SndLib.sound_goblin_roar
			############################################## SETUP Ev
			get_character(tmpDuabBiosID).summon_data[:CBToX] = $game_player.x
			get_character(tmpDuabBiosID).summon_data[:CBToY] = $game_player.y
			$game_player.moveto(1,1)
			cam_follow(tmpKickerCamID,0)
			$hudForceHide = true
			$balloonForceHide = true
			$game_player.force_update = false
			$game_player.drop_light
			$game_player.transparent = true
			$game_system.menu_disabled = true
			set_event_force_page(tmpCBTvictimID,get_character(tmpCurVictimID).summon_data[:hp]+1)
			get_character(tmpCBTvictimID).move_type = 3
			set_event_force_page(tmpCBTvictimGrapID,get_character(tmpCurVictimID).summon_data[:hp]+1)
			tmpPattern = get_character(tmpCBTvictimID).x - tmpCBTvictimX
			get_character(tmpCBTvictimGrapID).pattern = tmpPattern
			get_character(0).switch1_id = [0,0]
			get_character(0).switch2_id = 1
			get_character(tmpCurID).opacity = 255
			get_character(tmpCurID).set_manual_move_type(13)
			get_character(tmpCurID).move_type = 13
			#get_character(tmpCurID).force_update = true
			cam_follow(tmpKickerCamID,0)
			set_this_event_force_page(4)
		chcg_background_color(0,0,0,255,-7)
		
		@hint_sprite = Sprite.new(@viewport)
		@hint_sprite.z = System_Settings::COMPANION_UI_Z
		@hint_sprite.bitmap= Bitmap.new(640,360)
		@hint_sprite.bitmap.font.outline = false
		@hint_sprite.x = 0
		@hint_sprite.y = 0


		lineHeight = 15
		startHeight = 15
		tmpY = -15
		keyLinesL = []
		keyLinesL << InputUtils.getKeyAndTranslateLongKeyBoardOnly(:S1)
		keyLinesL << InputUtils.getKeyAndTranslateLong(:S1) 				if WolfPad.plugged_in?
		keyLinesL << InputUtils.getKeyAndTranslateLong(:MZ_LINK)			if Mouse.usable?
		tmpKey1L = "-"
		tmpKey2L = "KICK"
		keyLinesL.each{|ary|
			tmpY+=lineHeight
			@hint_sprite.bitmap.draw_text(18, 5+tmpY,320,40,ary.upcase,0)
		}
		tmpY+=lineHeight
		@hint_sprite.bitmap.draw_text(18, startHeight+tmpY,320,40,tmpKey1L,0)
		tmpY+=lineHeight
		@hint_sprite.bitmap.draw_text(18, startHeight+tmpY,320,40,tmpKey2L,0)
		lineHeight = 15
		startHeight = 15
		tmpY = -15
		keyLinesR = []
		keyLinesR << InputUtils.getKeyAndTranslateLongKeyBoardOnly(:B)
		keyLinesR << InputUtils.getKeyAndTranslateLong(:B) 					if WolfPad.plugged_in?
		keyLinesR << InputUtils.getKeyAndTranslateLong(:MM_LINK)			if Mouse.usable?
		tmpKey1R = "-"
		tmpKey2R = "QUIT"
		keyLinesR.each{|ary|
			tmpY+=lineHeight
			@hint_sprite.bitmap.draw_text(307, 5+tmpY,320,40,ary.upcase,2)
		}
		tmpY+=lineHeight
		@hint_sprite.bitmap.draw_text(307, startHeight+tmpY,320,40,tmpKey1R,2)
		tmpY+=lineHeight
		@hint_sprite.bitmap.draw_text(307, startHeight+tmpY,320,40,tmpKey2R,2)
		
		
		#tmpKey0L = InputUtils.getKeyAndTranslateLong(:S1)
		#tmpKey1L = "-"
		#tmpKey2L = "KICK"
		#tmpKey0R = InputUtils.getKeyAndTranslateLong(:B)
		#tmpKey1R = "-"
		#tmpKey2R = "QUIT"
		#@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_LARGE #30
		#@hint_sprite.opacity = 255
		#@hint_sprite.bitmap.draw_text(18, 5,320,40,tmpKey0L.upcase,0)
		#@hint_sprite.bitmap.draw_text(18, 20,320,40,tmpKey1L,0)
		#@hint_sprite.bitmap.draw_text(18, 39,320,40,tmpKey2L,0)
		#@hint_sprite.bitmap.draw_text(307, 5,320,40,tmpKey0R.upcase,2)
		#@hint_sprite.bitmap.draw_text(307, 20,320,40,tmpKey1R,2)
		#@hint_sprite.bitmap.draw_text(307, 39,320,40,tmpKey2R,2)
		
	when"Release"
		return load_script("Data/HCGframes/event/SMRefugeeCamp_ReleaseCBT.rb")
end
