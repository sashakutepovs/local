
return SndLib.sys_trigger if $story_stats["RecQuestDF_Ecp"] == -1
return SndLib.sys_trigger if $story_stats["RecQuestDF_Ecp"] != 3

tmpAmo1X,tmpAmo1Y,tmpAmo1ID = $game_map.get_storypoint("Ammo1")
tmpAmo2X,tmpAmo2Y,tmpAmo2ID = $game_map.get_storypoint("Ammo2")
tmpCan1X,tmpCan1Y,tmpCan1ID = $game_map.get_storypoint("Cannon1")
tmpCan2X,tmpCan2Y,tmpCan2ID = $game_map.get_storypoint("Cannon2")
tmpDorX,tmpDorY,tmpDorID = $game_map.get_storypoint("Door")
tmpQcX,tmpQcY,tmpQcID = $game_map.get_storypoint("QuestCount")
tmpExX,tmpExY,tmpExID = $game_map.get_storypoint("exitDor")
if get_character(tmpQcID).summon_data[:withAmmo] == true
	SndLib.sys_buzzer
	$game_map.popup(0,"TagMapDoomFortEastCP:lona/WithAmmoQmsg#{rand(2)}",0,0)
	return
end
get_character(tmpAmo1ID).call_balloon(0)
get_character(tmpAmo2ID).call_balloon(0)
get_character(tmpDorID).call_balloon(0)

cannon1 = get_character(tmpCan1ID)
cannon2 = get_character(tmpCan2ID)
can1_lod = cannon1.summon_data[:loaded]
can2_lod = cannon2.summon_data[:loaded]
can1_fired = cannon1.summon_data[:fired]
can2_fired = cannon1.summon_data[:fired]
cannon1.call_balloon(28,-1) if !can1_lod && !can1_fired
cannon2.call_balloon(28,-1) if !can2_lod && !can2_fired

	$game_player.animation = $game_player.animation_mc_pick_up
	SndLib.sound_equip_armor
	get_character(0).moveto(99,99)
	get_character(tmpExID).call_balloon(28,-1)
	get_character(tmpQcID).summon_data[:withAmmo] = true

