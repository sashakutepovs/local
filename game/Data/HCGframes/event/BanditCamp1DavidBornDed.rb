tmpDvId=$game_map.get_storypoint("UniqueDavidBorn")[2]
get_character(0).turn_toward_character($game_player)
call_msg("CompDavidBorn:DavidBorn/CampLost0") #\optD[誰理你,嚇?!]

case $game_temp.choice
	when -1,0
		call_msg("CompDavidBorn:DavidBorn/CampLost0_fqu")
		portrait_hide
		chcg_background_color(0,0,0,0,7)
				$story_stats["UniqueCharUniqueDavidBorn"] = -1
				cam_center(0)
				get_character(tmpDvId).delete
				SndLib.sound_combat_hit_gore
				wait(45)
				SndLib.sound_combat_hit_gore
				wait(45)
				SndLib.sound_combat_hit_gore
				wait(45)
				SndLib.sound_combat_hit_gore
				wait(45)
				SndLib.sound_MaleWarriorDed
				get_character(0).summon_data[:user].opacity = 255
				get_character(0).opacity = 0
		chcg_background_color(0,0,0,255,-7)
		optain_morality(20)
		wait(30)
		optain_exp(11000)
	when 1
		call_msg("CompDavidBorn:DavidBorn/CampLost0_okay")
		portrait_hide
		chcg_background_color(0,0,0,0,7)
				
				get_character(0).opacity = 0
				cam_center(0)
				$story_stats["RecQuestDavidBorn"] = 2
				get_character(tmpDvId).delete
		chcg_background_color(0,0,0,255,-7)
		call_msg("CompDavidBorn:DavidBorn/CampLost0_okay2")
	
end
cam_center(0)
portrait_hide
$game_temp.choice = -1
get_character(0).erase
