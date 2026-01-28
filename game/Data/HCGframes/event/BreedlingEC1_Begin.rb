
$story_stats["OverMapEvent_saw"] = 1
$story_stats["OnRegionMapSpawnRace"] = "AbomBreedlingTrap"
tmpTimes = 4
tmpTimes += ($story_stats["WorldDifficulty"] / 30).to_i
tmpTimes.times{
	posi=$game_map.region_map[19].sample
	EvLib.sum("AbomCreatureBreedling",posi[0],posi[1],{:mobs=>true})
}
tmpSTx,tmpSTy,tmpSTid=$game_map.get_storypoint("StartPoint")
tmpMCx,tmpMCy,tmpMCid=$game_map.get_storypoint("MapCount")

enter_static_tag_map
cam_follow(tmpSTid,0)
$game_player.turn_random
$game_player.moveto(tmpSTx,tmpSTy-10)
chcg_background_color(0,0,0,255,-7)

$game_player.jump_to(tmpSTx,tmpSTy)
wait(35)
SndLib.sound_punch_hit(90)
SndLib.WaterIn(90)
$game_player.set_animation("animation_stun")
$game_player.call_balloon(14)


lona_mood "p5health_damage"
$game_player.actor.portrait.shake
call_msg("commonH:Lona/grab_mouth_block0")

$game_player.call_balloon(1)
$game_player.animation = nil
cam_center(0)
summon_companion
eventPlayEnd
set_event_force_page(tmpMCid,3)

$story_stats["OverMapEvent_saw"] = 1
$story_stats["LimitedNapSkill"] = 1
$story_stats["OverMapEvent_name"] = "_bad_AbomBreedlingTrap"
$story_stats["OnRegionMapSpawnRace"] = "AbomBreedlingTrap"

$game_map.npcs.each{|event|
	next unless event.summon_data
	next unless event.summon_data[:mobs]
	next if event.deleted?
	next if event.npc.action_state == :death
	event.turn_toward_character($game_player)
	event.call_balloon(1)
}
SndLib.BreedlingSpot
SndLib.bgm_play("D/Arena-Industrial Combat LAYER12",90)