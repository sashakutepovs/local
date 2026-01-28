@hint_sprite.dispose if @hint_sprite
SndLib.sys_LvUp



tmpTeacherId=$game_map.get_storypoint("teacher")[2]
tmpT2ID=$game_map.get_storypoint("StoneTop2")[2]
tmpFireID=$game_map.get_storypoint("Fire3")[2]
tmpOPTriggerX,tmpOPTriggerY,tmpCBtriggerID=$game_map.get_storypoint("CBtrigger")


get_character(tmpTeacherId).turn_toward_character($game_player)
$game_player.turn_toward_character(get_character(tmpTeacherId))
call_msg("TagMapTutorialOP:OP/begin14")
eventPlayEnd
get_character(tmpTeacherId).npc_story_mode(true)
get_character(tmpTeacherId).direction = 6 ; get_character(tmpTeacherId).move_forward_force ; wait(30)
get_character(tmpTeacherId).direction = 8 ; get_character(tmpTeacherId).move_forward_force ; wait(30)
get_character(tmpTeacherId).direction = 6 ; get_character(tmpTeacherId).move_forward_force ; wait(30)
get_character(tmpT2ID).moveto(0,0)
SndLib.stoneCollapsed(70+rand(40))
set_event_force_page(tmpFireID,2)
get_character(tmpFireID).give_light("lantern")
SndLib.sound_flame(100)
$game_map.events.each{|ev|
	next unless ev[1].summon_data
	next unless ev[1].summon_data[:OPcb]
	ev[1].give_light("green300_5")
}
get_character(tmpTeacherId).direction = 6 ; get_character(tmpTeacherId).move_forward_force ; wait(30)
get_character(tmpTeacherId).direction = 6 ; get_character(tmpTeacherId).move_forward_force ; wait(30)
get_character(tmpTeacherId).direction = 6 ; get_character(tmpTeacherId).move_forward_force ; wait(30)



call_msg("TagMapTutorialOP:OP/begin15")
get_character(tmpTeacherId).npc_story_mode(false)


get_character(tmpCBtriggerID).call_balloon(19,-1)


@hint_sprite = Sprite.new(@viewport)
@hint_sprite.z = System_Settings::COMPANION_UI_Z
@hint_sprite.bitmap= Bitmap.new(640,360)
@hint_sprite.bitmap.font.outline = false
@hint_sprite.x = 0
@hint_sprite.y = 0
tmpKey2 = $game_text["TagMapTutorialOP:OP/UX_GOTO1"]
@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
@hint_sprite.bitmap.draw_text(0, 5,640,25,tmpKey2,1)



tmpMapCountId=$game_map.get_storypoint("MapCount")[2]
set_event_force_page(tmpMapCountId,15)
eventPlayEnd

