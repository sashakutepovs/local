tmpWardenX,tmpWardenY,tmpWardenID=$game_map.get_storypoint("Warden")
tmpGate1X,tmpGate1Y,tmpGate1ID=$game_map.get_storypoint("Gate1")
tmpGate2X,tmpGate2Y,tmpGate2ID=$game_map.get_storypoint("Gate2")
tmpWakeUpX,tmpWakeUpY,tmpWakeUpID=$game_map.get_storypoint("WakeUp")
tmpDualBiosID=$game_map.get_storypoint("DualBios")[2]
tmpMatchStart = $game_date.dateAmt >= get_character(tmpDualBiosID).summon_data[:MatchWait]
godlinRoom = false




tmpG1X,tmpG1Y,tmpG1ID = $game_map.get_storypoint("Gate1")
tmpG2X,tmpG2Y,tmpG2ID = $game_map.get_storypoint("Gate2")
tmpG3X,tmpG3Y,tmpG3ID = $game_map.get_storypoint("Gate3")
tmpG4X,tmpG4Y,tmpG4ID = $game_map.get_storypoint("Gate4")
tmpG5X,tmpG5Y,tmpG5ID = $game_map.get_storypoint("Gate5")
tmpG6X,tmpG6Y,tmpG6ID = $game_map.get_storypoint("Gate6")
tmpToiletID = $game_map.get_storypoint("ExitToilet")[2]
get_character(tmpG1ID).switch1_id = 0 if !get_character(tmpG1ID).switch1_id
get_character(tmpG2ID).switch1_id = 0 if !get_character(tmpG2ID).switch1_id
get_character(tmpG3ID).switch1_id = 0 if !get_character(tmpG3ID).switch1_id
get_character(tmpG4ID).switch1_id = 0 if !get_character(tmpG4ID).switch1_id
get_character(tmpG5ID).switch1_id = 0 if !get_character(tmpG5ID).switch1_id
get_character(tmpG6ID).switch1_id = 0 if !get_character(tmpG6ID).switch1_id
tmpG1HP = get_character(tmpG1ID).switch1_id
tmpG2HP = get_character(tmpG2ID).switch1_id
tmpG3HP = get_character(tmpG3ID).switch1_id
tmpG4HP = get_character(tmpG4ID).switch1_id
tmpG5HP = get_character(tmpG5ID).switch1_id
tmpG6HP = get_character(tmpG6ID).switch1_id
tmpToiletHP = get_character(tmpToiletID).switch1_id
tmpG1HPmax = get_character(tmpG1ID).summon_data[:staNeed]
tmpG2HPmax = get_character(tmpG2ID).summon_data[:staNeed]
tmpG3HPmax = get_character(tmpG3ID).summon_data[:staNeed]
tmpG4HPmax = get_character(tmpG4ID).summon_data[:staNeed]
tmpG5HPmax = get_character(tmpG5ID).summon_data[:staNeed]
tmpG6HPmax = get_character(tmpG6ID).summon_data[:staNeed]
if tmpG1HP >= tmpG1HPmax || tmpG2HP >= tmpG2HPmax || tmpG3HP >= tmpG3HPmax || tmpG4HP >= tmpG4HPmax || tmpG5HP >= tmpG5HPmax || tmpG6HP >= tmpG6HPmax
	$story_stats["RapeLoopTorture"] = 1
	call_msg("TagMapNoerMobHouse:Doors/LockReset")
	get_character(tmpG1ID).switch1_id = 0
	get_character(tmpG2ID).switch1_id = 0
	get_character(tmpG3ID).switch1_id = 0
	get_character(tmpG4ID).switch1_id = 0
	get_character(tmpG5ID).switch1_id = 0
	get_character(tmpG6ID).switch1_id = 0
	get_character(tmpToiletID).switch1_id = 0
	get_character(tmpG1ID).moveto(tmpG1X,tmpG1Y)
	get_character(tmpG2ID).moveto(tmpG2X,tmpG2Y)
	get_character(tmpG3ID).moveto(tmpG3X,tmpG3Y)
	get_character(tmpG4ID).moveto(tmpG4X,tmpG4Y)
	get_character(tmpG5ID).moveto(tmpG5X,tmpG5Y)
	get_character(tmpG6ID).moveto(tmpG6X,tmpG6Y)
end



########################################################################################################################################### 上銬模組
if $story_stats["Captured"] == 1
	$game_player.actor.change_equip(0, nil)
	$game_player.actor.change_equip(1, nil)
	$game_player.actor.change_equip(5, nil)
	rape_loop_drop_item(tmpEquip=false,tmpSummon=false,lostItem=true,keepInBox=false)
	load_script("Data/Batch/Put_HeavyestBondage_no_dialog.rb")
	$story_stats["dialog_cuff_equiped"]=0
	SndLib.sound_equip_armor(100)
end

###########################################################################################################################################	決鬥開始
if $story_stats["Captured"] == 1 && $story_stats["ReRollHalfEvents"] == 0 && $story_stats["RapeLoop"] == 1 && tmpMatchStart
	get_character(tmpWardenID).moveto(tmpGate1X,tmpGate1Y+1)
	tmpWardenOD = get_character(tmpWardenID).direction
	get_character(tmpWardenID).direction = 8
	$game_player.moveto(tmpWakeUpX,tmpWakeUpY)
	$game_player.direction = 6
	chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapNoerArenaB1:playerFight/begin0") ; portrait_hide
			chcg_background_color(0,0,0,0,7)
				$game_player.moveto(tmpGate1X,tmpGate1Y-1)
				$game_player.direction = 2
			chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapNoerArenaB1:playerFight/begin1")
		$game_player.actor.change_equip(0, nil)
		$game_player.actor.change_equip(1, nil)
		$game_player.actor.change_equip(5, nil)
		$game_player.actor.change_equip(6, nil)
		$game_party.lose_item("ItemCuff", 99, include_equip =true)
		$game_party.lose_item("ItemChainCuff", 99, include_equip =true)
		$game_party.lose_item("ItemCollar", 99, include_equip =true)
		$game_party.lose_item("ItemChainCollar", 99, include_equip =true)
		$game_party.lose_item("ItemChainMidExtra", 99, include_equip =true)
		wait(30)
		optain_item("ItemChainCollar", 1)
		wait(30)
		$game_player.actor.change_equip(5, "ItemChainCollar")
		$story_stats["dialog_cuff_equiped"]=0
		SndLib.sound_equip_armor(125)
		cam_center(0)
		optain_gold(10000)
		wait(35)
		player_force_update
		$story_stats["HiddenOPT0"] = "1"
		$game_temp.choice = -1
		until false #$game_temp.choice == 3 #出場
			call_msg("TagMapNoerArenaB1:playerFight/begin2_opt") #[選擇裝備,特別提供<r=HiddenOPT0>,準備,出場]
			case $game_temp.choice
				when 0 #裝備
					manual_barters("NoerArenaB1_SlaveFight")
					
				when 1 #特別提供
					$story_stats["HiddenOPT0"] = "0"
					call_msg("TagMapNoerArenaB1:playerFight/begin2_opt_OtherOffer")
					call_msg("common:Lona/Decide_optB") #算了,決定
						if $game_temp.choice == 1
							manual_barters("NoerArenaB1_SlaveSupply")
							call_msg("TagMapNoerArenaB1:playerFight/begin2_opt_OtherOffer_yes3")
						else
							call_msg("TagMapNoerArenaB1:playerFight/begin2_opt_OtherOffer_no")
						end
					
				when 2 #準備
					$game_system.menuSystem_disabled = true
					SceneManager.goto(Scene_Menu)
					call_msg("TagMapNoerArenaB1:playerFight/begin2_opt_notYet")
					$game_system.menuSystem_disabled = false
				
				when 3 #出場
					call_msg("TagMapNoerArenaB1:playerFight/FightStart") ; portrait_hide
					break
				end #case
		end #until
		
		
	chcg_background_color(0,0,0,0,7)
	map_background_color(0,0,0,255)
	change_map_enter_tagSub("NoerArena")
	return change_map_captured_story_stats_fix
	
###########################################################################################################################################	處罰 
elsif $story_stats["Captured"] == 1 && $story_stats["RapeLoop"] == 1 && $story_stats["RapeLoopTorture"] == 1
	$story_stats["RapeLoopTorture"] = 0
	call_msg("TagMapNoerArenaB1:Nap/Torture0")
	godlinRoom = true
	
###########################################################################################################################################	剛被抓 
elsif $story_stats["Captured"] == 1 && $story_stats["ReRollHalfEvents"] == 1 && $story_stats["RapeLoop"] == 1
	get_character(tmpWardenID).moveto(tmpGate1X,tmpGate1Y+1)
	tmpWardenOD = get_character(tmpWardenID).direction
	get_character(tmpWardenID).direction = 8
	$game_player.moveto(tmpGate1X,tmpGate1Y-1)
	$game_player.direction = 2
	chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapNoerArenaB1:enter/begin0")
		get_character(tmpWardenID).move_type = 0
		get_character(tmpWardenID).npc_story_mode(true)
		get_character(tmpWardenID).set_animation("animation_atk_mh")
		SndLib.sound_equip_armor
		wait(35)
		4.times{
			EvLib.sum("ItemBread",tmpGate1X,tmpGate1Y-1)
		}
	chcg_background_color(0,0,0,0,7)
	get_character(tmpWardenID).move_type = 3
	get_character(tmpWardenID).npc_story_mode(false)
	get_character(tmpWardenID).moveto(tmpWardenX,tmpWardenY)
	get_character(tmpWardenID).direction = tmpWardenOD
	
###########################################################################################################################################	日常食物
elsif $story_stats["Captured"] == 1 && $story_stats["ReRollHalfEvents"] == 0 && $story_stats["RapeLoop"] == 1
	get_character(tmpWardenID).moveto(tmpGate1X,tmpGate1Y+1)
	tmpWardenOD = get_character(tmpWardenID).direction
	get_character(tmpWardenID).direction = 8
	$game_player.moveto(tmpWakeUpX,tmpWakeUpY)
	$game_player.direction = 6
	chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapNoerArenaB1:Daily/Food0") ; portrait_hide
			chcg_background_color(0,0,0,0,7)
				$game_player.moveto(tmpGate1X,tmpGate1Y-1)
				$game_player.direction = 2
			chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapNoerArenaB1:Daily/Food1") ; portrait_hide
		call_msg("common:Lona/Decide_optB") #算了,決定
		if $game_temp.choice == 1
			call_msg("TagMapNoerArenaB1:Daily/Food_YES0")
			call_msg("TagMapNoerArenaB1:playerFight/begin2_opt_OtherOffer_yes0")
			call_msg("TagMapNoerArenaB1:Daily/Food_YES0_1")
			$cg.erase
					$game_map.popup(0,"1",$data_items[24].icon_index,-1)
					$game_player.actor.itemUseBatch("ItemHiPotionLV2")
					$game_player.actor.stat["EventMouthRace"] = "Human"
					load_script("Data/HCGframes/UniqueEvent_DeepThroat.rb")
					$game_map.popup(0,"1",$data_items[24].icon_index,-1)
					$game_player.actor.itemUseBatch("ItemHiPotionLV2")
				whole_event_end
				portrait_off
			call_msg("TagMapNoerArenaB1:Daily/Food_YES1")
			wait(35)
			3.times{
				EvLib.sum("ItemBread",tmpGate1X,tmpGate1Y-1)
			}
			call_msg("TagMapNoerArenaB1:Daily/Food_END")
		else
			call_msg("TagMapNoerArenaB1:Daily/Food_NO")
		end
	chcg_background_color(0,0,0,0,7)
	get_character(tmpWardenID).moveto(tmpWardenX,tmpWardenY)
	get_character(tmpWardenID).direction = tmpWardenOD
end


if godlinRoom
	portrait_off
	tmpID=$game_map.get_storypoint("WakeUp2")[2]
	enter_static_tag_map(tmpID)
	$game_map.events.each{|event|
		next unless event[1].summon_data
		next unless event[1].summon_data[:goblin]
		event[1].turn_toward_character($game_player)
		event[1].set_animation("animation_masturbation")
		event[1].move_type = 0
		event[1].npc_story_mode(true)
	}
	call_msg("TagMapNoerArenaB1:Nap/Torture1")
	chcg_background_color(0,0,0,255,-3)
	call_msg("TagMapNoerArenaB1:Nap/Torture2")
	$game_map.events.each{|event|
		next unless event[1].summon_data
		next unless event[1].summon_data[:goblin]
		event[1].animation = event[1].animation_grabber_qte($game_player)
		event[1].call_balloon(4)
	}
	$game_player.set_animation("animation_grabbed_qte")
	SndLib.sound_equip_armor(100)
	call_msg("TagMapNoerArenaB1:Nap/Torture3")
	$game_map.events.each{|event|
		next unless event[1].summon_data
		next unless event[1].summon_data[:goblin]
		event[1].npc_story_mode(false)
		event[1].animation = nil
		event[1].set_npc("GoblinCommoner")
	}
	$game_player.animation = nil
	call_msg("common:Lona/use_as_MeatToilet#{talk_style}")
else
	enter_static_tag_map
end
