return if $story_stats["QuProgPB_NorthCP"] ==2
if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).call_balloon(0)
#tmpQcX,tmpQcY,tmpQcID = $game_map.get_storypoint("QuestCount") #do this if i changed my mind
tmpQtX,tmpQtY,tmpQtID=$game_map.get_storypoint("QuestTar")
tmpDoX,tmpDoY,tmpDoID=$game_map.get_storypoint("DedOne")
tmpScX,tmpScY,tmpScID=$game_map.get_storypoint("SummonCore")
tmpM1X,tmpM1Y,tmpM1ID=$game_map.get_storypoint("Mob1")
tmpM2X,tmpM2Y,tmpM2ID=$game_map.get_storypoint("Mob2")
tmpGs1X,tmpGs1Y,tmpGs1ID=$game_map.get_storypoint("GoblinSpear1")
tmpGs2X,tmpGs2Y,tmpGs2ID=$game_map.get_storypoint("GoblinSpear2")
tmpGb1X,tmpGb1Y,tmpGb1ID=$game_map.get_storypoint("GoblinBow1")
tmpGb2X,tmpGb2Y,tmpGb2ID=$game_map.get_storypoint("GoblinBow2")
tmpGwX,tmpGwY,tmpGwID=$game_map.get_storypoint("GoblinWarrior1")





call_msg("TagMapPB_NorthCP:CPq/Quest1")
portrait_hide
$game_player.direction = 2
$game_player.call_balloon(8)
wait(45)
$game_player.direction = 4
$game_player.call_balloon(8)
wait(45)
$game_player.direction = 6
$game_player.call_balloon(8)
wait(45)
$game_player.direction = 8
$game_player.call_balloon(8)
call_msg("TagMapPB_NorthCP:CPq/Quest2")
call_msg("TagMapPB_NorthCP:CPq/Quest3")
	$game_player.animation = $game_player.animation_mc_pick_up
	SndLib.sound_equip_armor
	$game_map.popup(0,1,235,1)
	$game_system.add_mail("DedSolderLog2")
wait(60)
#do summon mobs
chcg_background_color(0,0,0,0,7)
	get_character(tmpM1ID).moveto(tmpQtX,tmpQtY-2)
	get_character(tmpM1ID).direction = 2
	get_character(tmpM2ID).moveto(tmpQtX,tmpQtY+2)
	get_character(tmpM2ID).direction = 8
	get_character(tmpM1ID).npc_story_mode(true)
	get_character(tmpM2ID).npc_story_mode(true)
	call_msg("TagMapPB_NorthCP:CPq/Quest3_1")
chcg_background_color(0,0,0,255,-7)
call_msg("TagMapPB_NorthCP:CPq/Quest4")
get_character(tmpM1ID).move_forward
get_character(tmpM2ID).move_forward
get_character(tmpM1ID).npc_story_mode(false)
get_character(tmpM2ID).npc_story_mode(false)
call_msg("TagMapPB_NorthCP:CPq/Quest5")
# do goblin summon top group
get_character(tmpGs1ID).moveto(tmpQtX,tmpQtY-4)
get_character(tmpGb1ID).moveto(tmpQtX+1,tmpQtY-4)
get_character(tmpGs1ID).direction = 2
get_character(tmpGb1ID).direction = 2
call_msg("TagMapPB_NorthCP:CPq/Quest6")
# do goblin summon Bot group
get_character(tmpGs2ID).moveto(tmpQtX-1,tmpQtY+5)
get_character(tmpGwID).moveto(tmpQtX+1,tmpQtY+4)
get_character(tmpGb2ID).moveto(tmpQtX+1,tmpQtY+5)
get_character(tmpGs2ID).direction = 8
get_character(tmpGb2ID).direction = 8
get_character(tmpGwID).direction = 8
call_msg("TagMapPB_NorthCP:CPq/Quest7")
cam_follow(tmpM1ID,0)
portrait_hide
get_character(tmpM1ID).turn_random
get_character(tmpM2ID).turn_random
wait(45)
get_character(tmpM1ID).turn_random
get_character(tmpM2ID).turn_random
wait(45)
get_character(tmpM1ID).turn_random
get_character(tmpM2ID).turn_random
wait(45)
call_msg("TagMapPB_NorthCP:CPq/Quest8")
# do summon the dead one
get_character(tmpDoID).npc_story_mode(true)
get_character(tmpDoID).direction = 4
get_character(tmpDoID).jump_to(tmpQtX+3,tmpQtY)
call_msg("TagMapPB_NorthCP:CPq/Quest9")

get_character(tmpM1ID).direction = 6
get_character(tmpM2ID).direction = 6
$game_player.direction = 6
get_character(tmpM1ID).call_balloon(8)
get_character(tmpM2ID).call_balloon(8)
$game_player.call_balloon(8)
call_msg("TagMapPB_NorthCP:CPq/Quest10")
get_character(tmpDoID).move_forward
get_character(tmpDoID).npc_story_mode(false)
call_msg("TagMapPB_NorthCP:CPq/Quest11")
call_msg("TagMapPB_NorthCP:CPq/Quest12")


$story_stats["QuProgPB_NorthCP"] = 2
#set_event_force_page(tmpQcID,9) # if i changed my mind

$game_temp.choice = -1
portrait_hide
cam_center(0)