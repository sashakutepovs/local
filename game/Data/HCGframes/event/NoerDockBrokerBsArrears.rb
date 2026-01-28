$game_map.interpreter.cam_center(0)
portrait_hide
$game_temp.choice= -1

chcg_background_color(0,0,0,0,7)

call_msg("TagMapNoerDock:Captain/WithArrears0")
$game_player.actor.stat["EventExt1Race"] = "Human"
$game_player.actor.stat["EventExt1"] ="Grab"
call_msg("TagMapNoerDock:Captain/WithArrears1")
call_msg("TagMapNoerDock:Captain/WithArrears2")
whole_event_end
portrait_hide



	rape_loop_drop_item(false,false)
	$game_player.actor.change_equip(0, nil)
	$game_player.actor.change_equip(1, nil)
	$game_player.actor.change_equip(5, nil)
	load_script("Data/Batch/Put_BondageItemsON.rb")
	$story_stats["dialog_cuff_equiped"] =0
	SndLib.sound_equip_armor(125)
	$game_party.lose_item("ItemCuff", 99, include_equip =true)
	$game_party.lose_item("ItemChainCuff", 99, include_equip =true)
	$game_party.lose_item("ItemCollar", 99, include_equip =true)
	$game_party.lose_item("ItemChainCollar", 99, include_equip =true)
	#傳送主角至定點
	$game_player.move_normal
	$game_map.interpreter.chcg_background_color(0,0,0,255)
	$game_actors[1].sta = -99 if $game_actors[1].sta <= -99
	change_map_leave_tag_map
	$story_stats["OverMapForceTrans"] = "NoerBackStreet"
	$story_stats["RapeLoop"] =1
	$story_stats["RapeLoopTorture"] =1
	$story_stats["Captured"] =1
	$story_stats["BackStreetArrearsWhorePrincipal"] = 600+($story_stats["WorldDifficulty"]*3).round


