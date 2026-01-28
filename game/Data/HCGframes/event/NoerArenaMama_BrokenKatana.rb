get_character(0).call_balloon(0)
GabeSDK.getAchievement("DefeatBossMama")
$game_player.animation = $game_player.animation_mc_pick_up
$game_player.actor.mood = 100
optain_item("ItemQuestMhKatana",1)
tmpRightArenaEID = $game_map.get_storypoint("RightArenaE")[2]
tmpLeftArenaEID = $game_map.get_storypoint("LeftArenaE")[2]
$game_map.events[tmpRightArenaEID].call_balloon(28,-1)
$game_map.events[tmpLeftArenaEID].call_balloon(28,-1)

if get_character(0).summon_data[:user] && !get_character(0).summon_data[:user].deleted?
	tmpCoconaX,tmpCoconaY,tmpCoconaID = $game_map.get_storypoint("Cocona")
	tmpRightArenaEX,tmpRightArenaEY,tmpRightArenaEID = $game_map.get_storypoint("RightArenaE")
	tmpLeftArenaEX,tmpLeftArenaEY,tmpLeftArenaEID = $game_map.get_storypoint("LeftArenaE")
	mamaID = get_character(0).summon_data[:user].id
	get_character(tmpCoconaID).npc_story_mode(true)
	wait(45)
	$game_player.turn_toward_character(get_character(tmpCoconaID))
	call_msg("CompCocona:BrokenKatana/0")
	get_character(tmpCoconaID).jump_to(get_character(tmpCoconaID).x,get_character(tmpCoconaID).y)
	call_msg("CompCocona:BrokenKatana/0_1")
	get_character(tmpCoconaID).jump_to(get_character(tmpCoconaID).x,get_character(tmpCoconaID).y)
	call_msg("CompCocona:BrokenKatana/0_2")
	call_msg("CompCocona:BrokenKatana/0_3")
	get_character(mamaID).call_balloon(6)
	get_character(tmpCoconaID).jump_to(get_character(tmpCoconaID).x,get_character(tmpCoconaID).y)
	cam_follow(mamaID,0)
	call_msg("CompCocona:BrokenKatana/1")
	portrait_hide
	get_character(mamaID).call_balloon(8)
	wait(60)
	$game_player.turn_toward_character(get_character(mamaID))
	cam_follow(mamaID,0)
	get_character(mamaID).call_balloon(8)
	call_msg("CompCocona:BrokenKatana/2")
	#cam_follow(mamaID,0)
	#get_character(mamaID).call_balloon(8)
	call_msg("CompCocona:BrokenKatana/3")
	cam_follow(mamaID,0)
	get_character(mamaID).call_balloon(8)
	call_msg("CompCocona:BrokenKatana/4")
	get_character(tmpCoconaID).npc_story_mode(false)
end
get_character(tmpRightArenaEID).call_balloon(28,-1)
get_character(tmpLeftArenaEID).call_balloon(28,-1)
eventPlayEnd
get_character(0).delete

