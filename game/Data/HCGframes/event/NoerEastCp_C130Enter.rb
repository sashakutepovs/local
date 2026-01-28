if $game_map.threat
 SndLib.sys_buzzer
 $game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
 return
end
portrait_hide

chcg_background_color(0,0,0,0,7)
	screen.start_tone_change(Tone.new(20,10,0,240),2)
	$game_map.shadows.set_opacity(0)
	
	$hudForceHide = true
	$balloonForceHide = true
	$game_player.force_update = false
	$game_system.menu_disabled = true
	get_character(0).switch1_id = [0,0]
	get_character(0).switch2_id = 1
	get_character(0).call_balloon(0)
	tmpCurX,tmpCurY,tmpCurID=$game_map.get_storypoint("CannonCur")
	get_character(tmpCurID).move_type = :control_this_event
	get_character(tmpCurID).set_manual_move_type(:control_this_event)
	cam_follow(tmpCurID,0)
	$bg = TempBG.new(["AirStrike"])
	set_this_event_force_page(3)
	SndLib.bgm_play("D/Action Time (Looped)",85,100)
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
#tmpKey2L = "FIRE"
#tmpKey0R = InputUtils.getKeyAndTranslateLong(:B)
#tmpKey1R = "-"
#tmpKey2R = "QUIT"
#@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_LARGE #30
#@hint_sprite.opacity = 150
#@hint_sprite.bitmap.draw_text(18, 5,320,40,tmpKey0L.upcase,0)
#@hint_sprite.bitmap.draw_text(18, 20,320,40,tmpKey1L,0)
#@hint_sprite.bitmap.draw_text(18, 39,320,40,tmpKey2L,0)
#@hint_sprite.bitmap.draw_text(307, 5,320,40,tmpKey0R.upcase,2)
#@hint_sprite.bitmap.draw_text(307, 20,320,40,tmpKey1R,2)
#@hint_sprite.bitmap.draw_text(307, 39,320,40,tmpKey2R,2)


