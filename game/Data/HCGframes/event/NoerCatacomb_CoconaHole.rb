if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if $story_stats["QuProgCataUndeadHunt2"] ==6
	$story_stats["QuProgCataUndeadHunt2"] = 7
	call_msg("TagMapNoerCatacomb:Lona/HoleBlock")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		SndLib.sys_equip
		get_character(0).delete
	chcg_background_color(0,0,0,255,-7)
	eventPlayEnd
end