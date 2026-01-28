tmpMobAlive = $game_map.npcs.any?{
|event| 
next unless event.summon_data
next unless event.summon_data[:WildnessNapEvent]
next if event.deleted?
next if event.npc.action_state == :death
true
}
$story_stats["RapeLoop"] = 1 if tmpMobAlive

if $story_stats["UniqueCharUniqueKillerRabbit"] != -1
	SndLib.bgm_stop
	SndLib.bgs_stop
	portrait_hide
	chcg_background_color(20,0,0,0,2)
	12.times{
		$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
		SndLib.ratAtk if rand(100) >= 50
		SndLib.sound_gore(100)
		SndLib.sound_combat_hit_gore(70)
		wait(20+rand(20))
	}
	chcg_background_color(0,0,0,255)
	call_msg("commonEnding:KillerRabbit/Eaten")
	
	return load_script("Data/HCGframes/OverEvent_Death.rb")
elsif $story_stats["OnRegionMapSpawnRace"] != "Orkind" && $story_stats["RapeLoop"] != 1
	tmpMobAlive = $game_map.npcs.any?{
	|event| 
	next unless event.summon_data
	next unless event.summon_data[:Mercenary]
	next if event.deleted?
	next if event.npc.action_state == :death
	tmpEvent = event
	true
	}
	$game_boxes.box(System_Settings::STORAGE_TEMP_MAP).clear if tmpMobAlive
	handleNap
elsif $story_stats["RapeLoop"] == 1
	tmp_x,tmp_y=$game_map.get_storypoint("WakeUp")
	$game_player.moveto(tmp_x,tmp_y)
	$story_stats["RapeLoop"] =1
	$story_stats["OnRegionMapSpawnRace"] = "Orkind"
	$story_stats["Kidnapping"] =1
	$game_player.actor.sta =-100
	region_map_wildness_nap
else
	handleNap
end

