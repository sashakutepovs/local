


#choose pass: normal pass or wis pass or sneak pass
call_msg("CompElise:FishResearch1/enter_view") if $story_stats["RecQuestElise"] == 12
call_msg("TagMapFishTownT:Top/OvermapEnter") #[算了,進入]
case $game_temp.choice
	when 0,-1
	when 1 #進入
		tmpQ2 = $story_stats["RecQuestElise"] == 15
		tmpQ3 =  $story_stats["UniqueCharUniqueElise"] != -1
		tmpQ0 = $story_stats["RecQuestElise"] == 12
		tmpQ1 = $game_player.record_companion_name_ext == "CompExtUniqueElise"
		if tmpQ2 && tmpQ3 #elise in group
			tmp_pass = 1
		elsif tmpQ0 && tmpQ1 #elise in group
			call_msg("CompElise:FishResearch1/enter_WithElise")
			tmp_pass = 1
			
		elsif $game_player.actor.stat["SlaveBrand"] == 1
			call_msg("TagMapFishTown:Gate/Enter_slave0")
			call_msg("TagMapFishTown:Gate/Enter_slave1")
			tmp_aggro = 1
			
			
		else #cant enter
			tmp_pass = 1
		end
end# case

if tmp_aggro == 1
#####################3333333 TODO
		call_msg("OvermapNoer:GateGuard/enter_failed#{talk_persona}")
		$story_stats["OverMapEvent_saw"] =1
		load_script("Data/HCGframes/encounter/FishPPL.rb")
end

eventPlayEnd
$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT2"] = "0"
if tmp_pass ==1
	portrait_hide
	$game_player.direction = 8
	change_map_enter_tag("FishTownT")
end