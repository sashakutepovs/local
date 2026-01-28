if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if $game_player.player_slave? && $story_stats["SlaveOwner"] == "NorthFL_INN"
	call_msg("TagMapNorthFL_INN:InnKeeper/Slave_work")
	return eventPlayEnd
end

tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
$game_temp.choice = -1
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"]
	tmpTarList << [$game_text["commonNPC:commonNPC/About"]				,"About"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Work"]				,"Work"]
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("TagMapNorthFL_INN:InnKeeper/Begin",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1

case tmpPicked
	when "Barter"
		manual_barters("NorthFL_INN_Keeper")
	when "About"
			if $game_player.player_slave? && $story_stats["SlaveOwner"] == "NorthFL_INN"
				call_msg("TagMapNorthFL_INN:InnKeeper/Slave_work")
			else
				call_msg("TagMapNorthFL_INN:InnKeeper/About_here")
			end
	when "Work"
				####################################################### Already a slave
			if $game_player.player_slave? && $story_stats["SlaveOwner"] == "NorthFL_INN"
				call_msg("TagMapNorthFL_INN:InnKeeper/Slave_work")
				
				####################################################### Escape Slave
			elsif $game_player.player_slave? && $story_stats["SlaveOwner"] != "NorthFL_INN"
				
				####################################################### Not Slave Yet
			else
				call_msg("TagMapNorthFL_INN:InnKeeper/About_work0")
				call_msg("TagMapNorthFL_INN:InnKeeper/About_work1")
				call_msg("TagMapNorthFL_INN:InnKeeper/About_work2")
				call_msg("common:Lona/Decide_optB") #[算了,決定]
				if $game_temp.choice == 1
					call_msg("TagMapNorthFL_INN:InnKeeper/About_work2_Y")
					portrait_hide
					chcg_background_color(0,0,0,0,7)
						portrait_off
						tmpG1X,tmpG1Y,tmpG1id = $game_map.get_storypoint("Guard1")
						tmpG2X,tmpG2Y,tmpG2id = $game_map.get_storypoint("Guard2")
						tmpKeeperX,tmpKeeperY,tmpKeeperID = $game_map.get_storypoint("Keeper")
						tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
						tmpWhoreQUX,tmpWhoreQUY,tmpWhoreQUID = $game_map.get_storypoint("WhoreQU")
						tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
						get_character(0).moveto(tmpKeeperX,tmpKeeperY)
						get_character(0).direction = 2
						$game_player.moveto(tmpKeeperX,tmpKeeperY+2)
						$game_player.direction = 8
						get_character(tmpG1id).opacity = 255
						get_character(tmpG2id).opacity = 255
						get_character(tmpG1id).moveto(tmpKeeperX-1,tmpKeeperY+5)
						get_character(tmpG2id).moveto(tmpKeeperX,tmpKeeperY+5)
						get_character(tmpG1id).direction = 8
						get_character(tmpG2id).direction = 8
						get_character(tmpG1id).npc_story_mode(true)
						get_character(tmpG2id).npc_story_mode(true)
						cam_center(0)
					chcg_background_color(0,0,0,255,-7)
					2.times{
						get_character(tmpG1id).move_forward_force
						get_character(tmpG2id).move_forward_force
						wait(30)
					}
					get_character(tmpG1id).move_forward_force
					wait(30)
					get_character(tmpG1id).direction = 6
					$game_player.direction = 2
					call_msg("TagMapNorthFL_INN:InnKeeper/About_work2_Y1") ; portrait_hide
					get_character(tmpG2id).animation = get_character(tmpG2id).animation_grabber_qte($game_player)
					$game_player.animation = $game_player.animation_grabbed_qte
					SndLib.sound_equip_armor(100)
					call_msg("TagMapNorthFL_INN:InnKeeper/About_work2_Y2") ; portrait_hide
					get_character(tmpKeeperID).animation = get_character(tmpKeeperID).animation_atk_sh
					SndLib.sound_equip_armor(100)
					call_msg("TagMapNorthFL_INN:InnKeeper/About_work2_Y3")
					get_character(tmpG1id).animation = get_character(tmpG1id).animation_atk_mh
					combat_Hevent_Grab_Punch("Human",10)
					SndLib.sound_punch_hit(100)
					call_msg("TagMapNorthFL_INN:InnKeeper/About_work2_Y4")
					get_character(tmpG1id).animation = get_character(tmpG1id).animation_atk_mh
					SndLib.sound_punch_hit(100)
					call_msg("commonH:Lona/ForceFeeding_begin3")
					$game_player.actor.portrait.shake
					get_character(tmpG1id).animation = get_character(tmpG1id).animation_atk_shoot_hold
					SndLib.sound_equip_armor(100)
					combat_Hevent_Grab_BoobTouch("Human",10)
					call_msg("TagMapNorthFL_INN:InnKeeper/About_work2_Y5") ; portrait_hide
					$game_player.actor.add_state("SlaveBrand") #51
					$game_player.actor.sta = -100
					$cg.erase
					$story_stats["Captured"] = 1
					chcg_background_color(0,0,0,0,7)
					$game_player.actor.change_equip(0, nil)
						$game_player.actor.change_equip(1, nil)
						$game_player.actor.change_equip(5, nil)
						load_script("Data/Batch/Put_BondageItemsON.rb")
						$story_stats["dialog_cuff_equiped"] =0
						get_character(tmpDualBiosID).summon_data[:IsSlave] = true
						SndLib.sound_equip_armor(100)
						$story_stats["dialog_collar_equiped"] =0
						rape_loop_drop_item(false,false)
						$game_player.animation = nil
						get_character(tmpG1id).npc_story_mode(false)
						get_character(tmpG2id).npc_story_mode(false)
						get_character(tmpG1id).moveto(tmpG1X,tmpG1Y)
						get_character(tmpG2id).moveto(tmpG2X,tmpG2Y)
						get_character(tmpG1id).opacity = 0
						get_character(tmpG2id).opacity = 0
						get_character(tmpG1id).animation = nil
						get_character(tmpG2id).animation = nil
						#get_character(tmpWhoreQUID).moveto(tmpWakeUpX,tmpWakeUpY+1)
						#get_character(tmpWhoreQUID).direction = 8
						$game_player.moveto(tmpWakeUpX,tmpWakeUpY)
						get_character(tmpG2id).moveto(tmpWakeUpX-1,tmpWakeUpY)
						get_character(tmpG2id).direction = 6
						get_character(tmpG2id).opacity = 255
						whole_event_end
						portrait_off
						$story_stats["SlaveOwner"] = "NorthFL_INN"
						SndLib.bgs_play("AMBIENCE_Public_Hall_Chatter_01_loop_stereo",30,80)
						SndLib.me_play("SE/Move",75,120+rand(31))
						$game_player.animation = $game_player.animation_stun
						call_msg("TagMapNorthFL_INN:InnKeeper/About_work2_Y6")
					chcg_background_color(0,0,0,255,-7)
					$game_player.direction = 2
					call_msg("TagMapNorthFL_INN:InnKeeper/About_work2_Y7")
					portrait_hide
					chcg_background_color(0,0,0,0,7)
						portrait_off
						get_character(tmpG1id).opacity = 0
						get_character(tmpG2id).opacity = 0
						get_character(tmpWhoreQUID).moveto(tmpWhoreQUX,tmpWhoreQUY)
						get_character(tmpWhoreQUID).direction = 2
					chcg_background_color(0,0,0,255,-7)
					call_msg("TagMapNorthFL_INN:InnKeeper/About_work2_Y8")
					
				else
					call_msg("TagMapNorthFL_INN:InnKeeper/About_work2_N")
				end
				
			end
end

eventPlayEnd
