tmpT1ID=$game_map.get_storypoint("StoneTop1")[2]
tmpT2ID=$game_map.get_storypoint("StoneTop2")[2]
tmpBeginLightID=$game_map.get_storypoint("BeginLight")[2]
tmpBlock1X,tmpBlock1Y,tmpBlock1ID=$game_map.get_storypoint("Block1")
tmpBlock2X,tmpBlock2Y,tmpBlock2ID=$game_map.get_storypoint("Block2")

get_character(0).call_balloon(0)
get_character(tmpBeginLightID).delete
@hint_sprite.dispose
get_character(tmpT1ID).npc_story_mode(true)
get_character(tmpT2ID).npc_story_mode(true)
get_character(tmpT1ID).moveto(tmpBlock1X,tmpBlock1Y)
get_character(tmpT2ID).moveto(tmpBlock2X,tmpBlock2Y)
$game_map.events.each{|ev|
	next unless ev[1].summon_data
	next unless ev[1].summon_data[:OPbegin]
	ev[1].drop_light
}
get_character(tmpBeginLightID).delete
SndLib.stoneCollapsed(70+rand(40))
wait(5)
SndLib.stoneCollapsed(70+rand(40))
wait(2)
SndLib.stoneCollapsed(70+rand(40))


tmpTeacherId=$game_map.get_storypoint("teacher")[2]
get_character(tmpTeacherId).npc_story_mode(true)
get_character(tmpTeacherId).direction = 8 ; get_character(tmpTeacherId).move_forward_force ; wait(30)
get_character(tmpTeacherId).direction = 6 ; get_character(tmpTeacherId).move_forward_force ; wait(30)

call_msg("TagMapTutorialOP:OP/begin1")
get_character(tmpTeacherId).npc_story_mode(false)

@hint_sprite.dispose if @hint_sprite
@hint_sprite = Sprite.new(@viewport)
@hint_sprite.z = System_Settings::COMPANION_UI_Z
@hint_sprite.bitmap= Bitmap.new(640,360)
@hint_sprite.bitmap.font.outline = false
@hint_sprite.x = 0
@hint_sprite.y = 0
tmpKey0 = $game_text["TagMapTutorialOP:OP/UX_GOTO0"]
tmpKey1 = "#{InputUtils.getKeyAndTranslateLong(:ALT)} + #{InputUtils.getKeyAndTranslateLong(:UP)} #{InputUtils.getKeyAndTranslateLong(:DOWN)} #{InputUtils.getKeyAndTranslateLong(:LEFT)} #{InputUtils.getKeyAndTranslateLong(:RIGHT)}"
tmpKey2 = $game_text["TagMapTutorialOP:OP/CHANGE_DIR0"]
@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
@hint_sprite.bitmap.draw_text(0, 5,640,25,tmpKey0,1)
@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
@hint_sprite.bitmap.draw_text(0, 25,640,25,tmpKey1,1)
@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
@hint_sprite.bitmap.draw_text(0, 45,640,25,tmpKey2,1)

eventPlayEnd
tmpMapCountId=$game_map.get_storypoint("MapCount")[2]
set_event_force_page(tmpMapCountId,3)
