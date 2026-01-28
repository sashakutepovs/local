
tmpArcherX,tmpArcherY,tmpArcherID = $game_map.get_storypoint("Archer")
tmpGuardAX,tmpGuardAY,tmpGuardAID = $game_map.get_storypoint("GuardA")
tmpEnterCheckX,tmpEnterCheckY,tmpEnterCheckID = $game_map.get_storypoint("EnterCheck")
tmpMapContID = $game_map.get_storypoint("MapCont")[2]
tmpHalfBiosID = $game_map.get_storypoint("HalfBios")[2]
tmpWitchID = $game_map.get_storypoint("Witch")[2]
slotList = $data_system.equip_type_name
!equip_slot_removetable?("MH")		? equips_MH_id = -1 :		equips_MH_id =		$game_player.actor.equips[slotList["MH"]].item_name		#0
!equip_slot_removetable?("SH")		? equips_SH_id = -1 :		equips_SH_id =		$game_player.actor.equips[slotList["SH"]].item_name		#1
!equip_slot_removetable?("Top")		? equips_Top_id = -1 :		equips_Top_id =		$game_player.actor.equips[slotList["Top"]].item_name	#2
!equip_slot_removetable?("Mid")		? equips_Mid_id = -1 :		equips_Mid_id =		$game_player.actor.equips[slotList["Mid"]].item_name	#3
!equip_slot_removetable?("Bot")		? equips_Bot_id = -1 :		equips_Bot_id =		$game_player.actor.equips[slotList["Bot"]].item_name	#4
!equip_slot_removetable?("TopExt")	? equips_TopExt_id = -1 :	equips_TopExt_id =	$game_player.actor.equips[slotList["TopExt"]].item_name	#5
!equip_slot_removetable?("MidExt")	? equips_MidExt_id = -1 :	equips_MidExt_id =	$game_player.actor.equips[slotList["MidExt"]].item_name	#6
!equip_slot_removetable?("Hair")	? equips_Hair_id = -1 :		equips_Hair_id =	$game_player.actor.equips[slotList["Hair"]].item_name	#7
!equip_slot_removetable?("Head")	? equips_Head_id = -1 :		equips_Head_id =	$game_player.actor.equips[slotList["Head"]].item_name	#8
!equip_slot_removetable?("Neck")	? equips_Neck_id = -1 :		equips_Neck_id =	$game_player.actor.equips[slotList["Neck"]].item_name	#14
!equip_slot_removetable?("Vag")		? equips_Vag_id = -1 :		equips_Vag_id =		$game_player.actor.equips[slotList["Vag"]].item_name	#15
!equip_slot_removetable?("Anal")	? equips_Anal_id = -1 :		equips_Anal_id =	$game_player.actor.equips[slotList["Anal"]].item_name	#16
withCloth = !$game_player.player_nude?
tmpAggro = false
tmpPass = false

if $game_player.actor.morality > 120 || $game_player.actor.morality < -20
	tmpAggro = true
	############################################################################### 第1次進場
elsif $story_stats["RecQuestPenisTribeHelp"] == 0
	SndLib.MaleWarriorGruntSpot(100)
	call_msg("TagMapPenisTribe:rg4/FirstAlert0")
	$game_player.direction = 8
	SndLib.MaleWarriorGruntSpot(100)
	call_msg("TagMapPenisTribe:rg4/FirstAlert1")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		$game_player.direction = 4
		get_character(tmpArcherID).direction = 4
		get_character(tmpGuardAID).direction = 6
		get_character(tmpArcherID).moveto(tmpEnterCheckX+1,tmpEnterCheckY)
		get_character(tmpGuardAID).moveto(tmpEnterCheckX-1,tmpEnterCheckY)
		$game_player.moveto(tmpEnterCheckX,tmpEnterCheckY)
	chcg_background_color(0,0,0,255,-7)
	if withCloth #有穿衣服 詢問脫衣
		call_msg("TagMapPenisTribe:rg4/FirstAlert3")
		$game_temp.choice = -1
		call_msg("common:Lona/Decide_optD") #[算了,決定]
		if $game_temp.choice == 1
			call_msg("TagMapPenisTribe:rg4/FirstAlert3_1")
			if equips_MidExt_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("MidExt", nil)
				SndLib.sound_equip_armor(100)
				player_force_update
				wait(30)
			end
			if equips_Top_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("Top", nil)
				SndLib.sound_equip_armor(100)
				player_force_update
				wait(30)
			end
			if equips_Bot_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("Bot", nil)
				SndLib.sound_equip_armor(100)
				player_force_update
				wait(30)
			end
			if equips_Mid_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("Mid", nil)
				SndLib.sound_equip_armor(100)
				player_force_update
				wait(30)
			end
			if equips_Anal_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("Anal", nil)
				SndLib.sound_equip_armor(100)
				player_force_update
				wait(30)
			end
			if equips_Vag_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("Vag", nil)
				SndLib.sound_equip_armor(100)
				player_force_update
				wait(30)
			end
			call_msg("TagMapPenisTribe:rg4/FirstAlert4")
				get_character(tmpGuardAID).animation = get_character(tmpGuardAID).animation_grabber_qte($game_player)
				$game_player.animation = $game_player.animation_grabbed_qte
				load_script("Data/HCGframes/Grab_EventExt1_BoobTouch.rb")
				call_msg("TagMapPenisTribe:rg4/FirstAlert4_0")
				3.times{
					$game_player.actor.stat["EventExt1Race"] = "Human"
					load_script("Data/HCGframes/Grab_EventExt1_BoobTouch.rb")
					get_character(tmpGuardAID).call_balloon(8)
					wait(30)
				}
				call_msg("TagMapPenisTribe:rg4/FirstAlert4_1")
				$game_player.animation = nil
				get_character(tmpGuardAID).animation = nil
				whole_event_end
			call_msg("TagMapPenisTribe:rg4/FirstAlert5")
			get_character(tmpWitchID).call_balloon(28,-1)
			tmpPass = true
			$story_stats["RecQuestPenisTribeHelp"] = 1
		else #不脫衣服 直接進入AGGRO
			tmpAggro = true
		end
	else #沒穿衣服 去見預言者
		get_character(tmpWitchID).call_balloon(28,-1)
		tmpPass = true
		$story_stats["RecQuestPenisTribeHelp"] = 1
			get_character(tmpGuardAID).animation = get_character(tmpGuardAID).animation_grabber_qte($game_player)
			$game_player.animation = $game_player.animation_grabbed_qte
			load_script("Data/HCGframes/Grab_EventExt1_BoobTouch.rb")
			call_msg("TagMapPenisTribe:rg4/FirstAlert4_0")
			3.times{
				$game_player.actor.stat["EventExt1Race"] = "Human"
				load_script("Data/HCGframes/Grab_EventExt1_BoobTouch.rb")
				get_character(tmpGuardAID).call_balloon(8)
				wait(30)
			}
			call_msg("TagMapPenisTribe:rg4/FirstAlert4_1")
			$game_player.animation = nil
			get_character(tmpGuardAID).animation = nil
			whole_event_end
		call_msg("TagMapPenisTribe:rg4/FirstAlert5")
	end
	
	############################################################################### 第二次進場
elsif $story_stats["RecQuestPenisTribeHelp"] >= 1 && withCloth
	if withCloth
		call_msg("TagMapPenisTribe:rg4/DressCheck")
		$game_temp.choice = -1
		call_msg("common:Lona/Decide_optD") #[算了,決定]
		if $game_temp.choice == 1
			call_msg("TagMapPenisTribe:rg4/FirstAlert3_1")
			if equips_MidExt_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("MidExt", nil)
				SndLib.sound_equip_armor(100)
				player_force_update
				wait(30)
			end
			if equips_Top_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("Top", nil)
				SndLib.sound_equip_armor(100)
				player_force_update
				wait(30)
			end
			if equips_Bot_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("Bot", nil)
				SndLib.sound_equip_armor(100)
				player_force_update
				wait(30)
			end
			if equips_Mid_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("Mid", nil)
				SndLib.sound_equip_armor(100)
				player_force_update
				wait(30)
			end
			if equips_Anal_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("Anal", nil)
				SndLib.sound_equip_armor(100)
				player_force_update
				wait(30)
			end
			if equips_Vag_id != -1#檢查裝備 並脫裝
				$game_player.actor.change_equip("Vag", nil)
				SndLib.sound_equip_armor(100)
				player_force_update
				wait(30)
			end
			tmpPass = true
		else #不脫衣服 直接進入AGGRO
			tmpAggro = true
		end
	end
	############################################################################### 第二次進場 沒穿衣服+
elsif $story_stats["RecQuestPenisTribeHelp"] >= 1 && !withCloth
		set_event_force_page(tmpMapContID,3)
end

if tmpPass #准許通過 衛兵歸位
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		set_event_force_page(tmpMapContID,3)
		get_character(tmpArcherID).direction = 2
		get_character(tmpGuardAID).direction = 6
		get_character(tmpArcherID).moveto(tmpArcherX,tmpArcherY)
		get_character(tmpGuardAID).moveto(tmpGuardAX,tmpGuardAY)
		get_character(tmpHalfBiosID).summon_data[:Pass] = true
	chcg_background_color(0,0,0,255,-7)
end

if tmpAggro #不准通過 所有單位AGGRO
	$story_stats["RecQuestPenisTribeHelp"] = 5
	SndLib.bgm_play("CB_Barren Combat LOOP",80,100)
	call_msg("TagMapPenisTribe:rg4/Aggroed")
	get_character(tmpHalfBiosID).summon_data[:NapGameOver] = true
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:TribeDudes]
		next if event.npc.action_state == :death
		event.npc.killer_condition={"health"=>[0, ">"]}
		event.set_manual_move_type(8)
		event.set_manual_trigger(-1)
		event.trigger = -1
		event.call_balloon(0)
		next unless [nil,:none].include?(event.npc.action_state)
		event.move_type = 8 if event.move_type <= 3
	}
end

eventPlayEnd
