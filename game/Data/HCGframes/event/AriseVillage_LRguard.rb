if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if $story_stats["RecQuestAriseVillageFish"] >= 2 || $game_player.record_companion_name_ext == "AriseVillageCompExtConvoy"
	call_msg("TagMapAriseVillage:CommomerM0/Rng#{rand(3)}")
else
	call_msg("TagMapAriseVillage:AriseVillage/0to1_Rng#{rand(2)}")
end

eventPlayEnd