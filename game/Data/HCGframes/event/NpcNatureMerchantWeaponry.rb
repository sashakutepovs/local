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
	call_msg("commonNPC:MaleHumanRandomNpc/CommonMerchant_begin1#{npc_talk_style}")
	#tmp_Talk = $game_player.actor.wisdom_trait >= 10 && $game_player.actor.sta >0 && get_character(0).summon_data[:SexTradeble]
	#tmp_Threaten = $game_player.actor.combat_trait >= 10 && $game_player.actor.sta >0 && get_character(0).summon_data[:SexTradeble]
	tmp_Talk = false
	tmp_Threaten = false
	tmp_Prostitution = $game_player.actor.stat["Prostitute"] ==1 && get_character(0).summon_data[:SexTradeble]
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Talk"]				,"Talk"] if tmp_Talk
	tmpTarList << [$game_text["commonNPC:commonNPC/Threaten"]			,"Threaten"] if tmp_Threaten
	tmpTarList << [$game_text["commonNPC:commonNPC/Prostitution"]		,"Prostitution"] if tmp_Prostitution
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("commonNPC:MaleHumanRandomNpc/CommonHuman_CommonNpcOpt",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
				
	case tmpPicked
		when "Barter"
			manual_barters("CommonWeaponTrader")
			
		when "Talk"
			get_character(0).summon_data[:SexTradeble] = false
			call_msg("commonNPC:RandomNpc/CommonMerchant_comm")
			call_msg("commonNPC:RandomNpc/choosed")
			$game_player.actor.sta -=5
			temp_value= ($game_player.actor.wisdom)
			temp_value2=30+rand(50)
			if temp_value >= temp_value2
				$game_player.actor.mood +=10
				call_msg("commonNPC:RandomNpc/CommonMerchant_comm_win")
				$game_party.gain_gold(temp_value*2)
				SndLib.sys_Gain
				$game_map.popup(0,"",812,(temp_value*2).round)
			else
				$game_player.actor.mood -=3
				call_msg("commonNPC:RandomNpc/CommonMerchant_comm_failed")
			end

		when "Threaten"
		call_msg("commonNPC:RandomNpc/CommonMerchant_threaten#{talk_style}")
		call_msg("commonNPC:RandomNpc/choosed")
		$game_player.actor.sta -=5
			temp_value= ($game_player.actor.combat - $game_player.actor.weak)
			temp_value2=30+rand(100)
			if temp_value >= temp_value2
				$game_player.actor.mood +=10
				call_msg("commonNPC:RandomNpc/CommonMerchant_threaten_win")
				$game_party.gain_gold(temp_value*30)
				SndLib.sys_Gain
				$game_map.popup(0,"",812,(temp_value*30).round)
			else
				$game_player.actor.mood -=3 
				call_msg("commonNPC:RandomNpc/CommonMerchant_threaten_failed")
				$game_player.actor.add_state("MoralityDown30")
			end

		when "Prostitution"
			get_character(0).summon_data[:SexTradeble] = false
			get_character(0).summon_data[:SexTradeble] = false
			$game_temp.choice == 0
			call_msg("commonNPC:RandomNpc/WhoreWork#{talk_style}")
			call_msg("commonNPC:RandomNpc/choosed")
			$game_player.actor.sta -=5
			temp_vs1=50+rand(50) #校交易難度
			call_msg("\\narr #{$game_player.actor.sexy.round} VS #{temp_vs1.round}")
			if $game_player.actor.sexy > temp_vs1
				$game_player.actor.mood +=10
				$story_stats["sex_record_whore_job"] +=1
				$game_player.actor.record_lona_title = "WhoreJob/title_hooker" if $story_stats["sex_record_whore_job"] % 10 == 0
				call_msg("commonNPC:RandomNpc/WhoreWork_win")
				prev_gold = $game_party.gold
				play_sex_service_menu(get_character(0),2)
				play_sex_service_items(get_character(0),["ItemCoin1","ItemCoin2","ItemCoin3"],prev_gold)
			else
				$game_player.actor.mood -=3
				call_msg("commonNPC:RandomNpc/WhoreWork_failed")
			end
end

eventPlayEnd
