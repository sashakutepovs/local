
call_msg("TagMapSMRefugeeCamp:GoblinRelease/Begin1")
if $game_player.record_companion_name_front == "UniqueGrayRat"
	call_msg("TagMapSMRefugeeCamp:GoblinRelease/UniqueGrayRat")
	return eventPlayEnd
elsif $game_player.record_companion_name_front == "CompOrkindSlayer"
	call_msg("TagMapSMRefugeeCamp:GoblinRelease/CompOrkindSlayer")
	return eventPlayEnd
end
$story_stats["RecQuestSMRefugeeCampCBT"] = -1
portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	$story_stats["OnRegionMapSpawnRace"] = "Orkind"
	$story_stats["RapeLoop"] = 1
	$story_stats["WildDangerous"] +=1000
	$game_map.events.each{|event|
		next if !event[1].summon_data
		next if !event[1].summon_data[:GobliToy]
		next if event[1].deleted?
		EvLib.sum("RandomGoblin",event[1].x,event[1].y) if event[1].npc?
		event[1].delete
	}
	3.times{
		SndLib.sound_equip_armor(90)
		wait(40+rand(20))
	}
	5.times{
		$game_map.npcs.each do |event|
			next if event.summon_data == nil
			next unless event.summon_data[:WildnessNapEvent] == "Orkind"
			next if event.actor.action_state == :death
			event.npc_story_mode(true)
			event.move_toward_xy($game_player.x,$game_player.y)
		end
		wait(1)
	}
	wait(2)
	$game_map.npcs.each do |event|
		next if event.summon_data == nil
		next unless event.summon_data[:WildnessNapEvent] == "Orkind"
		next if event.actor.action_state == :death
		event.npc_story_mode(false)
		event.turn_toward_character($game_player)
		#event.npc.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],120)
	end
chcg_background_color(0,0,0,255,-7)

call_msg("TagMapSMRefugeeCamp:GoblinRelease/Begin2")
SndLib.sound_goblin_spot(90)

tmpGob=nil
$game_map.npcs.any?{|event|
	next if event.summon_data == nil
	next unless event.summon_data[:WildnessNapEvent] == "Orkind"
	next if event.actor.action_state == :death
	tmpGob = event
}
tmpGob.call_balloon(5)
tmpGob.npc_story_mode(true)
tmpGob.move_type = 0
wait(60)
until tmpGob.near_the_target?(temp_target=$game_player,temp_range=2)
	tmpGob.turn_toward_character($game_player) ; tmpGob.move_forward_force ;wait(15)
end
$game_player.turn_toward_character(tmpGob)
tmpGob.turn_toward_character($game_player)
call_msg("TagMapSMRefugeeCamp:GoblinRelease/Begin3") ; portrait_hide
tmpGob.turn_toward_character($game_player)
tmpGob.animation = tmpGob.animation_atk_mh
wait(8)
SndLib.sound_punch_hit(100)
lona_mood "p5crit_damage"
$game_player.actor.portrait.shake
$game_player.actor.force_stun("Stun6") #stun 6
$game_player.actor.add_state("DoormatUp20")#doormat
$game_player.actor.add_state("DoormatUp20")#doormat
$game_player.actor.sta -= 50
wait(22)
tmpGob.npc_story_mode(false)
tmpGob.move_type = 1

$game_map.npcs.each do |event|
	next if event.summon_data == nil
	next unless event.summon_data[:WildnessNapEvent] == "Orkind"
	next if event.actor.action_state == :death
	event.call_balloon(4)
	#event.npc.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],20)
end
SndLib.sound_goblin_spot(90)
wait(40)
eventPlayEnd
