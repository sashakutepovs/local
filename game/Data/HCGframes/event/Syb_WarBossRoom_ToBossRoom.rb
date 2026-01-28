



tmpGobRunnerX,tmpGobRunnerY,tmpGobRunnerID = $game_map.get_storypoint("GobRunner")
tmpToBossRoomX,tmpToBossRoomY,tmpToBossRoomID = $game_map.get_storypoint("ToBossRoom")
tmpStartPointX,tmpStartPointY,tmpStartPointID = $game_map.get_storypoint("StartPoint")
tmpOgreWarBossX,tmpOgreWarBossY,tmpOgreWarBossID = $game_map.get_storypoint("OgreWarBoss")
tmpThrowHeadX,tmpThrowHeadY,tmpThrowHeadID = $game_map.get_storypoint("ThrowHead")
tmpFoodEVX,tmpFoodEVY,tmpFoodEVID = $game_map.get_storypoint("FoodEV")
tmpBossRoomDoorX,tmpBossRoomDoorY,tmpBossRoomDoorID = $game_map.get_storypoint("BossRoomDoor")
tmpbossEQPX,tmpbossEQPY,tmpbossEQPID = $game_map.get_storypoint("bossEQP")
tmpEnterGateID = $game_map.get_storypoint("EnterGate")[2]
tmDualBiosID = $game_map.get_storypoint("DualBios")[2]
tmpCamX,tmpCamY,tmpCamID = $game_map.get_storypoint("Cam")

$game_temp.choice = -1
call_msg("common:Lona/EnterSub") #[算了,進入]
return if $game_temp.choice != 1
################################################## OrkindSlayer mode
if ["CompOrkindSlayer"].include?($game_player.record_companion_name_front) && follower_in_range?(1,5) && $story_stats["UniqueCharUniqueOgreWarBoss"] != -1 && !get_character(tmDualBiosID).summon_data[:OrkindSlayerThrowPee]
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character($game_player.get_followerID(1)).moveto($game_player.x,$game_player.y+1)
		get_character($game_player.get_followerID(1)).turn_toward_character($game_player)
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapSyb_WarBossRoom:EnterBossRoom/OrkindSlayer_Begin1")
	$game_player.turn_toward_character(get_character($game_player.get_followerID(1)))
	
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]												,"Cancel"]
	tmpTarList << [$game_text["TagMapSyb_WarBossRoom:EnterBossRoom/OrkindSlayer_OPT_justEnter"]			,"JustGetIn"]
	tmpTarList << [$game_text["TagMapSyb_WarBossRoom:EnterBossRoom/OrkindSlayer_OPT_Give"]				,"Give"]
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("TagMapSyb_WarBossRoom:EnterBossRoom/OrkindSlayer_Begin2",0,2,0)
	#call_msg("commonNPC:MaleHumanRandomNpc/CommonHuman_CommonNpcOpt"
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
				
	case tmpPicked
		when "Cancel"
			return eventPlayEnd
		when "JustGetIn"
				call_msg("TagMapSyb_WarBossRoom:EnterBossRoom/OrkindSlayer_justEnter0")
		when "Give" 
			 if $game_party.has_item?("ItemBottledPee") #58
				tmpGSmove_Type = get_character($game_player.get_followerID(1)).move_type
				get_character($game_player.get_followerID(1)).move_type = 0
				get_character($game_player.get_followerID(1)).npc_story_mode(true)
				
				#give item to GS
				call_msg("TagMapSyb_WarBossRoom:EnterBossRoom/OrkindSlayer_Give0")
				cam_center(0)
				portrait_hide
				$game_player.animation = $game_player.animation_atk_sh
				optain_lose_item("ItemBottledPee",1)
				wait(60)
				
				#switch GS local & player
				1.times{
					get_character($game_player.get_followerID(1)).direction = 8 ; get_character($game_player.get_followerID(1)).move_forward_force
					get_character($game_player.get_followerID(1)).move_speed = 2.5
					$game_player.direction = 2 ; $game_player.move_forward_force
					$game_player.move_speed = 2.5
					$game_player.direction = 8
					until !get_character($game_player.get_followerID(1)).moving? ; wait(1) end
				}
				wait(10)
				
				
				#switch GS make his specail potion
				get_character($game_player.get_followerID(1)).animation = get_character($game_player.get_followerID(1)).animation_atk_pray_hold
				SndLib.sound_Bubble
				wait(60)
				get_character($game_player.get_followerID(1)).animation = get_character($game_player.get_followerID(1)).animation_atk_hook_hold
				SndLib.sound_Bubble
				wait(60)
				get_character($game_player.get_followerID(1)).animation = get_character($game_player.get_followerID(1)).animation_atk_pray_hold
				SndLib.sound_Bubble
				wait(60)
				
				#throw potion to room
				get_character($game_player.get_followerID(1)).animation = get_character($game_player.get_followerID(1)).animation_atk_mh
				SndLib.sound_whoosh(100,100)
				wait(60)
				get_character($game_player.get_followerID(1)).animation = get_character($game_player.get_followerID(1)).animation_atk_sh
				tmpGateOD=get_character(tmpEnterGateID).direction
				get_character(tmpEnterGateID).direction = 4
				wait(2)
				get_character(tmpEnterGateID).direction = 2
				SndLib.closeDoor(100,50)
				get_character($game_player.get_followerID(1)).call_balloon(8)
				wait(60)
				get_character($game_player.get_followerID(1)).call_balloon(8)
				wait(60)
				get_character($game_player.get_followerID(1)).call_balloon(8)
				wait(60)
				tmpVOL = 80
				3.times{
					wait(1+rand(5))
					SndLib.sound_goblin_spot(tmpVOL,90)
					wait(1+rand(5))
					#SndLib.sound_OgreQuestion(tmpVOL,90)
					#wait(1+rand(5))
					SndLib.sound_goblin_death(tmpVOL,90)
					wait(30)
					tmpVOL -= 20
				}
				wait(60)
				
				#open the door
				get_character($game_player.get_followerID(1)).animation = get_character($game_player.get_followerID(1)).animation_atk_sh
				get_character(tmpEnterGateID).direction = 4
				wait(2)
				
				get_character(tmpEnterGateID).direction = tmpGateOD
				SndLib.closeDoor(100,50)
				wait(60)
				get_character($game_player.get_followerID(1)).turn_toward_character($game_player)
				call_msg("TagMapSyb_WarBossRoom:EnterBossRoom/OrkindSlayer_Give1")
				
				get_character($game_player.get_followerID(1)).move_type = tmpGSmove_Type
				get_character($game_player.get_followerID(1)).npc_story_mode(false)
				
				
				
				get_character(tmDualBiosID).summon_data[:OrkindSlayerThrowPee] = true
				get_character(tmpOgreWarBossID).summon_data[:WarbossOrkindSlayerWin] = true
				get_character(tmpOgreWarBossID).summon_data[:StoryMode] = true
				#get_character(tmpOgreWarBossID).summon_data[:GoblinSlayerMode] = true
				get_character(tmDualBiosID).summon_data[:BossFightBeginPlayed] = true
				$game_map.events.each{|event|
						next if !event[1].summon_data
						next if !event[1].summon_data[:GobFucker]
						event[1].move_type = 1
						event[1].set_manual_move_type(1)
						event[1].animation = nil
						event[1].unset_event_chs_sex
						event[1].npc.battle_stat.set_stat_m("sta",0,[0,2,3])
						event[1].npc.battle_stat.set_stat_m("health",3,[0,2,3])
						event[1].npc.refresh
				}
				$game_map.events.each{|event|
					next if !event[1].summon_data
					next if !event[1].summon_data[:MeatToiletCropse]
					event[1].unset_event_chs_sex
				}
				get_character(tmpOgreWarBossID).npc.battle_stat.set_stat_m("sta",0,[0,2,3])
				get_character(tmpOgreWarBossID).npc.battle_stat.set_stat_m("health",10,[0,2,3])
				get_character(tmpOgreWarBossID).npc.refresh
				get_character(tmpOgreWarBossID).animation = nil
				get_character(tmpOgreWarBossID).move_type = 1
				get_character(tmpOgreWarBossID).set_manual_move_type(1)
				get_character(tmpbossEQPID).delete
				get_character(tmpThrowHeadID).moveto(tmpOgreWarBossX+1,tmpOgreWarBossY+1)
				get_character(tmpThrowHeadID).through = false
				get_character(tmpThrowHeadID).forced_z = -3
				get_character(tmpThrowHeadID).priority_type = 0
				get_character(tmpThrowHeadID).opacity = 255
				get_character(tmpThrowHeadID).forced_x = 0
				get_character(tmpThrowHeadID).forced_x = 0
				15.times{
					$game_map.events.each{|event|
							next if !event[1].summon_data
							next if !event[1].summon_data[:GobFucker]
							event[1].move_toward_character(get_character(tmpToBossRoomID))
							#event[1].move_random
					}
					#get_character(tmpOgreWarBossID).move_random
					get_character(tmpOgreWarBossID).move_toward_character(get_character(tmpToBossRoomID))
				}
				return eventPlayEnd
			 else #no item
				call_msg("TagMapSyb_WarBossRoom:EnterBossRoom/OrkindSlayer_Give0_failed")
				return eventPlayEnd
			 end
	end
end


############################################################################Boss fight begin  First time
if $story_stats["Captured"] == 0 && $story_stats["RapeLoop"] == 0 && $story_stats["UniqueCharUniqueOgreWarBoss"] != -1 && !get_character(tmDualBiosID).summon_data[:BossFightBeginPlayed]
	get_character(tmDualBiosID).summon_data[:BossFightBeginPlayed] = true
	
	
	get_character(tmpCamID).npc_story_mode(true)
	if $story_stats["Syb_WarBossRoom_WarBossOP"] == 0
		$story_stats["Syb_WarBossRoom_WarBossOP"] = 1
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			$game_player.transparent = true
			$hudForceHide = true
			tmpLP = RPG::BGM.last.pos
			tmpLP2 = RPG::BGS.last.pos
			SndLib.bgm_stop
			SndLib.bgm_play("D/WarBossKeep-Keep-18 - tomb loop",90,100,tmpLP)
			SndLib.bgs_stop
			SndLib.bgs_play("D/ATMO EERIE Cave, Water Drips, Emptyness, Howling Interior Wind, Oppressive, LOOP",20,100,tmpLP2)
			get_character(tmpCamID).moveto(tmpCamX,tmpCamY)
			get_character(tmpGobRunnerID).npc_story_mode(true)
			get_character(tmpThrowHeadID).npc_story_mode(true)
			get_character(tmpOgreWarBossID).npc_story_mode(true)
			get_character(tmpOgreWarBossID).balloon_XYfix = 15
			get_character(tmpOgreWarBossID).summon_data[:StoryMode] = true
			get_character(tmpGobRunnerID).opacity = 255
			get_character(tmpGobRunnerID).moveto(tmpToBossRoomX,tmpToBossRoomY)
			get_character(tmpGobRunnerID).direction = 2
			
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:GobFucker]
				event[1].npc_story_mode(true)
			}
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:MeatReciver]
				event[1].npc_story_mode(true)
			}
			cam_follow(tmpCamID,0)
		chcg_background_color(0,0,0,255,-7)
		4.times{ 
			get_character(tmpGobRunnerID).direction = 8 ; get_character(tmpGobRunnerID).move_forward_force
			get_character(tmpGobRunnerID).move_speed = 2.5
			get_character(tmpGobRunnerID).direction = 2
			until !get_character(tmpGobRunnerID).moving? ; wait(1) end
		}
		SndLib.sound_goblin_spot(80,120)
		get_character(tmpGobRunnerID).jump_to_low(get_character(tmpGobRunnerID).x,get_character(tmpGobRunnerID).y)
		get_character(tmpGobRunnerID).call_balloon(6)
		wait(20)
		get_character(tmpGobRunnerID).jump_to_low(get_character(tmpGobRunnerID).x,get_character(tmpGobRunnerID).y)
		get_character(tmpGobRunnerID).call_balloon(6)
		wait(60)
		
		################run to warboss
		7.times{ 
			get_character(tmpGobRunnerID).direction = 8 ; get_character(tmpGobRunnerID).move_forward_force
			get_character(tmpGobRunnerID).move_speed = 5
			until !get_character(tmpGobRunnerID).moving? ; wait(1) end
		}
		################move cam to warboss
		9.times{ 
			get_character(tmpCamID).direction = 8 ; get_character(tmpCamID).move_forward_force
			get_character(tmpCamID).move_speed = 4
			until !get_character(tmpCamID).moving? ; wait(1) end
		}
		
		#yell to boss
		SndLib.sound_goblin_spot(80,120)
		get_character(tmpGobRunnerID).jump_to_low(get_character(tmpGobRunnerID).x,get_character(tmpGobRunnerID).y)
		get_character(tmpGobRunnerID).call_balloon(20)
		wait(20)
		get_character(tmpGobRunnerID).jump_to_low(get_character(tmpGobRunnerID).x,get_character(tmpGobRunnerID).y)
		get_character(tmpGobRunnerID).call_balloon(20)
		wait(90)
		
		#boss say .....
		get_character(tmpOgreWarBossID).call_balloon(8)
		wait(90)
		
		#gob say .....
		SndLib.sound_goblin_spot(80,110)
		get_character(tmpGobRunnerID).call_balloon(8)
		wait(60)
		
		#yell boss again
		SndLib.sound_goblin_spot(80,120)
		get_character(tmpGobRunnerID).jump_to_low(get_character(tmpGobRunnerID).x,get_character(tmpGobRunnerID).y)
		get_character(tmpGobRunnerID).call_balloon(20)
		wait(20)
		get_character(tmpGobRunnerID).jump_to_low(get_character(tmpGobRunnerID).x,get_character(tmpGobRunnerID).y)
		get_character(tmpGobRunnerID).call_balloon(20)
		wait(90)
		
		#boss say .....
		SndLib.sound_OgreQuestion(80,90)
		aniArr=[[6,2,0,0,16]]
		get_character(tmpOgreWarBossID).animation = get_character(tmpOgreWarBossID).aniCustom(aniArr,-1)
		get_character(tmpOgreWarBossID).call_balloon(5)
		wait(90)
		
		#yell boss last time
		SndLib.sound_goblin_spot(80,120)
		get_character(tmpGobRunnerID).jump_to(get_character(tmpGobRunnerID).x,get_character(tmpGobRunnerID).y)
		get_character(tmpGobRunnerID).call_balloon(20)
		wait(20)
		get_character(tmpGobRunnerID).jump_to(get_character(tmpGobRunnerID).x,get_character(tmpGobRunnerID).y)
		get_character(tmpGobRunnerID).call_balloon(20)
		wait(90)
		
		#boss throw head
		aniArr = [
		[6,1,2,0 ,16],
		[6,1,2,-1 ,16],
		[6,1,2,0 ,16],
		[6,1,2,-1 ,16],
		[6,1,2,0 ,16],
		[6,1,2,-1 ,16],
		[6,1,2,0 ,16],
		[6,1,2,-1 ,16],
		[6,1,2,0 ,16],
		[6,1,2,-1 ,16],
		[6,1,2,0 ,16],
		[6,1,2,-1 ,16],
		[6,1,2,0 ,16],
		[6,1,2,-1 ,16],
		[6,1,2,0 ,16],
		[6,1,2,-1 ,16],
		[6,1,2,0 ,16],
		[6,1,2,-1 ,16],
		[6,1,2,0 ,16],
		[6,1,2,-1 ,16],
		[6,1,2,0 ,16],
		[6,1,2,-1 ,16],
		[6,1,2,0 ,16],
		[6,1,2,-1 ,16],
		[6,1,2,0 ,16],
		[6,1,2,-1 ,16],
		[6,1,2,0 ,16],
		[6,1,2,-1 ,16],
		[6,1,2,0 ,16],
		[6,1,2,-1 ,16],
		[6,1,2,0 ,16],
		[6,1,2,-1 ,16],
		
		[7,1,2,0 ,16],
		[7,1,2,-1 ,16],
		[7,1,2,0 ,16],
		[7,1,2,-1 ,16],
		[7,1,2,0 ,16],
		[7,1,2,-1 ,16],
		[7,1,2,0 ,16],
		[7,1,2,-1 ,16],
		[7,1,2,0 ,16],
		[7,1,2,-1 ,16],
		[7,1,2,0 ,16],
		[7,1,2,-1 ,16],
		[7,1,2,0 ,16],
		[7,1,2,-1 ,16],
		[7,1,2,0 ,16],
		[7,1,2,-1 ,16],
		[7,1,2,0 ,16],
		[7,1,2,-1 ,16],
		[7,1,2,0 ,16],
		[7,1,2,-1 ,16],
		[7,1,2,0 ,16],
		[7,1,2,-1 ,16],
		[7,1,2,0 ,16],
		[7,1,2,-1 ,16],
		[7,1,2,0 ,16],
		[7,1,2,-1 ,16],
		[7,1,2,0 ,16],
		[7,1,2,-1 ,16],
		[7,1,2,0 ,16],
		[7,1,2,-1 ,16],
		[7,1,2,0 ,16],
		[7,1,2,-1 ,16],
		
		[8,1,-1,0,16]
		]
		get_character(tmpOgreWarBossID).animation = get_character(tmpOgreWarBossID).aniCustom(aniArr,-1)
		SndLib.sound_combat_hit_gore
		10.times{$game_damage_popups.add(rand(12)+1,tmpOgreWarBossX, tmpOgreWarBossY,2,5)}
		wait(64)
		10.times{$game_damage_popups.add(rand(12)+1,tmpOgreWarBossX, tmpOgreWarBossY,2,5)}
		SndLib.sound_combat_hit_gore
		wait(64)
		SndLib.sound_combat_whoosh(100)
		get_character(tmpThrowHeadID).moveto(tmpOgreWarBossX,tmpOgreWarBossY)
		get_character(tmpThrowHeadID).opacity = 255
		
		#summon throw head
		2.times{ 
			get_character(tmpThrowHeadID).direction = 2 ; get_character(tmpThrowHeadID).move_forward_force
			get_character(tmpThrowHeadID).move_speed = 6
			until !get_character(tmpThrowHeadID).moving? ; wait(1) end
		}
		
		#summon throw hit Food
		SndLib.sound_punch_hit(100)
		get_character(tmpFoodEVID).opacity = 0
		EvLib.sum("EffectOverKill",tmpFoodEVX,tmpFoodEVY)
		$game_map.interpreter.screen.start_shake(5,10,4)
		10.times{$game_damage_popups.add(rand(12)+1,tmpOgreWarBossX, tmpOgreWarBossY,2,8)}
		1.times{ 
			get_character(tmpThrowHeadID).direction = 2 ; get_character(tmpThrowHeadID).move_forward_force
			get_character(tmpThrowHeadID).move_speed = 6
			until !get_character(tmpThrowHeadID).moving? ; wait(1) end
		}
		$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:GobFucker] || !event[1].summon_data[:GobFapper]
				event[1].unset_event_chs_sex
				event[1].move_type = 0
				event[1].set_manual_move_type(0)
				event[1].animation = nil
				event[1].jump_to(event[1].x,event[1].y)
		}
		
		#summon throw head Hit GOB
		SndLib.sound_punch_hit(100)
		SndLib.sound_goblin_death
		$game_map.interpreter.screen.start_shake(5,10,4)
		5.times{$game_damage_popups.add(rand(12)+1,tmpGobRunnerX, tmpGobRunnerY,2,5)}

		### all gob stop sex and watch what happen
		$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:GobFucker]
				event[1].move_type = 0
				event[1].set_manual_move_type(0)
				event[1].unset_event_chs_sex
				event[1].item_jump_to
				event[1].turn_toward_character(get_character(tmpOgreWarBossID))
				event[1].call_balloon([2,1].sample)
		}
		$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:MeatToiletCropse]
				event[1].unset_event_chs_sex
		}
		7.times{ 
			get_character(tmpGobRunnerID).direction = 2 ; get_character(tmpGobRunnerID).move_forward_force
			get_character(tmpGobRunnerID).move_speed = 6
			get_character(tmpGobRunnerID).direction = 8
			
			get_character(tmpThrowHeadID).direction = 2 ; get_character(tmpThrowHeadID).move_forward_force
			get_character(tmpThrowHeadID).move_speed = 6
			until !get_character(tmpThrowHeadID).moving? ; wait(1) end
		}
		$game_map.interpreter.screen.start_shake(5,10,30)
		SndLib.sound_gore(80,70)
		SndLib.sound_punch_hit(100,70)
		wait(120)
		get_character(tmpGobRunnerID).through = true
		get_character(tmpGobRunnerID).setup_cropse_graphics(2)
			
		#put player to boss fight location
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			get_character(tmpThrowHeadID).opacity = 0 
			get_character(tmpThrowHeadID).moveto(tmpThrowHeadX,tmpThrowHeadY)
			$game_player.transparent = false
			$game_player.direction = 8
			follower_goto(tmpToBossRoomX,tmpToBossRoomY) #follower first so they wont stay in room
			$game_player.moveto(tmpToBossRoomX,tmpToBossRoomY)
			get_character(tmpOgreWarBossID).animation = nil
			get_character(tmpOgreWarBossID).move_forward_force
			get_character(tmpbossEQPID).delete
			get_character(tmpFoodEVID).delete
			cam_center(0)
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:GobFucker]
				event[1].move_type = 0
				event[1].set_manual_move_type(0)
				event[1].unset_chs_sex
				event[1].turn_toward_character(get_character(tmpGobRunnerID))
			}
		chcg_background_color(0,0,0,255,-7)
		
		#Lona enter Boss Room
		2.times{
			$game_player.direction = 8 ; $game_player.move_forward_force
			$game_player.move_speed = 3
			until !$game_player.moving? ; wait(1) end
		}
		$game_player.direction = 6
		$game_player.call_balloon(8)
		wait(60)
		$game_player.direction = 4
		$game_player.call_balloon(8)
		wait(60)
		call_msg("TagMapSyb_WarBossRoom:EnterBossRoom/1_smell") ; portrait_hide
		
		SndLib.sound_goblin_death(60,120)
		wait(20)
		SndLib.sound_goblin_death(60,120)
		$game_player.direction = 8
		$game_player.call_balloon(1)
		wait(60)
		
		
		##############Kill 2 gobs
		cropseLVL = 1
		$game_map.events.each{|event|
			next if !event[1].summon_data
			next if !event[1].summon_data[:GobFucker]
			next if !event[1].summon_data[:GobKill]
			next if !event[1].npc?
			next if !event[1].npc?
			event[1].npc.drop_list = []
			event[1].npc.battle_stat.set_stat_m("health",0,[0,2,3])
			event[1].npc.refresh
			event[1].setup_cropse_graphics(cropseLVL)
			$game_map.delete_npc(event[1])
			cropseLVL += 1 if cropseLVL < 3
		}
		
		###############GOb run to exit
		tmpIsAnyMoreGob = true
		tmpCount = 0
		goalEV = get_character(tmpToBossRoomID)
		until !tmpIsAnyMoreGob #til theres no more Gobs 
			tarSightEV = nil
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:GobFucker]
				next if event[1].summon_data[:GobKill]
				next if event[1].moving?
				next if event[1].deleted?
				next if !event[1].npc?
				next event[1].delete if (event[1].x == goalEV.x || event[1].x == goalEV.x+1 || event[1].x == goalEV.x-1) && event[1].y == goalEV.y
				event[1].move_speed = 4.5
				event[1].move_goto_xy(goalEV.x,goalEV.y)
				tarSightEV = event[1]
			}
			tmpCount += 1
			if tmpCount >= 5
				tmpCount = 0
				$game_player.turn_toward_character(tarSightEV) if tarSightEV
			end
			tmpIsAnyMoreGob = $game_map.events.any?{|event|
				next if event[1].deleted?
				next unless event[1].summon_data && event[1].summon_data[:GobFucker] && !event[1].summon_data[:GobKill]
				true
			}
			wait(1) 
		end
		wait(30)
		
		#close the door
		SndLib.closeDoor(100,50)
		get_character(tmpBossRoomDoorID).pattern = get_character(tmpBossRoomDoorID).manual_pattern = 0
		get_character(tmpBossRoomDoorID).summon_data[:locked] = true
		wait(30)
		$game_player.direction = 2
		call_msg("TagMapSyb_WarBossRoom:EnterBossRoom/2_sawGobRunning") ; portrait_hide
		
		#cam_to_boss
		$game_player.direction = 8
		$game_player.call_balloon(1)
		#SndLib.sound_OgreDed(100,60)
		wait(30)
		get_character(tmpCamID).moveto($game_player.x,$game_player.y)
		cam_follow(tmpCamID,0)
		12.times{ 
			get_character(tmpCamID).direction = 8 ; get_character(tmpCamID).move_forward_force
			get_character(tmpCamID).move_speed = 5
			until !get_character(tmpCamID).moving? ; wait(1) end
		}
		
		#WarBoss shield taught Lona
		aniArr =[[6,4,25],[0,0,5],[2,0,10],[0,0,5],[6,4,25]]
		2.times{
			get_character(tmpOgreWarBossID).animation = get_character(tmpOgreWarBossID).aniCustom(aniArr,-1)
			wait(30)
			SndLib.sound_shield_up
			wait(10)
		}
		get_character(tmpOgreWarBossID).animation = nil
		wait(30)
		
		#Show OgreWarBoss portrait
		SndLib.bgm_play("D/WarBoss-Boss-05 - shadow i loop",85,100)
		$game_portraits.setLprt("OgreWarboss_BoneShield")
		$game_portraits.lprt.shake
		get_character(tmpOgreWarBossID).call_balloon(20)
		SndLib.sound_OgreDed(100,60)
		wait(1)
		$game_portraits.rprt.focus
		wait(10)
		$game_portraits.lprt.shake
		wait(150)
		$game_portraits.lprt.fade
		
		
		#lona shocked and BossFight started
		12.times{ 
			get_character(tmpCamID).direction = 2 ; get_character(tmpCamID).move_forward_force
			get_character(tmpCamID).move_speed = 7
			until !get_character(tmpCamID).moving? ; wait(1) end
		}
		wait(30)
		call_msg("TagMapSyb_WarBossRoom:EnterBossRoom/3_sawWarBoss#{talk_persona}")

	############################################################################Boss fight begin  First time
	else
		#put player to boss fight location
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
			$hudForceHide = true
			$game_player.transparent = false
			$game_player.direction = 8
			follower_goto(tmpToBossRoomX,tmpToBossRoomY) #follower first so they wont stay in room
			$game_player.moveto(tmpToBossRoomX,tmpToBossRoomY)
			get_character(tmpOgreWarBossID).npc_story_mode(true)
			get_character(tmpOgreWarBossID).summon_data[:StoryMode] = true
			get_character(tmpOgreWarBossID).animation = nil
			get_character(tmpOgreWarBossID).move_forward_force
			get_character(tmpbossEQPID).delete
			get_character(tmpFoodEVID).delete
			cam_center(0)
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:GobFucker]
				event[1].move_type = 0
				event[1].set_manual_move_type(0)
				event[1].npc_story_mode(true)
			}
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:MeatReciver]
				event[1].npc_story_mode(true)
			}
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:GobFucker]
				event[1].unset_event_chs_sex
			}
			wait(3)
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:GobFucker]
				event[1].move_type = 0
				event[1].set_manual_move_type(0)
				event[1].delete
			}
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:MeatToiletCropse]
				event[1].unset_event_chs_sex
			}
		chcg_background_color(0,0,0,255,-7)
		
		#Lona enter Boss Room
		2.times{
			$game_player.direction = 8 ; $game_player.move_forward_force
			$game_player.move_speed = 3
			until !$game_player.moving? ; wait(1) end
		}
		$game_player.direction = 6
		$game_player.call_balloon(8)
		wait(60)
		$game_player.direction = 4
		$game_player.call_balloon(8)
		wait(60)
		
		
		
		#close the door
		SndLib.closeDoor(100,50)
		get_character(tmpBossRoomDoorID).pattern = get_character(tmpBossRoomDoorID).manual_pattern = 0
		get_character(tmpBossRoomDoorID).summon_data[:locked] = true
		$game_player.direction = 2
		$game_player.call_balloon(1)
		wait(120)
		
		#cam_to_boss
		$game_player.direction = 8
		$game_player.call_balloon(1)
		#SndLib.sound_OgreDed(100,60)
		wait(30)
		get_character(tmpCamID).moveto($game_player.x,$game_player.y)
		cam_follow(tmpCamID,0)
		12.times{ 
			get_character(tmpCamID).direction = 8 ; get_character(tmpCamID).move_forward_force
			get_character(tmpCamID).move_speed = 5
			until !get_character(tmpCamID).moving? ; wait(1) end
		}
		
		#WarBoss shield taught Lona
		aniArr =[[6,4,25],[0,0,5],[2,0,10],[0,0,5],[6,4,25]]
		2.times{
			get_character(tmpOgreWarBossID).animation = get_character(tmpOgreWarBossID).aniCustom(aniArr,-1)
			wait(30)
			SndLib.sound_shield_up
			wait(10)
		}
		get_character(tmpOgreWarBossID).animation = nil
		wait(30)
		
		#Show OgreWarBoss portrait
		SndLib.bgm_play("D/WarBoss-Boss-05 - shadow i loop",85,100)
		$game_portraits.setLprt("OgreWarboss_BoneShield")
		$game_portraits.lprt.shake
		get_character(tmpOgreWarBossID).call_balloon(20)
		SndLib.sound_OgreDed(100,60)
		wait(1)
		$game_portraits.rprt.focus
		wait(10)
		$game_portraits.lprt.shake
		wait(150)
		$game_portraits.lprt.fade
		
		#lona shocked and BossFight started
		12.times{ 
			get_character(tmpCamID).direction = 2 ; get_character(tmpCamID).move_forward_force
			get_character(tmpCamID).move_speed = 7
			until !get_character(tmpCamID).moving? ; wait(1) end
		}
		wait(30)
		$game_player.call_balloon(6)
		$game_player.jump_to($game_player.x,$game_player.y)
		call_msg("TagMapSyb_WarBossRoom:EnterBossRoom/3_sawWarBoss_again#{talk_persona}")
	end
	
	
	
	
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		$hudForceHide = false
		tmpLP = RPG::BGM.last.pos
		SndLib.bgm_stop
		SndLib.bgm_play("D/WarBoss-Boss-05 - shadow i loop",90,103,tmpLP)
		cam_center(0)
		get_character(tmpOgreWarBossID).balloon_XYfix = 0
		get_character(tmpGobRunnerID).npc_story_mode(false)
		get_character(tmpCamID).npc_story_mode(false)
		get_character(tmpThrowHeadID).npc_story_mode(true)
		get_character(tmpOgreWarBossID).npc_story_mode(false)
		get_character(tmpCamID).npc_story_mode(false)
		get_character(tmpOgreWarBossID).move_type = 2
		get_character(tmpOgreWarBossID).set_manual_move_type(2)
		get_character(tmpOgreWarBossID).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],50000)
		$game_map.events.each{|event|
			next if !event[1].summon_data
			next if !event[1].summon_data[:GobFucker]
			event[1].npc_story_mode(false)
			event[1].unset_event_chs_sex
			event[1].move_type = 0
			event[1].set_manual_move_type(0)
		}
		$game_map.events.each{|event|
			next if !event[1].summon_data
			next if !event[1].summon_data[:MeatReciver]
			event[1].npc_story_mode(false)
		}
		$game_map.events.each{|event|
			next if !event[1].summon_data
			next if !event[1].summon_data[:MeatToiletCropse]
			event[1].npc_story_mode(true)
			event[1].unset_event_chs_sex
		}
		Cache.clear #67 70 66
	chcg_background_color(0,0,0,255,-7)
else
	tmpData = [nil,nil,nil,nil,
	"cave_fall",
	nil,nil,nil]
	moveto_teleport_point("ToBossRoom",tmpData,8)
end
