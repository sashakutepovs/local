@hint_sprite.dispose if @hint_sprite

tmpTeacherId=$game_map.get_storypoint("teacher")[2]
$game_player.turn_toward_character(get_character(tmpTeacherId))
call_msg("TagMapTutorialOP:OP/begin12")

call_msg("TagMapTutorialOP:OP/begin13")





@hint_sprite = Sprite.new(@viewport)
@hint_sprite.z = System_Settings::COMPANION_UI_Z
@hint_sprite.bitmap= Bitmap.new(640,360)
@hint_sprite.bitmap.font.outline = false
@hint_sprite.x = 0
@hint_sprite.y = 0
tmpKey0 = $game_text["TagMapTutorialOP:OP/ToMenu0"]
tmpKey1 = $game_text["TagMapTutorialOP:OP/ToMenu1"]
tmpKey2 = $game_text["TagMapTutorialOP:OP/ToMenu2"]
tmpKey3 = InputUtils.getKeyAndTranslateLong(:B)
@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
@hint_sprite.bitmap.draw_text(0, 5,640,25,tmpKey0,1)
@hint_sprite.bitmap.draw_text(0, 25,640,25,tmpKey1,1)
@hint_sprite.bitmap.draw_text(0, 45,640,25,tmpKey2,1)
@hint_sprite.bitmap.draw_text(0, 65,640,25,tmpKey3,1)



tmpMapCountId=$game_map.get_storypoint("MapCount")[2]
set_event_force_page(tmpMapCountId,9)
eventPlayEnd

