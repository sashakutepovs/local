
tmpQ1 = [2,3].include?($story_stats["RecQuestAriseVillageFish"])
tmpQ2 = $game_player.record_companion_name_ext == "AriseVillageCompExtConvoy"
if !tmpQ1 || !tmpQ2
	SndLib.sys_trigger
	return
end
if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
################################################ okay to go b2
if get_character(0).summon_data[:toB2] == true
	$story_stats["RecQuestAriseVillageFish"] = 3
	change_map_tag_sub("FishkindCave1B2",0,2)
################################################ b4 go b2
elsif tmpQ1 && tmpQ2
	if !follower_in_range?(-1,3)
		SndLib.sys_buzzer
		call_msg_popup("QuickMsg:CoverTar/NonNearLona")
		return eventPlayEnd
	end
	get_character(0).call_balloon(0)
	get_character(0).summon_data[:toB2] = true
	tmpCapPointSpawnX,tmpCapPointSpawnY,tmpCapPointSpawnID=$game_map.get_storypoint("CapPointSpawn")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character($game_player.get_followerID(-1)).npc_story_mode(true)
		tmpCOmove_type = get_character($game_player.get_followerID(-1)).move_type
		get_character($game_player.get_followerID(-1)).move_type = 0
		get_character($game_player.get_followerID(-1)).moveto(tmpCapPointSpawnX,tmpCapPointSpawnY-1)
		get_character($game_player.get_followerID(-1)).direction = 2
		$game_player.moveto(tmpCapPointSpawnX,tmpCapPointSpawnY)
		$game_player.direction = 8
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapPB_FishCampA:AriseVillageFish/2to3_0") ; portrait_hide
	get_character($game_player.get_followerID(-1)).direction = 8
	get_character($game_player.get_followerID(-1)).call_balloon(8)
	wait(60)
	call_msg("TagMapPB_FishCampA:AriseVillageFish/2to3_1")
	get_character($game_player.get_followerID(-1)).direction = 2
	call_msg("TagMapPB_FishCampA:AriseVillageFish/2to3_2")
	get_character($game_player.get_followerID(-1)).animation = get_character($game_player.get_followerID(-1)).animation_grabber_qte($game_player)
	$game_player.animation = $game_player.animation_grabbed_qte
	$game_player.actor.stat["EventExt1Race"] = "Fishkind"
	load_script("Data/HCGframes/Grab_EventExt1_BoobTouch.rb")
	call_msg("TagMapPB_FishCampA:AriseVillageFish/2to3_3") ; portrait_hide
	$game_player.animation = nil
	get_character($game_player.get_followerID(-1)).animation = nil
	whole_event_end
	get_character($game_player.get_followerID(-1)).direction = 2
	$game_player.call_balloon(5)
	wait(60)
	call_msg("TagMapPB_FishCampA:AriseVillageFish/2to3_4") ; portrait_hide
	get_character($game_player.get_followerID(-1)).direction = 8
	get_character($game_player.get_followerID(-1)).animation = get_character($game_player.get_followerID(-1)).animation_prayer
	get_character($game_player.get_followerID(-1)).call_balloon(8)
	wait(60)
	get_character($game_player.get_followerID(-1)).animation = get_character($game_player.get_followerID(-1)).animation_prayer
	$game_map.interpreter.screen.start_shake(1,7,60)
	SndLib.sound_FlameCast(100,70)
	wait(30)
	until get_character(0).opacity <= 0
		get_character(0).opacity -= 5
		wait(1)
	end
	get_character($game_player.get_followerID(-1)).animation = nil
	call_msg("TagMapPB_FishCampA:AriseVillageFish/2to3_5")
	get_character($game_player.get_followerID(-1)).direction = 2
	call_msg("TagMapPB_FishCampA:AriseVillageFish/2to3_6")
	get_character($game_player.get_followerID(-1)).direction = 4 ; get_character($game_player.get_followerID(-1)).move_forward_force ; get_character($game_player.get_followerID(-1)).move_speed = 3
	wait(30)
	get_character($game_player.get_followerID(-1)).move_type = tmpCOmove_type
	get_character($game_player.get_followerID(-1)).npc_story_mode(false)
	get_character(0).call_balloon(28,-1)
end

eventPlayEnd