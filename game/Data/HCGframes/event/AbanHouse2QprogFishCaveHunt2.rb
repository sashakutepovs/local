tmpSkip =false
tmpSummon_mob = false
tmpSpX,tmpSpY,tmpSpID=$game_map.get_storypoint("StartPoint")
tmpMcX,tmpMcY,tmpMcID=$game_map.get_storypoint("MapCont")
yellX,yellY,yellID=$game_map.get_storypoint("YellingGuard")
if $story_stats["RecQuestFishCaveHunt2"] == 0
	tmpSkip = true if get_character(yellID).nil?
	tmpSkip = true if !get_character(yellID).npc?
	tmpSkip = true if !get_character(yellID).summon_data
	tmpSkip = true if !get_character(yellID).summon_data[:Yeller]
	tmpSkip = true if get_character(yellID).npc.alert_level != 0
	tmpSkip = true if get_character(yellID).npc.action_state == :death
	tmpSkip = true if $game_map.threat
	
	if !tmpSkip
		get_character(yellID).turn_toward_character($game_player)
		call_msg("TagMapAbanHouse2:yeller/start")
		get_character(yellID).direction = 2
	end
	$story_stats["RecQuestFishCaveHunt2"] = 1
	tmpSummon_mob = true
elsif $story_stats["RecQuestFishCaveHunt2"] == 1
	tmpSummon_mob = true
	
end

tmpTodoCount = 0
if tmpSummon_mob
	$game_map.npcs.each{
	|event|
		next unless event.summon_data
		next unless event.summon_data[:wave2]
		next if event.deleted?
		set_event_force_page(event.id,1)
		event.moveto(tmpSpX-1+tmpTodoCount,tmpSpY+1)
		event.direction = 8
		tmpTodoCount +=1
	}
	call_msg("TagMapAbanHouse2:yeller/start1")
	SndLib.bgm_play("CB_Big Percussion LOOP",70)
	call_timer(6,60)
	set_event_force_page(tmpMcID,5)
	
end


cam_center(0)
portrait_hide
get_character(0).erase