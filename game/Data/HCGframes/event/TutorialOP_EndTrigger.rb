SndLib.sys_LvUp
@hint_sprite.dispose if @hint_sprite
get_character(0).call_balloon(0)

tmpTeacherId=$game_map.get_storypoint("teacher")[2]
tmpFireID=$game_map.get_storypoint("Fire3")[2]
get_character(tmpTeacherId).npc_story_mode(true)
get_character(tmpTeacherId).direction = 8 ; get_character(tmpTeacherId).move_forward_force ; wait(30)
get_character(tmpTeacherId).direction = 6 ; get_character(tmpTeacherId).move_forward_force ; wait(30)
get_character(tmpTeacherId).direction = 6 ; get_character(tmpTeacherId).move_forward_force ; wait(30)
get_character(tmpTeacherId).direction = 2 ; get_character(tmpTeacherId).move_forward_force ; wait(30)
get_character(tmpTeacherId).direction = 6 ; get_character(tmpTeacherId).move_forward_force ; wait(30)
get_character(tmpTeacherId).direction = 6 ; get_character(tmpTeacherId).move_forward_force ; wait(30)


$game_map.events.each{|ev|
	next unless ev[1].summon_data
	next unless ev[1].summon_data[:OPcb]
	ev[1].drop_light
}
get_character(tmpFireID).delete
SndLib.stoneCollapsed(70+rand(40))
SndLib.sound_flame(100)

get_character(tmpTeacherId).turn_toward_character($game_player)
$game_player.turn_toward_character(get_character(tmpTeacherId))
call_msg("TagMapTutorialOP:OP/begin18")
get_character(tmpTeacherId).npc_story_mode(false)



@hint_sprite = Sprite.new(@viewport)
@hint_sprite.z = System_Settings::COMPANION_UI_Z
@hint_sprite.bitmap= Bitmap.new(640,360)
@hint_sprite.bitmap.font.outline = false
@hint_sprite.x = 0
@hint_sprite.y = 0
tmpKey0 = $game_text["TagMapTutorialOP:OP/ToEND"]
@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
@hint_sprite.bitmap.draw_text(0, 5,640,25,tmpKey0,1)

eventPlayEnd
