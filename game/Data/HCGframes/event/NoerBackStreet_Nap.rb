
tmpH_BIOS_ID = $game_map.get_storypoint("H_BIOS")[2]
get_character(tmpH_BIOS_ID).summon_data[:WorkerMode] = false if $story_stats["Captured"] != 0 || $story_stats["RapeLoop"] != 0
tmp_fucker_id = nil
if $story_stats["RapeLoopTorture"] != 1
	do_ret = false
	no_more_until = nil
	until do_ret
		tmp_fucker_id = nil
		tmpFuckerNPCs = $game_map.npcs.select{|event| 
			next if event.summon_data == nil
			next if event.summon_data[:NapFucker] == nil
			next if !event.summon_data[:NapFucker]
			next if event.actor.action_state != nil && event.actor.action_state !=:none
			next if !event.near_the_target?($game_player,5)
			next if !event.actor.target.nil?
			next if event.opacity != 255
			next if event.actor.sensors[0].get_signal(event,$game_player)[2] <=15 #[target,distance,signal_strength,sensortype]
			event
		}
		if !tmpFuckerNPCs.empty?
			tgtEV = tmpFuckerNPCs.sample
			tgtEV.summon_data[:NapFucker] = false
			tmp_fucker_id = tgtEV.id
		end
		break if !tmp_fucker_id
		tmpFuckerNPCs.each{|event|
			event.call_balloon([1,4,8,3].sample)
			event.moveto(event.x,event.y)
		}
		
		if tmp_fucker_id != nil && !$game_map.threat
			$story_stats["DreamPTSD"] = "Slave" if $game_player.actor.mood <= -50
			get_character(tmp_fucker_id).opacity = 255
			get_character(tmp_fucker_id).setup_audience
			get_character(tmp_fucker_id).move_type =0
			get_character(tmp_fucker_id).animation = nil
			get_character(tmp_fucker_id).call_balloon(2)
			get_character(tmp_fucker_id).turn_toward_character($game_player)
			tmpRACE= "_#{get_character(tmp_fucker_id).actor.race}"
			call_msg("common:Noer/NapRape#{tmpRACE}#{rand(2)}")
			get_character(tmp_fucker_id).npc_story_mode(true,false)
			wait(80)
				10.times{
					if get_character(tmp_fucker_id).report_range($game_player) > 1
						get_character(tmp_fucker_id).move_speed = 2.8
						get_character(tmp_fucker_id).move_toward_TargetSmartAI($game_player)
						get_character(tmp_fucker_id).call_balloon(8)
						until !get_character(tmp_fucker_id).moving?
							wait(1)
						end
					end
				}
			get_character(tmp_fucker_id).call_balloon(4)
			get_character(tmp_fucker_id).npc_story_mode(false,false)
			get_character(tmp_fucker_id).turn_toward_character($game_player)
			call_msg("common:Noer/NapRape1#{tmpRACE}")
			call_msg("common:Noer/NapRape2#{tmpRACE}")
			goto_sex_point_with_character(get_character(tmp_fucker_id),"closest",tmpMoveToCharAtEnd=false)
			do_ret = false
			$game_player.turn_toward_character(get_character(tmp_fucker_id))
			$game_player.call_balloon(0)
			$game_player.animation = nil
			call_msg("common:Lona/NapRape3")
			get_character(tmp_fucker_id).call_balloon(20)
			call_msg("common:Noer/NapRape3#{tmpRACE}#{rand(3)}")
			if $game_player.actor.sta > 0
				$game_player.call_balloon(0)
				$game_player.actor.add_state("DoormatUp20")
				$game_player.actor.add_state("DoormatUp20")
				$game_player.animation = nil
				$game_player.actor.cancel_holding
				$game_player.actor.reset_skill(true)
				call_msg("common:Lona/NapRape_withSta") #\optD[我是便器<t=3>,反抗]
				do_ret = false
				case $game_temp.choice
					when 0
						call_msg("common:Lona/NapRape_withSta_NoFight1#{talk_persona}")
						call_msg("common:Noer/NapRape_withSta_NoFight2#{tmpRACE}#{rand(3)}")
					when 1
						player_cancel_nap
						do_ret = true
						get_character(tmp_fucker_id).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
						$game_player.animation = $game_player.animation_atk_charge
						$game_player.actor.sta -= 5
						wait(15)
						SndLib.sound_punch_hit(100)
						SndLib.sound_punch_hit(100)
						SndLib.sound_punch_hit(100)
						get_character(tmp_fucker_id).npc_story_mode(true,false)
							get_character(tmp_fucker_id).push_away
							$game_player.turn_toward_character(get_character(tmp_fucker_id))
							get_character(tmp_fucker_id).turn_toward_character($game_player)
							until !get_character(tmp_fucker_id).moving?
								wait(1)
							end
						get_character(tmp_fucker_id).npc_story_mode(false,false)
						call_msg("common:Lona/NapRape_withSta_Fight1#{talk_persona}")
						get_character(tmp_fucker_id).call_balloon(20)
						call_msg("common:Noer/NapRape_withSta_Fight2#{tmpRACE}#{rand(3)}")
				end
				$game_temp.choice = -1
				get_character(tmp_fucker_id).actor.process_target_lost if !do_ret
				return eventPlayEnd if do_ret
			else
				call_msg("common:Lona/NapRape_noSta")
				$story_stats["sex_record_coma_sex"] +=1 if $game_player.actor.sta <=-100
			end
			get_character(tmp_fucker_id).moveto($game_player.x,$game_player.y)
			play_sex_service_menu(get_character(tmp_fucker_id),0,nil,true)
			get_character(tmp_fucker_id).turn_toward_character($game_player)
			get_character(tmp_fucker_id).actor.process_target_lost
			$game_player.animation = $game_player.animation_stun
		end
	end #until
end

if tmp_fucker_id == nil
	tmpOwnedTooMuch= $story_stats["BackStreetArrearsInterest"] > $story_stats["BackStreetArrearsPrincipal"] && $story_stats["BackStreetArrearsPrincipal"] > 0 && $story_stats["RapeLoop"] == 0
	if  get_character($game_map.get_storypoint("MapCont")[2]).summon_data[:FuckOff] && $story_stats["RapeLoop"] == 0 && $story_stats["Captured"] == 0 && !$game_player.player_slave?
		chcg_background_color(0,0,0,0,7)
		call_msg("common:Lona/NarrDriveAway")
		portrait_hide
		return change_map_leave_tag_map
	end
	if tmpOwnedTooMuch || ($game_player.player_slave? && $story_stats["RapeLoop"] == 0)
		$story_stats["RapeLoop"] = 1
		$story_stats["Captured"] = 1
		chcg_background_color(0,0,0,0,7)
		tmpU1X,tmpU1Y,tmpU1ID=$game_map.get_storypoint("stGang1")
		tmpU2X,tmpU2Y,tmpU2ID=$game_map.get_storypoint("stGang2")
		get_character(tmpU1ID).npc_story_mode(true)
		get_character(tmpU2ID).npc_story_mode(true)
		set_event_force_page(tmpU1ID,1,0)
		set_event_force_page(tmpU2ID,1,0)
		get_character(tmpU1ID).moveto($game_player.x,$game_player.y)
		get_character(tmpU2ID).moveto($game_player.x,$game_player.y)
		get_character(tmpU1ID).move_forward_passable_dir
		get_character(tmpU2ID).move_forward_passable_dir
		until !get_character(tmpU2ID).moving? && !get_character(tmpU1ID).moving?
			wait(1)
		end
		chcg_background_color(0,0,0,255,-7)
		get_character(tmpU1ID).turn_toward_character($game_player)
		get_character(tmpU1ID).call_balloon([1,5,7,15].sample)
		get_character(tmpU2ID).turn_toward_character($game_player)
		get_character(tmpU2ID).call_balloon([1,5,7,15].sample)
		call_msg("TagMapNoerBackStreet:Escape/failed")

		#移除裝備
		rape_loop_drop_item(false,false)
		load_script("Data/Batch/Put_HeavyestBondage.rb") #上銬批次檔
		$story_stats["RapeLoopTorture"] = 1
	end
	
	#事件變數導引
	$story_stats["Ending_MainCharacter"] = "Ending_MC_HumanSlave" if $story_stats["Captured"] == 1
	if $story_stats["Captured"] == 1 && $story_stats["RapeLoop"] == 1 && $story_stats["SlaveOwner"] != "NoerBackStreet" && $game_player.actor.stat["SlaveBrand"] != 1
		if $story_stats["BackStreetArrearsPrincipal"] <= 0
			$story_stats["Captured"] = 0
			$story_stats["RapeLoop"] = 0
			$story_stats["RapeLoopTorture"] = 0
			$story_stats["BackStreetArrearsPrepayDateAMT"] =0
			$story_stats["BackStreetArrearsPrincipal"] = 0
			$story_stats["BackStreetArrearsInterest"] = 0
		else
			$story_stats["BackStreetArrearsPrincipal"] += $story_stats["BackStreetArrearsWhorePrincipal"] if $game_date.night?
			$story_stats["BackStreetArrearsWhorePrincipal"] = 600+($story_stats["WorldDifficulty"]*3).round if $game_date.night?
		end
	elsif get_character(tmpH_BIOS_ID).summon_data[:WorkerMode] == true && $story_stats["Captured"] < 1 && $story_stats["RapeLoop"] < 1
		$story_stats["BackStreetArrearsPrincipal"] += $story_stats["BackStreetArrearsWhorePrincipal"] if $game_date.night?
		$story_stats["BackStreetArrearsWhorePrincipal"] = 600+($story_stats["WorldDifficulty"]*3).round if $game_date.night?

	elsif $story_stats["BackStreetArrearsInterest"] >= $story_stats["BackStreetArrearsPrincipal"] && $story_stats["BackStreetArrearsPrincipal"] > 0
		$story_stats["BackStreetArrearsPrincipal"] += $story_stats["BackStreetArrearsWhorePrincipal"] if $game_date.night?
		$story_stats["BackStreetArrearsWhorePrincipal"] = 600+($story_stats["WorldDifficulty"]*3).round if $game_date.night?
		$story_stats["Captured"] = 1
		$story_stats["RapeLoop"] = 1
	elsif $game_player.actor.stat["SlaveBrand"] == 1
		$story_stats["BackStreetArrearsWhorePrincipal"] = 750+($story_stats["WorldDifficulty"]*3).round if $game_date.night?
		$story_stats["SlaveOwner"] = "NoerBackStreet"
		$story_stats["Captured"] = 1
		$story_stats["RapeLoop"] = 1
	end


	#奴隸 物品充公 並轉換成交易點
	if $game_player.actor.stat["SlaveBrand"] == 1 && $game_party.get_price_from_items >0
		#類型轉價位
		tarEqpPrice = $game_party.get_price_from_items
		$story_stats["BackStreetArrearsWhorePrincipal"] -= tarEqpPrice
		$story_stats["BackStreetArrearsWhorePrincipal"] = 0 if $story_stats["BackStreetArrearsWhorePrincipal"] <= 0
		$game_party.drop_all_items_and_summon(false,["Key","Bondage","Hair","Trait", "Child"],false)
		call_msg("TagMapNoerBackStreet:nap/WhorePrincipal_returnEqp") if tarEqpPrice >0
	end

	#轉換交易餘額成保護費 並判斷是否虐待
	if $story_stats["Captured"] == 1 && $story_stats["UniqueCharUniqueHappyMerchant"] != -1 && $story_stats["RapeLoopTorture"] != 1
		tmpReturn = [$game_party.gold,$story_stats["BackStreetArrearsWhorePrincipal"]].min
		$game_party.lose_gold(tmpReturn)
		$story_stats["BackStreetArrearsWhorePrincipal"] -= tmpReturn
		$story_stats["BackStreetArrearsWhorePrincipal"] = 0 if $story_stats["BackStreetArrearsWhorePrincipal"] <= 0
		if $story_stats["BackStreetArrearsWhorePrincipal"] > 0 && $game_date.day?
			$story_stats["RapeLoopTorture"] = 1
			call_msg("TagMapNoerBackStreet:nap/SlaveTorture")
		else
			 $story_stats["RapeLoopTorture"] = 0
		end

	end


	#虐待演出
	if $story_stats["RapeLoopTorture"] == 1
		$story_stats["DreamPTSD"] = "Slave" if $game_player.actor.mood <= -50
		$story_stats["RapeLoopTorture"] = 0
		#分配腳色位置
		chcg_background_color(0,0,0,0,7)
		tmpX,tmpY=$game_map.get_storypoint("CapturedPoint")
		$game_player.moveto(tmpX,tmpY)
		$game_player.direction = 2
		$game_player.call_balloon(0)
		tmpU1X,tmpU1Y,tmpU1ID=$game_map.get_storypoint("stGang1")
		tmpU2X,tmpU2Y,tmpU2ID=$game_map.get_storypoint("stGang2")
		get_character(tmpU1ID).npc_story_mode(true)
		get_character(tmpU2ID).npc_story_mode(true)
		set_event_force_page(tmpU1ID,1,0)
		set_event_force_page(tmpU2ID,1,0)
		get_character(tmpU1ID).moveto($game_player.x,$game_player.y)
		get_character(tmpU1ID).move_forward_passable_dir
		get_character(tmpU2ID).moveto($game_player.x,$game_player.y)
		get_character(tmpU2ID).move_forward_passable_dir
		$game_map.npcs.each do |event|
			next if event.summon_data == nil
			next if event.summon_data[:BsWhore] == nil
			next if !event.summon_data[:BsWhore]
			next if event.actor.action_state != nil && event.actor.action_state !=:none
			next if event.animation != nil
			next if !event.actor.target.nil?
			next if event.region_id == 55
			posi=$game_map.region_map[30].sample
			event.moveto(posi[0],posi[1])
			event.npc_story_mode(true)
			event.move_forward_passable_dir
		end

		chcg_background_color(0,0,0,255,-7)
		get_character(tmpU1ID).turn_toward_character($game_player)
		get_character(tmpU1ID).call_balloon([1,5,7,15].sample)
		get_character(tmpU2ID).turn_toward_character($game_player)
		get_character(tmpU2ID).call_balloon([1,5,7,15].sample)
		$game_map.npcs.each do |event|
			next if event.summon_data == nil
			next if event.summon_data[:BsWhore] == nil
			next if !event.summon_data[:BsWhore]
			next if event.actor.action_state != nil && event.actor.action_state !=:none
			next if event.animation != nil
			next if !event.actor.target.nil?
			next if event.region_id == 55
			event.turn_toward_character($game_player)
		end

		#虐待實體表演
		call_msg("TagMapNoerBackStreet:nap/torture_begin")

		get_character(tmpU1ID).animation = get_character(tmpU1ID).animation_atk_mh
		get_character(tmpU1ID).call_balloon([15,7,5].sample)
		$game_player.animation = $game_player.animation_stun
		$game_player.jump_to_low($game_player.x,$game_player.y)
		load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
		wait(45+rand(30))
		get_character(tmpU2ID).animation = get_character(tmpU2ID).animation_atk_sh
		get_character(tmpU2ID).call_balloon([15,7,5].sample)
		$game_player.animation = $game_player.animation_stun
		$game_player.jump_to_low($game_player.x,$game_player.y)
		SndLib.sound_whoosh ; SndLib.sound_punch_hit(100)
		wait(45+rand(30))


		get_character(tmpU1ID).animation = get_character(tmpU1ID).animation_atk_sh
		get_character(tmpU1ID).call_balloon([15,7,5].sample)
		$game_player.animation = $game_player.animation_stun
		$game_player.jump_to_low($game_player.x,$game_player.y)
		load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
		wait(45+rand(30))
		get_character(tmpU2ID).animation = get_character(tmpU2ID).animation_atk_mh
		get_character(tmpU2ID).call_balloon([15,7,5].sample)
		$game_player.animation = $game_player.animation_stun
		$game_player.jump_to_low($game_player.x,$game_player.y)
		SndLib.sound_whoosh ; SndLib.sound_punch_hit(100)
		wait(45+rand(30))


		get_character(tmpU1ID).animation = get_character(tmpU1ID).animation_atk_sh
		get_character(tmpU1ID).call_balloon([15,7,5].sample)
		$game_player.animation = $game_player.animation_stun
		$game_player.jump_to_low($game_player.x,$game_player.y)
		load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
		wait(45+rand(30))
		get_character(tmpU2ID).animation = get_character(tmpU2ID).animation_atk_mh
		get_character(tmpU2ID).call_balloon([15,7,5].sample)
		$game_player.animation = $game_player.animation_stun
		$game_player.jump_to_low($game_player.x,$game_player.y)
		SndLib.sound_whoosh ; SndLib.sound_punch_hit(100)
		wait(45+rand(30))


		get_character(tmpU1ID).animation = get_character(tmpU1ID).animation_atk_mh
		get_character(tmpU1ID).call_balloon([15,7,5].sample)
		load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
		wait(45+rand(30))
		get_character(tmpU2ID).animation = get_character(tmpU2ID).animation_atk_sh
		get_character(tmpU2ID).call_balloon([15,7,5].sample)
		SndLib.sound_whoosh ; SndLib.sound_punch_hit(100)
		wait(45+rand(30))
	end #torture

	
	
	handleNap
end
