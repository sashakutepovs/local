$game_temp.choice = -1
tmpCeX,tmpCeY,tmpCeID=$game_map.get_storypoint("CeTrapped")
call_msg("TagMapCargoSaveCecily:CecilyRape/stage1")
case $game_temp.choice
when 0 ;cam_center(0)
		get_character(tmpCeID).call_balloon(28,-1)
		return eventPlayEnd
when 1 ;
end

$game_temp.choice = -1
call_msg("TagMapCargoSaveCecily:CecilyRape/stage2")
case $game_temp.choice
when 0 ;cam_center(0)
		get_character(tmpCeID).call_balloon(28,-1)
		return eventPlayEnd
when 1 ;
end

$game_temp.choice = -1
call_msg("TagMapCargoSaveCecily:CecilyRape/stage3")
case $game_temp.choice
when 0 ;cam_center(0)
		get_character(tmpCeID).call_balloon(28,-1)
		return eventPlayEnd
when 1 ;
		$story_stats["RecQuestSaveCecilyRaped"] =1
		call_StoryHevent("RecHevCargoSaveCecilyRape","HevCargoSaveCecilyRape")
	
end #case

get_character(tmpCeID).call_balloon(28,-1)
eventPlayEnd