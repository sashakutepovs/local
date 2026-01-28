
$story_stats["OverMapEvent_name"] = "_bad_FishPPL"
$story_stats["OverMapEvent_enemy"] = 1
$story_stats["StepStoryCount"] = 0
sneak_result = overmap_event_sneak_check(0,false)
call_msg("OvermapEvents:World/ThingHappen_begin")
SndLib.FishkindSmSpot(100)
chcg_background_color(0,0,0,255,-15) if @chcg_background_color
call_msg("OvermapEvents:World/ThingHappen_who_bad_FishPPL")
call_msg("OvermapEvents:World/ThingHappen#{sneak_result}")
if sneak_result == "_SneakFailed"
	call_msg("OvermapEvents:World/ThingHappen_who_bad_FishPPL_SneakFailed")
end

if $game_player.actor.stat["RaceRecord"] == "TrueDeepone"
	return load_script("Data/HCGframes/encounter/-LonaIsTrueDeepone.rb")
end

loop_is_over = 0
tmpOptions_Leave_able= true
tmpOptions_Escape_able= true
tmpOptions_Talk_able= true
tmpOptions_Bluff_able= true
tmpOptions_Hide_able= true
tmpSlave = ($game_player.player_slave? || $game_player.actor.weak >= 30)
tmpFishDudeInGroup = $game_player.record_companion_name_back == "CompFishShaman" || $game_player.record_companion_name_front == "CompFishGuard"
	until loop_is_over ==1
		$story_stats["OverMapEvent_saw"] == 0 ? SndLib.FishkindSmHurt(100) : SndLib.FishkindSmSpot(100)
		($game_player.actor.sta > 0 && $story_stats["OverMapEvent_saw"] ==0) || !tmpSlave ? tmpOptions_Leave = true : tmpOptions_Leave = false
		$game_player.actor.sta > 0 && $story_stats["OverMapEvent_saw"] ==1 ? tmpOptions_Hide = true : tmpOptions_Hide = false
		$game_player.actor.sta > 0 && $story_stats["OverMapEvent_saw"] ==1 ? tmpOptions_Escape = true : tmpOptions_Escape = false
		$game_player.actor.sta > 0 && tmpFishDudeInGroup == true ? tmpOptions_Talk = true : tmpOptions_Talk = false
		$game_player.actor.sta > 0 && $game_player.actor.weak < 25 ? tmpOptions_Bluff = true : tmpOptions_Bluff = false
		tmpPicked = ""
		tmpQuestList = []
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Leave"]			,"Options_Leave"]			 if tmpOptions_Leave		&& tmpOptions_Leave_able
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Escape"]		,"Options_Escape"]			 if tmpOptions_Escape		&& tmpOptions_Escape_able
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Talk"]			,"Options_Talk"]			 if tmpOptions_Talk			&& tmpOptions_Talk_able
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Bluff"]			,"Options_Bluff"]			 if tmpOptions_Bluff		&& tmpOptions_Bluff_able
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Hide"]			,"Options_Hide"]			 if tmpOptions_Hide 		&& tmpOptions_Hide_able
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Approach"]		,"Options_Approach"]		
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Kyaaah"]		,"Options_Kyaaah"]			
				cmd_sheet = tmpQuestList
				cmd_text =""
				for i in 0...cmd_sheet.length
					cmd_text.concat(cmd_sheet[i].first+",")
					p cmd_text
				end
				$game_player.actor.prtmood("confused")
				call_msg("#{$game_text["OvermapEvents:Lona/Options"]}\\optD[#{cmd_text}]")
		
				$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
				$game_temp.choice = -1
		
		
		case tmpPicked
			when "Options_Escape"
					tmpOptions_Escape_able = false
					running_result = overmap_event_running_check(60)
					$game_player.actor.sta -= 2
					call_msg("OvermapEvents:Lona/Options_sneakpass#{running_result}")
					$story_stats["OverMapEvent_saw"] =1 if running_result=="_RunningFailed"
					loop_is_over =1 if running_result=="_RunningWin"
					
			when "Options_Leave"
					if !tmpSlave
						call_msg("OvermapEvents:World/ThingHappen_who_bad_FishPPL_NotSlave") if $story_stats["OverMapEvent_saw"] == 1
						break
					else
						tmpOptions_Leave_able = false
						sneak_result = overmap_event_sneak_check
						$game_player.actor.sta -= 2
						call_msg("OvermapEvents:Lona/Options_sneakpass#{sneak_result}")
						$story_stats["OverMapEvent_saw"] =1 if sneak_result=="_SneakFailed"
						loop_is_over =1 if sneak_result=="_SneakWin"
					end
					
			when "Options_Talk"
					tmpOptions_Talk_able = false
					loop_is_over =1
					call_msg("OvermapEvents:World/ThingHappen_who_bad_FishPPL_ComGood")
					
			when "Options_Bluff"
					tmpOptions_Bluff_able = false
					$story_stats["OverMapEvent_saw"] =1
					call_msg("OvermapEvents:World/ThingHappen_SneakFailed")
					call_msg("OvermapEvents:Lona/Options_Talk_begin")
					if overmap_event_wisdom_check(30) == 1
						loop_is_over =1
						call_msg("OvermapEvents:World/ThingHappen_who_bad_FishPPL_BluffGood")
					else
						call_msg("OvermapEvents:World/ThingHappen_who_bad_FishPPL_SneakFailed")
					end
					$game_player.actor.sta -= 2
					
					
			when "Options_Hide"
					tmpOptions_Hide_able = false
					tmpOptions_Leave_able = true
					tmpOptions_Escape_able = true
					#overmap_event_running_check(50)
					$game_player.actor.sta -= 10
					$story_stats["OverMapEvent_saw"] =0
					call_msg("OvermapEvents:World/Check_Hide")
					
			when "Options_Approach"
					enter_tag_map = 1
					loop_is_over =1
					
			when "Options_Kyaaah"
					$story_stats["OverMapEvent_saw"] =1
					$game_player.actor.sta = -99 
					call_msg("OvermapEvents:Lona/OvermapSlip")
					enter_tag_map = 1
					loop_is_over =1
		end
	end
$cg.erase
portrait_hide
chcg_background_color_off
#todo 建構個事件獨立之RB
#下列三筆資料 在TAG MAP鐘用AUTO BEGIN 還原
#todo add OverMapEvent_race
p "OverMapEvent_name    #{$story_stats["OverMapEvent_name"]}"
p "OverMapEvent_saw     #{$story_stats["OverMapEvent_saw"]}"
p "OverMapEvent_enemy   #{$story_stats["OverMapEvent_enemy"]}"
#收尾 關閉複寫
	
	

if enter_tag_map == 1
#overmap_gen_WildDangerous
p "WildDangerous = #{$story_stats["WildDangerous"]}"
change_map_enter_region
else
$story_stats["WildDangerous"] =0
$story_stats["OverMapEvent_name"] =0
$story_stats["OverMapEvent_saw"] =0
$story_stats["OverMapEvent_enemy"] =0
$story_stats["RegionMap_Background"] = 0
end

