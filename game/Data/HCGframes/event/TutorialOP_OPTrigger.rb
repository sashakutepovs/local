@hint_sprite.dispose if @hint_sprite

get_character(0).call_balloon(0)
tmpT1ID=$game_map.get_storypoint("StoneTop1")[2]
tmpBlock2X,tmpBlock2Y,tmpBlock2ID=$game_map.get_storypoint("Block2")
tmpBlock3X,tmpBlock3Y,tmpBlock3ID=$game_map.get_storypoint("Block3")
tmpArrowKeyLanternID=$game_map.get_storypoint("ArrowKeyLantern")[2]
tmpFireID=$game_map.get_storypoint("Fire")[2]
get_character(tmpT1ID).moveto(tmpBlock2X,tmpBlock2Y)
SndLib.stoneCollapsed(70+rand(40))

set_event_force_page(tmpArrowKeyLanternID,2)
get_character(tmpArrowKeyLanternID).pattern = 0
get_character(tmpArrowKeyLanternID).drop_light
get_character(tmpArrowKeyLanternID).moveto(0,0)
$game_map.events.each{|ev|
	next unless ev[1].summon_data
	next unless ev[1].summon_data[:OPMoveTo]
	ev[1].drop_light
}


$game_player.call_balloon(8)
wait(50)
call_msg("TagMapTutorialOP:OP/begin4")
get_character(tmpFireID).call_balloon(28,-1)

@hint_sprite = Sprite.new(@viewport)
@hint_sprite.z = System_Settings::COMPANION_UI_Z
@hint_sprite.bitmap= Bitmap.new(640,360)
@hint_sprite.bitmap.font.outline = false
@hint_sprite.x = 0
@hint_sprite.y = 0
tmpKey0 = $game_text["TagMapTutorialOP:OP/FaceFirePitAndPress"]
tmpKey1 = "#{InputUtils.getKeyAndTranslateLong(:C)}"
tmpKey2 = $game_text["TagMapTutorialOP:OP/5Times"]
@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
@hint_sprite.bitmap.draw_text(0, 5,640,25,tmpKey0,1)
@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
@hint_sprite.bitmap.draw_text(0, 25,640,25,tmpKey1,1)
@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
@hint_sprite.bitmap.draw_text(0, 45,640,25,tmpKey2,1)


eventPlayEnd
