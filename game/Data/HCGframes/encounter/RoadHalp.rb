
$story_stats["OverMapEvent_name"] = "_Bad_RoadHalp"
tmpEnemyList = Array.new
tmpEnemyList << ["CommonMobs","BanditMobs"].sample if [1,4,5,7,9,11,10,20,23].include?($game_player.region_id)
tmpEnemyList << "Orkind" if [1,4,5,7,9,11].include?($game_player.region_id)
tmpEnemyList << "Fishkind" if [13].include?($game_player.region_id)
tmpEnemyList << "AbomManager" if [2].include?($game_player.region_id)
if tmpEnemyList.empty?
	$story_stats["OverMapEvent_enemy"] = ["CommonMobs","BanditMobs"].sample
else
	$story_stats["OverMapEvent_enemy"] = tmpEnemyList.sample
end
$story_stats["StepStoryCount"] = 0
$story_stats["OverMapEvent_saw"] = 0
sneak_result = overmap_event_sneak_check(0,false)
call_msg("OvermapEvents:World/ThingHappen_begin")
SndLib.sound_HumanFemaleDed(100)
chcg_background_color(0,0,0,255,-15) if @chcg_background_color
call_msg("OvermapEvents:World/ThingHappen_who_Bad_RoadHalp")
call_msg("OvermapEvents:World/ThingHappen#{sneak_result}")
call_msg("OvermapEvents:World/ThingHappen_who_Bad_RoadHalp_SneakFailed") if sneak_result == "_SneakFailed"
hidden_event = [
				[50,"CommonMobs.rb"],
				[5,"NoerMissionary.rb"],
				[20,"OrkindGroup.rb"],
				[50,"BanditMobs.rb"],
				[20,"NoerGuards.rb"]
				]
loop_is_over = 0

if $game_player.actor.stat["RaceRecord"] == "TrueDeepone"
	return load_script("Data/HCGframes/encounter/-LonaIsTrueDeepone.rb")
end

tmpOptions_Leave_able= true
tmpOptions_Escape_able= true
tmpOptions_Observe_able= true
tmpOptions_Talk_able= true
tmpOptions_Hide_able= true
tmpTrueDeepone = $game_player.actor.stat["RaceRecord"] == "TrueDeepone"
	until loop_is_over ==1
		SndLib.sound_HumanFemaleDed(100)
		###############################################################################################################################
		case $story_stats["OverMapEvent_enemy"]
		when "BanditMobs", "CommonMobs"
			$story_stats["OverMapEvent_saw"] ==0 ? SndLib.sound_MaleWarriorQuestion(100) : SndLib.sound_MaleWarriorSpot(100)
		when "Orkind"
			$story_stats["OverMapEvent_saw"] ==0 ? SndLib.sound_goblin_idle(100) : SndLib.sound_goblin_roar(100)
		when "Fishkind"
			$story_stats["OverMapEvent_saw"] ==0 ? SndLib.FishkindSmQuestion(100) : SndLib.FishkindSmSpot(100)
		when "AbomManager"
			$story_stats["OverMapEvent_saw"] ==0 ? SndLib.sound_ManagerDed(100) : SndLib.sound_ManagerSpot(100)
		end 
		
		
		tmpOptions_Hide = $game_player.actor.sta > 0 && $story_stats["OverMapEvent_saw"] ==1
		tmpOptions_Leave = $game_player.actor.sta > 0 && $story_stats["OverMapEvent_saw"] ==0
		tmpOptions_Escape = $game_player.actor.sta > 0 && $story_stats["OverMapEvent_saw"] ==1
		tmpOptions_Talk = $game_player.actor.sta > 0
		tmpOptions_Observe = $game_player.actor.sta > 0
		
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
					##################################### if CECILY and Grayrat in group
					if $game_player.record_companion_name_back == "UniqueCecily" && $game_player.record_companion_name_front == "UniqueGrayRat"
						tmpOptions_Leave_able= false
						tmpOptions_Escape_able= false
						tmpOptions_Hide_able= false
						call_msg("CompCecily:Cecily/BanditMobs_run")
						$story_stats["OverMapEvent_saw"] =1
						call_msg("OvermapEvents:World/ThingHappen_SneakFailed")
						portrait_hide
						
					#####################################  BASIC
					else
					running_result = overmap_event_running_check(60)
					$game_player.actor.sta -= 2
					call_msg("OvermapEvents:Lona/Options_sneakpass#{running_result}")
					$story_stats["OverMapEvent_saw"] =1 if running_result=="_RunningFailed"
					loop_is_over =1 if running_result=="_RunningWin"
					end
					
			when "Options_Leave"
					tmpOptions_Leave_able = false
					sneak_result = overmap_event_sneak_check
					$game_player.actor.sta -= 2
					call_msg("OvermapEvents:Lona/Options_sneakpass#{sneak_result}")
					$story_stats["OverMapEvent_saw"] =1 if sneak_result=="_SneakFailed"
					loop_is_over =1 if sneak_result=="_SneakWin"
					
					
			when "Options_Observe"
					tmpOptions_Observe_able = false
					event_reroll = overmap_event_sneak_check(30)
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
					call_msg("OvermapEvents:World/ThingHappen_who_Bad_RoadHalp_SneakFailed")
					
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

