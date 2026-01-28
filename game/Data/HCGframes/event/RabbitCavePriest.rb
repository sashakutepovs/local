if $story_stats["UniqueCharUniqueKillerRabbit"] == -1
	call_msg("TagMapRabbitCave:priest/win")
else
	get_character(0).call_balloon(0)
	priestX,priestY,priestID=$game_map.get_storypoint("Priest")
	hwX,hwY,hwID=$game_map.get_storypoint("HolyWater")
	$game_party.has_item?($data_items[135]) && get_character(hwID).switch1_id == 0 ? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
	call_msg("TagMapRabbitCave:priest/begin0") #\optB[沒事,關於,給予聖水<r=HiddenOPT0>]
	case $game_temp.choice
		when 1
			call_msg("TagMapRabbitCave:priest/about")
		when 2
			call_msg("TagMapRabbitCave:priest/HolyWater0")
			optain_lose_item($data_items[135],1)
			call_msg("TagMapRabbitCave:priest/HolyWater1")
			
			chcg_background_color(0,0,0,0,7)
				$game_player.moveto(hwX-1,hwY)
				$game_player.direction = 6
				get_character(priestID).moveto(hwX,hwY-1)
				get_character(priestID).direction = 2
				set_event_force_page(hwID,1)
				get_character(hwID).switch1_id = 1
			chcg_background_color(0,0,0,255,-7)
			get_character(hwID).trigger = -1
			
			call_msg("TagMapRabbitCave:priest/HolyWater2")
			
			chcg_background_color(0,0,0,0,7)
				get_character(priestID).moveto(priestX+1,priestY+1)
				get_character(priestID).direction = 6
			chcg_background_color(0,0,0,255,-7)
			
			call_msg("TagMapRabbitCave:priest/HolyWater3")
			cam_center(0)
			get_character(hwID).call_balloon(19,-1)
			
	end
end
$story_stats["HiddenOPT0"] = "0"
$game_temp.choice = -1
portrait_hide