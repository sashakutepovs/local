if $game_map.threat
 SndLib.sys_buzzer
 $game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
 return
elsif $story_stats["RecQuestDarneyl_BabyAMT"] >= $game_date.dateAmt
 SndLib.sys_buzzer
 $game_map.popup(0,"Played, try next day",0,0)
 return
end




tmpDuabBiosID=$game_map.get_storypoint("DualBios")[2]
tmpCurX,tmpCurY,tmpCurID=$game_map.get_storypoint("CannonCur")
tmpKickerCamX,tmpKickerCamY,tmpKickerCamID=$game_map.get_storypoint("KickerCam")

portrait_hide
chcg_background_color(0,0,0,0,7)
	SndLib.bgm_play("/D/PP_Fight_or_Flight_Heavy_Loop",60,150)
	
	portrait_off
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


