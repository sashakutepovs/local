return get_character(0).delete if $story_stats["UniqueChar_NFL_MerCamp_Leader"] == -1
return get_character(0).delete if $story_stats["NFL_MerCamp_SaveDog"] != 1
return get_character(0).delete if $story_stats["RapeLoop"] >= 1
return get_character(0).delete if $story_stats["Captured"] >= 1
return get_character(0).delete if $story_stats["NFL_MerCamp_SaveDogRg38"] >= 1
eventPlayStart
$story_stats["NFL_MerCamp_SaveDogRg38"] = 1
$story_stats["NFL_MerCamp_SaveDogAMT"] = $game_date.dateAmt

tmpSlaveMasterX,tmpSlaveMasterY,tmpSlaveMasterID = $game_map.get_storypoint("SlaveMaster")
tmpPriestX,tmpPriestY,tmpPriestID = $game_map.get_storypoint("Priest")
tmpMerLeaderX,tmpMerLeaderY,tmpMerLeaderID = $game_map.get_storypoint("MerLeader")
tmpCamX,tmpCamY,tmpCamID = $game_map.get_storypoint("Cam")


portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	$game_player.moveto($game_player.x,$game_player.y)
	get_character(tmpMerLeaderID).moveto($game_player.x,$game_player.y+1)
	get_character(tmpMerLeaderID).turn_toward_character($game_player)
	get_character(tmpMerLeaderID).call_balloon(0)
	get_character(tmpPriestID).moveto(tmpPriestX,tmpPriestY)
	get_character(tmpSlaveMasterID).moveto(tmpSlaveMasterX,tmpSlaveMasterY)
	get_character(tmpCamID).moveto($game_player.x,$game_player.y)
	get_character(tmpPriestID).npc_story_mode(true)
	get_character(tmpSlaveMasterID).npc_story_mode(true)
	get_character(tmpCamID).npc_story_mode(true)
chcg_background_color(0,0,0,255,-7)
call_msg("TagMapNFL_OrkCamp2:MercLeader/Rg38_1")
portrait_hide
$game_player.turn_toward_character(get_character(tmpMerLeaderID))
cam_follow(tmpCamID,0)
get_character(tmpCamID).movetoRolling(tmpPriestX,tmpPriestY)
until !get_character(tmpCamID).moving?
	get_character(tmpCamID).move_speed = 4
	wait(1)
end
until !get_character(tmpSlaveMasterID).moving? && get_character(tmpSlaveMasterID).report_range(get_character(tmpPriestID)) <= 1
	get_character(tmpSlaveMasterID).move_speed = 3
	get_character(tmpSlaveMasterID).turn_toward_character(get_character(tmpPriestID))
	get_character(tmpSlaveMasterID).move_forward_force if !get_character(tmpSlaveMasterID).moving?
	wait(1)
end
get_character(tmpSlaveMasterID).through = false
call_msg("TagMapNFL_OrkCamp2:MercLeader/Rg38_2")
portrait_fade
get_character(tmpSlaveMasterID).turn_toward_character(get_character(tmpPriestID))
get_character(tmpPriestID).call_balloon(8)
wait(60)
call_msg("TagMapNFL_OrkCamp2:MercLeader/Rg38_3")
portrait_fade
get_character(tmpPriestID).turn_toward_character(get_character(tmpSlaveMasterID))
get_character(tmpPriestID).call_balloon(8)
wait(60)
call_msg("TagMapNFL_OrkCamp2:MercLeader/Rg38_4")
call_msg("TagMapNFL_OrkCamp2:MercLeader/Rg38_5")
call_msg("TagMapNFL_OrkCamp2:MercLeader/Rg38_6")
portrait_fade

get_character(tmpPriestID).animation = get_character(tmpPriestID).animation_atk_mh
SndLib.sound_whoosh
wait(10)
$game_portraits.rprt.shake
SndLib.sound_punch_hit(100)
get_character(tmpSlaveMasterID).jump_to(get_character(tmpSlaveMasterID).x,get_character(tmpSlaveMasterID).y)

wait(40)

get_character(tmpPriestID).animation = get_character(tmpPriestID).animation_atk_sh
SndLib.sound_whoosh
wait(10)
get_character(tmpSlaveMasterID).jump_to(get_character(tmpSlaveMasterID).x,get_character(tmpSlaveMasterID).y)
$game_portraits.rprt.shake
SndLib.sound_punch_hit(100)
get_character(tmpSlaveMasterID).animation = get_character(tmpSlaveMasterID).animation_stun

call_msg("TagMapNFL_OrkCamp2:MercLeader/Rg38_7")
portrait_hide


get_character(tmpCamID).moveto(get_character(tmpPriestID).x,get_character(tmpPriestID).y)
cam_follow(tmpCamID,0)
get_character(tmpPriestID).move_speed = 3
until !get_character(tmpPriestID).moving? && get_character(tmpPriestID).report_range(get_character(tmpSlaveMasterID)) > 4
	get_character(tmpPriestID).move_speed = 3
	get_character(tmpPriestID).direction = 6
	get_character(tmpPriestID).move_forward_force if !get_character(tmpPriestID).moving?
	wait(1)
end

get_character(tmpPriestID).effects=["FadeOutDelete",0,false,nil,nil,[true,false].sample]

get_character(tmpCamID).movetoRolling($game_player.x,$game_player.y)
until !get_character(tmpCamID).moving?
	get_character(tmpCamID).move_speed = 5
	wait(1)
end

$game_player.turn_toward_character(get_character(tmpMerLeaderID))
get_character(tmpMerLeaderID).turn_toward_character($game_player)
call_msg("TagMapNFL_OrkCamp2:MercLeader/Rg38_8")
portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	get_character(tmpSlaveMasterID).delete
	get_character(tmpPriestID).delete
	$game_player.direction = 8
	get_character(tmpMerLeaderID).direction = 8
chcg_background_color(0,0,0,255,-7)

get_character(tmpPriestID).npc_story_mode(false)
get_character(tmpSlaveMasterID).npc_story_mode(false)
get_character(tmpCamID).npc_story_mode(false)
eventPlayEnd
