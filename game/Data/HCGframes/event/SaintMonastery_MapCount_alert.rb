$game_map.npcs.each do |event|
 next if event.npc.fraction != 13
 event.npc.add_fated_enemy([0])
 SndLib.bgm_play("CB_-_Zombies_Everywhere",70,95)
 $story_stats["BG_EFX_data"] = get_BG_EFX_data_Indoor
end

$story_stats["RapeLoopTorture"] = 0 if $story_stats["Captured"] == 1
$story_stats["RapeLoop"] = 1
call_msg("TagMapSaintMonastery:Alert/begin1")

set_this_event_force_page(3)

