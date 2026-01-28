
module GIM_CHCG

	def basicNeed_gen_possible_data
		$story_stats["BasicNeed_TempData"] = Hash.new(false)
		$story_stats["BasicNeed_TempData"]["temp_vag_cums"] = $game_player.actor.cumsMeters["CumsCreamPie"]
		$story_stats["BasicNeed_TempData"]["temp_anal_cums"] = $game_player.actor.cumsMeters["CumsMoonPie"]
		$story_stats["BasicNeed_TempData"]["tmpCleanPrivates"] = ($game_player.actor.cumsMeters["CumsCreamPie"] + $game_player.actor.cumsMeters["CumsMoonPie"]) >=1
		$story_stats["BasicNeed_TempData"]["tmpCollectMilk"] = $game_player.actor.lactation_level >=300

		$story_stats["BasicNeed_TempData"]["tmpCanMasturbate"] = !$game_player.player_cuffed? && $game_player.actor.sta > 0 #&& able_to_mas_count >=1
		$story_stats["BasicNeed_TempData"]["total_wounds"] = $game_player.actor.get_total_wounds
		$story_stats["BasicNeed_TempData"]["tmpCanPoo"] = $game_player.actor.defecate_level >=300
		$story_stats["BasicNeed_TempData"]["tmpCanPee"] = $game_player.actor.urinary_level >=300
		$story_stats["BasicNeed_TempData"]["tmpCanPeePoo"] = $story_stats["BasicNeed_TempData"]["tmpCanPoo"] || $story_stats["BasicNeed_TempData"]["tmpCanPee"]

		$story_stats["BasicNeed_TempData"]["tmpCanPeeWithCocona"] = $story_stats["RecQuestCoconaVagTaken"] >= 3 && $story_stats["BasicNeed_TempData"]["tmpCanPee"] && get_coconaEV && follower_in_range?(0,5)

		$story_stats["BasicNeed_TempData"]["tmpBondageCuff"] = ["CuffTopExtra","ChainCuffTopExtra"].include?($game_player.actor.stat["MainArm"])
		$story_stats["BasicNeed_TempData"]["tmpBondageCollar"] = ["CollarTopExtra","ChainCollarTopExtra"].include?($game_player.actor.stat["equip_TopExtra"])
		$story_stats["BasicNeed_TempData"]["tmpBondageShackles"] = ["ChainMidExtra"].include?($game_player.actor.stat["equip_MidExtra"])
		$story_stats["BasicNeed_TempData"]["tmpCanBreakCuff"] = $story_stats["BasicNeed_TempData"]["tmpBondageCuff"] || $story_stats["BasicNeed_TempData"]["tmpBondageCollar"] || $story_stats["BasicNeed_TempData"]["tmpBondageShackles"]
		$story_stats["BasicNeed_TempData"]["tmpCanCollectWaste"] = (($game_player.actor.survival_trait + $game_player.actor.scoutcraft_trait >= 10) || $game_player.actor.stat["Mod_Taste"] == 1 || $game_player.actor.stat["Omnivore"] == 1) && $story_stats["BasicNeed_TempData"]["tmpCanPeePoo"]
		$story_stats["BasicNeed_TempData"]["tmpCanCollectSemenMouth"] = $game_player.actor.cumsMeters["CumsMouth"] >= 1 && $game_player.actor.sta > 0
		$story_stats["BasicNeed_TempData"]["tmpCanShavePubicHair"] = $game_player.actor.sta > 0 && !$story_stats["BasicNeed_TempData"]["tmpBondageCuff"] && ($game_player.actor.stat["PubicHairAnal"] >= 2 || $game_player.actor.stat["PubicHairVag"] >= 2)
		$story_stats["BasicNeed_TempData"]["tmpCanObserve"] = $game_player.actor.sta >= 1
	end
	def basicNeed_create_tmpQuestList
		basicNeed_gen_possible_data
		tmpQuestList = []
		tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Cancel"]			,"BasicNeedsOpt_Cancel"]
		tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Bathe"]			,"BasicNeedsOpt_Bathe"]				if $game_player.on_water_floor?
		tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Relieve"]		,"BasicNeedsOpt_Relieve"]			if $story_stats["BasicNeed_TempData"]["tmpCanPeePoo"]
		tmpQuestList << [$game_text["CompCocona:Lona/BasicNeedsOpt_PeeWithCocona"]		,"BasicNeedsOpt_PeeWithCocona"]		if $story_stats["BasicNeed_TempData"]["tmpCanPeeWithCocona"]
		tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Masturbate"]		,"BasicNeedsOpt_Masturbate"]		if $story_stats["BasicNeed_TempData"]["tmpCanMasturbate"]
		tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_ShavePubicHair"]	,"BasicNeedsOpt_ShavePubicHair"]	if $story_stats["BasicNeed_TempData"]["tmpCanShavePubicHair"]
		tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_CleanPrivates"]	,"BasicNeedsOpt_CleanPrivates"]		if $story_stats["BasicNeed_TempData"]["tmpCleanPrivates"]
		tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_CollectMilk"]	,"BasicNeedsOpt_CollectMilk"]		if $story_stats["BasicNeed_TempData"]["tmpCollectMilk"]
		tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_CollectWaste"]	,"BasicNeedsOpt_CollectWaste"]		if $story_stats["BasicNeed_TempData"]["tmpCanCollectWaste"]
		tmpQuestList << [$game_text["DataState:CumsMouth/item_name"]					,"BasicNeedsOpt_Swallow"]			if $story_stats["BasicNeed_TempData"]["tmpCanCollectSemenMouth"]
		tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_BreakRestraints"],"BasicNeedsOpt_BreakRestraints"]	if $story_stats["BasicNeed_TempData"]["tmpCanBreakCuff"]
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Observe"]				,"BasicNeedsOpt_Observe"]			if $story_stats["BasicNeed_TempData"]["tmpCanObserve"]
		return tmpQuestList
	end

	def basicNeed_work_with_tmpPicked(tmpPicked)

		case tmpPicked
			when "BasicNeedsOpt_Bathe";				action_blocked = true if !$game_player.on_water_floor?
				load_script("Data/HCGframes/Command_bath.rb") if !action_blocked
			when "BasicNeedsOpt_Relieve";			action_blocked = true if !$story_stats["BasicNeed_TempData"]["tmpCanPeePoo"]
				load_script("Data/HCGframes/Command_Excretion.rb") if !action_blocked
			when "BasicNeedsOpt_PeeWithCocona";		action_blocked = true if !$story_stats["BasicNeed_TempData"]["tmpCanPeeWithCocona"]
				load_script("Data/HCGframes/UniqueEvent_PeeWithCocona.rb") if !action_blocked
			when "BasicNeedsOpt_Masturbate";		action_blocked = true if !$story_stats["BasicNeed_TempData"]["tmpCanMasturbate"]
				load_script("Data/HCGframes/Action_CHSH_Masturbation.rb") if !action_blocked
			when "BasicNeedsOpt_CleanPrivates";		action_blocked = true if !$story_stats["BasicNeed_TempData"]["tmpCleanPrivates"]
				load_script("Data/HCGframes/Command_GroinClearn.rb") if !action_blocked
			when "BasicNeedsOpt_CollectMilk";		action_blocked = true if !$story_stats["BasicNeed_TempData"]["tmpCollectMilk"]
				load_script("Data/HCGframes/Command_SelfMilking.rb") if !action_blocked
			when "BasicNeedsOpt_CollectWaste";		action_blocked = true if !$story_stats["BasicNeed_TempData"]["tmpCanCollectWaste"]
				load_script("Data/HCGframes/Command_Collect_Excretion.rb") if !action_blocked
			when "BasicNeedsOpt_BreakRestraints";	action_blocked = true if !$story_stats["BasicNeed_TempData"]["tmpCanBreakCuff"]
				load_script("Data/HCGframes/Command_BreakBondage.rb") if !action_blocked
			when "BasicNeedsOpt_Swallow";			action_blocked = true if !$story_stats["BasicNeed_TempData"]["tmpCanCollectSemenMouth"]
				load_script("Data/HCGframes/Command_CumsSwallow.rb") if !action_blocked
			when "BasicNeedsOpt_ShavePubicHair";	action_blocked = true if !$story_stats["BasicNeed_TempData"]["tmpCanShavePubicHair"]
				load_script("Data/HCGframes/Command_ShavePubicHair.rb") if !action_blocked
			when "BasicNeedsOpt_Observe";			action_blocked = true if !$story_stats["BasicNeed_TempData"]["tmpCanObserve"]
				tmpSuccess = false
				tgtEV = []
				tmpX = $game_map.round_x_with_direction($game_player.x, $game_player.direction)
				tmpY = $game_map.round_y_with_direction($game_player.y, $game_player.direction)
				$game_map.npcs.each{|npc_ev|
					next unless npc_ev.pos?(tmpX,tmpY)
					next if npc_ev.opacity == 0
					next if npc_ev.npc.immune_damage && npc_ev.npc.is_object && npc_ev.npc.is_a?(Game_DestroyableObject)
					tmpSuccess = true
					tgtEV << npc_ev
				}
				if !tgtEV.empty?
					$game_player.actor.sta -= 1
					$game_player.call_balloon(8)
					wait(60)
					tgtEV.each{|ev|
						show_npc_info(ev,extra_info=true,"..........")
					}
				else
					$game_player.call_balloon(8)
					wait(60)
					SndLib.sound_QuickDialog
					$game_map.popup(0,"QuickMsg:Lona/SexNoTarget0",0,0)
				end
		end
	end
end
