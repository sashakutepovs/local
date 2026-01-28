
call_msg("commonEnding:Cocona/RecQuestCocona29_0")
call_msg("commonEnding:Cocona/RecQuestCocona29_1")
call_msg("commonEnding:Cocona/RecQuestCocona29_2")
portrait_hide


if $story_stats["RecQuestCoconaVagTaken"] >=3
	get_character(0).direction = 6
	get_character(0).call_balloon(8)
	wait(60)
	get_character(0).direction = 8
	get_character(0).call_balloon(8)
	wait(60)
	get_character(0).turn_toward_character($game_player)
	call_msg("commonEnding:Cocona/RecQuestCoconaVagTaken2_0")
	call_msg("commonEnding:Cocona/RecQuestCoconaVagTaken2_1")
	call_msg("commonEnding:Cocona/RecQuestCoconaVagTaken2_2")
	call_msg("commonEnding:Cocona/RecQuestCoconaVagTaken2_3")
	portrait_hide
end
get_character(0).direction = 8
get_character(0).call_balloon(8)
wait(60)
get_character(0).direction = 2
get_character(0).call_balloon(8)
wait(60)
get_character(0).turn_toward_character($game_player)
call_msg("commonEnding:Cocona/RecQuestCocona29_3")
call_msg("commonEnding:Cocona/RecQuestCocona29_4")

eventPlayEnd