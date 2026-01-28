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



	call_msg("TagMapSouthFL:MaleDoomed/CommonHuman#{rand(4)}")
	tmp_Prostitution = $game_player.actor.stat["Prostitute"] ==1 && get_character(0).summon_data[:SexTradeble]
	tmp_Begging = $game_player.actor.weak >= 50 && get_character(0).summon_data[:SexTradeble]
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
				play_sex_service_menu(get_character(0),0.3,nil)
				tmpReward = [
					"ItemApple",		"ItemBread",
					"ItemCheese",		"ItemMushroom",
					"ItemSausage",		"ItemGrapes",
					"ItemOrange",		"ItemNuts",
					"ItemOnion",		"ItemPepper",
					"ItemBlueBerry",		"ItemFish",
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
