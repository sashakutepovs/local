enter_static_tag_map
eventPlayEnd



tmpStartPointX,tmpStartPointY,tmpStartPointID=$game_map.get_storypoint("StartPoint")
tmpST2x,tmpST2y,tmpST2id=$game_map.get_storypoint("ST2")
tmpGangBossX,tmpGangBossY,tmpGangBossID=$game_map.get_storypoint("GangBoss")
tmpMaaniX,tmpMaaniY,tmpMaaniID=$game_map.get_storypoint("Maani")
tmpQuestCountX,tmpQuestCountY,tmpQuestCountID=$game_map.get_storypoint("QuestCount")

cam_center(0)
$game_player.direction = 6 ; $game_player.move_forward_force ; $game_player.direction = 4
$game_player.call_balloon(6)
wait(60)
$game_player.direction = 6
$game_player.call_balloon(8)
wait(60)
SndLib.sound_equip_armor
$game_player.jump_to(tmpST2x,tmpST2y+2)
wait(20)
SndLib.sound_punch_hit(100)
$game_player.move_speed = 3 ; $game_player.direction = 6 ; $game_player.move_forward_force ; $game_player.direction = 4 ; wait(30)
$game_player.move_speed = 3 ; $game_player.direction = 6 ; $game_player.move_forward_force ; $game_player.direction = 4 ; wait(30)
call_msg("CompCecily:QuProg/20to21_1") ; portrait_hide
get_character(tmpMaaniID).npc_story_mode(true)
get_character(tmpGangBossID).npc_story_mode(true)
cam_follow(tmpMaaniID,0)
until get_character(tmpMaaniID).opacity >= 255
	get_character(tmpMaaniID).opacity += 5
	get_character(tmpGangBossID).opacity += 5
	wait(1)
end
SndLib.sound_equip_armor
get_character(tmpMaaniID).jump_to(tmpStartPointX-1,tmpStartPointY+1)
get_character(tmpGangBossID).jump_to(tmpStartPointX-1,tmpStartPointY)
wait(25)
SndLib.sound_punch_hit(100)
wait(10)
get_character(tmpMaaniID).direction = 6 ; get_character(tmpMaaniID).move_forward_force ; 
get_character(tmpGangBossID).direction = 6 ; get_character(tmpGangBossID).move_forward_force ; wait(30)
$game_player.direction = 4
call_msg("CompCecily:QuProg/20to21_2")
get_character(tmpGangBossID).direction = 2
call_msg("CompCecily:QuProg/20to21_3")
get_character(tmpGangBossID).direction = 6
call_msg("CompCecily:QuProg/20to21_4")
call_msg("CompCecily:QuProg/20to21_5") ; portrait_hide
$game_player.move_speed = 4 ; $game_player.direction = 8 ; $game_player.move_forward_force ; wait(15)
$game_player.move_speed = 4 ; $game_player.direction = 8 ; $game_player.move_forward_force ; wait(15)
call_msg("CompCecily:QuProg/20to21_6") ; portrait_hide
get_character(tmpMaaniID).direction = 6 ; get_character(tmpMaaniID).move_forward_force
$game_player.move_speed = 3 ; $game_player.direction = 2 ; $game_player.move_forward_force ; $game_player.direction = 8 ; wait(30)
call_msg("CompCecily:QuProg/20to21_7")

$game_player.direction = 2
set_event_force_page(tmpQuestCountID,3)
get_character(tmpMaaniID).move_type = 3
get_character(tmpMaaniID).npc_story_mode(false)
get_character(tmpGangBossID).npc_story_mode(false)
eventPlayEnd
#summon_companion