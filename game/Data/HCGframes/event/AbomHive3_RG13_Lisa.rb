return get_character(0).erase if $story_stats["RecQuestLisa"] != 12
return get_character(0).erase if $story_stats["Captured"] == 1
return get_character(0).erase if $game_date.dateAmt >= $story_stats["RecQuestLisaAmt"]
return get_character(0).erase if $story_stats["UniqueCharUniqueElise"] == -1
return get_character(0).erase if $story_stats["UniqueCharUniqueLisa"] == -1
eventPlayEnd


tmpLisaX,tmpLisaY,tmpLisaID=$game_map.get_storypoint("Lisa")
tmpLisaAimX,tmpLisaAimY,tmpLisaAimID=$game_map.get_storypoint("LisaAim")
$game_player.direction = 8
get_character(tmpLisaID).call_balloon(28,-1)
get_character(tmpLisaAimID).npc_story_mode(true)
cam_follow(tmpLisaAimID,0)
6.times{
	get_character(tmpLisaAimID).direction = 8 ; get_character(tmpLisaAimID).move_forward_force ; wait(32)
}
call_StoryHevent("RecHevLisaAbomHive3","HevLisaAbomHive3")
call_msg("CompLisa:Lisa12/rg13_end")
eventPlayEnd
get_character(tmpLisaAimID).npc_story_mode(false)
get_character(0).erase