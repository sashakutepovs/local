if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if $story_stats["RecQuestAriseVillageApe"] == 3
	SndLib.MonkeyLost(80,65)
elsif !get_character(0).summon_data[:Released]
	SndLib.sound_step_chain(100)
	call_msg("TagMapAriseVillage:Rho/Ape0_opt")
	return if $game_temp.choice != 1
	get_character(0).call_balloon(0)
	3.times{
		SndLib.sound_step_chain(100)
		if [true,false].sample
			$game_player.animation = $game_player.animation_atk_mh
		else
			$game_player.animation = $game_player.animation_atk_sh
		end
		wait(50)
	}
	SndLib.sound_combat_sword_hit_sword
	wait(20)
	get_character(0).set_npc("WildApeF_Sneak")
	SndLib.MonkeyLost(80,65)
	get_character(0).npc.no_aggro= true
	get_character(0).npc.killer_condition={"sex"=>[65535, "="]}
	get_character(0).npc.assaulter_condition={"sex"=>[65535, "="]}
	get_character(0).summon_data[:Released] = true
	get_character(0).animation = nil
	get_character(0).animation = nil
	get_character(0).npc.master = $game_player
	get_character(0).npc.set_fraction(400)
	get_character(0).move_type = 3
	get_character(0).set_manual_move_type(3)
	get_character(0).move_frequency = 5
	get_character(0).set_move_frequency(5)
	get_character(0).set_this_event_follower(0)
	get_character(0).npc.no_aggro= true
	get_character(0).through = false
	get_character(0).follower[1] = 1
	get_character(0).call_balloon(0)
	eventPlayEnd
	tmpApe = 0
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:Monkey]
		next unless event.summon_data[:Released]
		next if event.deleted?
		next if event.npc.action_state == :death
		tmpApe += 1
	}
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:Villager]
		next if event.deleted?
		next if event.npc.action_state == :death
		event.npc.add_fated_enemy([400,8])
	}
	if tmpApe >= 2
		tmpLdoorX,tmpLdoorY,tmpLdoorID=$game_map.get_storypoint("Ldoor")
		tmpLexitX,tmpLexitY,tmpLexitID=$game_map.get_storypoint("Lexit")
		tmpRdoorX,tmpRdoorY,tmpRdoorID=$game_map.get_storypoint("Rdoor")
		tmpRexitX,tmpRexitY,tmpRexitID=$game_map.get_storypoint("Rexit")
		tmpPriestX,tmpPriestY,tmpPriestID=$game_map.get_storypoint("Priest")
		get_character(tmpRdoorID).call_balloon(28,-1)
		get_character(tmpPriestID).call_balloon(28,-1)
		get_character(tmpLexitID).call_balloon(0)
		get_character(tmpLdoorID).call_balloon(0)
		get_character(tmpRexitID).call_balloon(0)
		call_msg("TagMapAriseVillage:Rho/Ape1")
		call_msg("TagMapAriseVillage:Rho/Ape2_brd")
		eventPlayEnd
	end
else
	tmpPicked = ""
	tmpQuestList = []
	tmpQuestList << [$game_text["commonComp:Companion/Follow"]			,"Follow"]
	tmpQuestList << [$game_text["commonComp:Companion/Wait"]			,"Wait"]
	tmpQuestList << [$game_text["DataInput:Key/Ctrl"]					,"Sneak"]
	cmd_sheet = tmpQuestList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
		p cmd_text
	end
	SndLib.MonkeyLost
	show_npc_info(get_character(0),extra_info=false,"\\optB[#{cmd_text}]")

	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
	case tmpPicked
		when "Follow"
			get_character(0).follower[1] = 1
			SndLib.MonkeyLost
		when "Wait"
			get_character(0).follower[1] == 1
			get_character(0).follower[1] = 0
			get_character(0).npc.move_sneak
			SndLib.MonkeyLost(80,65)
		when "Sneak"
			SndLib.MonkeyLost(80,65)
			if get_character(0).npc.movement == :normal
				get_character(0).npc.move_sneak
			else
				get_character(0).npc.move_normal
			end
	end
	get_character(0).process_npc_DestroyForceRoute
end
