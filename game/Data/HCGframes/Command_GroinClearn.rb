if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

portrait_hide

tmp_fucker_id = nil
$game_map.npcs.each do |event| 
		next if event.actor.friendly?($game_player)
		next if event.actor.action_state != nil && event.actor.action_state !=:none
		next if !event.near_the_target?($game_player,5)
		next if !event.actor.target.nil?
		next if event.opacity != 255
		next if event.actor.sensors[0].get_signal(event,$game_player)[2] <=15 #[target,distance,signal_strength,sensortype]
		next if event.actor.sex != 1
		$game_player.actor.setup_state(161,10) #DoormatUp20
		next if event.summon_data == nil
		next if event.summon_data[:NapFucker] == nil
		next if !event.summon_data[:NapFucker]
		event.summon_data[:NapFucker] = false
		tmp_fucker_id = event.id
end

	temp_vag_cums =$game_player.actor.cumsMeters["CumsCreamPie"]


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
	
	$game_player.actor.sta -=10 #扣除本行動STA
	
	call_msg("commonCommands:Lona/GroinClearn_begin1")
	
	if $game_player.innocent_spotted?
			call_msg("commonCommands:Lona/Bath_begin3_FuckerSight#{talk_style}")
			case $game_player.actor.stat["persona"] #主角處於視線下 檢測PERSONA來決定屬性變化
				when "typical"
					$game_player.actor.mood -=rand(10)+5
				when "gloomy"
					$game_player.actor.mood -=rand(5)+3
				when "tsundere"
					$game_player.actor.mood -=rand(10)+20
				when "slut"
					$game_player.actor.mood +=rand(10)+5
			end
	end
	chcg_background_color(0,0,0,0,7)

	if equips_MidExt_id != -1#檢查裝備 並脫裝
		$game_player.actor.change_equip("MidExt", nil)
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
	if equips_Vag_id != -1#檢查裝備 並脫裝
		$game_player.actor.change_equip("Vag", nil)
		SndLib.sound_equip_armor(100)
		player_force_update
		wait(30)
	end
	if $game_player.player_cuffed? #檢查手銬
		$game_message.add("\\t[commonCommands:Lona/GroinClearn_cuffed]")
		$game_map.interpreter.wait_for_message
	end

	load_script("Data/Batch/Command_GroinClearn.rb")
	call_msg("commonCommands:Lona/GroinClearn_begin2_1")
	load_script("Data/Batch/Command_GroinClearn.rb")
	call_msg("commonCommands:Lona/GroinClearn_begin2_2")
	load_script("Data/Batch/Command_GroinClearn.rb")
	call_msg("commonCommands:Lona/GroinClearn_begin2_3")
	load_script("Data/Batch/Command_GroinClearn.rb")
	tmpReward = []
	2.times{
		temp_CumsCreamPie =$game_player.actor.cumsMeters["CumsCreamPie"]
		temp_CumsMoonPie =$game_player.actor.cumsMeters["CumsMoonPie"]
		if !$game_player.player_cuffed? #檢查上銬否
			$game_player.actor.stat["SemenGulper"] == 1 ? tmpValue = 200 : tmpValue = 250
			tmpReward += chcg_clearn_vag_semen_trans_to_event(tmpValue)
			tmpReward += chcg_clearn_anal_semen_trans_to_event(tmpValue)
			$game_player.actor.healCums("CumsMoonPie", ((temp_CumsMoonPie * 0.3).round)+$game_player.actor.constitution)
			$game_player.actor.healCums("CumsCreamPie", ((temp_CumsCreamPie * 0.3).round)+$game_player.actor.constitution)
		else
			$game_player.actor.stat["SemenGulper"] == 1 ? tmpValue = 450 : tmpValue = 500
			tmpReward += chcg_clearn_vag_semen_trans_to_event(tmpValue)
			tmpReward += chcg_clearn_anal_semen_trans_to_event(tmpValue)
			$game_player.actor.healCums("CumsMoonPie", ((temp_CumsMoonPie * 0.2).round)+$game_player.actor.constitution)
			$game_player.actor.healCums("CumsCreamPie", ((temp_CumsCreamPie * 0.2).round)+$game_player.actor.constitution)
		end
		$game_player.actor.healCums("CumsCreamPie", 10) #基礎效果
		$game_player.actor.healCums("CumsMoonPie", 10)
	}
	
	$game_map.reserve_summon_event("WasteSemen") if [true,false].sample && !$game_map.isOverMap
	$game_map.reserve_summon_event("WasteSemen") if [true,false].sample && !$game_map.isOverMap
	call_msg("commonCommands:Lona/GroinClearn_begin2_4")
	
	#變更洗澡屬性
	chcg_background_color(0,0,0,255,-7)
	if temp_vag_cums >= 50
		call_msg("commonCommands:Lona/GroinClearn_failed#{talk_persona}")
	else
		call_msg("commonCommands:Lona/GroinClearn_win")
	end
	Audio.se_stop
	
if tmp_fucker_id == nil
	#if !Input.press?(:SHIFT)
		if equips_Vag_id != -1#檢查裝備 並穿裝
			$game_player.actor.change_equip("Vag", $data_ItemName[equips_Vag_id])
			SndLib.sound_equip_armor(100)
			player_force_update
			wait(30)
		end
		if equips_Bot_id != -1#檢查裝備 並穿裝
			$game_player.actor.change_equip("Bot", $data_ItemName[equips_Bot_id])
			SndLib.sound_equip_armor(100)
			player_force_update
			wait(30)
		end
		if equips_MidExt_id != -1#檢查裝備 並穿裝
			$game_player.actor.change_equip("MidExt", $data_ItemName[equips_MidExt_id])
			SndLib.sound_equip_armor(100)
			player_force_update
			wait(30)
		end
	#end
else # not nil
	$story_stats["sex_record_privates_seen"] +=1
	$game_player.actor.setup_state(161,10)
	get_character(tmp_fucker_id).setup_audience
	get_character(tmp_fucker_id).move_type =0
	get_character(tmp_fucker_id).opacity = 255
	get_character(tmp_fucker_id).animation = nil
	get_character(tmp_fucker_id).call_balloon(2)
	get_character(tmp_fucker_id).turn_toward_character($game_player)
	get_character(tmp_fucker_id).npc_story_mode(true,false)
	wait(80)
	10.times{
		if get_character(tmp_fucker_id).report_range($game_player) > 1
			get_character(tmp_fucker_id).move_speed = 2.8
			get_character(tmp_fucker_id).move_toward_TargetSmartAI($game_player)
			get_character(tmp_fucker_id).call_balloon(8)
			until !get_character(tmp_fucker_id).moving?
				wait(1)
			end
		end
	}
	get_character(tmp_fucker_id).call_balloon(4)
	get_character(tmp_fucker_id).npc_story_mode(false,false)
	get_character(tmp_fucker_id).turn_toward_character($game_player)
	get_character(tmp_fucker_id).npc.fucker_condition={"weak"=>[100, ">"],"sexy"=>[40, ">"],"sex"=>[0, "="],}
	get_character(tmp_fucker_id).actor.process_target_lost
end
p "total cums reward => #{tmpReward}"
#msgbox "total cums reward => #{tmpReward}"
if !tmpReward.empty?
	tmpFinal = tmpReward.group_by{|x| x[0]}.map{|x| [x[0], x[1].sum{|x| x[1]}]}
	tmpFinal.each.each{|itemName,itemNumber|
		p "item=#{itemName}   num=#{itemNumber}"
		optain_item(itemName,itemNumber)
		wait(30)
	}
end
eventPlayEnd
