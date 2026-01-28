if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end

$game_player.actor.stat["AllowOgrasm"] = true if $game_player.actor.stat["AsVulva_MilkGland"] ==1 || $game_player.actor.stat["AsVulva_Skin"] ==1
$game_player.actor.stat["EventTargetPart"] = "Milking"
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} Command_SelfMilking"
portrait_hide

tmp_fucker_id = nil
$game_map.npcs.each do |event| 
	next if event.summon_data == nil
	next if event.summon_data[:NapFucker] == nil
	next if !event.summon_data[:NapFucker]
	next if event.actor.action_state != nil && event.actor.action_state !=:none
	next if !event.near_the_target?($game_player,5)
	next if !event.actor.target.nil?
	next if event.opacity != 255
	next if event.actor.sensors[0].get_signal(event,$game_player)[2] <=15 #[target,distance,signal_strength,sensortype]
	event.summon_data[:NapFucker] = false
	tmp_fucker_id = event.id
end

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
	$game_player.animation = $game_player.animation_grabbed_qte
	$game_player.actor.sensitivity_breast >=5 ? lona_mood("sexhurt") : lona_mood("shy")
	call_msg("commonCommands:Lona/SelfMilking_begin1")
	chcg_background_color(0,0,0,0,7)
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
	if equips_Mid_id != -1#檢查裝備 並脫裝
		$game_player.actor.change_equip("Mid", nil)
		SndLib.sound_equip_armor(100)
		player_force_update
		wait(30)
	end

########################################################################################################################################


extraMilkItem = ($game_player.actor.lactation_level/300).to_i


if extraMilkItem >= 2
	tmpPicked = ""
	tmpQuestList = []
	chkTimes = 1
	extraMilkItem.times{
		tmpQuestList << ["#{300*chkTimes}"						,chkTimes]
		chkTimes += 1
	}
	cmd_sheet = tmpQuestList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("commonCommands:Lona/SelfMilking_HowMuch",0,2,0)
	call_msg("\\optD[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
	action_blocked = false
	extraMilkItem = tmpPicked 
end
lona_mood "fear"
call_msg("commonCommands:Lona/SelfMilking_begin2")
$cg = TempCG.new(["event_SelfMilking"])
if extraMilkItem >= 1
	##### each rb decrease 100.  run 3 times
	$game_player.actor.lactation_level -= extraMilkItem*300
	extraMilkCount = extraMilkItem
	while extraMilkCount > 0 do
		lona_mood ["sad","tired","shy","fear"].sample
		$game_player.actor.stat["subpose"] = 3
		$game_player.actor.stat["MilkSplash"] =0
		$game_player.actor.portrait.update
		#load_script("Data/Batch/Command_SelfMilking.rb")
		call_msg("commonCommands:Lona/SelfMilking_begin3")
		####################################################################
		
		lona_mood ["sad","tired","shy","fear"].sample
		$game_player.actor.stat["subpose"] = 3
		$game_player.actor.stat["MilkSplash"] =1
		$game_player.actor.portrait.update
		load_script("Data/Batch/Command_SelfMilking.rb")
		call_msg("commonCommands:Lona/SelfMilking_begin4")
		check_over_event
		
		####################################################################
		lona_mood ["sad","tired","shy","fear"].sample
		$game_player.actor.stat["subpose"] = 3
		$game_player.actor.stat["MilkSplash"] =0
		$game_player.actor.portrait.update
		load_script("Data/Batch/Command_SelfMilking.rb")
		call_msg("commonCommands:Lona/SelfMilking_begin5")
		check_over_event
		####################################################################
		
		lona_mood ["sad","tired","shy","fear"].sample
		$game_player.actor.stat["subpose"] = 3
		$game_player.actor.stat["MilkSplash"] =1
		$game_player.actor.portrait.update
		load_script("Data/Batch/Command_SelfMilking.rb")
		call_msg("commonCommands:Lona/SelfMilking_begin3")
		check_over_event
		####################################################################
		extraMilkCount -= 1
	end
	##### end noob mod attempt
	$game_player.actor.stat["EventTargetPart"] = nil
	$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false

	####################################################################
	$cg.erase
	$game_player.animation = nil
	chcg_background_color(0,0,0,255,-7)
	check_over_event
	lona_mood "shy"
	$game_player.actor.stat["MilkSplash"] =0
	$game_player.actor.stat["subpose"] = 3
	$game_player.actor.portrait.update
	call_msg("commonCommands:Lona/SelfMilking_end1")
	$game_player.actor.stat["MilkSplash"] =0
	$game_player.actor.portrait.update
end #if extraMilkItem >= 1
	
if tmp_fucker_id == nil
	#if !Input.press?(:SHIFT)
		if equips_Mid_id != -1#檢查裝備 並穿裝
			$game_player.actor.change_equip("Mid", $data_ItemName[equips_Mid_id])
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
	
if extraMilkItem >= 1
	lona_mood "flirty"
	$game_player.actor.stat["MilkSplash"] =0
	$game_player.actor.portrait.update
	call_msg("commonCommands:Lona/SelfMilking_end2")      if $game_player.actor.stat["persona"] !="slut"
	call_msg("commonCommands:Lona/SelfMilking_end2_slut") if $game_player.actor.stat["persona"] =="slut"
	$story_stats["sex_record_MilkSplash"] += extraMilkItem #changed from 1
	optain_item("ItemMilk", extraMilkItem) #changed from 1
end

portrait_hide
