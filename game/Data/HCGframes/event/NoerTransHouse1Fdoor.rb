eventPlayStart
tmpKnok = false
tmpSnowflakeX,tmpSnowflakeY,tmpSnowflakeID= $game_map.get_storypoint("Snowflake")
if $story_stats["RecQuestNoerSnowflake"] != -1 && $story_stats["UniqueCharNoerSnowflake"] != -1 && get_character(tmpSnowflakeID).summon_data[:fapMOde]
	
	get_character(0).summon_data[:knokPT] += 1
	if get_character(0).summon_data[:knokPT] > 3
		portrait_hide
		get_character(tmpSnowflakeID).summon_data[:fapMOde] = false
		get_character(tmpSnowflakeID).npc_story_mode(true)
		get_character(tmpSnowflakeID).set_manual_move_type(0)
		get_character(tmpSnowflakeID).move_type = 0
		get_character(tmpSnowflakeID).call_balloon(1)
		get_character(tmpSnowflakeID).animation = nil
		get_character(tmpSnowflakeID).turn_toward_character($game_player)
		wait(60)
		get_character(tmpSnowflakeID).move_forward_force
		until !get_character(tmpSnowflakeID).moving?
			wait(1)
		end
		SndLib.openDoor
		set_event_force_page(get_character(0).id,2,0)
		get_character(0).forced_y = -6
		get_character(0).forced_z = -2
		get_character(tmpSnowflakeID).move_forward_force
		until !get_character(tmpSnowflakeID).moving?
			wait(1)
		end 
		SndLib.sound_equip_armor
		$game_player.knockback_from_char(get_character(tmpSnowflakeID))
		
		get_character(tmpSnowflakeID).move_forward_force
		until !get_character(tmpSnowflakeID).moving?
			wait(1)
		end
		if $story_stats["RecQuestNoerSnowflake"] == 1#first spot
			$story_stats["RecQuestNoerSnowflake"] = 2
			get_character(tmpSnowflakeID).jump_to(get_character(tmpSnowflakeID).x,get_character(tmpSnowflakeID).y)
			call_msg("TagMapNoerTransHouse:Trans/begin0")
			call_msg("TagMapNoerTransHouse:Trans/begin1")
			call_msg("TagMapNoerTransHouse:Trans/begin2")
			call_msg("TagMapNoerTransHouse:Trans/begin3")
		else
			call_msg("TagMapNoerTransHouse:Trans/talkedNight0")
		end
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			SndLib.openDoor
			set_event_force_page(get_character(0).id,1,4)
			get_character(0).forced_y = 4
			get_character(0).forced_z = 6
			cam_center(0)
			#get_character(tmpSnowflakeID).move_forward_force
			get_character(tmpSnowflakeID).npc_story_mode(false)
		chcg_background_color(0,0,0,255,-7)
	else
		tmpKnok = true
	end
	
else
	tmpKnok = true
end


if tmpKnok
	SndLib.sys_DoorLock
	call_msg_popup("TagMapNoerCatacomb:Necropolis/Locked#{rand(2)}")
end
eventPlayEnd