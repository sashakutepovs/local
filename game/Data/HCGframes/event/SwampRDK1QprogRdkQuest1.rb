
tmpQtX,tmpQtY,tmpQtID=$game_map.get_storypoint("QuestTar")
tmpW2AX,tmpW2AY,tmpW2AID=$game_map.get_storypoint("Wave2A")
tmpW2BX,tmpW2BY,tmpW2BID=$game_map.get_storypoint("Wave2B")
tmpMcBX,tmpMcBY,tmpMcID=$game_map.get_storypoint("MapCont")

call_msg("TagMapSwampRDK1:mec/halp1")
cam_follow(tmpQtID,0)
get_character(tmpQtID).npc_story_mode(true)
get_character(tmpQtID).trigger = -1
get_character(tmpQtID).move_forward
wait(10)
get_character(tmpQtID).move_forward
wait(10)
get_character(tmpQtID).move_forward
wait(10)
get_character(tmpQtID).move_forward
wait(10)
get_character(tmpQtID).move_forward
wait(10)
get_character(tmpQtID).move_forward
wait(10)
get_character(tmpQtID).move_forward
wait(10)
get_character(tmpQtID).move_forward
wait(10)
call_msg("TagMapSwampRDK1:mec/halp2")
get_character(tmpQtID).jump_to($game_player.x-1,$game_player.y)
SndLib.sound_equip_armor
get_character(tmpQtID).direction = 6
wait(10)
call_msg("TagMapSwampRDK1:mec/halp3")
SndLib.sound_punch_hit
get_character(tmpQtID).animation = get_character(tmpQtID).animation_atk_charge

call_msg("TagMapSwampRDK1:mec/halp4")
get_character(tmpQtID).npc_story_mode(false)
get_character(tmpQtID).set_npc("NeutralHumanCommonM")


get_character(tmpW2AID).moveto(tmpQtX,tmpQtY)
get_character(tmpW2AID).direction = 4
get_character(tmpW2AID).move_type = 3
get_character(tmpW2AID).call_balloon(20)
cam_follow(tmpW2AID,0)
SndLib.FishkindSmSpot
wait(40)

get_character(tmpW2BID).moveto(tmpQtX+1,tmpQtY)
get_character(tmpW2BID).direction = 4
get_character(tmpW2BID).move_type = 3
get_character(tmpW2BID).call_balloon(20)
cam_follow(tmpW2BID,0)
SndLib.FishkindSmSpot
wait(40)

get_character(tmpW2AID).set_npc("FishkindCharger")
get_character(tmpW2BID).set_npc("FishkindCommoner")


call_msg("TagMapSwampRDK1:mec/halp5")
SndLib.bgm_play("CB_Combat LOOP",70)

set_event_force_page(tmpMcID,4)
cam_center(0)
portrait_hide
$game_temp.choice = -1
get_character(0).erase