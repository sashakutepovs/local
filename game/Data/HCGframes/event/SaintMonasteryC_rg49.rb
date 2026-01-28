tmpBOx,tmpBOy,tmpBOid=$game_map.get_storypoint("boss")
tmpMAx,tmpMAy,tmpMAid=$game_map.get_storypoint("TavernWaifu")
tmpL1x,tmpL1y,tmpL1id=$game_map.get_storypoint("L1")

#chcg_background_color(0,0,0,255,-7)
$game_player.direction = 2
$game_player.moveto(tmpL1x+1,tmpL1y)
get_character($game_player.get_followerID(0)).moveto(tmpL1x+1,tmpL1y-1) if $game_player.get_followerID(0) != nil
get_character($game_player.get_followerID(0)).direction = 6 if $game_player.get_followerID(0) != nil
portrait_off

cam_follow(tmpBOid,0)
get_character(tmpBOid).npc_story_mode(true)
get_character(tmpBOid).direction = 2 ; get_character(tmpBOid).move_forward
wait(50)
get_character(tmpBOid).npc_story_mode(false)
call_msg("CompCocona:cocona/RecQuestCocona_18_hall0")
get_character(tmpBOid).direction = 8
portrait_hide
########################################################################    可可娜生存？
tmpQ1 = $story_stats["RecQuestCocona"].between?(17,20)
tmpQ2 = $story_stats["UniqueCharUniqueCocona"] != -1
tmpQ3 = $game_player.record_companion_name_back == "UniqueCoconaMaid"
if !(tmpQ1 && tmpQ2 && tmpQ3)
	eventPlayEnd
	return get_character(0).erase
end
$story_stats["RecQuestCocona"] = 19
get_character($game_player.get_followerID(0)).direction = 2
call_msg("CompCocona:cocona/RecQuestCocona_18_hall1")
portrait_hide

########################################################################    大媽媽生存？
if $story_stats["UniqueCharUniqueTavernWaifu"] != -1
	tmpAR1x,tmpAR1y,tmpAR1id=$game_map.get_storypoint("arr1")
	tmpAR2x,tmpAR2y,tmpAR2id=$game_map.get_storypoint("arr2")
	tmpAR3x,tmpAR3y,tmpAR3id=$game_map.get_storypoint("arr3")
	tmpAR4x,tmpAR4y,tmpAR4id=$game_map.get_storypoint("arr4")
	tmpL2x,tmpL2y,tmpL2id=$game_map.get_storypoint("L2") 
	get_character(tmpMAid).opacity = 0
	get_character(tmpMAid).character_index = 3
	get_character($game_player.get_followerID(0)).direction = 6
	$game_player.direction = 6
	call_msg("CompCocona:cocona/RecQuestCocona_18_hall2")
	51.times{
		get_character(tmpMAid).opacity += 5
		wait(1)
	}
	get_character(tmpMAid).npc_story_mode(true)
	call_msg("CompCocona:cocona/RecQuestCocona_18_hall3")
	portrait_hide
	get_character(tmpMAid).direction = 4 ; get_character(tmpMAid).move_forward
	wait(35)
	get_character(tmpAR1id).summon_data[:tarX] = get_character(tmpMAid).x-1
	get_character(tmpAR2id).summon_data[:tarX] = get_character(tmpMAid).x
	get_character(tmpAR3id).summon_data[:tarX] = get_character(tmpMAid).x+1
	get_character(tmpAR4id).summon_data[:tarX] = get_character(tmpMAid).x-2
	get_character(tmpAR1id).summon_data[:tarY] = get_character(tmpMAid).y-1
	get_character(tmpAR2id).summon_data[:tarY] = get_character(tmpMAid).y+2
	get_character(tmpAR3id).summon_data[:tarY] = get_character(tmpMAid).y+1
	get_character(tmpAR4id).summon_data[:tarY] = get_character(tmpMAid).y-1
	set_event_force_page(tmpAR1id,1)
	wait(12)
	set_event_force_page(tmpAR3id,1)
	wait(25)
	set_event_force_page(tmpAR2id,1)
	$game_player.jump_to(tmpL1x,tmpL1y) ; $game_player.direction = 6
	wait(30)
	call_msg("CompCocona:cocona/RecQuestCocona_18_hall4")
	portrait_hide
	get_character(tmpMAid).character_index = 0
	get_character(tmpMAid).direction = 4 ; get_character(tmpMAid).move_forward
	wait(15)
	SndLib.sound_equip_armor
	get_character(tmpMAid).jump_to(tmpL2x+1,tmpL2y+1)
	wait(5)
	get_character(tmpMAid).direction = 6
	wait(5)
	set_event_force_page(tmpAR4id,1)
	get_character(tmpMAid).direction = 4
	call_msg("CompCocona:cocona/RecQuestCocona_18_hall5")
	get_character($game_player.get_followerID(0)).direction = 2
	get_character(tmpMAid).direction = 8
	call_msg("CompCocona:cocona/RecQuestCocona_18_hall6_1")
	get_character(tmpMAid).direction = 4
	call_msg("CompCocona:cocona/RecQuestCocona_18_hall6_2")
	get_character(tmpMAid).direction = 8
	get_character(tmpMAid).npc_story_mode(false)
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character($game_player.get_followerID(0)).jump_to(tmpL1x,tmpL1y-1) ; get_character($game_player.get_followerID(0)).direction = 6
		get_character(tmpMAid).direction = 6
		get_character(tmpMAid).call_balloon(8,-1)
		
		get_character(tmpMAid).set_npc("UniqueTavernWaifu")
		get_character(tmpMAid).npc.master = $game_player
		get_character(tmpMAid).npc.add_fated_enemy([13])
		get_character(tmpMAid).npc.set_fraction(0)
		get_character(tmpMAid).npc.no_aggro = true
		get_character(tmpMAid).npc.set_def(5)
	chcg_background_color(0,0,0,255,-7)
	call_msg("CompCocona:cocona/RecQuestCocona_18_hall7")
else
	get_character(tmpMAid).delete
end
eventPlayEnd
get_character(0).erase