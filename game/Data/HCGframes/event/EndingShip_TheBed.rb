call_msg("commonEnding:ending/end") #[在逛逛,結束吧]
if $game_temp.choice == 1
	$game_player.animation = $game_player.animation_stun
	SndLib.bgm_stop
	$game_map.interpreter.chcg_background_color(0,0,0,0,3)
	$game_player.force_update = true
	wait(120)
	SndLib.bgs_stop
	wait(60)
	if $story_stats["sex_record_vaginal_count"] == 0
		$bg.erase
		$cg.erase
		call_msg("commonEnding:TicketBought/begin2_virgin")
		GabeSDK.getAchievement("record_vaginal_count_0")
	end
	wait(60)
	tmpDataSavEvID = $game_map.get_storypoint("DualBios")[2]
	
	$game_player.slot_RosterCurrent   = get_character(tmpDataSavEvID).summon_data[:slot_RosterCurrent]
	$game_player.slot_RosterArray     = get_character(tmpDataSavEvID).summon_data[:slot_RosterArray]  
	$game_player.slot_skill_normal    = get_character(tmpDataSavEvID).summon_data[:slot_skill_normal] 
	$game_player.slot_skill_heavy     = get_character(tmpDataSavEvID).summon_data[:slot_skill_heavy]  
	$game_player.slot_skill_control   = get_character(tmpDataSavEvID).summon_data[:slot_skill_control]
	$game_player.slot_hotkey_0        = get_character(tmpDataSavEvID).summon_data[:slot_hotkey_0]     
	$game_player.slot_hotkey_1        = get_character(tmpDataSavEvID).summon_data[:slot_hotkey_1]     
	$game_player.slot_hotkey_2        = get_character(tmpDataSavEvID).summon_data[:slot_hotkey_2]     
	$game_player.slot_hotkey_3        = get_character(tmpDataSavEvID).summon_data[:slot_hotkey_3]     
	$game_player.slot_hotkey_4        = get_character(tmpDataSavEvID).summon_data[:slot_hotkey_4]     
	$game_player.slot_hotkey_other    = get_character(tmpDataSavEvID).summon_data[:slot_hotkey_other] 
	
	
	
	
	
	load_script("Data/HCGframes/OverEvent_RebirthCheck.rb")
	SceneManager.goto(Scene_Gameover)
end
