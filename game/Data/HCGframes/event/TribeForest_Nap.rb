tmpMobAlive = $game_map.npcs.any?{|event|
	next unless event.summon_data
	next unless event.summon_data[:WildnessNapEvent] == "GaintBoar"
	next if event.deleted?
	next if event.npc.action_state == :death
	true
}
tmpMobAliveOrkind = $game_map.npcs.any?{|event|
next unless event.summon_data
next unless event.summon_data[:WildnessNapEvent] == "Orkind"
next if event.deleted?
next if event.npc.action_state == :death
true
}

#todo if not nude then dead
if tmpMobAlive
	portrait_hide
	chcg_background_color(0,0,0,0,7)
	portrait_off
	6.times{
		$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
		SndLib.sound_gore(100)
		SndLib.pigHurt(80)
		SndLib.sound_combat_hit_gore(70)
		wait(20+rand(20))
	}
	call_msg("TagMapTribeForest:Nap/GameOver1")
	return load_script("Data/HCGframes/OverEvent_Death.rb")
	#game_over
elsif tmpMobAliveOrkind
	portrait_hide
	chcg_background_color(0,0,0,0,7)
	portrait_off
	$story_stats["RapeLoop"] =1
	$story_stats["OnRegionMapSpawnRace"] = "Orkind"
	$story_stats["Kidnapping"] =1
	$game_player.actor.sta =-100
	region_map_wildness_nap
else
	handleNap
end