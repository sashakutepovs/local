
SndLib.bgm_play("Cave/Espionage LOOP MOVING",80)
SndLib.bgs_play("Cave/Cavern Sound effect_Short",50)


$game_map.shadows.set_color(0, 20, 40)
$game_map.shadows.set_opacity(130)
$game_map.interpreter.map_background_color(80,80,200,40,0)

p "########## BIOS AUTORUN SETUP ##########"
$game_player.direction = 2 if $story_stats["ReRollHalfEvents"] ==1
fadeout2=$story_stats["ReRollHalfEvents"] ==1
newgame=$story_stats["RecordFirstMissionBegin"] ==0 
		
		####################################################### lets test color fix here
		
		if $story_stats["record_Rebirth"] >= 1
			$story_stats["RecordFirstMissionBegin"] =1 if $story_stats["record_Rebirth"] >= 1
			$game_player.direction = 6
			$game_player.apply_color_palette
		end
		
		#############################################################################
fadeout = newgame || fadeout2
enter_static_tag_map(nil,fadeout) if $story_stats["ReRollHalfEvents"] == 1
summon_companion


if $story_stats["RecordFirstMissionBegin"] ==0 
	
	$story_stats["RecordFirstMissionBegin"] =1
	$game_player.direction = 6
	$story_stats["HiddenOPT0"] = [
	InputUtils.getKeyAndTranslateLong(:SHIFT),
	InputUtils.getKeyAndTranslateLong(:C),
	InputUtils.getKeyAndTranslateLong(:B),
	InputUtils.getKeyAndTranslateLong(:ALT),
	InputUtils.getKeyAndTranslateLong(:ALT),
	InputUtils.getKeyAndTranslateLong(:CTRL),
	 "#{InputUtils.getKeyAndTranslateLong(:S1)}#{InputUtils.getKeyAndTranslateLong(:S2)}#{InputUtils.getKeyAndTranslateLong(:S3)}#{InputUtils.getKeyAndTranslateLong(:S4)}#{InputUtils.getKeyAndTranslateLong(:S5)}#{InputUtils.getKeyAndTranslateLong(:S6)}#{InputUtils.getKeyAndTranslateLong(:S7)}#{InputUtils.getKeyAndTranslateLong(:S8)}"
	]
	
	call_msg("MainTownSewer:Sewer/MissionStart0")
	portrait_hide
	call_msg("MainTownSewer:Sewer/MissionStart1")
	call_msg("MainTownSewer:Sewer/MissionStart2")
	$story_stats["HiddenOPT0"] = "0"
end
SndLib.bgm_play("Cave/Espionage LOOP MOVING",80)

eventPlayEnd

get_character(0).erase