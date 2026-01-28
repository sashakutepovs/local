if $story_stats["RapeLoop"] == 1 && $story_stats["UniqueCharUniqueOgreWarBoss"] != -1
	call_msg("TagMapSyb_WarBossRoom:rapeloopExit/opt") #[Nvm,exit]
	if $game_temp.choice == 1
		chcg_background_color(0,0,0,0,14)
		SndLib.bgm_stop
		SndLib.sound_equip_armor
		wait(60)
		SndLib.sound_equip_armor
		wait(60)
		SndLib.sound_equip_armor
		wait(120)
		call_msg("TagMapSyb_WarBossRoom:rapeloopExit/did")
		change_map_leave_tag_map
	end
	
else
	SndLib.sys_trigger
end


