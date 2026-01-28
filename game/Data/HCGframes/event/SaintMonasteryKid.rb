if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

################################################################ 尋找湯米的任務
if $story_stats["RecQuestSMRefugeeCampFindChild"] == 3 && get_character(0).summon_data[:QuprogTommy] == 3
	get_character(0).call_balloon(0)
	$story_stats["RecQuestSMRefugeeCampFindChild"] = 4
	call_msg("TagMapSaintMonastery:MIAchildMAMA/prog3")
	$game_map.npcs.any?{|event|
		next if event.summon_data == nil
		next unless event.summon_data[:QuprogTommy] == 4
		next if event.actor.action_state == :death
		event.call_balloon(28,-1)
	}
	return eventPlayEnd
	
################################################################ 以下為基本款
else
	SndLib.sound_QuickDialog
	call_msg_popup("TagMapSaintMonastery:kid1M/Qmsg#{rand(2)}",get_character(0).id)
end