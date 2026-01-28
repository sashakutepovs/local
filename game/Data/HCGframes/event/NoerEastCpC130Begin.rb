return get_character(0).erase if $story_stats["RecQuestC130"] !=0
yellX,yellY,yellID=$game_map.get_storypoint("YellingGuard")
return get_character(0).erase if get_character(yellID).nil?
return get_character(0).erase if !get_character(yellID).npc?
return get_character(0).erase if !get_character(yellID).summon_data
return get_character(0).erase if !get_character(yellID).summon_data[:Yeller]
return get_character(0).erase if get_character(yellID).npc.alert_level != 0
return get_character(0).erase if get_character(yellID).npc.action_state == :death
return get_character(0).erase if $game_map.threat

$story_stats["RecQuestC130"] = 1
get_character(yellID).turn_toward_character($game_player)
call_msg("TagMapNoerEastCp:yeller/start")
get_character(yellID).direction = 2
portrait_hide
get_character(0).erase