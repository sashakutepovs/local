chcg_background_color(0,0,0,0,7)
	$story_stats["QuProgSaveCecily"] = 21
	$game_map.npcs.each do |event| 
		next if !event.summon_data
		next if !event.summon_data[:WildnessNapEvent]
		next if event.actor.action_state == :death
		next if event.actor.is_object
		event.opacity = 0
	end
	tmpPT8x,tmpPT8y=$game_map.get_storypoint("PT8")
	tmpPT9x,tmpPT9y=$game_map.get_storypoint("PT9")
	tmpRG2id=$game_map.get_storypoint("RG2")[2]
	tmpRG5id=$game_map.get_storypoint("RG5")[2]
	tmpChestID=$game_map.get_storypoint("Chest")[2]
	tmpEndUp1ID=$game_map.get_storypoint("EndUp1")[2]
	tmpEndUp2ID=$game_map.get_storypoint("EndUp2")[2]
	tmpEndDn1ID=$game_map.get_storypoint("EndDn1")[2]
	tmpEndDn2ID=$game_map.get_storypoint("EndDn2")[2]
	tmpAdamID=$game_map.get_storypoint("Adam")[2]
	tmpCecilyID=$game_map.get_storypoint("Cecily")[2]
	tmpGrayRatID=$game_map.get_storypoint("GrayRat")[2]
	tmpMaaniID=$game_map.get_storypoint("Maani")[2]
	tmpGangBossID=$game_map.get_storypoint("GangBoss")[2]
	tmpSnipeID=$game_map.get_storypoint("Snipe")[2]
	tmpSnipeHitID=$game_map.get_storypoint("SnipeHit")[2]
	get_character(tmpEndUp1ID).npc_story_mode(true)
	get_character(tmpEndUp2ID).npc_story_mode(true)
	get_character(tmpEndDn1ID).npc_story_mode(true)
	get_character(tmpEndDn2ID).npc_story_mode(true)
	get_character(tmpAdamID).npc_story_mode(true)
	get_character(tmpCecilyID).npc_story_mode(true)
	get_character(tmpGrayRatID).npc_story_mode(true)
	$game_player.moveto(tmpPT8x,tmpPT8y+3)
	$game_player.direction = 2
	get_character(tmpCecilyID).moveto(tmpPT9x+1,tmpPT9y)
	get_character(tmpGrayRatID).moveto(tmpPT9x-1,tmpPT9y)
	get_character(tmpEndDn1ID).moveto(tmpPT9x+1,tmpPT9y)
	get_character(tmpEndDn2ID).moveto(tmpPT9x-1,tmpPT9y)
	get_character(tmpEndUp1ID).moveto(tmpPT8x+1,tmpPT8y+1)
	get_character(tmpEndUp2ID).moveto(tmpPT8x-1,tmpPT8y+1)
chcg_background_color(0,0,0,255,-7)
$game_player.call_balloon(6)
5.times{
	$game_player.move_speed = 4 ; $game_player.direction = 2 ; $game_player.move_forward_force ; wait(15)
}

SndLib.sound_HumanRoar
until get_character(tmpEndDn1ID).opacity >= 255
	get_character(tmpEndDn1ID).opacity += 5
	get_character(tmpEndDn2ID).opacity += 5
	wait(1)
end

call_msg("CompCecily:QuProg/20to21_Exit0") ; portrait_hide
$game_player.call_balloon(1)
2.times{
	get_character(tmpEndDn1ID).move_speed = 3 ; get_character(tmpEndDn1ID).direction = 8 ; get_character(tmpEndDn1ID).move_forward_force
	get_character(tmpEndDn2ID).move_speed = 3 ; get_character(tmpEndDn2ID).direction = 8 ; get_character(tmpEndDn2ID).move_forward_force
	$game_player.move_speed = 3 ; $game_player.direction = 8 ; $game_player.move_forward_force ; $game_player.direction = 2 ; wait(30)
}
cam_center(0)
$game_player.direction = 8
SndLib.sound_HumanRoar
until get_character(tmpEndUp1ID).opacity >= 255
	get_character(tmpEndUp1ID).opacity += 5
	get_character(tmpEndUp2ID).opacity += 5
	wait(1)
end
$game_player.call_balloon(1)
3.times{
	get_character(tmpEndUp1ID).move_speed = 3 ; get_character(tmpEndUp1ID).direction = 2 ; get_character(tmpEndUp1ID).move_forward_force
	get_character(tmpEndUp2ID).move_speed = 3 ; get_character(tmpEndUp2ID).direction = 2 ; get_character(tmpEndUp2ID).move_forward_force
	wait(30)
}
call_msg("CompCecily:QuProg/20to21_Exit1") ; portrait_hide
cam_center(0)
1.times{
	get_character(tmpEndUp1ID).move_speed = 3 ; get_character(tmpEndUp1ID).direction = 2 ; get_character(tmpEndUp1ID).move_forward_force
	get_character(tmpEndUp2ID).move_speed = 3 ; get_character(tmpEndUp2ID).direction = 2 ; get_character(tmpEndUp2ID).move_forward_force
	$game_player.move_speed = 3 ; $game_player.direction = 2 ; $game_player.move_forward_force ; $game_player.direction = 8 ; wait(30)
}
call_msg("CompCecily:QuProg/20to21_Exit2") ; portrait_hide
cam_center(0)
until get_character(tmpCecilyID).opacity >= 255
	get_character(tmpCecilyID).opacity += 5
	get_character(tmpGrayRatID).opacity += 5
	wait(1)
end
########################################### CEC AND GR SHOW UP
get_character(tmpCecilyID).move_speed = 3 ; get_character(tmpCecilyID).direction = 8 ; get_character(tmpCecilyID).move_forward_force
get_character(tmpGrayRatID).move_speed = 3 ; get_character(tmpGrayRatID).direction = 8 ; get_character(tmpGrayRatID).move_forward_force
get_character(tmpEndDn1ID).npc.battle_stat.set_stat_m("health",50,[0,2,3])
get_character(tmpEndDn2ID).npc.battle_stat.set_stat_m("health",50,[0,2,3])
get_character(tmpEndDn1ID).npc.battle_stat.set_stat_m("sta",50,[0,2,3])
get_character(tmpEndDn2ID).npc.battle_stat.set_stat_m("sta",50,[0,2,3])
wait(30)
$game_player.direction = 2
get_character(tmpCecilyID).animation = get_character(tmpCecilyID).animation_atk_sh
SndLib.sound_whoosh
wait(5)
SndLib.sound_combat_hit_gore
wait(3)
get_character(tmpEndDn1ID).animation = get_character(tmpEndDn1ID).animation_stun
get_character(tmpEndDn1ID).call_balloon(14)
SndLib.sound_MaleWarriorDed
get_character(tmpEndDn2ID).direction = 6 ; get_character(tmpEndDn2ID).call_balloon(1)
wait(10)
get_character(tmpGrayRatID).animation = get_character(tmpGrayRatID).animation_atk_mh
SndLib.sound_whoosh
wait(5)
SndLib.sound_combat_hit_gore
wait(3)
get_character(tmpEndDn2ID).animation = get_character(tmpEndDn2ID).animation_stun
get_character(tmpEndDn2ID).call_balloon(14)
SndLib.sound_MaleWarriorDed
wait(10)
call_msg("CompCecily:QuProg/20to21_Exit3") ; portrait_hide
cam_follow(tmpAdamID,0)
if $story_stats["RecQuestAdam"] >= 6 && $story_stats["UniqueCharUniqueAdam"] != -1
	get_character(tmpAdamID).call_balloon(1)
	get_character(tmpAdamID).moveto(tmpPT8x+3,tmpPT8y+4)
	get_character(tmpAdamID).opacity = 5
	until get_character(tmpAdamID).opacity >= 255
		get_character(tmpAdamID).opacity += 10
		wait(1)
	end
	get_character(tmpAdamID).jump_to(get_character(tmpEndUp1ID).x,get_character(tmpEndUp1ID).y-1)
	SndLib.sound_equip_armor
	get_character(tmpEndUp1ID).call_balloon(1)
	get_character(tmpEndUp1ID).direction = 8
	$game_player.direction = 8
	$game_player.call_balloon(1)
	wait(50)
	get_character(tmpAdamID).direction = 2
	get_character(tmpAdamID).animation = get_character(tmpAdamID).animation_atk_mh
	SndLib.sound_whoosh
	wait(10)
	SndLib.sound_combat_hit_gore
	get_character(tmpEndUp1ID).animation = get_character(tmpEndUp1ID).animation_stun
	get_character(tmpEndUp1ID).call_balloon(14)
	wait(60)
	call_msg("CompCecily:QuProg/20to21_Exit3_adam0") ; portrait_hide
	
	get_character(tmpEndUp1ID).npc.battle_stat.set_stat_m("health",50,[0,2,3])
	get_character(tmpEndUp1ID).npc.battle_stat.set_stat_m("sta",50,[0,2,3])
	get_character(tmpAdamID).move_type = 3
	get_character(tmpEndUp1ID).actor.force_stun("Stun3")
	$game_player.set_follower(get_character(tmpAdamID).id)
	get_character(tmpAdamID).follower = [1,1,0,0]
	get_character(tmpAdamID).set_manual_move_type(3)
end

$game_player.record_companion_back_date = $game_date.dateAmt+1
$game_player.record_companion_front_date = $game_date.dateAmt+1
$game_player.record_companion_name_back = "UniqueCecily"
$game_player.record_companion_name_front = "UniqueGrayRat"
summon_companion(get_character(tmpCecilyID).x,get_character(tmpCecilyID).y,skipExt=false,slot=1,fadein=false)
summon_companion(get_character(tmpGrayRatID).x,get_character(tmpGrayRatID).y,skipExt=false,slot=0,fadein=false)
get_character(tmpEndDn1ID).actor.force_stun("Stun3")
get_character(tmpEndDn2ID).actor.force_stun("Stun3")
get_character(tmpEndUp1ID).npc_story_mode(false)
get_character(tmpEndUp2ID).npc_story_mode(false)
get_character(tmpEndDn1ID).npc_story_mode(false)
get_character(tmpEndDn2ID).npc_story_mode(false)
get_character(tmpAdamID).npc_story_mode(false)
get_character(tmpCecilyID).npc_story_mode(false)
get_character(tmpGrayRatID).npc_story_mode(false)
get_character(tmpCecilyID).delete
get_character(tmpGrayRatID).delete
get_character(tmpRG5id).set_region_trigger(5)
set_event_force_page(tmpChestID,1)
set_event_force_page(tmpRG2id,1)
$game_map.npcs.each do |event|
	next if !event.summon_data
	next if !event.summon_data[:WildnessNapEvent]
	next if event.actor.action_state == :death
	next if event.actor.is_object
	event.opacity = 255
end

call_msg("CompCecily:QuProg/20to21_Exit4BRD") ; portrait_hide
eventPlayEnd

get_character(0).erase
