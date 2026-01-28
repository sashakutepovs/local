tmpQ1 = $story_stats["RecQuestBC2_SideQu"] == 9
tmpQ2 = $game_player.record_companion_name_ext == "BC2_SideQu_Qobj"
if tmpQ1 && tmpQ2
	if $game_map.threat
		SndLib.sys_buzzer
		$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
		return
	end
	tmpT1X,tmpT1Y,tmpT1ID = $game_map.get_storypoint("Tent1")
	tmpT2X,tmpT2Y,tmpT2ID = $game_map.get_storypoint("Tent2")
	$story_stats["RecQuestBC2_SideQu"] = 10
	tmpID = $game_player.get_followerID(-1)
	
	chcg_background_color(0,0,0,0,7)
		$game_player.moveto(tmpT1X,tmpT1Y+2)
		$game_player.direction = 8
		get_character(tmpID).moveto(tmpT1X,tmpT1Y+1)
		get_character(tmpID).direction = 2
	chcg_background_color(0,0,0,255,-7)

	call_msg("TagMapBC2_SideQu:QuGiver10/Begin0")
	call_msg("TagMapBC2_SideQu:QuGiver10/Begin1")
	chcg_background_color(0,0,0,0,7)
		get_character(tmpID).set_this_companion_disband
		get_character(tmpT1ID).delete
		get_character(tmpT2ID).delete
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapBC2_SideQu:QuGiver10/Begin2")
	optain_exp(2500)
	wait(30)
	optain_item($data_items[51],5)
	wait(30)
	optain_morality(5)
	
else
	return SndLib.sys_trigger
end