tmpQ0 = $story_stats["RecQuestSewerSawGoblin"] != -2
tmpQ1 = $story_stats["UniqueCharUniqueGrayRat"] != -1
tmpQ2 = $story_stats["UniqueCharUniqueCecily"] != -1
tmpQ3 = $story_stats["RecQuestSaveCecily"] != -1
tmpQ4 = [1,2,3].include?($story_stats["QuProgSaveCecily"])
if !tmpQ0 && tmpQ1 && tmpQ2 && tmpQ3 && tmpQ4
 call_msg("TagMapCargoSaveCecily:Enter/Begin1")
 call_msg("TagMapCargoSaveCecily:Enter/Begin2")
 call_msg("common:Lona/Decide_optB")
 case $game_temp.choice
  when 1
	call_msg("TagMapCargoSaveCecily:Enter/Begin3")
	portrait_hide
	$cg.erase
	wait(1)
	change_map_enter_tag("CargoSaveCecily")
	$game_player.direction = 8
 end
else
 call_msg("TagMapCargoSaveCecily:thisMap/OvermapEnter") ; portrait_hide
 case $game_temp.choice
  when 1
    $game_player.direction= 8
    change_map_enter_tag("NoerWest13WH")
 end
end
