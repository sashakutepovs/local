
tmpWhoreQGiverX,tmpWhoreQGiverY,tmpWhoreQGiverID=$game_map.get_storypoint("WhoreQGiver")
tmpWhore1X,tmpWhore1Y,tmpWhore1ID=$game_map.get_storypoint("whore1")
tmpJohnX,tmpJohnY,tmpJohnID=$game_map.get_storypoint("John")

return get_character(0).erase if !get_character(tmpWhoreQGiverID)
return get_character(0).erase if !get_character(tmpJohnID)
return get_character(0).erase if ![nil,:none].include?(get_character(tmpWhoreQGiverID).npc.action_state)
return get_character(0).erase if ![nil,:none].include?(get_character(tmpJohnID).npc.action_state)
return get_character(0).erase if get_character(tmpWhoreQGiverID).npc.target != nil
return get_character(0).erase if get_character(tmpJohnID).npc.target != nil

portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	get_character(tmpJohnID).npc_story_mode(true)
	get_character(tmpWhoreQGiverID).npc_story_mode(true)
	get_character(tmpWhoreQGiverID).character_index = 0
	cam_follow(tmpWhoreQGiverID,0)
chcg_background_color(0,0,0,255,-7)


call_msg("TagMapDfRefugeeCamp:Df_Heresy/0_0")
cam_follow(tmpWhoreQGiverID,0)
get_character(tmpWhore1ID).direction = 4

get_character(tmpJohnID).direction = 2 ; get_character(tmpJohnID).move_forward_force ; wait(60)
get_character(tmpJohnID).direction = 2 ; get_character(tmpJohnID).move_forward_force ; wait(60)
get_character(tmpJohnID).direction = 2 ; get_character(tmpJohnID).move_forward_force ; wait(60)
get_character(tmpJohnID).direction = 4 ; get_character(tmpJohnID).move_forward_force
until get_character(tmpJohnID).opacity <= 0
	get_character(tmpJohnID).opacity -= 5
	wait(1)
end
call_msg("TagMapDfRefugeeCamp:Df_Heresy/0_1")
portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	cam_center(0)
	$story_stats["RecQuestDf_HeresyMomo"] = 1
	get_character(tmpJohnID).npc_story_mode(false)
	get_character(tmpWhoreQGiverID).npc_story_mode(false)
	get_character(tmpJohnID).delete
	get_character(tmpWhoreQGiverID).call_balloon(28,-1) if !($game_player.actor.weak >= 50)
	get_character(tmpWhore1ID).direction = 2
chcg_background_color(0,0,0,255,-7)

get_character(0).erase