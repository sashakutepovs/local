if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).animation =  nil
get_character(0).call_balloon(0)

if get_character(0).summon_data[:JobAccept] && !get_character(0).summon_data[:JobStarted]

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
	withCloth = !$game_player.player_nude?

	if $story_stats["SouthFL_PurgeWorkTimes"] >= 1
		call_msg("TagMapSouthFL:healerFInn/Work0_did")
	else
		call_msg("TagMapSouthFL:healerFInn/Work0_new")
	end
	
	call_msg("TagMapSouthFL:healerFInn/Work1")
	call_msg("common:Lona/Decide_optB") #[算了,決定]
	return eventPlayEnd if $game_temp.choice != 1
	call_msg("TagMapSouthFL:healerFInn/Work_accept0")
	if withCloth
		call_msg("TagMapSouthFL:healerFInn/Work_BodyCheck0")
		call_msg("common:Lona/Decide_optB") #[算了,決定]
		return eventPlayEnd if $game_temp.choice != 1
		call_msg("TagMapSouthFL:healerFInn/Work_BodyCheck1")
		if equips_Head_id != -1#檢查裝備 並脫裝
			$game_player.actor.change_equip("Head", nil)
			SndLib.sound_equip_armor(125)
			player_force_update
			wait(30)
		end
		if equips_MidExt_id != -1#檢查裝備 並脫裝
			$game_player.actor.change_equip("MidExt", nil)
			SndLib.sound_equip_armor(100)
			player_force_update
			wait(30)
		end
		if equips_Top_id != -1#檢查裝備 並脫裝
			$game_player.actor.change_equip("Top", nil)
			SndLib.sound_equip_armor(100)
			player_force_update
			wait(30)
		end
		if equips_Bot_id != -1#檢查裝備 並脫裝
			$game_player.actor.change_equip("Bot", nil)
			SndLib.sound_equip_armor(100)
			player_force_update
			wait(30)
		end
		if equips_Mid_id != -1#檢查裝備 並脫裝
			$game_player.actor.change_equip("Mid", nil)
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
		if equips_Vag_id != -1#檢查裝備 並脫裝
			$game_player.actor.change_equip("Vag", nil)
			SndLib.sound_equip_armor(100)
			player_force_update
			wait(30)
		end
		call_msg("TagMapSouthFL:healerFInn/Work_BodyCheck2")
		3.times{
			$game_player.actor.stat["EventVagRace"] = "Human"
			load_script("Data/HCGframes/Grab_EventVag_VagTouch.rb")
			get_character(0).call_balloon(8)
			wait(30)
			}
	end #withCloth
	tmpVagCum = $game_player.actor.cumsMeters["CumsCreamPie"]
	tmpAnalCum = $game_player.actor.cumsMeters["CumsMoonPie"]
	if tmpAnalCum+tmpVagCum >= 300
		get_character(0).process_npc_DestroyForceRoute
		get_character(0).npc_story_mode(true)
		get_character(0).animation = get_character(0).animation_grabber_qte($game_player)
		$game_player.animation = $game_player.animation_grabbed_qte
		wait(30)
		get_character(0).animation = get_character(0).animation_handjob_giver($game_player)
		get_character(0).y >= $game_player.y ? get_character(0).forced_z = 10 :  get_character(0).forced_z = 20
		$game_player.animation = $game_player.animation_handjob_target
		2.times{
			$game_player.actor.stat["EventVagRace"] = "Human"
			load_script("Data/HCGframes/Grab_EventVag_VagLick.rb")
			get_character(0).call_balloon(8)
			wait(50)
		}
		portrait_hide
		get_character(0).npc_story_mode(false)
		get_character(0).animation = nil
		$game_player.animation = nil
		get_character(0).forced_z = 0
		call_msg("TagMapSouthFL:healerFInn/Work_VagLick0")
		call_msg("TagMapSouthFL:healerFInn/Work_BodyCheck2")
	else
		call_msg("TagMapSouthFL:healerFInn/Work_VagLick1")
	end #tmpAnalCum+tmpVagCum >= 1
	

	$game_map.npcs.each do |event|
		next if event.summon_data == nil
		next if !event.summon_data[:jobMan]
		next if event.actor.action_state == :death
		event.animation = nil
		event.direction = 8
		event.call_balloon(4)
	end
	call_msg("TagMapSouthFL:healerFInn/Work_accept1")
	$story_stats["SouthFL_PurgeWorkTimes"] += 1
	$story_stats["SouthFL_DailyWorkAmt"] = $game_date.dateAmt
	get_character(0).summon_data[:JobStarted] = true
	$game_map.npcs.each do |event|
		next if event.summon_data == nil
		next if !event.summon_data[:NeedCure]
		next if event.actor.action_state == :death
		event.summon_data[:DoingJob] = true
		event.call_balloon(19,-1)
	end
	
	
	get_character(0).npc.master = $game_player
	get_character(0).set_this_event_follower(0)
	get_character(0).follower=[1,1,0,0]
	get_character(0).summon_data[:follower] = true
	get_character(0).set_manual_move_type(3)
	get_character(0).move_type = 3
	
elsif get_character(0).summon_data[:JobAccept] && get_character(0).summon_data[:JobStarted]
	tmpCurPoint = $story_stats["HiddenOPT1"] = get_character(0).summon_data[:WorkScore]
	call_msg("TagMapSouthFL:healerFInn/WorkDOing_HerDialog") #[算了,結束]
	$story_stats["HiddenOPT1"] = "0"
	return eventPlayEnd if $game_temp.choice != 1
	get_character(0).summon_data[:JobStarted] = false
	$game_map.npcs.each do |event|
		next if event.summon_data == nil
		next unless event.summon_data[:NeedCure] == true || event.summon_data[:NeedCure] == false
		next if event.actor.action_state == :death
		event.summon_data[:NeedCure] = false
		event.call_balloon(0)
	end
	if tmpCurPoint >= 50
		call_msg("TagMapSouthFL:healerFInn/WorkDOing_HerDialog_end")
		tmpCurPoint = (tmpCurPoint*2.1).to_i
		optain_item_chain(tmpCurPoint,["ItemCoin1","ItemCoin2","ItemCoin3"],false)
	else
		call_msg("TagMapSouthFL:healerFInn/WorkDOing_HerDialog_end_noReward")
	end
	chcg_background_color(0,0,0,0,7)
		get_character(0).delete
	chcg_background_color(0,0,0,255,-7)
	
	
else
	SndLib.sound_QuickDialog
	call_msg_popup("TagMapSouthFL:healerFInn/Qmsg#{rand(3)}",get_character(0).id)
end
eventPlayEnd
