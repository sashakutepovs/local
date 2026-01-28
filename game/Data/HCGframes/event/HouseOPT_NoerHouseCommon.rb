if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if $story_stats["OverMapEvent_name"] != 0 || !get_character(0).summon_data || get_character(0).summon_data[:executed]
	SndLib.sys_DoorLock
	call_msg_popup("TagMapNoerCatacomb:Necropolis/Locked#{rand(2)}")
	return
end
if $game_player.actor.stat["RaceRecord"] == "TrueDeepone"
	SndLib.sys_buzzer
	case rand(3)
		when 0 ; $game_map.popup(0,"OOooOoOOoO",0,0)
		when 1 ; $game_map.popup(0,"ooOoOOooOOo",0,0)
		when 2 ; $game_map.popup(0,"ooOoOOo",0,0)
	end
	return
end

call_msg("commonNPC:NoerHouse/HouseOpt")
tmpCanBegging =	$game_player.actor.weak > 150 && get_character(0).summon_data[:executed] == false
tmpCanDeceive =	$game_player.actor.wisdom_trait >= 5 && $game_player.actor.sta > 0 && get_character(0).summon_data[:executed] == false
tmpCanSteal = 	$game_player.actor.scoutcraft_trait >= 5 && $game_player.actor.sta > 0 && get_character(0).summon_data[:executed] == false
tmpGotoTar = ""
tmpTarList = []
tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
tmpTarList << [$game_text["commonNPC:commonNPC/Begging"]			,"Begging"]		if tmpCanBegging
tmpTarList << [$game_text["commonNPC:commonNPC/Steal"]				,"Steal"]		if tmpCanSteal
tmpTarList << [$game_text["commonNPC:commonNPC/Deceive"]			,"Deceive"]		if tmpCanDeceive
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
		when "Begging"
				call_msg("commonNPC:NoerHouse/HouseOpt_beg")
				get_character(0).summon_data[:executed] = true
				$game_player.actor.sta -= 3
				temp_tar = 50+rand(150) ##############   Begging Diff
				tmpWeak = $game_player.actor.weak - $game_player.actor.stat["SlaveBrand"]*rand(500) - $game_player.actor.stat["moot"]*rand(100) + $game_player.actor.wisdom*rand(10)
				call_msg("\\narr #{tmpWeak.round} VS #{temp_tar.round}")
				if tmpWeak >=  temp_tar #### WIN
					call_msg("commonNPC:NoerHouse/HouseOpt_beg_win")
					temp_food_list= [1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,17,18,19,20,50]
					temp_get_from_list = temp_food_list.sample
					$game_party.gain_item($data_items[temp_get_from_list], 1)
					$game_map.popup(0,:item,temp_get_from_list,1)
					SndLib.sys_Gain
				else
					call_msg("commonNPC:NoerHouse/HouseOpt_fail_night") if $game_date.night?
					call_msg("commonNPC:NoerHouse/HouseOpt_beg_fail#{rand(2)}")
					$game_map.reserve_summon_event("RandomNoerHouseAggroPPL",$game_player.x,$game_player.y) if rand(100) >=50
				end
				$game_player.actor.update_lonaStat
		when "Deceive"
				call_msg("commonNPC:NoerHouse/HouseOpt_lie_begin1")
				call_msg("commonNPC:NoerHouse/HouseOpt_lie_begin1_1")
				call_msg("commonNPC:NoerHouse/HouseOpt_lie_begin2_#{rand(2)}")
				call_msg("commonNPC:NoerHouse/HouseOpt_lie_begin3")
				get_character(0).summon_data[:executed] = true
				$game_player.actor.sta -= 3
				temp_tar= 15+rand(100)
				temp_vs = ($game_player.actor.wisdom + rand(100)) - $game_player.actor.weak
				call_msg("\\narr #{temp_vs.round} VS #{temp_tar.round}")
				if temp_vs >= temp_tar #win
					call_msg("commonNPC:NoerHouse/HouseOpt_lie_win")
					temp_val = rand(3)+2
					$game_party.gain_item($data_items[50], temp_val)
					$game_map.popup(0,:item,50,temp_val)
					SndLib.sys_Gain
				else #fail
					call_msg("commonNPC:NoerHouse/HouseOpt_lie_fail")
					$game_player.actor.morality_lona -=1
					optain_morality(-1)
					EvLib.sum("RandomNoerHouseAggroPPL",$game_player.x,$game_player.y) if rand(100) >=50
				end
				$game_player.actor.update_lonaStat
		when "Steal"
				call_msg("commonNPC:NoerHouse/HouseOpt_steal")
				get_character(0).summon_data[:executed] = true
				$game_player.actor.sta -= 3
				#成功的話開啟箱子 失敗的話給予道德低落的DEBUFF 並減5基本道德
				temp_tar= 15+rand(100)
				temp_mod = 1+($game_player.actor.scoutcraft/5).to_i
				temp_vs = $game_player.actor.scoutcraft*1.5 + rand(21*temp_mod)
				temp_vs -= 50 if $game_date.day?
				temp_vs = 0 if $game_player.innocent_spotted?
				box_id = System_Settings::STORAGE_TEMP
				call_msg("\\narr #{temp_vs.round} VS #{temp_tar.round}")
				if temp_vs >= temp_tar #win
					call_msg("commonNPC:NoerHouse/HouseOpt_steal_win")
					$game_boxes.box(box_id).clear
					item = $data_items[rand(20)+1]	;	$game_boxes.box(box_id)[item] = 1
					item = $data_items[rand(20)+1]	;	$game_boxes.box(box_id)[item] = 1
					item = $data_items[rand(20)+1]	;	$game_boxes.box(box_id)[item] = 1
					item = $data_items[50]			;	$game_boxes.box(box_id)[item] = rand(3)+1 if rand(100) >=50
					item = $data_items[51]			;	$game_boxes.box(box_id)[item] = 1 if rand(100) >=90
					item = $data_items[52]			;	$game_boxes.box(box_id)[item] = 1 if rand(200) ==199
					SceneManager.goto(Scene_ItemStorage)
					SceneManager.scene.prepare(box_id)
				else #fail
					call_msg("commonNPC:NoerHouse/HouseOpt_steal_fail")
					optain_morality(-2)
					$game_player.actor.add_state("MoralityDown30")
					EvLib.sum("RandomNoerHouseAggroPPL",$game_player.x,$game_player.y)
				end
				$game_player.actor.update_lonaStat
	end #case

eventPlayEnd
