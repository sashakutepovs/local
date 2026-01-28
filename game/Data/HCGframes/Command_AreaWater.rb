if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
$game_portraits.lprt.hide



temp_vag_cums =$game_player.actor.cumsMeters["CumsCreamPie"]
temp_anal_cums =$game_player.actor.cumsMeters["CumsMoonPie"]
tmpCleanPrivates = ($game_player.actor.cumsMeters["CumsCreamPie"] + $game_player.actor.cumsMeters["CumsMoonPie"]) >=1
tmpCollectMilk = $game_player.actor.lactation_level >=300
#able_to_mas_count = $story_stats["sex_record_vaginal_count"] + $story_stats["sex_record_anal_count"] + $story_stats["sex_record_mouth_count"] + $story_stats["sex_record_handjob_count"]
tmpCanMasturbate = !$game_player.player_cuffed? && $game_player.actor.sta > 0 #&& able_to_mas_count >=1
total_wounds = $game_player.actor.get_total_wounds

tmpPicked = ""
tmpQuestList = []
tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Cancel"]				,"BasicNeedsOpt_Cancel"]
tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Bathe"]				,"BasicNeedsOpt_Bathe"]
tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_CleanPrivates"]		,"BasicNeedsOpt_CleanPrivates"] if tmpCleanPrivates
tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_CollectMilk"]		,"BasicNeedsOpt_CollectMilk"] if tmpCollectMilk
tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Masturbate"]			,"BasicNeedsOpt_Masturbate"] if tmpCanMasturbate
	cmd_sheet = tmpQuestList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
		p cmd_text
	end
	call_msg("commonCommands:Lona/BasicNeeds_begin",0,2,0)
	call_msg("\\optB[#{cmd_text}]")

	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1

$game_map.interpreter.wait_for_message

	case tmpPicked
		when "BasicNeedsOpt_Bathe";				 load_script("Data/HCGframes/Command_bath.rb")
		when "BasicNeedsOpt_Relieve";			load_script("Data/HCGframes/Command_Excretion.rb")
		when "BasicNeedsOpt_Masturbate";		load_script("Data/HCGframes/Action_CHSH_Masturbation.rb")
		when "BasicNeedsOpt_CleanPrivates";		load_script("Data/HCGframes/Command_GroinClearn.rb")
		when "BasicNeedsOpt_CollectMilk";		load_script("Data/HCGframes/Command_SelfMilking.rb")
		when "BasicNeedsOpt_BreakRestraints";	load_script("Data/HCGframes/Command_BreakBondage.rb")
	end

eventPlayEnd
