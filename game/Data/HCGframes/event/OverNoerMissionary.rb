if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if get_character(0).switch1_id != 1
	tmpPP = 0
	get_character(0).call_balloon(20)
	call_msg("commonNPC:NoerMissionary/Begin0")
	get_character(0).call_balloon(20)
	call_msg("commonNPC:NoerMissionary/Begin1")
	wait(1)
	SceneManager.goto(Scene_ItemStorage)
	SceneManager.scene.prepare(System_Settings::STORAGE_TEMP)
	wait(1)
	tmpPP = $game_boxes.get_price(System_Settings::STORAGE_TEMP)
	
	tmpPP > 0 ? tmpMoralityPlus = tmpPP / 1000 : tmpMoralityPlus = 0
	if tmpMoralityPlus >=1
	get_character(0).switch1_id = 1
	tmpMoralityPlus = [tmpMoralityPlus,10].min
	$story_stats["WorldDifficulty"] -= tmpMoralityPlus
	$story_stats["WorldDifficulty"] = 0 if $story_stats["WorldDifficulty"] <0
	get_character(0).call_balloon([3,4].sample)
	call_msg("commonNPC:NoerMissionary/END_Good")
	elsif tmpPP > 0
	get_character(0).switch1_id = 1
	get_character(0).call_balloon(5)
	call_msg("commonNPC:NoerMissionary/END_Bad")
	get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
	end
	$game_boxes.box(System_Settings::STORAGE_TEMP).clear
else
	SndLib.sound_QuickDialog
	call_msg_popup("commonNPC:NoerMissionary/Qmsg",get_character(0).id)
end
portrait_hide