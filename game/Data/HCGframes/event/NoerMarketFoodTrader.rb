if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

get_character(0).call_balloon(0)
#Cocona出遊
if $story_stats["RecQuestCocona"] == 12 && get_character(0).summon_data[:cocona13start] == true && $game_player.record_companion_name_back == "UniqueCoconaMaid"
	tmpFollowerID=$game_player.get_followerID(0)
	tmpPtX,tmpPtY,tmpPtID=$game_map.get_storypoint("FoodTrader")
	tmpPriX,tmpPriY,tmpPriID=$game_map.get_storypoint("C12Priest")
	tmpCoconaX,tmpCoconaY,tmpCoconaID=$game_map.get_storypoint("C12Cocona")
	chcg_background_color(0,0,0,0,7)
		get_character(tmpFollowerID).set_this_companion_disband #delete cocona
		get_character(tmpCoconaID).opacity = 255
		get_character(tmpCoconaID).npc_story_mode(true)
		get_character(tmpCoconaID).flying = true
		get_character(tmpCoconaID).through = true
		get_character(tmpPtID).direction = 2
		$game_player.moveto(tmpPtX,tmpPtY+2)
		get_character(tmpCoconaID).moveto(tmpPtX+1,tmpPtY+2)
		get_character(tmpCoconaID).direction = 4
		$game_player.direction = 6
		get_character(tmpPriID).moveto(1,1)
		get_character(tmpPriID).opacity = 255
		get_character(tmpPriID).npc_story_mode(true)
		get_character(tmpPriID).flying = true
		get_character(tmpPriID).through = true
		get_character(0).moveto(tmpPtX,tmpPtY)
		get_character(0).direction = 2
	chcg_background_color(0,0,0,255,-7)
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food0")
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food0_1")
	$game_player.direction = 8
	optain_lose_item($data_items[122],1)
	portrait_off
	$game_player.call_balloon(8)
	get_character(tmpPtID).call_balloon(20)
	wait(60)
	$game_player.call_balloon(20)
	get_character(tmpPtID).call_balloon(8)
	wait(90)
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food1")
	portrait_hide
	$game_player.call_balloon(8)
	get_character(tmpPtID).call_balloon(20)
	wait(60)
	$game_player.call_balloon(20)
	get_character(tmpPtID).call_balloon(8)
	wait(60)
	get_character(tmpCoconaID).direction = 6
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food2")
	portrait_hide
	$game_player.call_balloon(8)
	get_character(tmpPtID).call_balloon(20)
	wait(60)
	$game_player.call_balloon(20)
	get_character(tmpPtID).call_balloon(8)
	wait(60)
	get_character(tmpCoconaID).direction = 2
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food3")
	portrait_hide
	cam_center(0)
	get_character(tmpPriID).moveto(tmpPtX+9,tmpPtY+3)
	get_character(tmpPriID).direction = 4 ; get_character(tmpPriID).move_forward_force
	wait(35)
	get_character(tmpPriID).direction = 4 ; get_character(tmpPriID).move_forward_force
	wait(35)
	get_character(tmpPriID).turn_random ; wait(10)
	get_character(tmpPriID).call_balloon(20)
	wait(90)
	get_character(tmpPriID).direction = 4 ; get_character(tmpPriID).move_forward_force
	wait(35)
	get_character(tmpPriID).direction = 4 ; get_character(tmpPriID).move_forward_force
	wait(35)
	$game_player.call_balloon(8) ; get_character(tmpPtID).call_balloon(20)
	get_character(tmpPriID).turn_random ; wait(10)
	get_character(tmpPriID).call_balloon(20)
	wait(90)
	get_character(tmpPriID).direction = 4 ; get_character(tmpPriID).move_forward_force
	wait(35)
	get_character(tmpPriID).direction = 4 ; get_character(tmpPriID).move_forward_force
	wait(35)
	get_character(tmpPriID).turn_random ; wait(10)
	get_character(tmpCoconaID).turn_toward_character(get_character(tmpPriID))
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food4")
	portrait_hide
	$game_player.call_balloon(20) ; get_character(tmpPtID).call_balloon(8)
	wait(90)
	get_character(tmpCoconaID).call_balloon(8)
	get_character(tmpPriID).direction = 4 ; get_character(tmpPriID).move_forward_force
	wait(35)
	$game_player.call_balloon(8) ; get_character(tmpPtID).call_balloon(20)
	get_character(tmpPriID).direction = 4 ; get_character(tmpPriID).move_forward_force
	wait(35)
	get_character(tmpCoconaID).turn_toward_character($game_player)
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food5")
	portrait_hide
	$game_player.call_balloon(20) ; get_character(tmpPtID).call_balloon(8)
	get_character(tmpCoconaID).turn_toward_character(get_character(tmpPriID))
	get_character(tmpPriID).direction = 8 ; wait(10)
	get_character(tmpPriID).call_balloon(20)
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food5_1")
	get_character(tmpPriID).direction = 2
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food5_2")
	cam_center(0)
	get_character(tmpPriID).direction = 4 ; get_character(tmpPriID).move_forward_force
	wait(35)
	$game_player.call_balloon(8) ; get_character(tmpPtID).call_balloon(20)
	get_character(tmpCoconaID).call_balloon(8)
	get_character(tmpPriID).direction = 4 ; get_character(tmpPriID).move_forward_force
	wait(35)
	get_character(tmpPriID).turn_random ; wait(10)
	get_character(tmpCoconaID).turn_toward_character(get_character(tmpPriID))
	get_character(tmpPriID).call_balloon(20)
	$game_player.call_balloon(20) ; get_character(tmpPtID).call_balloon(8)
	wait(90)
	get_character(tmpCoconaID).turn_toward_character($game_player)
	get_character(tmpPriID).direction = 2
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food6")
	get_character(tmpPriID).direction = 4 ; get_character(tmpPriID).move_forward_force
	portrait_hide
	4.times{
		get_character(tmpPriID).direction = 4 ; get_character(tmpPriID).move_forward_force
		wait(35)
	}
	get_character(tmpPriID).direction = 2
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food7")
	portrait_hide
	2.times{
		get_character(tmpPriID).direction = 2 ; get_character(tmpPriID).move_forward_force
		wait(35)
	}
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food8")
	portrait_hide
	get_character(tmpPriID).turn_random
	get_character(tmpPriID).call_balloon(20) ; wait(10)
	get_character(tmpCoconaID).turn_toward_character(get_character(tmpPriID))
	get_character(tmpCoconaID).call_balloon(8)
	wait(90)
	$game_player.call_balloon(8) ; get_character(tmpPtID).call_balloon(20)
	get_character(tmpPriID).direction = 2 ; get_character(tmpPriID).move_forward_force
	wait(35)
	$game_player.call_balloon(20) ; get_character(tmpPtID).call_balloon(8)
	get_character(tmpPriID).direction = 2 ; get_character(tmpPriID).move_forward_force
	get_character(tmpCoconaID).direction = 2 ; get_character(tmpCoconaID).move_forward_force
	wait(35)
	6.times{
		get_character(tmpPriID).direction = 2 ; get_character(tmpPriID).move_forward_force
		get_character(tmpCoconaID).direction = 4 ; get_character(tmpCoconaID).move_forward_force
		wait(35)
	}
	$game_player.call_balloon(8) ; get_character(tmpPtID).call_balloon(20)
	
	5.times{
		get_character(tmpPriID).direction = 2 ; get_character(tmpPriID).move_forward_force
		get_character(tmpCoconaID).direction = 2 ; get_character(tmpCoconaID).move_forward_force
		wait(35)
	}
	$game_player.call_balloon(20) ; get_character(tmpPtID).call_balloon(8)
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		call_msg("CompCocona:Cocona/RecQuestCocona_12_food8_1")
		get_character(tmpCoconaID).delete
		get_character(tmpPriID).delete
	chcg_background_color(0,0,0,255,-7)
	$game_player.direction = 6
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food9")
	$game_player.direction = 4
	$game_player.call_balloon(8)
	wait(60)
	$game_player.direction = 6
	$game_player.call_balloon(8)
	wait(60)
	$game_player.direction = 2
	$game_player.call_balloon(8)
	wait(60)
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food10")
	$game_player.direction = 2
	$game_player.call_balloon(8)
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food11")
	$game_player.direction = 8
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food12")
	$game_player.direction = 6
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food12_1")
	$game_player.direction = 2
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food12_2")
	$game_player.direction = 4
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food12_3")
	$game_player.direction = 2
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food13")
	$game_player.actor.mood -= 200
	#cocona missing
	$story_stats["RecQuestCocona"] = 13
	
else
	call_msg("TagMapNoerMarket:FoodTrader/Welcome#{rand(3)}")
		manual_barters("NoerMarketFoodTrader")
end

eventPlayEnd
