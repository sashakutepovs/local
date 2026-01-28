if $story_stats["RecQuestElise"] == 12 && $game_player.record_companion_name_ext == "CompExtUniqueElise" && $story_stats["UniqueChar_FishTownT_Shaman"] == -1
	
	tmpStX,tmpStY,tmpStID=$game_map.get_storypoint("StartPoint")
	tmpSg0X,tmpSg0Y,tmpSg0ID=$game_map.get_storypoint("StoryGuard0")
	tmpSwX,tmpSwY,tmpSwID=$game_map.get_storypoint("Swirl")
	tmpQgX,tmpQgY,tmpQgID=$game_map.get_storypoint("QuestGiver")
	wait(20)
	$story_stats["RecQuestElise"] = 14
	
	tmpEliseID=$game_player.get_followerID(-1)
	get_character(tmpEliseID).npc_story_mode(true)
	get_character(tmpSg0ID).npc_story_mode(true)
	get_character(tmpEliseID).move_type = 0
	
	get_character(tmpEliseID).moveto(tmpStX-1,tmpStY)
	get_character(tmpEliseID).direction = 8
	$game_player.direction = 8
	$game_player.moveto(tmpStX+1,tmpStY)
	chcg_background_color(0,0,0,255,-7)
	
	2.times{
			$game_player.move_speed = 2.5
			$game_player.direction = 8
			$game_player.move_forward
			get_character(tmpEliseID).move_speed = 2.5
			get_character(tmpEliseID).move_forward
			get_character(tmpEliseID).direction = 8
		until !$game_player.moving?
			wait(1)
		end
	}
	get_character(tmpSg0ID).opacity = 0
	get_character(tmpSg0ID).direction = 8
	get_character(tmpSg0ID).moveto(tmpStX,tmpStY)
	until get_character(tmpSg0ID).opacity >= 255
		get_character(tmpSg0ID).opacity += 10
		wait(1)
	end
	$game_player.direction = 2
	get_character(tmpEliseID).direction = 2
	call_msg("CompElise:FishResearch1/14_ShamanDead_begin1")
	
	$game_player.direction = 8
	get_character(tmpEliseID).direction = 8
	$game_map.npcs.each{|event|
		next if !event.summon_data
		next if !event.summon_data[:Commoner]
		next if event.deleted? || event.actor.action_state == :death
		event.animation = nil
		event.call_balloon(1)
		event.turn_toward_character($game_player)
	}
	portrait_hide
	wait(60)
	$game_player.call_balloon(8)
	wait(60)
	call_msg("CompElise:FishResearch1/14_ShamanDead_begin2")
	call_msg("CompElise:FishResearch1/14_ShamanDead_begin3")
	get_character(tmpEliseID).turn_toward_character($game_player)
	$game_player.turn_toward_character(get_character(tmpEliseID))
	call_msg("CompElise:FishResearch1/14_ShamanDead_begin4")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		$game_player.moveto(tmpSwX,tmpSwY)
		$game_player.direction = 8
		get_character(tmpEliseID).delete
		#get_character(tmpEliseID).moveto(tmpQgX+1,tmpQgY)
		#get_character(tmpEliseID).direction = 2
		get_character(tmpSg0ID).moveto(tmpQgX,tmpQgY)
		get_character(tmpSg0ID).direction = 2
		$game_map.npcs.each{|event|
			next if !event.summon_data
			next if !event.summon_data[:Commoner]
			next if event.deleted? || event.actor.action_state == :death
			event.direction = 8
		}
	chcg_background_color(0,0,0,255,-7)
	call_msg("CompElise:FishResearch1/14_ShamanDead_begin5")
	
	#######################################################################################
	$game_map.npcs.each{|event|
		next if !event.summon_data
		next if !event.summon_data[:Commoner]
		next if event.deleted? || event.actor.action_state == :death
		event.call_balloon(20)
		event.turn_toward_character($game_player)
	}
	portrait_hide
	call_msg("TagMapFishTown:QuestGiver/sexParty2")
	cam_follow(tmpQgID,0)
	portrait_hide
	get_character(tmpQgID).jump_to(tmpQgX,tmpQgY)
	SndLib.sound_equip_armor
	wait(20)
	get_character(tmpSwID).npc_story_mode(true)
	set_event_force_page(tmpSwID,1)
	get_character(tmpSwID).animation = get_character(tmpSwID).animation_swirl
	call_msg("CompElise:FishResearch1/14_ShamanDead_begin6")
	cam_center(0)
	portrait_hide
	20.times{
		$game_player.direction = 4
		wait(2)
		$game_player.direction = 8
		wait(2)
		$game_player.direction = 6
		wait(2)
		$game_player.direction = 2
		wait(2)
		$game_player.forced_y += 1
		$game_player.opacity -= 12
	}
	$game_player.moveto(0,0)
	wait(60)
	$game_map.npcs.each{|event|
		next if !event.summon_data
		next if !event.summon_data[:Commoner]
		next if event.deleted? || event.actor.action_state == :death
		event.call_balloon(20)
	}
	
	#######################################################################################
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		call_msg("CompElise:FishResearch1/14_begin10")
		$game_player.forced_y =0
		$game_player.opacity = 255
	
	$story_stats["OverMapForceTrans"] = "FishkindCave3"
	change_map_leave_tag_map
	$story_stats["Captured"] = 1
	
	
elsif $story_stats["RecQuestElise"] == 12 && $game_player.record_companion_name_ext == "CompExtUniqueElise"
	
	$story_stats["RecQuestElise"] = 13
	tmpQgX,tmpQgY,tmpQgID=$game_map.get_storypoint("QuestGiver")
	tmpStX,tmpStY,tmpStID=$game_map.get_storypoint("StartPoint")
	tmpSg0X,tmpSg0Y,tmpSg0ID=$game_map.get_storypoint("StoryGuard0")
	tmpMtbX,tmpMtbY,tmpMtbID=$game_map.get_storypoint("ManTransB4")
	tmpMtX,tmpMtY,tmpMtID=$game_map.get_storypoint("ManTrans")
	tmpSwX,tmpSwY,tmpSwID=$game_map.get_storypoint("Swirl")
	wait(20)
	tmpEliseID=$game_player.get_followerID(-1)
	get_character(tmpQgID).call_balloon(0)
	#$game_player.moveto(tmpStX+1,tmpStY)
	$game_player.direction = 8
	get_character(tmpEliseID).moveto(tmpStX-1,tmpStY)
	get_character(tmpEliseID).direction = 8
	chcg_background_color(0,0,0,255,-7)
	
	get_character(tmpEliseID).npc_story_mode(true)
	get_character(tmpSg0ID).npc_story_mode(true)
	get_character(tmpMtbID).npc_story_mode(true)
	get_character(tmpQgID).npc_story_mode(true)
	get_character(tmpMtID).npc_story_mode(true)
	get_character(tmpSwID).force_update = true
	
	get_character(tmpEliseID).move_type = 0
	call_msg("CompElise:FishResearch1/13_begin1")
	portrait_hide
	$game_player.direction = 6 ; $game_player.move_forward
	get_character(tmpEliseID).move_type = 0
	get_character(tmpEliseID).direction = 4 ; get_character(tmpEliseID).move_forward
	get_character(tmpEliseID).direction = 6
	$game_player.direction = 4
	wait(10)
	get_character(tmpMtbID).moveto(tmpStX,tmpStY)
	get_character(tmpMtbID).direction = 8 ; get_character(tmpMtbID).move_forward
	wait(45)
	get_character(tmpSg0ID).moveto(tmpStX,tmpStY)
	get_character(tmpSg0ID).direction = 8 ; get_character(tmpSg0ID).move_forward
	call_msg("CompElise:FishResearch1/13_begin2")
	portrait_hide
	cam_follow(tmpMtbID,0)
	5.times{
			get_character(tmpMtbID).direction = 8 ; get_character(tmpMtbID).move_forward
			get_character(tmpSg0ID).direction = 8 ; get_character(tmpSg0ID).move_forward
			until !get_character(tmpMtbID).moving?
				wait(1)
			end
	}
	get_character(tmpEliseID).direction = 8
	$game_player.direction = 8
	get_character(tmpMtbID).direction = 8 ; get_character(tmpMtbID).move_forward
	wait(45)
	get_character(tmpMtbID).jump_to(tmpSwX,tmpSwY)
	get_character(tmpMtbID).direction = 2
	get_character(tmpSg0ID).animation = get_character(tmpSg0ID).animation_atk_shoot_hold
	wait(30)
	SndLib.stepWater(95)
	wait(20)
	call_msg("CompElise:FishResearch1/13_begin3")
	portrait_hide
	$game_map.npcs.each{|event|
		next if !event.summon_data
		next if !event.summon_data[:Commoner]
		next if event.deleted? || event.actor.action_state == :death
		event.call_balloon(20)
	}
	call_msg("TagMapFishTown:QuestGiver/sexParty2")
	portrait_hide
	$game_map.npcs.each{|event|
		next if !event.summon_data
		next if !event.summon_data[:Commoner]
		next if event.deleted? || event.actor.action_state == :death
		event.call_balloon(20)
	}
	call_msg("TagMapFishTown:QuestGiver/sexParty3")
	get_character(tmpMtbID).animation = get_character(tmpMtbID).animation_grabbed_qte
	call_msg("CompElise:FishResearch1/13_begin4")
	portrait_hide
	20.times{
		get_character(tmpMtbID).zoom_x -= rand(5) * 0.01
		get_character(tmpMtbID).zoom_y -= rand(5) * 0.01
		wait(2)
	}
	$game_map.reserve_summon_event("EffectOverKill",tmpSwX,tmpSwY)
	SndLib.sound_gore(80,70)
	SndLib.sound_gore(80,70)
	SndLib.sound_gore(80,70)
	get_character(tmpMtbID).delete
	get_character(tmpMtID).moveto(tmpSwX,tmpSwY)
	get_character(tmpMtID).direction = 2
	get_character(tmpMtID).animation = get_character(tmpMtID).animation_grabbed_qte
	get_character(tmpMtID).zoom_x = 0.7
	get_character(tmpMtID).zoom_y = 0.7
	6.times{
		get_character(tmpMtID).zoom_x += 0.05
		get_character(tmpMtID).zoom_y += 0.05
		wait(2)
	}
	wait(60)
	get_character(tmpMtID).animation = nil
	wait(20)
	get_character(tmpMtID).direction = 4
	get_character(tmpMtID).call_balloon(2)
	wait(40)
	get_character(tmpMtID).direction = 6
	get_character(tmpMtID).call_balloon(2)
	wait(40)
	get_character(tmpMtID).direction = 8
	get_character(tmpMtID).call_balloon(2)
	call_msg("CompElise:FishResearch1/13_begin5")
	portrait_hide
	get_character(tmpQgID).jump_to(tmpQgX,tmpQgY)
	SndLib.sound_equip_armor
	wait(20)
	set_event_force_page(tmpSwID,1)
	get_character(tmpSwID).animation = get_character(tmpSwID).animation_swirl
	$game_map.npcs.each{|event|
		next if !event.summon_data
		next if !event.summon_data[:Commoner]
		next if event.deleted? || event.actor.action_state == :death
		event.call_balloon(20)
	}
	call_msg("TagMapFishTown:QuestGiver/sexParty3")
	cam_follow(tmpSwID,0)
	20.times{
		get_character(tmpMtID).direction = 4
		wait(2)
		get_character(tmpMtID).direction = 8
		wait(2)
		get_character(tmpMtID).direction = 6
		wait(2)
		get_character(tmpMtID).direction = 2
		wait(2)
		get_character(tmpMtID).forced_y += 1
		get_character(tmpMtID).opacity -= 12
	}
	get_character(tmpSg0ID).animation = nil
	call_msg("CompElise:FishResearch1/13_begin6")
	portrait_hide
	$game_player.direction = 4
	get_character(tmpEliseID).direction = 6
	call_msg("CompElise:FishResearch1/13_begin7")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		$game_player.moveto(tmpStX,tmpStY)
		$game_player.direction = 8
		get_character(tmpSwID).animation = nil
		get_character(tmpSg0ID).animation = nil
		set_event_force_page(tmpSwID,2)
		get_character(tmpEliseID).move_type = 3
		get_character(tmpEliseID).npc_story_mode(false)
		get_character(tmpSg0ID).npc_story_mode(false)
		get_character(tmpMtbID).npc_story_mode(false)
		get_character(tmpSwID).npc_story_mode(false)
		get_character(tmpQgID).npc_story_mode(false)
		wait(2)
		get_character(tmpSg0ID).moveto(tmpSg0X,tmpSg0Y)
		get_character(tmpMtID).delete
		wait(2)
		get_character(tmpQgID).call_balloon(28,-1)
		eventPlayEnd
	chcg_background_color(0,0,0,255,-7)
elsif $story_stats["RecQuestElise"] == 15 && $game_player.record_companion_name_ext != "CompExtUniqueElise" && $story_stats["UniqueCharUniqueElise"] != -1
	SndLib.bgm_play("D/Hidden Assault LOOP",70,100)
	call_msg("CompElise:FishResearch1/15_begin7_enter")
	$game_map.npcs.each do |event| 
		next if event.summon_data == nil
		next unless event.summon_data[:FishDude]
		event.npc.death_event="EffectCharDed"
	end
end
