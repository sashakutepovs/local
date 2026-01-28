tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
tmpCamID = $game_map.get_storypoint("Cam")[2]
tmpGuardL = $game_map.get_storypoint("GuardL")[2]
tmpGuardR = $game_map.get_storypoint("GuardR")[2]
tmpFishExplorerX,tmpFishExplorerY,tmpFishExplorerID = $game_map.get_storypoint("FishExplorer")
return get_character(tmpDualBiosID).erase if get_character(tmpDualBiosID).summon_data[:Aggro]
return get_character(tmpDualBiosID).erase if $story_stats["RecQuestAriseVillageFish"] >= 1
get_character(tmpCamID).npc_story_mode(true)
get_character(tmpFishExplorerID).npc_story_mode(true)
get_character(tmpGuardR).npc_story_mode(true)
get_character(tmpGuardR).npc_story_mode(true)

aniArr = [[6,5,0,-24,-8]]
get_character(tmpGuardR).animation = get_character(tmpGuardR).aniCustom(aniArr,-1)

aniArr = [[9,4,0,0,-32]]
get_character(tmpFishExplorerID).animation = get_character(tmpFishExplorerID).aniCustom(aniArr,-1)
get_character(tmpFishExplorerID).forced_z = -1
get_character(tmpFishExplorerID).angle = 180

get_character(tmpFishExplorerID).call_balloon(0)
$story_stats["RecQuestAriseVillageFish"] = 1
call_msg("TagMapAriseVillage:AriseVillage/0to1_0") ; portrait_hide
cam_follow(tmpCamID,0)
get_character(tmpCamID).moveto($game_player.x,$game_player.y)
get_character(tmpCamID).movetoRolling(tmpFishExplorerX,tmpFishExplorerY)
until !get_character(tmpCamID).moving?
	wait(1)
end
call_msg("TagMapAriseVillage:AriseVillage/0to1_1")
get_character(tmpFishExplorerID).direction = 8
get_character(tmpFishExplorerID).animation = nil
get_character(tmpFishExplorerID).forced_z = 0
get_character(tmpFishExplorerID).angle = 0
get_character(tmpGuardR).animation = nil
get_character(tmpGuardR).direction = 8
call_msg("TagMapAriseVillage:AriseVillage/0to1_2")
get_character(tmpGuardR).direction = 4
get_character(tmpGuardR).animation = get_character(tmpGuardR).animation_atk_mh
wait(8)
SndLib.sound_punch_hit(100)
get_character(tmpFishExplorerID).direction = 8
get_character(tmpFishExplorerID).animation = get_character(tmpFishExplorerID).animation_stun
get_character(tmpGuardR).direction = 4
call_msg("TagMapAriseVillage:AriseVillage/0to1_3") ; portrait_hide


portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	get_character(tmpFishExplorerID).animation = get_character(tmpFishExplorerID).animation_stun
	get_character(tmpFishExplorerID).forced_z = 0
	get_character(tmpFishExplorerID).npc_story_mode(false)
	get_character(tmpGuardR).npc_story_mode(false)
	get_character(tmpGuardR).npc_story_mode(false)
	get_character(tmpCamID).npc_story_mode(false)
	get_character(tmpCamID).delete
	cam_center(0)
	get_character(tmpFishExplorerID).call_balloon(28,-1) if [0,1].include?($story_stats["RecQuestAriseVillageFish"])
chcg_background_color(0,0,0,255,-7)
eventPlayEnd
get_character(0).erase
