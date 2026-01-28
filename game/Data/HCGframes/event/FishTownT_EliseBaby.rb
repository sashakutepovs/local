if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

$story_stats["RecQuestConvoyTarget"] = [21,22]
get_character(-1).animation = get_character(-1).animation_mc_pick_up
optain_item($data_items[120],1)

return get_character(0).delete if $story_stats["UniqueCharUniqueElise"] == -1

get_character(0).opacity = 0
wait(20)
call_msg("CompElise:FishResearch1/17_begin2_gotBB")
eventPlayEnd
get_character(0).delete