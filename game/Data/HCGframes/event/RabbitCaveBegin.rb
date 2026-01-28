return get_character(0).erase if $story_stats["UniqueCharUniqueKillerRabbit"] == -1
return get_character(0).erase if $story_stats["RecQuestKillerRabbit"] >=1
yellX,yellY,yellID=$game_map.get_storypoint("MerA")
rabbitX,rabbitY,rabbitID=$game_map.get_storypoint("KillerRabbit")
runnerX,runnerY,runnerID=$game_map.get_storypoint("Runner")
startX,startY,startID=$game_map.get_storypoint("StartPoint")
priestX,priestY,priestID=$game_map.get_storypoint("Priest")
return get_character(0).erase if get_character(yellID).nil?
return get_character(0).erase if !get_character(yellID).npc?
return get_character(0).erase if get_character(yellID).npc.alert_level != 0
return get_character(0).erase if get_character(yellID).npc.action_state == :death
return get_character(0).erase if $game_map.threat

$story_stats["RecQuestKillerRabbit"] = 1
portrait_hide
call_msg("TagMapRabbitCave:yeller/start")
get_character(rabbitID).npc_story_mode(true)
get_character(runnerID).npc_story_mode(true)
until get_character(rabbitID).near_the_target?(get_character(runnerID),2)
get_character(rabbitID).move_toward_event(runnerID) if !get_character(rabbitID).moving?
get_character(runnerID).move_toward_event(startID)  if !get_character(runnerID).moving?
wait(5)
end
wait(10)
call_msg("TagMapRabbitCave:yeller/start1")
get_character(rabbitID).animation = get_character(rabbitID).animation_atk_mh
SndLib.ratAtk
SndLib.sound_punch_hit
SndLib.sound_MaleWarriorDed
get_character(runnerID).npc.stat.set_stat("health",-300)
get_character(runnerID).animation = get_character(runnerID).animation_overkill_melee_reciver
get_character(runnerID).setup_cropse_graphics(2)
wait(120)
call_msg("TagMapRabbitCave:yeller/start2")
get_character(runnerID).npc.refresh
until get_character(rabbitID).x == rabbitX && get_character(rabbitID).y == rabbitY
get_character(rabbitID).move_toward_xy(rabbitX,rabbitY) if !get_character(rabbitID).moving?
wait(5)
end
get_character(rabbitID).direction = 4
get_character(rabbitID).npc_story_mode(false)
get_character(runnerID).npc_story_mode(false)
call_msg("TagMapRabbitCave:yeller/start3")
cam_center(0)
get_character(priestID).call_balloon(28,-1)
portrait_hide
get_character(0).erase
