@hint_sprite.dispose if @hint_sprite

get_character(0).call_balloon(0)

tmpT1ID=$game_map.get_storypoint("StoneTop1")[2]
tmpBlock3X,tmpBlock3Y,tmpBlock3ID=$game_map.get_storypoint("Block3")
tmpFireID=$game_map.get_storypoint("Fire")[2]
tmpLonaWoodID=$game_map.get_storypoint("LonaWood")[2]
tmpLonaLenID=$game_map.get_storypoint("LonaLen")[2]


get_character(tmpT1ID).moveto(tmpBlock3X,tmpBlock3Y+1)
SndLib.stoneCollapsed(70+rand(40))

set_event_force_page(tmpFireID,1)
get_character(tmpFireID).pattern = 0
get_character(tmpFireID).drop_light
$game_map.events.each{|ev|
	next unless ev[1].summon_data
	next unless ev[1].summon_data[:OPTrigger]
	ev[1].drop_light
}

call_msg("TagMapTutorialOP:OP/begin10")
eventPlayEnd
$game_player.direction = 4
wait(20)
$game_player.call_balloon(8)
$game_player.direction = 2
wait(50)
call_msg("TagMapTutorialOP:OP/begin11")
eventPlayEnd



@hint_sprite = Sprite.new(@viewport)
@hint_sprite.z = System_Settings::COMPANION_UI_Z
@hint_sprite.bitmap= Bitmap.new(640,360)
@hint_sprite.bitmap.font.outline = false
@hint_sprite.x = 0
@hint_sprite.y = 0
tmpKey0 = $game_text["TagMapTutorialOP:OP/StandOnItemAndPress"]
tmpKey1 = InputUtils.getKeyAndTranslateLong(:C)
tmpKey2 = $game_text["TagMapTutorialOP:OP/ToPickItem"]
@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
@hint_sprite.bitmap.draw_text(0, 5,640,25,tmpKey0,1)
@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
@hint_sprite.bitmap.draw_text(0, 25,640,25,tmpKey1,1)
@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
@hint_sprite.bitmap.draw_text(0, 45,640,25,tmpKey2,1)

get_character(tmpLonaLenID).call_balloon(19,-1)

eventPlayEnd
