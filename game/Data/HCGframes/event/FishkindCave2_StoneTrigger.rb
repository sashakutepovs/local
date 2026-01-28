$game_map.interpreter.screen.start_shake(1,7,20)
SndLib.sound_FlameCast(60,70)
SndLib.sound_equip_armor(60,70)
$game_player.animation = $game_player.animation_mc_pick_up
get_character(0).switch1_id +=1
get_character(0).switch1_id =1 if get_character(0).switch1_id >4
set_this_event_force_page(get_character(0).switch1_id)
$game_player.actor.sta -= 1


s1ID=$game_map.get_storypoint("Stone1")[2]
s2ID=$game_map.get_storypoint("Stone2")[2]
s3ID=$game_map.get_storypoint("Stone3")[2]
s4ID=$game_map.get_storypoint("Stone4")[2]
g1ID=$game_map.get_storypoint("Swirl1")[2]
g2ID=$game_map.get_storypoint("Swirl2")[2]
st1ID=$game_map.get_storypoint("StoneTar1")[2]
st2ID=$game_map.get_storypoint("StoneTar2")[2]
st3ID=$game_map.get_storypoint("StoneTar3")[2]
st4ID=$game_map.get_storypoint("StoneTar4")[2]
chk1 = get_character(s1ID).switch1_id == get_character(st1ID).switch1_id
chk2 = get_character(s2ID).switch1_id == get_character(st2ID).switch1_id
chk3 = get_character(s3ID).switch1_id == get_character(st3ID).switch1_id
chk4 = get_character(s4ID).switch1_id == get_character(st4ID).switch1_id
chk5 = get_character(g1ID).switch1_id==0
if chk1 && chk2 && chk3 && chk4 && chk5
 get_character(g1ID).switch1_id = 1
 set_event_force_page(g1ID,2)
 get_character(g1ID).animation = get_character(g1ID).animation_swirl
 get_character(g2ID).switch1_id = 0
 set_event_force_page(g2ID,3)
 get_character(g2ID).animation = nil
end