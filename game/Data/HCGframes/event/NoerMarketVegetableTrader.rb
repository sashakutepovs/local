if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).call_balloon(0)

#Cocona出遊
if $story_stats["RecQuestCocona"] == 12 && get_character(0).summon_data[:CoconaTalked] == false && $game_player.record_companion_name_back == "UniqueCoconaMaid"
	tmpCoconaID=$game_player.get_followerID(0)
	tmpPtX,tmpPtY,tmpPtID=$game_map.get_storypoint("VegetableTrader")
	chcg_background_color(0,0,0,0,7)
		get_character(tmpPtID).direction = 2
		$game_player.moveto(tmpPtX,tmpPtY+2)
		get_character(tmpCoconaID).moveto(tmpPtX-1,tmpPtY+2)
		$game_player.direction = 8
		get_character(tmpCoconaID).direction = 8
		call_msg("CompCocona:Cocona/RecQuestCocona_12_food8_1")
	chcg_background_color(0,0,0,255,-7)
	
	get_character(tmpPtID).summon_data[:CoconaTalked] = true
	call_msg("CompCocona:Cocona/RecQuestCocona_12_vegtable")
	tmpResult = $game_map.npcs.any?{
		|event|
		next unless event.summon_data
		next unless event.summon_data[:cocona12Qu]
		next if event.summon_data[:CoconaTalked] == true
		true
	}
	if !tmpResult
		tmpPtX,tmpPtY,tmpPtID=$game_map.get_storypoint("FoodTrader")
		get_character(tmpPtID).call_balloon(28,-1)
		get_character(tmpPtID).summon_data[:cocona13start] = true
	end
else

	manual_barters("CommonVegetableTrader")
end
eventPlayEnd
