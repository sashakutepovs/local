@hint_sprite.dispose if @hint_sprite

tmpTeacherId=$game_map.get_storypoint("teacher")[2]
tmpT2ID=$game_map.get_storypoint("StoneTop2")[2]
tmpBlock4X,tmpBlock4Y,tmpBlock4ID=$game_map.get_storypoint("Block4")
tmpFire2ID=$game_map.get_storypoint("Fire2")[2]
tmpOPequipX,tmpOPequipY,tmpOPequipID=$game_map.get_storypoint("OPequip")

get_character(tmpTeacherId).turn_toward_character($game_player)
$game_player.turn_toward_character(get_character(tmpTeacherId))
call_msg("TagMapTutorialOP:OP/begin8")


eventPlayEnd
get_character(tmpTeacherId).npc_story_mode(true)
get_character(tmpTeacherId).direction = 2 ; get_character(tmpTeacherId).move_forward_force ; wait(30)
get_character(tmpTeacherId).direction = 6 ; get_character(tmpTeacherId).move_forward_force ; wait(30)
get_character(tmpTeacherId).direction = 2 ; get_character(tmpTeacherId).move_forward_force ; wait(30)
get_character(tmpT2ID).moveto(tmpBlock4X,tmpBlock4Y)
SndLib.stoneCollapsed(70+rand(40))
set_event_force_page(tmpFire2ID,2)
get_character(tmpFire2ID).give_light("lantern")
SndLib.sound_flame(100)
$game_map.events.each{|ev|
	next unless ev[1].summon_data
	next unless ev[1].summon_data[:OPequip]
	ev[1].give_light("green300_5")
}
get_character(tmpTeacherId).direction = 2 ; get_character(tmpTeacherId).move_forward_force ; wait(30)
get_character(tmpTeacherId).direction = 2 ; get_character(tmpTeacherId).move_forward_force ; wait(30)

chcg_background_color(0,0,0,0,7)
	get_character(tmpTeacherId).moveto(tmpOPequipX,tmpOPequipY+2)
	get_character(tmpTeacherId).direction = 8
chcg_background_color(0,0,0,255,-7)


call_msg("TagMapTutorialOP:OP/begin9")
get_character(tmpTeacherId).npc_story_mode(false)
@hint_sprite = Sprite.new(@viewport)
@hint_sprite.z = System_Settings::COMPANION_UI_Z
@hint_sprite.bitmap= Bitmap.new(640,360)
@hint_sprite.bitmap.font.outline = false
@hint_sprite.x = 0
@hint_sprite.y = 0
tmpKey2 = $game_text["TagMapTutorialOP:OP/UX_GOTO1"]
@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
@hint_sprite.bitmap.draw_text(0, 5,640,25,tmpKey2,1)

get_character(tmpOPequipID).call_balloon(19,-1)

tmpMapCountId=$game_map.get_storypoint("MapCount")[2]
set_event_force_page(tmpMapCountId,7)
eventPlayEnd
