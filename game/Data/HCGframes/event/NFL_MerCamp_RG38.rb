return if $story_stats["UniqueChar_NFL_MerCamp_Leader"] == -1
if $story_stats["RecQuestNorthFL_AtkOrkCamp2"] == 0
	eventPlayStart
	tmpLeaderX,tmpLeaderY,tmpLeaderID = $game_map.get_storypoint("Leader")
	tmpYellingSubX,tmpYellingSubY,tmpYellingSubID = $game_map.get_storypoint("YellingSub")
	tmpPT1X,tmpPT1Y,tmpPT1ID = $game_map.get_storypoint("PT1")
	
	tmpLeaderOD = get_character(tmpLeaderID).direction
	tmpYellingSubOD = get_character(tmpYellingSubID).direction
	get_character(tmpLeaderID).moveto(tmpLeaderX,tmpLeaderY)
	get_character(tmpYellingSubID).moveto(tmpYellingSubX,tmpYellingSubY)
	get_character(tmpLeaderID).npc_story_mode(true)
	get_character(tmpYellingSubID).npc_story_mode(true)
	
	
	
	get_character(tmpYellingSubID).moveto(tmpYellingSubX+2,tmpYellingSubY)
	call_msg("TagMapNFL_MerCamp:NorthFL_AtkOrkCamp/0_1")
	portrait_hide
	6.times{
			$game_player.turn_random if [true,false].sample
			get_character(tmpYellingSubID).move_speed = 5
			get_character(tmpYellingSubID).direction = 6 
			get_character(tmpYellingSubID).move_forward_force
		until !get_character(tmpYellingSubID).moving?
			wait(1)
		end
	}
	get_character(tmpYellingSubID).turn_toward_character($game_player)
	$game_player.turn_toward_character(get_character(tmpYellingSubID))
	SndLib.sound_equip_armor(100)
	get_character(tmpYellingSubID).animation = get_character(tmpYellingSubID).aniCustom([[8, 6, 4, 1,0], [8, 6, 2, 0, 0], ],-1)
	call_msg("TagMapNFL_MerCamp:NorthFL_AtkOrkCamp/0_2")
	portrait_hide
	get_character(tmpLeaderID).moveto(tmpYellingSubX+2,tmpYellingSubY+1)
	5.times{
			get_character(tmpLeaderID).move_speed = 5
			get_character(tmpLeaderID).direction = 6 
			get_character(tmpLeaderID).move_forward_force
		until !get_character(tmpLeaderID).moving?
			wait(1)
		end
	}
	get_character(tmpYellingSubID).animation = nil
	get_character(tmpYellingSubID).direction = 4
	call_msg("TagMapNFL_MerCamp:NorthFL_AtkOrkCamp/0_3")
	get_character(tmpYellingSubID).direction = 6
	call_msg("TagMapNFL_MerCamp:NorthFL_AtkOrkCamp/0_4")
	
	portrait_hide
	get_character(tmpLeaderID).call_balloon(8)
	get_character(tmpYellingSubID).call_balloon(8)
	$game_player.call_balloon(8)
	wait(120)
	
	call_msg("TagMapNFL_MerCamp:NorthFL_AtkOrkCamp/0_5")
	
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpLeaderID).moveto(tmpLeaderX,tmpLeaderY)
		get_character(tmpYellingSubID).moveto(tmpYellingSubX,tmpYellingSubY)
		get_character(tmpLeaderID).npc_story_mode(false)
		get_character(tmpYellingSubID).npc_story_mode(false)
		get_character(tmpLeaderID).direction = tmpLeaderOD
		get_character(tmpYellingSubID).direction = tmpYellingSubOD
		get_character(tmpLeaderID).call_balloon(28,-1)
	chcg_background_color(0,0,0,255,-7)
	
	$story_stats["RecQuestNorthFL_AtkOrkCamp2"] = 1
	eventPlayEnd
	
end