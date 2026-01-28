if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
	tmp_Begging = $game_player.actor.weak >= 50 && get_character(0).summon_data[:SexTradeble]
	tmp_Begging_Slave =  get_character(0).summon_data[:SexTradeble] && ($game_player.actor.stat["SlaveBrand"] == 1 || $story_stats["SlaveOwner"] == "NoerBackStreet") && $story_stats["Captured"] == 1
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Begging"]			,"Begging"] if tmp_Begging || tmp_Begging_Slave
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	if $story_stats["Captured"] >= 1
		call_msg("TagMapNoerBackStreet:CommonGangMember/begging#{rand(2)}",0,2,0)
	else
		call_msg("commonNPC:CommonGangMember/commonBegin#{npc_talk_style}",0,2,0)
	end
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
				
	case tmpPicked
		when "Barter"
			manual_barters("NoerBackStreetGangMember")
			
		when "Begging"
			if $story_stats["Captured"] == 1
				load_script("Data/HCGframes/event/NoerBackStreetGuard_Begging.rb")
			else
				$game_player.actor.mood -= 10
				tmpMad = true
				if tmpMad
					call_msg("commonNPC:Begging/Aggro0")
					call_msg("commonNPC:Begging/Aggro1")
					call_msg("OvermapNoer:GateGuard/enter_failed#{talk_persona}")
					get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
				else
					call_msg("commonNPC:Begging/Aggro0")
					get_character(0).animation = get_character(0).animation_atk_mh
					get_character(0).call_balloon([15,7,5].sample)
					SndLib.sound_punch_hit(100)
					lona_mood "p5crit_damage"
					$game_player.actor.portrait.shake
					$game_player.actor.force_stun("Stun1")
					return eventPlayEnd
				end
			end
			$game_player.animation = nil
	end


eventPlayEnd
