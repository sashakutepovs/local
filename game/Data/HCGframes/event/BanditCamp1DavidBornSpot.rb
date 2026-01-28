
tmpDvId=$game_map.get_storypoint("UniqueDavidBorn")[2]
get_character(tmpDvId).turn_toward_character($game_player)
call_msg("CompDavidBorn:DavidBorn/CampSpot1")
call_msg("CompDavidBorn:DavidBorn/CampSpot3")

if $story_stats["RecQuestDavidBorn"] == 0
$story_stats["RecQuestDavidBorn"] = 1
call_msg("CompDavidBorn:DavidBorn/Unknow")
call_msg("TagMapBanditCamp1:DavidBorn/Unknow")
cam_center(0)
end


$game_player.actor.wisdom_trait >= 20 ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
call_msg("CompDavidBorn:DavidBorn/CampSpot4_opt")
case $game_temp.choice
	when -1,0
		call_msg("CompDavidBorn:DavidBorn/CampSpot4_failed")
	when 1
		call_msg("CompDavidBorn:DavidBorn/CampSpot4_win")
		portrait_hide
		chcg_background_color(0,0,0,0,7)
				cam_center(0)
				$story_stats["RecQuestDavidBorn"] = 2
				get_character(tmpDvId).delete
		chcg_background_color(0,0,0,255,-7)
		call_msg("CompDavidBorn:DavidBorn/CampSpot4_win2")
end

cam_center(0)
portrait_hide
$story_stats["HiddenOPT1"] = "0" 
$game_temp.choice = -1


