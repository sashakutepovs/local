
class Game_Player
	#	attr_reader  :sex_fight_count_z
	#	attr_reader  :sex_fight_count_x
		
	
	def no_light?
		[:sneak, :sneak_overfatigue, :sneak_cuffed].include?(@movement)
	end

	def player_chained?
		return true if ["ChainCuffTopExtra", "CuffTopExtra"].include?(actor.stat["MainArm"])
		return true if ["ChainCollarTopExtra"].include?(actor.stat["equip_TopExtra"])
		return true if actor.stat["equip_MidExtra"] == "ChainMidExtra"
		return false
	end
	
	def player_cuffed?
		return false if actor.equips[0] == nil
		return false if actor.equips[0].type_tag != "Bondage"
		return true
		#["ChainCuffTopExtra", "CuffTopExtra"].include?($game_actors[1].stat["MainArm"])
	end
	
	def player_women?
		return true if player_slave?
		return true if player_cuffed?
		return true if player_chained?
		return true if player_nude?
		return true if $game_player.actor.sexy >= 30
		return true if $game_player.actor.weak >= 35
		return false
	end
	def player_slave?
		return true if actor.stat["SlaveBrand"] == 1
		return true if actor.stat["equip_TopExtra"] == "CollarTopExtra"
		return true if actor.stat["equip_TopExtra"] == "ChainCollarTopExtra"
		return true if actor.stat["equip_MidExtra"] == "ChainMidExtra"
		return true if actor.stat["MainArm"] == "CuffTopExtra"
		return true if actor.stat["MainArm"] == "ChainCuffTopExtra"
		return false
	end
	def player_nude?
		chest_present = actor.equip_part_covered.include?("Chest")
		anal_present = actor.equip_part_covered.include?("Anal")
		vag_present = actor.equip_part_covered.include?("Vag")
		return true if !(chest_present && vag_present && anal_present)
		return false
	end
	def player_full_nun_dressed?
		return false if $game_player.actor.stat["equip_head"] != "NunVeil"
		return false if $game_player.actor.stat["equip_Mid"] != "NunSexyMid"
		return false if $game_player.actor.stat["equip_MidExtra"] != "NunMidExtra"
		true
	end
	def player_all_hole_opened?
		#groin_present = actor.equip_part_covered.include?("Groin")
		face_present = actor.equip_part_covered.include?("Face")
		anal_present = actor.equip_part_covered.include?("Anal")
		vag_present = actor.equip_part_covered.include?("Vag")
		return true if !(face_present && vag_present && anal_present)
		return false
	end
	def light_check
		return give_light("lona_sight") if $game_map.isOverMap
		return give_light("lantern_player") if actor.equips.include?($data_ItemName["ItemShLantern"]) && !no_light?
		return give_light("lantern_player_sm") if actor.ext_items.any?{|item| 
			next if !item
			next if $game_party.item_number(item) <= 0
			item == "ItemShLantern"
			} && !no_light?
		return give_light("lona_sight")
	end
	
	#更新overMap相關的內容

###################################################################################################################
###################################################################################################################
#########################################	OVER MAP SHITS 		##################################################
###################################################################################################################
###################################################################################################################
###################################################################################################################
	def handle_on_move_overmap(use_ctrl=false) #OVERMAP
		tmpDash = [:dash, :dash_fatigue, :dash_cuffed, :dash_overfatigue].include?($game_player.movement)
		overmap_anti_stuck
		SndLib.sound_step(rand(20)+60,rand(20)+50)
		SndLib.sound_step_chain(rand(20)+30,rand(20)+80) if player_chained?
		use_ctrl ? sta_cost = 6 : sta_cost = deduct_lona_sta_overmap
		$story_stats["OnRegionMap_Regid"] = $game_player.region_id
		$story_stats["Setup_Hardcore"] >= 1 ? tmpHcMode = 1 : tmpHcMode = 0
		tmpResult=0
		tmpResult += sta_cost*2 if actor.weight_immobilized?
		tmpResult += sta_cost*0.5 if !use_ctrl
		tmpResult += sta_cost*0.5 if actor.sta <=0 && !use_ctrl
		tmpResult += sta_cost*0.5 if tmpDash && !use_ctrl
		actor.sta -= tmpResult
		tmpDash && !use_ctrl ? tmp_timePassed = sta_cost*0.5/2 : tmp_timePassed = sta_cost*0.5 #削減時間消耗DASH
		#tmp_timePassed = sta_cost*0.5
		p "time passed = #{tmp_timePassed}"
		$story_stats["OverMapEvent_DateCount"] += tmp_timePassed #rand for 補正
		$story_stats["StepOvermapDangerous"] += (((rand(20)*tmpHcMode) + $story_stats["WorldDifficulty"])/2).round #TODO 增加OVERMAP STA計步器 實際上不採用
		$story_stats["StepStoryCount"] += rand(150)+1#+3*sta_cost # 增加OVERMAP STA計步器 
		$game_damage_popups.add(tmpResult.round,self.x, self.y,0,2)
		handle_on_move_step(sta_cost)
		overmap_gen_WildDangerous
		$game_temp.reserve_common_event(:HOM_OverMap) #hom_overmap
		
		#p "Setup_Hardcore #{$story_stats["Setup_Hardcore"]}"
		#p "WorldDifficulty #{$story_stats["WorldDifficulty"]}"
		#p "StepOvermapDangerous #{$story_stats["StepOvermapDangerous"]}"
		p "StepStoryCount #{$story_stats["StepStoryCount"]}"
		p "WildDangerous = #{$story_stats["WildDangerous"]}"
	end
	
	def overmap_relax
		if $game_player.actor.check_sat_heal_HealthSta
			SndLib.sys_Gain(90)
			$game_map.popup(0,"QuickMsg:Lona/FeelsBetter#{rand(2)}",0,0)
		else
			SndLib.sys_buzzer
		end
	end
	
	def overmap_anti_stuck
		return if !$game_map.isOverMap
		return p "Test Mode Stucked" if  $TEST && !$game_map.passable?(self.x, self.y, self.direction)
		return if $game_map.passable?(self.x, self.y, self.direction)
		if $story_stats["LastOverMapX"] <= 1 && $story_stats["LastOverMapY"] <= 1
			$story_stats["LastOverMapX"]= $story_stats["StartOverMapX"]
			$story_stats["LastOverMapY"]= $story_stats["StartOverMapY"]
			msgbox "Player Stucked, all doomed!"
			self.moveto($story_stats["DebugOverMapX"],$story_stats["DebugOverMapY"])
		else
			msgbox "Player Stucked lastX=>#{$story_stats["LastOverMapX"]} lastY=>#{$story_stats["LastOverMapY"]}"
			self.moveto($story_stats["LastOverMapX"],$story_stats["LastOverMapY"])
		end
	end
	
	def overmap_gen_WildDangerous
		$story_stats["Setup_Hardcore"] >= 1 ? tmpHcMode = 1 : tmpHcMode = 0
		$story_stats["WildDangerous"] =rand(100) + ($story_stats["WorldDifficulty"]/2) + (25*tmpHcMode)
		$story_stats["WildDangerous"] *=0.8 if $game_date.day?
		$story_stats["WildDangerous"] *=1.2 if $game_date.night?
		$story_stats["WildDangerous"] = $story_stats["WildDangerous"].round
	end
###################################################################################################################
###################################################################################################################
#########################################	NORMAL MAP SHITS 		##################################################
###################################################################################################################
###################################################################################################################
###################################################################################################################
	def handle_on_move  #NORMAL MAP
		actor.event_key_combat_end if actor.stat["CombatEventOn"] == 1 && ![:grabbed,:sex].include?(actor.action_state)
		actor.skill_changed=true
		@forced_y = 0
		#if self.on_water_floor?
		#	#@forced_y = 3
		#	SndLib.stepWater(rand(10)+70,rand(20)+40)
		#elsif self.on_bush_floor?
		#	#@forced_y = 0
		#	SndLib.stepBush(rand(5)+70,rand(10)+95)
		#else
			@stepSndCount +=1
			if @stepSndCount >= @move_speed.to_i/2
				if self.on_water_floor?
					SndLib.stepWater(rand(10)+70,rand(20)+40)
				elsif self.on_bush_floor?
					SndLib.stepBush(rand(5)+70,rand(10)+95)
				else
					SndLib.sound_step(rand(20)+25,rand(20)+20)
				end
				@stepSndCount = 0
			end

		#end
		SndLib.sound_step_chain(rand(20)+20,rand(20)+80) if player_chained?
		
		#DASH控制
		if [:dash, :dash_fatigue, :dash_cuffed, :dash_overfatigue].include?(@movement) && $game_map.threat
			actor.sta -= 0.3
		end
		
		#視覺控制 LEWD but laggy
		#if actor.stat["EffectWet"] == 1 && rand(2) == 0
		#	$game_map.reserve_summon_event("WasteWet",self.x,self.y,-1,{:user=>self})
		#end
	end
	
	def handle_on_move_fps_update
		#$cg.erase
		#$game_map.interpreter.chcg_background_color_off
		handle_on_move_step
		actor.refresh
		@reqUpdateHomNormal = true #tell HOM commonevent update it
	end
	
	
	def handle_on_move_step(multiplier = 1)
		hom_chk_Fatigue_freeze
		hom_chk_portrait_idle
		hom_chk_Exhibitionism(multiplier)#露出闢控制
		hom_chk_arousal_overflow(multiplier) #高潮抑制控制
		hom_chk_PiercingChest(multiplier)#胸部穿環控制
		hom_chk_PiercingVag(multiplier)#陰部穿環控制
		hom_chk_PiercingAnal(multiplier) #肛門穿環控制
		hom_chk_Parasited(multiplier) #寄生蟲控制
		hom_chk_FeelsSick(multiplier)#生病控制
		hom_chk_StomachSpasm(multiplier) #胃病控制
		hom_chk_STD_basic(multiplier)  #itch
		hom_chk_weight_immobilized?
		hom_chk_FeelsHorniness(multiplier) #lewd drug
		hom_chk_SemenAddiction(multiplier)
		hom_chk_OgrasmAddiction(multiplier)
		hom_chk_DrugAddiction(multiplier)
		hom_chk_Fatigue(multiplier)
		hom_chk_death_nap
		
		#Other
		hom_chk_puke_value_preg(multiplier)
		hom_chk_pain_value_preg(multiplier)
		hom_chk_lactation_level(multiplier) #STATE增加乳汁
		hom_chk_arousal(multiplier) # feels warm, justrcum overcum


		multiplier.times{
			actor.refresh_hom_effects
		}
	end

###############################################################################################################################
	def hom_chk_Fatigue_freeze
		if actor.sta >0 && actor.stat["Fatigue".freeze] ==1
			actor.remove_state("Fatigue")
		end
	end
	def hom_chk_portrait_idle
		if actor.stat_changed  #2020 7 17 moved from game_player update
			actor.prtmood("normal",false) if $game_portraits.getRprt_idle_time <= 0
			$game_portraits.setRprt(actor.name)
			refresh_chs #if actor.stat_changed
		end
	end
	def hom_chk_Exhibitionism(multiplier)
		if player_nude? && actor.mood > 0
			actor.mood  -=1*multiplier if actor.stat["Exhibitionism"] !=1
		end
	end
	def hom_chk_arousal_overflow(multiplier)
		if actor.arousal >= 1.2*actor.will
			actor.sta  -=0.15*multiplier
			actor.mood  -=0.15*multiplier if actor.mood >-100
		end
	end
	def hom_chk_PiercingChest(multiplier)
		if actor.stat["PiercingChest"] !=0
			actor.arousal += (0.3*(0.1*(actor.stat["PiercingChest"]+actor.sensitivity_breast)))*multiplier
		end
	end
	def hom_chk_PiercingVag(multiplier)
		if actor.stat["PiercingVag"] !=0
			actor.arousal += (0.3*(0.1*(actor.stat["PiercingVag"]+actor.sensitivity_vag)))*multiplier
		end
	end
	def hom_chk_PiercingAnal(multiplier)
		if actor.stat["PiercingAnal"] !=0
			actor.arousal += (0.3*(0.1*(actor.stat["PiercingAnal"]+actor.sensitivity_anal)))*multiplier
		end
	end
	def hom_chk_Parasited(multiplier)
		if actor.stat["ParasitedMoonWorm"] !=0 #月蟲
			actor.defecate_level +=  rand(1+actor.stat["ParasitedMoonWorm"])*multiplier
		end
		if actor.stat["ParasitedPotWorm"] !=0 #壺蟲
			actor.urinary_level +=  rand(1+actor.stat["ParasitedPotWorm"])*multiplier
		end
	end
	def hom_chk_FeelsSick(multiplier)
		if actor.stat["FeelsSick"] >= 1
			actor.sta -=(0.3 * actor.stat["FeelsSick"])*multiplier
		end
	end
	def hom_chk_StomachSpasm(multiplier)
		if actor.stat["StomachSpasm"] >= 1
			actor.puke_value_normal += (10+rand(10) * actor.stat["StomachSpasm"])*multiplier
		end
	end
	def hom_chk_STD_basic(multiplier)
		if actor.stat["STD_WartAnal"] + actor.stat["STD_WartVag"] >= 1
			actor.itch_level += (actor.stat["STD_WartAnal"] + actor.stat["STD_WartVag"] + actor.stat["STD_HerpesAnal"] + actor.stat["STD_HerpesVag"])*multiplier
		end
	end
	def hom_chk_weight_immobilized?
		if actor.weight_immobilized?	#過重定義
			actor.sta -= 1
			call_balloon(6) if @balloon == 0
		end
	end
	def hom_chk_FeelsHorniness(multiplier)
		case actor.stat["FeelsHorniness"]
			when 1 ; actor.arousal += ((1*actor.stat["FeelsHorniness"]))*multiplier if actor.arousal <= 0.55*actor.will # feels hot
			when 2 ; actor.arousal += ((2*actor.stat["FeelsHorniness"]))*multiplier if actor.arousal <= 0.8*actor.will # feels hot
			when 3 ; actor.arousal += ((3*actor.stat["FeelsHorniness"]))*multiplier if actor.arousal <= 0.9*actor.will # feels hot
			when 4 ; actor.arousal += ((4*actor.stat["FeelsHorniness"]))*multiplier if actor.arousal <= actor.will # feels hot
			when 5..100 ; actor.arousal += ((actor.stat["FeelsHorniness"]*actor.stat["FeelsHorniness"]))*multiplier if actor.arousal <= actor.will # feels hot
		end
	end
	def hom_chk_SemenAddiction(multiplier)
		if actor.stat["SemenAddiction"] >=1
			actor.semen_addiction_level += (1* actor.stat["SemenAddiction"])*multiplier
			if actor.stat["SemenBursting"] >=1 #精液超載
				actor.arousal += (0.5*actor.stat["SemenAddiction"])*multiplier
			end
		end
	end
	def hom_chk_OgrasmAddiction(multiplier)
		if actor.stat["OgrasmAddiction"] >=1
			actor.ograsm_addiction_level += (1* actor.stat["OgrasmAddiction"])*multiplier
		end
	end
	def hom_chk_DrugAddiction(multiplier)
		if actor.stat["DrugAddiction"] >=1
			actor.drug_addiction_level += (0.5* actor.stat["DrugAddiction"])*multiplier
		end
	end
	def hom_chk_Fatigue(multiplier)
		if actor.sta <=0 && actor.stat["Fatigue"] !=1
			actor.add_state("Fatigue")
		elsif actor.sta >0 && actor.stat["Fatigue"] ==1
			actor.erase_state("Fatigue")
		end
	end
	def hom_chk_death_nap
		if actor.action_state == :death && actor.sta > -100 && actor.health > 0
			actor.set_action_state(:none,true)
		end
	end
	def hom_chk_puke_value_preg(multiplier)
		actor.puke_value_preg +=(1+rand(2))*multiplier if [1,5].include?(actor.preg_level)
	end
	def hom_chk_pain_value_preg(multiplier)
		actor.pain_value_preg +=(1+rand(2))*multiplier if [3,4,5].include?(actor.preg_level)
	end
	def hom_chk_lactation_level(multiplier)
		actor.lactation_level += ((actor.stat["Lactation"] + 5)*(actor.sat*0.01))*multiplier if actor.stat["Mod_MilkGland"] >=1 #STATE增加乳汁
		actor.lactation_level += (actor.stat["WombSeedBed"]*(0.5+actor.sat*0.005))*multiplier if actor.stat["WombSeedBed"] >=1 #STATE增加乳汁
	end
	def hom_chk_arousal(multiplier)
		actor.arousal += (1)*multiplier if actor.stat["FeelsWarm"] ==1 && actor.arousal <= 0.55* actor.will # feels warm, lower than wet
		actor.arousal += (1)*multiplier if actor.stat["Cummed"] ==1 && actor.arousal <= 0.55* actor.will # justrcum
		actor.arousal += (1)*multiplier if actor.stat["OverCummed"] ==1 && actor.arousal <= actor.will # overcum
	end
	

end #class game player
