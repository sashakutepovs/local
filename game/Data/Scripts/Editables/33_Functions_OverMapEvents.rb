

#417個人化延伸批次
#主要為中斷器的新功能
module GIM_ADDON


def overmap_event_EnterMap_check
	if $story_stats["WildDangerous"] >=50
		check="_danger"
	elsif $story_stats["WildDangerous"] >=20
		check="_peace"
	else
		check="_peaceful"
	end
	check
end

def overmap_gen_WildDangerous
	$story_stats["Setup_Hardcore"] >= 1 ? tmpHcMode = 1 : tmpHcMode = 0
	$story_stats["WildDangerous"] =rand(100) + ($story_stats["WorldDifficulty"]/2) + (25*tmpHcMode)
	$story_stats["WildDangerous"] *=0.8 if $game_date.day?
	$story_stats["WildDangerous"] *=1.2 if $game_date.night?
	p "WildDangerous = #{$story_stats["WildDangerous"]}"
end

def overmap_event_EnterMap(customData=nil)
	#overmap_roll_capturedXY
	#TODO 環境危險係數  RAND一個基本變數 當環境危險係數高於基本變數時 且玩家處於 REGION MAP 則NAP後出現敵人
	#TODO 基本變數為玩家的3*SURVIVAL+RAND(100)基本變數
	$game_portraits.lprt.hide
	$game_portraits.rprt.hide
	chcg_background_color(0,0,0,180)
	#overmap_gen_WildDangerous
	call_msg("OvermapEvents:World/Region#{$game_player.region_id}")
	#overmap_threatended = $game_map.overmap_threatended?
	#overmap_threatended ? tmp_Observe_Able = false : tmp_Observe_Able = true
	#overmap_threatended ? tmp_RemoveTracks_Able = false : tmp_RemoveTracks_Able = true
	#overmap_threatended ? tmp_Kyaaah_Able = false : tmp_Kyaaah_Able = true 
	#overmap_threatended ? tmp_Enter_Able = false : tmp_Enter_Able = true 
	tmp_Observe_Able = true
	tmp_RemoveTracks_Able = true
	tmp_Kyaaah_Able = true 
	tmp_Enter_Able = true 
	
		
		
	tgtOnRegionMapSpawnRace = nil   # CONTROLLER IN region_map_wildness_nap_stats_create_race_list
	$game_map.npcs.each{|event|
		next unless event.npc.is_a?(Game_OvermapChar)
		next if event.erased?
		next if event.deleted?
		#p "#{event.summon_data[:OnRegionMapSpawnRace]} id=>#{event.id} x=>#{event.x} y=>#{event.y}" if event.summon_data[:OnRegionMapSpawnRace]
		next unless event.npc.target
		next unless event.npc.alert_level >= 1
		next unless event.summon_data
		next unless event.summon_data[:OnRegionMapSpawnRace]
		tgtOnRegionMapSpawnRace = event.summon_data[:OnRegionMapSpawnRace]
		p "found active encounter threat ev=>#{tgtOnRegionMapSpawnRace} id=>#{event.id} x=>#{event.x} y=>#{event.y}"
	}
	$story_stats["WildDangerous"] += 100+rand(100)+$story_stats["WorldDifficulty"] if tgtOnRegionMapSpawnRace
	
	loop_is_over = 0
	until loop_is_over ==1
		tmpPicked = ""
		tmpQuestList = []
		tmpQuestList << [$game_text["OvermapEvents:World/Region_option_Cancel"]			,"Region_option_Cancel"]
		tmpQuestList << [$game_text["OvermapEvents:World/Region_option_Relax"]			,"Region_option_Relax"]			if $game_player.actor.report_relax_able
		tmpQuestList << [$game_text["OvermapEvents:World/Region_option_Observe"]		,"Region_option_Observe"]		if $game_player.actor.sta > 0 && tmp_Observe_Able
		tmpQuestList << [$game_text["OvermapEvents:World/Region_option_RemoveTracks"]	,"Region_option_RemoveTracks"]	if $game_player.actor.sta > 0 && tmp_RemoveTracks_Able
		tmpQuestList << [$game_text["OvermapEvents:World/Region_option_Enter"]			,"Region_option_Enter"]			if tmp_Enter_Able
		tmpQuestList << [$game_text["OvermapEvents:World/Region_option_Kyaaah"]			,"Region_option_Kyaaah"]		if tmp_Kyaaah_Able
		cmd_sheet = tmpQuestList
		cmd_text =""
		for i in 0...cmd_sheet.length
			cmd_text.concat(cmd_sheet[i].first+",")
		end
		$game_player.actor.prtmood("confused")
		call_msg("#{$game_text["OvermapEvents:World/Region_option_start"]}\\optB[#{cmd_text}]")
		
		$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
		$game_temp.choice = -1
	
		case tmpPicked
			when "Region_option_Cancel",false 
				loop_is_over =1
				
			when "Region_option_Relax"
				loop_is_over =1
				$story_stats["OverMapEvent_DateCount"] += 10
				$game_player.handle_on_move_overmap(true)
				$game_player.finish_turn
				$game_player.overmap_relax
			
			when "Region_option_Observe"
				$game_player.actor.sta -= 1
				check_result = overmap_event_EnterMap_check
				call_msg("OvermapEvents:World/Region_option_check#{check_result}")
			
			when "Region_option_RemoveTracks"
				#erase_result = overmap_event_EnterMap_erase
				$game_player.actor.sta -= 5
				call_msg("OvermapEvents:World/Region_option_erase_win#{rand(2)}")
				$story_stats["WildDangerous"] -= 10+ (2*$game_player.actor.survival_trait)
			
			when "Region_option_Enter"
				loop_is_over =1
				enter_tag_map = 1
			
			when "Region_option_Kyaaah"
				tmp_Kyaaah_Able = false
				$story_stats["WildDangerous"] = 999
				$game_player.actor.sta = -99 
				call_msg("OvermapEvents:Lona/OvermapSlip")
				enter_tag_map = 1
				loop_is_over =1
		end

	end
	$cg.erase
	chcg_background_color_off
	if enter_tag_map == 1
		$game_player.actor.sta -= $game_player.deduct_lona_sta_overmap*0.3
		if tgtOnRegionMapSpawnRace
			$story_stats["OnRegionMapEncounterRace"] = tgtOnRegionMapSpawnRace
		end
		if customData
			$story_stats["OverMapEvent_name"] = "Custom"
			$story_stats["OverMapEvent_SosName"] = customData
		end
		
		change_map_enter_region
	else
		$story_stats["WildDangerous"] =0
	end
end


############################################# OVER MAP EVENTS ################################################
############################################# OVER MAP EVENTS ################################################
############################################# OVER MAP EVENTS ################################################
############################################# OVER MAP EVENTS ################################################
def overmap_event_faction    #TODO 將事件的好壞 做出以世界難度為基礎的變異體
	case $story_stats["OverMapEvent_enemy"]
	when 0
		check = rand(100)+$story_stats["WorldDifficulty"]
		case check 
		when 0..20		; check = "good"
		when 21..70		; check = "unknow"
		else 			; check = "bad"
		end
		if check == "unknow" && $story_stats["OverMapEvent_enemy"] ==0
		worldDIff = rand(100) + $story_stats["WorldDifficulty"]
		worldDIff_vs = rand(130) + $game_player.actor.survival
		$story_stats["OverMapEvent_enemy"] = 1 if worldDIff_vs >= worldDIff
		end
		check
	when 1
		check_bad = rand(100)+$story_stats["WorldDifficulty"]
		case check_bad
		when 0..50;			check_bad = "unknow"
							$story_stats["OverMapEvent_enemy"] =1
		else;				check_bad = "bad"
							$story_stats["OverMapEvent_enemy"] =1
		end
		check_bad
	end
	
end
#############################################事件列表################################################
#############################################事件列表################################################
#############################################事件列表################################################
#############################################事件列表################################################
def overmap_event_bad_roster
	p "overmap_event_bad_roster"
	event_roll=rand(3)+1
	case event_roll
	when 1 ; $story_stats["OverMapEvent_name"]="_bad_OrkindCamp"
	when 2 ; $story_stats["OverMapEvent_name"]="_bad_Bandits"
	when 3 ; $story_stats["OverMapEvent_name"]="_bad_BanditsCiv"
	end
	$story_stats["OverMapEvent_enemy"] =1
	$story_stats["OverMapEvent_name"]
end

def overmap_event_good_roster
	p "overmap_event_good_roster"
	event_roll=1
	case event_roll
	when 1 ; $story_stats["OverMapEvent_name"]="_good_Merchant"
	end
	$story_stats["OverMapEvent_name"]
end

def overmap_event_unknow_roster
	p "overmap_event_unknow_roster"
	event_roll=rand(3)+1
	case event_roll
	when 1 ; $story_stats["OverMapEvent_name"]="_unknow_HumanGuard"
	when 2 ; $story_stats["OverMapEvent_name"]="_unknow_PPLsos"
	when 3 ; $story_stats["OverMapEvent_name"]="_unknow_UnknowCamp"
	end
	$story_stats["OverMapEvent_name"]
end
################################################################################################
def overmap_event_wisdom_check(diff=0,textPlay=true)
	temp_event_check = rand(100) + $story_stats["WorldDifficulty"] + diff
	temp_mc_wisdom= ($game_player.actor.sta/2) + (2*$game_player.actor.wisdom)
	temp_mc_wisdom >= temp_event_check ? temp_vs_result = 1 : temp_vs_result = 0
	call_msg("\\narr #{temp_mc_wisdom.round} VS #{temp_event_check.round}") if textPlay
	temp_vs_result
end

################################################################################################
################################################################################################
################################################################################################
################################################################################################

def overmap_event_sneak_check(diff=0,textPlay=true)
	if $story_stats["OverMapEvent_enemy"] == 0
		temp_event_scoutcraft = rand(100) - (diff + $game_player.actor.scoutcraft_trait)
	else
		temp_event_scoutcraft = rand(100) + (diff + $story_stats["WorldDifficulty"])
	end
	temp_mc_scoutcraft = ($game_player.actor.sta/2) + $game_player.actor.scoutcraft_trait
	#p temp_mc_scoutcraft
	#p temp_event_scoutcraft
	temp_mc_scoutcraft >= temp_event_scoutcraft ? $story_stats["OverMapEvent_saw"] =0 : $story_stats["OverMapEvent_saw"] =1
	call_msg("\\narr #{temp_mc_scoutcraft.round} VS #{temp_event_scoutcraft.round}") if textPlay
	case $story_stats["OverMapEvent_saw"]
	when 0 ; check="_SneakWin"
	when 1 ; check="_SneakFailed"
	end
	check
end

def overmap_event_running_check(diff=0,textPlay=true)
	temp_event_check = rand(100) + $story_stats["WorldDifficulty"]
	temp_mc_running = $game_player.actor.sta
	temp_mc_running-=diff
	temp_mc_running >= temp_event_check ? $story_stats["OverMapEvent_saw"] =0 : $story_stats["OverMapEvent_saw"] =1
	call_msg("\\narr #{temp_mc_running.round} VS #{temp_event_check.round}") if textPlay
	case $story_stats["OverMapEvent_saw"]
		when 0 ; check="_RunningWin"
		when 1 ; check="_RunningFailed"
	end
end

def overmap_event_observation_check(textPlay=true)
	temp_event_check = rand(100) + $story_stats["WorldDifficulty"]
	temp_mc_wisdom= rand(70) + (3*($game_player.actor.wisdom+$game_player.actor.survival))
	temp_mc_wisdom >= temp_event_check ? temp_vs_result =1 : temp_vs_result =0
	
	call_msg("\\narr #{temp_mc_wisdom.round} VS #{temp_event_check.round}") if textPlay
	if temp_vs_result ==1
		case $story_stats["OverMapEvent_enemy"]
		when 0 ; check="_ChkGood"
		when 1 ; check="_ChkBad"
		end
	else
		check="_ChkUnknow"
	end
	check
end



###########################################################################################
end #GIM_ADDON

