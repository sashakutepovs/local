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
	call_msg("commonComp:CompFishGuard/begin")
	canFuck = get_character(0).summon_data[:SexTradeble] && $game_player.record_companion_name_front != get_character(0).name
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonComp:Companion/TeamUp"]			,"TeamUp"] if canFuck && $game_player.record_companion_name_front != get_character(0).name && !$game_player.player_slave?
	tmpTarList << [$game_text["commonComp:Companion/Disband"]			,"Disband"] if $game_player.record_companion_name_front == get_character(0).name
	tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"] if !$game_player.player_slave?
	tmpTarList << [$game_text["commonNPC:commonNPC/Prostitution"]		,"Prostitution"] if canFuck && $game_player.actor.stat["Prostitute"] ==1
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	#call_msg("commonNPC:MaleHumanRandomNpc/CommonHuman_CommonNpcOpt",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
	
	case tmpPicked
	when "TeamUp"
		call_msg("commonComp:CompFishGuard/CompData")
		call_msg("commonComp:CompFishGuard/sex0")
		show_npc_info(get_character(0),extra_info=false,"commonComp:Companion/Accept") 			#\optD[算了，確定]
		case $game_temp.choice
			when 0,-1
				call_msg("commonComp:Lona/notWhore0")
			when 1
				if ($game_player.actor.stat["Prostitute"] == 1 || $game_player.actor.stat["Nymph"] == 1) && $game_player.actor.stat["SlaveBrand"] !=1
				call_msg("commonNPC:RandomNpc/WhoreWork#{talk_style}")
				$cg.erase
				call_msg("commonComp:CompFishGuard/sex1")
				get_character(0).animation = get_character(0).animation_hold_sh
				cam_follow(get_character(0).id,0)
				get_character(0).call_balloon(20)
				call_msg("TagMapFishTown:Guards/OfferSex0_#{rand(2)}")
				tmpLonaX = $game_player.x
				tmpLonaY = $game_player.y
				$game_player.moveto(get_character(0).x,get_character(0).y)
				wait(10)
				get_character(0).summon_data[:SexTradeble] = false
				play_sex_service_menu(get_character(0),0,tmpPoint=nil,true,fetishLVL=3,forceCumIn=true)
				whole_event_end
				
				$game_player.moveto(tmpLonaX,tmpLonaY)
				get_character(0).set_this_event_companion_front(get_character(0).name,false,$game_date.dateAmt+6)
				call_msg("commonComp:CompFishGuard/Comp_win")
				
				elsif $game_player.actor.stat["SlaveBrand"] == 1
					call_msg("commonComp:CompFishGuard/Comp_failed_slave")
				else
					call_msg("commonComp:Lona/notWhore0")
					call_msg("commonComp:CompFishGuard/Comp_failed")
					call_msg("commonComp:Lona/notWhore1")
				end
		end
	when "Disband"
		call_msg("commonComp:Companion/Accept") 			#\optD[算了，確定]
			case $game_temp.choice
				when 0,-1
				when 1
					call_msg("commonComp:CompFishGuard/Comp_disband")
					get_character(0).set_this_companion_disband(false)
			end
			
	when "Barter"
			manual_barters("FishTownInnCompFishGuard")
		
	when "Prostitution"
		get_character(0).summon_data[:SexTradeble] = false
		$game_temp.choice == 0
		call_msg("commonNPC:RandomNpc/WhoreWork#{talk_style}")
		call_msg("commonNPC:RandomNpc/choosed")
		$game_player.actor.sta -=1 #WhoreWorkCost
			temp_vs1=rand(50)
			temp_fishkind_vs2= $game_player.actor.weak + (100*(($game_player.actor.state_preg_rate-10) + $game_player.actor.get_preg_rate_on_date($game_player.actor.currentDay))) #魚類特化性交易難度
			#no m
			call_msg("\\narr #{temp_fishkind_vs2.round} VS #{temp_vs1.round}")
			if temp_fishkind_vs2 > temp_vs1
				$game_player.actor.mood +=10
				$story_stats["sex_record_whore_job"] +=1
				$game_player.actor.record_lona_title = "WhoreJob/title_hooker" if $story_stats["sex_record_whore_job"] % 10 == 0
				call_msg("commonNPC:RandomNpc/WhoreWork_win")
				prev_gold = $game_party.gold
				$game_player.actor.stat["SlaveBrand"] == 1 ? tmpPoint = nil : tmpPoint =  "closest"
				get_character(0).summon_data[:SexTradeble] = false
				play_sex_service_menu(get_character(0),0.5,tmpPoint,false,fetishLVL=3,forceCumIn=true)
				tmpReward = ["ItemFish"]
				tmpReward << "ItemCoin2" if $game_player.actor.stat["SlaveBrand"] != 1
				play_sex_service_items(get_character(0),tmpReward,prev_gold)
			else
			$game_actors[1].mood -=3
			call_msg("commonNPC:RandomNpc/WhoreWork_failed")
		end
	end
	

eventPlayEnd
