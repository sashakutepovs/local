$story_stats["OverMapEvent_name"] = "_good_SosGiver"
$story_stats["OverMapEvent_enemy"] = rand(2)
$story_stats["StepStoryCount"] = 0
sneak_result = overmap_event_sneak_check(0,false)
call_msg("OvermapEvents:World/ThingHappen_begin")
SndLib.sound_MaleWarriorSpot(80)
chcg_background_color(0,0,0,255,-15) if @chcg_background_color
call_msg("OvermapEvents:World/ThingHappen_who_unknow_PPLsos")
call_msg("OvermapEvents:World/ThingHappen#{sneak_result}")

hidden_event = [
				[70,"CommonMobs.rb"]
				]
sos_type = 		[
				"QuestGiverConvoyRefugee",
				"QuestGiverConvoyNoer"
				]
sos_pickup = sos_type.sample
$story_stats["OverMapEvent_SosName"] = "#{sos_pickup}"
loop_is_over = 0
tmpOptions_Leave_able= true
tmpOptions_Observe_able= true
tmpOptions_Talk_able= true
tmpOptions_Hide_able= true
tmpTrueDeepone = $game_player.actor.stat["RaceRecord"] == "TrueDeepone"
	until loop_is_over ==1
		SndLib.sound_HumanFemaleLost(80,rand(10)+80)
		$game_player.actor.sta > 0 && $story_stats["OverMapEvent_saw"] ==1 ? tmpOptions_Hide = true : tmpOptions_Hide = false
		$game_player.actor.sta > 0 ? tmpOptions_Leave = true : tmpOptions_Leave = false
		$game_player.actor.sta > 0 ? tmpOptions_Observe = true : tmpOptions_Observe = false
		$game_player.actor.sta > 0 ? tmpOptions_Talk = true : tmpOptions_Talk = false
		tmpPicked = ""
		tmpQuestList = []
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Leave"]			,"Options_Leave"]			 if tmpOptions_Leave		&& tmpOptions_Leave_able
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Observe"]		,"Options_Observe"]			 if tmpOptions_Observe		&& tmpOptions_Observe_able	&& !tmpTrueDeepone
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Talk"]			,"Options_Talk"]			 if tmpOptions_Talk			&& tmpOptions_Talk_able		&& !tmpTrueDeepone
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Hide"]			,"Options_Hide"]			 if tmpOptions_Hide 		&& tmpOptions_Hide_able		&& !tmpTrueDeepone
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
			when "Options_Leave"
					if $story_stats["OverMapEvent_enemy"] == 1 && sneak_result == "_SneakFailed"
						call_msg("OvermapEvents:World/Ambush_begin")
						return overmap_random_event_trigger(hidden_event,true)
					else
						call_msg("OvermapEvents:Lona/Options_sneakpass_JustLeave")
						loop_is_over =1
					end
					
			when "Options_Observe"
					tmpOptions_Observe_able = false
					check_result = overmap_event_sneak_check(10)
					$game_player.actor.sta -= 2
					if $story_stats["OverMapEvent_enemy"] == 1
						call_msg("OvermapEvents:World/ThingHappen_who_unknow_PPLsos_ChkBad")	if check_result == "_SneakWin"
						call_msg("OvermapEvents:World/ThingHappen_who_unknow_PPLsos_ChkUnknow")		if check_result == "_SneakFailed"
					else
						call_msg("OvermapEvents:World/ThingHappen_who_unknow_PPLsos_ChkGood")	if check_result == "_SneakWin"
						call_msg("OvermapEvents:World/ThingHappen_who_unknow_PPLsos_ChkUnknow")		if check_result == "_SneakFailed"
					end
					
			when "Options_Talk"
					tmpOptions_Talk_able = false
					$story_stats["OverMapEvent_saw"] =1
					call_msg("OvermapEvents:World/ThingHappen_SneakFailed")
					if $story_stats["OverMapEvent_enemy"] == 1
						call_msg("OvermapEvents:World/Ambush_begin")
						return overmap_random_event_trigger(hidden_event,true,"OpenCamp")
					elsif $game_player.actor.morality_lona <10
						call_msg("OvermapEvents:World/ThingHappen_who_unknow_PPLsos_ComLowMorality")
					else
						call_msg("OvermapEvents:World/ThingHappen_who_unknow_PPLsos_ComGood")
					end
					
			when "Options_Hide"
					tmpOptions_Hide_able = false
					tmpOptions_Leave_able = true
					tmpOptions_Escape_able = true
					#overmap_event_running_check(50)
					$game_player.actor.sta -= 10
					$story_stats["OverMapEvent_saw"] =0
					call_msg("OvermapEvents:World/Check_Hide")
					
			when "Options_Approach"
					if $story_stats["OverMapEvent_enemy"] ==1
						call_msg("OvermapEvents:World/Ambush_begin")
						return overmap_random_event_trigger(hidden_event,true,"OpenCamp")
					else
						$story_stats["RegionMap_Background"] = "OpenCamp"
						enter_tag_map = 1
						loop_is_over =1
					end
					
			when "Options_Kyaaah"
					$story_stats["OverMapEvent_saw"] =1
					$game_player.actor.sta = -99 
					call_msg("OvermapEvents:Lona/OvermapSlip")
					if $story_stats["OverMapEvent_enemy"] ==1
						call_msg("OvermapEvents:World/Ambush_begin")
						return overmap_random_event_trigger(hidden_event,true,"OpenCamp")
					else
						$story_stats["RegionMap_Background"] = "OpenCamp"
						enter_tag_map = 1
						loop_is_over =1
					end
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
$game_temp.choice = -1

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

