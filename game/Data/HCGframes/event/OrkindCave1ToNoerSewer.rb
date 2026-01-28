
if $game_map.threat && $story_stats["Setup_Hardcore"] >= 1
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
else
	call_msg("TagMapRandOrkindCave:Lona/ToOrkindCave1")
	if $game_temp.choice == 1
		if $game_map.threat && $story_stats["Setup_Hardcore"] >= 1
			SndLib.sys_buzzer
			$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
		else
			$game_player.move_normal
			$game_map.interpreter.chcg_background_color(0,0,0,255)
			$story_stats["OverMapForceTrans"] = "NoerSewer"
			$story_stats["TagSubTrans"] = "StartPoint2"
			$story_stats["TagSubForceDir"] = 2
			call_msg("MainTownSewer:Lona/ToOrkindCave_procress")
			call_msg("MainTownSewer:Lona/ToOrkindCave_procress1")
			change_map_leave_tag_map
		end
	else
		eventPlayEnd
	end
end


$game_temp.choice =-1