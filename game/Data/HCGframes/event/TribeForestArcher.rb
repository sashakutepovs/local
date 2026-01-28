tmpArcherX,tmpArcherY,tmpArcherID = $game_map.get_storypoint("Archer")
tmpQuestCountID = $game_map.get_storypoint("QuestCount")[2]

if $story_stats["RecQuestPenisTribeHelp"] == 2 && get_character(0).npc.master != $game_player
	get_character(0).call_balloon(0)
	call_msg("TagMapTribeForest:Archer/begin0")
	
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(0).moveto(tmpArcherX,tmpArcherY-1)
		get_character(0).process_npc_DestroyForceRoute
		get_character(0).npc_story_mode(true)
		get_character(0).direction = 6
		get_character(0).move_type = 0
		$game_player.direction = 4
		$game_player.moveto(tmpArcherX+1,tmpArcherY-1)
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapTribeForest:Archer/begin1")
	get_character(0).direction = 8 ; get_character(0).move_forward_force
	wait(35)
	get_character(0).direction = 6 ; get_character(0).move_forward_force
	$game_player.direction = 6
	wait(35)
	get_character(0).direction = 6 ; get_character(0).move_forward_force
	wait(35)
	if $game_player.actor.wisdom >= 12
		call_msg("TagMapTribeForest:Archer/begin1_WisMod_opt") #[等等！,算了]
		if $game_temp.choice == 0
			call_msg("TagMapTribeForest:Archer/begin1_WisMod0")
			get_character(0).direction = 4
			call_msg("TagMapTribeForest:Archer/begin1_WisMod1")
			call_msg("TagMapNFL_OrkCamp2:MercJoin/spear")
			get_character(0).set_this_event_companion_back_lite
			#call_msg("TagMapTribeForest:Archer/begin1_WisMod0")
			#get_character(0).direction = 4
			#call_msg("TagMapTribeForest:Archer/begin1_WisMod1")
			get_character(0).npc_story_mode(false)
			get_character(0).npc.master = $game_player
			#get_character(0).set_this_event_follower(0)
			#get_character(0).follower=[1,1,0,0]
			#get_character(0).summon_data[:follower] = true
			#get_character(0).set_manual_move_type(3)
			#get_character(0).move_type = 3
			get_character(0).npc.fated_enemy << 4
		end
	end
	if get_character(0).npc.master != $game_player
		51.times{
			get_character(0).opacity -= 5
			wait(1)
		}
	end
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		posi=$game_map.region_map[14].sample
		get_character(0).npc_story_mode(false)
		get_character(0).opacity = 255
		if get_character(0).npc.master != $game_player
			get_character(0).moveto(1,1)
		else
			get_character(0).moveto($game_player.x-1,$game_player.y)
		end
		EvLib.sum("RecQuestPenisTribeHelp_GaintBoarF",posi[0],posi[1],{:RecQuestPenisTribeHelp_GaintBoarF=>true})
		wait(10)
		$game_map.npcs.each{|ev|
			next unless ev.summon_data
			next unless ev.summon_data[:RecQuestPenisTribeHelp_GaintBoarF]
			ev.call_balloon(19,-1)
		}
		set_event_force_page(tmpQuestCountID,3)
		$game_player.direction = 4
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapTribeForest:Archer/begin2")
	call_msg("TagMapTribeForest:Archer/begin3")

elsif get_character(0).npc.master == $game_player
	get_character(0).turn_toward_character($game_player)
	get_character(0).prelock_direction = get_character(0).direction
	tmpPicked = ""
	tmpQuestList = []
	tmpQuestList << [$game_text["commonComp:Companion/Follow"]			,"Follow"]
	tmpQuestList << [$game_text["commonComp:Companion/Wait"]			,"Wait"]
			cmd_sheet = tmpQuestList
			cmd_text =""
			for i in 0...cmd_sheet.length
				cmd_text.concat(cmd_sheet[i].first+",")
				p cmd_text
			end
			call_msg("common:Lona/CompCommand",0,2,0)
			show_npc_info(get_character(0),extra_info=false,"\\optB[#{cmd_text}]")

			$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
			$game_temp.choice = -1

	case tmpPicked
		when "Follow"
			SndLib.sound_QuickDialog
			call_msg_popup("TagMapTribeForest:Archer/Qmsg#{rand(3)}",get_character(0).id)
			get_character(0).follower[1] =1

		when "Wait"
			SndLib.sound_QuickDialog
			$game_map.popup(get_character(0).id,"QuickMsg:NPC/CommandWait#{rand(2)}",0,0)
			get_character(0).follower[1] =0
	end
else
	SndLib.sound_QuickDialog
	call_msg_popup("TagMapTribeForest:Archer/Qmsg#{rand(3)}",get_character(0).id)
end
eventPlayEnd
