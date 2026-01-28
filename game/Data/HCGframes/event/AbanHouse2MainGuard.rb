



if [0,1].include?($story_stats["RecQuestFishCaveHunt2"])
	SndLib.sound_QuickDialog
	call_msg_popup("TagMapAbanHouse2:yeller/Qmsg#{rand(2)}",get_character(0).id)
	return
end

if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

get_character(0).call_balloon(0)
if $story_stats["RecQuestFishCaveHunt2"] == 2
	optain_exp(4000*2)
	call_msg("TagMapAbanHouse2:yeller/begin2to3")
	$story_stats["RecQuestFishCaveHunt2"] = 3
elsif $story_stats["RecQuestFishCaveHunt2"] == 3
	$game_temp.choice = -1
	call_msg("TagMapAbanHouse2:yeller/begin3") #[沒事,發生什麼事]
	case $game_temp.choice
	when 1
		call_msg("TagMapAbanHouse2:yeller/begin3_opt_Wut")
		call_msg("TagMapAbanHouse2:yeller/begin3_opt_WutBoard")
		$game_temp.choice = -1
		call_msg("TagMapAbanHouse2:yeller/begin3_opt_WutBoard_opt") #[不要,沒問題]
		if $game_temp.choice ==1
			call_msg("TagMapAbanHouse2:yeller/begin3_opt_WutBoard_opt_yes")
			$story_stats["RecQuestFishCaveHunt2"] = 4
		end
		
	end
elsif $game_player.record_companion_name_ext == "FishkindCaveCompExtUQConvoy" && $story_stats["RecQuestFishCaveHunt2"] == 4
	tmpExtId=$game_player.get_companion_id("ext")
	yellX,yellY,yellID=$game_map.get_storypoint("YellingGuard")
	tmpFaX,tmpFaY,tmpFaID=$game_map.get_storypoint("FArcher")
	chcg_background_color(0,0,0,0,7)
		get_character(tmpExtId).set_this_companion_disband
		get_character(yellID).direction = 4
		get_character(yellID).moveto(yellX,yellY)
		get_character(tmpFaID).moveto(yellX-1,yellY)
		get_character(tmpFaID).direction = 6
		$game_player.moveto(yellX,yellY+1)
	chcg_background_color(0,0,0,255,-7)
	
	
	$story_stats["RecQuestFishCaveHunt2"] = 5
	
	call_msg("TagMapAbanHouse2:yeller/begin4to5")
	optain_exp(10000)
	wait(30)
	optain_morality(5)
	get_character(yellID).turn_toward_character($game_player)
	get_character(tmpFaID).direction = 2
	call_msg("TagMapAbanHouse2:yeller/begin4to5_2")
	$game_map.popup(0,1,235,1)
	SndLib.sound_equip_armor
	$game_system.add_mail("FishkindReport1")
	call_msg("TagMapAbanHouse2:yeller/begin4to5_3")
	
	
elsif [5,6].include?($story_stats["RecQuestFishCaveHunt2"])
	SndLib.sound_QuickDialog
	call_msg_popup("TagMapAbanHouse2:FArcher/Qmsg",get_character(0).id)
	return
else
	SndLib.sound_QuickDialog
	call_msg_popup("TagMapAbanHouse2:yeller/beginElseQmsg#{rand(2)}",get_character(0).id)
	return
end

$game_temp.choice = -1
portrait_hide
cam_center(0)

return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestFishCaveHunt2"] == 2
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestFishCaveHunt2"] == 3
tmpQ0 = $game_player.record_companion_name_ext == "FishkindCaveCompExtUQConvoy"
tmpQ1 = $story_stats["RecQuestFishCaveHunt2"] == 4
return get_character(0).call_balloon(28,-1) if tmpQ0 && tmpQ1