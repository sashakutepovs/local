tmpQ0 = $story_stats["UniqueCharNoerSnowflake"] == -1
tmpQ1 = $story_stats["RecQuestNoerSnowflake"] == -1

if tmpQ1 || tmpQ0
 SndLib.bgm_play("Awkward LOOP LONG",80,50)
else
 SndLib.bgm_play("Awkward LOOP LONG",90,120) if $game_date.day?
 SndLib.bgm_play("Awkward LOOP LONG",90,95) if $game_date.night?
end
if [23].include?($game_player.region_id)
 $game_map.set_underground_light
else
	$game_map.shadows.set_color(120, 90, 70) if $game_date.day?
	$game_map.shadows.set_opacity(120) if $game_date.day?
	$game_map.shadows.set_color(50, 70, 160) if $game_date.night?
	$game_map.shadows.set_opacity(160) if $game_date.night?
end
$game_map.interpreter.weather("cave_dust", 1, "WhiteDot")
$game_map.interpreter.map_background_color
if (!tmpQ1 && !tmpQ0) && $story_stats["RecQuestNoerSnowflake"] == 0 && $story_stats["UniqueCharUniqueHappyMerchant"] != -1
	tmpHappyMerchantX,tmpHappyMerchantY,tmpHappyMerchantID=$game_map.get_storypoint("HappyMerchant")
	tmpSnowflakeEVModX,tmpSnowflakeEVModY,tmpSnowflakeEVModID=$game_map.get_storypoint("SnowflakeEVMod")
	tmpSnowflakeX,tmpSnowflakeY,tmpSnowflakeID=$game_map.get_storypoint("Snowflake")
	tmpPillSTX,tmpPillSTY,tmpPillSTID=$game_map.get_storypoint("PillST")
		$story_stats["RecQuestNoerSnowflake"] = 1
		get_character(tmpHappyMerchantID).opacity = 255
		get_character(tmpSnowflakeEVModID).opacity = 255
		get_character(tmpSnowflakeID).opacity = 0
		cam_follow(tmpSnowflakeEVModID,0)
		get_character(tmpHappyMerchantID).moveto(tmpPillSTX+1,tmpPillSTY)
		get_character(tmpSnowflakeEVModID).moveto(tmpPillSTX,tmpPillSTY)
		get_character(tmpHappyMerchantID).npc_story_mode(true)
		get_character(tmpSnowflakeEVModID).npc_story_mode(true)
		portrait_hide
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapNoerTransHouse:EnterOp/0")
	get_character(tmpSnowflakeEVModID).jump_to(get_character(tmpSnowflakeEVModID).x,get_character(tmpSnowflakeEVModID).y)
	call_msg("TagMapNoerTransHouse:EnterOp/1")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		cam_center(0)
		get_character(tmpHappyMerchantID).npc_story_mode(false)
		get_character(tmpSnowflakeEVModID).npc_story_mode(false)
		get_character(tmpHappyMerchantID).delete
		get_character(tmpSnowflakeEVModID).delete
		get_character(tmpSnowflakeID).opacity = 255
		SndLib.PenWrite
		wait(90)
		
	################################################## if jew is dead auto set to 1
elsif $story_stats["RecQuestNoerSnowflake"] == 0 && $story_stats["UniqueCharUniqueHappyMerchant"] == -1
	$story_stats["RecQuestNoerSnowflake"] = 1
	
	################################################## capture mode
elsif $story_stats["RecQuestNoerSnowflake"] != -1 && $story_stats["Captured"] == 1 && $story_stats["RapeLoop"] == 0
	$story_stats["RapeLoop"] = 1
	$game_map.set_underground_light
	SndLib.bgm_play("Awkward LOOP LONG",80,50)
	tmpSnowflakeX,tmpSnowflakeY,tmpSnowflakeID=$game_map.get_storypoint("Snowflake")
	tmpCapturedPointX,tmpCapturedPointY,tmpCapturedPointID=$game_map.get_storypoint("CapturedPoint")
	tmpGate1X,tmpGate1Y,tmpGate1ID=$game_map.get_storypoint("Gate1")
	tmpWakeUpX,tmpWakeUpY,tmpWakeUpID=$game_map.get_storypoint("WakeUp")
	
	tmpTrannyMoveType = get_character(tmpSnowflakeID).move_type
	get_character(tmpSnowflakeID).move_type = 0
	get_character(tmpSnowflakeID).moveto(tmpCapturedPointX,tmpCapturedPointY)
	get_character(tmpSnowflakeID).turn_toward_character($game_player)
	
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapNoerTransHouse:Trans/NapCapture0")
	$game_player.call_balloon(1)
	$game_player.turn_toward_character(get_character(tmpSnowflakeID))
	get_character(tmpSnowflakeID).turn_toward_character($game_player)
	call_msg("TagMapNoerTransHouse:Trans/NapCapture1") ; portrait_hide
	$game_player.call_balloon(8)
	wait(90)
	call_msg("TagMapNoerTransHouse:Trans/NapCapture2")
	
	get_character(tmpSnowflakeID).animation = get_character(tmpSnowflakeID).animation_grabber_qte($game_player)
	$game_player.animation = $game_player.animation_grabbed_qte
	SndLib.sound_equip_armor(100)
	
	call_msg("TagMapNoerTransHouse:Trans/NapCapture3") ; portrait_hide
	
	get_character(tmpSnowflakeID).jump_to(get_character(tmpSnowflakeID).x,get_character(tmpSnowflakeID).y)
	SndLib.sound_DressTear
	wait(25)
	
	portrait_off
	play_sex_service_main(ev_target=get_character(tmpSnowflakeID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4)
	half_event_key_cleaner
	play_sex_service_main(ev_target=get_character(tmpSnowflakeID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4)
	half_event_key_cleaner
	play_sex_service_main(ev_target=get_character(tmpSnowflakeID),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=4)
	portrait_off
	call_msg("TagMapNoerTransHouse:Trans/NapCapture4")
	portrait_off
	$game_player.actor.stat["EventVagRace"] =  "Human"
	$game_player.actor.stat["EventVag"] = "CumInside1"
	load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
	portrait_off
	$game_player.unset_event_chs_sex
	get_character(tmpSnowflakeID).unset_event_chs_sex
	call_msg("TagMapNoerTransHouse:Trans/NapCapture5")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpSnowflakeID).set_manual_move_type(tmpTrannyMoveType)
		get_character(tmpSnowflakeID).move_type = tmpTrannyMoveType
		get_character(tmpSnowflakeID).npc.fucker_condition={"sex"=>[0, "="]}
		get_character(tmpSnowflakeID).animation = nil
		posi=$game_map.region_map[24].sample
		get_character(tmpSnowflakeID).moveto(posi[0],posi[1])
	################################################## capture mode rapeloop after first nap
elsif $story_stats["RecQuestNoerSnowflake"] != -1 && $story_stats["Captured"] == 1 && $story_stats["RapeLoop"] == 1
	SndLib.bgm_stop
	#He is dead.  no more shit
#	tmpSnowflakeX,tmpSnowflakeY,tmpSnowflakeID=$game_map.get_storypoint("Snowflake")
#	tmpCapturedPointX,tmpCapturedPointY,tmpCapturedPointID=$game_map.get_storypoint("CapturedPoint")
#	chcg_background_color(0,0,0,255,-7)
#		get_character(tmpSnowflakeID).moveto(tmpCapturedPointX,tmpCapturedPointY)
#		get_character(tmpSnowflakeID).turn_toward_character($game_player)
#		
#	chcg_background_color(0,0,0,0,7)
#		get_character(tmpSnowflakeID).set_manual_move_type(1)
#		get_character(tmpSnowflakeID).move_type = 1
#		get_character(tmpSnowflakeID).npc.fucker_condition={"sex"=>[0, "="]}
#		get_character(tmpSnowflakeID).animation = nil
#		posi=$game_map.region_map[24].sample
#		get_character(tmpSnowflakeID).moveto(posi[0],posi[1])
end
$game_player.direction = 8 if $story_stats["ReRollHalfEvents"] == 1
fadeout=$story_stats["ReRollHalfEvents"] == 1
enter_static_tag_map(nil,fadeout)
summon_companion
$story_stats["LimitedNeedsSkill"] = 1
eventPlayEnd
get_character(0).erase