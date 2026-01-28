$story_stats["OverMapEvent_name"] = "_bad_Vs_Refugee_Orkind"
$story_stats["OverMapEvent_enemy"] = 0 #dev
$story_stats["StepStoryCount"] = 0
call_msg("OvermapEvents:World/ThingVS_begin")
SndLib.sound_MaleWarriorDed(80)
SndLib.sound_goblin_roar(50)
chcg_background_color(0,0,0,255,-15) if @chcg_background_color
call_msg("OvermapEvents:World/ThingHappen_who_unknow_Vs_Refugee_Orkind")



hidden_event = [
				[70,"NFL_OrkindPlayGround.rb"],
				[70,"NFL_OrkindGroup.rb"],
				[10,"NFL_AbandonedCropses.rb"]
				]
loop_is_over = 0
tmpOptions_Observe_able= true
tmpOptions_Leave_able= true
	until loop_is_over ==1
		SndLib.sound_MaleWarriorDed(80)
		SndLib.sound_goblin_roar(50)
		tmpPicked = ""
		tmpQuestList = []
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Leave"]			,"Options_Leave"]			 if tmpOptions_Leave_able
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Observe"]		,"Options_Observe"]			 if tmpOptions_Observe_able
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
					tmpOptions_Leave_able = false
					loop_is_over =1
					call_msg("OvermapEvents:Lona/Options_sneakpass_JustLeave")
					
			when "Options_Observe"
					$game_player.actor.sta -= 2
					tmpOptions_Observe_able = false
					SndLib.sound_goblin_roar
					call_msg("OvermapEvents:World/Region_option_WatchThemDead")
					return overmap_random_event_trigger(hidden_event,true,["OrkindPlayGround","OrkindMessy"].sample)
					
			when "Options_Approach"
					SndLib.sound_goblin_roar(80)
					SndLib.sound_MaleWarriorDed(50)
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

