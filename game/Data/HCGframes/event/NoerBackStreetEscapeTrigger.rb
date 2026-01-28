

tmpU1X,tmpU1Y,tmpU1ID=$game_map.get_storypoint("UpGang1")
tmpU2X,tmpU2Y,tmpU2ID=$game_map.get_storypoint("UpGang2")
tmpU3X,tmpU3Y,tmpU3ID=$game_map.get_storypoint("UpGang3")
tmpU4X,tmpU4Y,tmpU4ID=$game_map.get_storypoint("UpGang4")
tmpD1X,tmpD1Y,tmpD1ID=$game_map.get_storypoint("DownGang1")
tmpD2X,tmpD2Y,tmpD2ID=$game_map.get_storypoint("DownGang2")
tmpD3X,tmpD3Y,tmpD3ID=$game_map.get_storypoint("DownGang3")
tmpD4X,tmpD4Y,tmpD4ID=$game_map.get_storypoint("DownGang4")
get_character(tmpU1ID).set_npc("GangHumanCatcher")
get_character(tmpU2ID).set_npc("GangHumanCatcher")
get_character(tmpU3ID).set_npc("GangHumanWarrior")
get_character(tmpU4ID).set_npc("GangHumanWarrior")
get_character(tmpD1ID).set_npc("GangHumanCatcher")
get_character(tmpD2ID).set_npc("GangHumanCatcher")
get_character(tmpD3ID).set_npc("GangHumanWarrior")
get_character(tmpD4ID).set_npc("GangHumanWarrior")

set_event_force_page(tmpU1ID,1,0)
set_event_force_page(tmpU2ID,1,0)
set_event_force_page(tmpU3ID,1,0)
set_event_force_page(tmpU4ID,1,0)
set_event_force_page(tmpD1ID,1,0)
set_event_force_page(tmpD2ID,1,0)
set_event_force_page(tmpD3ID,1,0)
set_event_force_page(tmpD4ID,1,0)

get_character(tmpU1ID).moveto(45,27)
get_character(tmpU2ID).moveto(46,27)
get_character(tmpU3ID).moveto(47,27)
get_character(tmpU4ID).moveto(48,27)
get_character(tmpD1ID).moveto(45,68)
get_character(tmpD2ID).moveto(46,68)
get_character(tmpD3ID).moveto(47,68)
get_character(tmpD4ID).moveto(48,68)

get_character(tmpU1ID).npc.add_fated_enemy([0])
get_character(tmpU2ID).npc.add_fated_enemy([0])
get_character(tmpU3ID).npc.add_fated_enemy([0])
get_character(tmpU4ID).npc.add_fated_enemy([0])
get_character(tmpD1ID).npc.add_fated_enemy([0])
get_character(tmpD2ID).npc.add_fated_enemy([0])
get_character(tmpD3ID).npc.add_fated_enemy([0])
get_character(tmpD4ID).npc.add_fated_enemy([0])
$story_stats["RapeLoopTorture"] = 1
if $story_stats["Captured"] == 1
	call_msg("TagMapNoerBackStreet:Escape/begin")
	eventPlayEnd
else
	get_character($game_map.get_storypoint("MapCont")[2]).summon_data[:FuckOff] = true
	call_msg("TagMapNoerBackStreet:Escape/begin_NoCapture")
	eventPlayEnd
end
