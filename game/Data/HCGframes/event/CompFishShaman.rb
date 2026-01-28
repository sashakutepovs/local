get_character(0).turn_toward_character($game_player)
get_character(0).prelock_direction = get_character(0).direction

tmpMobAlive = $game_map.npcs.any?{
|event|
	next unless event.summon_data
	next unless event.summon_data[:WildnessNapEvent]
	next if event.deleted?
	next if event.npc.action_state == :death
	true
}
tmpCanExtension = !tmpMobAlive && !$game_map.threat


tmpPicked = ""
tmpQuestList = []
tmpQuestList << [$game_text["commonComp:Companion/Follow"]			,"Follow"]
tmpQuestList << [$game_text["commonComp:Companion/Wait"]			,"Wait"]
tmpQuestList << [$game_text["commonComp:Companion/Extension"]		,"Extension"] if tmpCanExtension
tmpQuestList << [$game_text["commonComp:Companion/Disband"]			,"Disband"]
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
		$game_map.popup(get_character(0).id,"QuickMsg:NPC/CommandFollow#{rand(2)}",0,0)
		get_character(0).follower[1] =1

	when "Wait"
		SndLib.sound_QuickDialog 
		$game_map.popup(get_character(0).id,"QuickMsg:NPC/CommandWait#{rand(2)}",0,0)
		get_character(0).follower[1] =0
		
	when "Extension"
		$game_temp.choice = -1
		call_msg("commonComp:CompFishGuard/sex0")
		call_msg("commonComp:CompFish/Extension")
		call_msg("common:Lona/Decide_optB")
		if $game_temp.choice == 1
			call_msg("commonNPC:RandomNpc/WhoreWork#{talk_style}")
			$cg.erase
			call_msg("commonComp:CompFishGuard/sex1")
				get_character(0).animation = get_character(0).animation_hold_sh
				cam_follow(get_character(0).id,0)
				get_character(0).call_balloon(20)
				call_msg("TagMapFishTown:Guards/OfferSex0_#{rand(2)}")
				tmpLonaX = $game_player.x
				tmpLonaY = $game_player.y
				$game_player.moveto(get_character(0).x,get_character(0).y)
				wait(10)
				play_sex_service_menu(get_character(0),0,tmpPoint=nil,true,fetishLVL=3,forceCumIn=true)
				whole_event_end
				$game_player.moveto(tmpLonaX,tmpLonaY)
			$game_player.record_companion_back_date += 4
			call_msg("commonComp:CompFishShaman/Comp_win")
		end
		
	when "Disband"
		call_msg("commonComp:#{get_character(0).npc.npc_name}/Comp_disband")
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



eventPlayEnd