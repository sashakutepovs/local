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
#make store [算了,交易,賣身<r=HiddenOPT1>]

call_msg("commonNPC:OrcRandomNpc/CommonOrc_begin1_#{rand(3)}")
	tmp_Prostitution = $game_player.actor.stat["Prostitute"] ==1 && get_character(0).summon_data[:SexTradeble]
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"]
	tmpTarList << [$game_text["commonNPC:commonNPC/SexService"]			,"Prostitution"] if tmp_Prostitution
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("commonNPC:OrcRandomNpc/CommonOrc_CommonNpcOpt",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
	
	case tmpPicked
		when "Barter"
			manual_barters("CommonOrkind")
			
	when "Prostitution"
			get_character(0).summon_data[:SexTradeble] = false
			$game_temp.choice == 0
			call_msg("commonNPC:RandomNpc/WhoreWork#{talk_style}")
			call_msg("commonNPC:RandomNpc/choosed")
			$game_player.actor.sta -=1 #WhoreWorkCost
			temp_vs1=10+rand(10) #校交易難度
			call_msg("\\narr #{$game_player.actor.weak.round} VS #{temp_vs1.round}")
		if $game_player.actor.weak > temp_vs1
			$game_player.actor.mood +=5
			$story_stats["sex_record_whore_job"] +=1
			call_msg("commonNPC:RandomNpc/WhoreWork_win")
			prev_gold = $game_party.gold
			play_sex_service_menu(get_character(0),0.6,nil,true)
			play_sex_service_items(get_character(0),["ItemHumanoidFlesh","ItemRawMeat"],prev_gold)
		else
			$game_player.actor.mood -=3
			call_msg("commonNPC:RandomNpc/WhoreWork_failed")
		end
end

eventPlayEnd
