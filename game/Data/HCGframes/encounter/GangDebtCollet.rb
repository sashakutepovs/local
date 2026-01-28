if !$game_map.interpreter.check_GangDebtCollet
	return
end
$story_stats["OverMapEvent_name"] = "_bad_GangDebtCollet"
$story_stats["OverMapEvent_enemy"] = 1
$story_stats["StepStoryCount"] = 0

sneak_result = overmap_event_sneak_check(0,false)
call_msg("OvermapEvents:World/ThingHappen_begin")
SndLib.sound_MaleWarriorSpot(100)
chcg_background_color(0,0,0,255,-15) if @chcg_background_color
call_msg("OvermapEvents:World/ThingHappen_who_bad_GangDebtCollet")
call_msg("OvermapEvents:World/ThingHappen#{sneak_result}")

if $game_player.actor.stat["RaceRecord"] == "TrueDeepone"
	return load_script("Data/HCGframes/encounter/-LonaIsTrueDeepone.rb")
end
$story_stats["HiddenOPT0"] = (1000*(1+$story_stats["WorldDifficulty"]*0.02)).round #debt hunter fee 1000~3000
loop_is_over = 0
tmpOptions_Leave_able= true
tmpOptions_Escape_able= true
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
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Talk"]			,"Options_Talk"]			 if tmpOptions_Talk			&& tmpOptions_Talk_able
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Hide"]			,"Options_Hide"]			 if tmpOptions_Hide 		&& tmpOptions_Hide_able
		tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Approach"]		,"Options_Approach"]
		tmpQuestList << [$game_text["commonNPC:commonNPC/opt_ex_Repayment"]	,"Repayment"]	if $story_stats["BackStreetArrearsPrincipal"]+$story_stats["BackStreetArrearsWhorePrincipal"] > 0
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
			when "Repayment"
						tmpOptions_Hide_able = false
						tmpOptions_Leave_able = false
						tmpOptions_Escape_able = false
						call_msg("OvermapEvents:World/ThingHappen_SneakFailed") if $story_stats["OverMapEvent_saw"] != 1
						$story_stats["OverMapEvent_saw"] = 1
						call_msg("TagMapNoerBackStreet:HappyTrader/Arrears_info_DebtHunter")
						$cg.erase
						SceneManager.goto(Scene_ItemStorage)
						SceneManager.scene.prepare(System_Settings::STORAGE_TEMP)
						call_msg("OvermapEvents:World/ThingHappen_who_bad_GangDebtCollet_ComRepayment_1")
						tmpTotal = $game_boxes.get_price(System_Settings::STORAGE_TEMP)
						$story_stats["HiddenOPT0"] -= tmpTotal
						$story_stats["BackStreetArrearsInterest"] -= $story_stats["HiddenOPT0"].abs if $story_stats["HiddenOPT0"] < 0
						$story_stats["BackStreetArrearsWhorePrincipal"] -= $story_stats["BackStreetArrearsInterest"].abs if $story_stats["BackStreetArrearsInterest"] < 0
						$story_stats["BackStreetArrearsWhorePrincipal"] =0 if $story_stats["BackStreetArrearsWhorePrincipal"] < 0
						$story_stats["HiddenOPT0"] =0 if $story_stats["HiddenOPT0"] < 0
						if $story_stats["BackStreetArrearsInterest"] < 0
							$story_stats["BackStreetArrearsPrincipal"] += $story_stats["BackStreetArrearsInterest"]
							$story_stats["BackStreetArrearsInterest"] = 0
							if $story_stats["BackStreetArrearsPrincipal"] < 0
								$story_stats["BackStreetArrearsPrincipal"]=0
								$story_stats["BackStreetArrearsInterest"] = 0
							end
						end
						$story_stats["BackStreetArrearsPrincipal"] += $story_stats["BackStreetArrearsInterest"] if $story_stats["BackStreetArrearsInterest"] < 0
						call_msg("TagMapNoerBackStreet:HappyTrader/Arrears_info_DebtHunter")
						$game_boxes.box(System_Settings::STORAGE_TEMP).clear
						if !$game_map.interpreter.check_GangDebtCollet && $story_stats["HiddenOPT0"] <= 0
							enter_tag_map = 0
							loop_is_over =1
							$game_map.npcs.each{|event| #clear all other debt hunter
								next unless event.summon_data
								next unless event.summon_data[:OnRegionMapSpawnRace] == "GangDebtCollet"
								next if event.deleted?
								event.overmap_char.erased = true
								event.over_trigger= nil
								event.opacity = 0
								event.erase
								event.delete
							}
							call_msg("OvermapEvents:World/ThingHappen_who_bad_GangDebtCollet_ComRepayment_pass")
						else
							call_msg("OvermapEvents:World/ThingHappen_who_bad_GangDebtCollet_ComRepayment_Failed")
						end
			when "Options_Escape"
					tmpOptions_Escape_able = false
					##################################### if CECILY and Grayrat in group
					if $game_player.record_companion_name_back == "UniqueCecily" && $game_player.record_companion_name_front == "UniqueGrayRat" #&& $game_player.record_companion_back_date != nil && $game_player.record_companion_back_date > $game_date.dateAmt
						$story_stats["HiddenOPT1"] = "0"
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
					sneak_result = overmap_event_sneak_check
					$game_player.actor.sta -= 2
					call_msg("OvermapEvents:Lona/Options_sneakpass#{sneak_result}")
					$story_stats["OverMapEvent_saw"] =1 if sneak_result=="_SneakFailed"
					loop_is_over =1 if sneak_result=="_SneakWin"
					
			when "Options_Talk"
					tmpOptions_Talk_able = false
					$story_stats["OverMapEvent_saw"] =1
					call_msg("OvermapEvents:World/ThingHappen_SneakFailed")
					if overmap_event_wisdom_check(30) == 1
						loop_is_over =1
						call_msg("OvermapEvents:World/ThingHappen_who_bad_GangDebtCollet_ComGood")
					else
						call_msg("OvermapEvents:World/ThingHappen_who_bad_GangDebtCollet_ComBad")
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
$game_temp.choice = -1
	
	

if enter_tag_map == 1
#overmap_gen_WildDangerous
p "WildDangerous = #{$story_stats["WildDangerous"]}"
change_map_enter_region
else
$story_stats["HiddenOPT0"] = "0"
$story_stats["WildDangerous"] =0
$story_stats["OverMapEvent_name"] =0
$story_stats["OverMapEvent_saw"] =0
$story_stats["OverMapEvent_enemy"] =0
$story_stats["RegionMap_Background"] = 0
end

