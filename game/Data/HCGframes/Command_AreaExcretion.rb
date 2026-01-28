if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).set_summon_data({}) if !get_character(0).summon_data
get_character(0).summon_data[:DiggedWastePoo] = false if !get_character(0).summon_data[:DiggedWastePoo]
get_character(0).summon_data[:DiggedWastePee] = false if !get_character(0).summon_data[:DiggedWastePee]

$game_portraits.lprt.hide
	temp_vag_cums =$game_player.actor.cumsMeters["CumsCreamPie"]
	temp_anal_cums =$game_player.actor.cumsMeters["CumsMoonPie"]
	tmpCleanPrivates = ($game_player.actor.cumsMeters["CumsCreamPie"] + $game_player.actor.cumsMeters["CumsMoonPie"]) >= 1
	tmpCollectMilk = $game_player.actor.lactation_level >= 300
	tmpCanMasturbate = !$game_player.player_cuffed? && $game_player.actor.sta > 0 #&& able_to_mas_count >=1
	total_wounds = $game_player.actor.get_total_wounds
	tmp_NoerPrison_toilet = get_character(0).summon_data[:Opt_NoerPrison_toilet]
	tmp_DoomFortress_toilet = get_character(0).summon_data[:Opt_DoomFortress_toilet] == 1 && $game_date.night? && $story_stats["Captured"] == 1
	tmpCanPeePoo = $game_player.actor.urinary_level >=300 || $game_player.actor.defecate_level >=300
	$game_player.actor.equips[5].nil? ? tmpChainID = -1 : tmpChainID = $game_player.actor.equips[5].id
	$game_player.actor.equips[0].nil? ? tmpCuffID = -1 : tmpCuffID = $game_player.actor.equips[0].id
	tmpCanBreakCuff = ($game_player.player_cuffed? || $game_player.player_chained?) && $story_stats["Setup_Hardcore"] >= 0
	tmpCanCollectWaste = ($game_player.actor.survival_trait + $game_player.actor.scoutcraft_trait >= 10) || $game_player.actor.stat["Mod_Taste"] == 1 || $game_player.actor.stat["Omnivore"] == 1
	tmpCanDigPoo = !get_character(0).summon_data[:DiggedWastePoo] && tmpCanCollectWaste && $story_stats["Setup_ScatEffect"] !=0
	tmpCanDigPee = !get_character(0).summon_data[:DiggedWastePee] && tmpCanCollectWaste && $story_stats["Setup_UrineEffect"] !=0
	tmpCanDigPeePoo = (tmpCanDigPee || tmpCanDigPoo) && !tmp_NoerPrison_toilet && !tmp_DoomFortress_toilet
	
	tmpPicked = ""
	tmpQuestList = []
	tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Cancel"]					,"BasicNeedsOpt_Cancel"]
	tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Relieve"]				,"BasicNeedsOpt_Relieve"] if tmpCanPeePoo
	tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_CleanPrivates"]			,"BasicNeedsOpt_CleanPrivates"] if tmpCleanPrivates
	tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_CollectMilk"]			,"BasicNeedsOpt_CollectMilk"] if tmpCollectMilk
	tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_CollectWaste"]			,"BasicNeedsOpt_CollectWaste"] if tmpCanCollectWaste && tmpCanPeePoo
	tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Masturbate"]				,"BasicNeedsOpt_Masturbate"] if tmpCanMasturbate
	tmpQuestList << [$game_text["TagMapNoerPrison:that_toilet/Opt_NoerPrison_toilet"]		,"Opt_NoerPrison_toilet"] if tmp_NoerPrison_toilet
	tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_DigPeePoo"]				,"Opt_DoomFortress_toilet"] if tmp_DoomFortress_toilet
	tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_DigPeePoo"]				,"BasicNeedsOpt_DigPeePoo"] if tmpCanDigPeePoo
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
	
	
	case tmpPicked
		when "BasicNeedsOpt_Bathe";				load_script("Data/HCGframes/Command_bath.rb")
		when "BasicNeedsOpt_Relieve";			load_script("Data/HCGframes/Command_Excretion.rb")
		when "BasicNeedsOpt_Masturbate";		load_script("Data/HCGframes/Action_CHSH_Masturbation.rb")
		when "BasicNeedsOpt_CleanPrivates";		load_script("Data/HCGframes/Command_GroinClearn.rb")
		when "BasicNeedsOpt_CollectMilk";		load_script("Data/HCGframes/Command_SelfMilking.rb")
		when "BasicNeedsOpt_CollectWaste";		load_script("Data/HCGframes/Command_Collect_Excretion.rb")
		when "BasicNeedsOpt_BreakRestraints";	load_script("Data/HCGframes/Command_BreakBondage.rb")
		when "Opt_NoerPrison_toilet";			return load_script("Data/HCGframes/event/NoerPrison_RealToilet.rb")
		when "Opt_DoomFortress_toilet";			return load_script("Data/HCGframes/event/DoomFortressR_AreaExcretion.rb")
		
		when "BasicNeedsOpt_DigPeePoo";
			$game_player.call_balloon(6)
			call_msg("commonCommands:Lona/Toilet_ClearnUp")
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				$game_player.actor.sta -= 4 if tmpCanDigPoo
				$game_player.actor.sta -= 4 if tmpCanDigPee
				$game_player.actor.puke_value_normal += 50+rand(10) if !tmpCanCollectWaste
				$game_player.actor.dirt  += 100
				EvLib.sum("WastePee",$game_player.x,$game_player.y)
				EvLib.sum("WastePoo1",$game_player.x,$game_player.y)
				SndLib.sys_MeatGain(80+rand(10),50+rand(40))
				wait(60)
				SndLib.sys_MeatGain(80+rand(10),50+rand(40))
				wait(60)
				SndLib.sys_MeatGain(80+rand(10),50+rand(40))
				wait(60)
			chcg_background_color(0,0,0,255,-7)
			get_character(0).summon_data[:DiggedWastePoo] = true if tmpCanDigPoo && !get_character(0).summon_data[:UnlimitedWaste]
			get_character(0).summon_data[:DiggedWastePee] = true if tmpCanDigPee && !get_character(0).summon_data[:UnlimitedWaste]
			get_character(0).opacity = 0 if get_character(0).summon_data[:DiggedWastePoo] && get_character(0).summon_data[:DiggedWastePee]
			$game_player.call_balloon(8)
			call_msg("commonCommands:Lona/Bath_Undress1")
			optain_item("WastePoo0",1) if tmpCanDigPoo #40
			wait(30) if tmpCanDigPee
			optain_item("ItemBottledPee",1) if tmpCanDigPee #58
	end

eventPlayEnd
