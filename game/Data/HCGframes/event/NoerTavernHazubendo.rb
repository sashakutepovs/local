tmpQ1 = $story_stats["RecQuestCocona"].between?(14,20)
tmpQ2 = $story_stats["UniqueCharUniqueTavernWaifu"] == -1
tmpQ3 = $story_stats["RecQuestCocona"] == 25

if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
elsif !(tmpQ1 || tmpQ2 || tmpQ3)
	SndLib.sound_QuickDialog
	chr_id = get_character(0).id
	$game_map.popup(chr_id,"TagMapNoerTavern:Hazubendo/FearWaifu#{rand(4)}",0,0)
	return
end

call_msg("TagMapNoerTavern:Hazubendo/begin")
case $game_temp.choice
	when 0,-1
	when 1
		manual_barters("NoerTavernWaifu")
end
eventPlayEnd
