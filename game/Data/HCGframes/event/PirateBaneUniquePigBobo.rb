if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

get_character(0).animation = nil
	call_msg("CompPigBobo:UniquePigBobo/begin")
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonComp:Companion/TeamUp"]			,"TeamUp"]  if $game_player.record_companion_name_front != "UniquePigBobo"
	tmpTarList << [$game_text["commonComp:Companion/Disband"]			,"Disband"] if $game_player.record_companion_name_front == "UniquePigBobo"
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
	
	case tmpPicked
	when "TeamUp"
		call_msg("CompPigBobo:UniquePigBobo/CompData")
		show_npc_info(get_character(0),extra_info=false,"commonComp:Companion/Accept") 			#\optD[算了，確定]
		case $game_temp.choice
			when 0,-1
			when 1
				if $game_player.actor.stat["EffectWet"] >=1 #WET
					SndLib.SwineAtk
					call_msg("CompPigBobo:UniquePigBobo/Comp_win")
					portrait_hide
					chcg_background_color(0,0,0,0,7)
						portrait_off
						cam_center(0)
						$game_player.record_companion_name_front = "UniquePigBobo"
						$game_player.record_companion_front_date = $game_date.dateAmt+4
						get_character(0).delete
						EvLib.sum("UniquePigBobo")
					chcg_background_color(0,0,0,255,-7)
				else
					SndLib.pigQuestion
					call_msg("CompPigBobo:UniquePigBobo/Comp_failed")
					get_character(0).call_balloon(5)
				end
		end
	when "Disband"
		call_msg("commonComp:Companion/Accept") 			#\optD[算了，確定]
			case $game_temp.choice
				when 0,-1
				when 1
					SndLib.pigQuestion
					call_msg("CompPigBobo:UniquePigBobo/Comp_disband")
					$game_player.record_companion_name_front = nil
					#get_character(0).set_this_companion_disband(false)
			end
	end
	
eventPlayEnd
