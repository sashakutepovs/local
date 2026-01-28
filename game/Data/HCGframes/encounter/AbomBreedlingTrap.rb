
$story_stats["OverMapEvent_name"] = "_bad_AbomBreedlingTrap"
$story_stats["OverMapEvent_enemy"] = 1
$story_stats["StepStoryCount"] = 0
sneak_result = overmap_event_sneak_check(5,false)
call_msg("OvermapEvents:World/ThingHappen_begin")
SndLib.BreedlingSpot(100)
chcg_background_color(0,0,0,255,-15) if @chcg_background_color
call_msg("OvermapEvents:World/ThingHappen_who_bad_AbomBreedlingTrap")

loop_is_over = 0
struggleTimes = 0
struggleNeed = 3
struggleStaNeed = [15 -($game_player.actor.combat_trait/5) ,7].max
	until loop_is_over ==1
		[true,false].sample ? SndLib.BreedlingSpot(90) : SndLib.BreedlingAtk(90)
		$game_player.actor.sta > 0 ? tmpOptions_Escape = true : tmpOptions_Escape = false
		$game_player.actor.sta > 0 ? tmpOptions_Struggle = true : tmpOptions_Struggle = false
		$game_player.actor.sta > 0 && $game_party.item_type_HowMany("Trap") >= 2 ? tmpOptions_Bomb = true : tmpOptions_Bomb = false
		tmpPicked = ""
		tmpQuestList = []
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Escape"]		,"Options_Escape"]			 if struggleTimes >= struggleNeed
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Struggle"]		,"Options_Struggle"]		 if tmpOptions_Struggle && struggleTimes < struggleNeed
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
	change_map_enter_tag("BreedlingEC1")
else
	$story_stats["WildDangerous"] =0
	$story_stats["OverMapEvent_name"] =0
	$story_stats["OverMapEvent_saw"] =0
	$story_stats["OverMapEvent_enemy"] =0
	$story_stats["RegionMap_Background"] = 0
end

