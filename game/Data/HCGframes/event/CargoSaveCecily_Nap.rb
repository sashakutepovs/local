$game_map.interpreter.chcg_background_color(0,0,0,255)
call_msg("TagMapCargoSaveCecily:QuestFailed/Nap2")
$story_stats["QuProgSaveCecily"] = -1
$story_stats["RecQuestSaveCecily"] = -1
$story_stats["OverMapForceTrans"] = "NoerMobHouse"
$game_actors[1].change_equip(5, nil)
rape_loop_drop_item(false,false)
$game_party.gain_item("ItemChainCuff", 1)
$game_actors[1].change_equip(0, "ItemChainCuff")
$story_stats["dialog_collar_equiped"] =0
SndLib.sound_equip_armor(125)
call_msg("TagMapCargoSaveCecily:QuestFailed/Nap3")
player_force_update
call_msg("TagMapCargoSaveCecily:QuestFailed/Nap1")
$game_player.move_normal
$game_actors[1].sta = -99 if $game_actors[1].sta <= -99
change_map_leave_tag_map
$story_stats["Captured"] = 1

return portrait_hide
