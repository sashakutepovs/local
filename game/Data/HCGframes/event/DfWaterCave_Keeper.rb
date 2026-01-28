if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
tmpAggro = false
if !get_character(0).summon_data[:Enter] && $story_stats["Captured"] == 0 #quest dialog
	$story_stats["RecQuestDf_Heresy"] >= 4 ? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
	call_msg("TagMapDfWaterCave:keeper/0_opt") #路人,尼古拉斯<r=HiddenOPT0>]
	case $game_temp.choice
		when 0,-1 #none
			call_msg("TagMapDfWaterCave:keeper/1_1Passby")
			call_msg("TagMapDfWaterCave:keeper/1_1Passby_cocona") if cocona_in_group?
			call_msg("TagMapDfWaterCave:keeper/Aggro")
			get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],3000)
			get_character($game_player.get_followerID(0)).actor.set_aggro(get_character(0).actor,$data_arpgskills["BasicNormal"],300)  if cocona_in_group?
			get_character(0).summon_data[:Enter] = true
			tmpAggro = true
		when 1 # quest HerName
			call_msg("TagMapDfWaterCave:keeper/1_1HerName")
			portrait_hide
			cam_center(0)
			get_character(0).npc_story_mode(true)
			get_character(0).direction = 4 ; get_character(0).move_forward_force ; wait(60)
			get_character(0).direction = 8 ; get_character(0).move_forward_force ; wait(60)
			get_character(0).direction = 2
			get_character(0).npc_story_mode(false)
			get_character(0).summon_data[:Enter] = true
			call_msg("TagMapDfWaterCave:keeper/1_1HerName_cocona") if cocona_in_group?
	end
elsif $story_stats["Captured"] == 1 #rapeloop Dialog
	get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
	call_msg("TagMapDfWaterCave:keeper/Aggro_captured")
	tmpAggro = true
	
elsif get_character(0).summon_data[:Enter]
	call_msg("TagMapDfWaterCave:keeper/Aggro_captured_loop")
	
else #Common
	get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],3000)
	call_msg("TagMapDfWaterCave:keeper/Aggro")
	tmpAggro = true
	
	
end
eventPlayEnd
