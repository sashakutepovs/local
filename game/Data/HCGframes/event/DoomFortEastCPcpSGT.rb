if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
tmpDorX,tmpDorY,tmpDorID = $game_map.get_storypoint("Door")
tmpAmo1X,tmpAmo1Y,tmpAmo1ID = $game_map.get_storypoint("Ammo1")
tmpAmo2X,tmpAmo2Y,tmpAmo2ID = $game_map.get_storypoint("Ammo2")
tmpCan1X,tmpCan1Y,tmpCan1ID = $game_map.get_storypoint("Cannon1")
tmpCan2X,tmpCan2Y,tmpCan2ID = $game_map.get_storypoint("Cannon2")
if $story_stats["RecQuestDF_Ecp"] == 0
	get_character(0).call_balloon(0)
	$story_stats["RecQuestDF_Ecp"] = 1
	get_character(0).move_type = 3
	call_msg("TagMapDoomFortEastCP:CPofficer/overrunning_begin0")
	
elsif $story_stats["RecQuestDF_Ecp"] == 2
	get_character(0).call_balloon(0)
	$story_stats["RecQuestDF_Ecp"] = 3
	call_msg("TagMapDoomFortEastCP:CPofficer/overrunning_begin2")
	get_character(tmpDorID).call_balloon(28,-1)
	get_character(tmpAmo1ID).call_balloon(28,-1)
	get_character(tmpAmo2ID).call_balloon(28,-1)
	set_event_force_page(tmpCan1ID,2)
	set_event_force_page(tmpCan2ID,2)

else
	call_msg("TagMapDoomFortEastCP:CPofficer/InfoHere")
	
#elsif [1,3].include?($story_stats["RecQuestDF_Ecp"])
#	SndLib.sound_QuickDialog
#	$game_map.popup(get_character(0).id,"TagMapDoomFortEastCP:CPofficer/DuringQuprogQmsg",0,0)
#
#elsif $story_stats["RecQuestDF_Ecp"] == 4
	
end

cam_center(0)
portrait_hide