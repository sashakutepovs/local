if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if $game_player.actor.stat["equip_head"] == "DocHead"
	SndLib.sound_QuickDialog
	$game_map.popup(get_character(0).id,"CompElise:BirbMaskedLona/Qmsgpop#{rand(5)}",0,0)
	get_character(0).call_balloon([5,6,7].sample)
	return
end

if $story_stats["RecQuestElise"] ==0
call_msg("TagMapNoerEliseGynecology:elise/day_1TimeBegin0")
call_msg("TagMapNoerEliseGynecology:elise/day_1TimeBegin1")
$story_stats["RecQuestElise"] = 1
$story_stats["RecQuestEliseAmt"] = 6+$game_date.dateAmt

################################################################ ABOM BAT
elsif $story_stats["RecQuestElise"] == 5 && $game_date.dateAmt >= $story_stats["RecQuestEliseAmt"] && $game_date.day?
	tmpMobAlive = $game_map.npcs.any?{
		|event| 
		next unless event.summon_data
		next unless event.summon_data[:abomBat]
		next if event.deleted?
		next if event.npc.action_state == :death
		true
	}
	if !tmpMobAlive
		call_msg("CompElise:RecQuestElise5/end0")
		call_msg("CompElise:RecQuestElise5/end1")
		call_msg("CompElise:RecQuestElise5/end2") #[懂,蝦？]
		if $game_temp.choice == 0
			call_msg("CompElise:RecQuestElise5/end2_y")
		else
			call_msg("CompElise:RecQuestElise5/end2_n")
			get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],430)
		end
		$story_stats["RecQuestElise"] = 6
		$story_stats["RecQuestEliseAmt"] = 1 + $game_date.dateAmt
	else
		call_msg("its escaped, kill it!, dont let it escape!")
	end

################################################################收集體力藥草
elsif $story_stats["QuProgStaHerbCollect"]==1 && $game_party.item_number($data_items[27]) >=4
	get_character(0).call_balloon(0)
	$story_stats["QuProgStaHerbCollect"] = 2
	$game_party.lose_item($data_items[27],4)
	call_msg("TagMapNoerEliseGynecology:elise/StaHerbCollect0")
	SndLib.sound_equip_armor
	$game_map.popup(0,"-4",$data_items[27].icon_index,-1)
	call_msg("TagMapNoerEliseGynecology:elise/StaHerbCollect1")

################################################################ 幫LISA治療
elsif $story_stats["RecQuestLisa"] == 15 && $game_player.record_companion_name_ext == "CompExtUniqueLisaDown"
	$story_stats["RecQuestLisaAmt"] = 6 + $game_date.dateAmt
	
	call_msg("CompLisa:Lisa16/ElisaTalk0")
	get_character(0).call_balloon(0)
	portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			tmpLisaEV = get_character($game_map.get_storypoint("lisa")[2])
			tmpEliseX,tmpEliseY=$game_map.get_storypoint("elise")
			bedEV=$game_map.events[$game_map.get_storypoint("DoTricket")[2]]
			tmpLisaEV.moveto(bedEV.x,bedEV.y)
			set_event_force_page(tmpLisaEV.id,1)
			tmpLisaEV.set_npc("NeutralHp1Sandbag")
			tmpLisaEV.npc.death_event = "EffectLisaHiveDed"
			tmpLisaEV.balloon_XYfix = -20
			tmpLisaEV.forced_y = -16
			tmpLisaEV.animation = tmpLisaEV.animation_overfatigue_stable
			get_character($game_player.get_followerID(-1)).set_this_companion_disband
			$game_player.moveto(tmpLisaEV.x+1,tmpLisaEV.y)
			$game_player.direction = 4
			get_character(0).moveto(tmpLisaEV.x-1,tmpLisaEV.y)
			get_character(0).direction = 6
		call_msg("CompLisa:Lisa16/ElisaTalk1")
		chcg_background_color(0,0,0,255,-7)
	call_msg("CompLisa:Lisa16/ElisaTalk2")
	get_character(0).npc_story_mode(true)
	get_character(0).move_forward_force ; wait(40)
	get_character(0).animation = get_character(0).animation_atk_sh
	wait(10)
	optain_item($data_items[147],1) #ItemBerserkDrug
	wait(20)
	get_character(0).npc_story_mode(false)
	if $story_stats["RecQuestElise"] >= 40
		$story_stats["RecQuestLisa"] = 17 #KEEP MEMORY
		call_msg("CompLisa:Lisa16/ElisaTalk3_berY")
	else
		$story_stats["RecQuestLisa"] = 16 #Reset Memory
		call_msg("CompLisa:Lisa16/ElisaTalk3_berN")
	end
	call_msg("CompLisa:Lisa16/ElisaTalk4")
	
	portrait_hide
		chcg_background_color(0,0,0,0,7)
			cam_center(0)
			portrait_off
			get_character(0).moveto(tmpEliseX,tmpEliseY)
			get_character(0).direction = 2
		chcg_background_color(0,0,0,255,-7)
	call_msg("CompLisa:Lisa16/ElisaTalk5")
	optain_exp(3500)
	
	
############################################################### 一般對話
else
	tmpOrcResearch = $story_stats["RecQuestElise"] == 1 && $game_date.dateAmt >= $story_stats["RecQuestEliseAmt"] && !$DEMO
	tmpFishtopiaIsle = $story_stats["RecQuestElise"].between?(7,13) #漁人島 
	
		
	has_ItemAMT=0
	$game_party.all_items.each{
		|item|
		next if !item.type.eql?("Baby")
		next if item.common_tags["baby_MouthRace"] == "Human"
		next if item.common_tags["baby_MouthRace"] == "Moot"
		amt=$game_party.item_number(item)
		for i in 0...amt
		has_ItemAMT += $game_party.item_number(item)
		end
	}
	tmpHasBaby = has_ItemAMT > 0#$game_party.has_item_type("Baby")
	tmpLisaAbom = [16,17].include?($story_stats["RecQuestLisa"])
		tmpPicked = ""
		tmpQuestList = []
		tmpQuestList << [$game_text["TagMapNoerEliseGynecology:elise/DayTalkOPT_Cancel"]				,"Cancel"]			
		tmpQuestList << [$game_text["TagMapNoerEliseGynecology:elise/DayTalkOPT_Talk"]					,"Talk"]			if !tmpLisaAbom
		tmpQuestList << [$game_text["TagMapNoerEliseGynecology:elise/DayTalkOPT_LisaAbom"]				,"LisaAbom"]		if tmpLisaAbom
		tmpQuestList << [$game_text["commonNPC:commonNPC/Barter"]										,"Barter"]
		tmpQuestList << [$game_text["TagMapNoerEliseGynecology:elise/DayTalkOPT_PregnancyCheck"]		,"PregnancyCheck"]	
		tmpQuestList << [$game_text["TagMapNoerEliseGynecology:elise/DayTalkOPT_OrcResearch"]			,"OrcResearch"]		if tmpOrcResearch
		tmpQuestList << [$game_text["TagMapNoerEliseGynecology:elise/DayTalkOPT_FishtopiaIsle"]			,"FishtopiaIsle"]	if tmpFishtopiaIsle
		tmpQuestList << [$game_text["TagMapNoerEliseGynecology:elise/DayTalkOPT_SellBaby"]				,"SellBaby"]	if tmpHasBaby
		cmd_sheet = tmpQuestList
		cmd_text =""
		for i in 0...cmd_sheet.length
			cmd_text.concat(cmd_sheet[i].first+",")
		end
		call_msg("TagMapNoerEliseGynecology:elise/day_talk",0,2,0)
		call_msg("\\optB[#{cmd_text}]")
		
		$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
		$game_temp.choice = -1
	case tmpPicked
		when "Talk"
			call_msg("TagMapNoerEliseGynecology:elise/day_talk_about0")
			call_msg("TagMapNoerEliseGynecology:elise/day_talk_about1")
		when "LisaAbom"
			if $game_date.dateAmt >= $story_stats["RecQuestLisaAmt"] 
				call_msg("CompLisa:Lisa16_17/NotThere0")
				call_msg("CompLisa:Lisa16_17/NotThere1")
			else
				call_msg("CompLisa:Lisa16_17/StillThere0")
				call_msg("CompLisa:Lisa16_17/StillThere1_#{rand(3)}")
				call_msg("CompLisa:Lisa16_17/StillThere2_2")
			end
			
		when "Barter"
			#$story_stats["HiddenOPT2"] = "1" if $game_party.has_item_type("Baby")
			manual_barters("NoerGynecologyEliseDay")

		when "PregnancyCheck"
			call_msg("TagMapNoerEliseGynecology:elise/preg_check_begin1")
			portrait_off
			tmpAggro = false
			chcg_background_color(0,0,0,0,7)
				wait(30)
				3.times{
					$game_portraits.lprt.shake
					$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
					SndLib.sound_combat_hit_gore(90,50+rand(100))
					wait(30)+rand(60)
				}
				if $game_player.actor.preg_level >= 1
					$story_stats["HiddenOPT1"] = $game_player.actor.preg_whenGiveBirth?-(rand(5)-2)
					$game_player.actor.stat["displayBabyHealth"] = 1
					call_msg("TagMapNoerEliseGynecology:elise/preg_check_win0")
					call_msg("TagMapNoerEliseGynecology:elise/preg_check_win1")
					call_msg("TagMapNoerEliseGynecology:elise/preg_check_win2")
					$story_stats["HiddenOPT1"] = "0"
					
				else
					tmpAggro = true
					call_msg("TagMapNoerEliseGynecology:elise/preg_check_failed0")
					get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],600)
				end
				portrait_hide
				wait(30)
			chcg_background_color(0,0,0,255,-7)
			call_msg("TagMapNoerEliseGynecology:elise/preg_check_failed1") if tmpAggro
		
		when "OrcResearch"
			call_msg("CompElise:OrkindResearch1/begin0")
			call_msg("CompElise:OrkindResearch1/begin1")
			call_msg("CompElise:OrkindResearch1/begin2")
			case $game_temp.choice 
				when 0,-1
					call_msg("CompElise:OrkindResearch1/begin2_No")
				when 1
					
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
						call_msg("CompElise:OrkindResearch1/begin2_Yes1")
						portrait_hide
							chcg_background_color(0,0,0,0,7)
							get_character(0).set_this_event_companion_ext("CompExtUniqueElise",false,10+$game_date.dateAmt)
							get_character(0).delete
							$game_map.reserve_summon_event("CompExtUniqueElise",$game_player.x,$game_player.y)
							chcg_background_color(0,0,0,255,-7)
						call_msg("CompElise:OrkindResearch1/begin2_Yes2")
					end
			end
			
		when "FishtopiaIsle"
			#return call_msg("dev") #################################################################################### REMOVE AFTER ITS DONE
			if $game_player.player_slave?
				call_msg("CompElise:FishResearch1/slaveBlock")
				return eventPlayEnd
			end
			call_msg("CompElise:FishResearch1/begin0")
			call_msg("CompElise:FishResearch1/begin1")
			call_msg("CompElise:FishResearch1/begin2")
			case $game_temp.choice 
				when 0,-1
					call_msg("CompElise:OrkindResearch1/begin2_No")
				when 1
					
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
						call_msg("CompElise:OrkindResearch1/begin2_Yes1")
						portrait_hide
							chcg_background_color(0,0,0,0,7)
							get_character(0).set_this_event_companion_ext("CompExtUniqueElise",false,10+$game_date.dateAmt)
							get_character(0).delete
							$game_map.reserve_summon_event("CompExtUniqueElise",$game_player.x,$game_player.y)
							chcg_background_color(0,0,0,255,-7)
						call_msg("CompElise:OrkindResearch1/begin2_Yes2")
					end
			end

			when"SellBaby"
				call_msg("TagMapNoerEliseGynecology:elise/sell_baby_begin1")
				tmpAbom = $game_party.item_number($data_items[71]) #PlayerAbominationBaby
				
				
				temp_val=0
				$game_party.all_items.each{
					|item|
					next if !item.type.eql?("Baby")
					next if item.common_tags["baby_MouthRace"] == "Human"
					next if item.common_tags["baby_MouthRace"] == "Moot"
					amt=$game_party.item_number(item)
					for i in 0...amt
					temp_val += item.price
					end
				}
				tar_price= temp_val #$game_party.get_item_type_price("Baby")
				tar_price*=10
				
				
				
				temp_val=0
				$game_party.all_items.each{
					|item|
					next if !item.type.eql?("Baby")
					next if item.common_tags["baby_MouthRace"] == "Human"
					next if item.common_tags["baby_MouthRace"] == "Moot"
					amt=$game_party.item_number(item)
					$game_party.lose_item(item,$game_party.item_number(item),true)
				}
				#$game_party.lost_item_type("Baby")
				portrait_hide
				chcg_background_color(0,0,0,0,7)
					wait(60)
					portrait_off
				chcg_background_color(0,0,0,255,-7)
				optain_item_chain(tar_price,["ItemCoin1","ItemCoin2","ItemCoin3"],false)
				
				call_msg("TagMapNoerEliseGynecology:elise/sell_baby_begin2")
				call_msg("TagMapNoerEliseGynecology:elise/sell_baby_begin3") if $story_stats["RecQuestEliseBabySale"] == 0
				$story_stats["RecQuestEliseBabySale"] += 1
				$story_stats["RecQuestEliseAbomBabySale"] += tmpAbom
				
		end # case
	end # end day_talk


$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT2"] = "0"
$game_temp.choice = -1

prev_RecQuestEliseAbortion = $story_stats["RecQuestEliseAbortion"]
############################################################### 手術演出 ##############################################################################
if $game_party.has_item_type("SurgeryCoupon")
	call_msg("TagMapNoerEliseGynecology:elise/surgery_begin0")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		call_msg("TagMapNoerEliseGynecology:elise/surgery_begin1")
		tmpDoTricketX,tmpDoTricketY,tmpDoTricketID=$game_map.get_storypoint("DoTricket")
		tar_elise=get_character(0)
		$game_player.moveto(get_character(tmpDoTricketID).x,get_character(tmpDoTricketID).y) ; $game_player.direction = 2
		$game_player.animation = $game_player.animation_overfatigue
		get_character(0).moveto($game_player.x-1,$game_player.y) ; get_character(0).direction = 6
		portrait_hide
	chcg_background_color(0,0,0,255,-7)
	
	call_msg("TagMapNoerEliseGynecology:elise/surgery_begin2")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
	
		call_msg("TagMapNoerEliseGynecology:elise/surgery_begin3") 				if !$game_party.has_item?($data_items[201])#墮胎票
		
		no_end_dialog =0
		#結渣卷 沒懷孕
		call_msg("TagMapNoerEliseGynecology:elise/surgery_begin3_Miscarriage") 	if $game_party.has_item?($data_items[201])
		if $game_party.has_item?($data_items[201]) && $game_player.actor.preg_level ==0 #有墮胎票但沒懷孕 #id 201
			map_background_color(0,0,0,255,0)
			call_msg("TagMapNoerEliseGynecology:elise/surgery_begin3_Miscarriage_nopreg1")
			call_msg("TagMapNoerEliseGynecology:elise/surgery_begin3_Miscarriage_nopreg2")
			$game_player.actor.health = 0
			return load_script("Data/HCGframes/OverEvent_Death.rb")
		elsif $game_party.has_item?($data_items[201]) && $game_player.actor.preg_level >=1
			#墮胎票 有懷孕
			map_background_color(0,0,0,255,0)
			portrait_hide
			wait(15)
			SndLib.sys_equip
			wait(30)
			call_msg("TagMapNoerEliseGynecology:elise/surgery_begin3_Miscarriage_endFB")
			6.times{
				$game_portraits.lprt.shake
				$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
				SndLib.sound_combat_hit_gore(90,50+rand(100))
				wait(30)+rand(60)
			}
			portrait_hide
			wait(10)
			tmpRecRace = $game_player.actor.baby_race
			tmpRecRace = "OthersElise" if tmpRecRace == "Others"
			tmpPregLvl = $game_player.actor.preg_level
			load_script("Data/HCGframes/BirthEvent_Miscarriage.rb")
			portrait_off
			wait(30)
			SndLib.sys_equip
			wait(30)
			$game_message.add("#{$game_text["TagMapNoerEliseGynecology:elise/surgery_begin3_Miscarriage_endF1"]}#{$game_text["DataNpcName:race/#{tmpRecRace}"]}#{$game_text["TagMapNoerEliseGynecology:elise/surgery_begin3_Miscarriage_endF2"]}#{$game_text["TagMapNoerEliseGynecology:elise/surgery_begin3_Miscarriage_endF3_preg_level#{tmpPregLvl}"]}")
			$game_map.interpreter.wait_for_message
			portrait_hide
			no_end_dialog = 0
			$story_stats["RecQuestEliseAbortion"] += 1
		end
		
		#治療烙印
		if $game_party.has_item?($data_items[208])
			$story_stats["SlaveOwner"] = 0
		end
		
		$game_party.force_use_item_type("SurgeryCoupon")
		$game_party.lost_item_type("SurgeryCoupon")
		
		
		
		########################################################## 手術完成
	map_background_color
	$game_player.animation = nil
	chcg_background_color(0,0,0,255,-7)
	if no_end_dialog ==0
		call_msg("TagMapNoerEliseGynecology:elise/surgery_end")
		portrait_hide
	end
	#return eveny thing to normal
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		cam_center(0)
		get_character(tmpDoTricketID).summon_data[:canSleep] = true
		posi=$game_map.get_storypoint("elise")
		get_character(0).moveto(posi[0],posi[1]) ; get_character(0).direction = 2
	chcg_background_color(0,0,0,255,-7)
end

$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT2"] = "0"
$story_stats["HiddenOPT3"] = "0"
achCheckEliseAbortion if $story_stats["RecQuestEliseAbortion"] != prev_RecQuestEliseAbortion
eventPlayEnd


##### check balloon
get_character(0).call_balloon(0)

tmpQ1 = $game_party.item_number($data_items[27]) >= 4
return get_character(0).call_balloon(28,-1) if $story_stats["QuProgStaHerbCollect"]==1 && tmpQ1
return if $DEMO
tmpDay = $game_date.day?
tmpQ1 = $story_stats["RecQuestElise"] == 1
tmpQ2 = $game_date.dateAmt >= $story_stats["RecQuestEliseAmt"]
return get_character(0).call_balloon(28,-1) if tmpQ1 && tmpQ2 && tmpDay
tmpQ1= $game_party.has_item?($data_items[107])
tmpQ2=$story_stats["RecQuestElise"] ==4
return get_character(0).call_balloon(28,-1) if tmpQ1 && tmpQ2 && tmpDay
tmpQ1 = $game_date.dateAmt >= $story_stats["RecQuestEliseAmt"]
tmpQ2 = $story_stats["RecQuestElise"] == 6
return get_character(0).call_balloon(28,-1) if tmpDay && tmpQ1 && tmpQ2
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestElise"] == 7
#幫麗莎治療
tmpQ2 = $story_stats["RecQuestLisa"] == 15
tmpQ3 = $game_player.record_companion_name_ext == "CompExtUniqueLisaDown"
return get_character(0).call_balloon(28,-1) if tmpQ2 && tmpQ3
####
