@hint_sprite.dispose if @hint_sprite

tmpTeacherId=$game_map.get_storypoint("teacher")[2]
get_character(0).call_balloon(0)
get_character(0).trigger = -1

get_character(tmpTeacherId).turn_toward_character($game_player)
$game_player.turn_toward_character(get_character(tmpTeacherId))
call_msg("TagMapTutorialOP:OP/begin5")
get_character(tmpTeacherId).direction = 2
call_msg("TagMapTutorialOP:OP/begin6")
25.times{
	$game_map.events.each{|ev|
		next unless ev[1].summon_data
		next unless ev[1].summon_data[:dryfood]
		ev[1].opacity += 10
	}
	wait(1)
}
$game_map.events.each{|ev|
	next unless ev[1].summon_data
	next unless ev[1].summon_data[:dryfood]
	ev[1].trigger = 0
	ev[1].opacity = 255
}

get_character(tmpTeacherId).turn_toward_character($game_player)
$game_player.turn_toward_character(get_character(tmpTeacherId))
call_msg("TagMapTutorialOP:OP/begin7")
get_character(tmpTeacherId).direction = 6
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


$game_map.events.each{|ev|
	next unless ev[1].summon_data
	next unless ev[1].summon_data[:dryfood]
	ev[1].call_balloon(19,-1)
}
eventPlayEnd
