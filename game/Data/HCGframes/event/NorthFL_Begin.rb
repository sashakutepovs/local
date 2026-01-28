SndLib.bgs_play("FoodMarket",50,100) if $game_date.day?
SndLib.bgs_play("RainLight",45,100) if $game_date.night?
tmpLP = RPG::BGM.last.pos
SndLib.bgm_play("D/Secrets of Kingdom (looped)",80,85,tmpLP)
if $game_date.day?
	$game_map.shadows.set_color(128, 128, 148)
	$game_map.shadows.set_opacity(80)
	map_background_color(130,100,140,40)
end
if $game_date.night?
	$game_map.shadows.set_color(128, 128, 188)
	$game_map.shadows.set_opacity(210)
	map_background_color(120,80,170,40)
end
#screen.start_tone_change(Tone.new(0,0,0,40),0)
$game_map.set_fog("mountainUP")
$game_map.interpreter.weather("rain_fast", 3, "Rain") if $game_date.night?
p "########## BIOS AUTORUN SETUP ##########"

if $story_stats["Captured"] == 1
	call_msg("TagMapNorthFL:Exit/Escaped")
end
fadeout=$story_stats["ReRollHalfEvents"] == 1
enter_static_tag_map(nil,fadeout)
summon_companion
eventPlayEnd
get_character(0).erase
