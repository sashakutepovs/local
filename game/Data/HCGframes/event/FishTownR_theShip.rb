if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if $game_player.actor.sta <= 0
	call_msg("TagMapFishTown:RsideShip/begin_NoSta")
	return eventPlayEnd
end
return if $story_stats["Captured"] != 1

tmpBuildLVL = get_character(0).summon_data[:buildLVL]
if tmpBuildLVL > 0
	$game_party.item_number("ItemMhWoodenClub") >= 1 ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
	$game_party.item_number("ItemMhWoodenClub") >= 2 ? $story_stats["HiddenOPT2"] = "1" : $story_stats["HiddenOPT2"] = "0"
	$game_party.item_number("ItemMhWoodenClub") >= 3 ? $story_stats["HiddenOPT3"] = "1" : $story_stats["HiddenOPT3"] = "0"
	$game_temp.choice = -1
	call_msg("TagMapFishTown:RsideShip/begin_opt") #[算了,1<r=HiddenOPT1>,2<r=HiddenOPT2>,3<r=HiddenOPT3>]
	case $game_temp.choice
		when 1 ; get_character(0).summon_data[:buildLVL] -= $game_temp.choice ; $game_player.actor.sta -= 3 ; tmpDoBuild = true
				
		when 2 ; get_character(0).summon_data[:buildLVL] -= $game_temp.choice ; $game_player.actor.sta -= 6 ; tmpDoBuild = true
				
		when 3 ; get_character(0).summon_data[:buildLVL] -= $game_temp.choice ; $game_player.actor.sta -= 9 ; tmpDoBuild = true
				
	end
	
	if tmpDoBuild
	chcg_background_color(0,0,0,0,7)
		3.times{
		SndLib.WoodenBuild
		wait(60)
		}
	chcg_background_color(0,0,0,255,-7)
		optain_lose_item("ItemMhWoodenClub",$game_temp.choice)
		tmpBuildLVL = get_character(0).summon_data[:buildLVL]
		if tmpBuildLVL <= 0
			set_this_event_force_page(1)
			call_msg("TagMapFishTown:RsideShip/begin_win")
		elsif tmpBuildLVL < 6
			set_this_event_force_page(2)
			call_msg("TagMapFishTown:RsideShip/begin_tired")
		else
			call_msg("TagMapFishTown:RsideShip/begin_tired")
		end
	end
end

$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT2"] = "0"
$story_stats["HiddenOPT3"] = "0"
eventPlayEnd
