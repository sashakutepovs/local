eventPlayEnd


slotList = $data_system.equip_type_name
!equip_slot_removetable?("MH")		? equips_MH_id = -1 :		equips_MH_id =		$game_player.actor.equips[slotList["MH"]].item_name		#0
!equip_slot_removetable?("SH")		? equips_SH_id = -1 :		equips_SH_id =		$game_player.actor.equips[slotList["SH"]].item_name		#1
!equip_slot_removetable?("Top")		? equips_Top_id = -1 :		equips_Top_id =		$game_player.actor.equips[slotList["Top"]].item_name	#2
!equip_slot_removetable?("Mid")		? equips_Mid_id = -1 :		equips_Mid_id =		$game_player.actor.equips[slotList["Mid"]].item_name	#3
!equip_slot_removetable?("Bot")		? equips_Bot_id = -1 :		equips_Bot_id =		$game_player.actor.equips[slotList["Bot"]].item_name	#4
!equip_slot_removetable?("TopExt")	? equips_TopExt_id = -1 :	equips_TopExt_id =	$game_player.actor.equips[slotList["TopExt"]].item_name	#5
!equip_slot_removetable?("MidExt")	? equips_MidExt_id = -1 :	equips_MidExt_id =	$game_player.actor.equips[slotList["MidExt"]].item_name	#6
!equip_slot_removetable?("Hair")	? equips_Hair_id = -1 :		equips_Hair_id =	$game_player.actor.equips[slotList["Hair"]].item_name	#7
!equip_slot_removetable?("Head")	? equips_Head_id = -1 :		equips_Head_id =	$game_player.actor.equips[slotList["Head"]].item_name	#8
!equip_slot_removetable?("Neck")	? equips_Neck_id = -1 :		equips_Neck_id =	$game_player.actor.equips[slotList["Neck"]].item_name	#14
!equip_slot_removetable?("Vag")		? equips_Vag_id = -1 :		equips_Vag_id =		$game_player.actor.equips[slotList["Vag"]].item_name	#15
!equip_slot_removetable?("Anal")	? equips_Anal_id = -1 :		equips_Anal_id =	$game_player.actor.equips[slotList["Anal"]].item_name	#16
######################################################################################################

call_msg("commonCommands:Lona/SubmitSkill#{talk_style}")
$story_stats["dialog_dress_out"] = 0
combat_remove_random_equip("MH")
wait(5)
combat_remove_random_equip("SH")
if equips_Head_id != -1 #檢查裝備 並脫裝
	combat_remove_random_equip("Head")
	SndLib.sound_equip_armor(100)
	player_force_update
	wait(30)
end
combat_remove_random_equip("SH")
if equips_MidExt_id != -1 #檢查裝備 並脫裝
	combat_remove_random_equip("MidExt")
	SndLib.sound_equip_armor(100)
	player_force_update
	wait(30)
end
if equips_Top_id != -1 #檢查裝備 並脫裝
	combat_remove_random_equip("Top")
	SndLib.sound_equip_armor(100)
	player_force_update
	wait(30)
end
if equips_Bot_id != -1 #檢查裝備 並脫裝
	combat_remove_random_equip("Bot")
	SndLib.sound_equip_armor(100)
	player_force_update
	wait(30)
end
if equips_Mid_id != -1 #檢查裝備 並脫裝
	combat_remove_random_equip("Mid")
	SndLib.sound_equip_armor(100)
	player_force_update
	wait(30)
end
if equips_Vag_id != -1#檢查裝備 並脫裝
	$game_player.actor.change_equip("Vag", nil)
	SndLib.sound_equip_armor(100)
	player_force_update
	wait(30)
end
if equips_Anal_id != -1#檢查裝備 並脫裝
	$game_player.actor.change_equip("Anal", nil)
	SndLib.sound_equip_armor(100)
	player_force_update
	wait(30)
end
SndLib.BonkHitSap
eventPlayEnd
$game_player.actor.force_stun("Stun9")
