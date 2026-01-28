class Game_Actor

	def add_wound(part=nil)   #wounds 堆疊控制碼  請將肛門負傷移除 並重新排列STATES(15,16向前移)
		state_id = case part
			when "head"	; "WoundHead"
			when "chest"; "WoundChest"
			when "s_arm"; "WoundSArm"
			when "m_arm"; "WoundMArm"
			when "belly"; "WoundBelly"
			when "groin"; "WoundGroin"
			when "s_thigh"; "WoundGroin"
			when "m_thigh"; "WoundMThigh"
			when "body"; ["WoundMThigh","WoundSArm","WoundMArm","WoundBelly"].sample
			when "bot"; ["WoundGroin","WoundSThigh","WoundMThigh"].sample
			else ; part = wound_state_list.sample
		end
		if state_addable?(state_id)  ## Line below changed to allow stacking states.
			if max_state_stack?(state_id) # Check if we can transform the state
				wound_states = wound_state_list.shuffle
				if wound_states.include?(state_id)
					wound_states.each do |new_wound|
						unless max_state_stack?(new_wound)
							state_id = new_wound
							add_new_state(state_id)
							break
						end
					end
				end
			else
				add_new_state(state_id)
			end
			reset_state_counts(state_id)
			@result.added_states.push(state_id).uniq!
		end
	end
	def wound_state_list
		["WoundHead","WoundChest","WoundCuff","WoundSArm","WoundMArm","WoundCollar","WoundBelly","WoundGroin","WoundSThigh","WoundMThigh"]
	end
	#def cum_state_list #unused
	#	["CumsHead","CumsTop","CumsMid","CumsBot","CumsMouth"]
	#end
	def get_total_wounds
		total_wounds = 0
		wound_state_list.each{|state|total_wounds += $game_player.actor.state_stack(state)}
		total_wounds
	end

	def heal_wound  #負傷治療 通常用在休息時使用
		wound_states = wound_state_list
		all_wounds = wound_states.select { |id| state_stack(id) >= 1 }
		heal_me = all_wounds.shuffle.first(1)
		heal_me.each do |wound|
			remove_state_stack(wound)
			#add_new_state(35) if state_stack(35) <=10; remove_state_stack(35) if state_stack(35) >=11#dirt
			reset_state_counts(wound)
			reset_state_counts("DirtState")
			@result.added_states.push(wound).uniq!
			@result.added_states.push("DirtState").uniq!
		end
	end

	#def add_cums(part,race,amt)   #cums 堆疊控制碼 需數據化 #unused
	#	addCums(part,race,amt)
	#	cumsPartArr=cumsMap[part]
	#	state_id = cumsPartArr[0] if cumsMap[part].length==1
	#	state_id = cumsPartArr[rand(cumsPartArr.length)] if cumsMap[part].length>1
	#
	#	if max_state_stack?(state_id) && [18,19,24].include?(state_id)  #若指向為Anal or vag or mouth 且該項已滿 則導向 BODY
	#		add_new_state(cum_state_list.sample)
	#	else
	#		if state_addable?(state_id)  ## Line below changed to allow stacking states.
	#			if max_state_stack?(state_id) # Check if we can transform the state
	#				cums_states = cum_state_list.shuffle
	#				if cums_states.include?(state_id)
	#					cums_states.each do |new_cums|
	#						unless max_state_stack?(new_cums)
	#							state_id = new_cums
	#							add_new_state(state_id)
	#							break
	#						end
	#					end
	#				end
	#			else
	#				add_new_state(state_id)
	#			end
	#			reset_state_counts(state_id)
	#			@result.added_states.push(state_id).uniq!
	#		end
	#	end
	#end

	##治療CUMS，從所有部位中選擇1到3個來進行治療(刪除一層state)
	##同時減少@cums陣列中指定部位的cums數值(平均或是分散再說)
	#def heal_cums  #治療CUMS 通常用在休息時使用 將其數字化後從此處移除 對應位置參考attribute.rb #unused
	#	all_cums = cums_state_ids.select { |id| state_stack(id) >= 1 }
	#	heal_me = all_cums.shuffle.first(1 + rand(2))
	#	heal_me.each do |cums|
	#		remove_state_stack(cums)
	#		healCumsByStateId(cums)
	#		@result.added_states.push(cums).uniq!
	#		@result.added_states.push(35).uniq!
	#	end
	#end
 
	def process_nap_change #NAP專用  用以執行在中斷器結束運作前之反映 必要  勿砍
		p "97_Game_Actor_StatsAndState process_nap_change"
		#load_script("Data/Batch/Command_NapNormalMap.rb") #舊的控制rb，已搬進來
		#建議保留self，避免跟真正的區域變數衝突
		#▼Command_NapNormalMap.rb
		
		$game_NPCLayerMain.nap_reset_stats
		
		self.urinary_level  += rand(1000) if self.urinary_level <=1000
		self.lactation_level += (100*((2*self.stat["Lactation"]) + self.stat["Mod_MilkGland"]*10))*(self.sat*0.01) #STATE增加乳汁
		self.lactation_level = 0 if self.stat["Lactation"] == 0 && self.stat["Mod_MilkGland"] == 0
		self.defecate_level += rand(300) if self.defecate_level  <=1000
		self.arousal = rand(50) #reset basic arousal each nap
		self.sta += 20+rand(20)+self.sat    #heal up sta/nap
		tmpHealthChangeByNap = 0
		if self.stat["WeakSoul"] == 1 && ($story_stats["RapeLoop"] >= 1 || $story_stats["Captured"] >= 1)
			tmpHealthChangeByNap = (-20+(0.6*(self.sat+13))).round #heal up hp /nap
		else
			tmpHealthChangeByNap = (-20+(0.6*self.sat)).round #heal up hp /nap
		end
		self.last_hit_by_skill = $data_arpgskills["BasicHungryDamage"] if tmpHealthChangeByNap <0
		self.health += tmpHealthChangeByNap
		self.baby_health += (self.sat+(0.6*(self.sat+self.stat["WeakSoul"]*10)).round)-35 if self.preg_level !=0


		#當穴還未壞掉時治療穴傷害
		self.vag_damage -=35				if self.stat["VaginalDamaged"] ==0 
		self.urinary_damage -=35			if self.stat["SphincterDamaged"] ==0
		self.anal_damage -=35				if self.stat["UrethralDamaged"] ==0

		#藥物成癮控制
		#self.drug_addiction_level =100 if self.drug_addiction_level <100 && self.state_stack(103) !=0
		self.drug_addiction_damage -=rand(300)
		
		#精液中毒控制
		#self.semen_addiction_level =100 if self.semen_addiction_level <100 && self.state_stack(102) !=0
		self.semen_addiction_damage -=rand(300)
		
		#精液中毒控制
		#self.ograsm_addiction_level =100 if self.ograsm_addiction_level <100 && self.stat["OgrasmAddiction"] !=0
		self.ograsm_addiction_damage -=rand(300)
		
		if self.stat["WeakSoul"] == 1 && ($story_stats["RapeLoop"] >= 1 || $story_stats["Captured"] >= 1)
			self.sat -= 12 #basic -sat /nap
		elsif self.stat["WeakSoul"] == 1
			self.sat -= 15 #basic -sat /nap
		else
			self.sat -= 18 #basic -sat /nap
		end
		self.sat -= 12 if $story_stats["Setup_Hardcore"] >= 1 #basic -sat /nap
		#self.sat -= self.state_stack(94)+ self.state_stack(93)+ self.state_stack(96)+self.state_stack(97)#寄生蟲消耗食物
		
		
		self.puke_value_normal =0 if self.stat["StomachSpasm"] ==0 #StomachSpasm
		self.puke_value_normal =300 if self.stat["StomachSpasm"] >=1 #StomachSpasm
		self.puke_value_preg +=35+rand(10) if [1].include?(self.preg_level)
		self.pain_value_preg +=30+rand(10) if self.preg_level.between?(3,5)
		
		self.sat -=3+(2*self.preg_level) if self.preg_level >=1 #basic -sat /nap/preg
		
		self.dirt +=26 #basic dirt every nap
		self.gain_exp (rand(300)+self.level) #exp each nap
		self.healCums("CumsMoonPie", 100)
		self.healCums("CumsCreamPie", 100)
		self.healCums("CumsHead", 100)
		self.healCums("CumsTop", 100)
		self.healCums("CumsMid", 100)
		self.healCums("CumsBot", 100)
		self.healCums("CumsMouth", self.cumsMeters["CumsMouth"])
		
		self.remove_combat_state #stay in top
		self.remove_daily_state#stay in top
		tmpCon = self.constitution_trait/10
		((1+self.constitution_trait/10).to_i).times{
			self.heal_wound
		}
		self.update_player_nap_state_from_json_state#stay in bot
		self.update_player_nap_state_from_json_equip#stay in bot
		self.update_player_nap_get_state_when_from_json
		
		self.mood -=10 if self.sat ==0  #how sat effect mood
		self.mood -=10 if self.sat <=10
		self.mood -=10 if self.sat <=20
		self.mood +=10 if self.sat >=20
		self.mood +=10 if self.sat >=40
		self.mood +=10 if self.sat >=80
		self.mood -=20 if self.stat["Pessimist"] == 1

		$story_stats["dialog_cumflation"] = 1
		$story_stats["dialog_wet"] =1
		$story_stats["dialog_sta"] =1
		$story_stats["dialog_sat"] =1
		$story_stats["dialog_heavy_cums"] =1
		$story_stats["dialog_cuff"] =1
		$story_stats["dialog_collar"] =1
		$story_stats["dialog_dress_out"] =1
		$story_stats["dialog_defecate"] =1 if !$game_map.isOverMap
		$story_stats["dialog_urinary"] =1 if !$game_map.isOverMap
		$story_stats["dialog_defecated"] =1 if !$game_map.isOverMap
		$story_stats["dialog_overweight"] =1
		$story_stats["dialog_lactation"] =1
		$story_stats["dialog_sick"] =1
		$story_stats["dialog_drug_addiction"] =1
		$story_stats["dialog_parasited"] =1
		$story_stats["dialog_babie_feeding"] = $game_map.interpreter.player_carry_babies? ? 1 : 0
		
		$story_stats["BackStreetArrearsInterest"] = [((($story_stats["BackStreetArrearsPrincipal"]+$story_stats["BackStreetArrearsInterest"]) *1.05)-$story_stats["BackStreetArrearsPrincipal"]).round,1000000].min if $story_stats["BackStreetArrearsPrincipal"] != 0 && $game_date.dateAmt > $story_stats["BackStreetArrearsPrepayDateAMT"] && $game_date.day?
		$story_stats["WorldDifficulty"] = [$story_stats["WorldDifficulty"]+0.35,100].min
		$story_stats["LonaCannotDie"] = 0
		
		
		
		
		
		
		$story_stats["OverMapEvent_DateCount"] = 1+rand(15) if !$game_map.isOverMap
		
		if $story_stats["Setup_Hardcore"] >= 1
			#$game_party.drop_raw
			#$game_boxes.drop_raw(65533)
			#$game_boxes.drop_raw(65535)
			$game_party.update_rotten_items
			$game_boxes.update_rotten_items(65533)
			$game_boxes.update_rotten_items(65535)
		end
		
		$game_boxes.box(System_Settings::STORAGE_TEMP).clear
		$game_boxes.box(System_Settings::STORAGE_PLAYER_POT).clear
		$game_timer.off
		$game_party.lose_gold($game_party.gold) if $story_stats["Captured"] ==1
		$game_player.move_normal
		$game_player.unset_all_saved_event #reset all data, fix ghost dick
		self.map_loading_reset_stats
		$game_date.expireTradeHashCheck
		event_key_combat_end ######################################################## TEST for para OEV
		self.update_baby_health
		self.belly_size_control
		self.update_sex_exp
		self.update_melanin_eff
		self.update_melanin
		self.update_PubicHair
		self.update_sex_sensitivity
		self.set_action_state(:none,true)
		#▲Command_NapNormalMap.rb
		
		
		self.update_state_frames
		self.update_state_link
		self.update_reproduction	#更新生理週期相關參數
		refresh
		p "97_Game_Actor_StatsAndState process_nap_change"
	end
	
	def map_loading_reset_stats
		$game_player.balloon_id = 0
		$game_player.blend_type = 0
		$game_player.pathfinding = false
		$game_player.cannot_trigger = false
		$game_player.cannot_change_map = false
		$game_player.cannot_control = false
		$game_player.mind_control_on_hit_cancel = false
		$game_player.target = nil
		$game_player.transparent = false
		
		self.shieldEV = nil
		self.immune_damage = false
		self.immune_state_effect = false
		self.hit_LinkToMaster = false
		self.is_object = false
		self.master = nil
		self.is_a_ProtectShield = nil
	end
	
	def update_baby_health
		#return if self.preg_level < 1
		p "97_Game_Actor_StatsAndState.rb update_baby_health"
		self.set_baby_health(multiplier=1.2,update_current=false)
		case self.preg_level
			when 1 ; self.set_baby_health(multiplier=1,update_current=false)
			when 2 ; self.set_baby_health(multiplier=1.1,update_current=false)
			when 3 ; self.set_baby_health(multiplier=1.3,update_current=false)
			when 4 ; self.set_baby_health(multiplier=1.1,update_current=false)
			when 5 ; self.set_baby_health(multiplier=1,update_current=false)
		end
	end
	
 
####################################################################################################################################################
	

	def check_passage_from_json(tmpState)
				return true if tmpState["stats_value"] && tmpState["stats_key"] && tmpState["stats_filter"] && 		!(tmpState["stats_value"].include?(self.stat[tmpState["stats_key"]]) == tmpState["stats_filter"]					)
				return true if tmpState["stats_value2"] && tmpState["stats_key2"] && tmpState["stats_filter2"] && 	!(tmpState["stats_value2"].include?(self.stat[tmpState["stats_key2"]]) == tmpState["stats_filter2"]					)
				return true if tmpState["req_dirt"] && 								!(eval("self.dirt								#{tmpState['req_dirt'][0]}						#{tmpState['req_dirt'][1]}")						)
				return true if tmpState["req_drug_addiction_level"] && 				!(eval("self.drug_addiction_level				#{tmpState['req_drug_addiction_level'][0]}		#{tmpState['req_drug_addiction_level'][1]}")		)
				return true if tmpState["req_ograsm_addiction_level"] && 			!(eval("self.ograsm_addiction_level				#{tmpState['req_ograsm_addiction_level'][0]}	#{tmpState['req_ograsm_addiction_level'][1]}")		)
				return true if tmpState["req_semen_addiction_level"] && 			!(eval("self.semen_addiction_level				#{tmpState['req_semen_addiction_level'][0]}		#{tmpState['req_semen_addiction_level'][1]}")		)
				return true if tmpState["req_sat"] && 								!(eval("self.sat								#{tmpState['req_sat'][0]}						#{tmpState['req_sat'][1]}")							)
				return true if tmpState["req_CumsCreamPie"] && 						!(eval("self.cumsMeters['CumsCreamPie']			#{tmpState['req_CumsCreamPie'][0]}				#{tmpState['req_CumsCreamPie'][1]}")				)
				return true if tmpState["req_CumsMoonPie"] && 						!(eval("self.cumsMeters['CumsMoonPie']			#{tmpState['req_CumsMoonPie'][0]}				#{tmpState['req_CumsMoonPie'][1]}")					)
				return true if tmpState["req_Setup_Hardcore"] && 					!(eval("$story_stats['Setup_Hardcore']			#{tmpState['req_Setup_Hardcore'][0]}			#{tmpState['req_Setup_Hardcore'][1]}")				)
				return true if tmpState["req_baby_race"] &&							!(eval("self.baby_race							#{tmpState['req_baby_race'][0]}					tmpState['req_baby_race'][1]")						)
				return true if tmpState["chance_max"] && tmpState["chance_req"] &&	!(rand(tmpState["chance_max"]) >= tmpState["chance_req"])
				return true if tmpState["eval_rule"] && 							!(eval(tmpState["eval_rule"]))
				false
	end
	def json_addon_remove_equip(data)
		data.each{|tmpState|
			next unless tmpState["tgt_slot"]
			tgtSlot = tmpState["tgt_slot"].to_i
			next if self.equips[tgtSlot].nil?
			next if self.equips[tgtSlot].type_tag == "Bondage" && !tmpState["skip_Bondage"]
			self.change_equip(tgtSlot, nil)
		}
	end
	def json_addon_manage_state(item,data)
			data.each{|tmpState|
				tmpState["state_stack_check"] && item.is_a?( RPG::State) ? tmpHowMany = self.state_stack(item.id) : tmpHowMany = 1
				next if check_passage_from_json(tmpState)
				
				tmpHowMany.times{
					eval("self.dirt							#{tmpState['dirt'][0]}						tmpState['dirt'][1]")						if tmpState["dirt"]
					eval("self.sat							#{tmpState['sat'][0]}						tmpState['sat'][1]")						if tmpState["sat"]
					eval("self.anal_damage					#{tmpState['anal_damage'][0]}				tmpState['anal_damage'][1]")				if tmpState["anal_damage"]
					eval("self.urinary_damage				#{tmpState['urinary_damage'][0]}			tmpState['urinary_damage'][1]")				if tmpState["urinary_damage"]
					eval("self.vag_damage					#{tmpState['vag_damage'][0]}				tmpState['vag_damage'][1]")					if tmpState["vag_damage"]
					eval("self.ograsm_addiction_damage		#{tmpState['ograsm_addiction_damage'][0]}	tmpState['ograsm_addiction_damage'][1]")	if tmpState["ograsm_addiction_damage"]
					eval("self.ograsm_addiction_level		#{tmpState['ograsm_addiction_level'][0]}	tmpState['ograsm_addiction_level'][1]")		if tmpState["ograsm_addiction_level"]
					eval("self.semen_addiction_damage		#{tmpState['semen_addiction_damage'][0]}	tmpState['semen_addiction_damage'][1]")		if tmpState["semen_addiction_damage"]
					eval("self.semen_addiction_level		#{tmpState['semen_addiction_level'][0]}		tmpState['semen_addiction_level'][1]")		if tmpState["semen_addiction_level"]
					eval("self.drug_addiction_damage		#{tmpState['drug_addiction_damage'][0]}		tmpState['drug_addiction_damage'][1]")		if tmpState["drug_addiction_damage"]
					eval("self.drug_addiction_level			#{tmpState['drug_addiction_level'][0]}		tmpState['drug_addiction_level'][1]")		if tmpState["drug_addiction_level"]
					eval("self.player_nap_state_control		#{tmpState['player_nap_state_control'][0]}	tmpState['player_nap_state_control'][1]")	if tmpState["player_nap_state_control"]
					eval("self.vag_damage					#{tmpState['vag_damage'][0]}				tmpState['vag_damage'][1]")					if tmpState["vag_damage"]
					eval("self.urinary_damage				#{tmpState['urinary_damage'][0]}			tmpState['urinary_damage'][1]")				if tmpState["urinary_damage"]
					eval("self.anal_damage					#{tmpState['anal_damage'][0]}				tmpState['anal_damage'][1]")				if tmpState["anal_damage"]
					eval("self.arousal						#{tmpState['arousal'][0]}					tmpState['arousal'][1]")					if tmpState["arousal"]
					eval("self.baby_health					#{tmpState['baby_health'][0]}				tmpState['baby_health'][1]")				if tmpState["baby_health"]
					eval("self.addCums *#{tmpState['addCums']}") if tmpState["addCums"] #addCums("CumsCreamPie",1000,"Abomination") #slot num race
					
					

					
					if tmpState["tar_state_name"]
						next if self.max_state_stack?(tmpState["tar_state_name"][1]) && tmpState["tar_state_name"][0].to_f >0 #if max  dont add this state
						next if self.state_stack(tmpState["tar_state_name"][1]) == 0 && tmpState["tar_state_name"][0].to_f <0 #if 0  dont decrease any stste
						current_state_count = [self.state_stack(tmpState["tar_state_name"][1])+tmpState["tar_state_name"][0].to_f,0].max
						self.setup_state(tmpState["tar_state_name"][1],current_state_count)

						#NEW VER.  but will cause bug if json is with string
						#next if self.max_state_stack?(tmpState["tar_state_name"][1]) && tmpState["tar_state_name"][0] >0 #if max  dont add this state
						#next if self.state_stack(tmpState["tar_state_name"][1]) == 0 && tmpState["tar_state_name"][0] <0 #if 0  dont decrease any stste
						#current_state_count = [self.state_stack(tmpState["tar_state_name"][1])+tmpState["tar_state_name"][0],0].max
						#self.setup_state(tmpState["tar_state_name"][1],current_state_count)
					end
				}
			}
	end
	def manage_equip_from_json(item,data)
		
	end
	def update_player_nap_state_from_json_equip
		self.equips.each{|item|
			next if !item
			next if !item.player_nap_state_control
			json_addon_manage_state(item,item.player_nap_state_control)
		}
	end
	def update_player_nap_state_from_json_state
		checked_state = []  #record same state
		self.states.each{|state|
			next if !state
			next if checked_state.include?(state) #dont check same state
			checked_state << state #dont check same state
			next if !state.player_nap_state_control
			json_addon_manage_state(state,state.player_nap_state_control)
		}
		
		
	end
	
	
	def update_player_nap_get_state_when_from_json
		#清除所有戰鬥相關的state，主要用在nap流程
		$data_states.each{|state|
			next if !state
			next if !state.player_nap_get_state_when
			json_addon_manage_state(state,state.player_nap_get_state_when)
		}
	end
	def remove_combat_state
		#清除所有戰鬥相關的state，主要用在nap流程
		checked_state = []  #record same state
		self.states.each{|state|
			next if !state
			next if checked_state.include?(state) #dont check same state
			checked_state << state #dont check same state
			#next if !state.type_tag.eql?("combat")
			
			next unless state.is_combat_state
			self.remove_state(state.id)
		}
	end

	def remove_daily_state
		#清除所有日程相關的state，主要用在nap流程
		checked_state = []  #record same state
		self.states.each{|state|
			next if !state
			next if checked_state.include?(state) #dont check same state
			checked_state << state #dont check same state
			#next if !["daily","combat"].include?(state.type_tag)
			#self.remove_state(state.id) if state.type_tag.eql?("combat")
			#self.remove_state_stack(state.id) if state.type_tag.eql?("daily")
			
			next unless state.is_daily_state || state.is_combat_state
			self.remove_state(state.id) if state.is_combat_state
			self.remove_state_stack(state.id) if state.is_daily_state
		}
	end
	
	def update_PubicHair
		if self.stat["PubicHairVag"] >=1
			@pubicHair_Vag_GrowCount += 1
			if @pubicHair_Vag_GrowCount >= @pubicHair_Vag_GrowRate
				@pubicHair_Vag_GrowCount = 0
				self.add_state("PubicHairVag") if @pubicHair_Vag_GrowMAX > self.stat["PubicHairVag"]
			end
			@pubicHair_Vag_GrowMAX = self.stat["PubicHairVag"] if self.stat["PubicHairVag"] > @pubicHair_Vag_GrowMAX
		end
		if self.stat["PubicHairAnal"] >=1
			@pubicHair_Anal_GrowCount += 1
			if @pubicHair_Anal_GrowCount >= @pubicHair_Anal_GrowRate
				@pubicHair_Anal_GrowCount = 0
				self.add_state("PubicHairAnal") if @pubicHair_Anal_GrowMAX > self.stat["PubicHairAnal"]
			end
			@pubicHair_Anal_GrowMAX = self.stat["PubicHairAnal"] if self.stat["PubicHairAnal"] > @pubicHair_Anal_GrowMAX
		end
	end
	
	def check_mood_to_state #心情轉狀態
		return if @mood_state_vs == (self.mood / 25.0).round
		@mood_state_vs = (self.mood / 25.0).round
		setup_state("MoodBad",0) if self.stat["MoodBad"] !=0 && @mood_state_vs >= 0 #when good mood
		setup_state("MoodGood",0) if self.stat["MoodGood"] !=0 && @mood_state_vs <= 0 #when bad mood
		setup_state("MoodBad",@mood_state_vs.abs) if self.mood < 0 && @mood_state_vs <= -1#bad
		setup_state("MoodGood",@mood_state_vs) if self.mood > 0 && @mood_state_vs >= 1#good
	end
	
	def check_dirt_to_state #骯髒轉狀態
		return if @dirt_state_vs == (self.dirt / 100).floor
		@dirt_state_vs = (self.dirt / 100).floor
		setup_state("DirtState", @dirt_state_vs)
	end
	
	def check_prev_sta_to_exp #基本活動轉EXP & DIRT
		return if @prev_sta == self.sta
		temp_sta_to_dirt = @prev_sta - self.sta
		temp_sta_to_exp = temp_sta_to_dirt.abs
		gain_exp((temp_sta_to_exp*3).round)
		self.dirt += (temp_sta_to_exp/2).round if temp_sta_to_dirt > 0
		self.dirt = 255 if self.dirt > 255
	end
	
	def report_relax_able(tmpCost=10)
		tmpSuccess = false
		tmpSTA = self.sta
		tmpStaMax = self.battle_stat.get_stat("sta",2)
		tmpStaVS = ((tmpSTA-tmpStaMax).abs).to_i
		tmpHp = self.health
		tmpHpMax = self.battle_stat.get_stat("health",2)
		tmpHpVS = ((tmpHp-tmpHpMax).abs).to_i
		tmpSat = self.sat
		return tmpSuccess if tmpSat < tmpCost
		return tmpSuccess if tmpStaVS == 0 && tmpHpVS == 0
		tmpSuccess = true
		tmpSuccess
	end
	
	def check_sat_heal_HealthSta(tmpCost=10)# 瑾於NAP技能使用
		tmpSuccess = false
		tmpSTA = self.sta
		tmpStaMax = self.battle_stat.get_stat("sta",2)
		tmpStaVS = ((tmpSTA-tmpStaMax).abs)
		tmpStaVS.to_f.round(1)
		tmpHp = self.health
		tmpHpMax = self.battle_stat.get_stat("health",2)
		$story_stats["Setup_Hardcore"] <= 0 ? tmpHpVS = ((tmpHp-tmpHpMax).abs).to_i : tmpHpVS = 0
		tmpSat = self.sat
		return tmpSuccess if tmpSat < tmpCost
		return tmpSuccess if tmpStaVS == 0 && tmpHpVS == 0
		
		self.sat -= tmpCost
		satScore = tmpCost*2
		if tmpStaVS != 0 && satScore > 0
			tmpStaInc = ([tmpStaVS,satScore].min)
			satScore -= tmpStaInc
			satScore.to_f.round(1)
			self.sta += tmpStaInc
		end
		if tmpHpVS != 0 && satScore > 0
			tmpHpInc = ([tmpHpVS,satScore].min)
			satScore -= tmpHpInc
			satScore.to_f.round(1)
			self.health += tmpHpInc
		end
		
		tmpSuccess = true
		tmpSuccess
	end

	def check_Abom_heal_HealthSta(tmpCost=10)#ABOM LONA 回復技能
		tmpSuccess = false
		tmpSTA = self.sta
		tmpStaMax = self.battle_stat.get_stat("sta",2)
		tmpStaVS = ((tmpSTA-tmpStaMax).abs).to_i
		 tmpHp = self.health
		 tmpHpMax = self.battle_stat.get_stat("health",2)
		 tmpHpVS = 0
		 tmpHpVS = ((tmpHp-tmpHpMax).abs).to_i
		tmpSat = self.sat
		#return tmpSuccess if tmpSat < tmpCost
		#return tmpSuccess if tmpStaVS == 0 && tmpHpVS == 0
		
		#self.sat -= tmpCost
		if $story_stats["Setup_Hardcore"] >= 1
			satScore = (tmpCost*0.5).round
		else
			satScore = (tmpCost*0.8).round
		end
		
		if tmpStaVS != 0 && satScore > 0
			tmpStaInc = ([tmpStaVS,satScore].min).to_i
			satScore -= tmpStaInc
			self.sta += tmpStaInc
		end
		 if tmpHpVS != 0 && satScore > 0
		 	tmpHpInc = ([tmpHpVS,satScore].min).to_i
		 	satScore -= tmpHpInc
		 	self.health += tmpHpInc
		 end
		
		tmpSuccess = true
		tmpSuccess
	end
	
	
	
	def check_prev_sta_to_arousal #皮膚性器化 STA轉性慾
		return if self.stat["AsVulva_Skin"] !=1
		return if @prev_sta == self.sta
		temp_sta_to_arousal = (@prev_sta - self.sta).abs
		self.arousal += 2*temp_sta_to_arousal
	end
	
	def check_prev_health_to_mood #M屬性因苦痛增加MOOD
		return if self.stat["Masochist"] !=1
		return if @prev_health == self.health
		check_maso_add = true if @prev_health > self.health
		check_maso_add = false if @prev_health < self.health
		temp_health_to_mood = (@prev_health - self.health).abs
		self.mood += temp_health_to_mood if check_maso_add == true
	end

	
	def check_prev_health_to_BabyHealth #因HP傷害減少 BB HP
		return if self.preg_level ==0
		return if @prev_health == self.health
		check_bb_add = true if @prev_health > self.health
		check_bb_add = false if @prev_health < self.health
		temp_TarHealth = (@prev_health - self.health).abs
		self.baby_health -= (temp_TarHealth*1.2).round if check_bb_add == true
	end
	
	def check_prev_sta_to_BabyHealth #因STA傷害減少 BB HP
		return if self.preg_level ==0
		return if @prev_sta == self.sta
		check_bb_add = true if @prev_sta > self.sta
		check_bb_add = false if @prev_sta < self.sta
		temp_TarHealth = (@prev_sta - self.sta).abs
		self.baby_health -= (temp_TarHealth*0.3).round if check_bb_add == true
	end


	def belly_size_control    #肚子大小控制 使用於overevent
		if self.stat["ParasitedPotWorm"] >= 5
			temp_para_pot = 1
		else
			temp_para_pot = 0
		end
		if self.stat["ParasitedMoonWorm"] >= 5
			temp_para_moon = 1
		else 
			temp_para_moon=0
		end
		temp_belly_size = (@preg_level + self.stat["SemenBursting"] +temp_para_pot +temp_para_moon) #preg+heavy cums
		temp_belly_size -=1 if @preg_level !=0
		temp_belly_size =3 if temp_belly_size >=4
		if self.stat["preg"] != temp_belly_size
			self.stat["preg"] = temp_belly_size
		end
	end

	def hit_effect_mood_fix(temp_plus=1) #use in HitEffect combat, player take hit
		temp_res_a=3*temp_plus
		temp_res_b=2*temp_plus
		self.mood -= (rand(temp_res_a)+temp_res_b) if self.stat["Prostitute"]	 ==0 #change to -mood
		self.mood -= (rand(temp_res_a)+temp_res_b) if self.stat["IronWill"]		 ==1 #change to -mood
		self.mood += (rand(temp_res_a)+temp_res_b) if self.stat["Masochist"]	 ==1 #change to +mood
	end


	def	update_on_update_lonaStat #update on frame\27.rb   #moved to mod folder
		check_mood_to_state
		check_dirt_to_state
		check_prev_health_to_mood	#M屬性
		check_prev_sta_to_arousal #皮膚性器化
		check_prev_sta_to_exp
		check_prev_health_to_BabyHealth
		check_prev_sta_to_BabyHealth
	end
	
	def actor_ForceUpdate
		update_lonaStat_tera
		update_state_frames
		$game_player.update
		portrait.update
	end
	
	def actor_changeMapForceUpdate
		update_state_frames
		refresh
		$game_player.update
	end
	
	
	def allow_ograsm?
		return false if self.sta <=-100 || self.health <= 0
		return false if self.stat["Mod_VagGlandsSurgical"] ==1 #切除
		return true if self.action_state == :sex
		return true if self.stat["AsVulva_MilkGland"] ==1 && self.stat["AsVulva_Skin"] ==1 && self.stat["AsVulva_Anal"] ==1 && self.stat["AsVulva_Urethra"] ==1 && self.stat["AsVulva_Esophageal"] ==1
		return true if self.stat["FeelsHorniness"] >= 3 #快樂水
		return true if self.stat["Mod_VagGlandsLink"] == 1 #改造
		return true if self.stat["AllowOgrasm"] == true #此KEY僅由CHCG做操作
		return false
	end
	
	def event_key_cleaner #tool
		self.stat["EventVag"] = nil
		self.stat["EventAnal"] = nil
		self.stat["EventMouth"] = nil
		self.stat["EventExt1"] = nil
		self.stat["EventExt2"] = nil
		self.stat["EventExt3"] = nil
		self.stat["EventExt4"] = nil
		self.stat["EventVagRace"] = nil
		self.stat["EventAnalRace"] = nil
		self.stat["EventMouthRace"] = nil
		self.stat["EventExt1Race"] = nil
		self.stat["EventExt2Race"] = nil
		self.stat["EventExt3Race"] = nil
		self.stat["EventExt4Race"] = nil
		self.stat["vagopen"] = 0 #if not puting any toy inside
		self.stat["analopen"] = 0 #if not puting any toy inside
	end
	
	def event_key_combat_end #所有事件都撥放完 回到遊戲前的清理器
		event_key_cleaner
		self.stat["CombatEventOn"] = 0
		self.stat["EventTargetPart"] = nil
		self.stat["AllowOgrasm"] = false
		self.stat["allow_ograsm_record"] = false
		self.stat["EventTargetPart"] = nil
	end

	def handle_on_move_autoKeyclearner 
		self.stat["EventVag"] = nil					if self.stat["EventVag"] != nil				
		self.stat["EventAnal"] = nil				if self.stat["EventAnal"] != nil			
		self.stat["EventMouth"] = nil				if self.stat["EventMouth"] != nil			
		self.stat["EventExt1"] = nil				if self.stat["EventExt1"] != nil			
		self.stat["EventExt2"] = nil				if self.stat["EventExt2"] != nil			
		self.stat["EventExt3"] = nil				if self.stat["EventExt3"] != nil			
		self.stat["EventExt4"] = nil				if self.stat["EventExt4"] != nil			
		self.stat["EventVagRace"] = nil				if self.stat["EventVagRace"] != nil			
		self.stat["EventAnalRace"] = nil			if self.stat["EventAnalRace"] != nil		
		self.stat["EventMouthRace"] = nil			if self.stat["EventMouthRace"] != nil		
		self.stat["EventExt1Race"] = nil			if self.stat["EventExt1Race"] != nil		
		self.stat["EventExt2Race"] = nil			if self.stat["EventExt2Race"] != nil		
		self.stat["EventExt3Race"] = nil			if self.stat["EventExt3Race"] != nil		
		self.stat["EventExt4Race"] = nil			if self.stat["EventExt4Race"] != nil		
		self.stat["vagopen"] = 0					if self.stat["vagopen"] != 0				
		self.stat["analopen"] = 0					if self.stat["analopen"] != 0				
		self.stat["CombatEventOn"] = 0				if self.stat["CombatEventOn"] != 0			
		self.stat["EventTargetPart"] = nil			if self.stat["EventTargetPart"] != nil		
		self.stat["AllowOgrasm"] = false			if self.stat["AllowOgrasm"] != false		
		self.stat["allow_ograsm_record"] = false	if self.stat["allow_ograsm_record"] != false
		self.stat["EventTargetPart"] = nil			if self.stat["EventTargetPart"] != nil		
	end
	
	
end
