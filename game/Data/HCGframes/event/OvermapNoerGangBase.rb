if $story_stats["QuProgSaveCecily"] == 17
	call_msg("CompCecily:NoerGangBase/enter")
	$cg.erase
end
call_msg("TagMapNoerGangBase:thisMap/OvermapEnter")
case $game_temp.choice
	when 1
		$game_player.direction = 8
		change_map_enter_tag("NoerGangBase")
end


$game_portraits.lprt.hide
$game_portraits.rprt.hide
$game_temp.choice = -1