$game_map.interpreter.screen.start_shake(1,7,20)
SndLib.closeDoor
SndLib.sound_equip_armor(60,70)
$game_player.animation = $game_player.animation_mc_pick_up
$game_player.actor.sta -= 1

tmpT1ID=$game_map.get_storypoint("TopB1")[2]
tmpT2ID=$game_map.get_storypoint("TopB2")[2]
tmpT3ID=$game_map.get_storypoint("TopB3")[2]
tmpT4ID=$game_map.get_storypoint("TopB4")[2]
tmpT5ID=$game_map.get_storypoint("StoneTop1")[2]
tmpT6ID=$game_map.get_storypoint("StoneTop2")[2]
tmpT7ID=$game_map.get_storypoint("StoneTop3")[2]
tmpT8ID=$game_map.get_storypoint("StoneTop4")[2]
tmpT9ID=$game_map.get_storypoint("StoneTop5")[2]
tmpT10ID=$game_map.get_storypoint("StoneTop6")[2]
tmpT11ID=$game_map.get_storypoint("StoneTop7")[2]

get_character(0).direction = 4
$story_stats["RegionMap_RegionOuta"] = $game_map.region_map[3].shuffle
wait(5)
SndLib.stoneCollapsed
wait(5)
SndLib.stoneCollapsed
get_character(tmpT1ID).npc_story_mode(true)
get_character(tmpT2ID).npc_story_mode(true)
get_character(tmpT3ID).npc_story_mode(true)
get_character(tmpT4ID).npc_story_mode(true)
get_character(tmpT5ID).npc_story_mode(true)
get_character(tmpT6ID).npc_story_mode(true)
get_character(tmpT7ID).npc_story_mode(true)
get_character(tmpT8ID).npc_story_mode(true)
get_character(tmpT9ID).npc_story_mode(true)
get_character(tmpT10ID).npc_story_mode(true)
get_character(tmpT11ID).npc_story_mode(true)
point=$story_stats["RegionMap_RegionOuta"].shift
get_character(tmpT1ID).moveto(point[0],8)
get_character(tmpT1ID).jump_to(point[0],point[1])
point=$story_stats["RegionMap_RegionOuta"].shift
get_character(tmpT2ID).moveto(point[0],8)
get_character(tmpT2ID).jump_to(point[0],point[1])
point=$story_stats["RegionMap_RegionOuta"].shift
get_character(tmpT3ID).moveto(point[0],8)
get_character(tmpT3ID).jump_to(point[0],point[1])
point=$story_stats["RegionMap_RegionOuta"].shift
get_character(tmpT4ID).moveto(point[0],8)
get_character(tmpT4ID).jump_to(point[0],point[1])
point=$story_stats["RegionMap_RegionOuta"].shift
get_character(tmpT5ID).moveto(point[0],8)
get_character(tmpT5ID).jump_to(point[0],point[1])
point=$story_stats["RegionMap_RegionOuta"].shift
get_character(tmpT6ID).moveto(point[0],8)
get_character(tmpT6ID).jump_to(point[0],point[1])
point=$story_stats["RegionMap_RegionOuta"].shift
get_character(tmpT7ID).moveto(point[0],8)
get_character(tmpT7ID).jump_to(point[0],point[1])
point=$story_stats["RegionMap_RegionOuta"].shift
get_character(tmpT8ID).moveto(point[0],8)
get_character(tmpT8ID).jump_to(point[0],point[1])
point=$story_stats["RegionMap_RegionOuta"].shift
get_character(tmpT9ID).moveto(point[0],8)
get_character(tmpT9ID).jump_to(point[0],point[1])
point=$story_stats["RegionMap_RegionOuta"].shift
get_character(tmpT10ID).moveto(point[0],8)
get_character(tmpT10ID).jump_to(point[0],point[1])
point=$story_stats["RegionMap_RegionOuta"].shift
get_character(tmpT11ID).moveto(point[0],8)
get_character(tmpT11ID).jump_to(point[0],point[1])

wait(30)
5.times{
SndLib.stoneCollapsed(70+rand(40))
wait(2+rand(5))
}
get_character(0).direction = 8
get_character(tmpT1ID).npc_story_mode(false)
get_character(tmpT2ID).npc_story_mode(false)
get_character(tmpT3ID).npc_story_mode(false)
get_character(tmpT4ID).npc_story_mode(false)
get_character(tmpT5ID).npc_story_mode(false)
get_character(tmpT6ID).npc_story_mode(false)
get_character(tmpT7ID).npc_story_mode(false)
get_character(tmpT9ID).npc_story_mode(false)
get_character(tmpT10ID).npc_story_mode(false)
get_character(tmpT11ID).npc_story_mode(false)