
$game_system.add_mail("B4CampOrkind")
tmpGbX,tmpGbY,tmpGbID=$game_map.get_storypoint("GoblinBow")
tmpGsX,tmpGsY,tmpGsID=$game_map.get_storypoint("GoblinSpear")
tmpGs2X,tmpGs2Y,tmpGs2ID=$game_map.get_storypoint("GoblinSpear2")
tmpGwX,tmpGwY,tmpGwID=$game_map.get_storypoint("GoblinWarrior")
tmpHuX,tmpHuY,tmpHuID=$game_map.get_storypoint("Hum")
tmpTmpPT1X,tmpTmpPT1Y,tmpTmpPT1ID=$game_map.get_storypoint("TmpPT1")
$story_stats["RecQuestB4CampOrkind"] = 1
portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	get_character(tmpHuID).npc_story_mode(true)
	get_character(tmpHuID).opacity = 255
	SndLib.sound_MaleWarriorDed
	call_msg("TagMapB4CampOrkind:crying/begin1")
	cam_follow(tmpTmpPT1ID,0)
chcg_background_color(0,0,0,255,-7)
3.times{
	get_character(tmpHuID).move_forward_force
	wait(60)
}


get_character(tmpGs2ID).npc_story_mode(true)
get_character(tmpGbID).npc_story_mode(true)
get_character(tmpGsID).npc_story_mode(true)
get_character(tmpGwID).npc_story_mode(true)

get_character(tmpGs2ID).moveto(tmpHuX+6,tmpHuY+1)
get_character(tmpGsID).moveto(tmpHuX+1+7,tmpHuY+1)
get_character(tmpGbID).moveto(tmpHuX+6,tmpHuY)
get_character(tmpGwID).moveto(tmpHuX+1+6,tmpHuY)
SndLib.sound_goblin_roar(40)
get_character(tmpHuID).move_forward_force
3.times{
	get_character(tmpGbID).move_forward_force
	get_character(tmpGs2ID).move_forward_force
	get_character(tmpGsID).move_forward_force
	get_character(tmpGwID).move_forward_force
	wait(18)
}
get_character(tmpGwID).call_balloon(4)
SndLib.sound_goblin_roar(60)
get_character(tmpHuID).move_forward_force
3.times{
	get_character(tmpGbID).move_forward_force
	get_character(tmpGs2ID).move_forward_force
	get_character(tmpGsID).move_forward_force
	get_character(tmpGwID).move_forward_force
	wait(18)
}
get_character(tmpGbID).call_balloon(4)
SndLib.sound_goblin_roar(80)
SndLib.sound_punch_hit
get_character(tmpHuID).call_balloon(6)
get_character(tmpHuID).jump_to(get_character(tmpHuID).x-1,get_character(tmpHuID).y)
get_character(tmpHuID).character_index = 3
3.times{
	get_character(tmpGbID).move_forward_force
	get_character(tmpGs2ID).move_forward_force
	get_character(tmpGsID).move_forward_force
	get_character(tmpGwID).move_forward_force
	wait(18)
}
get_character(tmpGsID).call_balloon(4)

get_character(tmpGbID).move_forward_force
get_character(tmpGs2ID).move_forward_force
get_character(tmpGsID).move_forward_force
get_character(tmpGwID).move_forward_force
wait(18)
get_character(tmpGbID).move_forward_force
get_character(tmpGs2ID).move_forward_force
get_character(tmpGsID).move_forward_force
get_character(tmpGwID).move_forward_force
wait(18)
get_character(tmpHuID).direction = 6
get_character(tmpGbID).move_forward_force
get_character(tmpGs2ID).move_forward_force
get_character(tmpGsID).direction = 8 ; get_character(tmpGsID).move_forward_force
get_character(tmpGwID).direction = 4 ; get_character(tmpGwID).move_forward_force
wait(18)
SndLib.sound_goblin_roar(80)
get_character(tmpGbID).move_forward_force
wait(1)
get_character(tmpGsID).direction = 8 ; get_character(tmpGsID).move_forward_force
wait(18)
get_character(tmpGsID).direction = 4 ; get_character(tmpGsID).move_forward_force
wait(18)
get_character(tmpGsID).direction = 4 ; get_character(tmpGsID).move_forward_force
wait(18)
get_character(tmpGsID).direction = 4 ; get_character(tmpGsID).move_forward_force
get_character(tmpGsID).turn_toward_character(get_character(tmpHuID))
get_character(tmpGbID).turn_toward_character(get_character(tmpHuID))
get_character(tmpGs2ID).turn_toward_character(get_character(tmpHuID))
get_character(tmpGs2ID).animation = get_character(tmpGs2ID).animation_grabber_qte(get_character(tmpHuID))
get_character(tmpHuID).animation = get_character(tmpHuID).animation_grabbed_qte
SndLib.sound_equip_armor(100)
SndLib.sound_goblin_roar(80)
SndLib.sound_MaleWarriorDed(80)
call_msg("TagMapB4CampOrkind:crying/begin2")

SndLib.sound_goblin_spot(80)
get_character(tmpGbID).call_balloon(4)
get_character(tmpGbID).jump_to(get_character(tmpGbID).x,get_character(tmpGbID).y)
wait(60)
SndLib.sound_goblin_spot(80)
get_character(tmpGsID).call_balloon(25)
get_character(tmpGsID).jump_to(get_character(tmpGsID).x,get_character(tmpGsID).y)
wait(60)
SndLib.sound_goblin_spot(80)
get_character(tmpGwID).call_balloon(23)
get_character(tmpGwID).jump_to(get_character(tmpGwID).x,get_character(tmpGwID).y)
wait(60)
call_msg("TagMapB4CampOrkind:crying/begin3")
##################################################################################################
get_character(tmpGs2ID).animation = nil
get_character(tmpHuID).animation = nil
npc_sex_service_main(get_character(tmpGs2ID),get_character(tmpHuID),"anal",1,0)
wait(1)
npc_sex_service_main(get_character(tmpGs2ID),get_character(tmpHuID),"anal",1,0)
call_msg("TagMapB4CampOrkind:crying/begin4")
3.times{
	SndLib.sound_chs_buchu
	wait(20)
}
call_msg("TagMapB4CampOrkind:crying/begin5")
SndLib.sound_chs_buchu
SndLib.sound_goblin_spot(80)
get_character(tmpGsID).call_balloon(4)
get_character(tmpGsID).jump_to(get_character(tmpGsID).x,get_character(tmpGsID).y)
wait(60)
SndLib.sound_chs_buchu
SndLib.sound_goblin_spot(80)
get_character(tmpGwID).call_balloon(25)
get_character(tmpGwID).jump_to(get_character(tmpGwID).x,get_character(tmpGwID).y)
wait(60)
SndLib.sound_chs_buchu
SndLib.sound_goblin_spot(80)
get_character(tmpGbID).call_balloon(23)
get_character(tmpGbID).jump_to(get_character(tmpGbID).x,get_character(tmpGbID).y)
wait(60)
npc_sex_service_main(get_character(tmpGs2ID),get_character(tmpHuID),"anal",1,2)
3.times{
	SndLib.sound_chs_buchu
	wait(20)
}
call_msg("TagMapB4CampOrkind:crying/begin6")
get_character(tmpHuID).call_balloon(8)
wait(60)
get_character(tmpHuID).unset_event_chs_sex
get_character(tmpGs2ID).unset_event_chs_sex
SndLib.sound_chs_buchu(100,80)
get_character(tmpHuID).turn_toward_character(get_character(tmpGs2ID))
get_character(tmpHuID).animation = get_character(tmpHuID).animation_atk_2hSpins
wait(20)
wait(10)
get_character(tmpGs2ID).call_balloon(14,-1)
get_character(tmpGs2ID).animation = get_character(tmpGs2ID).animation_stun
SndLib.sound_punch_hit
SndLib.sound_goblin_death(80)
$game_map.interpreter.screen.start_shake(1,8,8)
call_msg("TagMapB4CampOrkind:crying/begin7")
get_character(tmpGsID).call_balloon(5)
SndLib.sound_goblin_roar
wait(60)
get_character(tmpGsID).animation = get_character(tmpGsID).animation_atk_piercing
wait(10)
SndLib.sound_whoosh
wait(3)
SndLib.sound_combat_hit_gore
wait(3)
SndLib.sound_MaleWarriorDed(80)
get_character(tmpHuID).animation = get_character(tmpHuID).overkill_animation
get_character(tmpHuID).through = true
wait(60)
get_character(tmpGbID).call_balloon(8)
SndLib.sound_goblin_idle(80)
wait(50)
get_character(tmpHuID).priority_type = 0
get_character(tmpGsID).call_balloon(20)
SndLib.sound_goblin_idle(80)
wait(50)
get_character(tmpGwID).call_balloon(5)
SndLib.sound_goblin_idle(80)
wait(50)
get_character(tmpGbID).call_balloon(8)
get_character(tmpGsID).call_balloon(8)
get_character(tmpGwID).call_balloon(8)
wait(60)
get_character(tmpGbID).call_balloon(25)
SndLib.sound_goblin_idle(80)
wait(60)
get_character(tmpGsID).call_balloon(24)
SndLib.sound_goblin_idle(80)
wait(60)
get_character(tmpGwID).call_balloon(23)
SndLib.sound_goblin_idle(80)
wait(60)
get_character(tmpGbID).direction = 2
get_character(tmpGsID).direction = 2
get_character(tmpGwID).direction = 2
get_character(tmpGbID).call_balloon(8)
get_character(tmpGsID).call_balloon(8)
get_character(tmpGwID).call_balloon(8)
wait(60)
get_character(tmpGwID).jump_to(get_character(tmpGs2ID).x-1,get_character(tmpGs2ID).y)
get_character(tmpGwID).turn_toward_character(get_character(tmpGs2ID))
get_character(tmpGsID).jump_to(get_character(tmpGs2ID).x+1,get_character(tmpGs2ID).y)
get_character(tmpGsID).turn_toward_character(get_character(tmpGs2ID))
get_character(tmpGbID).jump_to(get_character(tmpGs2ID).x,get_character(tmpGs2ID).y+-1)
get_character(tmpGbID).turn_toward_character(get_character(tmpGs2ID))
SndLib.sound_equip_armor(100)
wait(60)
cam_follow(tmpGs2ID,0)
get_character(tmpGwID).call_balloon(8)
get_character(tmpGsID).call_balloon(8)
get_character(tmpGbID).call_balloon(8)
wait(60)
get_character(tmpGwID).call_balloon(4)
get_character(tmpGsID).call_balloon(4)
get_character(tmpGbID).call_balloon(4)
get_character(tmpGs2ID).call_balloon(0)
SndLib.sound_goblin_roar(80)
wait(2)
SndLib.sound_goblin_roar(80)
wait(2)
SndLib.sound_goblin_roar(80)
wait(56)
get_character(tmpGs2ID).call_balloon(8)
get_character(tmpGs2ID).animation = nil
get_character(tmpGs2ID).direction = 4
SndLib.sound_goblin_idle(80)
wait(60)
get_character(tmpGs2ID).call_balloon(8)
get_character(tmpGs2ID).direction = 8
SndLib.sound_goblin_idle(80)
wait(60)
get_character(tmpGs2ID).call_balloon(6)
get_character(tmpGs2ID).direction = 6
SndLib.sound_goblin_idle(80)
wait(60)
portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	cam_center(0)
	get_character(tmpGs2ID).npc.battle_stat.set_stat_m("sta",0,[0,2,3])
	wait(1)
	get_character(tmpGs2ID).set_manual_move_type(3)
	get_character(tmpGbID).set_manual_move_type(3)
	get_character(tmpGsID).set_manual_move_type(3)
	get_character(tmpGwID).set_manual_move_type(3)
	get_character(tmpGs2ID).npc_story_mode(false)
	get_character(tmpGbID).npc_story_mode(false)
	get_character(tmpGsID).npc_story_mode(false)
	get_character(tmpGwID).npc_story_mode(false)
	get_character(tmpHuID).npc_story_mode(false)
	SndLib.sound_chcg_fapper(80)
	SndLib.sound_chcg_full(80)
	wait(120)
chcg_background_color(0,0,0,255,-7)
call_msg("TagMapB4CampOrkind:enterMap/end0")
eventPlayEnd
get_character(0).erase
