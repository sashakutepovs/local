call_msg("commonCommands:Lona/Bath_tooClearn") if $game_player.actor.dirt < 10
$game_portraits.lprt.hide
	temp_vag_cums =$game_player.actor.cumsMeters["CumsCreamPie"]
	temp_anal_cums =$game_player.actor.cumsMeters["CumsMoonPie"]
	temp_groin_cums = $game_player.actor.cumsMeters["CumsCreamPie"] + $game_player.actor.cumsMeters["CumsMoonPie"]
	temp_milk_level = $game_player.actor.lactation_level
	
	total_wounds = $game_player.actor.get_total_wounds

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


		$game_player.move_normal
		$story_stats["dialog_dress_out"] = 0
		$game_player.actor.sta -=15 #扣除本行動STA
		if !$game_player.innocent_spotted?
			$game_message.add("\\t[commonCommands:Lona/Bath_begin3_NoFuckerSight]")
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
		chcg_background_color(0,0,0,0,7)
		if equips_Head_id != -1#檢查裝備 並脫裝
			$game_player.actor.change_equip("Head", nil)
			SndLib.sound_equip_armor(100)
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

		if $game_player.player_cuffed? #檢查手銬
			call_msg("commonCommands:Lona/Bath_cuffed")
		end
		SndLib.waterBath

		#check if spec event on there
		tmpEval = '
		specDmgEVname = nil
		$game_map.events_xy($game_player.x,$game_player.y).each{|ev|
			next if ev.deleted?
			break specDmgEVname = ev.name if ev.name == "EfxCorrosionArea"
		}
		case specDmgEVname
		 	when "EfxCorrosionArea"
		 		if $game_player.actor.stat["RaceRecord"] != "Abomination"
					SndLib.sound_AcidBurn(100)
					SndLib.sound_AcidBurn(100,80)
					SndLib.sound_combat_hit_gore(90)
					$game_player.actor.health -= 100 if specDmgEVname && $game_player.actor.health >= 100
					$game_player.actor.health = 1 if $game_player.actor.health <= 100
				end
		end
		'
		if total_wounds ==0 #正在洗 檢測是否負傷 並執行對應狀態
				SndLib.waterBath
				eval(tmpEval)
				2.times{load_script("Data/Batch/Command_Bath.rb")}
				call_msg("commonCommands:Lona/Bath_washing")
				SndLib.waterBath
				eval(tmpEval)
				2.times{load_script("Data/Batch/Command_Bath.rb")}
			elsif total_wounds !=0 && $game_player.actor.stat["Masochist"] !=1 #有受傷  不是M
				call_msg("commonCommands:Lona/Bath_washing_IfWounds0")
				SndLib.waterBath
				eval(tmpEval)
				2.times{load_script("Data/Batch/Command_Bath.rb")}
				call_msg("commonCommands:Lona/Bath_washing_IfWounds1")
				SndLib.waterBath
				eval(tmpEval)
				2.times{load_script("Data/Batch/Command_Bath.rb")}
				$game_player.actor.mood -= (total_wounds*0.5).round
			elsif total_wounds !=0 && $game_player.actor.stat["Masochist"] ==1 #有受傷 是個M
				call_msg("commonCommands:Lona/Bath_washing_IfWounds0")
				2.times{load_script("Data/Batch/Command_Bath.rb")}
				SndLib.waterBath
				eval(tmpEval)
				call_msg("commonCommands:Lona/Bath_washing_IfWounds1")
				call_msg("commonCommands:Lona/Bath_washing_IfWoundsM")
				SndLib.waterBath
				eval(tmpEval)
				2.times{load_script("Data/Batch/Command_Bath.rb")}
				$game_player.actor.sta +=2
				$game_player.actor.mood += (total_wounds*0.5).round
		end
		eval(tmpEval)
		chcg_background_color(0,0,0,255,-7)
		#$game_message.add("\\t[commonCommands:Lona/Bath_end]")
		#$game_map.interpreter.wait_for_message
		Audio.se_stop
		
if tmp_fucker_id == nil
	#if !Input.press?(:SHIFT)
		if equips_Anal_id != -1#檢查裝備 並穿裝
			$game_player.actor.change_equip("Anal", $data_ItemName[equips_Anal_id])
			SndLib.sound_equip_armor(100)
			player_force_update
			wait(30)
		end
		if equips_Vag_id != -1#檢查裝備 並穿裝
			$game_player.actor.change_equip("Vag", $data_ItemName[equips_Vag_id])
			SndLib.sound_equip_armor(100)
			player_force_update
			wait(30)
		end
		if equips_Mid_id != -1#檢查裝備 並穿裝
			$game_player.actor.change_equip("Mid", $data_ItemName[equips_Mid_id])
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
		if equips_Top_id != -1#檢查裝備 並穿裝
			$game_player.actor.change_equip("Top", $data_ItemName[equips_Top_id])
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
		if equips_Head_id != -1#檢查裝備 並穿裝
			$game_player.actor.change_equip("Head", $data_ItemName[equips_Head_id])
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

if $game_player.actor.dirt >= 60
	call_msg("commonCommands:Lona/Bath_EndDirtLvl3")
elsif $game_player.actor.dirt >= 40
	call_msg("commonCommands:Lona/Bath_EndDirtLvl2")
elsif $game_player.actor.dirt >= 20
	call_msg("commonCommands:Lona/Bath_EndDirtLvl1")
end
eventPlayEnd
