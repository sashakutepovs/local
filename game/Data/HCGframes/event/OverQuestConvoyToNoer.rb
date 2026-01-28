#sw1 =1 接受
if get_character(0).switch1_id != 1 #&& $game_player.actor.morality_lona >=10
	call_msg("commonNPC:Qgiver/ConvoyToNoer_begin0")
	call_msg("commonNPC:Qgiver/ConvoyToNoer_begin1")
	call_msg("commonNPC:Qgiver/ConvoyToNoer_board")
	call_msg("common:Lona/Decide_optB")
	set_comp=false
	if $game_temp.choice ==1 && $game_player.record_companion_name_ext == nil
		set_comp=true
	elsif $game_temp.choice ==1 && $game_player.record_companion_name_ext != nil
		$game_temp.choice = -1
		call_msg("commonComp:notice/ExtOverWrite")
		call_msg("common:Lona/Decide_optD")
		if $game_temp.choice ==1
		set_comp=true
		end
	end

	if set_comp
		chcg_background_color(0,0,0,0,7)
		$story_stats["RecQuestConvoyTarget"] = [21,22] #Inside Noer
		tar = ["CompExtConvoyNoerF",
				"CompExtConvoyNoerM"]
		tarNpc= tar.sample
		get_character(0).switch1_id =1
		get_character(0).call_balloon(0)
		get_character(0).set_this_event_companion_ext(tarNpc,false,10+$game_date.dateAmt)
		$game_map.reserve_summon_event(tarNpc,$game_player.x,$game_player.y)
		chcg_background_color(0,0,0,255,-7)
		call_msg("commonNPC:Qgiver/ConvoyToNoer_accept")
		
	end
	$game_temp.choice = -1
else
SndLib.sound_QuickDialog
$game_map.popup(get_character(0).id,"QuickMsg:NPC/ReqLonaTo#{rand(3)}",0,0)
end
