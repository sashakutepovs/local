tmpQ1 = $story_stats["RecQuestPigBobo"] == 1
tmpQ2 = $game_player.record_companion_name_front == "UniquePigBobo"
tmpQ3 = $story_stats["UniqueCharUniquePigBobo"] != -1
if tmpQ1 && tmpQ2 && tmpQ3
	tmpBoboID=$game_player.get_followerID(1)
	if get_character(tmpBoboID).region_id == 50
		call_msg("CompPigBobo:PigBoboQu1/ExitEnd0") ; portrait_hide
		cam_follow(tmpBoboID,0)
		get_character(tmpBoboID).call_balloon(8)
		wait(60)
		$game_player.turn_toward_character(get_character(tmpBoboID))
		get_character(tmpBoboID).turn_toward_character($game_player)
		2.times{
			get_character(tmpBoboID).jump_to(get_character(tmpBoboID).x,get_character(tmpBoboID).y)
			get_character(tmpBoboID).call_balloon(20)
			SndLib.SwineAtk
			wait(20)
		}
		call_msg("CompPigBobo:PigBoboQu1/ExitEnd1")
		$story_stats["RecQuestPigBobo"] = 2
		
		chcg_background_color(0,0,0,0,7)
			get_character(tmpBoboID).set_this_companion_disband
		chcg_background_color(0,0,0,255,-7)
		
		eventPlayEnd
		change_map_tag_map_exit(true)
	else
		SndLib.sys_buzzer
		call_msg_popup("CompPigBobo:PigBoboQu1/ExitFailedQmsg")
	end
else
	change_map_tag_map_exit(true)
end