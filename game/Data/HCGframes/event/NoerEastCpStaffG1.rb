if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if get_character(0).summon_data == nil
 get_character(0).set_summon_data({:SexTradeble => true})
elsif get_character(0).summon_data[:SexTradeble] == nil
 get_character(0).summon_data[:SexTradeble] = true
end

tmpPlayEvent = false

###################################################### 一般
if get_character(0).switch1_id == 0
	call_msg("TagMapNoerEastCp:staffG1/begin1") #妓女對吧？總算來了！\optD[不是,是]
	get_character(0).switch1_id = 1
	if $game_temp.choice ==1
		call_msg("TagMapNoerEastCp:staffG1/begin1Y")
		call_msg("TagMapNoerEastCp:staffG1/begin2")
		call_msg("TagMapNoerEastCp:staffG1/begin2YY")
		tmpPlayEvent = true
	else
		call_msg("TagMapNoerEastCp:staffG1/begin1N")
		call_msg("TagMapNoerEastCp:staffG1/begin2")
		call_msg("TagMapNoerEastCp:staffG1/begin2_opt") #[我不是！,好吧，我是。]
		
		if $game_temp.choice ==1
			call_msg("TagMapNoerEastCp:staffG1/begin2NN")
			tmpPlayEvent = true
		else
			call_msg("TagMapNoerEastCp:staffG1/begin2NNN")
		end
	end
	cam_center(0)
else
	load_script("Data/HCGframes/event/NpcNatureGuardsWild.rb")
end #sw id

if tmpPlayEvent
	tmpSpX,tmpSpY=$game_map.get_storypoint("SexPoint2")
	tmpAg0X,tmpAg0Y,tmpAg0ID=$game_map.get_storypoint("AnonGuard0")
	tmpAg1X,tmpAg1Y,tmpAg1ID=$game_map.get_storypoint("AnonGuard1")
	tmpAg2X,tmpAg2Y,tmpAg2ID=$game_map.get_storypoint("AnonGuard2")
	tmpAg3X,tmpAg3Y,tmpAg3ID=$game_map.get_storypoint("AnonGuard3")
	
	
	chcg_background_color(0,0,0,0,7)
		$game_player.moveto(tmpSpX,tmpSpY+1)
		get_character(tmpAg0ID).set_npc("NeutralHumanEmptyGuard")
		get_character(tmpAg1ID).set_npc("NeutralHumanEmptyGuard")
		get_character(tmpAg2ID).set_npc("NeutralHumanEmptyGuard")
		get_character(tmpAg3ID).set_npc("NeutralHumanEmptyGuard")
		get_character(tmpAg0ID).moveto($game_player.x+1,$game_player.y)
		get_character(tmpAg1ID).moveto($game_player.x-1,$game_player.y)
		get_character(tmpAg2ID).moveto($game_player.x,$game_player.y+1)
		get_character(tmpAg3ID).moveto($game_player.x,$game_player.y-1)
		get_character(tmpAg0ID).turn_toward_character($game_player)
		get_character(tmpAg1ID).turn_toward_character($game_player)
		get_character(tmpAg2ID).turn_toward_character($game_player)
		get_character(tmpAg3ID).turn_toward_character($game_player)
		get_character(tmpAg0ID).set_summon_data({:NapFucker=>true,:Yeller=>true, :prostituting=>true})
		get_character(tmpAg1ID).set_summon_data({:NapFucker=>true,:Yeller=>true, :prostituting=>true})
		get_character(tmpAg2ID).set_summon_data({:NapFucker=>true,:Yeller=>true, :prostituting=>true})
		get_character(tmpAg3ID).set_summon_data({:NapFucker=>true,:Yeller=>true, :prostituting=>true})
		get_character(tmpAg0ID).npc.fucker_condition={"sex"=>[65535, ">"]}
		get_character(tmpAg1ID).npc.fucker_condition={"sex"=>[65535, ">"]}
		get_character(tmpAg2ID).npc.fucker_condition={"sex"=>[65535, ">"]}
		get_character(tmpAg3ID).npc.fucker_condition={"sex"=>[65535, ">"]}
		get_character(tmpAg0ID).npc.killer_condition={"morality"=>[0, "<"]}
		get_character(tmpAg1ID).npc.killer_condition={"morality"=>[0, "<"]}
		get_character(tmpAg2ID).npc.killer_condition={"morality"=>[0, "<"]}
		get_character(tmpAg3ID).npc.killer_condition={"morality"=>[0, "<"]}
		get_character(tmpAg0ID).npc.assaulter_condition={"morality"=>[0, "<"]}
		get_character(tmpAg1ID).npc.assaulter_condition={"morality"=>[0, "<"]}
		get_character(tmpAg2ID).npc.assaulter_condition={"morality"=>[0, "<"]}
		get_character(tmpAg3ID).npc.assaulter_condition={"morality"=>[0, "<"]}
	chcg_background_color(0,0,0,255,-7)
	
	call_msg("TagMapNoerEastCp:whoreWork/begin1")
	chcg_background_color(0,0,0,0,7)
		$story_stats["dialog_dress_out"] = 0

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
		if equips_Head_id != -1#檢查裝備 並脫裝
			$game_player.actor.change_equip("Head", nil)
			SndLib.sound_equip_armor(125)
			player_force_update
			wait(30)
		end
		if equips_MidExt_id != -1#檢查裝備 並脫裝
			$game_player.actor.change_equip("MidExt", nil)
			SndLib.sound_equip_armor(125)
			player_force_update
			wait(30)
		end
		if equips_Top_id != -1#檢查裝備 並脫裝
			$game_player.actor.change_equip("Top", nil)
			SndLib.sound_equip_armor(125)
			player_force_update
			wait(30)
		end
		if equips_Bot_id != -1#檢查裝備 並脫裝
			$game_player.actor.change_equip("Bot", nil)
			SndLib.sound_equip_armor(125)
			player_force_update
			wait(30)
		end
		if equips_Mid_id != -1#檢查裝備 並脫裝
			$game_player.actor.change_equip("Mid", nil)
			SndLib.sound_equip_armor(125)
			player_force_update
			wait(30)
		end
		SndLib.sound_equip_armor(125)
		$game_party.drop_all_items_to_storage(true,System_Settings::STORAGE_TEMP_MAP)
		player_force_update
		wait(10)
		call_msg("TagMapNoerEastCp:whoreWork/DressOut")
		$game_player.light_check
	chcg_background_color(0,0,0,255,-7)
	
	
	call_msg("TagMapNoerEastCp:whoreWork/begin_unknow") if $story_stats["NoerEastCpSuckDick"] == 0
	$story_stats["NoerEastCpSuckDick"] = 1
	
	$game_player.actor.stat["EventVagRace"] = "Human"
	load_script("Data/HCGframes/Grab_EventVag_VagTouch.rb")
	call_msg("TagMapNoerEastCp:whoreWork/begin_hass0")
	
	$game_player.actor.stat["EventExt1Race"] = "Human"
	load_script("Data/HCGframes/Grab_EventExt1_BoobTouch.rb")
	call_msg("TagMapNoerEastCp:whoreWork/begin_hass1")
	
	$game_player.actor.stat["EventMouthRace"] = "Human"
	load_script("Data/HCGframes/Grab_EventMouth_kissed.rb")
	call_msg("TagMapNoerEastCp:whoreWork/begin_hass2")
	whole_event_end
	
	
	call_msg("TagMapNoerEastCp:whoreWork/begin2")
	
	get_character(tmpAg0ID).animation = get_character(tmpAg0ID).animation_peeing
	get_character(tmpAg1ID).animation = get_character(tmpAg1ID).animation_peeing
	get_character(tmpAg2ID).animation = get_character(tmpAg2ID).animation_peeing
	get_character(tmpAg3ID).animation = get_character(tmpAg3ID).animation_peeing
	get_character(tmpAg0ID).call_balloon(28,-1)
	get_character(tmpAg1ID).call_balloon(28,-1)
	get_character(tmpAg2ID).call_balloon(28,-1)
	get_character(tmpAg3ID).call_balloon(28,-1)
	get_character(tmpAg0ID).npc.sense_target(get_character(tmpAg0ID),0)
	get_character(tmpAg1ID).npc.sense_target(get_character(tmpAg1ID),0)
	get_character(tmpAg2ID).npc.sense_target(get_character(tmpAg2ID),0)
	get_character(tmpAg3ID).npc.sense_target(get_character(tmpAg3ID),0)
end
	

portrait_hide
$story_stats["HiddenOPT1"] = "0" 
$game_temp.choice = -1 
