

#417個人化延伸批次
#主要為中斷器的新功能
module GIM_ADDON


	def moveto_teleport_point(point_name,tmpLightMode=nil,tmpDir=nil)
		$game_player.pathfinding = false
		if $game_map.threat && $story_stats["Setup_Hardcore"] >= 1
			SndLib.sys_buzzer
			$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
		else
			portrait_hide
			SndLib.sys_StepChangeMap
			Fiber.yield while $game_message.visible;screen.start_fadeout(30);wait(30)
			tmpShiftMode = Input.press?(:ALT)
			tmpFadeTimer = tmpShiftMode ? 10 : 30
			#SndLib.me_play("SE/Move",75,120+rand(31)) if !tmpShiftMode
			#SndLib.sound_equip_armor if tmpShiftMode
			st_id=$game_map.get_storypoint(point_name)[2]
			temp_tar = get_character(st_id)
			if tmpShiftMode
				cam_follow(st_id,0)
				tmpLightData = get_BG_EFX_data_Observe if tmpLightMode
			else
				player_group_goto(temp_tar.x,temp_tar.y)
				$game_player.direction = tmpDir if tmpDir
			end
			set_BG_EFX_data(tmpLightMode) if tmpLightMode
			Fiber.yield while $game_message.visible;screen.start_fadein(tmpFadeTimer);wait(tmpFadeTimer)#fade in
			if tmpShiftMode
				until !Input.press?(:ALT)
					wait(1)
				end
				Fiber.yield while $game_message.visible;screen.start_fadeout(tmpFadeTimer);wait(tmpFadeTimer)
				cam_center(0)
				SndLib.sound_equip_armor if tmpShiftMode
				set_BG_EFX_data(tmpLightData) if tmpLightMode
				Fiber.yield while $game_message.visible;screen.start_fadein(tmpFadeTimer);wait(tmpFadeTimer)#fade in
			end
		end
	end

	def moveto_teleport_xy(temp_x,temp_y)
		if $game_map.threat && $story_stats["Setup_Hardcore"] >= 1
			SndLib.sys_buzzer
			$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
		else
			SndLib.me_play("SE/Move",75,120+rand(31))
			Fiber.yield while $game_message.visible;screen.start_fadeout(30);wait(30)
			player_group_goto(temp_x,temp_y)
			Fiber.yield while $game_message.visible;screen.start_fadein(30);wait(30)#fade in
		end
	end
def enter_static_tag_map(event_id=nil,fadeout=false) #注意  僅在AUTOBEGIN中使用  請勿INIT
	event_id = $game_map.get_storypoint(event_id)[2] if event_id.is_a?(String)
	if $story_stats["TagSubTrans"] != 0
		x,y,tmpID=$game_map.get_storypoint($story_stats["TagSubTrans"])
		$game_player.moveto(x,y)
		$story_stats["TagSubTrans"] = 0
	elsif $story_stats["RapeLoop"] == 0 && $story_stats["Captured"] == 0 && $story_stats["ReRollHalfEvents"] ==1
		if event_id == nil
			x,y,tmpID=$game_map.get_storypoint("StartPoint") if event_id == nil
			x=get_character(tmpID).x
			y=get_character(tmpID).y
		else
			x = get_character(event_id).x
			y = get_character(event_id).y
		end
		$game_player.moveto(x,y)
	elsif $story_stats["Captured"] == 1 || $story_stats["RapeLoop"] == 1
		if event_id == nil
			x,y,tmpID=$game_map.get_storypoint("WakeUp")
			x=get_character(tmpID).x
			y=get_character(tmpID).y
		else
			x=get_character(event_id).x
			y=get_character(event_id).y
		end
		$game_player.moveto(x,y)
	end
	$story_stats["Kidnapping"] = 0
	$story_stats["OnRegionMap"] =0
	$story_stats["OverMapEvent_name"] =0
	$story_stats["OverMapEvent_saw"] =0
	$story_stats["OverMapEvent_enemy"] =0
	$story_stats["OnRegionMapSpawnRace"] = 0
	$story_stats["ReRollHalfEvents"] =0
	if $story_stats["TagSubForceDir"] != 0
		$game_player.direction = $story_stats["TagSubForceDir"]
		$story_stats["TagSubForceDir"] = 0
	end
	#$game_party.lose_gold($game_party.gold)
	$game_player.actor.remove_combat_state
	$game_player.actor.actor_changeMapForceUpdate
	$game_player.actor.set_action_state(:none,true)
	screen.start_tone_change(Tone.new(0,0,0,0),0)
	#Cache.clear
	Cache.clear_chs_material
	chcg_background_color(0,0,0,255,-7) if fadeout
end

def enter_static_region_map(fadeout=false) #注意  僅在AUTOBEGIN中使用  請勿INIT
	if $story_stats["ReRollHalfEvents"] == 1 || ($game_player.x == 1 && $game_player.y == 1)
		x,y = $game_map.get_storypoint("StartPoint")
		$game_player.moveto(x,y)
	end
	$story_stats["Kidnapping"] = 0
	$story_stats["OnRegionMap"] = $story_stats["OnRegionMap_Regid"] #改由HANDLE ON MOVE OVERMAP 搞定
	$story_stats["OverMapEvent_name"] =0
	$story_stats["OverMapEvent_saw"] =0
	$story_stats["OverMapEvent_enemy"] =0
	$story_stats["ReRollHalfEvents"] =0
	#$game_party.lose_gold($game_party.gold)
	$game_player.actor.remove_combat_state
	$game_player.actor.actor_changeMapForceUpdate
	$game_player.actor.set_action_state(:none,true)
	screen.start_tone_change(Tone.new(0,0,0,0),0)
	#Cache.clear
	Cache.clear_chs_material
	chcg_background_color(0,0,0,255,-7) if fadeout
end

def change_map_story_stats_fix(reset_stats = true)		#離開 以及換地圖時用
	$story_stats["RegionMap_RegionOuta"] = 0
	$story_stats["RegionMap_RegionInsa"] = 0
	$story_stats["RapeLoop"] = 0
	$story_stats["Captured"] = 0
	$story_stats["OnRegionMap"] =0
	$story_stats["OnRegionMapSpawnRace"] = 0
	$story_stats["Record_CapturedPregCheckPassed"] = 0
	$story_stats["CapturedStatic"] = 0
	$story_stats["LimitedNeedsSkill"] = 0
	$story_stats["LimitedNapSkill"] = 0
	$story_stats["Ending_MainCharacter"] = 0
	$story_stats["RapeLoopTorture"] = 0
	$story_stats["ReRollHalfEvents"] = 1			#地圖AUTORUN物件完成後設為0
	$story_stats["LonaCannotDie"] = 0
	$game_player.unset_all_saved_event
	$game_player.actor.map_loading_reset_stats if reset_stats
	$game_boxes.box(System_Settings::STORAGE_TEMP).clear
	$game_boxes.box(System_Settings::STORAGE_PLAYER_POT).clear
	$game_player.actor.remove_combat_state
	change_map_weather_cleaner
	whole_key_clearner #must be there or common sex keys remain between maps change
	$game_player.move_normal
	$game_player.call_balloon(0)
	SndLib.bg_stop
	#Audio.bgm_fade(500)
	#Audio.bgs_fade(500)
end

def change_map_captured_story_stats_fix(reset_stats = true)		#被綁架後換地圖時用
	$story_stats["RegionMap_RegionOuta"] = 0
	$story_stats["RegionMap_RegionInsa"] = 0
	$story_stats["Record_CapturedPregCheckPassed"] = 0
	$story_stats["OnRegionMap"] =0
	$story_stats["Captured"] = 1
	$story_stats["RapeLoop"] = 1
	$story_stats["CapturedStatic"] = 1
	$story_stats["LimitedNeedsSkill"] = 0
	$story_stats["LimitedNapSkill"] = 0
	$story_stats["ReRollHalfEvents"] = 1			#地圖AUTORUN物件完成後設為0
	$story_stats["LonaCannotDie"] = 0
	$game_player.unset_all_saved_event #clearn all fucker. and select box
	$game_player.actor.map_loading_reset_stats if reset_stats
	$game_player.actor.remove_combat_state
	$game_player.actor.actor_changeMapForceUpdate
	change_map_weather_cleaner
	whole_key_clearner #must be there or common sex keys remain between maps change
	$game_player.move_normal
	$game_player.call_balloon(0)
	SndLib.bg_stop
	#Audio.bgm_fade(500)
	#Audio.bgs_fade(500)
end

def change_map_leave_tag_map
	$game_date.expireTradeHashCheck
	$game_party.lose_gold($game_party.gold)
	$story_stats["OnRegionMapSpawnRace"] = 0
	$story_stats["RegionMap_Background"] = 0
	$story_stats["WildDangerous"] = 0
	$story_stats["OnRegionMapEncounterRace"] = 0
	$story_stats["BG_EFX_data"] = [] #only when leave TAG map
	change_map_time_controller
	$game_player.move_normal
	change_map_story_stats_fix
	temp_id = $story_stats["OverMapID"]
	temp_x =$story_stats["LastOverMapX"]
	temp_y =$story_stats["LastOverMapY"]
	$game_boxes.box(System_Settings::STORAGE_TEMP_MAP).clear
	$game_player.actor.remove_combat_state
	$game_player.actor.actor_changeMapForceUpdate
	$game_player.reserve_transfer(temp_id, temp_x,temp_y,$game_player.direction)
	$game_player.actor.set_action_state(:none,true)
end

def change_map_enter_tag(target=nil,force_id=false)		#主動進入TAG MAP
	#$game_party.lose_gold($game_party.gold)
	$story_stats["LastOverMapX"] = $game_player.x
	$story_stats["LastOverMapY"] = $game_player.y
	change_map_weather_cleaner
	if force_id == false && target !=nil
		rnd_map_id=$data_tag_maps[target].sample
		p $data_tag_maps[target]
		p "change_map_enter_tag way1 rnd_map_id => #{rnd_map_id}"
		$game_player.reserve_transfer(rnd_map_id, 1,1,$game_player.direction)
	else
		p "change_map_enter_tag way2 force_id => #{force_id}"
		$game_player.reserve_transfer(force_id, 1,1,$game_player.direction)
	end
	change_map_story_stats_fix
end

def change_map_enter_tagSub(target=nil)		#進入Submap
	SndLib.me_play("SE/Move",75,120+rand(31))
	call_timer_off
	$game_timer.update
	#$game_party.lose_gold($game_party.gold)
	change_map_weather_cleaner
	rnd_map_id = $data_tag_maps[target].sample
	p $data_tag_maps[target]
	p "change_map_enter_tagSub rnd_map_id => #{rnd_map_id}"
	$game_boxes.box(System_Settings::STORAGE_TEMP_MAP).clear #一定要比換地圖早
	$game_player.reserve_transfer(rnd_map_id, 1,1,$game_player.direction)
	change_map_story_stats_fix
end

def change_map_captured_enter_tagSub(target=nil)		#進入Submap
	SndLib.me_play("SE/Move",75,120+rand(31))
	call_timer_off
	#$game_party.lose_gold($game_party.gold)
	change_map_weather_cleaner
	rnd_map_id = $data_tag_maps[target].sample
	p $data_tag_maps[target]
	p "change_map_enter_tagSub rnd_map_id => #{rnd_map_id}"
	$game_boxes.box(System_Settings::STORAGE_TEMP_MAP).clear #一定要比換地圖早
	$game_player.reserve_transfer(rnd_map_id, 1,1,$game_player.direction)
	change_map_captured_story_stats_fix
end

def change_map_captured_enter_tag(target=nil)	
	$game_date.expireTradeHashCheck
	$game_party.lose_gold($game_party.gold)
	$story_stats["LastOverMapX"] = $game_player.x
	$story_stats["LastOverMapY"] = $game_player.y
	change_map_weather_cleaner
	rnd_map_id=$data_tag_maps[target].sample if target !=nil
	p $data_tag_maps[target]
	p "change_map_captured_enter_tag rnd_map_id => #{rnd_map_id}"
	$game_player.reserve_transfer(rnd_map_id, 1,1,$game_player.direction) if target!=nil
	change_map_captured_story_stats_fix
end

def change_map_enter_region
	#$game_party.lose_gold($game_party.gold)
	$story_stats["LastOverMapX"] = $game_player.x
	$story_stats["LastOverMapY"] = $game_player.y
	SndLib.bg_stop
	change_map_weather_cleaner
	rnd_map_id=$data_region_maps[$game_player.region_id].sample
	change_map_story_stats_fix(reset_stats = false)
	p $data_region_maps[$game_player.region_id]
	p "change_map_enter_region rnd_map_id => #{rnd_map_id}"
	$game_player.reserve_transfer(rnd_map_id, 1,1,$game_player.direction)
	#$game_temp.reserve_story("BIOS")
end

def change_map_leave_region
	$game_date.expireTradeHashCheck
	$game_party.lose_gold($game_party.gold)
	$game_player.move_normal
	$story_stats["OnRegionMapSpawnRace"] = 0
	$story_stats["RegionMap_Background"] = 0
	$story_stats["OnRegionMapEncounterRace"] = 0
	$story_stats["WildDangerous"] = 0
	change_map_time_controller
	temp_id = $story_stats["OverMapID"]
	temp_x =$story_stats["LastOverMapX"]
	temp_y =$story_stats["LastOverMapY"]
	$game_boxes.box(System_Settings::STORAGE_TEMP_MAP).clear #一定要比換地圖早
	change_map_story_stats_fix
	$game_player.reserve_transfer(temp_id, temp_x,temp_y,$game_player.direction)
	$game_player.actor.set_action_state(:none,true)
	#call_timer_off
	#$game_temp.reserve_story("BIOS")
end


def change_map_captured_leave_region
	$game_date.expireTradeHashCheck
	$game_party.lose_gold($game_party.gold)
	$game_player.move_normal
	$story_stats["WildDangerous"] = 0
	$story_stats["RegionMap_Background"] = 0
	$story_stats["OnRegionMapEncounterRace"] = 0
	temp_id = $story_stats["OverMapID"]
	temp_x =$story_stats["LastOverMapX"]
	temp_y =$story_stats["LastOverMapY"]
	change_map_captured_story_stats_fix
	$game_player.reserve_transfer(temp_id, temp_x,temp_y,$game_player.direction)
	$game_player.actor.set_action_state(:none,true)
	#call_timer_off
end


def change_map_overmap_force_point_trans(temp_tar=$story_stats["OverMapForceTrans"],captured=$story_stats["Captured"],tmpSTAY=$story_stats["OverMapForceTransStay"],tmpNoNap=$story_stats["OverMapForceNoNap"])
	return if temp_tar ==0
	st_x,st_y,st_id=$game_map.get_storypoint(temp_tar)
	handleNap if captured ==0 && tmpNoNap==0
	$game_player.moveto(get_character(st_id).x,get_character(st_id).y)
	$story_stats["LastOverMapX"] = $game_player.x
	$story_stats["LastOverMapY"] = $game_player.y
	$story_stats["OverMapForceTrans"] =0
	$story_stats["OverMapForceTransStay"] =0
	$story_stats["OverMapForceNoNap"] = 0
	if tmpSTAY == 0 
		wait(45)
		change_map_enter_tag(temp_tar) if captured ==0
		change_map_captured_enter_tag(temp_tar) if captured ==1
	end
end

def change_map_tag_map_exit(temp_region_trigger=false,tmpChoice=true)
	return SndLib.sys_buzzer if $game_player.cannot_change_map
	if $game_map.threat && $story_stats["Setup_Hardcore"] >= 1
		SndLib.sys_buzzer
		$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
		return
	else
		call_msg("OvermapEvents:Lona/Exit")
	end
	
	if $game_temp.choice == 1
		$game_temp.choice =0 if tmpChoice
		if $game_map.threat && $story_stats["Setup_Hardcore"] >= 1
			SndLib.sys_buzzer
			$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
			#$game_player.jump_reverse if temp_region_trigger==true
		else
			chcg_background_color(0,0,0,0,14)
			change_map_leave_tag_map
		end
	end
end
def change_map_tag_sub(tmpTar,tmpPoint=0,tmpDir=0,tmpChoice=true,tmpSkipOpt=false,capture=false)
	return SndLib.sys_buzzer if $game_player.cannot_change_map
	if !tmpSkipOpt
		if $game_map.threat && $story_stats["Setup_Hardcore"] >= 1
			SndLib.sys_buzzer
			$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
			return
		else
			call_msg("common:Lona/EnterSub")
		end
	else
		$game_temp.choice = 1
	end
	
	if $game_temp.choice == 1
		$game_temp.choice =0 if tmpChoice
		if $game_map.threat && $story_stats["Setup_Hardcore"] >= 1
			SndLib.sys_buzzer
			$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
		else
			chcg_background_color(0,0,0,0,14)
			$story_stats["TagSubTrans"] = tmpPoint if tmpPoint != 0
			$story_stats["TagSubForceDir"] = tmpDir if tmpDir != 0
			change_map_enter_tagSub(tmpTar) if !capture
			change_map_captured_enter_tagSub(tmpTar) if capture
		end
	end
end

def change_map_region_map_exit(temp_region_trigger=false,tmpChoice=true)
	return SndLib.sys_buzzer if $game_player.cannot_change_map
	if $game_map.threat && $story_stats["Setup_Hardcore"] >= 1
		SndLib.sys_ChangeMapFailed
		$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
		#$game_player.jump_reverse if temp_region_trigger==true
		return
	else
		call_msg("OvermapEvents:Lona/Exit")
	end
	
	if $game_temp.choice == 1
		$game_temp.choice =0 if tmpChoice
		if $game_map.threat && $story_stats["Setup_Hardcore"] >= 1
			SndLib.sys_ChangeMapFailed
			$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
			#$game_player.jump_reverse if temp_region_trigger==true
		else
			chcg_background_color(0,0,0,0,14)
			change_map_leave_region
		end
	else
		#$game_player.jump_reverse if temp_region_trigger==true
	end
end


def change_map_weather_cleaner
	#screen.start_tone_change(Tone.new(0,0,0,0),0)
	$game_map.set_fog(nil)
	$game_map.interpreter.weather_stop
	$story_stats["MapBackgroundType"] = 0
end

def change_map_time_controller
	$story_stats["OverMapEvent_DateCount"] += 10
	$story_stats["StepStoryCount"] += 250
	$story_stats["OverMapEvent_ForceHOM"] =1
end


end #module

