tmpMobAliveSaint = $game_map.npcs.any?{
|event| 
	next unless event.summon_data
	next unless event.summon_data[:SaintBro]
	next if event.deleted?
	next if event.npc.action_state == :death
	next if event.npc.action_state == :stun
	true
}
tmpMobAlive = $game_map.npcs.any?{
|event| 
	next unless event.summon_data
	next unless event.summon_data[:WildnessNapEvent]
	next if event.deleted?
	next if event.npc.action_state == :death
	true
}

if tmpMobAlive && [3,4].include?($game_player.region_id)
	$story_stats["OnRegionMapSpawnRace"] ="UndeadWalking"
	$story_stats["RapeLoop"] = 1
	region_map_wildness_nap
	
elsif tmpMobAliveSaint && $game_player.actor.sexy >= 10
	portrait_hide
	chcg_background_color(0,0,0,0,7)
	portrait_off
	map_background_color(0,0,0,255,0)
	$game_player.actor.addCums("CumsHead",500,"Human")
	3.times{
		SndLib.sound_chs_buchu
		wait(50)
	}
	handleNap
	tmp_x,tmp_y=$game_map.get_storypoint("WakeUp")
	$game_player.moveto(tmp_x,tmp_y)
	if [true,false].sample
		$story_stats["sex_record_cumshotted"] += 1
	else
		$story_stats["sex_record_mouth_count"] += 1
	end
else
	handleNap
end

