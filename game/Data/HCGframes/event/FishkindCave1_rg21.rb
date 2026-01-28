
tmpQ1 = [3,4].include?($story_stats["RecQuestAriseVillageFish"])
tmpQ2 = $game_player.record_companion_name_ext == "AriseVillageCompExtConvoy"
if tmpQ1 && tmpQ2
	$story_stats["RecQuestAriseVillageFish"] = 5
	tmpCamID = $game_map.get_storypoint("Cam")[2]
	tmpCa1X,tmpCa1Y,tmpCa1ID = $game_map.get_storypoint("Ca1")
	tmpCa2X,tmpCa2Y,tmpCa2ID = $game_map.get_storypoint("Ca2")
	tmpEnter2X,tmpEnter2Y,tmpEnter2ID = $game_map.get_storypoint("Enter2")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character($game_player.get_followerID(-1)).moveto($game_player.x-1,$game_player.y)
		get_character($game_player.get_followerID(-1)).direction = 6
		$game_player.direction = 6
		cam_follow(tmpCamID,0)
	chcg_background_color(0,0,0,255,-7)
	get_character(tmpCamID).npc_story_mode(true)
	get_character(tmpCamID).moveto($game_player.x,$game_player.y)
	$game_player.direction = 4
	call_msg("TagMapPB_FishCampA:AriseVillageFish/4to5_0") ; portrait_hide
	$game_player.direction = 6
	cam_follow(tmpCamID,0)
	get_character(tmpCamID).movetoRolling(tmpCa1X,tmpCa1Y)
	until !get_character(tmpCamID).moving?
		wait(1)
	end
	$game_player.direction = 6
	call_msg("TagMapPB_FishCampA:AriseVillageFish/4to5_1") ; portrait_hide
	get_character(tmpCamID).movetoRolling(tmpEnter2X,tmpEnter2Y)
	until !get_character(tmpCamID).moving?
		wait(1)
	end
	call_msg("TagMapPB_FishCampA:AriseVillageFish/4to5_2") ; portrait_hide
	get_character(tmpCamID).movetoRolling(tmpCa2X,tmpCa2Y)
	until !get_character(tmpCamID).moving?
		wait(1)
	end
	call_msg("TagMapPB_FishCampA:AriseVillageFish/4to5_3")
	get_character(tmpCamID).movetoRolling($game_player.x,$game_player.y)
	until !get_character(tmpCamID).moving?
		wait(1)
	end
	$game_player.direction = 4
	call_msg("TagMapPB_FishCampA:AriseVillageFish/4to5_4")
	get_character(tmpCamID).npc_story_mode(false)
	eventPlayEnd
end

get_character(0).erase