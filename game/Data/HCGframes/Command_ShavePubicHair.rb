
#todo item test

didThing = false
tmp_fucker_id = nil
tmpHairAmt = 0
tmpPicked = "Cancel"
call_msg("commonCommands:Lona/ShavePubicHair_0#{talk_persona}")
		
		
tmpGotoTar = ""
tmpTarList = []
tmpTarList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Cancel"]				,"Cancel"		,0]
tmpTarList << [$game_text["commonCommands:Lona/BasicNeedsOpt_All"]					,"All"			,0] if $game_player.actor.stat["PubicHairVag"] + $game_player.actor.stat["PubicHairAnal"] >= 3
tmpTarList << [$game_text["DataState:PubicHairVag/item_name"]+"-1"				,"ShaveVag_1"	,1] if $game_player.actor.stat["PubicHairVag"] >= 2
tmpTarList << [$game_text["DataState:PubicHairVag/item_name"]+"-2"				,"ShaveVag_2"	,2] if $game_player.actor.stat["PubicHairVag"] >= 3
tmpTarList << [$game_text["DataState:PubicHairVag/item_name"]+"-3"				,"ShaveVag_3"	,3] if $game_player.actor.stat["PubicHairVag"] >= 4
tmpTarList << [$game_text["DataState:PubicHairAnal/item_name"]+"-1"				,"ShaveAnal_1"	,1] if $game_player.actor.stat["PubicHairAnal"] >= 2
tmpTarList << [$game_text["DataState:PubicHairAnal/item_name"]+"-2"				,"ShaveAnal_2"	,2] if $game_player.actor.stat["PubicHairAnal"] >= 3
tmpTarList << [$game_text["DataState:PubicHairAnal/item_name"]+"-3"				,"ShaveAnal_3"	,3] if $game_player.actor.stat["PubicHairAnal"] >= 4
cmd_sheet = tmpTarList
cmd_text =""
for i in 0...cmd_sheet.length
	cmd_text.concat(cmd_sheet[i].first+",")
end
call_msg("commonCommands:Lona/ShavePubicHair_1",0,2,0)
call_msg("\\optB[#{cmd_text}]")
$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
$game_temp.choice == -1 ? tmpPickedLV = 0 : tmpPickedLV = cmd_sheet[$game_temp.choice][2]
tmpPicked = "Cancel" if [0,-1].include?($game_temp.choice)


!equip_slot_removetable?(4) ? equips_4_id = -1 : equips_4_id = $game_player.actor.equips[4].id #BOT
if equips_4_id != -1 && ![0,-1].include?($game_temp.choice) #檢查裝備 並脫裝
	$game_player.actor.change_equip(4, nil)
	SndLib.sound_equip_armor(100)
	$game_portraits.rprt.set_position(400,0)
	player_force_update
	wait(45)
end
$game_temp.choice = -1



# to do add shave sound effect
case tmpPicked
	when "Cancel"
	when "All"
		($game_player.actor.stat["PubicHairVag"]-1).times{
			lona_mood "chcg4fuck_shame_low"
			$game_player.actor.portrait.update
			$game_portraits.rprt.set_position(-45+rand(6),-120+rand(6))
			load_script("Data/batch/chcg_basic_frame_vag.rb")
			SndLib.sys_PaperTear(80,60)
			tmpHairAmt+=1
			wait(30)
			$game_player.actor.remove_state_stack("PubicHairVag")
			player_force_update
			wait(15)
		}
		($game_player.actor.stat["PubicHairAnal"]-1).times{
			lona_mood "chcg2fuck_shame_low"
			$game_player.actor.portrait.update
			$game_portraits.rprt.set_position(-145+rand(6),-45+rand(6))
			load_script("Data/batch/chcg_basic_frame_anal.rb")
			SndLib.sys_PaperTear(80,60)
			tmpHairAmt+=1
			wait(30)
			$game_player.actor.remove_state_stack("PubicHairAnal")
			player_force_update
			wait(15)
		}
		$game_player.actor.pubicHair_Vag_GrowCount = 0
		$game_player.actor.pubicHair_Anal_GrowCount = 0
		didThing = true
	when "ShaveVag_1","ShaveVag_2","ShaveVag_3","ShaveVag_4"
		tmpPickedLV.times{
			lona_mood "chcg4fuck_shame_low"
			$game_player.actor.portrait.update
			$game_portraits.rprt.set_position(-45+rand(6),-120+rand(6))
			load_script("Data/batch/chcg_basic_frame_vag.rb")
			SndLib.sys_PaperTear(80,60)
			tmpHairAmt+=1
			wait(30)
			$game_player.actor.remove_state_stack("PubicHairVag")
			player_force_update
			wait(15)
		}
		didThing = true
		$game_player.actor.pubicHair_Vag_GrowCount = 0
	when "ShaveAnal_1","ShaveAnal_2","ShaveAnal_3","ShaveAnal_4"
		tmpPickedLV.times{
			lona_mood "chcg2fuck_shame_low"
			$game_player.actor.portrait.update
			$game_portraits.rprt.set_position(-145+rand(6),-45+rand(6))
			load_script("Data/batch/chcg_basic_frame_anal.rb")
			SndLib.sys_PaperTear(80,60)
			tmpHairAmt+=1
			wait(30)
			$game_player.actor.remove_state_stack("PubicHairAnal")
			player_force_update
			wait(15)
		}
		$game_player.actor.pubicHair_Anal_GrowCount = 0
		didThing = true
end

if didThing
	player_force_update
	check_over_event
	lona_mood "pain" ; $game_portraits.rprt.shake
	$game_player.call_balloon(8)
	$game_portraits.rprt.set_position(400,20)
	optain_item($data_ItemName["ItemPubicHair"],tmpHairAmt) if tmpHairAmt >= 1 # add after Pubic hair got some use
	wait(60)
else
	call_msg("commonNPC:prostituation/Repent_dialog")
	return eventPlayEnd
end


if didThing #若LONA決定剃毛
	
	#若周圍有NPC?
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
end

		
if tmp_fucker_id == nil #沒有FUCKER  川裝
	if equips_4_id != -1#檢查裝備 並穿裝
		call_msg("commonCommands:Lona/Excretion_begin2")
		$game_player.actor.change_equip(4, $data_armors[equips_4_id])
		SndLib.sound_equip_armor(100)
		lona_mood "shy" ; $game_portraits.rprt.shake
		$game_player.actor.stat["subpose"] = 2
		$game_portraits.rprt.set_position(400,20)
		player_force_update
		wait(30)
		call_msg("commonCommands:Lona/ShavePubicHair_2#{talk_persona}")
	end
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



eventPlayEnd
