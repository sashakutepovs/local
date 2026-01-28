if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

$game_temp.choice = -1
tmpEV = get_character(0)
set_comp=false
call_msg("TagMapSwampRDK1:mec/Quprog_0")
call_msg("TagMapSwampRDK1:mec/Quprog_0_board")
call_msg("TagMapSwampRDK1:mec/Quprog_0_decide")
if $game_temp.choice ==1 && $game_player.record_companion_name_ext == nil
	set_comp=true
elsif $game_temp.choice ==1 && $game_player.record_companion_name_ext != nil
	$game_temp.choice = -1
	call_msg("commonComp:notice/ExtOverWrite")
	call_msg("common:Lona/Decide_optD")
	if $game_temp.choice == 1
		set_comp=true
	end
end
if set_comp
	chcg_background_color(0,0,0,0,7)
	$story_stats["RecQuestConvoyTarget"] = [21,22] #Inside Noer
	tmpEV.set_this_event_companion_ext("SwampRDK1CompExtConvoy",false,10+$game_date.dateAmt)
	$game_map.reserve_summon_event("SwampRDK1CompExtConvoy",tmpEV.x,tmpEV.y)
	tmpEV.set_this_event_follower_remove
	tmpEV.delete
	chcg_background_color(0,0,0,255,-7)
end

get_character(0).call_balloon(28,-1) if !set_comp
cam_center(0)
portrait_hide
$game_temp.choice = -1
