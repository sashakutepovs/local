###################################################################################################################
###################################################################################################################
######################################## Battle SEX SYSTEM    #####################################################
###################################################################################################################
###################################################################################################################

class Game_Character < Game_CharacterBase

	def player_sex_fight_struggle
		if $game_player.player_cuffed? && rand(2) ==1
			SndLib.sys_buzzer
			$game_map.popup(0,"QuickMsg:Lona/cuffed#{rand(2)}",0,0)
			return
		end
		#p self.summon_data
		@sex_fight_count_struggle +=1 if $game_player.actor.action_state==:sex
		@sex_grabbed_count_struggle +=1 if $game_player.actor.action_state==:grabbed
		$game_player.actor.sta -=1
		$game_map.interpreter.flash_screen(Color.new(125,20,125,50),8,false)
		$game_map.interpreter.screen.start_shake(10,15,8)
		@sex_fucker_total_con = ($game_player.integrity_all/3)-($game_player.actor.atk/3).round
		@sex_fucker_total_con = 5 if @sex_fucker_total_con < 5
	end
	
	
	def player_sex_service
		#$game_map.interpreter.flash_screen(Color.new(255,0,rand(50)+200,rand(160)+50),5,false)
		p "def player_sex_service"
		$game_map.interpreter.screen.start_shake(5,8,4)
		$game_player.actor.sta -=3
	end
	
	def player_get_lilith_effect(tmpTar)
		tmpTar.npc.play_sound(:sound_death,tmpTar.report_distance_to_vol_close_npc_vol)
		return if $game_player.actor.stat["Lilith"] == 0
		$game_player.actor.health +=3
		$game_player.actor.sta +=10
	end

	def player_sex_tar_ograsm(temp_hole,totalDMG=0)
		p "player_sex_tar_ograsm #{temp_hole}"
		$game_player.actor.sat +=1 if $game_player.actor.stat["SemenGulper"] ==1
		case temp_hole
			when "vag"
					tar = $game_player.fucker_vag
					tmpOriginalHp = tar.actor.battle_stat.get_stat("sta") + tar.actor.battle_stat.get_stat("health")
					tar.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicSexService_vag_crit"])
					tar.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicSexBloodlust"]) if $game_player.actor.stat["BloodLust"] ==1
					tmpCurrHp = tar.actor.battle_stat.get_stat("sta") + tar.actor.battle_stat.get_stat("health")
					tmpCritDmg = (tmpCurrHp-tmpOriginalHp).abs
					totalDMG = totalDMG+tmpCritDmg
					$game_map.interpreter.chcg_battle_sex_add_cums_to_player(temp_hole,tar.actor.race,totalDMG)
					tar.actor.battle_stat.set_stat("arousal",0)
					tar.call_balloon(25)
					player_get_lilith_effect(tar)
					$game_player.quit_sex_gang(tar)
					tar.unset_chs_sex
					tar.actor.apply_stun_effect("Stun30") if !tar.deleted? && tar.actor.action_state != :death
					$game_map.interpreter.whole_event_end
					$game_player.actor.stat["EventVagRace"] = nil
					$game_player.actor.stat["EventVag"] = nil
			when "anal"
					tar = $game_player.fucker_anal
					tmpOriginalHp = tar.actor.battle_stat.get_stat("sta") + tar.actor.battle_stat.get_stat("health")
					tar.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicSexService_anal_crit"])
					tar.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicSexBloodlust"]) if $game_player.actor.stat["BloodLust"] ==1
					tmpCurrHp = tar.actor.battle_stat.get_stat("sta") + tar.actor.battle_stat.get_stat("health")
					tmpCritDmg = (tmpCurrHp-tmpOriginalHp).abs
					totalDMG = totalDMG+tmpCritDmg
					$game_map.interpreter.chcg_battle_sex_add_cums_to_player(temp_hole,tar.actor.race,totalDMG)
					tar.actor.battle_stat.set_stat("arousal",0)
					tar.call_balloon(25)
					player_get_lilith_effect(tar)
					$game_player.quit_sex_gang(tar)
					tar.unset_chs_sex
					tar.actor.apply_stun_effect("Stun30") if !tar.deleted? && tar.actor.action_state != :death
					$game_map.interpreter.whole_event_end
					$game_player.actor.stat["EventAnalRace"] = nil
					$game_player.actor.stat["EventAnal"] = nil
			when "mouth"
					tar = $game_player.fucker_mouth
					tmpOriginalHp = tar.actor.battle_stat.get_stat("sta") + tar.actor.battle_stat.get_stat("health")
					tar.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicSexService_mouth_crit"])
					tar.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicSexBloodlust"]) if $game_player.actor.stat["BloodLust"] ==1
					tmpCurrHp = tar.actor.battle_stat.get_stat("sta") + tar.actor.battle_stat.get_stat("health")
					tmpCritDmg = (tmpCurrHp-tmpOriginalHp).abs
					totalDMG = totalDMG+tmpCritDmg
					$game_map.interpreter.chcg_battle_sex_add_cums_to_player(temp_hole,tar.actor.race,totalDMG)
					tar.actor.battle_stat.set_stat("arousal",0)
					tar.call_balloon(25)
					player_get_lilith_effect(tar)
					$game_player.quit_sex_gang(tar)
					tar.unset_chs_sex
					tar.actor.apply_stun_effect("Stun30") if !tar.deleted? && tar.actor.action_state != :death
					$game_map.interpreter.whole_event_end
					$game_player.actor.stat["EventMouthRace"] = nil
					$game_player.actor.stat["EventMouth"] = nil
		end #case
	end
	
	def player_sex_mode_input #overwrite
		tmpInputDir = Input.KeyboardMouseGetScreenEdgeDir4
		if tmpInputDir != 0 && tmpInputDir != @recordedDir
			player_sex_fight_struggle
		elsif Input.trigger?($game_player.hotkey_skill_normal)
			@sex_input_a_count +=1
			player_sex_service
		elsif Input.trigger?($game_player.hotkey_skill_heavy)
			@sex_input_s_count +=1
			player_sex_service
		elsif Input.trigger?($game_player.hotkey_skill_control)
			@sex_input_d_count +=1
			player_sex_service
		elsif Input.trigger?($game_player.skill_hotkey_0)
			@sex_input_f_count +=1 
			player_sex_service
		end
		@recordedDir = tmpInputDir if tmpInputDir !=0
	end
	def player_sex_mode_control
		#return self.delete if ![:sex,:grab].include?($game_player.actor.action_state)
			player_sex_mode_input if $game_player.actor.battle_stat.get_stat("sta") >= 0
			if @sex_fight_count_struggle == @sex_fucker_total_con 
				@sex_fight_count_struggle = 0
				return if $game_player.player_cuffed?
				#actor.launch_skill($data_arpgskills["BasicSexStruggle"],true)
				$game_player.fuckers.each{
					|fker|
					$game_map.reserve_summon_event("EffectPunchHit",@x,@y,-1,{:target => fker,:user => $game_player})
					fker.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicSexStruggle"])
				}
			end
			
			if @sex_input_a_count ==2
				@sex_input_a_count=0
				if !$game_player.fucker_vag.nil? && $game_player.fucker_vag.npc? && $game_player.fucker_vag.npc.action_state == :sex
					$game_player.fucker_vag.npc.play_sound(:sound_death,$game_player.fucker_vag.report_distance_to_vol_close_npc_vol)
					$game_player.call_balloon(21)
					if $game_player.fucker_vag.actor.battle_stat.get_stat("sta") >=0
						tmpOriginalHp = $game_player.fucker_vag.actor.battle_stat.get_stat("sta") + $game_player.fucker_vag.actor.battle_stat.get_stat("health")
						$game_player.fucker_vag.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicSexService_vag"]) if $game_player.fucker_vag.actor.battle_stat.get_stat("arousal") < $game_player.fucker_vag.actor.battle_stat.get_stat("will")
						$game_player.fucker_vag.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicSexBloodlust"]) if $game_player.actor.stat["BloodLust"] ==1
						tmpCurrHp = $game_player.fucker_vag.actor.battle_stat.get_stat("sta") + $game_player.fucker_vag.actor.battle_stat.get_stat("health")
						totalDMG = (tmpCurrHp-tmpOriginalHp).abs
						player_sex_tar_ograsm("vag",totalDMG) if ($game_player.fucker_vag.actor.battle_stat.get_stat("arousal") > $game_player.fucker_vag.actor.battle_stat.get_stat("will")) || $game_player.fucker_vag.actor.battle_stat.get_stat("sta")<= -100 || $game_player.fucker_vag.actor.battle_stat.get_stat("health") <=0
						$game_map.reserve_summon_event("EffectSexServiceIngratiateHit",@x,@y,-1,{:target => $game_player.fucker_vag,:user => $game_player})
					else
						SndLib.sys_buzzer
						$game_map.popup(0,"QuickMsg:Lona/TargetNoSta#{rand(2)}",0,0)
						player_sex_tar_ograsm("vag") 
					end
				else
				SndLib.sys_buzzer
				$game_map.popup(0,"QuickMsg:Lona/SexNoTarget#{rand(2)}",0,0)
				end
			end
			
			if @sex_input_s_count ==2
				@sex_input_s_count=0
				if !$game_player.fucker_anal.nil? && $game_player.fucker_anal.npc? && $game_player.fucker_anal.npc.action_state == :sex
					$game_player.call_balloon(22)
					if $game_player.fucker_anal.actor.battle_stat.get_stat("sta") >=0
						tmpOriginalHp = $game_player.fucker_anal.actor.battle_stat.get_stat("sta") + $game_player.fucker_anal.actor.battle_stat.get_stat("health")
						$game_player.fucker_anal.npc.play_sound(:sound_death,$game_player.fucker_anal.report_distance_to_vol_close_npc_vol)
						$game_player.fucker_anal.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicSexService_anal"]) if $game_player.fucker_anal.actor.battle_stat.get_stat("arousal") < $game_player.fucker_anal.actor.battle_stat.get_stat("will")
						$game_player.fucker_anal.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicSexBloodlust"]) if $game_player.actor.stat["BloodLust"] ==1
						tmpCurrHp = $game_player.fucker_anal.actor.battle_stat.get_stat("sta") + $game_player.fucker_anal.actor.battle_stat.get_stat("health")
						totalDMG = (tmpCurrHp-tmpOriginalHp).abs
						player_sex_tar_ograsm("anal",totalDMG) if ($game_player.fucker_anal.actor.battle_stat.get_stat("arousal") > $game_player.fucker_anal.actor.battle_stat.get_stat("will")) || $game_player.fucker_anal.actor.battle_stat.get_stat("sta")<= -100 || $game_player.fucker_anal.actor.battle_stat.get_stat("health") <=0
						$game_map.reserve_summon_event("EffectSexServiceIngratiateHit",@x,@y,-1,{:target => $game_player.fucker_anal,:user => $game_player})
					else
						SndLib.sys_buzzer
						$game_map.popup(0,"QuickMsg:Lona/TargetNoSta#{rand(2)}",0,0)
						player_sex_tar_ograsm("anal")
					end
				else
				SndLib.sys_buzzer
				$game_map.popup(0,"QuickMsg:Lona/SexNoTarget#{rand(2)}",0,0)
				end
			end
			
			if @sex_input_d_count ==2
				@sex_input_d_count=0
				if !$game_player.fucker_mouth.nil? && $game_player.fucker_mouth.npc? && $game_player.fucker_mouth.npc.action_state == :sex
					$game_player.call_balloon(23)
					if $game_player.fucker_mouth.actor.battle_stat.get_stat("sta") >=0
						tmpOriginalHp = $game_player.fucker_mouth.actor.battle_stat.get_stat("sta") + $game_player.fucker_mouth.actor.battle_stat.get_stat("health")
						$game_player.fucker_mouth.npc.play_sound(:sound_death,$game_player.fucker_mouth.report_distance_to_vol_close_npc_vol)
						$game_player.fucker_mouth.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicSexService_mouth"]) if $game_player.fucker_mouth.actor.battle_stat.get_stat("arousal") < $game_player.fucker_mouth.actor.battle_stat.get_stat("will")
						$game_player.fucker_mouth.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicSexBloodlust"]) if $game_player.actor.stat["BloodLust"] ==1
						tmpCurrHp = $game_player.fucker_mouth.actor.battle_stat.get_stat("sta") + $game_player.fucker_mouth.actor.battle_stat.get_stat("health")
						totalDMG = (tmpCurrHp-tmpOriginalHp).abs
						player_sex_tar_ograsm("mouth",totalDMG) if ($game_player.fucker_mouth.actor.battle_stat.get_stat("arousal") > $game_player.fucker_mouth.actor.battle_stat.get_stat("will")) || $game_player.fucker_mouth.actor.battle_stat.get_stat("sta")<= -100 || $game_player.fucker_mouth.actor.battle_stat.get_stat("health") <=0
						$game_map.reserve_summon_event("EffectSexServiceIngratiateHit",@x,@y,-1,{:target => $game_player.fucker_mouth,:user => $game_player})
					else
						SndLib.sys_buzzer
						$game_map.popup(0,"QuickMsg:Lona/TargetNoSta#{rand(2)}",0,0)
						player_sex_tar_ograsm("mouth")
					end
				else
				SndLib.sys_buzzer
				$game_map.popup(0,"QuickMsg:Lona/SexNoTarget#{rand(2)}",0,0)
				end
			end
			
			if @sex_input_f_count ==2
				@sex_input_f_count=0
				tmpARY = Array.new
				$game_map.npcs.each{|ev|
					next if [:death,:stun].include?(ev.npc.action_state)
					next if ev.deleted?
					next if ev.actor.action_state == :death
					next if ev.npc.target != $game_player
					next if ev.npc.ai_state != :fucker && ev != $game_player.fucker_vag && ev != $game_player.fucker_anal && ev != $game_player.fucker_mouth
					#next unless ev.npc.ai_state == :fucker || ev == $game_player.fucker_vag || ev == $game_player.fucker_anal || ev == $game_player.fucker_mouth
					next if ev.npc.master == $game_player
					next if ev.report_range($game_player) > 2
					tmpARY << ev
				}
				#tmpARY<<$game_player.fucker_vag if $game_player.fucker_vag
				#tmpARY<<$game_player.fucker_anal if $game_player.fucker_anal
				#tmpARY<<$game_player.fucker_mouth if $game_player.fucker_mouth
				#tmpARY+=$game_player.fappers if !$game_player.fappers.empty?
				if tmpARY.empty?
					SndLib.sys_buzzer
					$game_map.popup(0,"QuickMsg:Lona/SexNoTarget#{rand(2)}",0,0)
				else
					$game_player.call_balloon(24)
					tmpAoeStun = false
					tmpARY.each{
						|fper|
						$game_map.reserve_summon_event("EffectSexServiceIngratiateHit",@x,@y,-1,{:target => fper,:user => $game_player})
							if fper.actor.battle_stat.get_stat("sta") <0 || fper.actor.battle_stat.get_stat("arousal") > fper.actor.battle_stat.get_stat("will")
								tmpOriginalHp = fper.actor.battle_stat.get_stat("sta") + fper.actor.battle_stat.get_stat("health")
								fper.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicSexService_limbs_crit"])
								fper.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicSexBloodlust"]) if $game_player.actor.stat["BloodLust"] ==1
								tmpCurrHp = fper.actor.battle_stat.get_stat("sta") + fper.actor.battle_stat.get_stat("health")
								totalDMG = (tmpCurrHp-tmpOriginalHp).abs
								$game_map.interpreter.chcg_battle_sex_add_cums_to_player("body",fper.actor.race,totalDMG)
								fper.npc.play_sound(:sound_death,fper.report_distance_to_vol_close_npc_vol)
								fper.call_balloon(25)
								player_get_lilith_effect(fper)
								fper.actor.battle_stat.set_stat("arousal",0)
								$game_player.quit_sex_gang(fper)
								$story_stats["sex_record_frottage"] +=1
								#fper.actor.apply_stun_effect("Stun30") if !fper.deleted? && fper.actor.action_state != :death
								tmpAoeStun = true
								#force this character quit fapper and stun
							else
								p "player fapping attack  on =>#{fper.id}"
								fper.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicSexService_limbs"])
							end
							$game_map.reserve_summon_event("EffectSexServiceIngratiateHit",@x,@y,-1,{:target => fper,:user => $game_player})
					}
					if tmpAoeStun
						$game_player.actor.event_key_combat_end
						tmpARY.each{|ev|
							next if ev.deleted?
							next if ev.actor.action_state == :death
							next if ev.actor.action_state == :stun
							next if ev.actor.npc_dead?
							$game_player.quit_sex_gang(ev)
							ev.unset_chs_sex
							ev.actor.apply_stun_effect("Stun30")
						}
					end
				end
			end
	end #def player_sex_mode_control
	
	def player_anti_grab_mode_input
		tmpInputDir = Input.KeyboardMouseGetScreenEdgeDir4
		player_sex_fight_struggle if tmpInputDir != 0 && tmpInputDir != @recordedDir
		@recordedDir = tmpInputDir if tmpInputDir !=0
	end
	def player_anti_grab_mode_control
		#return self.delete if ![:sex,:grab].include?($game_player.actor.action_state)
		player_anti_grab_mode_input
		if $game_player.actor.battle_stat.get_stat("sta") >= 0
			
			if @sex_grabbed_count_struggle == @sex_grabber_total_con 
			@sex_fight_count_struggle = 0
			return if $game_player.player_cuffed?
			$game_player.fuckers.each{
				|fker|
				$game_map.reserve_summon_event("EffectPunchHit",@x,@y,-1,{:target => fker,:user => $game_player})
				fker.actor.take_skill_effect($game_player.actor,$data_arpgskills["BasicSexStruggle"])
			}
			$game_player.release_chs_group
			end
		end
	end
	def player_AppetizerLauncher_control
		if $game_player.fuckers.empty? || [nil,:none].include?($game_player.actor.action_state) #protect when hit target after grab
			$game_player.unset_chs_sex
			return delete
		end
		player_sex_mode_control if $game_player.actor.action_state == :sex
		player_anti_grab_mode_control if $game_player.actor.action_state == :grabbed
	end
	
	

	#####################################################################################################################################################################################
	def sex_basic_damage
	#receiver_type:
	#	0 : common_ppl(normal)  (do struggle when sex>0 and rand(100) >50 ,no counter sex ; normal people)
	#	1 : sex_warrior (no struggle , counter_sex=l, super slut)
	#	2 : meat toilet (no_struggle , no counter sex, no dmg recive or offer)
	#	3 : warrior (struggle when sta > 0, no counter sex )
	#	4 : common_ppl(weak) 完全不反抗 但接收傷害
		user=@summon_data[:user]
		tmpSndPlay = true
		user.fuckers.each{
		|fker|
			#if user==$game_player
			#	user.actor.take_skill_effect(fker.actor,$data_arpgskills["BasicSexDmg_receiver"])
			#	fker.actor.battle_stat.set_stat("arousal",fker.actor.battle_stat.get_stat("arousal")+5)
			#end
			fker.actor.play_sound(:sound_skill,fker.report_distance_to_vol_close_npc_vol) if tmpSndPlay && rand(100) > 60
			tmpSndPlay = false
			case user.actor.receiver_type
			when 0 #common_ppl(normal)  (do struggle when sex>0 and rand(100) >50 ,no counter sex ; normal people)
				user.actor.take_skill_effect(fker.actor,$data_arpgskills["BasicSexDmg_receiver"])
				fker.actor.battle_stat.set_stat("arousal",fker.actor.battle_stat.get_stat("arousal")+5)
				if user.actor.battle_stat.get_stat("sta") >0 && rand(100) >=90
					$game_map.reserve_summon_event("EffectPunchHit",@x,@y,-1,{:target => fker,:user => user})
					fker.actor.take_skill_effect(user.actor,$data_arpgskills["BasicSexStruggle"])
					user.actor.battle_stat.set_stat("sta",user.actor.battle_stat.get_stat("sta")-6)
				end
			when 1 #sex_warrior (no struggle , counter_sex=l, super slut)
				user.actor.battle_stat.set_stat("sta",user.actor.battle_stat.get_stat("sta")+6)
				if user.actor.battle_stat.get_stat("sta") >0 && rand(100) >=90
					fker.actor.take_skill_effect(user.actor,$data_arpgskills["NpcSexWarriorService_dmg"]) if rand(3) == 2
					fker.actor.battle_stat.set_stat("arousal",fker.actor.battle_stat.get_stat("arousal")+5)
				else
					user.actor.take_skill_effect(fker.actor,$data_arpgskills["BasicSexDmg_receiver"])
					fker.actor.battle_stat.set_stat("arousal",fker.actor.battle_stat.get_stat("arousal")+5)
				end
			when 2 #meat toilet (no_struggle , no counter sex, no dmg recive or offer)
				next #do nothing
			when 3 #warrior (struggle when sta > 0, no counter sex )
				user.actor.take_skill_effect(fker.actor,$data_arpgskills["BasicSexDmg_receiver"])
				fker.actor.battle_stat.set_stat("arousal",fker.actor.battle_stat.get_stat("arousal")+5)
				if user.actor.battle_stat.get_stat("sta") >0
					user.actor.battle_stat.set_stat("sta",user.actor.battle_stat.get_stat("sta")-6)
					$game_map.reserve_summon_event("EffectPunchHit",@x,@y,-1,{:target => fker,:user => user})
					fker.actor.take_skill_effect(user.actor,$data_arpgskills["BasicSexStruggle"])
				end
			when 4 #common_ppl(weak) 完全不反抗 但接收傷害
				user.actor.take_skill_effect(fker.actor,$data_arpgskills["BasicSexDmg_receiver"])
				fker.actor.battle_stat.set_stat("arousal",fker.actor.battle_stat.get_stat("arousal")+5)
			when 5 #$game_player
				user.actor.take_skill_effect(fker.actor,$data_arpgskills["BasicSexDmg_receiver"])
				fker.actor.battle_stat.set_stat("arousal",fker.actor.battle_stat.get_stat("arousal")+5)
			end #case
			
			case fker.actor.receiver_type 
				when 1
				if fker.actor.battle_stat.get_stat("sta") >0 && rand(100) >=90
					user.actor.take_skill_effect(fker.actor,$data_arpgskills["NpcSexWarriorService_dmg"])
					fker.actor.battle_stat.set_stat("sta",fker.actor.battle_stat.get_stat("sta")-6)
					user.actor.battle_stat.set_stat("arousal",user.actor.battle_stat.get_stat("arousal")+5)
				end
			end
			
			if fker.actor.battle_stat.get_stat("sex") >=1 && rand(100) > 95
				case fker.actor.race
					when "Human"       	;event_race ="WasteSemenHuman"
					when "Moot"        	;event_race ="WasteSemenHuman"
					when "Orkind"      	;event_race ="WasteSemenOrcish"
					when "Goblin"      	;event_race ="WasteSemenOrcish"
					when "Abomination" 	;event_race ="WasteSemenAbomination"
					when "Deepone"     	;event_race ="WasteSemenHuman"
					when "Fishkind"    	;event_race ="WasteSemenFishkind"
					when "Troll"       	;event_race ="WasteSemenTroll"
					else				;event_race ="WasteSemenHuman"
				end
				$game_map.reserve_summon_event(event_race,@x,@y)
			end
		}
		$game_map.reserve_summon_event("EffectSexServiceIngratiateHit",@x,@y,-1,{:target => user,:user => user})
		$game_map.reserve_summon_event("WasteSemen",@x,@y) if rand(100) > 90
	end
	def sex_std_spread(slot="vag",fucker=event) #sketch
		#chance chk
		#when success apply a stats,  when self == lona, apply a temp efect to tgt with -Con -DEF -Sur effect.
		case slot
			when "vag"
				self.add_state("STD_WartVag") if fucker.state_stack("STD_WartVag") >= 1
				self.add_state("STD_HerpesVag") if fucker.state_stack("STD_HerpesVag") >= 1
			when "anal"
				self.add_state("STD_WartAnal") if fucker.state_stack("STD_WartAnal") >= 1
				self.add_state("STD_HerpesAnal") if fucker.state_stack("STD_HerpesAnal") >= 1
		end
	end
end#class
