

tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
get_character(tmpWakeUpID).switch2_id[2] = 1
$game_map.npcs.each do |event|
 next if event.summon_data == nil
 next if !event.summon_data[:customer] && !event.summon_data[:NapFucker]
 next if event.actor.action_state == :death
 event.call_balloon(28,-1)
end
call_msg("TagMapBanditCamp1:HevWhore/begin2")






