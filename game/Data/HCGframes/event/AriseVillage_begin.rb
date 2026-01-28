
p "########## BIOS AUTORUN SETUP ##########"
$game_map.set_fog("mountainUP_slow")
$game_map.interpreter.weather("snow", 3, "greenDot",true)
$game_map.shadows.set_color(50, 120, 40) if $game_date.day?
$game_map.shadows.set_opacity(100)  if $game_date.day?
$game_map.shadows.set_color(70, 160, 50) if $game_date.night?
$game_map.shadows.set_opacity(220)  if $game_date.night?
SndLib.bgs_play("forest_unname",80,100)
screen.start_tone_change(Tone.new(0,0,0,40),0)
tmpTortureRackL_X,tmpTortureRackL_Y,tmpTortureRackL_ID = $game_map.get_storypoint("TortureRackL")
tmpTortureRackR_X,tmpTortureRackR_Y,tmpTortureRackR_ID = $game_map.get_storypoint("TortureRackR")
tmpQ1 = $game_player.record_companion_name_ext == "AriseVillageCompExtConvoy"
posi=$game_map.region_map[30]+$game_map.region_map[31]
posi=posi.shuffle
if $story_stats["RecQuestAriseVillageFish"] >= 2 || $story_stats["RecQuestAriseVillageFish"] == -1
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:Obs]
		next if event.deleted?
		next if event.npc.action_state == :death
		next event.delete if [true,false].sample && $game_date.night?
		posi_pick = posi.sample
		posi.delete(posi_pick)
		event.moveto(posi_pick[0],posi_pick[1])
		if event.region_id == 31
			event.turn_toward_character(get_character(tmpTortureRackL_ID))
		else
			event.direction = 8
		end
		event.set_manual_move_type(0)
		event.move_type = 0
	}
elsif tmpQ1
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:Obs]
		next if event.deleted?
		next if event.npc.action_state == :death
		next event.delete if [true,false].sample && $game_date.night?
		posi_pick = posi.sample
		posi.delete(posi_pick)
		event.moveto(posi_pick[0],posi_pick[1])
		event.set_manual_move_type(:move_search_player)
		event.move_type = :move_search_player
	}
end

$game_map.interpreter.map_background_color
if $story_stats["ReRollHalfEvents"] ==1
	st_id=$game_map.get_storypoint("StartPoint")[2]
	fadeout=$story_stats["ReRollHalfEvents"] ==1
	enter_static_tag_map(st_id,fadeout)
end
summon_companion
$story_stats["LimitedNapSkill"] = 1
eventPlayEnd
get_character(0).erase
