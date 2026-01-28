#######################################HCG FRAME 撥放API#####################################################
######所有PLAYLIST逼應結束後需下列兩個指令
#event_key_cleaner
#whole_event_end


#######################################Grab######################################################
#########################所有GRAB結束後記得用event_key_cleaner清KEY
module GIM_CHCG
	############################################################################################################################################################################
	############################################################################################################################################################################
	############################################################################################################################################################################
	############################################################################################################################################################################
	##############################################################　GRAB AnD HAS and COMBAT 	###############################################################################
	############################################################################################################################################################################
	############################################################################################################################################################################
	############################################################################################################################################################################
	############################################################################################################################################################################
	############################################################################################################################################################################

	def	combat_hit_get_removable_slots
		rand_key = $data_system.equip_type.select { |_, v| v[3] }.keys.sample
	end

	#old build, keep it.  most event still use it. and it works well.
	def combat_remove_random_equip(eqp_target=combat_hit_get_removable_slots,summon=true)
		eqp_target = $data_system.equip_type_name[eqp_target] if eqp_target.is_a?(String)
		#return if !equip_slot_removetable?(eqp_target)
		#tar_name = $game_player.actor.equips[eqp_target].item_name
		tar_name = combat_remove_random_equip_chk(eqp_target)
		return if !tar_name
		combat_remove_random_equip_exec(tar_name,eqp_target,summon)
	end #def
	#new build for hit in combat.
	def combat_hit_remove_random_equip(eqp_target=combat_hit_get_removable_slots,summon=true)
		eqp_target = $data_system.equip_type_name[eqp_target] if eqp_target.is_a?(String)
		tar_name = combat_remove_random_equip_chk(eqp_target)
		return if !tar_name
		return if ![0,1].include?(eqp_target) && $game_player.actor.stat["SacredAegis"] >= 1
		combat_remove_random_equip_exec(tar_name,eqp_target,summon)
	end

	def combat_EffectGrabHit
		tmpQ1 = get_character(0).summon_data[:target] == $game_player
		tmpQ2 =!get_character(0).nil? && !get_character(0).summon_data.nil?
		if tmpQ1 && tmpQ2 && $game_player.grabbed?
			combat_remove_random_equip(0)
			combat_remove_random_equip(1)
			if $game_player.actor.stat["SacredAegis"] < 1 && !$game_player.player_all_hole_opened? #block if lona with ScaredAegis
				combat_remove_random_equip(4)
				combat_remove_random_equip(6)
				combat_remove_random_equip
			end
			race=get_character(0).summon_data[:user].actor.race
			dmg=get_character(0).summon_data[:damage]
			combat_Hevent_Grab_Grab(race,dmg)
		end
	end

	def combat_remove_random_equip_exec(tar_name,eqp_target=combat_hit_get_removable_slots,summon=true)
		eqp_target = $data_system.equip_type_name[eqp_target] if eqp_target.is_a?(String)
		$game_player.actor.change_equip(eqp_target, nil)
		weaponSlots = $data_system.weapon_slots
		tarType = weaponSlots.include?(eqp_target) ? "Weapon" : "Armor"
		$game_party.drop_tgt_item_and_summon(tarType,tar_name,1,summon)
		if weaponSlots.include?(eqp_target) && summon
			SndLib.sound_combat_sword_hit_sword(vol=80,effect=65+rand(10))
		else
			SndLib.sound_DressTear(vol=80,effect=75+rand(10))
		end
		$game_player.actor.update_state_frames
		$game_player.update
	end

	def combat_remove_random_equip_chk(eqp_target=combat_hit_get_removable_slots)
		eqp_target = $data_system.equip_type_name[eqp_target] if eqp_target.is_a?(String)
		return nil if !equip_slot_removetable?(eqp_target)
		tar_name = $game_player.actor.equips[eqp_target].item_name
	end



	def combat_get_arousal_dmg(damage)
		$game_player.actor.arousal += rand(damage/2).round if $game_player.actor.stat["Nymph"] ==1
		$game_player.actor.arousal += rand(damage/2).round if $game_player.actor.stat["Masochist"] ==1
		$game_player.actor.arousal += rand(damage/2).round if $game_player.actor.stat["WeakSoul"] ==1
		$game_player.actor.arousal += ((damage/4)*$game_player.actor.stat["FeelsHorniness"]).round # FeelsHorniness
		$game_player.actor.arousal += (damage/6).round if $game_player.actor.stat["FeelsWarm"] ==1 # FeelsWarm
	end
	def equip_slot_removetable?(eqp_target)
		eqp_target = $data_system.equip_type_name[eqp_target] if eqp_target.is_a?(String)
		return false if $game_player.actor.equips[eqp_target].nil?
		return false if !$game_player.actor.equips[eqp_target].item_name
		return false if $game_player.actor.equips[eqp_target].key_item? #to protect combat item drop
		return false if $game_player.actor.equips[eqp_target].type_tag.eql?("Bondage")
		return false if $game_player.actor.equips[eqp_target].type_tag.eql?("Hair")
		return false if $game_player.actor.equips[eqp_target].type_tag.eql?("Debug")
		return false if $game_player.actor.equip_slot_fixed_hard?(eqp_target)
		return false if !$game_player.actor.common_unequippable?(eqp_target)
		return false if !$game_player.actor.equip_change_ok?(eqp_target)
		return true
	end
	def combat_lona_got_hit(moodDmg=1,mood="p5sta_damage",dropItem=rand(100) >=99)
		$game_player.actor.hit_effect_mood_fix(moodDmg) if moodDmg >= 1
		lona_HitWhenCombat(mood)
		combat_hit_remove_random_equip if dropItem
	end

	def combat_EffectParasiteHookHit
		user=$game_player.actor
		if user.state_stack("ParasitedMoonWorm") == 1 && $story_stats["dialog_HookWorm_hit"] ==1
			$story_stats["dialog_HookWorm_hit"] = 0
			call_msg("common:Lona/ParasiteHit_hook")
			$cg.erase
		else
			$game_map.popup(0,"QuickMsg:Lona/parasited#{rand(3)}",0,0)
		end
		load_script("Data/Batch/FloorClearnPee_control.rb")
		$game_player.actor.belly_size_control
		combat_hit_remove_random_equip
	end
	def combat_EffectPolypWormAdultTrapHit
		user=$game_player.actor
		if user.state_stack("ParasitedPolypWorm") == 1 && $story_stats["dialog_PolypWorm_hit"] ==1
			$story_stats["dialog_PolypWorm_hit"] = 0
			call_msg("common:Lona/ParasiteHit_polyp")
			$cg.erase
		else
			$game_map.popup(0,"QuickMsg:Lona/parasited#{rand(3)}",0,0)
		end
		load_script("Data/Batch/VagDilatation_control.rb")
		$game_player.actor.belly_size_control
		combat_hit_remove_random_equip
	end
	def combat_lona_got_speam_hit
		$game_player.actor.hit_effect_mood_fix(2)
		pose_commonH_decider(pose=$game_player.actor.stat["pose"],mood="shame")
		$game_player.actor.portrait.shake
		my_race = get_character(0).summon_data[:user].summon_data[:user].actor.race
		tar_part= [
			"CumsHead",
			"CumsTop",
			"CumsMid",
			"CumsBot"
		]
		case my_race
		when "Human" 		; tar_val=80+rand(30)
		when "Moot" 		; tar_val=100+rand(30)
		when "Orkind"		; tar_val=200+rand(50)
		when "Goblin"		; tar_val=200+rand(50)
		when "Abomination"	; tar_val=150+rand(50)
		when "Deepone"		; tar_val=120+rand(40)
		when "Fishkind"		; tar_val=120+rand(40)
		when "Troll"		; tar_val=1000+rand(500)
		else 				; tar_val=80+rand(30)
		end
		$game_player.actor.addCums((tar_part[rand(tar_part.length)]),tar_val,my_race)
	end

	def combat_EffectHarBoobTouchHit
		tmpCHR = get_character(0)
		if !tmpCHR.nil? && !tmpCHR.summon_data.nil? &&tmpCHR.summon_data[:target]==$game_player
			combat_hit_remove_random_equip
			race=tmpCHR.summon_data[:user].actor.race
			dmg=tmpCHR.summon_data[:damage]
			combat_Hevent_Grab_BoobTouch(race,dmg)
			tmpCHR.delete
		end
	end

	def combat_EffectHarAnalTouchHit
		tmpCHR = get_character(0)
		if !tmpCHR.nil? && !tmpCHR.summon_data.nil? &&tmpCHR.summon_data[:target]==$game_player
			combat_hit_remove_random_equip
			race=tmpCHR.summon_data[:user].actor.race
			dmg=tmpCHR.summon_data[:damage]
			combat_Hevent_Grab_AnalTouch(race,dmg)
			tmpCHR.delete
		end
	end
	def combat_EffectHarVagTouchHit
		tmpCHR = get_character(0)
		if !tmpCHR.nil? && !tmpCHR.summon_data.nil? &&tmpCHR.summon_data[:target]==$game_player
			combat_hit_remove_random_equip
			race=get_character(0).summon_data[:user].actor.race
			dmg=get_character(0).summon_data[:damage]
			combat_Hevent_Grab_VagTouch(race,dmg)
			tmpCHR.delete
		end
	end
	def combat_EffectHarFeedingHit
		tmpCHR = get_character(0)
		if !tmpCHR.nil? && !tmpCHR.summon_data.nil? &&tmpCHR.summon_data[:target]==$game_player
			combat_hit_remove_random_equip
			race=get_character(0).summon_data[:user].actor.race
			dmg=get_character(0).summon_data[:damage]
			combat_Hevent_Grab_Feeding(race,dmg)
			tmpCHR.delete
		end
	end
	def combat_EffectHarVagLickHit
		tmpCHR = get_character(0)
		if !tmpCHR.nil? && !tmpCHR.summon_data.nil? &&tmpCHR.summon_data[:target]==$game_player
			combat_hit_remove_random_equip
			race=tmpCHR.summon_data[:user].actor.race
			dmg=tmpCHR.summon_data[:damage]
			combat_Hevent_Grab_VagLick(race,dmg)
			tmpCHR.delete
		end
	end
	def combat_EffectHarKissedHit
		tmpCHR = get_character(0)
		if !tmpCHR.nil? && !tmpCHR.summon_data.nil? &&tmpCHR.summon_data[:target]==$game_player
			combat_hit_remove_random_equip
			race=get_character(0).summon_data[:user].actor.race
			dmg=get_character(0).summon_data[:damage]
			combat_Hevent_Grab_Kissed(race,dmg)
			tmpCHR.delete
		end
	end


	def combat_EffectHarPunchHit
		tmpCHR = get_character(0)
		if !tmpCHR.nil? && !tmpCHR.summon_data.nil? &&tmpCHR.summon_data[:target]==$game_player
			combat_hit_remove_random_equip
			race=get_character(0).summon_data[:user].actor.race
			dmg=get_character(0).summon_data[:damage]
			combat_Hevent_Grab_Punch(race,dmg)
			tmpCHR.delete
		end
	end
	def combat_EffectParasiteMoonHit
		user=$game_player.actor
		if user.state_stack("ParasitedMoonWorm") == 1 && $story_stats["dialog_moon_worm_hit"] ==1
			$story_stats["dialog_moon_worm_hit"] = 0
			call_msg("common:Lona/ParasiteHit_moon")
			$cg.erase
		else
			$game_map.popup(0,"QuickMsg:Lona/parasited#{rand(3)}",0,0)
		end
		load_script("Data/Batch/AnalDilatation_control.rb")
		$game_player.actor.belly_size_control
		combat_hit_remove_random_equip
	end

	def combat_EffectParasitePotHit
		user=$game_player.actor
		if user.state_stack("ParasitedPotWorm") == 1 && $story_stats["dialog_pot_worm_hit"] ==1
			$story_stats["dialog_pot_worm_hit"] = 0
			call_msg("common:Lona/ParasiteHit_pot")
			$cg.erase
		else
			$game_map.popup(0,"QuickMsg:Lona/parasited#{rand(3)}",0,0)
		end
		load_script("Data/Batch/UrinaryDilatation_control.rb")
		$game_player.actor.belly_size_control
		combat_hit_remove_random_equip
	end

################################################################################################################################## event hit
################################################################################################################################## event hit
################################################################################################################################## event hit
################################################################################################################################## event hit
################################################################################################################################## event hit
################################################################################################################################## event hit
################################################################################################################################## event hit
################################################################################################################################## event hit
################################################################################################################################## event hit
################################################################################################################################## event hit
################################################################################################################################## event hit
################################################################################################################################## event hit
################################################################################################################################## event hit
################################################################################################################################## event hitd
	def combat_Hevent_Grab_Grab(race,damage)
		$game_player.actor.stat["EventExt1Race"] = "#{race}"
		$game_player.actor.stat["EventTargetPart"] = "Breast"
		p "combat_Hevent_Grab_Grab : #{$game_player.actor.stat["EventTargetPart"]} Grab"

		################################################################################################
		$game_player.actor.stat["EventExt1"] ="Grab" #anal cum inside frame 1
		pose_commonH_decider(pose=$game_player.actor.stat["pose"],mood="sta_damage")
		################################################################################################
		$game_player.actor.portrait.shake
		$game_player.actor.mood -= (rand(3)+2) if $game_player.actor.stat["Prostitute"] ==0 #change to -mood
		$game_player.actor.mood -= (rand(3)+2) if $game_player.actor.stat["IronWill"] ==1 #change to -mood
		$game_player.actor.arousal += rand(6) * 10 if $game_player.actor.stat["AsVulva_Skin"] ==1 #皮膚性器化
		$game_player.actor.arousal += rand(damage)+(rand(3) * $game_player.actor.sensitivity_breast) #B敏感
		$game_player.actor.lactation_level += (3*$game_player.actor.stat["Lactation"]) + ($game_player.actor.stat["Mod_MilkGland"]*5) #STATE增加乳汁
		SndLib.sound_equip_armor(80)
		################################################################################################
		$game_player.call_balloon([6,26,27].sample)
		#$game_map.popup(0,"QuickMsg:Lona/grab#{talk_style}#{rand(3)}",0,0)
		################################################################################################
	end

	def combat_Hevent_Grab_AnalTouch(race,damage)
		$game_player.actor.stat["EventAnalRace"] = "#{race}"
		$game_player.actor.stat["AllowOgrasm"] = true
		$game_player.actor.stat["EventTargetPart"] = "Anal"
		p "combat_Hevent_Grab_AnalTouch : #{$game_player.actor.stat["EventTargetPart"]} AnalTouch"

		################################################################################################
		$game_player.actor.stat["EventAnal"] ="AnalTouch"
		pose_commonH_decider(pose=$game_player.actor.stat["pose"],mood="sta_damage")
		################################################################################################
		#basic frame damage
		#SceneManager.scene.hud.perform_damage_effect #req map hud
		$game_player.actor.portrait.shake
		$game_player.actor.mood -= (rand(3)+2) if $game_player.actor.stat["Prostitute"] ==0 #change to -mood
		$game_player.actor.mood -= (rand(3)+2) if $game_player.actor.stat["IronWill"] ==1 #change to -mood
		combat_get_arousal_dmg(damage)
		$game_player.actor.arousal += rand(6) * 10 if $game_player.actor.stat["AsVulva_Skin"] ==1 #皮膚性器化
		$game_player.actor.arousal += rand(6) * $game_player.actor.sensitivity_anal #A敏感
		SndLib.sound_chcg_full(40)
		SndLib.sound_equip_armor(80)
		################################################################################################
		check_over_event
		$game_player.call_balloon([6,26,27].sample)
		#$game_map.popup(0,"QuickMsg:Lona/grab#{talk_style}#{rand(3)}",0,0)
		################################################################################################
		$story_stats["sex_record_groped"] +=1
		$story_stats["sex_record_butt_harassment"] +=1
	end

	def combat_Hevent_Grab_BoobTouch(race,damage)
		$game_player.actor.stat["EventExt1Race"] = "#{race}"
		$game_player.actor.stat["AllowOgrasm"] = true
		$game_player.actor.stat["EventTargetPart"] = "Breast"
		p "Playing combat_Hevent_Grab_BoobTouch : #{$game_player.actor.stat["EventTargetPart"]} BoobTouch"

		################################################################################################
		$game_player.actor.stat["EventExt1"] ="BoobTouch"
		pose_commonH_decider(pose=$game_player.actor.stat["pose"],mood="sta_damage")
		################################################################################################
		$game_player.actor.portrait.shake
		$game_player.actor.mood -= (rand(3)+2) if $game_player.actor.stat["Prostitute"] ==0 #change to -mood
		$game_player.actor.mood -= (rand(3)+2) if $game_player.actor.stat["IronWill"] ==1 #change to -mood
		combat_get_arousal_dmg(damage)
		$game_player.actor.arousal += rand(damage)+(rand(3) * $game_player.actor.sensitivity_breast) #B敏感
		$game_player.actor.arousal += rand(6) * 10 if $game_player.actor.stat["AsVulva_Skin"] ==1 #皮膚性器化
		$game_player.actor.lactation_level += 3*$game_player.actor.stat["Lactation"] + ($game_player.actor.stat["Mod_MilkGland"]*5) #STATE增加乳汁
		SndLib.sound_chcg_full(40)
		SndLib.sound_equip_armor(80)
		################################################################################################
		check_over_event
		$game_player.call_balloon([6,26,27].sample)
		#$game_map.popup(0,"QuickMsg:Lona/grab#{talk_style}#{rand(3)}",0,0)
		################################################################################################
		$story_stats["sex_record_groped"] +=1
		$story_stats["sex_record_boob_harassment"] +=1
	end

	def combat_Hevent_Grab_VagTouch(race,damage)
		$game_player.actor.stat["EventVagRace"] = "#{race}"
		$game_player.actor.stat["AllowOgrasm"] = true
		$game_player.actor.stat["EventTargetPart"] = "Vag"
		p "Playing combat_Hevent_Grab_VagTouch : #{$game_player.actor.stat["EventTargetPart"]} VagTouch"

		################################################################################################
		$game_player.actor.stat["EventVag"] ="VagTouch"
		pose_commonH_decider(pose=$game_player.actor.stat["pose"],mood="sta_damage")
		################################################################################################
		$game_player.actor.portrait.shake
		$game_player.actor.mood -= (rand(3)+2) if $game_player.actor.stat["Prostitute"] ==0 #change to -mood
		$game_player.actor.mood -= (rand(3)+2) if $game_player.actor.stat["IronWill"] ==1 #change to -mood
		$game_player.actor.arousal += rand(damage*3)+(rand(3) * $game_player.actor.sensitivity_vag) #v敏感
		$game_player.actor.arousal += rand(6) * 10 if $game_player.actor.stat["AsVulva_Skin"] ==1 #皮膚性器化
		combat_get_arousal_dmg(damage)
		SndLib.sound_chs_buchu(80)
		#$game_player.actor.health -= rand(2) if $game_player.actor.stat["WeakSoul"] ==0
		#$game_player.actor.health -= rand(2)
		################################################################################################
		check_over_event
		$game_player.call_balloon([6,26,27].sample)
		#$game_map.popup(0,"QuickMsg:Lona/grab#{talk_style}#{rand(3)}",0,0)
		################################################################################################
		$story_stats["sex_record_groped"] +=1
		$story_stats["sex_record_groin_harassment"] +=1
	end

	def combat_Hevent_Grab_Punch(race,damage)
		$game_player.actor.stat["EventVagRace"] = "#{race}"
		$game_player.actor.stat["AllowOgrasm"] = true
		$game_player.actor.stat["EventTargetPart"] = "Torture"
		p "combat_Hevent_Grab_Punch : #{$game_player.actor.stat["EventTargetPart"]} BellyPunch"

		################################################################################################
		$game_player.actor.stat["EventVag"] ="Punch2"
		pose_commonH_decider(pose=$game_player.actor.stat["pose"],mood="crit_damage")
		################################################################################################\
		$game_player.actor.portrait.shake
		$game_player.actor.mood -= (rand(5)+10) if $game_player.actor.stat["Prostitute"] ==0 #change to -mood
		$game_player.actor.mood -= (rand(8)+20) if $game_player.actor.stat["IronWill"] ==1 #change to -mood
		$game_player.actor.mood += (rand(5)+19) if $game_player.actor.stat["Masochist"] ==1 #change to +mood
		$game_player.actor.arousal -= rand(damage)
		$game_player.actor.arousal += 1 * ($game_player.actor.stat["AsVulva_Skin"]*10) #皮膚性器化
		$game_player.actor.arousal += rand(damage*5) if $game_player.actor.stat["Masochist"] ==1
		$game_player.actor.sta += 1
		$game_player.actor.health -= rand(5)
		$game_player.actor.lactation_level += $game_player.actor.stat["Lactation"] + ($game_player.actor.stat["Mod_MilkGland"]*5) #STATE增加乳汁
		SndLib.sound_whoosh(50)
		SndLib.sound_punch_hit(100)
		################################################################################################
		check_over_event
		$game_map.popup(0,"QuickMsg:Lona/beaten#{rand(10)}",0,0)
		################################################################################################
		$story_stats["sex_record_torture"] +=1
	end

	def combat_Hevent_Grab_VagLick(race,damage)
		$game_player.actor.stat["EventVagRace"] = "#{race}"
		$game_player.actor.stat["AllowOgrasm"] = true
		$game_player.actor.stat["EventTargetPart"] = "Vag"
		p "combat_Hevent_Grab_VagLick : #{$game_player.actor.stat["EventTargetPart"]} VagLick"

		################################################################################################
		$game_player.actor.stat["EventVag"] ="Snuff"
		pose_commonH_decider(pose=$game_player.actor.stat["pose"],mood="shame")
		################################################################################################\
		$game_player.actor.portrait.shake
		$game_player.actor.mood -= (rand(3)+2) if $game_player.actor.stat["Prostitute"] ==0 #change to -mood
		$game_player.actor.mood -= (rand(3)+2) if $game_player.actor.stat["IronWill"] ==1 #change to -mood
		$game_player.actor.arousal += rand(6) * 10 if $game_player.actor.stat["AsVulva_Skin"] ==1 #皮膚性器化
		$game_player.actor.arousal += rand(damage*5)+(rand(3) * $game_player.actor.sensitivity_vag) #v敏感
		combat_get_arousal_dmg(damage)
		SndLib.sound_chcg_chupa(80)
		################################################################################################
		check_over_event
		$game_player.call_balloon([6,26,27].sample)
		#$game_map.popup(0,"QuickMsg:Lona/grab#{talk_style}#{rand(3)}",0,0)
		################################################################################################
		$story_stats["sex_record_groped"] +=1
		$story_stats["sex_record_cunnilingus_taken"] +=1
	end

	def combat_Hevent_Grab_Feeding(race,damage)
		$game_player.actor.stat["EventMouthRace"] = "#{race}"
		################################################################################################
		$game_player.actor.stat["EventMouth"] ="Feeding"
		lona_mood "chcg1fuck_#{chcg_shame_mood_decider}"
		$game_player.actor.portrait.angle=90
		temp_x = $game_player.actor.portrait.portrait.x
		temp_y = $game_player.actor.portrait.portrait.y
		temp_x = 300 ; temp_y = 710
		$game_player.actor.portrait.portrait.x = temp_x
		$game_player.actor.portrait.portrait.y += temp_y
		################################################################################################
		$game_player.actor.portrait.shake
		$game_player.actor.mood -= (rand(3)+2) if $game_player.actor.stat["Prostitute"] ==0 #change to -mood
		$game_player.actor.mood -= (rand(3)+2) if $game_player.actor.stat["IronWill"] ==1 #change to -mood
		$game_player.actor.arousal += rand(6) * 10 if $game_player.actor.stat["AsVulva_Skin"] ==1 #皮膚性器化
		$game_player.actor.arousal += rand(damage*3)+(rand(3) * $game_player.actor.sensitivity_breast) #B敏感
		combat_get_arousal_dmg(damage)
		SndLib.sound_chcg_chupa(80)
		################################################################################################
		call_msg_popup("QuickMsg:Lona/Feeding#{rand(3)}")
		################################################################################################
		$story_stats["sex_record_BreastFeeding"] +=1
	end

	def combat_Hevent_Grab_Kissed(race,damage)
		$game_player.actor.stat["EventMouthRace"] = "#{race}"
		################################################################################################
		$game_player.actor.stat["AllowOgrasm"] = true
		$game_player.actor.stat["EventTargetPart"] = "Mouth"
		p "combat_Hevent_Grab_kissed : #{$game_player.actor.stat["EventTargetPart"]} ForcedKiss"

		################################################################################################
		$game_player.actor.stat["EventMouth"] ="kissed"
		################################################################################################
		$game_player.actor.portrait.shake
		$game_player.actor.mood -= (rand(3)+2) if $game_player.actor.stat["Prostitute"] ==0 #change to -mood
		$game_player.actor.mood -= (rand(3)+2) if $game_player.actor.stat["IronWill"] ==1 #change to -mood
		$game_player.actor.mood += (rand(3)+5) if $game_player.actor.stat["Nymph"] ==1 #change to +mood
		$game_player.actor.mood += (rand(3)+5) if $game_player.actor.stat["Masochist"] ==1 #change to +mood
		$game_player.actor.arousal += rand(6) * 10 if $game_player.actor.stat["AsVulva_Skin"] ==1 #皮膚性器化
		$game_player.actor.arousal += rand(6) * 10 if $game_player.actor.stat["AsVulva_Esophageal"] ==1 #魔紋：食道性器化
		$game_player.actor.arousal += rand(damage*3)+(rand(5) * $game_player.actor.sensitivity_mouth) #B敏感
		combat_get_arousal_dmg(damage)
		SndLib.sound_chcg_chupa(80)
		################################################################################################
		#message control
		check_over_event
		$game_player.call_balloon([6,26,27].sample)
		#$game_map.popup(0,"QuickMsg:Lona/grab#{talk_style}#{rand(3)}",0,0)
		################################################################################################
		$story_stats.sex_record_mouth(["DataNpcName:race/#{$game_player.actor.stat["EventMouthRace"]}" , "DataNpcName:part/mouth"])
		$story_stats["sex_record_kissed"] +=1
		$story_stats["sex_record_groped"]+=1
		$story_stats["sex_record_mouth_count"] +=1
		$story_stats["sex_record_kissed"]+=1

	end

########################################################################################################## overevent drug effect
########################################################################################################## overevent drug effect
########################################################################################################## overevent drug effect
########################################################################################################## overevent drug effect
########################################################################################################## overevent drug effect
########################################################################################################## overevent drug effect
########################################################################################################## overevent drug effect
########################################################################################################## overevent drug effect
########################################################################################################## overevent drug effect
########################################################################################################## overevent drug effect
########################################################################################################## overevent drug effect

	def batch_IEFX_HiPotionLV5
		call_msg("common:Lona/preglv5_birth_start_pain1")
		SndLib.sound_Heartbeat(90,90)
		screen.start_tone_change(Tone.new(125,0,125,80),60)
		SndLib.sound_DressTear
		combat_remove_random_equip(0)
		combat_remove_random_equip(1)
		combat_remove_random_equip(3)
		combat_remove_random_equip(4)
		combat_remove_random_equip(4)
		combat_remove_random_equip(6)
		call_msg("common:Lona/Ograsm_addiction_overLv3")
		$game_player.actor.add_state("ForceExhibitionism")
		$game_player.actor.add_state("ForceLewd")

		$story_stats["dialog_dress_out"] = 0
		#$game_player.actor.setup_state("ForceLewd",1) #ForceLewd

		EvLib.sum("EffectLewdCrazy",1,1)
		get_character(0).delete
	end

end #module
