
tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]




if get_character(tmpDualBiosID).summon_data[:Aggro]
	portrait_hide
	chcg_background_color(0,0,0,0,7)
	portrait_off
	call_msg("TagMapAriseVillage:Ded/Nap")
	6.times{
		$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
		SndLib.sound_gore(100)
		SndLib.sound_combat_hit_gore(70)
		wait(20+rand(20))
	}
	map_background_color(0,0,0,255,0)
	load_script("Data/HCGframes/event/Ending_loaderBad.rb")
else
	call_msg("common:Lona/NarrDriveAway")
	change_map_leave_tag_map
end

