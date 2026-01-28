if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if $story_stats["UniqueCharUniqueElise"] == -1
	SndLib.sys_buzzer
	$game_map.popup(0,"CompElise:tar/Failed_enter",0,0)
	return
end

set_comp=false

if $game_player.record_companion_name_ext == nil
	set_comp=true
elsif $game_player.record_companion_name_ext != nil
	$game_temp.choice = -1
	call_msg("commonComp:notice/ExtOverWrite")
	call_msg("common:Lona/Decide_optD")
	if $game_temp.choice ==1
	set_comp=true
	end
end


if set_comp
	tmpEliseX,tmpEliseY,tmpEliseID=$game_map.get_storypoint("elise")
	$story_stats["RecQuestConvoyTarget"] = [21,22]
	$story_stats["RecQuestElise"] =4
	get_character(-1).animation = get_character(-1).animation_mc_pick_up
	optain_item($data_items[107],1)
	get_character(0).delete
	call_msg("CompElise:RecQuestElise4/GJ0")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		tmpEliseX = get_character(tmpEliseID).x
		tmpEliseY = get_character(tmpEliseID).y
		get_character(tmpEliseID).set_this_event_companion_ext("CompExtUniqueElise",nil)
		get_character(tmpEliseID).npc.master = $game_player
		get_character(tmpEliseID).follower[1] =1
		set_event_force_page(tmpEliseID,3)
	chcg_background_color(0,0,0,255,-7)
	call_msg("CompElise:RecQuestElise4/GJ_BOARD")
	call_msg("CompElise:RecQuestElise4/GJ1")
end

$game_temp.choice = -1 ; portrait_hide