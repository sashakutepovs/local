if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end


!equip_slot_removetable?(0) ? equips_0_id = -1 : equips_0_id = $game_player.actor.equips[0].id #Weapon
if $game_player.player_cuffed?
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/cuffed#{rand(2)}",0,0)
elsif $game_player.actor.sta <0
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/sta_too_low#{rand(2)}",0,0)
else

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

	if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
		else 
		$game_player.actor.stat["allow_ograsm_record"] = false 
	end
	$game_player.actor.stat["AllowOgrasm"] = true 
	decide_random_part = rand(2)
	$game_player.actor.stat["EventTargetPart"] = "Vag" if decide_random_part == 0
	$game_player.actor.stat["EventTargetPart"] = "Breast" if decide_random_part == 1
	p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} Playing Command_Masturbation"
	portrait_hide
	$game_player.move_normal
	

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
			$game_message.add("\\t[commonCommands:Lona/Masturbation_begin1]")
			$game_map.interpreter.wait_for_message
			$story_stats["dialog_dress_out"] = 0
			if !$game_player.innocent_spotted?
				$game_message.add("\\t[commonCommands:Lona/Masturbation_begin2]")
				$game_map.interpreter.wait_for_message
			else
				$game_message.add("\\t[commonCommands:Lona/Bath_begin3_FuckerSight#{talk_style}]") if $game_player.actor.stat["Exhibitionism"] !=1
				$game_message.add("\\t[commonCommands:Lona/Bath_begin3_FuckerSight_slut]") if $game_player.actor.stat["Exhibitionism"] ==1
				$game_map.interpreter.wait_for_message
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
				$game_player.actor.mood +=rand(10)+20 if $game_player.actor.stat["Exhibitionism"] ==1
			end


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

#################################################################################################################################
	$game_player.animation = $game_player.animation_masturbation_cumming


	until $game_player.actor.arousal >= $game_player.actor.will
		#p "ar #{$game_player.actor.arousal} >= wi#{$game_player.actor.will}"
		lona_mood "p5shame"
		load_script("Data/Batch/Action_CHSH_Masturbation.rb")
		
		if $game_player.actor.arousal >= 0.7*$game_player.actor.will && $game_player.animation != $game_player.animation_masturbation
			$game_player.animation = $game_player.animation_masturbation 
		else
			$game_player.animation = $game_player.animation_masturbation_cumming
		end
		
			$game_map.interpreter.wait(8)
			$game_message.add("\\t[commonH:Lona/frame_normal#{rand(10)}]")
			$game_map.interpreter.wait_for_message
	end
	check_over_event
	
	############################################事件結束##########################################################
	$game_player.actor.add_state(44)#Masturbationed
	$story_stats["sex_record_masturbation_count"] +=1
	$game_player.actor.stat["EventTargetPart"] = nil
	$game_player.animation = nil
	$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false
	############################################事件結束##########################################################
	Audio.se_stop
	

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
	
	if tmp_fucker_id != nil
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
		return
	end
end

portrait_hide
