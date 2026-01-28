return get_character(0).erase if $story_stats["QuProgCataUndeadHunt2"] != 3
return get_character(0).erase if $game_player.actor.sta == -100

tmpRG_AgroID=$game_map.get_storypoint("RG_forceAggro")[2]
#10 room1, 11 room2, 12 room3, 13 room4
#do room 2 3, rg 11 12
get_character(tmpRG_AgroID).set_region_trigger(11)

$story_stats["QuProgCataUndeadHunt2"] = 4
portrait_hide
tmpX,tmpY,tmpID=$game_map.get_storypoint("GraveKeeper")
get_character(tmpID).erase

tmpX,tmpY,tmpID=$game_map.get_storypoint("ToB2")
get_character(tmpID).call_balloon(0)


$game_map.reserve_summon_event("EfxTrap0",$game_player.x,$game_player.y)
SndLib.sound_TrapTrigger(80)
wait(10)
SndLib.sound_punch_hit(90)
$game_player.animation = $game_player.animation_stun
wait(80)
chcg_background_color(0,0,0,0,2)
call_msg("TagMapNoerCatacombB1:Lona/B2TrapTrigger1")
if $game_player.with_companion
	$game_player.reset_companion_and_delete
	call_msg("common:Lona/Group_disbanded")
end
$game_party.drop_all_items_to_storage(true,System_Settings::STORAGE_TEMP_MAP)
$game_player.light_check

$game_player.moveto(1,1)
tmpCapX,tmpCapY,tmpCapID=$game_map.get_storypoint("CapLoc")
get_character(tmpCapID).npc_story_mode(true)
set_event_force_page(tmpCapID,1)
cam_follow(tmpCapID,0)
call_msg("TagMapNoerCatacombB1:Lona/B2TrapTrigger2")
chcg_background_color(0,0,0,255,-2)


tmpCoX,tmpCoY,tmpCoID=$game_map.get_storypoint("Cocona")
get_character(tmpCoID).npc_story_mode(true)
call_msg("TagMapNoerCatacombB1:Cocona/B2Trap_Sing1") ; portrait_hide
get_character(tmpCoID).animation = get_character(tmpCoID).animation_atk_sh
SndLib.sound_combat_hit_gore(80)
call_msg("TagMapNoerCatacombB1:Cocona/B2Trap_Sing2") ; portrait_hide
get_character(tmpCoID).animation = get_character(tmpCoID).animation_atk_mh
SndLib.sound_combat_hit_gore(80)
wait(60)
get_character(tmpCoID).animation = get_character(tmpCoID).animation_atk_sh
SndLib.sound_combat_hit_gore(80)
wait(50)
get_character(tmpCoID).animation = get_character(tmpCoID).animation_atk_mh
SndLib.sound_combat_hit_gore(80)
wait(60)
get_character(tmpCoID).animation = get_character(tmpCoID).animation_atk_sh
SndLib.sound_combat_hit_gore(80)
wait(60)
call_msg("TagMapNoerCatacombB1:Cocona/B2Trap_Sing3") ; portrait_hide

tmpBrX,tmpBrY,tmpBrID=$game_map.get_storypoint("ButRoom")
until get_character(tmpCoID).x == tmpBrX && get_character(tmpCoID).y == tmpBrY+1
	get_character(tmpCoID).move_goto_xy(tmpBrX,tmpBrY+1)
	wait(35)
end
get_character(tmpCoID).direction = 2
call_msg("TagMapNoerCatacombB1:Lona/BondageStruggle1") ; portrait_hide

tmpStruggle =0
until tmpStruggle == 3
	call_msg("TagMapNoerCatacombB1:Lona/BondageStruggle_opt") ; portrait_hide
	lona_mood "p5defence"
	tmpStruggle +=1
	$game_portraits.rprt.shake
	get_character(tmpCapID).jump_to(tmpCapX,tmpCapY)
	SndLib.sound_punch_hit(90,rand(10)+50)
	wait(60)
	call_msg("TagMapNoerCatacombB1:Lona/BondageStruggle2") ; portrait_hide
end

chcg_background_color(0,0,0,0,7)
set_event_force_page(tmpCapID,2)
$game_player.moveto(tmpCapX,tmpCapY)
$game_player.direction = 2
$game_player.animation = nil
cam_center(0)
chcg_background_color(0,0,0,255,-7)
call_msg("TagMapNoerCatacombB1:Lona/BondageStruggle3") ; portrait_hide

tmpQuX,tmpQuY,tmpQuID=$game_map.get_storypoint("QuestCount")
get_character(tmpCapID).npc_story_mode(false)
get_character(tmpCoID).npc_story_mode(false)
set_event_force_page(tmpQuID,9)
set_event_force_page(tmpCoID,4) #cooking
portrait_hide
get_character(0).erase
