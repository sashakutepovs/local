if $game_map.threat
	SndLib.sys_ChangeMapFailed(80,80)
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
elsif $game_player.actor.sta <=0
	SndLib.sys_ChangeMapFailed(80,80)
	$game_map.popup(0,"QuickMsg:Lona/sta_too_low#{rand(2)}",0,0)
else
	get_character(0).call_balloon(0)
	tmpDialogCheck = $game_map.events.any?{|event|
		next if event[1].deleted?
		next if !event[1].summon_data
		event[1].summon_data[:Touched] == true
	}
	if !tmpDialogCheck
		$game_map.events.any?{|event|
			next if event[1].deleted?
			next if !event[1].summon_data
			event[1].summon_data[:Touched] = true
		}
		call_msg("TagMapRandOrkindCave:RecQuestNorthFL_Main3/FirstTouch")
		tmpCecDialog1 = $game_player.record_companion_name_back == "UniqueCecily" && follower_in_range?(0,7)
		tmpCecDialog2 = $game_player.record_companion_name_front == "UniqueGrayRat" && follower_in_range?(1,7)
		if tmpCecDialog1 && tmpCecDialog2
			tmpGPprevDIR = $game_player.direction
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				portrait_off
				tmpBurnDocX,tmpBurnDocY=$game_map.get_storypoint("BurnDoc")
				$game_player.direction = 8
				get_character($game_player.get_followerID(0)).direction = 8
				get_character($game_player.get_followerID(1))..direction = 8
				$game_player.moveto(tmpBurnDocX,tmpBurnDocY+1)
				get_character($game_player.get_followerID(0)).moveto(tmpBurnDocX+1,tmpBurnDocY+1)
				get_character($game_player.get_followerID(1)).moveto(tmpBurnDocX-1,tmpBurnDocY+1)
			chcg_background_color(0,0,0,255,-7)
			$game_player.turn_toward_character(get_character($game_player.get_followerID(0)))
			get_character($game_player.get_followerID(1)).turn_toward_character(get_character($game_player.get_followerID(0)))
			get_character($game_player.get_followerID(0)).direction = 8
			call_msg("TagMapRandOrkindCave:RecQuestNorthFL_Main3/Cecily0")
			portrait_hide
			get_character($game_player.get_followerID(0)).call_balloon(8)
			wait(60)
			$game_player.call_balloon(8)
			wait(60)
			call_msg("TagMapRandOrkindCave:RecQuestNorthFL_Main3/Cecily1")
			$game_player.direction = tmpGPprevDIR
		end
	end
	$game_player.animation = $game_player.animation_atk_mh
	$game_player.actor.sta -= 5
	tmpToB1X,tmpToB1Y,tmpToB1ID=$game_map.get_storypoint("ToB1")
	get_character(0).summon_data[:doc] =  false
	get_character(0).effects=["CutTreeFall",0,false,nil,nil,nil]
	get_character(0).trigger = -1
	get_character(0).npc_story_mode(true)
	SndLib.stoneCollapsed(80)
	SndLib.stoneCollapsed(80,40)
	
	tmpDocCount = $game_map.events.any?{|event|
		next if event[1].deleted?
		next if !event[1].summon_data
		event[1].summon_data[:doc] == true
	}
	if !tmpDocCount
		wait(90)
		p "RecQuestNorthFL_Main quest done 3"
		get_character(tmpToB1ID).call_balloon(0)
		$story_stats["RecQuestNorthFL_Main"] = 3
		call_msg("TagMapRandOrkindCave:RecQuestNorthFL_Main3/Done")
	end
	eventPlayEnd
end
