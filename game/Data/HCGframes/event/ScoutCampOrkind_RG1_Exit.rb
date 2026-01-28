if $story_stats["QuProgScoutCampOrkind"] != 3 && $story_stats["GuildCompletedScoutCampOrkind"] < 1 && $story_stats["QuProgScoutCampOrkind"] != 0
	call_msg("TagMapScoutCampOrkind:Guide/QuestNotDone")
end

tmpQ1 = $story_stats["HostageSaved"]["HostageSavedRich"]
tmpQ2 = $story_stats["HostageSaved"]["HostageSavedCommoner"]
tmpQ3 = $story_stats["HostageSaved"]["HostageSavedMoot"]
tmpResult = tmpQ1+tmpQ2+tmpQ3
if tmpResult >= get_character(0).summon_data[:HostageVal]+5
	GabeSDK.getAchievement("SavedScoutCampOrkind_1")
end

change_map_tag_map_exit(true)
