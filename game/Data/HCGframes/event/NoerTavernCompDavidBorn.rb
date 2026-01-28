if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).animation = nil

if $story_stats["RecQuestDavidBorn"] ==2
$story_stats["RecQuestDavidBorn"] =3
call_msg("CompDavidBorn:DavidBorn/QuRec2to3_1")
cam_center(0)
return portrait_hide
end



$game_player.record_companion_name_front != "UniqueDavidBorn" ? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
$game_player.record_companion_name_front == "UniqueDavidBorn" ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
	call_msg("CompDavidBorn:DavidBorn/KnownBegin")
	call_msg("CompDavidBorn:DavidBorn/BasicOpt") #[Cancel,Team up<r=HiddenOPT0>,Disband<r=HiddenOPT1>,About]
	
	case $game_temp.choice
	when 0,-1
	when 1 #組隊
		call_msg("CompDavidBorn:DavidBorn/CompData")
		show_npc_info(get_character(0),extra_info=false,"commonComp:Companion/Accept") 			#\optD[算了，確定]
		case $game_temp.choice
			when 0,-1
			when 1
				if $game_player.player_slave?
					call_msg("CompDavidBorn:DavidBorn/Comp_failed_slave")
				elsif $game_player.actor.weak >= 100
					call_msg("CompDavidBorn:DavidBorn/Comp_failed")
				else
					call_msg("CompDavidBorn:DavidBorn/Comp_win")
					get_character(0).set_this_event_companion_front("UniqueDavidBorn",false,$game_date.dateAmt+6)
				end
		end
	when 2 #解除組隊
		call_msg("commonComp:Companion/Accept")			#\optD[算了，確定]
			case $game_temp.choice
				when 0,-1
				when 1
					call_msg("CompDavidBorn:DavidBorn/Comp_disband")
					$game_player.record_companion_name_front = nil
			end
	end

$story_stats["HiddenOPT0"] = "0"
$story_stats["HiddenOPT1"] = "0"
portrait_hide
$game_temp.choice = -1
cam_center(0)