return if $story_stats["QuProgCataUndeadHunt2"] != 2
chcg_background_color(0,0,0,255,-7)
$story_stats["QuProgCataUndeadHunt2"] =3
tmpX,tmpY,tmpID=$game_map.get_storypoint("ToB2")
get_character(tmpID).call_balloon(28,-1)
tmpX,tmpY,tmpID=$game_map.get_storypoint("GraveKeeper")
get_character(tmpID).npc_story_mode(true)
call_msg("TagMapNoerCatacombB1:GraveKeeper/UndeadHunt2Begin1")
call_msg("TagMapNoerCatacombB1:GraveKeeper/UndeadHunt2Begin2")
get_character(tmpID).direction = 8
call_msg("TagMapNoerCatacombB1:GraveKeeper/UndeadHunt2Begin3")
get_character(tmpID).call_balloon(6)
get_character(tmpID).direction = 2
get_character(tmpID).move_forward
wait(35)
call_msg("TagMapNoerCatacombB1:GraveKeeper/UndeadHunt2Begin4") ; portrait_hide
get_character(tmpID).move_forward
wait(35)
call_msg("TagMapNoerCatacombB1:GraveKeeper/UndeadHunt2Begin5") ; portrait_hide
cam_center(0)
call_msg("TagMapNoerCatacombB1:GraveKeeper/UndeadHunt2Begin6") ; portrait_hide
cam_follow(tmpID,0)
get_character(tmpID).call_balloon(8)
wait(70)
cam_center(0)
call_msg("TagMapNoerCatacombB1:GraveKeeper/UndeadHunt2Begin7") ; portrait_hide
cam_follow(tmpID,0)
call_msg("TagMapNoerCatacombB1:GraveKeeper/UndeadHunt2Begin8") ; portrait_hide
get_character(tmpID).move_forward
wait(35)
$game_map.reserve_summon_event("EfxTrap0",get_character(tmpID).x,get_character(tmpID).y)
SndLib.sound_TrapTrigger(80)
wait(10)
get_character(tmpID).animation = get_character(tmpID).animation_overkill_melee_reciver
get_character(tmpID).setup_cropse_graphics(2)
SndLib.sound_punch_hit(90)
SndLib.sound_combat_hit_gore(83)
SndLib.sound_MaleWarriorDed(80)
wait(10)
get_character(tmpID).drop_light
wait(70)
call_msg("TagMapNoerCatacombB1:GraveKeeper/UndeadHunt2Begin9")
cam_center(0)
wait(10)
$game_player.call_balloon(1)
call_msg("TagMapNoerCatacombB1:GraveKeeper/UndeadHunt2Begin10")
get_character(tmpID).priority_type = 0
get_character(tmpID).through = true
get_character(tmpID).npc_story_mode(false)
eventPlayEnd