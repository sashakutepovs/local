
if !$game_map.threat
	$game_temp.choice = -1 #還原OPTION
	temp_vag_cums =$game_actors[1].cumsMeters["CumsCreamPie"]
	temp_anal_cums =$game_actors[1].cumsMeters["CumsMoonPie"]
	temp_groin_cums = $game_actors[1].cumsMeters["CumsCreamPie"] + $game_actors[1].cumsMeters["CumsMoonPie"]
	temp_milk_level = $game_actors[1].lactation_level
	if temp_groin_cums >=1 ; $story_stats["HiddenOPT1"] = "1" else $story_stats["HiddenOPT1"] = "0" end #出現選項前先把需要使用的差分變數做設定
	if temp_milk_level >=300 ; $story_stats["HiddenOPT2"] = "1" else $story_stats["HiddenOPT2"] = "0" end #同上
	
	total_wound = $game_player.actor.get_total_wounds
	#$game_actors[1].state_stack(29) 6~13 15 16


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
	
	$game_message.add("\\t[commonCommands:Lona/Bath_begin]")
	$game_map.interpreter.wait_for_message
	
	if $game_temp.choice == 1
		$story_stats["dialog_dress_out"] = 0
		$game_actors[1].sta -=15 #扣除本行動STA
		if !$game_player.innocent_spotted?
			$game_message.add("\\t[commonCommands:Lona/Bath_begin3_NoFuckerSight]")
			$game_map.interpreter.wait_for_message
		else
			$game_message.add("\\t[commonCommands:Lona/Bath_begin3_FuckerSight#{talk_style}]")
			$game_map.interpreter.wait_for_message
			case $game_player.actor.stat["persona"] #主角處於視線下 檢測PERSONA來決定屬性變化
				when "typical"
					$game_actors[1].mood -=rand(10)+5
				when "gloomy"
					$game_actors[1].mood -=rand(5)+3
				when "tsundere"
					$game_actors[1].mood -=rand(10)+20
				when "slut"
					$game_actors[1].mood +=rand(10)+5
			end
		end
		chcg_background_color(0,0,0,0,7)
		if equips_6_id != -1#檢查裝備 並脫裝
			$game_actors[1].change_equip(6, nil) 
			player_force_update
			wait(30)
		end
		if equips_2_id != -1#檢查裝備 並脫裝
			$game_actors[1].change_equip(2, nil) 
			player_force_update
			wait(30)
		end
		if equips_4_id != -1#檢查裝備 並脫裝
			$game_actors[1].change_equip(4, nil) 
			player_force_update
			wait(30)
		end
		if equips_3_id != -1#檢查裝備 並脫裝
			$game_actors[1].change_equip(3, nil) 
			player_force_update
			wait(30)
		end
		
		if $game_player.player_cuffed? #檢查手銬
			$game_message.add("\\t[commonCommands:Lona/Bath_cuffed]")
			$game_map.interpreter.wait_for_message
		end
		
		if total_wounds ==0 #正在洗 檢測是否負傷 並執行對應狀態
			$game_message.add("\\t[commonCommands:Lona/Bath_washing]")
			$game_map.interpreter.wait_for_message
			elsif total_wounds !=0 && $game_player.actor.stat["Masochist"] !=1 #有受傷  不是M
			$game_message.add("\\t[commonCommands:Lona/Bath_washing_IfWounds]")
			$game_map.interpreter.wait_for_message
			$game_actors[1].mood -= (total_wounds*0.5).round
			elsif total_wounds !=0 && $game_player.actor.stat["Masochist"] ==1 #有受傷 是個M
			$game_message.add("\\t[commonCommands:Lona/Bath_washing_IfWoundsM]")
			$game_map.interpreter.wait_for_message
			$game_actors[1].sta +=2
			$game_actors[1].mood += (total_wounds*0.5).round
		end
		chcg_background_color(0,0,0,255,-7)
		$game_message.add("\\t[commonCommands:Lona/Bath_end]")
		$game_map.interpreter.wait_for_message
		
		#if !Input.press?(:SHIFT)
			if equips_3_id != -1#檢查裝備 並穿裝
				$game_actors[1].change_equip(3, $data_armors[equips_3_id])
				player_force_update
				wait(30)
			end
			if equips_4_id != -1#檢查裝備 並穿裝
				$game_actors[1].change_equip(4, $data_armors[equips_4_id])
				player_force_update
				wait(30)
			end
			if equips_2_id != -1#檢查裝備 並穿裝
				$game_actors[1].change_equip(2, $data_armors[equips_2_id])
				player_force_update
				wait(30)
			end
			if equips_6_id != -1#檢查裝備 並穿裝
				$game_actors[1].change_equip(6, $data_armors[equips_6_id])
				player_force_update
				wait(30)
			end
		#end
	end
	
	if $game_temp.choice == 2 #轉去執行清理下半身
	load_script("Data/HCGframes/Command_GroinClearn.rb")
	end
	if $game_temp.choice == 3 #擠奶
	load_script("Data/HCGframes/Command_SelfMilking.rb")
	end
else
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
end
