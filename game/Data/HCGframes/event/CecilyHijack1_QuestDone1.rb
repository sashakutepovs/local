return get_character(0).erase if $story_stats["UniqueCharUniqueGrayRat"] == -1
return get_character(0).erase if $story_stats["UniqueCharUniqueCecily"] == -1


tmpCecilyID=$game_player.get_followerID(0)
tmpGrayRarID=$game_player.get_followerID(1)
tmpSc1ID=$game_map.get_storypoint("SlaveCart1")[2]
tmpSc2ID=$game_map.get_storypoint("SlaveCart2")[2]
tmpSc3ID=$game_map.get_storypoint("SlaveCart3")[2]
tmpWakeUpX,tmpWakeUpY,tmpWakeUpID=$game_map.get_storypoint("WakeUp")

#delete all BanditGuard
chcg_background_color(0,0,0,0,7)
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:BanditGuard]
		event.delete if event.npc.action_state != :death
	}
	
	$game_player.moveto(tmpWakeUpX,tmpWakeUpY)
	$game_player.direction = 2
	get_character(tmpCecilyID).follower[1] =0
	get_character(tmpGrayRarID).follower[1] =0
	get_character(tmpCecilyID).moveto(tmpWakeUpX+1,tmpWakeUpY)
	get_character(tmpGrayRarID).moveto(tmpWakeUpX-1,tmpWakeUpY)
	get_character(tmpCecilyID).direction = 2
	get_character(tmpGrayRarID).direction = 2
chcg_background_color(0,0,0,255,-7)

get_character(tmpSc1ID).call_balloon(28,-1)
get_character(tmpSc2ID).call_balloon(28,-1)
get_character(tmpSc3ID).call_balloon(28,-1)
get_character(tmpSc1ID).trigger = 0
get_character(tmpSc2ID).trigger = 0
get_character(tmpSc3ID).trigger = 0
$game_map.events.each{|event|
	next if !event[1].summon_data
	next if event[1].summon_data[:cart] != true
	event[1].trigger = 0
}
call_msg("TagMapCecilyHijack:Part2/SpotQuWin")
portrait_hide
cam_center(0)