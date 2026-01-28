if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
tmpAggro = false
tmpSetComp = false
tmpSummonFish = false
tmpGuardTopX,tmpGuardTopY,tmpGuardTopID = $game_map.get_storypoint("GuardTop")
tmpFishExplorerX,tmpFishExplorerY,tmpFishExplorerID = $game_map.get_storypoint("FishExplorer")
tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
if [0,1].include?($story_stats["RecQuestAriseVillageFish"])
	if get_character(tmpDualBiosID).summon_data[:Aggro]
		call_msg("TagMapAriseVillage:AriseVillage/0to1_Fishman0")
		call_msg("TagMapAriseVillage:AriseVillage/0to1_Fishman0_1")
		call_msg("TagMapAriseVillage:AriseVillage/0to1_Fishman0_brd")
		call_msg("common:Lona/Decide_optB") #no Yes
		if $game_temp.choice == 1
			tmpAggro = false
			tmpSetComp = true
			tmpSummonFish = false
		else
			get_character(tmpFishExplorerID).call_balloon(28,-1)
		end
	else #if bios not aggroed
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			$game_player.moveto(tmpFishExplorerX,tmpFishExplorerY+1)
			$game_player.direction = 8
			get_character(tmpFishExplorerID).moveto(tmpFishExplorerX,tmpFishExplorerY)
			get_character(tmpFishExplorerID).direction = 2
			get_character(tmpFishExplorerID).animation = nil
			get_character(tmpGuardTopID).moveto(tmpFishExplorerX+2,tmpFishExplorerY+1)
			get_character(tmpGuardTopID).direction = 4
			get_character(tmpGuardTopID).npc_story_mode(true)
		chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapAriseVillage:AriseVillage/0to1_Fishman0")
		call_msg("TagMapAriseVillage:AriseVillage/0to1_Fishman0_0")
		call_msg("TagMapAriseVillage:AriseVillage/0to1_Fishman0_1")
		call_msg("TagMapAriseVillage:AriseVillage/0to1_Fishman0_brd")
		get_character(tmpGuardTopID).move_forward_force
		wait(35)
		SndLib.sound_MaleWarriorSpot
		get_character(tmpGuardTopID).call_balloon(5)
		wait(50)
		$game_player.direction = 6
		get_character(tmpGuardTopID).npc_story_mode(false)
		$story_stats["HiddenOPT0"] = (($game_player.actor.weak < 25 && $game_player.actor.wisdom_trait >= 18) || ($game_player.actor.weak < 25 && $game_player.actor.combat_trait >= 10)) ? "1" : 0
		$story_stats["HiddenOPT1"] = $game_player.record_companion_name_back == "UniqueCecily" ? "1" : 0
		call_msg("TagMapAriseVillage:AriseVillage/0to1_Fishman1_opt") #[不是,呃...,我是傭兵<r=HiddenOPT0>,賽希莉<r=HiddenOPT1>]
		case $game_temp.choice
			when 0,-1 #no
				call_msg("TagMapAriseVillage:AriseVillage/0to1_Fishman1_opt_No")
				get_character(tmpFishExplorerID).call_balloon(28,-1)
				tmpAggro = false
				tmpSetComp = false
				tmpSummonFish = false
			when 1 #呃... Aggro
			if $game_player.record_companion_name_back == "UniqueCecily"
			end
				call_msg("TagMapAriseVillage:AriseVillage/0to1_Fishman1_opt_Yes")
				tmpAggro = true
				tmpSetComp = true
				tmpSummonFish = true
				SndLib.bgm_play("CB_Combat LOOP",80,100)
			when 2 #我是傭兵
				call_msg("TagMapAriseVillage:AriseVillage/0to1_Fishman1_opt_WIS")
				tmpAggro = false
				tmpSetComp = true
				tmpSummonFish = false
			when 3 #賽希莉
				portrait_hide
				chcg_background_color(0,0,0,0,7)
					portrait_off
					get_character($game_player.get_followerID(0)).moveto($game_player.x-1,$game_player.y)
					get_character($game_player.get_followerID(1)).moveto($game_player.x,$game_player.y+1)
					get_character($game_player.get_followerID(0)).direction = 6
					get_character($game_player.get_followerID(1)).direction = 8
				chcg_background_color(0,0,0,255,-7)
				call_msg("TagMapAriseVillage:AriseVillage/0to1_Fishman1_opt_Cecily")
				tmpAggro = false
				tmpSetComp = true
				tmpSummonFish = false
		end
		if tmpSetComp == true && $game_player.record_companion_name_ext != nil
			$game_temp.choice = -1
			call_msg("commonComp:notice/ExtOverWrite")
			call_msg("common:Lona/Decide_optD")
			if $game_temp.choice ==1
				tmpSetComp = true
			else
				tmpAggro = false
				tmpSetComp = false
				tmpSummonFish = false
			end
		end
		$story_stats["HiddenOPT0"] = 0
		$story_stats["HiddenOPT1"] = 0
	end #get_character(tmpDualBiosID).summon_data[:Aggro]
end

if tmpSetComp
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		$story_stats["RecQuestAriseVillageFish"] = 1 if $story_stats["RecQuestAriseVillageFish"] == 0
		get_character(tmpDualBiosID).summon_data[:Aggro] = tmpAggro
		get_character(0).set_this_event_companion_ext("AriseVillageCompExtConvoy",false,10+$game_date.dateAmt)	
		get_character(0).delete
		$game_map.reserve_summon_event("AriseVillageCompExtConvoy",$game_player.x,$game_player.y-1)
		get_character(tmpGuardTopID).delete if !tmpAggro
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapAriseVillage:AriseVillage/0to1_Fishman2_joined")
	
	if tmpAggro
		get_character(tmpDualBiosID).summon_data[:Aggro] = true
		$game_map.npcs.each{|event|
			next unless event.summon_data
			next unless event.summon_data[:Villager]
			next if event.deleted?
			next unless [nil,:none].include?(event.npc.action_state)
			event.npc.add_fated_enemy([0,8])
			event.npc.killer_condition={"health"=>[0, ">"]}
			event.npc.assaulter_condition={"health"=>[0, ">"]}
			event.npc.fraction_mode = 4
			
			next if event.summon_data[:Guard] || event.summon_data[:Shopper]
			event.move_type = 1 if event.move_type == 0
			event.set_manual_move_type(1)
			event.set_move_frequency(rand(3)+1)
			event.move_frequency = rand(3)+1
		}
	elsif !get_character(tmpDualBiosID).summon_data[:Aggro]
		$game_map.npcs.each{|event|
			next unless event.summon_data
			next unless event.summon_data[:Villager]
			next if event.deleted?
			next unless [nil,:none].include?(event.npc.action_state)
			event.npc.fated_enemy -= [0,8]
			
			next if event.summon_data[:Guard] || event.summon_data[:Shopper]
			event.move_type = 1 if event.move_type == 0
			event.set_manual_move_type(1)
			event.set_move_frequency(rand(3)+1)
			event.move_frequency = rand(3)+1
		}
	end
else #tmpSetComp else
	if !get_character(tmpDualBiosID).summon_data[:Aggro]
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			cam_center(0)
			$game_player.direction = 8
			get_character(tmpFishExplorerID).animation = get_character(tmpFishExplorerID).animation_stun
			get_character(tmpGuardTopID).moveto(tmpGuardTopX,tmpGuardTopY)
		chcg_background_color(0,0,0,255,-7)
	end
end #if tmpSetComp
eventPlayEnd
