tmpMobAlive = $game_map.npcs.any?{
|event| 
next unless event.summon_data
next unless event.summon_data[:slave]
next if event.deleted?
next if event.npc.action_state == :death
true
}
tmpFishPPLAlive = $game_map.npcs.any?{
|event| 
next unless event.summon_data
next unless event.summon_data[:WildnessNapEvent] == "FishPPL"
next if event.deleted?
next if event.npc.action_state == :death
true
}
tmpDeeponeAlive = $game_map.npcs.any?{
|event| 
next unless event.summon_data
next unless event.summon_data[:WildnessNapEvent] == "Fishkind"
next if event.deleted?
next if event.npc.action_state == :death
true
}
totalSlave = 0
$game_map.npcs.each{
|event|
	next unless event.summon_data
	next unless event.summon_data[:slave]
	next if event.deleted?
	next if event.npc.action_state == :death
	totalSlave += 1
}
tmpMcID = $game_map.get_storypoint("MapCont")[2]
tmpCapX,tmpCapY,tmpCapID = $game_map.get_storypoint("Capture")
if tmpMobAlive && totalSlave >= 10 && $story_stats["Captured"] == 0 && ($game_player.player_slave? || $game_player.actor.weak > 50)
	$story_stats["Captured"] = 1
	get_character(tmpMcID).summon_data[:CapAsFood] = false
	get_character(tmpMcID).summon_data[:talked] = true
	get_character(tmpMcID).summon_data[:enemy] = false
	chcg_background_color(0,0,0,0,7)
	map_background_color(0,0,0,255,0)
	call_msg("TagMapFishEscSlave:Nap/Friendly")
	portrait_hide
	handleNap
elsif tmpMobAlive && $story_stats["Captured"] == 0
	$story_stats["Captured"] = 1
	get_character(tmpMcID).summon_data[:CapAsFood] = true
	get_character(tmpMcID).summon_data[:talked] = true
	get_character(tmpMcID).summon_data[:enemy] = true
	chcg_background_color(0,0,0,0,7)
	map_background_color(0,0,0,255,0)
	call_msg("TagMapFishEscSlave:Nap/Enemy")
	rape_loop_drop_item(false,false)
	portrait_hide
	handleNap
elsif tmpMobAlive && (get_character(tmpMcID).summon_data[:CapAsFood] == true || get_character(tmpMcID).summon_data[:enemy] == true)
	portrait_hide
	SndLib.bgm_stop
	SndLib.bgs_stop
	chcg_background_color(20,0,0,0,2)
	tmpSndLoop = 0
	4.times{
		$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
		SndLib.sound_gore(100)
		SndLib.sound_combat_hit_gore(70)
		wait(20+rand(20))
	}
	call_msg("TagMapFishEscSlave:gameOver/nap0")
	chcg_background_color(0,0,0,255)
	return load_script("Data/HCGframes/OverEvent_Death.rb")
	
elsif tmpDeeponeAlive
	$story_stats["RapeLoop"] = 1
	$story_stats["Captured"] = 0
	tmp_x,tmp_y=$game_map.get_storypoint("WakeUp")
	$game_player.moveto(tmp_x,tmp_y)
	$story_stats["RapeLoop"] =1
	$story_stats["OnRegionMapSpawnRace"] = "Fishkind"
	$story_stats["Kidnapping"] =1
	$game_player.actor.sta =-100
	region_map_wildness_nap
elsif tmpFishPPLAlive
	$story_stats["Captured"] = 0
	tmp_x,tmp_y=$game_map.get_storypoint("WakeUp")
	$game_player.moveto(tmp_x,tmp_y)
	$story_stats["RapeLoop"] = 1
	$story_stats["OnRegionMapSpawnRace"] = "FishPPL"
	$story_stats["Kidnapping"] =1
	$game_player.actor.sta =-100
	region_map_wildness_nap
else
	$story_stats["Captured"] = 0
	handleNap
end