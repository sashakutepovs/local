if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
return call_msg("demo") if $DEMO

if $game_player.actor.stat["SlaveBrand"] == 1
	call_msg("TagMapNoerDock:SlaveDealer/TalkIsSlave")
	return eventPlayEnd
end

$game_temp.choice = -1
call_msg("TagMapNoerDock:SlaveDealer/TalkNonSlave") #be slave? [沒興趣，好吧]
if $game_temp.choice == 1
	tmpSlave = ($game_player.player_slave? || $game_player.actor.weak >= 30)
	if !tmpSlave
		call_msg("TagMapNoerDock:SlaveDealer/Talk_failed")
		return eventPlayEnd
	end
	call_msg("TagMapFishTown:Gate/Enter_SlaveChoose")
	call_msg("TagMapNoerDock:SlaveDealer/TalkNonSlave_yes")
		chcg_background_color(0,0,0,0,7)
			$game_player.actor.stat["EventExt1Race"] = "Fishkind"
			$story_stats["SlaveOwner"] = "FishTownR"
			$game_player.actor.stat["EventExt1"] ="Grab"
			call_msg("TagMapFishTown:Gate/Enter_SlaveChoose_brand")
			$game_player.actor.mood = -100
			$game_player.actor.add_state("SlaveBrand") #51
			whole_event_end
		chcg_background_color(0,0,0,255,-7)
	eventPlayEnd
	call_msg("TagMapNoerDock:SlaveDealer/TalkIsSlave")
end


$story_stats["HiddenOPT1"] = "0"
eventPlayEnd