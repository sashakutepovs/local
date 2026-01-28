return if $story_stats["UniqueCharUniqueMilo"] == -1
return if $story_stats["UniqueCharUniqueTeller"] == -1
return if $story_stats["UniqueCharUniqueHappyMerchant"] == -1
return if $story_stats["RecQuestTellerThatDoorSucka"] != 1

if $story_stats["RecQuestTellerThatDoorSucka"] == 1
	tmpSadJewX,tmpSadJewY,tmpSadJewID = $game_map.get_storypoint("SadJew")
	cam_follow(tmpSadJewID,0)
	portrait_hide
	chcg_background_color(0,0,0,255,-7)
		portrait_off
		call_msg("CompTeller:GoldenBarHev/SadJew0")
		portrait_hide
	chcg_background_color(0,0,0,0,7)
	portrait_off
	cam_center(0)
	$story_stats["RecQuestTellerThatDoorSucka"] = 2
end