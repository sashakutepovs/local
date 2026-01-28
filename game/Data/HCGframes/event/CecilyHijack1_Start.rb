return get_character(0).erase if $story_stats["UniqueCharUniqueGrayRat"] == -1
return get_character(0).erase if $story_stats["UniqueCharUniqueCecily"] == -1
tmpScoutPTX,tmpScoutPTY,tmpScoutPTID=$game_map.get_storypoint("ScoutPT")
tmpMaaniG1X,tmpMaaniG1Y,tmpMaaniG1ID=$game_map.get_storypoint("MaaniG1")
tmpMaaniX,tmpMaaniY,tmpMaaniID=$game_map.get_storypoint("Maani")
tmpMaaniG2X,tmpMaaniG2Y,tmpMaaniG2ID=$game_map.get_storypoint("MaaniG2")
tmpFatManX,tmpFatManY,tmpFatManID=$game_map.get_storypoint("FatMan")
tmpStory1X,tmpStory1Y,tmpStory1ID=$game_map.get_storypoint("Story1")
tmpMcX,tmpMcY,tmpMcID=$game_map.get_storypoint("MapCont")
tmpCecilyID=$game_player.get_followerID(0)
tmpGrayRarID=$game_player.get_followerID(1)

chcg_background_color(0,0,0,0,7)
	$game_player.moveto(tmpScoutPTX,tmpScoutPTY)
	get_character(tmpCecilyID).moveto(tmpScoutPTX,tmpScoutPTY-1)
	get_character(tmpGrayRarID).moveto(tmpScoutPTX-1,tmpScoutPTY-1)
	get_character(tmpCecilyID).direction = 2
	get_character(tmpGrayRarID).direction = 2
chcg_background_color(0,0,0,255,-7)

call_msg("TagMapCecilyHijack:Part2/SpotQuAcc0")

if $story_stats["UniqueCharUniqueMaani"] != -1 && $story_stats["RecQuestMilo"] != 11
	chcg_background_color(0,0,0,0,7)
		get_character(tmpFatManID).moveto(tmpStory1X,tmpStory1Y+1)
		get_character(tmpMaaniG1ID).moveto(tmpStory1X+3,tmpStory1Y)
		get_character(tmpMaaniID).moveto(tmpStory1X+3,tmpStory1Y+1)
		get_character(tmpMaaniG2ID).moveto(tmpStory1X+3,tmpStory1Y+2)
		get_character(tmpMaaniG1ID).npc_story_mode(true)
		get_character(tmpMaaniID).npc_story_mode(true)
		get_character(tmpMaaniG2ID).npc_story_mode(true)
	chcg_background_color(0,0,0,255,-7)
	cam_follow(tmpMaaniID,0)
	portrait_hide
	get_character(tmpMaaniG1ID).move_forward
	get_character(tmpMaaniID).move_forward
	get_character(tmpMaaniG2ID).move_forward
	wait(30)
	get_character(tmpMaaniG1ID).move_forward
	get_character(tmpMaaniID).move_forward
	get_character(tmpMaaniG2ID).move_forward
	wait(30)
	portrait_off
	call_msg("TagMapCecilyHijack:Part2/SpotQuAcc0_Maani0")
	chcg_background_color(0,0,0,0,7)
		call_msg("TagMapCecilyHijack:Part2/SpotQuAcc0_Maani1")
		get_character(tmpFatManID).moveto(tmpFatManX,tmpFatManY)
		get_character(tmpMaaniG1ID).moveto(tmpMaaniG1X,tmpMaaniG1Y)
		get_character(tmpMaaniID).moveto(tmpMaaniX,tmpMaaniY)
		get_character(tmpMaaniG2ID).moveto(tmpMaaniG2X,tmpMaaniG2Y)
		get_character(tmpMaaniG1ID).npc_story_mode(false)
		get_character(tmpMaaniID).npc_story_mode(false)
		get_character(tmpMaaniG2ID).npc_story_mode(false)
		portrait_hide
		cam_center(0)
	chcg_background_color(0,0,0,255,-7)
end

call_msg("TagMapCecilyHijack:part2/SpotQuAcc1") #[敲暈他們,不行]
if $game_temp.choice == 0
	call_msg("TagMapCecilyHijack:part2/SpotQuAcc1_yes")
	get_character(tmpCecilyID).follower[1] =0
	get_character(tmpGrayRarID).follower[1] =0
else
	call_msg("TagMapCecilyHijack:part2/SpotQuAcc1_no")
end
call_msg("TagMapCecilyHijack:part2/SpotQuAcc2_board")


set_event_force_page(tmpMcID,4) #QuestCount set page


cam_center(0)
portrait_hide
get_character(0).erase