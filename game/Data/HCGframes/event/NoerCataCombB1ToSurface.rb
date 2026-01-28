if cocona_in_group?
	#本次使用特殊地圖設定  非公用的可可娜 故用MAPPOINT擷取單位ID
	#if follower_in_range?(0,3)
	tmpCoconaID=$game_map.get_storypoint("Cocona")[2]
	if get_character(tmpCoconaID).region_id != 50
		SndLib.sys_buzzer
		call_msg_popup("CompCocona:cocona/RecQuestCocona_16_ExitQmsg")
		return 
	end
	call_msg("common:Lona/EnterSub")
	if $game_temp.choice == 1
		if $game_map.threat && $story_stats["Setup_Hardcore"] >= 1
			SndLib.sys_buzzer
			$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
		else
			if $story_stats["QuProgCataUndeadHunt2"] == 5
				$story_stats["QuProgCataUndeadHunt2"] = 6
				$story_stats["RecQuestCocona"] = 1
			end
			chcg_background_color(0,0,0,0,14)
			$story_stats["TagSubTrans"] = "StartPoint3"
			$story_stats["TagSubForceDir"] = 2
			change_map_enter_tagSub("NoerCatacomb")
		end
	end
	$game_temp.choice = -1
else
	call_msg("TagMapNoerCatacombB1:Hole/begin")
end
