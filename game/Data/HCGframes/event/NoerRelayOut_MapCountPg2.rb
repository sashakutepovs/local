return get_character(0).erase if $story_stats["UniqueCharUniqueGrayRat"] == -1
return get_character(0).erase if $story_stats["UniqueCharUniqueCecily"] == -1
return get_character(0).erase if ![13,14].include?($story_stats["QuProgSaveCecily"])
return get_character(0).erase if $game_player.getComB_Name != "UniqueCecily"

tmpC14quEndPTX,tmpC14quEndPTY,tmpC14quEndPTID=$game_map.get_storypoint("C14quEndPT")
tmpRufC14endX,tmpRufC14endY,tmpRufC14endID=$game_map.get_storypoint("RufC14end")
tmpRufC14M1X,tmpRufC14M1Y,tmpRufC14M1ID=$game_map.get_storypoint("RufC14M1")

portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	get_character(tmpRufC14M1ID).delete
	tmpFmove_type = get_character($game_player.get_companion_id(0)).move_type
	get_character($game_player.get_companion_id(0)).move_type = 0
	get_character($game_player.get_companion_id(0)).npc_story_mode(true)
	get_character($game_player.get_companion_id(0)).direction = 6
	get_character(tmpRufC14endID).moveto(tmpC14quEndPTX,tmpC14quEndPTY)
	get_character(tmpRufC14endID).npc_story_mode(true)
	
	get_character(tmpRufC14endID).opacity = 255
	get_character($game_player.get_companion_id(1)).moveto(tmpC14quEndPTX+1,tmpC14quEndPTY)
	get_character($game_player.get_companion_id(0)).moveto(tmpC14quEndPTX,tmpC14quEndPTY+1)
	$game_player.moveto(tmpC14quEndPTX-1,tmpC14quEndPTY)
	get_character($game_player.get_companion_id(1)).direction = 4
	get_character($game_player.get_companion_id(0)).direction = 8
	$game_player.direction = 6
	$story_stats["QuProgSaveCecily"] = 15
chcg_background_color(0,0,0,255,-7)

if get_character(0).summon_data[:WisWay] == true
	call_msg("CompCecily:Cecily/QuestHikack14_WisOPTend3") ; portrait_hide
	optain_exp(2000)
else
	SndLib.bgm_play_prev
end
call_msg("CompCecily:Cecily/QuestHikack14_to15_1")

get_character($game_player.get_companion_id(0)).animation = get_character($game_player.get_companion_id(0)).animation_grabber_qte(get_character(tmpRufC14endID))
get_character(tmpRufC14endID).animation = get_character(tmpRufC14endID).animation_grabbed_qte
SndLib.sound_equip_armor(100)
call_msg("CompCecily:Cecily/QuestHikack14_to15_2")
call_msg("CompCecily:Cecily/QuestHikack14_to15_3")
portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	get_character($game_player.get_companion_id(0)).animation = nil
	get_character(tmpRufC14endID).animation = nil
	call_msg("CompCecily:Cecily/QuestHikack14_to15_4")
chcg_background_color(0,0,0,255,-7)

call_msg("CompCecily:Cecily/QuestHikack14_to15_5")
	
portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	get_character(tmpRufC14endID).delete
	$game_map.npcs.each do |event| 
		next unless event.summon_data
		next unless event.summon_data[:CecilyQu14]
		next unless event.summon_data[:CecilyQu14Saint]
		event.summon_data[:CanGetReward] = true
		event.call_balloon(8,-1)
	end
chcg_background_color(0,0,0,255,7)

call_msg("CompCecily:Cecily/QuestHikack14_to15_BRD")

get_character($game_player.get_companion_id(0)).npc_story_mode(false)
get_character($game_player.get_companion_id(0)).move_type = tmpFmove_type


eventPlayEnd