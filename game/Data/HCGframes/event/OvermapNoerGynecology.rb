tmpQ1 = [2,3,4,15,16].include?($story_stats["RecQuestElise"])
tmpQ2 = $game_player.record_companion_name_ext == "CompExtUniqueElise"
if tmpQ2 && $story_stats["RecQuestElise"] == 17
	overmap_event_EnterMap
elsif tmpQ1 || tmpQ2
	overmap_event_EnterMap
	#SndLib.sys_buzzer
	#$game_map.popup(0,"CompElise:tar/Failed_enter",0,0)
else
	call_msg("TagMapNoerEliseGynecology:EliseGynecology/OvermapEnter")
	case $game_temp.choice
		when 1
		if $game_date.night? && $story_stats["UniqueCharUniqueElise"] != -1
			call_msg("OvermapNoer:common/closed")
		elsif $story_stats["UniqueCharUniqueElise"] == -1
			$game_player.direction = 8
			change_map_enter_tag("EliseGynecology")
		elsif $game_date.day?
			$game_player.direction = 8
			change_map_enter_tag("EliseGynecology")
		end
	end
end


$game_portraits.lprt.hide
$game_portraits.rprt.hide
$game_temp.choice = -1