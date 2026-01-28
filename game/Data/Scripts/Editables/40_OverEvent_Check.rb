#common HCG frame page0
#todo  make them with def..... because this looks stupid

#這個模組被引用到Game_Interpreter中，主要負責超越事件的檢查
#主要由繪師操作
module GIM_OVC
	
		########################################## basic command ###########################################################################################
	def overEVloadRB(data="",parallel=false)
		if parallel
			$game_temp.loadRB(data)
		else
			load_script(data)
		end
	end
	
	def overEVcall_msg(data="",parallel=false)
		if parallel
			$game_temp.loadMSG(data)
		else
			call_msg(data)
		end
	end

	def check_oEV_with_parallel_mode?(parallel)
		!IsChcg? && ![:grabbed,:sex].include?($game_player.actor.action_state) && !$game_map.isOverMap && parallel
	end
	
	
		########################################## Arousal ###########################################################################################
	def checkOev_Arousal(parallel=false)
		tmpAruHalf = $game_player.actor.arousal >=0.6* $game_player.actor.will
		tmpAruOver = $game_player.actor.arousal >= $game_player.actor.will
		tmpCummed  = $game_player.actor.stat["Cummed"] ==1
		tmpAllowOg  = $game_player.actor.allow_ograsm?
		tmpWetDialog  = $story_stats["dialog_wet"]== 1
		if tmpAruOver && tmpCummed && tmpAllowOg
			if check_oEV_with_parallel_mode?(parallel)
				#$game_player.actor.arousal = 0
				tmpCHK = $game_map.events.any?{|event| 
					next if event[1].deleted?
					next unless event[1].summon_data
					event[1].summon_data[:OevEFXCumming]
				}
				EvLib.sum("OevEFX_ArousalOverCumming") if !tmpCHK
			else
				overEVloadRB("Data/HCGframes/OverEvent_overcuming.rb",parallel)
				eventPlayEnd
				$game_player.actor.add_state("OverCummed")
				$game_player.actor.add_state("Cummed")
				$game_player.actor.add_state("EffectWet") if $game_player.actor.stat["EffectWet"] ==0  #add wet
			end
		elsif tmpAruOver && tmpAllowOg
			if check_oEV_with_parallel_mode?(parallel)
				#$game_player.actor.arousal = 0
				tmpCHK = $game_map.events.any?{|event| 
					next if event[1].deleted?
					next unless event[1].summon_data
					event[1].summon_data[:OevEFXCumming]
				}
				EvLib.sum("OevEFX_ArousalCumming") if !tmpCHK
			else
				overEVloadRB("Data/HCGframes/OverEvent_cumming.rb",parallel)
				eventPlayEnd
				$game_player.actor.add_state("Cummed")
				$game_player.actor.add_state("EffectWet") if $game_player.actor.stat["EffectWet"] ==0
			end
		elsif tmpAruHalf && tmpWetDialog
			$story_stats["dialog_wet"]= 0
			if check_oEV_with_parallel_mode?(parallel)
				EvLib.sum("OevEFX_ArousalWet")
			else
				$game_player.actor.add_state("EffectWet") if $game_player.actor.stat["EffectWet"] ==0  #add wet
				overEVloadRB("Data/HCGframes/OverEvent_wet.rb",parallel)
				eventPlayEnd
			end
		elsif tmpAruHalf
			$game_player.actor.add_state("EffectWet") if $game_player.actor.stat["EffectWet"] ==0  #add wet
		end
	end
	

		########################################## PEE ###########################################################################################
	def checkOev_Pee(parallel=false)
		return if $story_stats["Setup_Hardcore"] <= 0 && $game_player.actor.stat["WeakBladder"] <= 0
		tmpRun = false
		if $game_player.actor.urinary_level >= $game_player.actor.will*3
			tmpRun= true
		elsif $game_player.actor.stat["UrethralDamaged"] ==0 && $game_player.actor.urinary_level >= $game_player.actor.will && IsChcg?
			tmpRun= true
		elsif $game_player.actor.stat["UrethralDamaged"] ==1 && $game_player.actor.urinary_level >= $game_player.actor.will
			tmpRun= true
		elsif $game_player.actor.stat["WeakBladder"] == 1 && $game_player.actor.urinary_level  >= $game_player.actor.will+300
			tmpRun= true
		end
		if tmpRun
			$game_player.actor.urinary_level =0
			if check_oEV_with_parallel_mode?(parallel)
				EvLib.sum("OevEFX_Pee")
			else
				overEVloadRB("Data/HCGframes/OverEvent_Pee.rb",parallel)
				eventPlayEnd
			end
		end
	end
	def checkOev_Poo(parallel=false)
		return if $story_stats["Setup_Hardcore"] <= 0
		#if $story_stats["dialog_defecated"] == 1
			if $game_player.actor.defecate_level >= $game_player.actor.will*3
				tmpRun= true
			elsif $game_player.actor.stat["SphincterDamaged"] ==0 && $game_player.actor.defecate_level >= $game_player.actor.will && IsChcg?
				tmpRun= true
			elsif $game_player.actor.stat["SphincterDamaged"] ==1 && $game_player.actor.defecate_level >= $game_player.actor.will
				tmpRun= true
			end
			if tmpRun
				$game_player.actor.defecate_level =0
				$story_stats["dialog_defecated"] =0
				if check_oEV_with_parallel_mode?(parallel)
					EvLib.sum("OevEFX_Poo")
				else
					overEVloadRB("Data/HCGframes/OverEvent_Poo.rb",parallel)
					eventPlayEnd
				end
			end
		#end
	end
	
	def checkOev_MilkOvercharge(parallel=false)
		return unless $game_player.actor.lactation_level >= 800 && $story_stats["dialog_lactation"] == 1
		$story_stats["dialog_lactation"] = 0
		if check_oEV_with_parallel_mode?(parallel)
			$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4shame" : "shy"
			$game_portraits.rprt.focus
			SndLib.sound_QuickDialog
			$game_map.popup(0,"commonH:Lona/Qmsg_Oev_Milk",0,0)
		else
			overEVcall_msg("common:Lona/MilkSpray_overcharge",parallel)
		end
	end
	def checkOev_Milk(parallel=false)
		return if $story_stats["Setup_Hardcore"] <= 0
		if $game_player.actor.lactation_level >= 1000
			if check_oEV_with_parallel_mode?(parallel)
				$story_stats["dialog_lactation"] = 0
				EvLib.sum("OevEFX_Milk")
			else
				overEVloadRB("Data/HCGframes/OverEvent_MilkSplash.rb",parallel)
				$story_stats["dialog_lactation"] = 0
				eventPlayEnd
			end
		end
	end
	def checkOev_Virgin(parallel=false)
		##############################################################################virgin and anal check
		if $story_stats["dialog_vag_virgin"]==1 && $story_stats["sex_record_vaginal_count"] != 0
		flash_screen(Color.new(255,0,0,80),8,false)
		overEVloadRB("Data/HCGframes/OverEvent_VirginTaken.rb",parallel)
		eventPlayEnd
		end
		if $story_stats["dialog_anal_virgin"] ==1 && $story_stats["sex_record_anal_count"] != 0
		flash_screen(Color.new(255,0,0,80),8,false)
		overEVloadRB("Data/HCGframes/OverEvent_AnalTaken.rb",parallel)
		eventPlayEnd
		end
	end
	
	
	
	def check_over_event(parallel=false)
		checkOev_Arousal(parallel)
		checkOev_Poo(parallel)
		checkOev_Pee(parallel)
		checkOev_Milk(parallel)
		checkOev_Virgin(parallel)
	end
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓half_over_event▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
	def checkOev_Vomit(parallel=false)
		tmpDoit = false
		tmpPuke = $game_player.actor.puke_value_normal
		tmpWill = $game_player.actor.will
		tmpDoit = true if tmpPuke >= tmpWill*1.6 && $story_stats["Setup_Hardcore"] <= 0
		tmpDoit = true if tmpPuke >= tmpWill && $story_stats["Setup_Hardcore"] >= 1
		return if !tmpDoit
		temp_StomachSpasm_chance = rand(100)
		$game_player.actor.add_state("StomachSpasm") if temp_StomachSpasm_chance >=60
		$game_player.actor.puke_value_normal = 0
		$game_player.actor.puke_value_preg = 0
		if tmpDoit
			if check_oEV_with_parallel_mode?(parallel)
				EvLib.sum("OevEFX_Vomit")
			else
				load_script("Data/HCGframes/OverEvent_Puke.rb")
			end
		end
	end
	
	def checkOev_Itch(parallel=false)
		return if !parallel #only parallel mode
		tmpDoit = false
		tmpPuke = $game_player.actor.itch_level
		tmpWill = $game_player.actor.will
		tmpDoit = true if tmpPuke >= tmpWill && $story_stats["Setup_Hardcore"] >= 1
		return if !tmpDoit
		if tmpDoit
			if check_oEV_with_parallel_mode?(parallel)
				$game_player.actor.itch_level = 0
				EvLib.sum("OevEFX_Itch")
			else
				load_script("Data/HCGframes/OverEvent_Itch.rb")
			end
		end
	end
	
	def checkOev_Preg(parallel=false)
		case $game_player.actor.preg_level
			when 1
				if $game_player.actor.puke_value_preg >= 225 && $game_date.daysSince($game_player.actor.preg_date) >= 1 + ($story_stats["Setup_Hardcore"]*2)
					$game_player.actor.puke_value_preg = 0
					tmpChkExped = $story_stats["sex_record_pregnancy"] >= 1 || $story_stats["sex_record_baby_birth"] >=1 || $story_stats["sex_record_miscarriage"] >=1 && $story_stats["dialog_preg_exped"] ==1
					if tmpChkExped
						$story_stats["dialog_preg_exped"] = 0
						$game_player.actor.stat["displayBabyHealth"] = 1
					end
					if check_oEV_with_parallel_mode?(parallel)
						if tmpChkExped
							EvLib.sum("OevEFX_PregLv1Vomit",1,1,{:PregModeExped=>true})
						else
							EvLib.sum("OevEFX_Vomit",1,1,)
						end
					else
						overEVloadRB("Data/HCGframes/OverEvent_Puke.rb",parallel)
						if tmpChkExped
							overEVcall_msg("common:Lona/preglv1_puke_exped",parallel)
						end
						eventPlayEnd
					end
				end
				
			when 2
				if $game_player.actor.stat["PregState"] ==0
					$game_player.actor.gain_exp(rand(100)*$game_player.actor.level)
					$game_player.actor.add_state("PregState") #29
					$game_player.actor.belly_size_control
					tmpChkExped = $story_stats["sex_record_pregnancy"] >= 1 || $story_stats["sex_record_baby_birth"] >=1 || $story_stats["sex_record_miscarriage"] >=1
					if check_oEV_with_parallel_mode?(parallel)
						if tmpChkExped
							EvLib.sum("OevEFX_PregLv2Begin",1,1,{:PregModeExped=>true})
						else
							EvLib.sum("OevEFX_PregLv2Begin",1,1)
						end
						
					else
						overEVcall_msg("common:Lona/preg_lv2",parallel)
						if tmpChkExped
							overEVcall_msg("common:Lona/preg_lv2_exped",parallel)
						end
						eventPlayEnd
					end
					$game_player.actor.stat["displayBabyHealth"] = 1
					$story_stats["sex_record_pregnancy"] +=1
					##############################################preg lv2 event
				elsif $game_player.actor.puke_value_preg >= 300
					$game_player.actor.puke_value_preg = 0
					if check_oEV_with_parallel_mode?(parallel)
						EvLib.sum("OevEFX_PregLv2Vomit",1,1)
					else
						overEVcall_msg("common:Lona/preglv2_puke",parallel)
						overEVloadRB("Data/HCGframes/OverEvent_Puke.rb",parallel)
						eventPlayEnd
					end
				end
				
			when 3
				if $game_player.actor.stat["PregState"] ==1
					$game_player.actor.gain_exp(rand(200)*$game_player.actor.level)
					$game_player.actor.add_state("PregState") #29
					$game_player.actor.belly_size_control
					$game_player.actor.stat["displayBabyHealth"] = 1
					if check_oEV_with_parallel_mode?(parallel)
						EvLib.sum("OevEFX_PregLv3Begin",1,1)
					else
						overEVcall_msg("common:Lona/preglv3",parallel)
						eventPlayEnd
					end
				#########################################preg lv3 event
				elsif $game_player.actor.pain_value_preg >= 187
					$game_player.actor.pain_value_preg = 0
					if $game_player.actor.baby_race == "Others" && [true,false].sample
						overEVloadRB("Data/Batch/birth_trigger.rb",parallel)
						eventPlayEnd
					else
						if check_oEV_with_parallel_mode?(parallel)
							EvLib.sum("OevEFX_PregLv3Pain",1,1)
						else
							overEVcall_msg("common:Lona/preglv3_pain",parallel)
							eventPlayEnd
						end
					end
				end
			
			when 4
				if $game_player.actor.stat["PregState"] == 2
					$game_player.actor.gain_exp(rand(300)*$game_player.actor.level)
					$game_player.actor.add_state("PregState") #29
					$game_player.actor.add_state("Lactation") #36
					$game_player.actor.belly_size_control
					$game_player.actor.stat["displayBabyHealth"] = 1
					if check_oEV_with_parallel_mode?(parallel)
						if $game_player.actor.mood <=0
							EvLib.sum("OevEFX_PregLv4Begin",1,1,{:PregModeWeak=>true})
						else
							EvLib.sum("OevEFX_PregLv4Begin",1,1)
						end
					else
						overEVcall_msg("common:Lona/preglv4",parallel)
						if $game_player.actor.mood <=0
							overEVcall_msg("common:Lona/preglv4_weak",parallel)
						end
						eventPlayEnd
					end
				#########################################preg lv4 event
				elsif $game_player.actor.pain_value_preg >= 105
					$game_player.actor.pain_value_preg = 0
					if $game_player.actor.baby_race == "Others" && [true,false].sample
						overEVloadRB("Data/Batch/birth_trigger.rb",parallel)
						eventPlayEnd
					else
						if check_oEV_with_parallel_mode?(parallel)
							EvLib.sum("OevEFX_PregLv4Pain",1,1)
						else
							overEVcall_msg("common:Lona/preglv4_pain",parallel)
							eventPlayEnd
						end
					end
				end
				
			when 5
			if $game_map.isOverMap
				flash_screen(Color.new(255,0,0,200),8,false)
				SndLib.sound_Heartbeat
				$game_player.actor.stat["displayBabyHealth"] = 1
				#overmap_gen_WildDangerous
				change_map_enter_region
			elsif $story_stats["dialog_ready_to_birth"] ==1 && $game_player.actor.puke_value_preg >= 4
				$game_player.actor.sta -=1
				$game_player.actor.pain_value_preg = 0
				$game_player.actor.puke_value_preg = 0
				$story_stats["dialog_ready_to_birth"] =0
				$game_player.actor.add_state("EffectWet") if $game_player.actor.stat["EffectWet"] ==0 #add wet
				flash_screen(Color.new(255,0,0,200),8,true)
				SndLib.sound_Heartbeat
				overEVcall_msg("common:Lona/preglv5_ready_to_birth",parallel) #羊水破了 找個安全的地方出產吧
				EvLib.sum("OevEFX_Birth",1,1,{:target=>$game_player})
			elsif $game_player.actor.puke_value_preg >= 4 && $story_stats["dialog_ready_to_birth"] ==0 && $game_player.actor.pain_value_preg < 30
				$game_player.actor.sta -=1
				$game_player.actor.puke_value_preg =0
				$game_player.actor.add_state("EffectWet") if $game_player.actor.stat["EffectWet"] ==0 #add wet
				flash_screen(Color.new(255,0,0,200),8,true)
				SndLib.sound_Heartbeat
				if check_oEV_with_parallel_mode?(parallel)
					$game_map.popup(0,"commonH:Lona/Qmsg_beaten#{rand(10)}",0,0)
					$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4health_damage" : "p5health_damage"
					$game_player.actor.portrait.shake
					$game_map.reserve_summon_event("WastePee")
					$game_map.reserve_summon_event("WasteBlood")
					load_script("Data/Batch/common_stats_damage_sta.rb")
					$game_player.actor.add_state("Slow6") #slow6
					$game_player.actor.force_stun("Stun2") if !$game_player.action_state_parallel_block? && $game_player.actor.action_state != :stun
				else
					overEVcall_msg("common:Lona/preglv5_ready_birth_shake#{rand(3)}",parallel) #約每三步子宮收縮陣痛
				end
			elsif $game_player.actor.pain_value_preg >=30 && $story_stats["dialog_ready_to_birth"] ==0
				$game_player.actor.pain_value_preg = 0
				overEVloadRB("Data/Batch/birth_trigger.rb",parallel)
				eventPlayEnd
			end
		end
	end


	def checkOev_Miscarriage(parallel=false)
		return if !$game_player.actor.miscarriage? # check repodocution.rb
		flash_screen(Color.new(255,0,0,200),8,false)
		SndLib.sound_Heartbeat
		overEVcall_msg("common:Lona/preg_miscarriage_start",parallel) #rand pain dialog
		flash_screen(Color.new(255,0,0,200),8,false)
		SndLib.sound_Heartbeat
		overEVcall_msg("common:Lona/preg_miscarriage_begin#{rand(4)}",parallel) #rand pain dialog
		flash_screen(Color.new(255,0,0,200),8,false)
		SndLib.sound_Heartbeat
		overEVcall_msg("common:Lona/preg_miscarriage_begin#{rand(4)}",parallel) #rand pain dialog
		overEVloadRB("Data/HCGframes/BirthEvent_Miscarriage.rb",parallel)
		$game_player.actor.belly_size_control
		eventPlayEnd
	end

	
	def checkOev_Parasited(parallel=false)
		if ($game_player.actor.stat["ParasitedPotWorm"] >=1 || $game_player.actor.stat["ParasitedMoonWorm"] >=1) && $story_stats["dialog_parasited"] ==1
			$story_stats["dialog_parasited"] =0
			$game_player.actor.belly_size_control
			overEVcall_msg("common:Lona/Parasite_Wakeup",parallel)
		end
	end
	
	def checkOev_CumsSwallow(parallel=false)
		chcg_clearn_mouth_semen_trans_items if $game_player.actor.stat["SemenGulper"] >= 1 && $game_player.actor.cumsMeters["CumsMouth"] >= 300
	end
	
	def checkOev_OgrasmAddiction(parallel=false)
		tmpLona = $game_player.actor
		stat1 = tmpLona.stat["OgrasmAddiction"] != 5
		stat2 = tmpLona.stat["FeelsHorniness"]+tmpLona.stat["WombSeedBed"] >= 4
		if	tmpLona.ograsm_addiction_damage >= tmpLona.will && stat1 && stat2
			tmpLona.ograsm_addiction_damage =0
			tmpLona.add_state("OgrasmAddiction") #高潮中毒
			overEVcall_msg("common:Lona/Ograsm_addiction_add_a_level",parallel)
		elsif tmpLona.ograsm_addiction_level >= 0.7*tmpLona.will && $story_stats["dialog_ograsm_addiction"] ==1
			$story_stats["dialog_ograsm_addiction"] =0
			overEVcall_msg("common:Lona/Ograsm_addiction_almost",parallel)
		elsif tmpLona.ograsm_addiction_level >= tmpLona.will && !$game_map.isOverMap
			tmpLona.mood = -100
			$game_player.move_normal
			$game_player.animation = $game_player.animation_grabbed_qte if tmpLona.action_state == nil || tmpLona.action_state == :none
				if tmpLona.stat["OgrasmAddiction"].between?(1,2)
					tmpLona.ograsm_addiction_level =0
					tmpLona.add_state("FeelsHorniness") #feels hot
					overEVcall_msg("common:Lona/Ograsm_addiction_overLv1",parallel)
				elsif tmpLona.stat["OgrasmAddiction"].between?(3,4)
					tmpLona.ograsm_addiction_level =0
					tmpLona.add_state("FeelsHorniness") #feels hot
					tmpLona.add_state("FeelsHorniness") #feels hot
					overEVcall_msg("common:Lona/Ograsm_addiction_overLv2",parallel)
				elsif tmpLona.stat["OgrasmAddiction"] ==5
					tmpLona.ograsm_addiction_level =0
					tmpLona.add_state("FeelsHorniness") #feels hot
					tmpLona.add_state("FeelsHorniness") #feels hot
					tmpLona.add_state("FeelsHorniness") #feels hot
					overEVcall_msg("common:Lona/Ograsm_addiction_overLv3",parallel)
				end
			$game_player.animation = nil if tmpLona.action_state == nil || tmpLona.action_state == :none
			EvLib.sum("EffectLewdCrazy",1,1)
		end
	end
	def checkOev_SemenAddiction(parallel=false)
		tmpLona = $game_player.actor
		stat1 = tmpLona.stat["SemenGulper"] == 0 && (tmpLona.stat["AsVulva_Esophageal"] >= 1 || tmpLona.stat["WombSeedBed"] >= 3)
		if	tmpLona.semen_addiction_damage >= tmpLona.will && tmpLona.stat["SemenAddiction"] !=5 && stat1
			tmpLona.semen_addiction_damage =0
			tmpLona.add_state("SemenAddiction") #精液中毒
			overEVcall_msg("common:Lona/Semen_addiction_add_a_level",parallel)
		elsif tmpLona.semen_addiction_level >= 0.7*tmpLona.will && $story_stats["dialog_semen_addiction"] ==1
			$story_stats["dialog_semen_addiction"] =0
			overEVcall_msg("common:Lona/Semen_addiction_almost",parallel)
		elsif tmpLona.semen_addiction_level >= tmpLona.will && !$game_map.isOverMap
			tmpLona.mood = -100
			$game_player.move_normal
			$game_player.animation = $game_player.animation_grabbed_qte if tmpLona.action_state == nil || tmpLona.action_state == :none
				if tmpLona.stat["SemenAddiction"].between?(1,2)
					tmpLona.semen_addiction_level =0
					tmpLona.add_state("StomachSpasm") #add StomachSpasm
					overEVcall_msg("common:Lona/Semen_addiction_overLv1",parallel)
				elsif tmpLona.stat["SemenAddiction"].between?(3,4)
					tmpLona.semen_addiction_level =0
					tmpLona.add_state("StomachSpasm") #add StomachSpasm
					overEVcall_msg("common:Lona/Semen_addiction_overLv2",parallel)
				elsif tmpLona.stat["SemenAddiction"] ==5
					tmpLona.semen_addiction_level =0
					tmpLona.add_state("StomachSpasm") #add sStomachSpasm
					overEVcall_msg("common:Lona/Semen_addiction_overLv3",parallel)
				end
			$game_player.animation = nil if tmpLona.action_state == nil || tmpLona.action_state == :none
			EvLib.sum("EffectMadness",1,1)
		end
	end

	def checkOev_DrugAddiction(parallel=false)
		tmpLona = $game_player.actor
		if	tmpLona.drug_addiction_damage >= tmpLona.will &&  tmpLona.stat["DrugAddiction"] !=5
			tmpLona.drug_addiction_damage =0
			tmpLona.add_state("DrugAddiction") #藥物成癮
			overEVcall_msg("common:Lona/Drug_addiction_add_a_level",parallel)
		elsif tmpLona.drug_addiction_level >= 0.7*tmpLona.will && $story_stats["dialog_drug_addiction"] ==1
			$story_stats["dialog_drug_addiction"] =0
			overEVcall_msg("common:Lona/Drug_addiction_almost",parallel)
		elsif tmpLona.drug_addiction_level >= tmpLona.will && !$game_map.isOverMap
			tmpLona.mood = -100
			$game_player.move_normal
			$game_player.animation = $game_player.animation_grabbed_qte if tmpLona.action_state == nil || tmpLona.action_state == :none
				if tmpLona.stat["DrugAddiction"].between?(1,2)
				tmpLona.drug_addiction_level =0
				tmpLona.add_state("FeelsSick") #add sick
				overEVcall_msg("common:Lona/Drug_addiction_overLv1",parallel)
				elsif tmpLona.stat["DrugAddiction"].between?(3,4)
				tmpLona.drug_addiction_level =0
				tmpLona.add_state("FeelsSick") #add sick
				overEVcall_msg("common:Lona/Drug_addiction_overLv2",parallel)
				elsif tmpLona.stat["DrugAddiction"] ==5
				tmpLona.drug_addiction_level =0
				tmpLona.add_state("FeelsSick") #add sick
				overEVcall_msg("common:Lona/Drug_addiction_overLv3",parallel)
				end
			$game_player.animation = nil if tmpLona.action_state == nil || tmpLona.action_state == :none
			EvLib.sum("EffectMadness",1,1)
		end
	end
	
	def checkOev_FeelsSick(parallel=false)
		if $game_player.actor.stat["FeelsSick"] ==1 && $story_stats["dialog_sick"] ==1
			$story_stats["dialog_sick"] =0
			overEVcall_msg("common:Lona/sick",parallel)
			
			eventPlayEnd
		end
	end
	
	def checkOev_OutDress(parallel=false)
		if $game_player.player_nude? && $story_stats["dialog_dress_out"] ==1
			$story_stats["dialog_dress_out"] = 0
			
			if check_oEV_with_parallel_mode?(parallel) || $LonaINI["GameOptions"]["oev_OutDress_always_parallel"] == 1
				if $game_player.actor.stat["Exhibitionism"] ==1
					$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4shame" : "lewd"
					$game_map.popup(0,"common:Lona/Qmsg_dress_out_ext#{talk_style}",0,0)
				else
					$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4shame" : "shy"
					$game_map.popup(0,"common:Lona/Qmsg_dress_out#{talk_style}",0,0)
				end
				$game_portraits.rprt.focus
				SndLib.sound_QuickDialog
			else
				if $game_player.actor.stat["Exhibitionism"] ==1
					overEVcall_msg("common:Lona/dress_out_ext#{talk_style}#{rand(2)}",parallel)
				else
					overEVcall_msg("common:Lona/dress_out#{talk_style}#{rand(3)}",parallel)
				end
				eventPlayEnd
			end
		end
	end
	
	def checkOev_SlotDMG(parallel=false)
		if $game_player.actor.stat["VaginalDamaged"] == 0 && $game_player.actor.vag_damage >= 9999
			$game_player.actor.add_state("VaginalDamaged") #41
			overEVcall_msg("common:Lona/vag_damaged",parallel)
			eventPlayEnd
		end
		
		if $game_player.actor.stat["UrethralDamaged"] == 0 && $game_player.actor.urinary_damage >= 9999
			$game_player.actor.add_state("UrethralDamaged") #42
			overEVcall_msg("common:Lona/urinary_damaged",parallel)
			eventPlayEnd
		end
		
		if $game_player.actor.stat["SphincterDamaged"] == 0 && $game_player.actor.anal_damage >= 9999
			$game_player.actor.add_state("SphincterDamaged") #43
			overEVcall_msg("common:Lona/anal_damaged",parallel)
			eventPlayEnd
		end
	end
	def checkOev_PooPoo(parallel=false)
		return if $story_stats["dialog_defecate"] == 0
		#auto scat effect
		if $game_player.actor.stat["SphincterDamaged"] ==1 && $game_player.actor.stat["EffectScat"] ==0 #add bot scat if anal dmg
			$game_player.actor.add_state("EffectScat") #39
			$story_stats["dialog_defecate"] = 0
			if check_oEV_with_parallel_mode?(parallel)
				SndLib.sound_Heartbeat(70,110)
				SndLib.sound_chs_dopyu(80,50+rand(15))
				$game_map.interpreter.flash_screen(Color.new(173,96,20,20),4,false)
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4crit_damage" : "bereft"
				$game_player.actor.portrait.shake
				$game_map.popup(0,"common:Lona/Qmsg_auto_poo",0,0)
			else
				overEVcall_msg("common:Lona/auto_poo",parallel)
				eventPlayEnd
			end
		elsif $game_player.actor.defecate_level >= $game_player.actor.will && $game_player.actor.stat["SphincterDamaged"] == 0
			#Poopoo Warning
			if check_oEV_with_parallel_mode?(parallel)
				$story_stats["dialog_defecate"] = 0
				SndLib.sound_Heartbeat(70,110)
				SndLib.sound_chs_dopyu(80,70+rand(15))
				$game_map.interpreter.flash_screen(Color.new(173,96,20,20),4,false)
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4sta_damage" : "pain"
				$game_player.actor.portrait.shake
				$game_player.actor.defecate_level += 10
				$game_map.popup(0,"common:Lona/Qmsg_scat_dialog",0,0)
			else
				$story_stats["dialog_defecate"] = 0
				overEVcall_msg("common:Lona/scat_dialog",parallel)
			end
		end
	end
	
	def checkOev_PeePee(parallel=false)
		#auto wet effect
		return if $story_stats["dialog_urinary"] == 0
		if $game_player.actor.stat["UrethralDamaged"] ==1 && $game_player.actor.stat["EffectWet"] == 0 #Udmg and wet
			$game_player.actor.add_state("EffectWet") #28
			$story_stats["dialog_urinary"] = 0
			if check_oEV_with_parallel_mode?(parallel)
				SndLib.sound_Heartbeat(70,110)
				$game_map.interpreter.flash_screen(Color.new(255,255,0,20),4,false)
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4sta_damage" : "pain"
				$game_player.actor.portrait.shake
				$game_map.popup(0,"common:Lona/Qmsg_auto_pee",0,0)
			else
				overEVcall_msg("common:Lona/auto_pee",parallel)
				eventPlayEnd
			end
		elsif $game_player.actor.urinary_level >= $game_player.actor.will && $game_player.actor.stat["UrethralDamaged"] == 0
		#Peepee Warning
			$story_stats["dialog_urinary"] = 0
			if check_oEV_with_parallel_mode?(parallel)
				SndLib.sound_Heartbeat(70,110)
				$game_map.interpreter.flash_screen(Color.new(255,255,0,20),4,false)
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4shame" : "shy"
				$game_portraits.rprt.focus
				$game_map.popup(0,"common:Lona/Qmsg_pee_dialog",0,0)
			else
				overEVcall_msg("common:Lona/pee_dialog",parallel)
			end
		end
	end
	
	def checkOev_SemenBursting(parallel=false)
		temp_heavy_cums = $game_player.actor.cumsMeters["CumsCreamPie"] + $game_player.actor.cumsMeters["CumsMoonPie"]
		if temp_heavy_cums >= 1000 && $story_stats["dialog_cumflation"] ==1 #18=vag cums 19=analcums
			$story_stats["dialog_cumflation"] =0
			$story_stats["dialog_cumflation_heal"] =1
			$game_player.actor.add_state("SemenBursting") #26
			$game_player.actor.belly_size_control
			
			if check_oEV_with_parallel_mode?(parallel)
				SndLib.sound_Heartbeat(70,110)
				$game_map.interpreter.flash_screen(Color.new(255,255,0,20),4,false)
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4shame" : "shy"
				$game_portraits.rprt.focus
				$game_map.popup(0,"common:Lona/Qmsg_SemenBursting#{rand(3)}",0,0)
			else
				overEVcall_msg("common:Lona/heavy_begin",parallel)
				overEVcall_msg("common:Lona/SemenBursting#{rand(3)}",parallel)
				eventPlayEnd
			end
		elsif $story_stats["dialog_cumflation_heal"] ==1 && $game_player.actor.stat["SemenBursting"] ==1 && temp_heavy_cums <=500
			$story_stats["dialog_cumflation"] =1
			$story_stats["dialog_cumflation_heal"] =0
			$game_player.actor.remove_state_stack("SemenBursting")
			$game_player.actor.belly_size_control
			
			if check_oEV_with_parallel_mode?(parallel)
				SndLib.sound_Heartbeat(70,110)
				$game_map.interpreter.flash_screen(Color.new(255,255,0,20),4,false)
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4sta_damage" : "pain"
				$game_portraits.rprt.focus
				$game_map.popup(0,"common:Lona/Qmsg_SemenBursting_regen#{rand(3)}",0,0)
			else
				overEVcall_msg("common:Lona/SemenBursting_regen_begin",parallel)
				overEVcall_msg("common:Lona/SemenBursting_regen#{rand(3)}",parallel)
				eventPlayEnd
			end
			
		end
	end
	#def checkOev_Hunger(parallel=false) #moved to check_wakeup_event_SAT
	#	if $story_stats["dialog_sat"] == 1
	#		$story_stats["dialog_sat"]=0
	#		if ($game_player.actor.sat <=25) && rand(100) >= 90
	#			overEVcall_msg("common:Lona/hunger3",parallel)
	#		elsif  $game_player.actor.sat <=50 && rand(100) >= 70
	#			overEVcall_msg("common:Lona/hunger2",parallel)
	#		elsif  $game_player.actor.sat <=75 && rand(100) >= 50
	#			overEVcall_msg("common:Lona/hunger1",parallel)
	#		elsif  $game_player.actor.sat <=100 && rand(100) >= 30
	#			overEVcall_msg("common:Lona/hunger0",parallel)
	#		end
	#		
	#		eventPlayEnd
	#	end
	#end
	def checkOev_OverWeight(parallel=false)
		if $game_player.actor.weight_immobilized? && $story_stats["dialog_overweight"] ==1
			$story_stats["dialog_overweight"] = 0
			overEVcall_msg("common:Lona/overweight",parallel)
			eventPlayEnd
		end
	end
	
	def checkOev_CuffCollar(parallel=false)
		actor = $game_player.actor
		#actor.equips[0].nil? ? equips_0_id = -1 : equips_0_id = actor.equips[0].id
		#actor.equips[5].nil? ? equips_5_id = -1 : equips_5_id = actor.equips[5].id
		withCUFF = ["CuffTopExtra","ChainCuffTopExtra"].include?(actor.stat["MainArm"])
		withCOLLAR = ["CollarTopExtra","ChainCollarTopExtra"].include?(actor.stat["equip_TopExtra"])
		#play dialog when equiped
		if $story_stats["dialog_cuff_equiped"] ==1 && withCUFF
			$story_stats["dialog_cuff_equiped"] =0
			overEVcall_msg("common:Lona/cuff_on#{talk_style}",parallel)
			eventPlayEnd
		elsif !withCUFF
			$story_stats["dialog_cuff_equiped"] =1 if $story_stats["dialog_cuff_equiped"] !=1
		end
		if $story_stats["dialog_collar_equiped"] ==1 && withCOLLAR
			$story_stats["dialog_collar_equiped"] =0
			overEVcall_msg("common:Lona/collar_on#{talk_style}",parallel)
			eventPlayEnd
		elsif !withCOLLAR
			$story_stats["dialog_collar_equiped"] =1 if $story_stats["dialog_collar_equiped"] !=1
		end
		
		
		#daily dialog check
		if $story_stats["dialog_cuff"] == 1
			case actor.stat["MainArm"]
				when "CuffTopExtra"
					$story_stats["dialog_cuff"] =0
					$story_stats["dialog_collar"] =0
						if actor.stat["WoundCuff"] ==0 #cuff
						overEVcall_msg("common:Lona/cuff_wound",parallel)
						
						overEVcall_msg("common:Lona/collar_wound",parallel)
						
						end
				when "ChainCuffTopExtra"
					$story_stats["dialog_cuff"] =0
					$story_stats["dialog_collar"] =0
						if actor.stat["WoundCuff"] ==0 #cuff
						overEVcall_msg("common:Lona/cuff_wound",parallel)
						
						overEVcall_msg("common:Lona/collar_wound",parallel)
						
						end
			end
		end
		if $story_stats["dialog_collar"] == 1
			case actor.stat["equip_TopExtra"]
				when "CollarTopExtra"
					$story_stats["dialog_collar"] =0
					overEVcall_msg("common:Lona/collar_wound",parallel) if actor.stat["WoundCollar"] ==0 #collar
				when "ChainCollarTopExtra"
					$story_stats["dialog_collar"] =0
					overEVcall_msg("common:Lona/collar_wound",parallel) if actor.stat["WoundCollar"] ==0 #collar
			end
			if actor.stat["equip_MidExtra"] == "ChainMidExtra"
				$story_stats["dialog_collar"] =0
				overEVcall_msg("common:Lona/collar_wound",parallel) if actor.stat["WoundCollar"] ==0 #collar
			end
		end
	end
	def check_half_over_event(parallel=false)
		checkOev_Vomit(parallel)
		checkOev_Itch(parallel)
		checkOev_Preg(parallel)
		checkOev_Miscarriage(parallel)
		checkOev_Parasited(parallel)
		checkOev_CumsSwallow(parallel)
		if $story_stats["Setup_Hardcore"] >= 1
			checkOev_MilkOvercharge(parallel)
			checkOev_OgrasmAddiction(parallel)
			checkOev_SemenAddiction(parallel)
			checkOev_DrugAddiction(parallel)
		end
		checkOev_FeelsSick(parallel)
		checkOev_OutDress(parallel)
		checkOev_SlotDMG(parallel)
		checkOev_PooPoo(parallel) if $story_stats["Setup_ScatEffect"] == 1
		checkOev_PeePee(parallel) if $story_stats["Setup_UrineEffect"] == 1
		checkOev_SemenBursting(parallel)
		#checkOev_Hunger(parallel) #moved to wake up ev
		checkOev_OverWeight(parallel)
		checkOev_CuffCollar(parallel)
	end #check_half_over_event
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓Wake up event  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
	def check_wakeup_event_LostBaby(parallel=false)
		p "check_wakeup_event_LostBaby"
		tmpReport = false
		#######################lost her baby_birth ###################################3
		if $story_stats["dialog_baby_lost"] ==1 && $story_stats["sex_record_birth_BabyLost"] < 3
			$story_stats["dialog_baby_lost"] =0
			overEVcall_msg("common:Lona/lost_baby",parallel)
			tmpReport = true
		elsif $story_stats["dialog_baby_lost"] ==1 && $story_stats["sex_record_birth_BabyLost"] >= 3
			overEVcall_msg("common:Lona/lost_baby_again",parallel)
			$story_stats["dialog_baby_lost"] =0
			tmpReport = true
		end
		tmpReport
	end
	def check_wakeup_event_Menses(parallel=false)
		p "check_wakeup_event_Menses"
		#############################################  Menses event  #####################3
		tmpReport = false
		if $game_player.actor.preg_level ==0
			if $game_player.actor.nth_day_in_period(2) ==0 && $game_player.actor.menses_status ==2 #menses
				p "trigger wakeup event MENSES STAGE1"
				$cg = TempCG.new(["event_menses"])
				overEVcall_msg("common:Lona/menses",parallel)
				$game_player.actor.add_state("FeelsSick") #feels sick
				$game_player.actor.add_state("EffectBleedVag") #bleed vag
				$cg.erase
				tmpReport = true
		end
			if $game_player.actor.nth_day_in_period(2) >=1 && $game_player.actor.menses_status ==2 
				p "trigger wakeup event MENSES STAGE2"
				$cg = TempCG.new(["event_menses"])
				overEVcall_msg("common:Lona/menses_bad",parallel)
				$game_player.actor.add_state("FeelsSick") #feels sick
				$game_player.actor.add_state("EffectBleedVag") #bleed vag
				$cg.erase
				tmpReport = true
			end
			if $game_player.actor.get_preg_rate_on_date($game_player.actor.currentDay) >= 0.7  #ovul   BLAH when preg rate >=0.8
				p "trigger wakeup event MENSES STAGE3"
				overEVcall_msg("common:Lona/menses_ovulate",parallel)
				$game_player.actor.add_state("FeelsWarm") #feels warm
				tmpReport = true
			end
		end
		tmpReport
	end
	def check_wakeup_event_MilkingChild(parallel=false)
		p "check_wakeup_event_MilkingChild"
		###################################################################### Milking CHild ######################################################################3
		tmpReport = false
		if player_carry_babies? && $story_stats["dialog_babie_feeding"] ==1
			$story_stats["dialog_babie_feeding"] =0
			babies = $game_party.get_item_type_to_array("Baby")
			babies = babies.shuffle
			tarRace = "Human"

			##############3 #if item with milk   use item?
			milkID = []
			$data_ItemName.each{|key,item|
				next unless item.pot_data
				next unless item.pot_data["Milk"]
				milkID << key
			}
			hasMilkID = []
			milkID.each{|key|
				hasMilkID << key if $game_party.has_item?(key)
			}
			if !hasMilkID.empty?
				item_name = $game_text[$data_ItemName[hasMilkID[0]].name]
				$story_stats["HiddenOPT0"] = item_name
				call_msg("commonH:Lona/FeedingChild_item1",0,2,0)
				call_msg("common:Lona/Decide_optB")
				$story_stats["HiddenOPT0"] = 0
				if $game_temp.choice == 1
					$game_party.lose_item(hasMilkID[0],1)
					SndLib.sys_UseItem
					call_msg("commonH:Lona/FeedingChild_item2")
					return
				end
			end
			##################
			until babies.empty? || $game_player.actor.lactation_level < 150
				currentFeeding=babies.shift
				currentFeeding.common_tags["baby_MouthRace"] ? tarRace = currentFeeding.common_tags["baby_MouthRace"] :  tarRace = "Human"
				$game_player.actor.stat["EventMouthRace"] = tarRace
				overEVloadRB("Data/HCGframes/OverEvent_MilkFeeding.rb",parallel)
			end
			check_over_event
			#p babies
			temp_play_lost_child_dialog = 1
			temp_play_humchild_dialog = false
			until babies.empty?
				currentFeeding=babies.shift
				p "currentFeeding = #{currentFeeding.item_name}"
				if !currentFeeding.common_tags["baby_LonaHumChild"] && !currentFeeding.common_tags["baby_HumChild"]
					$game_party.lose_item(currentFeeding,1)
					overEVcall_msg("commonH:Lona/FeedingChild_MilkNotEnough",parallel) if temp_play_lost_child_dialog ==1 
					temp_play_lost_child_dialog = 0
				else
					temp_play_humchild_dialog = true
				end
			end
			if temp_play_humchild_dialog == true
				overEVcall_msg("common:Lona/Milk_feed_notEnough",parallel)
				overEVcall_msg("common:Lona/preg_miscarriage_end1",parallel)
			end
			tmpReport = true
		end
		tmpReport
	end
	
	def check_wakeup_event_PeePoo(parallel=false)
		p "check_wakeup_event_PeePoo"
		####################################################尿床 睡眠脫糞
		tmpReport = false
		if $story_stats["Setup_ScatEffect"] ==1
			if $game_player.actor.stat["SphincterDamaged"] ==1 && $game_player.actor.defecate_level >=400
			#if ($game_player.actor.stat["SphincterDamaged"] ==1 && $game_player.actor.defecate_level >=400) || ($game_player.actor.defecate_level >= $game_player.actor.will+rand(500))
				$game_player.actor.add_state("EffectScat") #add scat
				portrait_hide
				overEVcall_msg("common:Lona/auto_poo_nap",parallel)
				tmpReport = true
			end
		end
		if $story_stats["Setup_UrineEffect"] ==1
			#if $game_player.actor.stat["UrethralDamaged"] ==1 && $game_player.actor.urinary_level >=400
			if ($game_player.actor.stat["UrethralDamaged"] ==1 && $game_player.actor.urinary_level >=400) || ($game_player.actor.stat["WeakBladder"] ==1 && $game_player.actor.urinary_level >= $game_player.actor.will+rand(500))
				$game_player.actor.add_state("EffectWet") #add wet
				portrait_hide
				overEVcall_msg("common:Lona/auto_pee_nap",parallel)
				tmpReport = true
			end
		end
		tmpReport
	end
	def check_wakeup_event_SAT(parallel=false)
		p "check_wakeup_event_SAT"
		############################################################ˇCHECK SAT
		tmpReport = false
		if $story_stats["dialog_sat"] == 1
			$story_stats["dialog_sat"]=0
			if ($game_player.actor.sat <=25)
				overEVcall_msg("common:Lona/hunger3",parallel)
				elsif  $game_player.actor.sat <=50
				overEVcall_msg("common:Lona/hunger2",parallel)
				elsif  $game_player.actor.sat <=75
				overEVcall_msg("common:Lona/hunger1",parallel)
				elsif  $game_player.actor.sat <=100
				overEVcall_msg("common:Lona/hunger0",parallel)
			end
			tmpReport = true
		end
		tmpReport
	end
	
	def check_wakeup_event_PTSD(parallel=false)
		p "check_wakeup_event_PTSD"
		tmpReport = false
		return tmpReport if $DEMO
		return tmpReport if ![true,false].sample
		#$story_stats["DreamPTSD"] = 0 if $game_player.actor.mood >= 100 && rand(100) >= 80
		if $game_player.actor.mood < 0 && $story_stats["Captured"] !=1 && $story_stats["DreamPTSD"] != 0
			tmpPTSDPicked = [$story_stats["DreamPTSD"],"other"].sample
			portrait_hide
			overEVcall_msg("common:Lona/PTSD_begin0",parallel)
			overEVcall_msg("common:Lona/PTSD_begin1",parallel)
			overEVcall_msg("common:Lona/PTSD_begin2",parallel)
			case tmpPTSDPicked
				when "Slave"
					overEVcall_msg("common:Lona/PTSD_Slave",parallel)
				when "Bandit"
					overEVcall_msg("common:Lona/PTSD_Bandit",parallel)
				when "Abomination"
					overEVcall_msg("common:Lona/PTSD_Abomination",parallel)
				when "Fishkind"
					overEVcall_msg("common:Lona/PTSD_Fishkind",parallel)
				when "Orkind"
					overEVcall_msg("common:Lona/PTSD_Orkind",parallel)
				when "CecilyBetray"
					overEVcall_msg("common:Lona/PTSD_CecilyBetray",parallel)
				else
					overEVcall_msg("common:Lona/PTSD_Common_#{rand(4)}",parallel)
					overEVcall_msg("common:Lona/PTSD_Common_#{rand(4)}",parallel)
			end
			overEVcall_msg("common:Lona/PTSD_begin4",parallel)
			overEVcall_msg("common:Lona/PTSD_begin5_#{rand(2)}",parallel)
			$game_player.actor.mood = -100
			portrait_hide
			tmpReport = true
		end
		tmpReport
		
	end
	def check_wakeup_event(parallel=false)
		p "check_wakeup_event"
		$game_player.balloon_id = -1 if !$game_map.isOverMap && ($game_player.actor.action_state == nil || $game_player.actor.action_state == :none)
		$game_player.animation = nil if !$game_map.isOverMap && ($game_player.actor.action_state == nil || $game_player.actor.action_state == :none)
		$game_player.move_normal
		whole_event_end
		$game_map.interpreter.chcg_background_color(0,0,0,255)

		tmpCHK = false
		tmpPlayed = false

		tmpCHK = check_wakeup_event_LostBaby(parallel)
		tmpPlayed = tmpCHK if tmpCHK
		tmpCHK = check_wakeup_event_Menses(parallel)
		tmpPlayed = tmpCHK if tmpCHK
		tmpCHK = check_wakeup_event_MilkingChild(parallel)
		tmpPlayed = tmpCHK if tmpCHK

		tmpPlayed = check_wakeup_event_PeePoo(parallel) if !tmpPlayed #基於BOOL回報 不重要的事件只會則一波放
		tmpPlayed = check_wakeup_event_PTSD(parallel) if !tmpPlayed #噩夢於畫面FADEIN前優先撥放
		tmpPlayed = check_wakeup_event_SAT(parallel) if !tmpPlayed
		# if "def handleNap" didnt help,  this will force end nap
		$game_map.aft_nap
		$game_pause = false

		DataManager.doAutoSave(tmpDepose=true) if $story_stats["OverMapForceTrans"] == 0
	end #END OF WAKE UP EVENT
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
#####################################################   wake up event    END ############################################################
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
	def check_MainStats_event(parallel=false)
		return if $game_map.interpreter.running?
		return if [:grabbed,:sex].include?($game_player.actor.action_state)
		return if $story_stats["LonaCannotDie"] == 1
		####################################################################HP0 DEATH ###########################################################
		if $game_player.actor.health <=0 && $story_stats["dialog_death"] == 1
			p "trigger death"
			$game_player.moveto($game_player.x,$game_player.y)
			$game_player.actor.determine_death
				$game_player.moveto($game_player.x,$game_player.y)
				check_lona_way_of_death(tmpForcedWay=nil)
			$story_stats["dialog_death"] =0
			return overEVloadRB("Data/HCGframes/OverEvent_Death.rb",parallel)
		elsif $game_player.actor.sta <= -100 && $game_player.actor.health > 0
			return overEVloadRB("Data/HCGframes/OverEvent_Overfatigue.rb",parallel)
		elsif $game_player.actor.sta <=0 && $story_stats["dialog_sta"]==1 && !$game_map.isOverMap
			$story_stats["dialog_sta"]=0
			if check_oEV_with_parallel_mode?(parallel)
				$game_map.interpreter.lona_mood $game_player.actor.stat["pose"] == "pose4" ? "p4sta_damage" : "pain"
				$game_portraits.rprt.focus
				SndLib.sound_QuickDialog
				$game_map.popup(0,"common:Lona/Qmsg_lowsta#{rand(3)}",0,0)
			else
				overEVcall_msg("common:Lona/lowsta#{rand(3)}",parallel)
			end
		end
	end # main stats event

	#attr_accessor	:last_attacker
	#attr_accessor	:last_hitted_target
	#attr_accessor	:last_used_skill
	#attr_accessor	:last_hit_by_skill

	def check_lona_way_of_death(tmpForcedWay=nil)
		portrait_hide
		wait(10)
		portrait_off
		tmpGPA = $game_player.actor
		withLastAttacker = !tmpGPA.last_attacker.nil? && !tmpGPA.last_attacker.actor.nil? && (!tmpGPA.last_attacker.actor.skill.nil? || !tmpGPA.last_attacker.actor.last_used_skill.nil?) && !tmpGPA.last_hit_by_skill.nil?
		withLastSkillHit = withLastAttacker && (tmpGPA.last_hit_by_skill == tmpGPA.last_attacker.actor.last_used_skill || tmpGPA.last_hit_by_skill == tmpGPA.last_attacker.actor.skill)
		if withLastSkillHit
			if $game_player.actor.health <= -50
				way = "ByAttackOverKill"
			else
				way = "ByAttack"
			end
			#msgbox way
			#$game_player.actor.health = 1
		elsif  tmpGPA.last_hit_by_skill.nil?
			way = "BySta"
		else
			way = nil
		end
		way = tmpForcedWay if tmpForcedWay
		$game_player.mirror = [true,false].sample
		case way
			when "ByAttack"
				$game_player.jump_to($game_player.x,$game_player.y)
				$game_player.animation = $game_player.animation_over_corpse
				EvLib.sum("EffectKill",$game_player.x,$game_player.y,{:user=>$game_player}) if !$game_map.isOverMap
				SndLib.sound_combat_hit_gore(100)

			when "ByAttackOverKill"
				$game_player.jump_to($game_player.x,$game_player.y)
				$game_player.animation = $game_player.animation_overkill_melee_reciver_loop
				EvLib.sum("EffectOverKill",$game_player.x,$game_player.y) if !$game_map.isOverMap
				SndLib.sound_gore(100,70)
				SndLib.sound_combat_hit_gore(100)
			else # "BySta"
				$game_player.actor.sta = 0
				$game_player.animation = $game_player.animation_atk_pray_hold
				SndLib.sound_equip_armor(100,50)
				wait(60)
				$game_player.animation = nil
				$game_player.move_normal
				tmpA = 0
				tmpB = -1
				tmpC = 1
				until tmpA == 120
					tmpA += 1
					$game_player.forced_x = [tmpB,tmpC].sample
					wait(1)
				end
				$game_player.animation = $game_player.animation_overfatigue
				SndLib.sound_equip_armor(100)
		end
	end #check_lona_way_of_death

	def check_overmap_event(parallel=false)
		if $story_stats["OverMapEvent_DateCount"] >= 100
			p "trigger overmap change date"
			$story_stats["OverMapEvent_DateCount"] -=100
			handleNap
		end
		if $story_stats["StepStoryCount"] >= $story_stats["OverMapStepEncounterUnknow"]+rand(1000)
			p "trigger overmap unknow event"
			$story_stats["StepStoryCount"] = 0
			#$story_stats["OverMapEvent_enemy"] = 0
			overmap_random_event_trigger
		end
	end
	
	def player_carry_babies?
		babies=[]
		$game_party.all_items.each{
		|item| 
		babies.push(item) if item.type_tag.eql?("Child") || (item.type_tag.eql?("Key") && item.type.eql?("Baby"))
		}
		return true if !babies.empty?
	end
	
	def player_carry_LonaHumanoidBabies?
		babies=[]
		$game_party.all_items.each{|item| 
			babies.push(item) if item.common_tags["baby_LonaHumChild"]
		}
		return true if !babies.empty?
	end
	
	
end # class

