p "Playing HCGframe : NeutralHumanPrisonMinerHairTriggerM.rb"
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
if !$game_party.has_item?($data_items[53])
$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT1"] = "1" if $game_player.actor.stat["Prostitute"] ==1 && get_character(0).summon_data[:SexTradeble]
	call_msg("TagMapHumanPrisonCave:HumanPrisonCave/MinerHairTriggerM_begin_basic")
	call_msg("TagMapHumanPrisonCave:HumanPrisonCave/MinerHairTriggerM_Opt_basic")
	


	if $game_temp.choice == 1 && get_character(0).summon_data[:SexTradeble]
		get_character(0).summon_data[:SexTradeble] = false
		$game_temp.choice == 0
		call_msg("commonNPC:RandomNpc/WhoreWork#{talk_style}")
		call_msg("commonNPC:RandomNpc/choosed")
		$game_player.actor.sta -=1 #WhoreWorkCost
		temp_vs1=5+rand(10) #性交易難度
		if $game_actors[1].sexy > temp_vs1
			$game_actors[1].mood +=10
			call_msg("commonNPC:RandomNpc/WhoreWork_win")
			play_sex_service_menu(get_character(0),0.5)
		else
			$game_actors[1].mood -=3
			call_msg("commonNPC:RandomNpc/WhoreWork_failed")
		end
	end

elsif $game_party.has_item?($data_items[53])
	call_msg("TagMapHumanPrisonCave:HumanPrisonCave/MinerHairTriggerM_begin_aggro")
	call_msg("TagMapHumanPrisonCave:HumanPrisonCave/MinerHairTriggerM_Opt_aggro")
	#\optD[給他<t=5>,不要！]
	
	
	if $game_temp.choice == 0
		call_msg("TagMapHumanPrisonCave:HumanPrisonCave/MinerHairTriggerM_Opt_aggro_yes")
		SndLib.sys_Gain
		$game_map.popup(0,"",343, $game_party.item_number($data_items[53]))
		$game_party.lose_item($data_items[53],$game_party.item_number($data_items[53]))
	end
	
	
	if $game_temp.choice == 1
		get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],600)
		call_msg("TagMapHumanPrisonCave:HumanPrisonCave/MinerHairTriggerM_Opt_aggro_no")
	end
	
	
end
$story_stats["HiddenOPT1"] = "0" 
$game_temp.choice = -1
