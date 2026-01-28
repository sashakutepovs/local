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
call_msg("TagMapHumanPrisonCave:HumanPrisonCave/MinerM_begin1#{npc_talk_style}")
tmp_Prostitution = $game_player.actor.stat["Prostitute"] ==1 && get_character(0).summon_data[:SexTradeble]
tmpGotoTar = ""
tmpTarList = []
tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"]
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
		manual_barters("HumanPrisonerM")
	when "Prostitution"
		get_character(0).summon_data[:SexTradeble] = false
		$game_temp.choice == 0
		call_msg("commonNPC:RandomNpc/WhoreWork#{talk_style}")
		call_msg("commonNPC:RandomNpc/choosed")
		$game_player.actor.sta -=1 #WhoreWorkCost
		temp_vs1=5+rand(10) #性交易難度
		if $game_actors[1].weak > temp_vs1
			$game_actors[1].mood +=10
			$story_stats["sex_record_whore_job"] +=1
			call_msg("commonNPC:RandomNpc/WhoreWork_win")
			play_sex_service_menu(get_character(0),0.5)
		else
			$game_actors[1].mood -=3
			call_msg("commonNPC:RandomNpc/WhoreWork_failed")
		end
end
eventPlayEnd
