return if get_character(0).animation != nil
get_character(0).turn_toward_character($game_player)
get_character(0).prelock_direction = get_character(0).direction

tmpQcID=$game_map.get_storypoint("QuestCount")[2]
if get_character(tmpQcID).summon_data[:KilledAll] == true
	get_character(tmpQcID).summon_data[:KilledAll] = false
	call_msg("TagMapNoerCatacombB1:Cocona/aggro_FdSide8_win")
	optain_exp(9000)
	return eventPlayEnd
end

tmpPicked = ""
tmpQuestList = []
tmpQuestList << [$game_text["commonComp:Companion/Follow"]			,"Follow"]
tmpQuestList << [$game_text["commonComp:Companion/Wait"]			,"Wait"]
		cmd_sheet = tmpQuestList
		cmd_text =""
		for i in 0...cmd_sheet.length
			cmd_text.concat(cmd_sheet[i].first+",")
		end
		call_msg("CompCocona:Cocona/CompCommand",0,2,0)
		show_npc_info(get_character(0),extra_info=false,"\\optB[#{cmd_text}]")

		$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
		$game_temp.choice = -1
		
case tmpPicked
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
		get_character(0).npc.cost_affordable?($data_arpgskills["NpcCurvedSummonUndeadWarrior"])		? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
		get_character(0).npc.cost_affordable?($data_arpgskills["NpcCurvedSummonUndeadBow"])			? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
		call_msg("CompCocona:Cocona/CompCommand_extra") #[算了,招喚戰士<r=HiddenOPT0>,招喚弓箭手<r=HiddenOPT1>]
		case $game_temp.choice
			when 1
				$game_temp.choice = -1
				call_msg("CompCocona:Cocona/CompCommand_extra_SumWarrior")
				tmpSkill = "NpcCurvedSummonUndeadWarrior"
			when 2
				$game_temp.choice = -1
				call_msg("CompCocona:Cocona/CompCommand_extra_SumWarrior")
				tmpSkill = "NpcCurvedSummonUndeadBow"
		end #case
		
	when "Disband"
		call_msg("CompCocona:Cocona/Comp_disband")
		call_msg("common:Lona/Decide_optB")
		cam_center(0)
		if $game_temp.choice == 1
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				portrait_off
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

cam_center(0)
$story_stats["HiddenOPT0"] = "0"
$story_stats["HiddenOPT1"] = "0"
$game_temp.choice = -1
portrait_hide
