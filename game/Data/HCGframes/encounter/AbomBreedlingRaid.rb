
$story_stats["OverMapEvent_name"] = "_bad_AbomBreedlingRaid"
$story_stats["OverMapEvent_enemy"] = 1
$story_stats["StepStoryCount"] = 0

sneak_result = overmap_event_sneak_check(10,false)
call_msg("OvermapEvents:World/ThingHappen_begin")
SndLib.BreedlingSpot(100)
chcg_background_color(0,0,0,255,-15) if @chcg_background_color
call_msg("OvermapEvents:World/ThingHappen_who_bad_AbomBreedlingRaid")
call_msg("OvermapEvents:World/ThingHappen#{sneak_result}")

loop_is_over = 0
tmpOptions_Leave_able= true
tmpOptions_Escape_able= true
tmpOptions_Observe_able= true
tmpOptions_Hide_able= true
struggleStaNeed = [15 -($game_player.actor.combat_trait/5) ,7].max
	until loop_is_over ==1
		$story_stats["OverMapEvent_saw"] ==0  ? SndLib.BreedlingSpot(90) : SndLib.BreedlingAtk(90)
		$game_player.actor.sta > 0 && $story_stats["OverMapEvent_saw"] ==1 ? tmpOptions_Hide = true : tmpOptions_Hide = false
		$game_player.actor.sta > 0 && $story_stats["OverMapEvent_saw"] ==0 ? tmpOptions_Leave = true : tmpOptions_Leave = false
		$game_player.actor.sta > 0 && $story_stats["OverMapEvent_saw"] ==1 ? tmpOptions_Escape = true : tmpOptions_Escape = false
		$game_player.actor.sta > 0 ? tmpOptions_Observe = true : tmpOptions_Observe = false
		$game_player.actor.sta > 0 && $game_party.item_type_HowMany("Trap") >= 2 ? tmpOptions_Bomb = true : tmpOptions_Bomb = false
		tmpPicked = ""
		tmpQuestList = []
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Leave"]			,"Options_Leave"]			 if tmpOptions_Leave		&& tmpOptions_Leave_able
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Escape"]		,"Options_Escape"]			 if tmpOptions_Escape		&& tmpOptions_Escape_able
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Observe"]		,"Options_Observe"]			 if tmpOptions_Observe		&& tmpOptions_Observe_able
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Hide"]			,"Options_Hide"]			 if tmpOptions_Hide 		&& tmpOptions_Hide_able
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Bomb"]			,"Options_Bomb"]			 if tmpOptions_Bomb
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
					running_result = overmap_event_running_check(80)
					$game_player.actor.sta -= 2
					call_msg("OvermapEvents:Lona/Options_sneakpass#{running_result}")
					$story_stats["OverMapEvent_saw"] =1 if running_result=="_RunningFailed"
					loop_is_over =1 if running_result=="_RunningWin"
					
			when "Options_Leave"
					tmpOptions_Leave_able = false
					sneak_result = overmap_event_sneak_check(8)
					$game_player.actor.sta -= 2
					call_msg("OvermapEvents:Lona/Options_sneakpass#{sneak_result}")
					$story_stats["OverMapEvent_saw"] =1 if sneak_result=="_SneakFailed"
					loop_is_over =1 if sneak_result=="_SneakWin"
					
			when "Options_Observe"
					tmpOptions_Observe_able = false
					if overmap_event_wisdom_check(15) == 1
						$game_player.actor.sta -= 2
						call_msg("OvermapEvents:World/ThingHappen_who_bad_AbomSpider_CheckWin")
						loop_is_over =1
					else
						call_msg("OvermapEvents:World/Check_SneakFailed")
						SndLib.sound_WormCommonLoud(100)
						call_msg("OvermapEvents:World/ThingHappen_who_bad_AbomBreedlingRaid")
						call_msg("OvermapEvents:World/ThingHappen#{sneak_result}")
						$game_player.actor.sta -= 2
					end

			when "Options_Hide"
					tmpOptions_Hide_able = false
					tmpOptions_Leave_able = true
					tmpOptions_Escape_able = true
					#overmap_event_running_check(50)
					$game_player.actor.sta -= 10
					$story_stats["OverMapEvent_saw"] =0
					call_msg("OvermapEvents:World/Check_Hide")
					
			when "Options_Bomb"
					tmpOptions_Bomb = false
					$story_stats["OverMapEvent_saw"] =1
						SndLib.sound_explosion(95)
						lona_mood "p5defence"
						$game_map.interpreter.screen.start_shake(5,10,10)
						$game_portraits.rprt.shake
						wait(60)
						call_msg("OvermapEvents:World/ThingHappen_who_bad_AbomManager_ComGood")
						2.times{$game_party.decrease_item_type("Trap",1)}
						loop_is_over =1

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

