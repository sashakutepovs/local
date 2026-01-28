if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if get_character(0).switch1_id >=150
	change_map_tag_map_exit 
else
	
	
	
	
	if get_character(0).switch1_id ==0
	call_msg("TagMapHumanPrisonCave:HumanPrisonCave/Windcave_frist_time")
	end
	
	
	$story_stats["HiddenOPT1"] = "1" if $game_player.actor.sta > 0
	call_msg("TagMapHumanPrisonCave:HumanPrisonCave/Windcave_Opt")
	
	
	if $game_temp.choice == 1
	$story_stats["HiddenOPT1"] = "0" 
	$story_stats["HiddenOPT2"] = "0" 
	$story_stats["HiddenOPT3"] = "0" 
	$story_stats["HiddenOPT4"] = "0" 
	$story_stats["HiddenOPT5"] = "0" 
	$story_stats["HiddenOPT1"] = "1" if $game_player.actor.sta >=20
	$story_stats["HiddenOPT2"] = "1" if $game_player.actor.sta >=40
	$story_stats["HiddenOPT3"] = "1" if $game_player.actor.sta >=80
	$story_stats["HiddenOPT4"] = "1" if $game_player.actor.sta >=160
	$story_stats["HiddenOPT5"] = "1" if $game_player.actor.sta >=240
	call_msg("TagMapHumanPrisonCave:HumanPrisonCave/Windcave_Opt_dig")
	case $game_temp.choice
		when 1 ;temp_cost = 10
		when 2 ;temp_cost = 40
		when 3 ;temp_cost = 60
		when 4 ;temp_cost = 80
		when 5 ;temp_cost = 160
		when 6 ;temp_cost = 240
	end
		if $game_temp.choice >=1
			$cg.erase
			chcg_background_color(0,0,0,1,7)
			wait(35)
			SndLib.sound_equip_armor(90,90+rand(20))
			wait(35)
			SndLib.sound_equip_armor(90,90+rand(20))
			wait(35)
			SndLib.sound_equip_armor(90,90+rand(20))
			wait(35)
			SndLib.sound_equip_armor(90,90+rand(20))
			get_character(0).switch1_id += temp_cost
			$game_player.actor.sta -= 1+temp_cost
			chcg_background_color(0,0,0,255,-7)
				if get_character(0).switch1_id >= 150
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/Windcave_Opt_diged_open")
				else
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/Windcave_Opt_diged")
				end
		end
	end
	
	
	
end


$story_stats["HiddenOPT1"] = "0" 
$story_stats["HiddenOPT2"] = "0" 
$story_stats["HiddenOPT3"] = "0" 
$story_stats["HiddenOPT4"] = "0" 
$story_stats["HiddenOPT5"] = "0" 
$cg.erase
portrait_hide
cam_center(0)
$game_temp.choice = -1

