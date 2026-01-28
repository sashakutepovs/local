
if $story_stats["RecQuestSouthFLMain"] == 8
	$story_stats["RecQuestSouthFLMain"] = 9
	tmpExitX,tmpExitY,tmpExitID = $game_map.get_storypoint("Exit")
	tmpG1stX,tmpG1stY,tmpG1stID = $game_map.get_storypoint("guard1ST")
	tmpG2stX,tmpG2stY,tmpG2stID = $game_map.get_storypoint("guard2ST")
	tmpLeaderX,tmpLeaderY,tmpLeaderID = $game_map.get_storypoint("Leader")
	chcg_background_color(0,0,0,0,7)
		$game_map.npcs.each{|event|
			next unless event.summon_data
			next unless event.summon_data[:WildnessNapEvent] == "HumanGuard"
			next if event.deleted?
			event.opacity = 0
		}
		$game_player.moveto(tmpExitX-3,tmpExitY)
		$game_player.direction = 6
		get_character(tmpG1stID).moveto(tmpExitX-5,tmpExitY-1)
		get_character(tmpG2stID).moveto(tmpExitX-5,tmpExitY+1)
		get_character(tmpG1stID).move_type = 0
		get_character(tmpG2stID).move_type = 0
		get_character(tmpG1stID).direction = 6
		get_character(tmpG2stID).direction = 6
		get_character(tmpG1stID).npc_story_mode(true,true)
		get_character(tmpG2stID).npc_story_mode(true,true)
		get_character(tmpLeaderID).npc_story_mode(true,true)
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapSpawnPoolR:Qprog8/spotHiveEnd0") ; portrait_hide
	$game_player.direction = 4
	call_msg("TagMapSpawnPoolR:Qprog8/spotHiveEnd1") ; portrait_hide
	get_character(tmpG1stID).direction = 2
	get_character(tmpG2stID).direction = 8
	call_msg("TagMapSpawnPoolR:Qprog8/spotHiveEnd2") ; portrait_hide
	get_character(tmpLeaderID).moveto(tmpExitX-15,tmpExitY)
	8.times{
		get_character(tmpG1stID).call_balloon(8)
		wait(5)
		get_character(tmpG2stID).call_balloon(8)
		get_character(tmpLeaderID).direction = 6 ; get_character(tmpLeaderID).move_forward_force
		wait(10)
	}
	call_msg("TagMapSpawnPoolR:Qprog8/spotHiveEnd3") ; portrait_hide
	get_character(tmpG1stID).direction = 4
	get_character(tmpG2stID).direction = 4
	get_character(tmpG1stID).call_balloon(1)
	get_character(tmpG2stID).call_balloon(1)
	wait(20)
	get_character(tmpG1stID).call_balloon(8)
	wait(40)
	call_msg("TagMapSpawnPoolR:Qprog8/spotHiveEnd4")
	
	SndLib.me_play("SE/Move",75,120+rand(31))
	portrait_hide
	chcg_background_color(0,0,0,0,14)
	portrait_off
	call_msg("TagMapSpawnPoolR:Qprog8/spotHiveEnd5")
	change_map_leave_tag_map
else
	change_map_tag_map_exit
end