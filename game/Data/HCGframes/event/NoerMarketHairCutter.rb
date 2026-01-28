if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if $game_player.player_slave?
	call_msg("TagMapNoerMarket:HairCutter/Slave")
	return eventPlayEnd
end

call_msg("TagMapNoerMarket:HairCutter/Welcome#{rand(2)}")
manual_barters("NoerMarketHairCutter")


if $game_party.has_item_type("SurgeryCoupon")
	call_msg("TagMapNoerMarket:HairCutter/DyePicked")
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			tmpTarColor = $game_party.item_has_common_tag_and_report("DyeHairColor")
			$game_player.actor.record_HairColor = tmpTarColor#.to_i
			#4.times{
				SndLib.waterBath
				$game_player.refresh_chs
				wait(90)
			#}
			$game_player.apply_color_palette
		chcg_background_color(0,0,0,255,-7)
		$game_party.lost_item_type("SurgeryCoupon")
	call_msg("TagMapNoerMarket:HairCutter/DyeEnd")
end
$story_stats["HiddenOPT1"] = "0" 
eventPlayEnd
