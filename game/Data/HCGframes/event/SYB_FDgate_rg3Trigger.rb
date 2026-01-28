if $story_stats["QuProgSybFDgate"] == 0 #TODO 檢測故事變數
	$story_stats["QuProgSybFDgate"] = 1
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		call_msg("TagMapSybFDgate:QuProgSybBarn2/begin1")
		tmpYellerX,tmpYellerY,tmpYellerID=$game_map.get_storypoint("Yeller")
		tmpMainGuardX,tmpMainGuardY,tmpMainGuardID=$game_map.get_storypoint("MainGuard")
		cam_follow(tmpYellerID,0)
		$game_player.moveto(tmpYellerX,tmpYellerY+8)
		$game_player.direction = 8
	chcg_background_color(0,0,0,255,-7)
	5.times{
		$game_player.move_normal
		$game_player.move_speed= 3
		$game_player.move_forward_force
		wait(30)
	}
	call_msg("TagMapSybFDgate:QuProgSybBarn2/begin2")
	wait(30)
	$game_player.call_balloon(8)
	wait(60)
	call_msg("TagMapSybFDgate:QuProgSybBarn2/begin3")
	#get_character(tmpYellerID).call_balloon(8,-1)
	#get_character(tmpMainGuardID).call_balloon(8,-1)
end
eventPlayEnd
get_character(0).erase
#SybBarn