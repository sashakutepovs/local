GabeSDK.getAchievement("RecQuestLisaSaintCall_0")
call_msg("CompLisa:Lisa11/Win0")
portrait_hide
tmpOffX,tmpOffY,tmpOffID=$game_map.get_storypoint("officer")
return if get_character(tmpOffID).nil?
return if !get_character(tmpOffID).npc?
return if !get_character(tmpOffID).summon_data
return if !get_character(tmpOffID).summon_data[:officer]
return if get_character(tmpOffID).npc.alert_level != 0
return if get_character(tmpOffID).npc.action_state == :death
get_character(tmpOffID).call_balloon(28,-1)
$story_stats["RecQuestLisa"] = 11
$story_stats["RecQuestLisaSaintCall"] = 0
set_this_event_force_page(8)