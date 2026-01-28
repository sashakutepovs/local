if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

call_msg("TagMapPB_GobForest:Daughter/begin0") #[算了，給她物資]
case $game_temp.choice 
	when 0 #算了
		call_msg("TagMapPB_GobForest:Daughter/opt_nope")
		$story_stats["QuProgPB_GobForest"] = 4
		
	when 1 #給予物資
		call_msg("TagMapPB_GobForest:Daughter/opt_give")
		
		playerGold = $game_party.gold
		SceneManager.goto(Scene_ItemStorage)
		SceneManager.scene.prepare(System_Settings::STORAGE_TEMP)
		wait(1)
		tmpPP = $game_boxes.get_price(System_Settings::STORAGE_TEMP)
		$game_boxes.box(System_Settings::STORAGE_TEMP).clear
		if tmpPP >= 2000
			$story_stats["QuProgPB_GobForest"] = 6
			$game_player.animation = $game_player.animation_atk_sh
			SndLib.sys_equip
			call_msg("TagMapPB_GobForest:Daughter/opt_give2000")
			call_msg("TagMapPB_GobForest:Daughter/opt_giveTY")
		
		elsif tmpPP >= 100
			$story_stats["QuProgPB_GobForest"] = 5
			$game_player.animation = $game_player.animation_atk_sh
			SndLib.sys_equip
			call_msg("TagMapPB_GobForest:Daughter/opt_give100")
			call_msg("TagMapPB_GobForest:Daughter/opt_giveTY")
		
		else
			$story_stats["QuProgPB_GobForest"] = 4
		end
		$game_party.set_gold(playerGold)
		
end

portrait_hide
chcg_background_color(0,0,0,0,7)
	cam_center(0)
	portrait_off
	get_character(0).delete
chcg_background_color(0,0,0,255,-7)
call_msg("TagMapPB_GobForest:Daughter/END")


case $story_stats["QuProgPB_GobForest"]
	when 5
		optain_exp(5000)
		wait(30)
		optain_morality(1)
	when 6
		optain_exp(5000)
		wait(30)
		optain_morality(2)
	else
		optain_exp(5000)
end
eventPlayEnd
