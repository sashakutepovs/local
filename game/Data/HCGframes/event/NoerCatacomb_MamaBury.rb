if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if cocona_in_group? && $story_stats["RecQuestCoconaBuryMama"] ==0 && $game_party.has_item?($data_items[110])
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		tmpID = $game_player.get_followerID(0)
		get_character(tmpID).moveto(get_character(0).x+1,get_character(0).y)
		get_character(tmpID).direction = 4
		$game_player.moveto(get_character(0).x-1,get_character(0).y)
		$game_player.direction = 6
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapNoerCatacomb:Lona/CoconaMama_Bury")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		$story_stats["RecQuestCoconaBuryMama"] = 1
		optain_lose_item($data_items[110],1)
		get_character(0).delete
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapNoerCatacomb:Lona/Bury_end")
	eventPlayEnd
end