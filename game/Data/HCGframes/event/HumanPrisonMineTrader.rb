if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT1"] = "1" if $game_player.actor.stat["Prostitute"] ==1 && get_character(0).switch1_id ==0
#make store [算了,交易,賣身<r=HiddenOPT1>] #todo fix options,   add break chain when captured and slave mode

	p "Captured_PrisonMiningNeed = > #{$story_stats["Captured_PrisonMiningNeed"]}"
	p "Captured_PrisonMiningPoint = > #{$story_stats["Captured_PrisonMiningPoint"]}"
	
call_msg("TagMapHumanPrisonCave:HumanPrisonCave/CaveTrader_begin")
if $story_stats["Captured"] != 1
	portrait_hide
	$game_temp.choice = -1
	cam_center(0)
	return
end
call_msg("\\narr #{$game_text["TagMapHumanPrisonCave:HumanPrisonCave/CaveTrader_mineneed0"]}#{$story_stats["Captured_PrisonMiningNeed"]}#{$game_text["TagMapHumanPrisonCave:HumanPrisonCave/CaveTrader_mineneed1"]}")
call_msg("TagMapHumanPrisonCave:HumanPrisonCave/CaveTrader_Opt")

if $game_temp.choice == 1 
	manual_barters("HumanPrisonMineQuartermaster")
end

if $game_temp.choice == 2 
	call_msg("TagMapHumanPrisonCave:HumanPrisonCave/CaveTrader_Talk1")
end

if $game_temp.choice == 3 
	call_msg("TagMapHumanPrisonCave:HumanPrisonCave/CaveTrader_GiveMineral_begin")
	temp_point = $story_stats["Captured_PrisonMiningPoint"]
	
	$story_stats["Captured_PrisonMiningPoint"] += $game_party.item_number($data_items[53])
	
	
	$game_party.lose_item($data_items[53],$game_party.item_number($data_items[53]))
	
	
	if temp_point == $story_stats["Captured_PrisonMiningPoint"]
		#沒有礦
		call_msg("TagMapHumanPrisonCave:HumanPrisonCave/CaveTrader_GiveMineral_end_None")
		temp_atk_mc =1
	elsif $story_stats["Captured_PrisonMiningNeed"] > $story_stats["Captured_PrisonMiningPoint"]
		#有礦 但不夠
		call_msg("TagMapHumanPrisonCave:HumanPrisonCave/CaveTrader_GiveMineral_end_OkayButMore")
	elsif $story_stats["Captured_PrisonMiningPoint"] > $story_stats["Captured_PrisonMiningNeed"]
		#點數夠 或過量
		call_msg("TagMapHumanPrisonCave:HumanPrisonCave/CaveTrader_GiveMineral_end_Full")
		temp_over_get = 100*($story_stats["Captured_PrisonMiningPoint"] - $story_stats["Captured_PrisonMiningNeed"])
		$story_stats["Captured_PrisonMiningPoint"] = $story_stats["Captured_PrisonMiningNeed"]
		$game_party.gain_gold(temp_over_get)
		SndLib.sys_Gain
		$game_map.popup(0,"#{-temp_over_get}",812,-1)
		
	end
	
	

	#檢測晶礦總量
	#p $game_party.item_number($data_items[53])
	#p $game_party.has_item?($data_items[53])
	#$game_party.lose_item($data_items[55],3)
	
end

if $game_temp.choice == 4 && get_character(0).switch1_id==0
	get_character(0).switch1_id =1
	call_msg("TagMapHumanPrisonCave:HumanPrisonCave/CaveTrader_AnsSexService")
end


call_msg("TagMapHumanPrisonCave:HumanPrisonCave/CaveTrader_end") if temp_atk_mc !=1

if temp_atk_mc ==1
	get_character(0).animation = get_character(0).animation_atk_mh
	case rand(3)
		when 0;get_character(0).call_balloon(15)
		when 1;get_character(0).call_balloon(7)
		when 2;get_character(0).call_balloon(5)
	end
	combat_Hevent_Grab_Punch("Human",10)
	SndLib.sound_punch_hit(100)
	wait(30)
	whole_event_end
end


eventPlayEnd
$story_stats["HiddenOPT1"] = "0" 
portrait_hide
$game_temp.choice = -1
