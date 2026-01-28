@hint_sprite.dispose if @hint_sprite

tmpTeacherId=$game_map.get_storypoint("teacher")[2]
tmpT1ID=$game_map.get_storypoint("StoneTop1")[2]
tmpBlock4X,tmpBlock4Y,tmpBlock4ID=$game_map.get_storypoint("Block4")
tmpFireID=$game_map.get_storypoint("Fire2")[2]
get_character(tmpFireID).delete
get_character(tmpT1ID).moveto(tmpBlock4X,tmpBlock4Y)
SndLib.stoneCollapsed(70+rand(40))
get_character(0).call_balloon(0)
$game_map.events.each{|ev|
	next unless ev[1].summon_data
	next unless ev[1].summon_data[:OPequip]
	ev[1].drop_light
}


get_character(tmpTeacherId).turn_toward_character($game_player)
$game_player.turn_toward_character(get_character(tmpTeacherId))
call_msg("TagMapTutorialOP:OP/begin16")
get_character(tmpTeacherId).direction = 6
call_msg("TagMapTutorialOP:OP/begin17")
eventPlayEnd

$game_map.events.each{|ev|
	next unless ev[1].summon_data
	next unless ev[1].summon_data[:Atk1] || ev[1].summon_data[:Atk2]
	ev[1].call_balloon(19,-1)
}


@hint_sprite = Sprite.new(@viewport)
@hint_sprite.z = System_Settings::COMPANION_UI_Z
@hint_sprite.bitmap= Bitmap.new(640,360)
@hint_sprite.bitmap.font.outline = false
@hint_sprite.x = 0
@hint_sprite.y = 0
tmpKey0 = $game_text["TagMapTutorialOP:OP/ToATK0"]
tmpKey1 = $game_text["TagMapTutorialOP:OP/ToATK1"]
@hint_sprite.bitmap.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
@hint_sprite.bitmap.draw_text(0, 5,640,25,tmpKey0,1)
@hint_sprite.bitmap.draw_text(0, 25,640,25,tmpKey1,1)



