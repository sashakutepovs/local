#return init_jump_page(2) if $story_stats["UniqueCharUniqueLisa"] == -1
#return init_jump_page(2) if $game_player.record_companion_name_ext=="CompExtUniqueLisa"
#return init_jump_page(2) if $story_stats["RecQuestLisa"] != 3
p $story_stats["UniqueCharUniqueLisa"]
p $game_player.record_companion_name_ext
p $story_stats["RecQuestLisa"]

chcg_background_color(0,0,0,0,7)
	tmpLX,tmpLY,tmpLid=$game_map.get_storypoint("UniqueLisa")
	tar = get_character($game_player.get_companion_id(-1))
	tar.set_this_companion_disband(true)
	set_event_force_page(tmpLid,1)
	wait(3)
	get_character(tmpLid).moveto(tmpLX+1,tmpLY)
	get_character(tmpLid).animation = get_character(tmpLid).animation_overfatigue
	get_character(tmpLid).direction = 6
	wait(3)
	get_character(tmpLid).set_npc("UniqueLisa")
	get_character(tmpLid).npc.stat.set_stat("health",1)
	get_character(tmpLid).npc.refresh
		tmpQ1 = [3].include?($story_stats["RecQuestLisa"])
		tmpQ2 = $story_stats["UniqueCharUniqueLisa"] != -1
		tmpQ3 = $game_party.has_item?($data_items[31])
		tmpQ4 = $game_party.item_number($data_items[30]) >=5
		get_character(tmpLid).call_balloon(28,-1) if tmpQ1 && tmpQ2 && (tmpQ3 || tmpQ4)
	$game_player.moveto(tmpLX,tmpLY)
	get_character($game_player.get_companion_id(0)).moveto($game_player.x+1,$game_player.y+3) if $game_player.get_companion_id(0)
	get_character($game_player.get_companion_id(1)).moveto($game_player.x+2,$game_player.y+3) if $game_player.get_companion_id(1)
	$game_player.direction = 6
	$game_player.actor.remove_combat_state
	$game_player.actor.actor_changeMapForceUpdate
	call_msg("CompLisa:Lisa/LisaAbomHev_Clear1")
	portrait_hide
chcg_background_color(0,0,0,255,-7)
call_msg("CompLisa:Lisa/LisaAbomHev_HealNoItem")
call_msg("CompLisa:Lisa/LisaAbomHev_Clear2")
call_msg("CompLisa:Lisa/LisaAbomHev_Clear3")
set_this_event_force_page(7)
portrait_hide
