
tmpHeresyPriestX,tmpHeresyPriestY,tmpHeresyPriestID=$game_map.get_storypoint("HeresyPriest")
tmpHeresy1X,tmpHeresy1Y,tmpHeresy1ID=$game_map.get_storypoint("Heresy1")
tmpHeresy2X,tmpHeresy2Y,tmpHeresy2ID=$game_map.get_storypoint("Heresy2")
tmpHeresy3X,tmpHeresy3Y,tmpHeresy3ID=$game_map.get_storypoint("Heresy3")
tmpTellerX,tmpTellerY,tmpTellerID=$game_map.get_storypoint("teller")

return get_character(0).erase if !get_character(tmpHeresyPriestID)
return get_character(0).erase if ![nil,:none].include?(get_character(tmpHeresyPriestID).npc.action_state)
return get_character(0).erase if get_character(tmpHeresyPriestID).npc.target != nil



portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	$story_stats["RecQuestDf_Heresy"] = 3 if $story_stats["RecQuestDf_Heresy"] < 3
	get_character(tmpHeresyPriestID).call_balloon(0)
	get_character(tmpHeresy1ID).moveto(tmpHeresyPriestX-1,tmpHeresyPriestY+2)
	get_character(tmpHeresy2ID).moveto(tmpHeresyPriestX,tmpHeresyPriestY+2)
	get_character(tmpHeresy3ID).moveto(tmpHeresyPriestX+1,tmpHeresyPriestY+2)
	get_character(tmpHeresy1ID).opacity = 255
	get_character(tmpHeresy2ID).opacity = 255
	get_character(tmpHeresy3ID).opacity = 255
	get_character(tmpHeresy1ID).npc_story_mode(true)
	get_character(tmpHeresy2ID).npc_story_mode(true)
	get_character(tmpHeresy3ID).npc_story_mode(true)
	get_character(tmpHeresyPriestID).npc_story_mode(true)
	cam_follow(tmpHeresyPriestID,0)
chcg_background_color(0,0,0,255,-7)

call_msg("TagMapDfRefugeeCamp:Df_Heresy/2to3_1")
get_character(tmpHeresy2ID).direction =  4
call_msg("TagMapDfRefugeeCamp:Df_Heresy/2to3_2")
get_character(tmpHeresy1ID).direction =  6
call_msg("TagMapDfRefugeeCamp:Df_Heresy/2to3_3")
SndLib.sound_equip_armor
get_character(tmpHeresy1ID).animation = get_character(tmpHeresy1ID).animation_peeing
call_msg("TagMapDfRefugeeCamp:Df_Heresy/2to3_4")
SndLib.sound_equip_armor
get_character(tmpHeresy2ID).animation = get_character(tmpHeresy2ID).animation_masturbation
get_character(tmpHeresy3ID).direction = 4
call_msg("TagMapDfRefugeeCamp:Df_Heresy/2to3_5")
wait(20)
get_character(tmpHeresy1ID).animation = nil
get_character(tmpHeresy2ID).animation = nil
get_character(tmpHeresy1ID).direction = 2 ; get_character(tmpHeresy1ID).move_forward_force
get_character(tmpHeresy2ID).direction = 4 ; get_character(tmpHeresy2ID).move_forward_force
wait(40)
get_character(tmpHeresy1ID).direction = 2 ; get_character(tmpHeresy1ID).move_forward_force
get_character(tmpHeresy2ID).direction = 2 ; get_character(tmpHeresy2ID).move_forward_force
wait(40)
get_character(tmpHeresy1ID).direction = 2 ; get_character(tmpHeresy1ID).move_forward_force
get_character(tmpHeresy2ID).direction = 2 ; get_character(tmpHeresy2ID).move_forward_force
wait(40)
until get_character(tmpHeresy1ID).opacity <= 0
	get_character(tmpHeresy1ID).opacity -= 5
	get_character(tmpHeresy2ID).opacity -= 5
	wait(1)
end

get_character(tmpHeresy3ID).direction = 8 ; get_character(tmpHeresy3ID).move_forward_force
wait(60)
get_character(tmpHeresy3ID).direction = 4 ; get_character(tmpHeresy3ID).move_forward_force
wait(60)
get_character(tmpHeresy3ID).direction = 8
get_character(tmpHeresy3ID).animation = get_character(tmpHeresy3ID).animation_prayer
call_msg("TagMapDfRefugeeCamp:Df_Heresy/2to3_6")
canAcceptQuest = $story_stats["RecQuestDf_Heresy"] == 3 && ($story_stats["RecQuestDf_HeresyMomo"] == 2 || $story_stats["RecQuest_Df_TellerSide"] == 2) && !($story_stats["RecQuest_Df_TellerSide"] >2 || $story_stats["RecQuestDf_HeresyMomo"] >= 2)
portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	get_character(tmpHeresy1ID).delete
	get_character(tmpHeresy2ID).delete
	get_character(tmpHeresy3ID).delete
	get_character(tmpTellerID).call_balloon(28,-1) if $story_stats["RecQuest_Df_TellerSide"] == 0 && $story_stats["UniqueCharUniqueTeller"] != -1
	get_character(tmpHeresyPriestID).call_balloon(28,-1) if canAcceptQuest
	get_character(tmpHeresy1ID).npc_story_mode(false)
	get_character(tmpHeresy2ID).npc_story_mode(false)
	get_character(tmpHeresy3ID).npc_story_mode(false)
	get_character(tmpHeresyPriestID).npc_story_mode(false)
	get_character(tmpHeresyPriestID).set_manual_move_type(3)
	get_character(tmpHeresyPriestID).move_type = 3
	chcg_background_color(0,0,0,255,-7)
call_msg("TagMapDfRefugeeCamp:Df_Heresy/0_2")

get_character(0).erase