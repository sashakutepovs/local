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
nurseEvID = 0
tmpNurseAlive = $game_map.npcs.any?{|ev|
	next unless ev.summon_data
	next unless ev.summon_data[:SaintWorker]
	next unless [:none,nil].include?(ev.npc.action_state)
	nurseEvID = ev.id
	true
}

	call_msg("TagMapSouthFL:MaleDoomed/CommonHuman#{rand(4)}")
	tmp_Prostitution = $game_player.actor.stat["Prostitute"] ==1 && get_character(0).summon_data[:SexTradeble]
	tmp_Begging = $game_player.actor.weak >= 50 && get_character(0).summon_data[:SexTradeble]
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["TagMapSouthFL:InnWork/Purge"]			,"Purge"] if get_character(0).summon_data[:NeedCure] && get_character(0).summon_data[:DoingJob] && tmpNurseAlive
	tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Prostitution"]		,"Prostitution"] if tmp_Prostitution && !get_character(0).summon_data[:DoingJob]
	tmpTarList << [$game_text["commonNPC:commonNPC/Begging"]			,"Begging"] if tmp_Begging
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("commonNPC:MaleHumanRandomNpc/CommonHuman_CommonNpcOpt",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
				
	case tmpPicked
		when "Purge"
			get_character(nurseEvID).turn_toward_character($game_player)
			call_msg("TagMapSouthFL:healerFInn/WorkDOing_begin1")
			get_character(nurseEvID).turn_toward_character($game_player)
			call_msg("TagMapSouthFL:healerFInn/WorkDOing_begin0_#{rand(3)}")
			get_character(0).summon_data[:NeedCure] = false
			get_character(0).summon_data[:SexTradeble] = false
			chcg_background_color(0,0,0,0,7)
				get_character(nurseEvID).process_npc_DestroyForceRoute
				get_character(nurseEvID).npc_story_mode(true)
				get_character(nurseEvID).moveto($game_player.x,$game_player.y)
				get_character(nurseEvID).item_jump_to
				get_character(nurseEvID).move_type = 0
				tmp_nurseEvID_move_type = get_character(nurseEvID).move_type
				get_character(nurseEvID).turn_toward_character($game_player)
				until !get_character(nurseEvID).moving?
					wait(1)
				end
			chcg_background_color(0,0,0,255,-7)
			whole_event_end
			get_character(nurseEvID).animation = get_character(nurseEvID).animation_grabber_qte($game_player)
			$game_player.animation = $game_player.animation_grabbed_qte
				$game_player.actor.stat["EventExt1Race"] = "Human"
				load_script("Data/HCGframes/Grab_EventExt1_Grab.rb")
				get_character(nurseEvID).call_balloon(8)
				wait(15)
			call_msg("TagMapSouthFL:healerFInn/WorkDOing_begin2")
			$cg = TempCG.new(["event_OpenVag"])
			call_msg("TagMapSouthFL:healerFInn/WorkDOing_begin3")
			call_msg("TagMapSouthFL:healerFInn/WorkDOing_begin4")
			$cg.erase
			whole_event_end
			
			tmpVagScore = 0
			tmpAnalScore = 0
			prevTmpVagCum = $game_player.actor.cumsMeters["CumsCreamPie"]
			prevTmpAnalCum = $game_player.actor.cumsMeters["CumsMoonPie"]
			prev_gold = $game_party.gold
			tmpFetish=[2,3].sample
			play_sex_service_menu(ev_target=get_character(0),plus=0,sex_point=nil,tmp_auto=false,fetishLVL=tmpFetish,forceCumIn=true,noRefuse=true,noCumInOPT=true)
			get_character(nurseEvID).animation = nil
			$game_player.animation = nil
			if [true,false].sample
				call_msg("TagMapSouthFL:healerFInn/WorkDOing_getSemen0")
				get_character(nurseEvID).animation = get_character(nurseEvID).animation_grabber_qte($game_player)
				$game_player.animation = $game_player.animation_grabbed_qte
				wait(30)
				2.times{
					$game_player.actor.stat["EventVagRace"] = "Human"
					load_script("Data/HCGframes/Grab_EventVag_VagTouch.rb")
					get_character(nurseEvID).call_balloon(8)
					wait(50)
				}
			end
				
				current_gold = $game_party.gold
				tmpLosGold = prev_gold - current_gold
				$game_party.lose_gold(tmpLosGold)
				
				player_force_update
				currentTmpVagCum = $game_player.actor.cumsMeters["CumsCreamPie"]
				currentTmpAnalCum = $game_player.actor.cumsMeters["CumsMoonPie"]
				tmpVagScore  = currentTmpVagCum - prevTmpVagCum
				tmpAnalScore = currentTmpAnalCum - prevTmpAnalCum
				
				$story_stats["HiddenOPT1"] = (tmpVagScore+tmpAnalScore).to_i
			call_msg("TagMapSouthFL:healerFInn/WorkDOing_TotalScore0")
				get_character(nurseEvID).summon_data[:WorkScore] += $story_stats["HiddenOPT1"]
				
				get_character(nurseEvID).animation = nil
				$game_player.animation = nil
				$story_stats["HiddenOPT1"] = "0"
				get_character(nurseEvID).npc_story_mode(false)
				get_character(nurseEvID).move_type = tmp_nurseEvID_move_type
				whole_event_end
				
			call_msg("TagMapSouthFL:healerFInn/WorkDOing_TotalScore1")
			
		when "Barter"
			manual_barters("SouthFL_INN_RefugeeM")
			
		when "Prostitution"
			get_character(0).summon_data[:SexTradeble] = false
			$game_temp.choice == 0
			call_msg("commonNPC:RandomNpc/WhoreWork#{talk_style}")
			call_msg("commonNPC:RandomNpc/choosed")
			$game_player.actor.sta -=1 #WhoreWorkCost
			temp_vs1=5+rand(10) #性交易難度
			call_msg("\\narr 99 VS 0")
			if true
				$game_player.actor.mood +=10
				$story_stats["sex_record_whore_job"] +=1
				$game_player.actor.record_lona_title = "WhoreJob/title_hooker" if $story_stats["sex_record_whore_job"] % 10 == 0
				call_msg("commonNPC:RandomNpc/WhoreWork_win")
				prev_gold = $game_party.gold
				play_sex_service_menu(get_character(0),0.4,nil)
				tmpReward = [
					"ItemApple",		"ItemBread",
					"ItemCheese",		"ItemMushroom",
					"ItemSausage",		"ItemGrapes",
					"ItemOrange",		"ItemNuts",
					"ItemOnion",		"ItemPepper",
					"ItemBlueBerry",	"ItemFish",
					"ItemCarrot",		"ItemTomato",
					"ItemCherry",		"ItemPotato",
					"ItemDryFood"
					]
				tmpSuccess = play_sex_service_items(get_character(0),tmpReward.sample(3),prev_gold,summon=true)
				
			else
				$game_player.actor.mood -=3
				call_msg("commonNPC:RandomNpc/WhoreWork_failed")
			end
			
		when "Begging"
			1+rand(3).times{$game_player.actor.add_state("DoormatUp20")}
				get_character(0).summon_data[:SexTradeble] = false
				$game_player.animation = $game_player.animation_prayer
				call_msg("commonNPC:Begging/check")
				$game_player.actor.sta -= 3
				temp_tar = 200+rand(650) ##############   Begging Diff
				tmpWeak = $game_player.actor.weak + $game_player.actor.wisdom*rand(10)
				call_msg("\\narr #{tmpWeak.round} VS #{temp_tar.round}")
				if tmpWeak >=  temp_tar #### WIN
					$game_player.actor.mood += 10
					call_msg("commonNPC:Begging/Win")
					call_msg("commonNPC:Begging/Win_End")
					temp_food_list= [14,48,145]
					temp_get_from_list=temp_food_list[rand(temp_food_list.length)]
					optain_item($data_items[temp_get_from_list],1)
					get_character(0).animation = get_character(0).animation_atk_sh
				else #failed
					$game_player.actor.mood -= 10
					tmpMad = [true,false].sample
					if tmpMad
						call_msg("commonNPC:Begging/Aggro0")
						call_msg("commonNPC:Begging/Aggro1")
						call_msg("OvermapNoer:GateGuard/enter_failed#{talk_persona}")
						get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
					else
						call_msg("commonNPC:Begging/Aggro0")
						get_character(0).animation = get_character(0).animation_atk_mh
						get_character(0).call_balloon([15,7,5].sample)
						SndLib.sound_punch_hit(100)
						lona_mood "p5crit_damage"
						$game_player.actor.portrait.shake
						$game_player.actor.force_stun("Stun1")
						return eventPlayEnd
					end
				end
				$game_player.animation = nil
	end

eventPlayEnd
