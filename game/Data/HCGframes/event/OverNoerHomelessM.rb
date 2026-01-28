if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if get_character(0).switch1_id != 1
	tmpPP = 0
	get_character(0).call_balloon(20)
	call_msg("commonNPC:NoerHomeless/beginM#{rand(3)}")
	wait(10)
	SceneManager.goto(Scene_ItemStorage)
	SceneManager.scene.prepare(System_Settings::STORAGE_TEMP)
	call_msg("commonNPC:NoerHomeless/Begin2")
	tmpPP = $game_boxes.get_price(System_Settings::STORAGE_TEMP)
	if tmpPP >= 1
	get_character(0).switch1_id = 1
	optain_morality(1)
	get_character(0).call_balloon([3,4].sample)
	call_msg("commonNPC:NoerHomeless/END_Good#{rand(3)}")
	#get_character(0).npc.drop_list = []
	#get_character(0).npc.death_event = nil
	#get_character(0).force_delete_frame(300)
	get_character(0).move_type= 3
	end
	$game_boxes.box(System_Settings::STORAGE_TEMP).clear
else
	SndLib.sound_QuickDialog
	$game_map.popup(get_character(0).id,"QuickMsg:NPC_FregHobo/Qmsg#{rand(3)}",0,0)
end
portrait_hide