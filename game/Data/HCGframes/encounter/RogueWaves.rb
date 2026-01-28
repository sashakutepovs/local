
$story_stats["OverMapEvent_name"] = "_bad_RogueWaves"
$story_stats["OverMapEvent_enemy"] = 1
$story_stats["StepStoryCount"] = 0
#sneak_result = overmap_event_sneak_check(5,false)
call_msg("OvermapEvents:World/ThingHappen_begin")
SndLib.HeavySeaWave(80,200)
chcg_background_color(0,0,0,255,-15) if @chcg_background_color
call_msg("OvermapEvents:World/ThingHappen_who_bad_RougeWave")

loop_is_over = 0
struggleTimes = 0
struggleNeed = 3
struggleStaNeed = [15 -($game_player.actor.combat_trait/5) ,7].max
	until loop_is_over ==1
		SndLib.HeavySeaWave
		$game_player.actor.sta > 0 ? tmpOptions_Escape = true : tmpOptions_Escape = false
		$game_player.actor.sta > 0 ? tmpOptions_Struggle = true : tmpOptions_Struggle = false
		tmpPicked = ""
		tmpQuestList = []
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_GetHelp"]		,"Options_GetHelp"]		 if $game_player.with_companion
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Escape"]		,"Options_Escape"]			 if struggleTimes >= struggleNeed
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Struggle"]		,"Options_Struggle"]		 if tmpOptions_Struggle && struggleTimes < struggleNeed
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
			when "Options_GetHelp"
					call_msg("OvermapEvents:Lona/Options_FollowerHelp")
					call_msg("OvermapEvents:Lona/Options_sneakpass_JustLeave")
					loop_is_over = 1
			when "Options_Escape"
					$game_player.actor.sta -= struggleStaNeed
					call_msg("OvermapEvents:Lona/Options_sneakpass_JustLeave")
					loop_is_over = 1
					
			when "Options_Struggle"
					struggleTimes += 1
					running_result = overmap_event_running_check(20)
					$game_player.actor.sta -= 10
					if struggleTimes < struggleNeed
						call_msg("OvermapEvents:Lona/Options_StruggleLoop")
					else
						call_msg("OvermapEvents:Lona/Options_StruggleWin")
					end
			when "Options_Kyaaah"
					$story_stats["OverMapEvent_saw"] =1
					$game_player.actor.sta = -99
					call_msg("OvermapEvents:Lona/OvermapSlipDrowning")
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
	tarPointName = ["NoerDockOut","SeaEscPT0","SeaEscPT1","SeaEscPT2"].sample
	tmpX,tmpY = $game_map.get_storypoint(tarPointName)
	tmpX1,tmpY1 = $game_map.get_storypoint("DesertIsland1")
	portrait_hide
	if rand(100) > 70 #[true,false].sample
		chcg_background_color(0,0,0,0,7)
			portrait_off
			$game_player.moveto(tmpX1,tmpY1)
		chcg_background_color(0,0,0,255,-7)
			change_map_captured_enter_tag("DesertIsland1")
			rape_loop_drop_item(false,false)
			$story_stats["LastOverMapX"] = tmpX
			$story_stats["LastOverMapY"] = tmpY
	else
		chcg_background_color(0,0,0,0,7)
			portrait_off
			$game_player.moveto(tmpX,tmpY)
			$game_player.actor.sta -= 100
		chcg_background_color(0,0,0,255,-7)
		change_map_enter_region
	end
else
	$story_stats["WildDangerous"] =0
	$story_stats["OverMapEvent_name"] =0
	$story_stats["OverMapEvent_saw"] =0
	$story_stats["OverMapEvent_enemy"] =0
	$story_stats["RegionMap_Background"] = 0
end

