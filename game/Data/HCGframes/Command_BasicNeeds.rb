if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
#$game_portraits.lprt.hide
#	temp_vag_cums =$game_player.actor.cumsMeters["CumsCreamPie"]
#	temp_anal_cums =$game_player.actor.cumsMeters["CumsMoonPie"]
#	tmpCleanPrivates = ($game_player.actor.cumsMeters["CumsCreamPie"] + $game_player.actor.cumsMeters["CumsMoonPie"]) >=1
#	tmpCollectMilk = $game_player.actor.lactation_level >=300
#
#	tmpCanMasturbate = !$game_player.player_cuffed? && $game_player.actor.sta > 0 #&& able_to_mas_count >=1
#	total_wounds = $game_player.actor.get_total_wounds
#	tmpCanPoo = $game_player.actor.defecate_level >=300
#	tmpCanPee = $game_player.actor.urinary_level >=300
#	tmpCanPeePoo = tmpCanPee || tmpCanPoo
#
#	tmpCanPeeWithCocona = $story_stats["RecQuestCoconaVagTaken"] >= 3 && tmpCanPee && get_coconaEV && follower_in_range?(0,5)
#
#	tmpBondageCuff = ["CuffTopExtra","ChainCuffTopExtra"].include?($game_player.actor.stat["MainArm"])
#	tmpBondageCollar = ["CollarTopExtra","ChainCollarTopExtra"].include?($game_player.actor.stat["equip_TopExtra"])
#	tmpBondageShackles = ["ChainMidExtra"].include?($game_player.actor.stat["equip_MidExtra"])
#	tmpCanBreakCuff = tmpBondageCuff || tmpBondageCollar || tmpBondageShackles
#	tmpCanCollectWaste = ($game_player.actor.survival_trait + $game_player.actor.scoutcraft_trait >= 10) || $game_player.actor.stat["Mod_Taste"] == 1 || $game_player.actor.stat["Omnivore"] == 1
#	tmpCanCollectSemenMouth = $game_player.actor.cumsMeters["CumsMouth"] >= 1 && $game_player.actor.sta > 0
#	tmpCanShavePubicHair = $game_player.actor.sta > 0 && !tmpBondageCuff && ($game_player.actor.stat["PubicHairAnal"] >= 2 || $game_player.actor.stat["PubicHairVag"] >= 2)
#	tmpCanObserve = $game_player.actor.sta >= 1
#	tmpPicked = ""
#	tmpQuestList = []
#	tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Cancel"]			,"BasicNeedsOpt_Cancel"]
#	tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Bathe"]			,"BasicNeedsOpt_Bathe"]				if $game_player.on_water_floor?
#	tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Relieve"]		,"BasicNeedsOpt_Relieve"]			if tmpCanPeePoo
#	tmpQuestList << [$game_text["CompCocona:Lona/BasicNeedsOpt_PeeWithCocona"]		,"BasicNeedsOpt_PeeWithCocona"]		if tmpCanPeeWithCocona
#	tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Masturbate"]		,"BasicNeedsOpt_Masturbate"]		if tmpCanMasturbate
#	tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_ShavePubicHair"]	,"BasicNeedsOpt_ShavePubicHair"]	if tmpCanShavePubicHair
#	tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_CleanPrivates"]	,"BasicNeedsOpt_CleanPrivates"]		if tmpCleanPrivates
#	tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_CollectMilk"]	,"BasicNeedsOpt_CollectMilk"]		if tmpCollectMilk
#	tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_CollectWaste"]	,"BasicNeedsOpt_CollectWaste"]		if tmpCanCollectWaste && tmpCanPeePoo
#	tmpQuestList << [$game_text["DataState:CumsMouth/item_name"]					,"BasicNeedsOpt_Swallow"]			if tmpCanCollectSemenMouth
#	tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_BreakRestraints"],"BasicNeedsOpt_BreakRestraints"]	if tmpCanBreakCuff
#	tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Observe"]				,"BasicNeedsOpt_Observe"]			if tmpCanObserve
#	cmd_sheet = tmpQuestList
#	cmd_text =""
#	for i in 0...cmd_sheet.length
#		cmd_text.concat(cmd_sheet[i].first+",")
#	end
#	call_msg("commonCommands:Lona/BasicNeeds_begin",0,2,0)
#	call_msg("\\optB[#{cmd_text}]")
#
#	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
#	$game_temp.choice = -1
#	action_blocked = false
#	case tmpPicked
#		when "BasicNeedsOpt_Bathe";				action_blocked = true if !$game_player.on_water_floor?
#												load_script("Data/HCGframes/Command_bath.rb") if !action_blocked
#
#		when "BasicNeedsOpt_Relieve";			action_blocked = true if !tmpCanPeePoo
#												load_script("Data/HCGframes/Command_Excretion.rb") if !action_blocked
#
#		when "BasicNeedsOpt_PeeWithCocona";		action_blocked = true if !tmpCanPeeWithCocona
#												load_script("Data/HCGframes/UniqueEvent_PeeWithCocona.rb") if !action_blocked
#
#		when "BasicNeedsOpt_Masturbate";		action_blocked = true if !tmpCanMasturbate
#												load_script("Data/HCGframes/Action_CHSH_Masturbation.rb") if !action_blocked
#
#		when "BasicNeedsOpt_CleanPrivates";		action_blocked = true if !tmpCleanPrivates
#												load_script("Data/HCGframes/Command_GroinClearn.rb") if !action_blocked
#
#		when "BasicNeedsOpt_CollectMilk";		action_blocked = true if !tmpCollectMilk
#												load_script("Data/HCGframes/Command_SelfMilking.rb") if !action_blocked
#
#		when "BasicNeedsOpt_CollectWaste";		action_blocked = true if !(tmpCanCollectWaste && tmpCanPeePoo)
#												load_script("Data/HCGframes/Command_Collect_Excretion.rb") if !action_blocked
#
#		when "BasicNeedsOpt_BreakRestraints";	action_blocked = true if !tmpCanBreakCuff
#												load_script("Data/HCGframes/Command_BreakBondage.rb") if !action_blocked
#
#		when "BasicNeedsOpt_Swallow";			action_blocked = true if !tmpCanCollectSemenMouth
#												load_script("Data/HCGframes/Command_CumsSwallow.rb") if !action_blocked
#
#		when "BasicNeedsOpt_ShavePubicHair";	action_blocked = true if !tmpCanShavePubicHair
#												load_script("Data/HCGframes/Command_ShavePubicHair.rb") if !action_blocked
#
#		when "BasicNeedsOpt_Observe";			action_blocked = true if !tmpCanObserve
#												tmpSuccess = false
#												tgtEV = []
#												tmpX = $game_map.round_x_with_direction($game_player.x, $game_player.direction)
#												tmpY = $game_map.round_y_with_direction($game_player.y, $game_player.direction)
#												$game_map.npcs.each{|npc_ev|
#													next unless npc_ev.pos?(tmpX,tmpY)
#													next if npc_ev.opacity == 0
#													next if npc_ev.npc.immune_damage && npc_ev.npc.is_object && npc_ev.npc.is_a?(Game_DestroyableObject)
#													tmpSuccess = true
#													tgtEV << npc_ev
#												}
#												if !tgtEV.empty?
#													$game_player.actor.sta -= 1
#													$game_player.call_balloon(8)
#													wait(60)
#													tgtEV.each{|ev|
#														show_npc_info(ev,extra_info=true,"..........")
#													}
#												else
#													$game_player.call_balloon(8)
#													wait(60)
#													SndLib.sound_QuickDialog
#													$game_map.popup(0,"QuickMsg:Lona/SexNoTarget0",0,0)
#												end
#	end
#if action_blocked
#	SndLib.sys_buzzer
#	$game_map.popup(0,"CompElise:tar/Failed_enter",0,0)
#end
#
#eventPlayEnd

##################################################
######    load_script_empty("Command_BasicNeeds_Mod") # Load empty script without patch. Used only for  $mod_load_script and using alias_method inside script for def above.
##################################################
$game_portraits.lprt.hide
tmpPicked = ""

cmd_sheet = basicNeed_create_tmpQuestList

cmd_text =""
for i in 0...cmd_sheet.length
	cmd_text.concat(cmd_sheet[i].first+",")
end
call_msg("commonCommands:Lona/BasicNeeds_begin",0,2,0)
call_msg("\\optB[#{cmd_text}]")

$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
$game_temp.choice = -1
action_blocked = false


basicNeed_work_with_tmpPicked(tmpPicked)

if action_blocked
	SndLib.sys_buzzer
	$game_map.popup(0,"CompElise:tar/Failed_enter",0,0)
end

eventPlayEnd
