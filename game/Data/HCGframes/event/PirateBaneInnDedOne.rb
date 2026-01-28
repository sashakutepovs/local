if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).call_balloon(0)

load_script("Data/HCGframes/event/CompDedOneCheckUniqueDialog.rb")


if $story_stats["RecQuestDedOne"] == 3
	$story_stats["RecQuestDedOne"] = 4
	call_msg("CompDedOne:DedOne/PirateBane_begin_k2")
elsif [4,5].include?($story_stats["RecQuestDedOne"])
	call_msg("CompDedOne:DedOne/PirateBane_begin_k3")
	$game_temp.choice = -2
	until [0,-1].include?($game_temp.choice)
		tmpSeaWitch = $story_stats["UniqueCharUniqueSeaWitch"] != -1 && $story_stats["RecQuestDedOne"] != 5
		tmpSeaWitch ? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
		call_msg("CompDedOne:DedOne/PirateBane_begin_k3_Opt") #[沒事,你是誰,藍皮膚<r=HiddenOPT0>]
		case $game_temp.choice
			when 1
				call_msg("CompDedOne:DedOne/PirateBane_begin_k3_Opt_who")
			when 2
				if $story_stats["RecQuestSeaWitch"] == 4
					call_msg("CompDedOne:DedOne/PirateBane_begin_k3_Opt_blue_Meet")
				else
					call_msg("CompDedOne:DedOne/PirateBane_begin_k3_Opt_blue_NonMeet")
				end
				$story_stats["RecQuestDedOne"] = 5
		end
	end
else
	$game_temp.choice = -2
	until [0,-1].include?($game_temp.choice)
		$story_stats["RecQuestDedOne"] != 5
		tmpSeaWitch ? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
		call_msg("CompDedOne:DedOne/PirateBane_begin_k3_Opt") #[沒事,你是誰,藍皮膚<r=HiddenOPT0>]
		case $game_temp.choice
			when 1
				call_msg("CompDedOne:DedOne/PirateBane_begin_k3_Opt_who")
		end
	end
end


$story_stats["HiddenOPT0"] = "0"
eventPlayEnd

tmpQ1 = $story_stats["RecQuestDedOne"] <= 4
tmpQ2 = $story_stats["UniqueCharUniqueSeaWitch"] != -1
return get_character(0).call_balloon(28,-1) if tmpQ1 && tmpQ2