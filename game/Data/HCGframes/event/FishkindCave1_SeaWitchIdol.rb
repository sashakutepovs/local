
tmpQ1 = [2,3,4,5].include?($story_stats["RecQuestAriseVillageFish"])
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

if tmpQ1 && tmpQ2
	if !follower_in_range?(-1,3)
		SndLib.sys_buzzer
		call_msg_popup("QuickMsg:CoverTar/NonNearLona")
		return eventPlayEnd
	end
	get_character(0).call_balloon(0)
	$story_stats["RecQuestAriseVillageFish"] = 6
	tmpJusticeX,tmpJusticeY,tmpJusticeID=$game_map.get_storypoint("Justice")
	tmpEXITX,tmpEXITY,tmpEXITID=$game_map.get_storypoint("EXIT")
	tmpTableX,tmpTableY,tmpTableID=$game_map.get_storypoint("Table")
	tmpRewardX,tmpRewardY,tmpRewardID=$game_map.get_storypoint("Reward")
	tmpSeaWitchIdolX,tmpSeaWitchIdolY,tmpSeaWitchIdolID=$game_map.get_storypoint("SeaWitchIdol")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character($game_player.get_followerID(-1)).npc_story_mode(true)
		tmpCOmove_type = get_character($game_player.get_followerID(-1)).move_type
		get_character($game_player.get_followerID(-1)).move_type = 0
		get_character($game_player.get_followerID(-1)).moveto(tmpSeaWitchIdolX-1,tmpSeaWitchIdolY+3)
		get_character($game_player.get_followerID(-1)).direction = 8
		$game_player.moveto(tmpSeaWitchIdolX-1,tmpSeaWitchIdolY+4)
		$game_player.direction = 8
	chcg_background_color(0,0,0,255,-7)
	
	call_msg("TagMapPB_FishCampA:AriseVillageFish/5to6_0")
	get_character($game_player.get_followerID(-1)).direction = 8 ; get_character($game_player.get_followerID(-1)).move_forward_force ; get_character($game_player.get_followerID(-1)).move_speed = 3
	wait(30)
	get_character($game_player.get_followerID(-1)).direction = 8 ; get_character($game_player.get_followerID(-1)).move_forward_force ; get_character($game_player.get_followerID(-1)).move_speed = 3
	wait(30)
	$game_player.direction = 6 ; $game_player.move_speed = 3 ; $game_player.move_forward_force
	get_character($game_player.get_followerID(-1)).direction = 6 ; get_character($game_player.get_followerID(-1)).move_forward_force ; get_character($game_player.get_followerID(-1)).move_speed = 3
	wait(30)
	$game_player.direction = 8 ; $game_player.move_speed = 3 ; $game_player.move_forward_force
	get_character($game_player.get_followerID(-1)).direction = 8
	get_character($game_player.get_followerID(-1)).direction = 8
	call_msg("TagMapPB_FishCampA:AriseVillageFish/5to6_1_1")
	get_character($game_player.get_followerID(-1)).animation = get_character($game_player.get_followerID(-1)).animation_prayer
	call_msg("TagMapPB_FishCampA:AriseVillageFish/5to6_1_2")
	get_character($game_player.get_followerID(-1)).animation = get_character($game_player.get_followerID(-1)).animation_prayer
	call_msg("TagMapPB_FishCampA:AriseVillageFish/5to6_1_3")
	get_character($game_player.get_followerID(-1)).animation = get_character($game_player.get_followerID(-1)).animation_prayer
	call_msg("TagMapPB_FishCampA:AriseVillageFish/5to6_1_4")
	get_character($game_player.get_followerID(-1)).animation = get_character($game_player.get_followerID(-1)).animation_prayer
	get_character($game_player.get_followerID(-1)).call_balloon(8)
	wait(60)
	get_character($game_player.get_followerID(-1)).animation = get_character($game_player.get_followerID(-1)).animation_prayer
	get_character($game_player.get_followerID(-1)).call_balloon(8)
	wait(60)
	get_character($game_player.get_followerID(-1)).animation = get_character($game_player.get_followerID(-1)).animation_prayer
	get_character($game_player.get_followerID(-1)).call_balloon(8)
	wait(60)
	$game_map.interpreter.screen.start_shake(1,7,60)
	SndLib.sound_FlameCast(100,70)
	get_character(tmpJusticeID).opacity = 0
	get_character(tmpJusticeID).moveto(tmpSeaWitchIdolX,tmpSeaWitchIdolY-1)
	get_character(tmpJusticeID).forced_z = 10
	get_character(tmpJusticeID).npc_story_mode(true)
	get_character(tmpJusticeID).zoom_x = 1.5
	get_character(tmpJusticeID).zoom_y = 1.5
	get_character(tmpJusticeID).give_light("red300_5")
	until get_character(tmpJusticeID).opacity >=180
		get_character(tmpJusticeID).opacity += 3
		wait(1)
	end
	wait(30)
	get_character($game_player.get_followerID(-1)).animation = nil
	call_msg("TagMapPB_FishCampA:AriseVillageFish/5to6_2") ; portrait_hide
	get_character(tmpJusticeID).direction = 4
	get_character(tmpJusticeID).call_balloon(8)
	wait(60)
	get_character(tmpJusticeID).direction = 6
	get_character(tmpJusticeID).call_balloon(8)
	wait(60)
	get_character(tmpJusticeID).direction = 2
	call_msg("TagMapPB_FishCampA:AriseVillageFish/5to6_3")
	call_msg("TagMapPB_FishCampA:AriseVillageFish/5to6_3_KnowLona") if $story_stats["RecQuestDedOne"] >= 4
	call_msg("TagMapPB_FishCampA:AriseVillageFish/5to6_4") ; portrait_hide
	get_character(tmpJusticeID).call_balloon(8)
	wait(60)
	call_msg("TagMapPB_FishCampA:AriseVillageFish/5to6_5") ; portrait_hide
	#############
	get_character($game_player.get_followerID(-1)).angle = 0
	get_character($game_player.get_followerID(-1)).forced_x = 0
	get_character($game_player.get_followerID(-1)).forced_y = 0
	tmpANI = [
	[1,2,4,1,0],
	[1,2,4,0,0]
	]
	get_character($game_player.get_followerID(-1)).animation =get_character($game_player.get_followerID(-1)).aniCustom(tmpANI,-1)
	$game_map.interpreter.screen.start_shake(5,10,30)
	until get_character($game_player.get_followerID(-1)).angle >= 90
		get_character($game_player.get_followerID(-1)).forced_x += 0.3
		get_character($game_player.get_followerID(-1)).forced_y -= 0.5
		get_character($game_player.get_followerID(-1)).angle += 1
		SndLib.sound_FlameCast(100,100)
		wait(2)
	end
	get_character($game_player.get_followerID(-1)).forced_x = get_character($game_player.get_followerID(-1)).forced_x.round
	get_character($game_player.get_followerID(-1)).forced_y = get_character($game_player.get_followerID(-1)).forced_y.round
	get_character($game_player.get_followerID(-1)).animation =get_character($game_player.get_followerID(-1)).aniCustom(tmpANI,-1)
	wait(60)
	call_msg("TagMapPB_FishCampA:AriseVillageFish/5to6_6")
	EvLib.sum("EffectOverKillReverse",get_character($game_player.get_followerID(-1)).x,get_character($game_player.get_followerID(-1)).y-1)
	wait(20)
	call_msg("TagMapPB_FishCampA:AriseVillageFish/5to6_7")
	EvLib.sum("EffectOverKillReverse",get_character($game_player.get_followerID(-1)).x,get_character($game_player.get_followerID(-1)).y-1)
	wait(20)
	call_msg("TagMapPB_FishCampA:AriseVillageFish/5to6_8")
	EvLib.sum("EffectOverKillReverse",get_character($game_player.get_followerID(-1)).x,get_character($game_player.get_followerID(-1)).y-1)
	wait(20)
	call_msg("TagMapPB_FishCampA:AriseVillageFish/5to6_9")
	EvLib.sum("EffectOverKill",get_character($game_player.get_followerID(-1)).x,get_character($game_player.get_followerID(-1)).y-1)
	until get_character($game_player.get_followerID(-1)).opacity <= 0
		get_character($game_player.get_followerID(-1)).opacity -= 5
		get_character($game_player.get_followerID(-1)).zoom_x -= 0.05
		wait(1)
	end
	EvLib.sum("EffectOverKill",get_character($game_player.get_followerID(-1)).x,get_character($game_player.get_followerID(-1)).y-1)
	get_character($game_player.get_followerID(-1)).set_this_companion_disband(true)
	wait(50)
	call_msg("TagMapPB_FishCampA:AriseVillageFish/5to6_10_1") ; portrait_hide
	get_character(tmpJusticeID).move_forward_force
	wait(30)
	call_msg("TagMapPB_FishCampA:AriseVillageFish/5to6_10_2") ; portrait_hide
	get_character(tmpJusticeID).move_forward_force
	wait(30)
	$game_map.interpreter.flash_screen(Color.new(255,255,255,255),60,false)
	SndLib.sound_FlashMagic(80)
	get_character(tmpJusticeID).move_forward_force
	wait(25)
	get_character(tmpJusticeID).delete
	get_character(tmpRewardID).moveto(tmpTableX,tmpTableY-1)
	get_character(tmpRewardID).opacity = 255
	wait(30)
	call_msg("TagMapPB_FishCampA:AriseVillageFish/5to6_11") ; portrait_hide
	$game_player.call_balloon(8)
	$game_player.direction = 4
	wait(60)
	$game_player.call_balloon(8)
	$game_player.direction = 6
	wait(60)
	$game_player.call_balloon(8)
	$game_player.direction = 8
	wait(60)
	call_msg("TagMapPB_FishCampA:AriseVillageFish/5to6_12")
	
	get_character(tmpRewardID).call_balloon(28,-1)
	get_character(tmpEXITID).call_balloon(28,-1)
end
eventPlayEnd