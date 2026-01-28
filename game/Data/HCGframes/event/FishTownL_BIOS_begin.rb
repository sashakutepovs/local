

#$game_map.interpreter.weather("rain_fast", 4, "Rain")
#
#SndLib.bgm_play("D/Desert_Citadel_Light_LOOP",75,110,tmpLP) if $game_date.day?
#SndLib.bgm_play("D/Desert_Citadel_Light_LOOP",75,90,tmpLP) if $game_date.night?
#SndLib.bgs_play("RainLight",70,130)
#
#
#$game_map.interpreter.map_background_color(80,150,120,30,0)

weather_batch_r8_25_Swamp
$game_map.shadows.set_color(50, 120, 40) if $game_date.day?
$game_map.shadows.set_opacity(120)  if $game_date.day?
$game_map.shadows.set_color(50, 120, 40) if $game_date.night?
$game_map.shadows.set_opacity(210)  if $game_date.night?
tmpLP = RPG::BGM.last.pos
SndLib.bgm_play("D/Desert_Citadel_Light_LOOP",75,110,tmpLP) if $game_date.day?
SndLib.bgm_play("D/Desert_Citadel_Light_LOOP",75,90,tmpLP) if $game_date.night?

if $game_player.actor.stat["SlaveBrand"] == 1 ########### aggro player if player are slave. #############
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:watcher]
		next if event.deleted?
		event.npc.add_fated_enemy([0])
	}
end
if $story_stats["ReRollHalfEvents"] ==1
	enter_static_tag_map
end
summon_companion

load_script("Data/HCGframes/event/FishTownL_Begin.rb")

chcg_background_color(0,0,0,255,-7) if get_chcg_background_opacity >= 255

eventPlayEnd

get_character(0).erase
