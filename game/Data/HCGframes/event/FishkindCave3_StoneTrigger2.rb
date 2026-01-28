$game_map.interpreter.screen.start_shake(1,7,20)
SndLib.sound_FlameCast(60,70)
SndLib.sound_equip_armor(60,70)
$game_player.animation = $game_player.animation_mc_pick_up
get_character(0).switch1_id +=1
get_character(0).switch1_id =1 if get_character(0).switch1_id >4
set_this_event_force_page(get_character(0).switch1_id)
$game_player.actor.sta -= 1


s1ID=$game_map.get_storypoint("Stone1B")[2]
s2ID=$game_map.get_storypoint("Stone2B")[2]
s3ID=$game_map.get_storypoint("Stone3B")[2]
s4ID=$game_map.get_storypoint("Stone4B")[2]
g2ID=$game_map.get_storypoint("Swirl2")[2]
st1ID=$game_map.get_storypoint("StoneTar1B")[2]
st2ID=$game_map.get_storypoint("StoneTar2B")[2]
st3ID=$game_map.get_storypoint("StoneTar3B")[2]
st4ID=$game_map.get_storypoint("StoneTar4B")[2]
chk1 = get_character(s1ID).switch1_id == get_character(st1ID).switch1_id
chk2 = get_character(s2ID).switch1_id == get_character(st2ID).switch1_id
chk3 = get_character(s3ID).switch1_id == get_character(st3ID).switch1_id
chk4 = get_character(s4ID).switch1_id == get_character(st4ID).switch1_id
chk5 = get_character(g2ID).switch1_id==0
if chk1 && chk2 && chk3 && chk4 && chk5
 get_character(g2ID).switch1_id = 1
 set_event_force_page(g2ID,2)
 get_character(g2ID).animation = get_character(g2ID).animation_swirl
end