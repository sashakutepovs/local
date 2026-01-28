
if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

#if check_enemy_survival?($story_stats["OnRegionMapSpawnRace"],false)
#	SndLib.sound_QuickDialog
#	$game_map.popup(get_character(0).id,"QuickMsg:RoadHap/EnemyStillHere#{rand(3)}",0,0)
#	return
#end

if get_character(0).switch1_id == 0
	get_character(0).switch1_id =1
	get_character(0).call_balloon(0)
	call_msg("commonNPC:NoerHalp/get_reward0")
	SceneManager.goto(Scene_ItemStorage)
	SceneManager.scene.prepare(System_Settings::STORAGE_TEMP_MAP)
	call_msg("commonNPC:NoerHalp/get_reward1_#{rand(2)}")
	chcg_background_color(0,0,0,0,7)
		get_character(0).delete
	chcg_background_color(0,0,0,255,-7)
end