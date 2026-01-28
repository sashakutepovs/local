
$story_stats["OverMapEvent_name"] = "_Good_NoerHomeless"
$story_stats["OverMapEvent_enemy"] = 0
$story_stats["StepStoryCount"] = 0
sneak_result = overmap_event_sneak_check(0,false)
call_msg("OvermapEvents:World/ThingHappen_begin")
SndLib.sound_MaleWarriorSpot(100)
chcg_background_color(0,0,0,255,-15) if @chcg_background_color
call_msg("OvermapEvents:World/ThingHappen_who_Good_NoerHomeless")

if $game_player.actor.stat["RaceRecord"] == "TrueDeepone"
	return load_script("Data/HCGframes/encounter/-LonaIsTrueDeepone.rb")
end

loop_is_over = 0
tmpOptions_Leave_able= true
tmpOptions_Observe_able= true
tmpOptions_Talk_able= true
	until loop_is_over ==1
		$story_stats["OverMapEvent_saw"] ==0 ? SndLib.sound_MaleWarriorQuestion(100) : SndLib.sound_MaleWarriorSpot(100)
		call_msg("OvermapEvents:World/ThingHappen#{sneak_result}")
		call_msg("OvermapEvents:World/ThingHappen_who_Good_NoerHomeless_SneakFailed") if sneak_result == "_SneakFailed"
		
		tmpOptions_Leave	= true
		tmpOptions_Observe	= true
		tmpOptions_Talk		= true
		
		tmpPicked = ""
		tmpQuestList = []
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Leave"]			,"Options_Leave"]			 if tmpOptions_Leave		&& tmpOptions_Leave_able
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Observe"]		,"Options_Observe"]			 if tmpOptions_Observe		&& tmpOptions_Observe_able
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Talk"]			,"Options_Talk"]			 if tmpOptions_Talk			&& tmpOptions_Talk_able
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
					call_msg("OvermapEvents:Lona/Options_sneakpass_JustLeave")
					loop_is_over =1
					
			when "Options_Observe"
					tmpOptions_Observe_able = false
					call_msg("OvermapEvents:World/ThingHappen_who_unknow_NoerHomeless_CheckWin")
					
			when "Options_Talk"
					tmpOptions_Talk_able = false
					$story_stats["OverMapEvent_saw"] =1
					call_msg("OvermapEvents:World/ThingHappen_who_Good_NoerHomeless_SneakFailed")
					
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

