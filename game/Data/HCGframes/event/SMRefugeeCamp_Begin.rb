chcg_background_color(0,0,0,255,-7) if $story_stats["ReRollHalfEvents"] ==1 && $story_stats["RecQuestSMRefugeeCampCBT"] != 0
enter_static_region_map if $story_stats["Kidnapping"] == 0
summon_companion
$game_map.shadows.set_color(40, 120, 90) if $game_date.day?
$game_map.shadows.set_opacity(100)  if $game_date.day?
#$story_stats["RecQuestSMRefugeeCampCBT"]			1 看到女人踢蛋蛋
#													2 聽佛里曼解說完
if $story_stats["RecQuestSMRefugeeCampCBT"] == 0
	$game_player.transparent = true
	tmpCBTer1X,tmpCBTer1Y,tmpCBTer1ID=$game_map.get_storypoint("CBTer1")
	tmpCBTer2X,tmpCBTer2Y,tmpCBTer2ID=$game_map.get_storypoint("CBTer2")
	tmpOrkVictim2X,tmpOrkVictim2Y,tmpOrkVictim2ID=$game_map.get_storypoint("OrkVictim2")
	tmpCBThunterX,tmpCBThunterY,tmpCBThunterID=$game_map.get_storypoint("CBThunter")
	portrait_hide
	chcg_background_color(0,0,0,255,255)
		portrait_off
		get_character(tmpCBTer2ID).direction = 6
		get_character(tmpCBTer2ID).moveto(tmpOrkVictim2X-1,tmpOrkVictim2Y+2)
		get_character(tmpCBTer2ID).npc_story_mode(true)
		get_character(tmpCBTer1ID).direction = 4
		get_character(tmpCBTer1ID).moveto(tmpOrkVictim2X,tmpOrkVictim2Y+2)
		get_character(tmpCBTer1ID).npc_story_mode(true)
		cam_follow(tmpCBTer1ID,0)
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapSMRefugeeCamp:CBTop/Begin0")
	get_character(tmpCBTer2ID).direction = 8 ; get_character(tmpCBTer2ID).move_forward_force
	get_character(tmpCBTer1ID).direction = 8
	wait(35)
	get_character(tmpCBTer2ID).direction = 2
	call_msg("TagMapSMRefugeeCamp:CBTop/Begin1")
	get_character(tmpCBTer1ID).direction = 8 ; get_character(tmpCBTer1ID).move_forward_force
	wait(35)
	get_character(tmpCBTer1ID).direction = 4
	get_character(tmpCBTer2ID).direction = 6
	call_msg("TagMapSMRefugeeCamp:CBTop/Begin2")
	get_character(tmpCBTer1ID).direction = 8
	call_msg("TagMapSMRefugeeCamp:CBTop/Begin3")
	get_character(tmpCBTer1ID).direction = 8
	get_character(tmpCBTer1ID).animation = get_character(tmpCBTer1ID).animation_atk_mh
	wait(8)
	SndLib.sound_punch_hit(100)
	SndLib.sound_goblin_death(80)
	set_event_force_page(tmpOrkVictim2ID,6)
	5.times{
			get_character(tmpOrkVictim2ID).forced_x = 1+rand(2)
			wait(2)
			get_character(tmpOrkVictim2ID).forced_x = -(1+rand(2))
			wait(2)
	}
	set_event_force_page(tmpOrkVictim2ID,2)
	wait(22)
	get_character(tmpCBTer1ID).call_balloon(8)
	wait(60)
	get_character(tmpCBTer1ID).direction = 4
	call_msg("TagMapSMRefugeeCamp:CBTop/Begin4")
	get_character(tmpCBTer1ID).direction = 8
	get_character(tmpCBTer1ID).call_balloon(8)
	wait(40)
	get_character(tmpCBTer1ID).direction = 8
	get_character(tmpCBTer1ID).animation = get_character(tmpCBTer1ID).animation_atk_mh
	wait(8)
	SndLib.sound_punch_hit(100)
	SndLib.sound_goblin_death(80)
	set_event_force_page(tmpOrkVictim2ID,6)
	8.times{
			get_character(tmpOrkVictim2ID).forced_x = 1+rand(2)
			wait(2)
			get_character(tmpOrkVictim2ID).forced_x = -(1+rand(2))
			wait(2)
	}
	set_event_force_page(tmpOrkVictim2ID,2)
	get_character(tmpCBTer1ID).direction = 8
	get_character(tmpCBTer1ID).animation = get_character(tmpCBTer1ID).animation_atk_sh
	wait(8)
	SndLib.sound_punch_hit(100)
	SndLib.sound_goblin_death(80)
	set_event_force_page(tmpOrkVictim2ID,6)
	8.times{
			get_character(tmpOrkVictim2ID).forced_x = 1+rand(2)
			wait(2)
			get_character(tmpOrkVictim2ID).forced_x = -(1+rand(2))
			wait(2)
	}
	set_event_force_page(tmpOrkVictim2ID,2)
	call_msg("TagMapSMRefugeeCamp:CBTop/Begin5")
	get_character(tmpCBTer1ID).direction = 8
	get_character(tmpCBTer1ID).animation = get_character(tmpCBTer1ID).animation_atk_mh
	wait(8)
	SndLib.sound_punch_hit(100,100+rand(80))
	SndLib.sound_goblin_death(80)
	set_event_force_page(tmpOrkVictim2ID,6)
	8.times{
			get_character(tmpOrkVictim2ID).forced_x = 1+rand(2)
			wait(2)
			get_character(tmpOrkVictim2ID).forced_x = -(1+rand(2))
			wait(2)
	}
	set_event_force_page(tmpOrkVictim2ID,2)
	get_character(tmpCBTer1ID).direction = 8
	get_character(tmpCBTer1ID).animation = get_character(tmpCBTer1ID).animation_atk_sh
	wait(8)
	SndLib.sound_punch_hit(100,100+rand(80))
	SndLib.sound_goblin_death(80)
	set_event_force_page(tmpOrkVictim2ID,6)
	8.times{
			get_character(tmpOrkVictim2ID).forced_x = 1+rand(2)
			wait(2)
			get_character(tmpOrkVictim2ID).forced_x = -(1+rand(2))
			wait(2)
	}
	set_event_force_page(tmpOrkVictim2ID,2)
	get_character(tmpCBTer1ID).direction = 8
	get_character(tmpCBTer1ID).animation = get_character(tmpCBTer1ID).animation_atk_mh
	wait(8)
	SndLib.sound_punch_hit(100,100+rand(80))
	SndLib.sound_goblin_death(80)
	set_event_force_page(tmpOrkVictim2ID,6)
	8.times{
			get_character(tmpOrkVictim2ID).forced_x = 1+rand(2)
			wait(2)
			get_character(tmpOrkVictim2ID).forced_x = -(1+rand(2))
			wait(2)
	}
	set_event_force_page(tmpOrkVictim2ID,2)
	get_character(tmpCBTer1ID).direction = 8
	get_character(tmpCBTer1ID).animation = get_character(tmpCBTer1ID).animation_atk_sh
	wait(8)
	SndLib.sound_punch_hit(100,100+rand(80))
	SndLib.sound_goblin_death(80)
	set_event_force_page(tmpOrkVictim2ID,6)
	8.times{
			get_character(tmpOrkVictim2ID).forced_x = 1+rand(2)
			wait(2)
			get_character(tmpOrkVictim2ID).forced_x = -(1+rand(2))
			wait(2)
	}
	set_event_force_page(tmpOrkVictim2ID,2)
	call_msg("TagMapSMRefugeeCamp:CBTop/Begin6")
	chcg_background_color(0,0,0,0,7)
		tmpVol = 0
		6.times{
			SndLib.sound_punch_hit(100-tmpVol,100+rand(80))
			SndLib.sound_goblin_death(80-tmpVol)
			wait(30+rand(20))
			tmpVol += 10
		}
		wait(70)
		
		$story_stats["RecQuestSMRefugeeCampCBT"] = 1
		get_character(tmpCBTer1ID).delete
		get_character(tmpCBTer2ID).delete
		eventPlayEnd
		$game_player.transparent = false
	chcg_background_color(0,0,0,255,-7)
end