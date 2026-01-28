if $story_stats["NFL_MerCamp_SaveDog"] == 2
	SndLib.dogDead
	get_character(0).call_balloon(20)
	return
end
return if get_character(0).summon_data[:deadDog]
return if $story_stats["UniqueChar_NFL_MerCamp_Leader"] == -1
return if $story_stats["NFL_MerCamp_SaveDog"] != 1
return if $story_stats["RapeLoop"] >= 1
return if $story_stats["Captured"] >= 1
return if get_character(0).use_chs? && get_character(0).chs_configuration["sex_pos"] >= 0
tmpMerLeaderX,tmpMerLeaderY,tmpMerLeaderID = $game_map.get_storypoint("MerLeader")
if get_character(tmpMerLeaderID).report_range($game_player) >= 5
	SndLib.sys_buzzer
	call_msg_popup("QuickMsg:CoverTar/NonNearLona")
	return
end
return if get_character(tmpMerLeaderID).npc? && get_character(tmpMerLeaderID).npc.target
if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

$story_stats["NFL_MerCamp_SaveDog"] = 2
get_character(tmpMerLeaderID).turn_toward_character(get_character(0))
call_msg("TagMapNFL_OrkCamp2:Doggy/alive_begin1")
portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	get_character(0).call_balloon(0)
	get_character(0).walk_anime = true
	get_character(0).set_manual_character_index(0)
	get_character(0).character_index = 0
	get_character(0).forced_x = 0
	get_character(0).forced_y = 0
	get_character(0).set_npc("CompDoggy")
	wait(50)
	get_character(0).actor.killer_condition={"morality"=>[0, "<"]}
	get_character(0).actor.assaulter_condition={"morality"=>[0, "<"]}
	get_character(0).actor.add_fated_enemy([5])
	get_character(0).actor.set_fraction(12)
	get_character(0).actor.fraction_mode = 4
	get_character(0).priority_type = 1
	get_character(0).actor.battle_stat.set_stat_m("sta",0,[0,2,3])
	get_character(0).through = false
	get_character(0).set_this_event_companion_back_lite
	get_character(0).actor.death_event = "EffectDedEval"
	get_character(0).summon_data = {} if !get_character(0).summon_data
	get_character(0).summon_data[:DedEvalAutorun] = '
		tmpMerLeaderX,tmpMerLeaderY,tmpMerLeaderID = $game_map.get_storypoint("MerLeader")
		get_character(tmpMerLeaderID).remove_this_companion_lite
		get_character(tmpMerLeaderID).move_type = 1
		get_character(tmpMerLeaderID).set_manual_move_type(1)
		return if $story_stats["UniqueChar_NFL_MerCamp_Leader"] == -1
		call_msg("TagMapNFL_OrkCamp2:Doggy/KIA")
		eventPlayEnd
	'
	get_character(0).summon_data[:death_event] = '
		$story_stats["NFL_MerCamp_SaveDog"] = -1
		$story_stats["UniqueChar_NFL_MerCamp_Leader"] = -1
	'
	$game_player.moveto(get_character(0).x-1,get_character(0).y)
	get_character(tmpMerLeaderID).moveto(get_character(0).x,get_character(0).y+1)
	$game_player.turn_toward_character(get_character(0))
	get_character(tmpMerLeaderID).turn_toward_character(get_character(0))
	SndLib.bgm_play_prev
	SndLib.dogDead
chcg_background_color(0,0,0,255,-7)
call_msg("TagMapNFL_OrkCamp2:Doggy/alive_brd")
eventPlayEnd
