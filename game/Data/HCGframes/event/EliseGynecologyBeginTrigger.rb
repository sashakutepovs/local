return if $game_player.record_companion_name_ext == "CompExtUniqueElise"
return if $story_stats["UniqueCharUniqueElise"] == -1
tmpStX,tmpStY=$game_map.get_storypoint("StartPoint")
tmpLonaInStartXY = $game_player.x == tmpStX && $game_player.y == tmpStY
tmpEliseX,tmpEliseY,tmpEliseID=$game_map.get_storypoint("elise")
tmpEliseFapX,tmpEliseFapY,tmpEliseFapID=$game_map.get_storypoint("EliseFap")
tmpEliseSpX,tmpEliseSpY,tmpEliseSpID=$game_map.get_storypoint("EffectSpermHit")
tmpDoTricketX,tmpDoTricketY,tmpDoTricketID=$game_map.get_storypoint("DoTricket")
tmpBirthEVWakeUpX,tmpBirthEVWakeUpY,tmpBirthEVWakeUpID=$game_map.get_storypoint("BirthEVWakeUp")
tmpBirthEVdoorX,tmpBirthEVdoorY,tmpBirthEVdoorID=$game_map.get_storypoint("BirthEVdoor")
tmpFoodX,tmpFoodY,tmpFoodID = $game_map.get_storypoint("Food")
tmpDoBirthEV = $game_player.actor.preg_whenGiveBirth? <= 4
get_character(tmpDoTricketID).summon_data[:BirthEV] = tmpDoBirthEV

################################################################################################################ preg event
################################################################################################################ preg event
################################################################################################################ preg event
################################################################################################################ preg event
if get_character(tmpDoTricketID).summon_data[:BirthEV] == true && get_character(tmpDoTricketID).summon_data[:BirthLockedRoom] == false
	chcg_background_color(0,0,0,255,-255)
	call_msg("TagMapNoerEliseGynecology:elise/GiveBirthBegin0") ; portrait_hide
	get_character(tmpEliseID).npc_story_mode(true)
	SndLib.sound_equip_armor
	get_character(tmpEliseID).jump_to($game_player.x,$game_player.y)
	get_character(tmpEliseID).item_jump_to
	get_character(tmpEliseID).turn_toward_character($game_player)
	wait(16)
	get_character(tmpEliseID).jump_to(get_character(tmpEliseID).x,get_character(tmpEliseID).y)
	get_character(tmpEliseID).turn_toward_character($game_player)
	SndLib.sound_step(80)
	wait(5)
	SndLib.sound_step(50)
	wait(10)
	get_character(tmpEliseID).animation = get_character(tmpEliseID).animation_ClapSlow
	call_msg("TagMapNoerEliseGynecology:elise/GiveBirthBegin1")
	get_character(tmpEliseID).jump_to(get_character(tmpEliseID).x,get_character(tmpEliseID).y)
	get_character(tmpEliseID).turn_toward_character($game_player)
	call_msg("TagMapNoerEliseGynecology:elise/GiveBirthBegin2")
	SndLib.sound_equip_armor(80,50)
	get_character(tmpEliseID).animation = get_character(tmpEliseID).animation_grabber_qte($game_player)
	$game_player.animation = $game_player.animation_grabbed_qte
	call_msg("TagMapNoerEliseGynecology:elise/GiveBirthBegin3") ; portrait_hide#喝,考慮一下
	if $game_temp.choice == 0
		call_msg("TagMapNoerEliseGynecology:elise/GiveBirthBegin_YES0") ; portrait_hide
		$game_player.animation = nil
		get_character(tmpEliseID).animation = nil
		$game_map.popup(0,"",192,-1)
		SndLib.sound_drink2
		wait(30)
		SndLib.sound_drink3
		wait(30)
		get_character(tmpEliseID).jump_to(get_character(tmpEliseID).x,get_character(tmpEliseID).y)
		get_character(tmpEliseID).turn_toward_character($game_player)
		wait(10)
		get_character(tmpEliseID).animation = get_character(tmpEliseID).animation_ClapSlow
		call_msg("TagMapNoerEliseGynecology:elise/GiveBirthBegin_YES1") ; portrait_hide
		$game_player.call_balloon(8)
		wait(60)
		$game_player.direction = 4
		$game_player.call_balloon(8)
		wait(60)
		$game_player.direction = 6
		$game_player.call_balloon(8)
		wait(60)
		$game_player.direction = 2
		$game_player.call_balloon(8)
		wait(60)
		$game_player.call_balloon(13)
		$game_player.animation = $game_player.animation_stun
		wait(60)
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			get_character(tmpDoTricketID).summon_data[:canSleep] = true
			get_character(tmpDoTricketID).summon_data[:BirthEV] = true
			get_character(tmpDoTricketID).summon_data[:BirthLockedRoom] = true
			wait(20)
			SndLib.sys_StepChangeMap
			wait(80)
			3.times{
				SndLib.sound_equip_armor
				wait(60)
			}
			rape_loop_drop_item(tmpEquip=false,tmpSummon=false,lostItem=false,keepInBox=true)
			$game_player.moveto(tmpBirthEVWakeUpX,tmpBirthEVWakeUpY)
			get_character(tmpEliseID).moveto(tmpBirthEVWakeUpX+1,tmpBirthEVWakeUpY)
			get_character(tmpEliseID).direction = 4
			get_character(tmpBirthEVdoorID).summon_data[:Locked] = true
			player_force_update
			$game_player.light_check
			$game_player.direction = 6
		chcg_background_color(0,0,0,255,-7)
		get_character(tmpEliseID).call_balloon(8)
		wait(60)
		get_character(tmpEliseID).move_speed = 3 ; get_character(tmpEliseID).direction = 2 ; get_character(tmpEliseID).move_forward_force
		wait(30)
		get_character(tmpEliseID).move_speed = 3 ; get_character(tmpEliseID).direction = 6 ; get_character(tmpEliseID).move_forward_force
		wait(20)
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			$game_player.animation = nil
			get_character(tmpEliseID).animation = nil
			set_event_force_page(tmpFoodID,1)
			get_character(tmpEliseID).moveto(tmpEliseX,tmpEliseY)
			SndLib.closeDoorMetal(80)
			wait(30)
			SndLib.sound_step_chain(90)
			wait(30)
			SndLib.sound_step_chain(90)
			wait(30)
			get_character(tmpFoodID).effects=["Breath",0,true]
		chcg_background_color(0,0,0,255,-7)
	end
	get_character(tmpEliseID).npc_story_mode(false)
	$game_player.animation = nil
	get_character(tmpEliseID).animation = nil
	if $game_temp.choice == 0
		call_msg("TagMapNoerEliseGynecology:elise/GiveBirthBegin_wake0")
	else
		get_character(tmpEliseID).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],600)
		call_msg("TagMapNoerEliseGynecology:elise/GiveBirthBegin_NO")
	end
	###########################################################################birth_ev
elsif tmpDoBirthEV && $game_player.actor.preg_whenGiveBirth? <= 0
	$game_player.moveto(tmpBirthEVWakeUpX,tmpBirthEVWakeUpY)
	get_character(tmpEliseID).npc_story_mode(true)
	get_character(tmpEliseID).move_type = 0
	get_character(tmpEliseID).animation = nil
	get_character(tmpEliseID).jump_to($game_player.x,$game_player.y)
	get_character(tmpEliseID).turn_toward_character($game_player)
	get_character(tmpBirthEVdoorID).summon_data[:Locked] = false
	get_character(tmpEliseID).item_jump_to
	get_character(tmpEliseID).turn_toward_character($game_player)
	get_character(tmpDoTricketID).summon_data[:canSleep] = true
	$game_player.animation = $game_player.animation_stun
	$game_player.turn_toward_character(get_character(tmpEliseID))
	portrait_off
	wait(30)
	flash_screen(Color.new(255,0,0,200),8,false)
	SndLib.sound_Heartbeat(95)
	wait(40)
	flash_screen(Color.new(255,0,0,200),8,false)
	SndLib.sound_Heartbeat(95)
	chcg_background_color(0,0,0,255,-7)
	
	flash_screen(Color.new(255,0,0,200),8,false)
	SndLib.sound_Heartbeat(95)
	wait(10)
	get_character(tmpEliseID).jump_to(get_character(tmpEliseID).x,get_character(tmpEliseID).y)
	get_character(tmpEliseID).turn_toward_character($game_player)
	call_msg("TagMapNoerEliseGynecology:elise/GiveBirthBegin_Birth0")
	get_character(tmpEliseID).jump_to(get_character(tmpEliseID).x,get_character(tmpEliseID).y)
	get_character(tmpEliseID).turn_toward_character($game_player)
	call_msg("TagMapNoerEliseGynecology:elise/GiveBirthBegin_Birth1")
	get_character(tmpEliseID).jump_to(get_character(tmpEliseID).x,get_character(tmpEliseID).y)
	get_character(tmpEliseID).turn_toward_character($game_player)
	call_msg("TagMapNoerEliseGynecology:elise/GiveBirthBegin_Birth2")
	
	chcg_background_color(0,0,0,0,7)
		map_background_color(0,0,0,255,0)
		$game_player.animation = nil
		tmpRecRace = $game_player.actor.baby_race
		tmpRecRace = "OthersElise" if tmpRecRace == "Others"
		tmpPregLvl = $game_player.actor.preg_level
		portrait_off
		$game_player.actor.sta -= 1000
		load_script("Data/Batch/birth_trigger.rb")
		portrait_off
		$game_player.actor.health += 1000
		$game_player.actor.sat += 1000
		get_character(tmpEliseID).npc_story_mode(false)
		get_character(tmpEliseID).moveto(tmpEliseX,tmpEliseY)
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
		if has_ItemAMT > 0
			portrait_off
			tmpAbom = $game_party.item_number($data_items[71]) #PlayerAbominationBaby
			$story_stats["RecQuestEliseAbomBabySale"] += tmpAbom
			$story_stats["RecQuestEliseBabySale"] += 1
			call_msg("TagMapNoerEliseGynecology:elise/GiveBirthBegin_Birth3")
			$game_message.add("#{$game_text["TagMapNoerEliseGynecology:elise/surgery_begin3_Miscarriage_endF1"]}#{$game_text["DataNpcName:race/#{tmpRecRace}"]}#{$game_text["TagMapNoerEliseGynecology:elise/surgery_begin3_Miscarriage_endF2"]}#{$game_text["TagMapNoerEliseGynecology:elise/surgery_begin3_Miscarriage_endF3_preg_level#{tmpPregLvl}"]}")
			$game_map.interpreter.wait_for_message
			portrait_hide
			
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
			tar_price *= 10
			
			
			
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
			optain_item_chain(tar_price,["ItemCoin1","ItemCoin2","ItemCoin3"],false)
		else # baby isnt elise's fetish
			call_msg("CompLisa:Lisa16_17/NotThere0")
		end
	###########################################################################birth_ev Daily chk
elsif tmpDoBirthEV && get_character(tmpDoTricketID).summon_data[:BirthLockedRoom] == true
	$game_player.moveto(tmpBirthEVWakeUpX,tmpBirthEVWakeUpY)
	portrait_hide
	wait(10)
	SndLib.closeDoorMetal(80)
	wait(30)
	SndLib.sound_step_chain(90)
	wait(30)
	SndLib.sound_step_chain(90)
	wait(30)
	set_event_force_page(tmpFoodID,1)
	get_character(tmpFoodID).effects=["Breath",0,true]
	call_msg("TagMapNoerEliseGynecology:elise/GiveBirthBegin_wake0")
	
	############################################################################################################## QUEST
	############################################################################################################## QUEST
	############################################################################################################## QUEST
	############################################################################################################## QUEST
	####################################################summon bat
elsif tmpLonaInStartXY && $story_stats["RecQuestElise"] == 5 && $game_date.dateAmt >= $story_stats["RecQuestEliseAmt"] && $game_date.day?
	portrait_hide
	$game_map.reserve_summon_event("EliseVerAbomBat",tmpEliseX,tmpEliseY+4,-1,{:abomBat=>true})
	get_character(tmpEliseID).npc.add_fated_enemy([9])
	chcg_background_color(0,0,0,255,-7)
	call_msg("CompElise:RecQuestElise5/begin")
	
	######################################################################elise　FAP ing
elsif tmpLonaInStartXY && $story_stats["RecQuestElise"] == 6 && $game_date.dateAmt >= $story_stats["RecQuestEliseAmt"] && $game_date.day?
	$story_stats["RecQuestElise"] = 7
	get_character(tmpEliseID).npc_story_mode(true)
	get_character(tmpEliseID).call_balloon(0)
	get_character(tmpEliseFapID).npc_story_mode(true)
	get_character(tmpEliseFapID).opacity = 0
	get_character(tmpEliseID).direction = 8
	get_character(tmpEliseFapID).moveto(tmpEliseX,tmpEliseY)
	get_character(tmpEliseID).animation = get_character(tmpEliseID).animation_masturbation
	chcg_background_color(0,0,0,255,-7)
	call_msg("CompElise:RecQuestElise6/begin1")
	$game_player.move_normal ; $game_player.move_speed = 3 ; $game_player.move_forward_force
	wait(45)
	call_msg("CompElise:RecQuestElise6/begin2")
	$game_player.move_normal ; $game_player.move_speed = 3 ; $game_player.move_forward_force
	wait(45)
	call_msg("CompElise:RecQuestElise6/begin3")
	$game_player.move_normal ; $game_player.move_speed = 3 ; $game_player.move_forward_force
	wait(45)
	get_character(tmpEliseID).call_balloon(1)
	wait(26)
	get_character(tmpEliseID).call_balloon(8)
	get_character(tmpEliseID).opacity = 0
	get_character(tmpEliseFapID).opacity = 255
	wait(60)
	call_msg("CompElise:RecQuestElise6/begin4_1")
	call_msg("CompElise:RecQuestElise6/begin4_2")
	call_msg("CompElise:RecQuestElise6/begin4_3")
	cam_center(0)
	get_character(tmpEliseSpID).moveto($game_player.x,$game_player.y)
	get_character(tmpEliseSpID).opacity = 255
	get_character(tmpEliseSpID).force_update = true
	get_character(tmpEliseSpID).move_type = 3
	$game_player.actor.addCums("CumsHead",1000,"Human")
	$game_map.reserve_summon_event("WasteSemenHuman",$game_player.x,$game_player.y)
	$game_map.reserve_summon_event("WasteSemenHuman",$game_player.x-1+rand(3),$game_player.y-1+rand(3))
	$game_map.reserve_summon_event("WasteSemenHuman",$game_player.x-1+rand(3),$game_player.y-1+rand(3))
	player_force_update
	wait(20)
	lona_mood "p5sta_damage"
	$game_player.actor.portrait.shake
	SndLib.sound_chs_dopyu(60)
	player_force_update
	call_msg("CompElise:RecQuestElise6/begin5")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpEliseFapID).delete
		get_character(tmpEliseID).direction = 2
		get_character(tmpEliseID).animation = nil
		get_character(tmpEliseID).opacity = 255
		get_character(tmpEliseID).npc_story_mode(false)
		$game_player.moveto(tmpEliseX,tmpEliseY+2)
	chcg_background_color(0,0,0,255,-7)
	call_msg("CompElise:RecQuestElise6/begin6")
	call_msg("CompElise:RecQuestElise6/begin7")
	get_character(tmpEliseID).call_balloon(28,-1)
elsif !tmpDoBirthEV
	get_character(tmpBirthEVdoorID).summon_data[:Locked] = false
	get_character(tmpDoTricketID).summon_data[:BirthEV] = false
	get_character(tmpDoTricketID).summon_data[:BirthLockedRoom] = false
end

portrait_hide
cam_center(0)
