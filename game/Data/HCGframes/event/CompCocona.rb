return if get_character(0).animation != nil
tmpCanNude = $game_player.actor.stat["Exhibitionism"] == 1 || $game_player.actor.stat["Nymph"] == 1
get_character(0).turn_toward_character($game_player)
get_character(0).prelock_direction = get_character(0).direction
p $game_NPCLayerMain.stat["Cocona_Dress"]
tmpPicked = ""
tmpQuestList = []
tmpQuestList << [$game_text["commonComp:Companion/Follow"]			,"Follow"]
tmpQuestList << [$game_text["commonComp:Companion/Wait"]			,"Wait"]
tmpQuestList << [$game_text["commonComp:Companion/Other"]			,"Other"]
tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_DressOn"]		,"DressMaid"] if $game_NPCLayerMain.stat["Cocona_Dress"] == "Nude" && $story_stats["RecQuestCoconaVagTaken"] >= 3
tmpQuestList << [$game_text["commonCommands:Lona/BasicNeedsOpt_DressOff"]		,"DressNude"] if $game_NPCLayerMain.stat["Cocona_Dress"] == "Maid" && $story_stats["RecQuestCoconaVagTaken"] >= 3 && tmpCanNude
tmpQuestList << [$game_text["commonComp:Companion/Disband"]						,"Disband"] if !$story_stats["RecQuestCocona"].between?(17,20)
		cmd_sheet = tmpQuestList
		cmd_text =""
		for i in 0...cmd_sheet.length
			cmd_text.concat(cmd_sheet[i].first+",")
			p cmd_text
		end
		if $game_NPCLayerMain.stat["Cocona_Hsta"].nil? || $game_NPCLayerMain.stat["Cocona_Hsta"] >= 0
			call_msg("CompCocona:Cocona/CompCommand",0,2,0)
		else
			call_msg("CompCocona:Cocona/WhoreEV_hurt_CompCommand#{rand(2)}",0,2,0)
		end
		show_npc_info(get_character(0),extra_info=false,"\\optB[#{cmd_text}]")

		$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
		$game_temp.choice = -1
		
case tmpPicked
	when "DressMaid"
		call_msg("CompCocona:dressOn/1")
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			$game_NPCLayerMain.stat["Cocona_Dress"] = "Maid"
			get_character(0).batch_cocona_setCHS("-char-F-TEEN01",12)
			SndLib.sound_equip_armor(100)
			wait(30)
		chcg_background_color(0,0,0,255,-7)
		call_msg("CompCocona:dressOn/2")
		
	when "DressNude"
		call_msg("CompCocona:dressOff/1")
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			$game_NPCLayerMain.stat["Cocona_Dress"] = "Nude"
			get_character(0).batch_cocona_setCHS("-char-F-TEEN01",13)
			SndLib.sound_equip_armor(100)
			wait(30)
		chcg_background_color(0,0,0,255,-7)
		call_msg("CompCocona:dressOff/2")
		
	when "Follow"
		SndLib.sound_QuickDialog 
		$game_map.popup(get_character(0).id,"CompCocona:Cocona/CommandFollow#{rand(2)}",0,0)
		get_character(0).follower[1] =1

	when "Wait"
		SndLib.sound_QuickDialog 
		$game_map.popup(get_character(0).id,"CompCocona:Cocona/CommandWait#{rand(2)}",0,0)
		get_character(0).follower[1] =0
		
	when "Other"
		$game_temp.choice = -1
		tmpUndeadCount = 0
		$game_map.npcs.each{|event|
			next if event == self
			next if event.npc.action_state == :death
			next if event.deleted?
			next unless event.actor.master == get_character(0)
			tmpUndeadCount +=1
		}
		tmpUnSummon = $game_map.npcs.any?{|ev| ev.npc.master == get_character(0)}
		canSummonWarrior	= get_character(0).npc.cost_affordable?($data_arpgskills["NpcCurvedSummonUndeadWarrior"])	 && tmpUndeadCount < 5
		canSummonBow		= get_character(0).npc.cost_affordable?($data_arpgskills["NpcCurvedSummonUndeadBow"])		 && tmpUndeadCount < 5
		canSummonWarrior	? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
		canSummonBow		? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
		tmpUnSummon ? $story_stats["HiddenOPT2"] = "1" : $story_stats["HiddenOPT2"] = "0"
		call_msg("CompCocona:Cocona/CompCommand_extra") #[算了,招喚戰士<r=HiddenOPT0>,招喚弓箭手<r=HiddenOPT1>,回家了<r=HiddenOPT2>]
		case $game_temp.choice
			when 1
				$game_temp.choice = -1
				call_msg("CompCocona:Cocona/CompCommand_extra_SumWarrior")
				tmpSkill = "NpcCurvedSummonUndeadWarrior"
			when 2
				$game_temp.choice = -1
				call_msg("CompCocona:Cocona/CompCommand_extra_SumWarrior")
				tmpSkill = "NpcCurvedSummonUndeadBow"
			when 3
				$game_temp.choice = -1
				call_msg("CompCocona:Cocona/Comp_disband")
				$game_map.events.each{|event|
					next if !event[1].npc?
					next if event[1].npc.master != get_character(0)
					event[1].npc.stat.set_stat("sta",-100)
				}
		end #case
		$story_stats["HiddenOPT0"] = "0"
		$story_stats["HiddenOPT1"] = "0"
	when "Disband"
		call_msg("CompCocona:Cocona/Comp_disband")
		call_msg("common:Lona/Decide_optB")
		cam_center(0)
		if $game_temp.choice == 1
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				portrait_off
				$game_map.npcs.each{|event|
					next unless event.summon_data
					next unless event.summon_data[:user] == get_character(0)
					next unless event.npc.master == get_character(0)
					next if event.deleted?
					next if event.npc.action_state == :death
					event.npc.battle_stat.set_stat_m("sta",0,[0,2,3])
					event.npc.battle_stat.set_stat_m("health",0,[0,2,3])
				}
				get_character(0).set_this_companion_disband
			chcg_background_color(0,0,0,255,-7)
		end
end

if tmpSkill != nil
	get_character(0).npc.target = $game_player
	get_character(0).npc.launch_skill($data_arpgskills[tmpSkill]) #if get_character(0).npc.cost_affordable?($data_arpgskills[tmpSkill])
	get_character(0).npc.target = nil
	get_character(0).npc.refresh
end

eventPlayEnd
