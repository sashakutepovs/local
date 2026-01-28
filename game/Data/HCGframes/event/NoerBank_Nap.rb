tmpMobAlive = $game_map.npcs.any?{
	|event| 
	next unless event.summon_data
	next unless event.summon_data[:WildnessNapEvent]
	next if event.deleted?
	next if event.npc.action_state == :death
	true
}
if !tmpMobAlive
	region_map_wildness_nap
elsif $game_player.actor.morality >= 30
	call_msg("TagMapBank:NapBank/talk#{rand(3)}")
	call_msg("TagMapBank:NapBank/talk_end")
	portrait_hide
	change_map_leave_tag_map
else
	$game_player.actor.morality_lona = 29 if $game_player.actor.morality_lona >29
	check_enemy_survival?
	$story_stats["OnRegionMapSpawnRace"] = "HumanGuard"
	$story_stats["RapeLoop"] =1
	$story_stats["Kidnapping"] =1
	$game_player.actor.sta =-100
	call_msg("OvermapEvents:NobleGateGuard/NapCapture")
	region_map_wildness_nap
end
