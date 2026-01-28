if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if $story_stats["Captured"] != 1 && $story_stats["RecQuestDf_Heresy"] == 4
	get_character(0).animation = nil
	call_msg("TagMapDfWaterCave:Df_Heresy/4CommonerF_QuRng0_#{rand(3)}")
	call_msg("TagMapDfWaterCave:CommonerF/Rng#{rand(3)}")
	call_msg("TagMapDfWaterCave:Df_Heresy/4CommonerF_QuRngEND")
else
	get_character(0).summon_data[:RNGdialog] = [true,false].sample if !get_character(0).summon_data[:RNGdialog]
	if get_character(0).summon_data[:RNGdialog]
		call_msg("TagMapDfWaterCave:CommonerF/Rng#{rand(3)}")
	else
		SndLib.sound_QuickDialog
		call_msg_popup("TagMapDfWaterCave:Fcommoner/Qmsg#{rand(3)}",get_character(0).id)
	end
end
eventPlayEnd