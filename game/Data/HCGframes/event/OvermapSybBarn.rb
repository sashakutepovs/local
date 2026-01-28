call_msg("TagMapSybBarn:ThisMap/OmEnter")
case $game_temp.choice
	when 1
		if $story_stats["QuProgSybBarn"] == 1
			$game_player.actor.scoutcraft_trait >= 10 ? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
			call_msg("TagMapSybBarn:QuProgSybBarn1/EnterQuestMode0")
			call_msg("TagMapSybBarn:QuProgSybBarn1/EnterQuestMode1_OPT") #[旁邊看著,讓我試試<r=HiddenOPT0>]
			case $game_temp.choice
				when 0 #WAIT
					$story_stats["QuProgSybBarn"] = 2
					call_msg("TagMapSybBarn:QuProgSybBarn1/EnterQuestMode1_WAIT")
				when 1 #SCU
					$story_stats["QuProgSybBarn"] = 3
					call_msg("TagMapSybBarn:QuProgSybBarn1/EnterQuestMode1_SCU")
			end
			portrait_hide
			wait(20)
			portrait_off
			$cg.erase
			$game_player.direction= 2
			change_map_enter_tag("SybBarn")
		else
			$game_player.direction= 2
			change_map_enter_tag("SybBarn")
		end
end
$story_stats["HiddenOPT0"] = "0"
eventPlayEnd