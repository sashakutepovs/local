
$story_stats["OverMapEvent_name"] = "_bad_CommonMobs"
$story_stats["OverMapEvent_enemy"] = 1
$story_stats["StepStoryCount"] = 0
points_needed = ((100+$story_stats["WorldDifficulty"])*(rand(10)+1))*10
points_needed = points_needed.round
sneak_result = overmap_event_sneak_check(0,false)
call_msg("OvermapEvents:World/ThingHappen_begin")
SndLib.sound_MaleWarriorSpot(100)
chcg_background_color(0,0,0,255,-15) if @chcg_background_color
call_msg("OvermapEvents:World/ThingHappen_who_bad_BanditsCiv")
call_msg("OvermapEvents:World/ThingHappen#{sneak_result}")

hidden_event = [
				[70,"BanditMobs.rb"],
				[30,"NoerGuards.rb"]
				]

if $game_player.actor.stat["RaceRecord"] == "TrueDeepone"
	return load_script("Data/HCGframes/encounter/-LonaIsTrueDeepone.rb")
end

loop_is_over = 0
tmpOptions_Leave_able= true
tmpOptions_Escape_able= true
tmpOptions_Observe_able= true
tmpOptions_Talk_able= true
tmpOptions_Hide_able= true
	until loop_is_over ==1
		$story_stats["OverMapEvent_saw"] ==0 ? SndLib.sound_MaleWarriorQuestion(100) : SndLib.sound_MaleWarriorSpot(100)
		$game_player.actor.sta > 0 && $story_stats["OverMapEvent_saw"] ==1 ? tmpOptions_Hide = true : tmpOptions_Hide = false
		$game_player.actor.sta > 0 && $story_stats["OverMapEvent_saw"] ==0 ? tmpOptions_Leave = true : tmpOptions_Leave = false
		$game_player.actor.sta > 0 && $story_stats["OverMapEvent_saw"] ==1 ? tmpOptions_Escape = true : tmpOptions_Escape = false
		$game_player.actor.sta > 0 ? tmpOptions_Talk = true : tmpOptions_Talk = false
		$game_player.actor.sta > 0 ? tmpOptions_Observe = true : tmpOptions_Observe = false
		tmpPicked = ""
		tmpQuestList = []
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Leave"]			,"Options_Leave"]			 if tmpOptions_Leave		&& tmpOptions_Leave_able
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Escape"]		,"Options_Escape"]			 if tmpOptions_Escape		&& tmpOptions_Escape_able
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Observe"]		,"Options_Observe"]			 if tmpOptions_Observe		&& tmpOptions_Observe_able
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Talk"]			,"Options_Talk"]			 if tmpOptions_Talk			&& tmpOptions_Talk_able
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
					running_result = overmap_event_running_check(10)
					$game_player.actor.sta -= 2
					call_msg("OvermapEvents:Lona/Options_sneakpass#{running_result}")
					$story_stats["OverMapEvent_saw"] =1 if running_result=="_RunningFailed"
					loop_is_over =1 if running_result=="_RunningWin"
					
			when "Options_Leave"
					tmpOptions_Leave_able = false
					sneak_result = overmap_event_sneak_check
					$game_player.actor.sta -= 2
					call_msg("OvermapEvents:Lona/Options_sneakpass#{sneak_result}")
					$story_stats["OverMapEvent_saw"] =1 if sneak_result=="_SneakFailed"
					loop_is_over =1 if sneak_result=="_SneakWin"
					
			when "Options_Observe"
					tmpOptions_Observe_able = false
					event_reroll = overmap_event_sneak_check(20)
					if event_reroll == "_SneakWin"
						call_msg("OvermapEvents:World/RerollEvent_begin")
						return overmap_random_event_trigger(hidden_event,true,nil)
					else
						call_msg("OvermapEvents:World/Check_SneakFailed")
						call_msg("OvermapEvents:World/ThingHappen#{event_reroll}")
					end
					$game_player.actor.sta -= 2
					
			when "Options_Talk"
					tmpOptions_Talk_able = false
					$story_stats["OverMapEvent_saw"] =1
					call_msg("OvermapEvents:World/ThingHappen_SneakFailed")
					call_msg("OvermapEvents:Lona/Options_Talk_begin")
					if overmap_event_wisdom_check(0) == 1
						call_msg("OvermapEvents:World/ThingHappen_who_bad_BanditsCiv_ComGood")
						loop_is_over =1
					else
						$game_message.add("#{$game_text["OvermapEvents:World/ThingHappen_who_bad_CommonMobs_ComBad1"]}#{points_needed}#{$game_text["OvermapEvents:World/ThingHappen_who_bad_CommonMobs_ComBad2"]}")
						$game_map.interpreter.wait_for_message
					end
					$game_player.actor.sta -= 2
					
			when "Options_Hide"
					tmpOptions_Hide_able = false
					tmpOptions_Leave_able = true
					tmpOptions_Escape_able = true
					overmap_event_running_check(50)
					$game_player.actor.sta -= 5
					$story_stats["OverMapEvent_saw"] =0
					call_msg("OvermapEvents:World/Check_Hide")
					
			when "Options_Approach"
					if $story_stats["OverMapEvent_saw"] ==1
						$game_message.add("#{$game_text["OvermapEvents:World/ThingHappen_who_bad_CommonMobs_ComBad1"]}#{points_needed}#{$game_text["OvermapEvents:World/ThingHappen_who_bad_CommonMobs_ComBad2"]}")
						$game_map.interpreter.wait_for_message
						$cg.erase
						SceneManager.goto(Scene_ItemStorage)
						SceneManager.scene.prepare(System_Settings::STORAGE_TEMP)
						wait(1)
						tmpPP = $game_boxes.get_price(System_Settings::STORAGE_TEMP)
						$game_boxes.box(System_Settings::STORAGE_TEMP).clear
						if tmpPP >= points_needed
						#if $game_boxes.get_storeTP <= 0
							$game_party.lose_gold($game_party.gold)
							call_msg("OvermapEvents:World/ThingHappen_who_bad_CommonMobs_ComBad_win")
							loop_is_over =1
						else
							call_msg("OvermapEvents:World/ThingHappen_who_bad_CommonMobs_ComBad_failed")
							enter_tag_map = 1
							loop_is_over =1
						end
					else
						enter_tag_map = 1
						loop_is_over =1
					end

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

