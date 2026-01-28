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

call_msg("commonNPC:NoerHouse/WarehouseOpt")
tmpCanSteal = $game_player.actor.scoutcraft_trait >= 5 && $game_player.actor.sta > 0 && get_character(0).summon_data[:executed] == false
p tmpCanSteal
p $game_player.actor.scoutcraft_trait
p $game_player.actor.sta
p get_character(0).summon_data[:executed]
tmpGotoTar = ""
tmpTarList = []
tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
tmpTarList << [$game_text["commonNPC:commonNPC/Steal"]				,"Steal"]		if tmpCanSteal
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
					$game_boxes.clear(box_id)
					item = $data_items[rand(20)+1]	;	$game_boxes.box(box_id)[item] = 1
					item = $data_items[rand(20)+1]	;	$game_boxes.box(box_id)[item] = 1
					item = $data_items[rand(20)+1]	;	$game_boxes.box(box_id)[item] = 1
					item = $data_items[50]			;	$game_boxes.box(box_id)[item] = rand(3)+1 if rand(100) >=50
					item = $data_items[51]			;	$game_boxes.box(box_id)[item] = 1 if rand(100) >=90
					item = $data_items[52]			;	$game_boxes.box(box_id)[item] = 1 if rand(200) ==199
					wait(1)
					SceneManager.goto(Scene_ItemStorage)
					SceneManager.scene.prepare(box_id)
				else #fail
					call_msg("commonNPC:NoerHouse/HouseOpt_steal_fail")
					optain_morality(-2)
					$game_player.actor.add_state("MoralityDown30")
					$game_map.reserve_summon_event("NoerCommonAggroHumanM",$game_player.x,$game_player.y)
					get_posi = $story_stats["RegionMap_RegionOuta"]
					posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
					posi2=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
					EvLib.sum("RandomHumanGroup",posi1[0],posi1[1],-1)
					EvLib.sum("RandomHumanGroup",posi2[0],posi2[1],-1)
				end
				$game_player.actor.update_lonaStat
	end #case

eventPlayEnd
