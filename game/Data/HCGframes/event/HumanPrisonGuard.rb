if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if get_character(0).summon_data == nil
 get_character(0).set_summon_data({:SexTradeble => true})
elsif get_character(0).summon_data[:SexTradeble] == nil
 get_character(0).summon_data[:SexTradeble] = true
end
$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT1"] = "1" if $game_player.actor.stat["Prostitute"] ==1 && get_character(0).summon_data[:SexTradeble]
if $game_player.actor.stat["Prostitute"] ==1 && get_character(0).switch1_id ==0
	#make store [算了,交易,賣身<r=HiddenOPT1>]
	
	call_msg("TagMapHumanPrisonCave:HumanPrisonCave/Guard_begin1#{npc_talk_style}")
	call_msg("TagMapHumanPrisonCave:HumanPrisonCave/Guard_Opt")
	
	
	if $game_temp.choice == 1 
			manual_barters("HumanPrisonGuard")
	end
	
	if $game_temp.choice == 1 &&  get_character(0).summon_data[:SexTradeble]
		get_character(0).summon_data[:SexTradeble]
		$game_temp.choice == 0
		call_msg("commonNPC:RandomNpc/WhoreWork#{talk_style}")
		call_msg("commonNPC:RandomNpc/choosed")
		$game_player.actor.sta -=1 #WhoreWorkCost
		temp_vs1=60+rand(100) #性交易難度
		if $game_actors[1].sexy > temp_vs1
			$game_actors[1].mood +=10
			$story_stats["sex_record_whore_job"] +=1
			call_msg("commonNPC:RandomNpc/WhoreWork_win")
			play_sex_service_menu(get_character(0),1)
		else
			$game_actors[1].mood -=3
			call_msg("commonNPC:RandomNpc/WhoreWork_failed")
		end
	end
end
if get_character(0).switch1_id ==0
	get_character(0).animation = get_character(0).animation_atk_mh
	case rand(3)
		when 0;get_character(0).call_balloon(15)
		when 1;get_character(0).call_balloon(7)
		when 2;get_character(0).call_balloon(5)
	end
	

	combat_Hevent_Grab_Punch("Human",10)
	SndLib.sound_punch_hit(100)
	wait(30)
	whole_event_end
	call_msg_popup("QuickMsg:NPC/M_FUCKOFF#{rand(3)}",get_character(0).id)
end

$story_stats["HiddenOPT1"] = "0" 
$game_temp.choice = -1
