get_character(0).call_balloon(0)
call_msg("commonEnding:Lisa/common0")
if $story_stats["RecQuestLisa"] == 18
 call_msg("commonEnding:Lisa/RecQuestLisa18ResetMem1")
 call_msg("commonEnding:Lisa/RecQuestLisa18ResetMem2")
 call_msg("commonEnding:Lisa/RecQuestLisa18ResetMem3")
elsif $story_stats["RecQuestLisa"] == 19
 call_msg("commonEnding:Lisa/RecQuestLisa19KeepMem1")
 call_msg("commonEnding:Lisa/RecQuestLisa19KeepMem2")
 call_msg("commonEnding:Lisa/RecQuestLisa19KeepMem3")
end
eventPlayEnd