tmpCecilyID=$game_player.get_followerID(0)
tmpGrayRarID=$game_player.get_followerID(1)
tmpCs1X,tmpCs1Y,tmpCs1ID=$game_map.get_storypoint("CountEndSpawn1")
tmpQ1 = $story_stats["UniqueCharUniqueCecily"] == -1
tmpQ2 = $story_stats["UniqueCharUniqueGrayRat"] == -1

#假設已完成
if $story_stats["QuProgSaveCecily"] == 10 && (!tmpQ1 || !tmpQ2)
	change_map_tag_sub("CecilyHijack1",0,6,false)
	$game_player.jump_reverse if [-1,0].include?($game_temp.choice)
	
	#完成 但被發現
elsif get_character($game_map.get_storypoint("MapCont")[2]).summon_data[:Found] == true && (!tmpQ1 || !tmpQ2)
	#將目標送到 9 10 11
	if [9,10,11,12].include?(get_character(tmpCecilyID).region_id) && [9,10,11,12].include?(get_character(tmpGrayRarID).region_id)
		$story_stats["QuProgSaveCecily"] = 10
		chcg_background_color(0,0,0,0,7)
			tmpCharCount = 0
			$game_map.npcs.each{|event|
				next unless event.summon_data
				next unless event.summon_data[:Friendly]
				next if event.npc.action_state == :death
				event.moveto(tmpCs1X-2,tmpCs1Y-1+tmpCharCount)
				event.direction = 6
				tmpCharCount+=1
				
			}
			$game_player.moveto(tmpCs1X,tmpCs1Y)
			$game_player.direction = 4
		chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapCecilyHijack:ReachedEnd/Success_Spoted")
		$game_player.direction = 6
	#木標不再
	else
		call_msg("TagMapCecilyHijack:ReachedEnd/FailedWarning")
		$game_player.jump_reverse
	end
#完成 沒被發現
elsif get_character($game_map.get_storypoint("MapCont")[2]).summon_data[:Found] == false && (!tmpQ1 || !tmpQ2)
	$story_stats["QuProgSaveCecily"] = 10
	chcg_background_color(0,0,0,0,7)
		tmpCharCount = 0
		$game_map.npcs.each{|event|
			next unless event.summon_data
			next unless event.summon_data[:Friendly]
			next if event.npc.action_state == :death
			event.moveto(tmpCs1X-2,tmpCs1Y-1+tmpCharCount)
			event.direction = 6
			tmpCharCount+=1
		}
			$game_player.moveto(tmpCs1X,tmpCs1Y)
			$game_player.direction = 4
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapCecilyHijack:ReachedEnd/Success_NonSpot")
	$game_player.direction = 6
#失敗
else
	change_map_region_map_exit(true)
end

cam_center(0)
portrait_hide