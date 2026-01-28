if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT1"] = "1" if $game_player.actor.wisdom >=20
get_character(0).animation = nil
get_character(0).call_balloon(1)
get_character(0).turn_toward_character(get_character(-1))


call_msg("TagMapNoerEliseGynecology:elise/night_basic_begin")

if $game_temp.choice == 0 
	call_msg("TagMapNoerEliseGynecology:elise/night_basic_begin_no")
	get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],600)
elsif $game_temp.choice == 1
	$game_player.direction = 8
	get_character(9).direction = 8
	call_msg("TagMapNoerEliseGynecology:elise/night_basic_begin_yes")

end


$game_portraits.lprt.hide
$game_portraits.rprt.hide
$story_stats["HiddenOPT1"] = "0" 
$game_temp.choice = -1
