


$game_map.shadows.set_color(120, 90, 70) if $game_date.day?
$game_map.shadows.set_opacity(120) if $game_date.day?
$game_map.shadows.set_color(50, 70, 160) if $game_date.night?
$game_map.shadows.set_opacity(160) if $game_date.night?




if $story_stats["UniqueCharUniqueTeller"] != -1
	SndLib.bgm_play("Awkward LOOP LONG",90,120)
else
	SndLib.bgs_play("AlienRumble",100,100)
	$game_map.set_fog("infested_fall")
	$game_map.interpreter.weather("snow", 10, "redDot",true)
end
$game_map.interpreter.map_background_color
$game_player.direction = 8 if $story_stats["ReRollHalfEvents"] ==1
fadeout=$story_stats["ReRollHalfEvents"] == 1
enter_static_tag_map(nil,fadeout) if fadeout
summon_companion
$story_stats["LimitedNeedsSkill"] =1

if $game_date.night? && $story_stats["RecQuestTeller"] == 1 && $story_stats["UniqueCharUniqueTeller"] != -1
		$story_stats["RecQuestTeller"] = 2
		tmpDedX,tmpDedY,tmpDedID = $game_map.get_storypoint("DedOne")
		tmpExitX,tmpExitY=$game_map.get_storypoint("ExitPoint")
		tmpTellerX,tmpTellerY,tmpTellerID=$game_map.get_storypoint("teller")
		set_event_force_page(tmpDedID,1)
		get_character(tmpDedID).npc_story_mode(true)
		get_character(tmpDedID).moveto(tmpTellerX,tmpTellerY+2)
		get_character(tmpDedID).direction = 8
		chcg_background_color(0,0,0,255,-7)
		call_msg("CompTeller:GodCTalk/begin1")
		call_msg("CompTeller:GodCTalk/begin2")
		4.times{
			get_character(tmpDedID).move_goto_xy(tmpExitX,tmpExitY)
		}
		get_character(tmpDedID).delete
		call_msg("CompTeller:GodCTalk/begin3")
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			cam_center(0)
		chcg_background_color(0,0,0,255,-7)
		eventPlayEnd
elsif $game_date.night? && $story_stats["RecQuestTeller"] == 2 && $story_stats["UniqueCharUniqueTeller"] != -1 && ($story_stats["RecQuestSeaWitch"] == 5 && $story_stats["RecQuestDedOne"] == 5 && $story_stats["UniqueCharUniqueSeaWitch"] != -1)
		$story_stats["RecQuestTeller"] = 3
		$story_stats["RecQuestSeaWitch"] = 6
		$story_stats["RecQuestDedOne"] = 6
		tmpDedX,tmpDedY,tmpDedID = $game_map.get_storypoint("DedOne")
		tmpExitX,tmpExitY=$game_map.get_storypoint("ExitPoint")
		tmpTellerX,tmpTellerY,tmpTellerID=$game_map.get_storypoint("teller")
		tmpSwX,tmpSwY,tmpSwID=$game_map.get_storypoint("SeaWitch")
		tmpBallX,tmpBallY,tmpBallID=$game_map.get_storypoint("TheBall")
		set_event_force_page(tmpBallID,2)
		get_character(tmpSwID).npc_story_mode(true)
		get_character(tmpDedID).npc_story_mode(true)
		get_character(tmpSwID).direction = 4
		get_character(tmpDedID).direction = 6
		get_character(tmpTellerID).direction = 2
		get_character(tmpSwID).moveto(tmpTellerX+1,tmpTellerY+1)
		get_character(tmpDedID).moveto(tmpTellerX-1,tmpTellerY+1)
		get_character(tmpTellerID).moveto(tmpTellerX,tmpTellerY)
		cam_follow(tmpTellerID,0)
		chcg_background_color(0,0,0,255,-7)
		call_msg("CompTeller:GodCTalk2/begin0")
		portrait_hide
		get_character(tmpSwID).animation = get_character(tmpSwID).animation_atk_sh
		wait(20)
		SndLib.sound_equip_armor
		get_character(tmpBallID).opacity = 0
		call_msg("CompTeller:GodCTalk2/begin1")
		get_character(tmpBallID).effects=["Slime Breath",0,true]
		get_character(tmpBallID).opacity = 255
		get_character(tmpSwID).npc_story_mode(false)
		get_character(tmpDedID).npc_story_mode(false)
		get_character(tmpSwID).set_npc("UniqueSeaWitch")
		get_character(tmpDedID).set_npc("UniqueDedOne")
		get_character(tmpDedID).npc.set_fraction(3)
		get_character(tmpDedID).npc.set_morality(50)
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			cam_center(0)
		chcg_background_color(0,0,0,255,-7)
		eventPlayEnd

elsif $game_date.night? && $story_stats["RecQuestTeller"] >= 3 && $story_stats["RecQuestSeaWitch"] >= 6 && $story_stats["RecQuestDedOne"] >= 6 && $story_stats["UniqueCharUniqueTeller"] != -1 && $story_stats["UniqueCharUniqueSeaWitch"] != -1
		tmpDedX,tmpDedY,tmpDedID = $game_map.get_storypoint("DedOne")
		tmpExitX,tmpExitY=$game_map.get_storypoint("ExitPoint")
		tmpTellerX,tmpTellerY,tmpTellerID=$game_map.get_storypoint("teller")
		tmpSwX,tmpSwY,tmpSwID=$game_map.get_storypoint("SeaWitch")
		tmpBallX,tmpBallY,tmpBallID=$game_map.get_storypoint("TheBall")
		get_character(tmpSwID).direction = 4
		get_character(tmpDedID).direction = 6
		get_character(tmpTellerID).direction = 2
		get_character(tmpSwID).moveto(tmpTellerX+1,tmpTellerY+1)
		get_character(tmpDedID).moveto(tmpTellerX-1,tmpTellerY+1)
		get_character(tmpTellerID).moveto(tmpTellerX,tmpTellerY)
end


chcg_background_color(0,0,0,255,-7) if get_chcg_background_opacity >= 255
eventPlayEnd

get_character(0).erase

