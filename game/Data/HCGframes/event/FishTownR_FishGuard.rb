p get_character(0).id
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

tmpMCid = $game_map.get_storypoint("MapCont")[2]

if get_character(0).summon_data[:SexTradeble] == true && $story_stats["Captured"] == 1 && get_character(tmpMCid).summon_data[:JobPick] == "FindParnter"
	tmpSavedMoveType = get_character(0).move_type
	tmpSavedDir	= get_character(0).original_direction
	get_character(0).move_type = 0
	get_character(0).summon_data[:SexTradeble] = false
	get_character(0).summon_data[:FindParnter_Did] = true
		tmpReturnX = get_character(0).x
		tmpReturnY = get_character(0).y
		tmpMoveType = get_character(0).move_type
		tmpDir = get_character(0).direction
		get_character(0).turn_toward_character($game_player)
		$game_player.animation = $game_player.animation_stun
			$cg = TempCG.new(["event_WhoreWork"])
			call_msg("common:Lona/lure#{talk_style}#{rand(2)}")
			$cg.erase
			$game_player.animation = nil
			get_character(0).animation = get_character(0).animation_hold_sh
			cam_follow(get_character(0).id,0)
			get_character(0).call_balloon(20)
			call_msg("TagMapFishTown:Guards/OfferSex0_#{rand(2)}")
			wait(10)
			get_character(0).moveto($game_player.x,$game_player.y)
				portrait_off
				play_sex_service_main(ev_target=get_character(0),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=nil)
				play_sex_service_main(ev_target=get_character(0),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=nil)
				portrait_off
				get_character(0).call_balloon(20)
				call_msg("TagMapFishTown:wakeUpRape/begin2_#{rand(3)}")
				portrait_off
				play_sex_service_main(ev_target=get_character(0),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=nil)
				play_sex_service_main(ev_target=get_character(0),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=nil)
				play_sex_service_main(ev_target=get_character(0),temp_tar_slot="vag",passive=true,tmpCumIn=true,forcePose=nil)
				portrait_off
				get_character(0).call_balloon(20)
				call_msg("TagMapFishTown:wakeUpRape/begin3_#{rand(3)}")
				portrait_off
				$game_player.actor.stat["EventVagRace"] =  "Fishkind"
				$game_player.actor.stat["EventVag"] = "CumInside1"
				load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb")
				whole_event_end
				portrait_off
				wait(40)
			get_character(0).unset_event_chs_sex
			$game_player.unset_event_chs_sex
			$game_player.animation = nil
			$game_player.actor.set_action_state(:none)
			get_character(0).animation = nil
			get_character(0).npc_story_mode(false)
			get_character(0).moveto(tmpReturnX,tmpReturnY)
			get_character(0).move_type = tmpMoveType
			get_character(0).direction = tmpDir
			get_character(0).call_balloon(0)
			call_msg("TagMapFishTown:wakeUpRape/begin4_#{rand(3)}")
			call_msg("TagMapFishTown:wakeUpRape/begin5")
		tmpCount = 0
		$game_map.npcs.each{
			|event|
			next unless event.summon_data
			next unless event.summon_data[:SexTradeble] == false
			next if event.deleted?
			tmpCount += 1
		}
		if tmpCount >= 2
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:House2OutTag]
				event[1].call_balloon(28,-1)
			}
			$game_map.npcs.each{|event|
				next if !event.summon_data
				next if !event.summon_data[:guard]
				next if !event.summon_data[:SexTradeble] == true
				event.call_balloon(0)
			}
			
		end
		get_character(0).move_type = tmpSavedMoveType
		get_character(0).direction = tmpSavedDir
		get_character(0).set_original_direction(tmpSavedDir)
	return eventPlayEnd
end
	call_msg("commonNPC:MaleFishKindGuard/begin1#{npcFish_talk_style}")
	tmp_Prostitution = $game_player.actor.stat["Prostitute"] ==1 && get_character(0).summon_data[:SexTradeble]
	tmp_Begging = $game_player.actor.stat["SlaveBrand"] == 1 && $game_player.actor.weak >= 50 && get_character(0).summon_data[:SexTradeble]
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Prostitution"]		,"Prostitution"] if tmp_Prostitution
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
		when "Barter"
			manual_barters("FishKindGuards")
			
		when "Prostitution"
			get_character(0).summon_data[:SexTradeble] = false
			$game_temp.choice == 0
			call_msg("commonNPC:RandomNpc/WhoreWork#{talk_style}")
			call_msg("commonNPC:RandomNpc/choosed")
			$game_player.actor.sta -=1 #WhoreWorkCost
			temp_vs1=50+rand(50)
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
				play_sex_service_menu(get_character(0),0.7,tmpPoint,false,fetishLVL=3,forceCumIn=true)
				tmpReward = ["ItemFish"]
				tmpReward << "ItemCoin2" if $game_player.actor.stat["SlaveBrand"] != 1
				play_sex_service_items(get_character(0),tmpReward,prev_gold)
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
				temp_tar = 50+rand(50) ##############   Begging Diff
				tmpWeak = $game_player.actor.weak + $game_player.actor.wisdom*rand(10)
				call_msg("\\narr #{tmpWeak.round} VS #{temp_tar.round}")
				if tmpWeak >=  temp_tar #### WIN
					$game_player.actor.mood += 10
					call_msg("commonNPC:Begging/Win")
					call_msg("commonNPC:Begging/Win_End")
					temp_food_list= [12]
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
