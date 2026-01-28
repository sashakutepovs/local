#batch for event character in EvLib

class Game_Event < Game_Character
	
	def batch_itemDropSemen
		tmpA = $game_player.actor.stat["Mod_Taste"]
		tmpB = $game_player.actor.stat["SemenGulper"]
		tmpC = $game_player.actor.stat["SemenAddiction"]
		@manual_trigger = -1 if !(tmpA>=1 || tmpB>=1 || tmpC>=1)
		@summon_data={
			:isEquip => false,
			:isItem => @manual_trigger != -1
		}
		@pattern = rand(3)
		@direction = (2 + rand(4) * 2)
		@forced_y = -13+rand(27)
		@forced_x = -13+rand(27)
	end
	
	def batch_itemDropVomit
		tmpA = $game_player.actor.stat["Omnivore"]
		tmpB = $game_player.actor.stat["Mod_Taste"]
		@manual_trigger =-1 if !(tmpA>=1 || tmpB>=1)
		@summon_data={
			:isEquip => false,
			:isItem => @manual_trigger != -1
		}
		@pattern = rand(3)
		@direction = (2 + rand(4) * 2)
		@forced_y = -13+rand(27)
		@forced_x = -13+rand(27)
	end
	def batch_itemDropPoo
		tmpA = $game_player.actor.stat["Omnivore"]
		tmpB = $game_player.actor.stat["Mod_Taste"]
		@manual_trigger = -1 if !(tmpA>=1 || tmpB>=1)
		@summon_data={
			:isEquip => false,
			:isItem => @manual_trigger != -1
		}
		@pattern = rand(3)
		@direction = (2 + rand(4) * 2)
		@forced_y = -13+rand(27)
		@forced_x = -13+rand(27)
	end
	def batch_itemDropFlesh
		@summon_data={
			:isEquip => false,
			:isItem => true
		}
		@mirror = [true, false].sample
		tmpPattle = rand(3)
		@manual_pattern = tmpPattle
		@pattern = tmpPattle
		@forced_y = -13+rand(27)
		@forced_x = -13+rand(27)
		@zoom_x = rand(50)*0.01 + 0.5
		@zoom_y = rand(25)*0.01 + 0.75
	end
	def batch_itemDropMeat
		if @summon_data && @summon_data[:toX] && @summon_data[:toY]
			toX = @summon_data[:toX]
			toY = @summon_data[:toY]
		end
		@summon_data={
			:isEquip => false,
			:isItem => true
		}
		@mirror = [true, false].sample
		@forced_y = -13+rand(27)
		@forced_x = -13+rand(27)
		@zoom_x = rand(50)*0.01 + 0.5
		@zoom_y = rand(25)*0.01 + 0.75
		@forced_z = 2
		if toX && toY
			self.jump_to(toX,toY)
		end
	end
	def batch_itemDropitem
		@summon_data={
			:isEquip => false,
			:isItem => true
		}
		@mirror = [true, false].sample
		@forced_y = -13+rand(27)
		@forced_x = -13+rand(27)
		@forced_z = 8
	end
	def batch_itemDropEquipSetup
		@summon_data={
			:isEquip => true,
			:isItem => true
		}
		@mirror = [true, false].sample
		@forced_y = -13+rand(27)
		@forced_x = -13+rand(27)
		@forced_z = 2
	end
	
	def followerBasicMove #self.basicMove
		if self.near_the_target?($game_player,17) && @follower[1] == 1
			move_goto_xy($game_player.x,$game_player.y)
		end
	end
	
	
	def victimBasicMove(tmpRegion=50,tier="HostageSavedRich") #self.basicMove 
		tmpRange = self.report_range($game_player)
		if @follower[1] == 1 && self.region_id == tmpRegion
			set_this_event_follower_remove
			if tier && !@tmpVictimBasicMoveEnd
				$story_stats["HostageSaved"] = Hash.new(0) if $story_stats["HostageSaved"] == 0
				$story_stats["HostageSaved"][tier] += 1
				@tmpVictimBasicMoveEnd = true
			end
			fadeout_delete_region(7,tmpRegion)
		elsif tmpRange < 17 && @follower[1] == 1
			if [true,false].sample
				@wait_count = rand(15)
			elsif tmpRange == 2 && self.x != $game_player.x && self.y != $game_player.y
				move_goto_xy($game_player.x,$game_player.y)
			else
				companion_chase_character_back($game_player)
			end
		end
	end
	
	def questVictimBasicMove
		return if @follower[1] != 1
		if self.near_the_target?($game_player,17)
			move_goto_xy($game_player.x,$game_player.y)
		end
		if @balloon_id == 0 && self.region_id == 50
			call_balloon(28,-1)
		elsif @balloon_id == 28 && self.region_id != 50
			call_balloon(0)
		end
	end
	
	def efx_skill_BasicNunHeal
		@blend_type =1
		@opacity = 0
		@force_update =true
		@forced_z = 1
	
		return delete if @summon_data[:target].actor.action_state == :death
		target=@summon_data[:target]
		user=@summon_data[:user]
		@summon_data[:target].actor.refresh
		tmpSta =target.actor.battle_stat.get_stat("sta")
		if tmpSta >0 && target.npc? && target.use_chs?
			chs_index= target.charset_index
			target.character_index = target.chs_definition.chs_default_index[chs_index]
			target.npc.remove_state(14)
		end

		tarX = @summon_data[:target].x
		tarY = @summon_data[:target].y
		tarDir = @summon_data[:target].direction
		self.moveto(tarX,tarY)

		#add stats buff
		userCon=@summon_data[:user].actor.battle_stat.get_stat("constitution")
		if userCon >= 50
			tmpStateID = "ChannelSpdBuff10"
		elsif userCon >= 35
			tmpStateID = "ChannelSpdBuff8"
		elsif userCon >= 10
			tmpStateID = "ChannelSpdBuff6"
		#elsif userCon >= 5
		else
			tmpStateID = "ChannelSpdBuff4"
			#tmpStateID = false
		end
		
		if tmpStateID ######&& !target.actor.immune_state_effect
			tarIcon = $data_StateName[tmpStateID].icon_index
			target.actor.add_state(tmpStateID)
			$game_damage_popups.add(tarIcon,tarX,tarY,tarDir,4)
		end
		#heal wound
		tmpUserIsPP = user == $game_player
		if !tmpUserIsPP || (tmpUserIsPP && user.actor.stat["SaintFieldSupporter"] != 0)
			tmpHealWounds = false
			wound_states = [
				"WoundHead",
				"WoundChest",
				"WoundCuff",
				"WoundSArm",
				"WoundMArm",
				"WoundCollar",
				"WoundBelly",
				"WoundGroin",
				"WoundSThigh",
				"WoundMThigh"
			 ]
			all_wounds = wound_states.select { |id| target.actor.state_stack(id) >= 1 }
			heal_me = all_wounds.shuffle.first(1)
			heal_me.each do |wound|
				target.actor.remove_state_stack(wound)
				tmpHealWounds = true
			end
			if tmpHealWounds
				tarIcon = $data_SkillName["BasicNunHeal"].icon_index #68
				$game_damage_popups.add(tarIcon,tarX,tarY,tarDir,4)
			end
		end
	
		#aggro if target's target is range
		tmpTNT = target.npc.target
		return if !tmpTNT
		return if user.npc.friendly?(tmpTNT)
		return if tmpTNT.npc.master == user
		if tmpTNT.npc.ranged? || rand(100) > 70
			tmpTNT.actor.set_aggro(user.actor,$data_arpgskills["BasicNormal"],300)
		end
		give_light("green_torch_item")
		4.times{ $game_damage_popups.add(rand(12)+1,self.x, self.y,2,6) }
		#user = @summon_data[:user]
		#tmpTarXY = get_target_front_xy(user)
		#targetEV = $game_map.npcs.select{|ev|
		#	next if ev == user
		#	next if ev.npc.action_state == :death
		#	next if ev.deleted?
		#	next if !ev.pos?(tmpTarXY[0],tmpTarXY[1])
		#	ev
		#}
		#EvLib.sum("EffectLifeBuff",user.x,user.y)
		#return if targetEV.empty?
		#targetEV = targetEV.sample
		#EvLib.sum("EffectLifeBuffRev",targetEV.x,targetEV.y)
	end
	
	def batch_testlaEfxHold_MR #self.testlaEfx
		return self.delete if @summon_data[:user].actor.action_state != :skill
		return self.delete if @summon_data[:user].actor.skill.nil?
		return self.delete if @summon_data[:user].actor.skill.name != "TeslaStaffNormal"
		SndLib.sound_TeslaHold(report_distance_to_vol_close)
		self.direction = @summon_data[:user].direction
		self.actor.launch_skill($data_arpgskills["TeslaFront"],true)
		@summon_data[:user].actor.sta -= 0.5
	end
	
	def batch_testlaEfxHold_init
		user=@summon_data[:user]
		moveto(user.x,user.y)
		user.actor.holding_efx=self

		@forced_x = -3
		@forced_y = 10
		@forced_z = 1
		@blend_type =1
		@zoom_y = 1
		if user.use_chs?
			tmpCwFy = $chs_data[user.chs_type].cell_width
		end
		@zoom_y = (tmpCwFy/128.0).round(2)
		@zoom_x = 0.5
		@mirror = [true,false].sample
		@eleTop = 32
		if user.use_chs?
			tmpCeFy = $chs_data[user.chs_type].cell_height
			tmpBoFy = $chs_data[user.chs_type].balloon_height
			@eleTop = tmpCeFy + tmpBoFy
		end
		@effects=["TeslaFadeIn",[0,@forced_y,@eleTop,@pattern,0]]
		give_light("cyanTesla")
		set_npc("SkillDummy")
		userWis = user.actor.battle_stat.get_stat("wisdom")
		@npc.set_wisdom(userWis)
		@npc.set_fraction(@summon_data[:user_fraction])
		@npc.user_redirect=true
		@tmpAni=[
			[3,2,3],
			[4,2,3],
			[5,2,3]
		]
		self.animation = self.aniCustom(@tmpAni,-1)
	end
	
	
	
	
	
	def batch_chainMaceEfxHold1(tmpShift=false)
		return self.delete if @summon_data[:user].actor.action_state != :skill
		return self.delete if @summon_data[:user].actor.skill.nil?
		return self.delete if !["ChainMaceNormal","NpcChainMaceSpin"].include?(@summon_data[:user].actor.skill.name)
		self.direction = @summon_data[:user].direction
		SndLib.sound_combat_whoosh(report_distance_to_vol_close)
		self.actor.launch_skill($data_arpgskills["ChainMaceNormalT1"],true)
	end
	def batch_chainMaceEfxHoldSpin
		return self.delete if @summon_data[:user].actor.action_state != :skill
		return self.delete if @summon_data[:user].actor.skill.nil?
		return self.delete if !["ChainMaceNormal","NpcChainMaceSpin"].include?(@summon_data[:user].actor.skill.name)
		@opacity=255
		SndLib.sound_stable_woosh(report_distance_to_vol_close,150+rand(30))
		@tmpEfxRound += 1
		############################################player
		if @summon_data[:user] == $game_player
			originDir = @summon_data[:user].direction
			inputDir = Input.KeyboardMouseDir4  # mouse new
			if inputDir > 0 && !@tmpUser.moving? #  mouse new
				@tmpUser.direction = inputDir #  mouse new
				@tmpUser.move_forward
			end
			@summon_data[:user].direction = originDir #  mouse new
		############################################npc
		elsif @summon_data[:user].npc.target != nil && !@summon_data[:user].moving?
			@tmpUser.turn_toward_character(@summon_data[:user].npc.target)
			@tmpUser.move_toward_TargetDumbAI(@summon_data[:user].npc.target)
		end
		if @tmpEfxRound >= 3
			@tmpEfxRound = 0
			@summon_data[:user].actor.sta -= 0.4 if @summon_data[:user] == $game_player
			self.actor.launch_skill($data_arpgskills["ChainMaceNormalT2"],true)
		end
		self.stackWithTarget(@tmpUser)
		case @direction
			when 2
				@forced_z = 4
			when 4
				@forced_z = 1
			when 6
				@forced_z = 1
			when 8
				@forced_z = -3
		end
	end
	
	
	
	
	
	def batch_boardSwordEfxHold1(tmpShift=false)
		return self.delete if @summon_data[:user].actor.action_state != :skill
		return self.delete if @summon_data[:user].actor.skill.nil?
		return self.delete if !["BroadSwordNormal","NpcBroadSwordSpin"].include?(@summon_data[:user].actor.skill.name)
		self.direction = @summon_data[:user].direction
		SndLib.sound_combat_whoosh(report_distance_to_vol_close+10,60)
		self.actor.launch_skill($data_arpgskills["BroadSwordNormalT1"],true)
	end
	def batch_boardSwordEfxHoldSpin
		user = @summon_data[:user]
		return self.delete if user.actor.action_state != :skill
		return self.delete if user.actor.skill.nil?
		return self.delete if !["BroadSwordNormal","NpcBroadSwordSpin"].include?(user.actor.skill.name)
		SndLib.sound_stable_woosh(report_distance_to_vol_close,70+rand(10))
		@tmpEfxRound += 1
		############################################player
		if user == $game_player
			user.animation = user.animation_BoardSword_hold_spin_only(tmpMode=@switch1_id) if !@re_enterAnimation
			@re_enterAnimation = true
			#p "@holding_count :#{$game_player.actor.holding_count}"
			#p "launch_max :#{$game_player.actor.skill.launch_max}"
			pp_holding_count = user.actor.holding_count
			if pp_holding_count >= 400 && !@dizzy_t3
				@dizzy_t3 = true
				user.actor.add_state("Dizzy")
				$game_damage_popups.add($data_StateName["Dizzy"].icon_index, user.x, user.y,[4,6].sample,4,rand(100)+1) if user.actor.stat["Dizzy"] <6
				SndLib.BonkHitSap(self.report_distance_to_vol_close)
				user.actor.force_stun("Stun3")
				return user.actor.take_skill_cancel($data_arpgskills["BasicNormal"])

			elsif pp_holding_count  >= 330 && !@dizzy_t2
				user.actor.add_state("Dizzy")
				$game_damage_popups.add($data_StateName["Dizzy"].icon_index, user.x, user.y,[4,6].sample,4,rand(100)+1) if user.actor.stat["Dizzy"] <6
				SndLib.BonkHitSap(self.report_distance_to_vol_close-5)
				@dizzy_t2 = true
			elsif pp_holding_count >= 192 && !@dizzy_t1
				user.actor.add_state("Dizzy")
				$game_damage_popups.add($data_StateName["Dizzy"].icon_index, user.x, user.y,[4,6].sample,4,rand(100)+1) if user.actor.stat["Dizzy"] <6
				SndLib.BonkHitSap(self.report_distance_to_vol_close-10)
				@dizzy_t1 = true
			end
			inputDir = Input.KeyboardMouseDir4  # mouse new
			if inputDir > 0 && !@tmpUser.moving? #  mouse new
				@tmpUser.direction = inputDir #  mouse new
				@tmpUser.move_forward
			end
		############################################npc
		elsif user.npc.target != nil && !user.moving?
			@tmpUser.turn_toward_character(user.npc.target)
			@tmpUser.move_toward_TargetDumbAI(user.npc.target)
		end
		if @tmpEfxRound >= 3
			@tmpEfxRound = 0
			user.actor.sta -= 1 if user == $game_player
			self.actor.launch_skill($data_arpgskills["BroadSwordNormalT2"],true)
		end
		self.stackWithTarget(@tmpUser)
	end
	
	def testlaOnWater? # self.isWater?
		self.actor.launch_skill($data_arpgskills["TeslaAoe"],true) if self.on_water_floor?
	end
	
	def testlaEfxProj #self.testlaEfx
		SndLib.sound_FarBoom(report_distance_to_vol_far,400)
		@opacity = 255
		@pattern = rand(3)
		@mirror = [true,false].sample
		give_light("cyan")
		flashData = Color.new(255,255,255,report_distance_to_vol_close-60)
		$game_map.interpreter.flash_screen(flashData,4,false)
		if self.on_water_floor?
			self.actor.launch_skill($data_arpgskills["TeslaAoeWater"],true)
		else
			self.actor.launch_skill($data_arpgskills["TeslaSelf"],true)
		end
	end
	
	def testlaAoeIffEfx
		SndLib.sound_TeslaHold(report_distance_to_vol_close)
		self.direction = @summon_data[:user].direction
		self.actor.launch_skill($data_arpgskills["TeslaAoeIFF"],true)
	end
	
	def testlaAoeEfx #testlaEfx
		SndLib.sound_TeslaHold(report_distance_to_vol_close)
		self.direction = @summon_data[:user].direction
		self.actor.launch_skill($data_arpgskills["TeslaAoe"],true)
	end
	
	def testlaWaterAoeEfx #testlaEfx
		SndLib.sound_TeslaHold(report_distance_to_vol_close)
		self.direction = @summon_data[:user].direction
		self.actor.launch_skill($data_arpgskills["TeslaAoeWater"],true)
	end
	
	def testlaLinkToUser
		tmpPattern = rand(3)
		self.drop_light
		@manual_pattern = tmpPattern
		@pattern = tmpPattern
		@opacity = 180+rand(75)
		@zoom_y = [self.report_rangeRound(@originUser)*0.5,0.2].max
		@angle = get_target_angle(@tmpUser.x,@tmpUser.y)
		SndLib.sound_TeslaHit(report_distance_to_vol_close-20)
		start if @summon_data[:target] == $game_player
		if @summon_data[:target].on_water_floor? 
			EvLib.sum("EffectTeslaWaterAoe",@tmpTar.x,@tmpTar.y,{:user=>@tmpUser})
		elsif @tmpTar.summon_data && @tmpTar.summon_data[:TeslaCoil] && @summon_data[:user].actor.skill && @summon_data[:user].actor.skill.name == "TeslaStaffNormal"
			EvLib.sum("EffectTeslaAoeIFF",@tmpTar.x,@tmpTar.y,{:user=>@tmpUser})
		elsif @tmpTar.summon_data && @tmpTar.summon_data[:TeslaCoil]
			EvLib.sum("EffectTeslaAoe",@tmpTar.x,@tmpTar.y,{:user=>@tmpUser})
		end
	end
	
	def testlaAoeLinkToUser #self.linkToUser
		tmpPattern = rand(3)
		self.drop_light
		@manual_pattern = tmpPattern
		@pattern = tmpPattern
		@opacity = 180+rand(75)
		@zoom_y = [self.report_rangeRound(@originUser)*0.5,0.2].max
		@angle = get_target_angle(@originUser.x,@originUser.y)
		SndLib.sound_TeslaHit(report_distance_to_vol_close-20)
		start if @summon_data[:target]==$game_player
	end
	
	
	def batch_JumpForward_and_UseSkill(skill=nil,user,target)
		return if [:death,:sex,:grabber,:grabbed,:stun].include?(user.actor.action_state)
		return if !target
		tmpExport = [user.x,user.y]
		self.moveto(user.x,user.y)
		case user.direction
			when 2 ; tmpTarX = 0 ; tmpTarY = 1
			when 8 ; tmpTarX = 0 ; tmpTarY = -1
			when 6 ; tmpTarX = 1 ; tmpTarY = 0
			when 4 ; tmpTarX = -1 ; tmpTarY = 0
		end
		if !user.is_follower_stand_mode? && user.passable?(tmpExport[0],tmpExport[1],user.direction)
			user.jump_to_low(user.x+tmpTarX,user.y+tmpTarY)
		else
			user.jump_to_low(user.x,user.y)
		end
		self.moveto(target.x,target.y)
		if skill
			user.actor.take_skill_cancel($data_arpgskills["BasicNormal"])
			user.actor.cancel_holding
			user.actor.launch_skill($data_arpgskills[skill])
		end
	end
	
	def batch_WaterFlowJumpCombo(user,target,tmpPeak=5) #NPC ONLY
		return if !target
		@mirror = [true,false].sample
		self.animation = self.animation_atk_SingleSpin
		item_jump_to(5)
		#combat_jump_to_target(user,target,tmpPeak=5)
		self.turn_toward_character(target)
		@npc.launch_skill($data_arpgskills["KatanaWaterflowDanceAOE_F0"],true)
	end
	
	def batch_katanaChargeGetJumpXY(chk_TGT_Passible=true,superThrough=false) #superThrough >> dont care a shit, just through
		user = @summon_data[:user]
		target = @summon_data[:target]
		target.actor.remove_stun_by_chance if target.actor.action_state == :stun
		return if [:death,:sex,:grabber,:grabbed,:stun].include?(user.actor.action_state)
		return if !target
		tmpExport = [user.x,user.y,1]
		self.moveto(user.x,user.y)
		case user.direction
			when 2 ; tmpTarX = 0 ; tmpTarY = 1
			when 8 ; tmpTarX = 0 ; tmpTarY = -1
			when 6 ; tmpTarX = 1 ; tmpTarY = 0
			when 4 ; tmpTarX = -1 ; tmpTarY = 0
		end
		if chk_TGT_Passible
			tgt_def_through = target.through
			target.through = true
			canPassTGT = user.passable?(tmpExport[0],tmpExport[1],user.direction)
			target.through = tgt_def_through
		else
			canPassTGT = true
		end
		return self.moveto(target.x,target.y) if !canPassTGT
		tmpExport[0] += tmpTarX
		tmpExport[1] += tmpTarY
		if !(user == $game_player && $game_map.get_touch_or_region_events_here(tmpExport[0],tmpExport[1]))
			tmpExport[0] = target.x if superThrough
			tmpExport[1] = target.y if superThrough
			return self.moveto(target.x,target.y) if !user.passable?(tmpExport[0],tmpExport[1],user.direction)
			tmpExport[0] += tmpTarX
			tmpExport[1] += tmpTarY
		end
		if !superThrough
			if [target.x,target.y] != [tmpExport[0],tmpExport[1]]
				target.actor.take_skill_effect(user.actor,$data_arpgskills["NpcThrowStun2"],can_sap=false,force_hit=false) if target.actor.action_state == :skill
				user.jump_to_low(tmpExport[0],tmpExport[1])
			end
		else
			user.moveto(tmpExport[0],tmpExport[1])
		end
		self.moveto(target.x,target.y)
	end
	
	def batch_katanaBlock
		user = @summon_data[:user]
		return if [:death,:sex,:grabber,:grabbed,:stun].include?(user.actor.action_state)
		SndLib.katana_end(report_distance_to_vol_close-20,25+rand(10)) if !@soundPlayed
		@soundPlayed = true
		if user.actor.holding_count > @summon_data[:skill].launch_max
			#user.actor.take_skill_cancel($data_arpgskills["BasicNormal"])
			user.actor.cancel_holding
			user.actor.launch_skill($data_arpgskills["KatanaControlCharge"])
			self.delete
		end
	end
	
	def shieldBlockStunCheck
		tmpIsPlayer = @summon_data[:user] == $game_player
		return if !@summon_data[:user]
		return if !@summon_data[:target]
		return if !tmpIsPlayer && @summon_data[:user].deleted?
		return if [:sex,:stun,:death].include?(@summon_data[:user].actor.action_state)
		return if self.report_range(@summon_data[:user]) != 1
		return if @summon_data[:user].actor.immune_state_effect
		return if !@summon_data[:target].actor.skill
		return if @summon_data[:target].actor.holding_count > 18 #超過18則無效
		@summon_data[:user].actor.take_skill_cancel($data_arpgskills["BasicNormal"])
		case @summon_data[:target].actor.skill.name
			when "KatanaControl"		;	@summon_data[:user].actor.launch_skill($data_arpgskills["ParryStunLong"],true)
			when "KatanaControlCharge"	;	@summon_data[:user].actor.launch_skill($data_arpgskills["ParryStunLong"],true)
			else						;	@summon_data[:user].actor.launch_skill($data_arpgskills["ParryStun"],true)
		end
	end
	
	def batch_PunchDoubleHit(user)
		return if [:death,:sex,:grabber,:grabbed,:stun].include?(user.actor.action_state)
		if user.actor.last_holding_count >= @summon_data[:skill].launch_max
			#set_npc("SkillDummy")
			#@npc.user_redirect=true
			#@npc.launch_skill($data_arpgskills["NpcThrowPunchHit"],true)
			user.actor.take_skill_cancel($data_arpgskills["BasicNormal"])
			#user.actor.launch_skill($data_arpgskills["BasicNormal"],true)
			user.actor.launch_skill($data_arpgskills["NpcBasicSh_Combo"],true)
		end
	end
	def batch_SlashDoubleHit(user,skill="NpcSlashSH_Combo")
		return if [:death,:sex,:grabber,:grabbed,:stun].include?(user.actor.action_state)
		if user.actor.last_holding_count >= @summon_data[:skill].launch_max
			#set_npc("SkillDummy")
			#@npc.user_redirect=true
			#@npc.launch_skill($data_arpgskills["NpcThrowSlashHit"],true)
			user.actor.take_skill_cancel($data_arpgskills["BasicNormal"])
			#user.actor.launch_skill($data_arpgskills["ShortSwordNormal"],true)
			user.actor.launch_skill($data_arpgskills[skill],true)
		end
	end
	
	def abomGrabSkillHoldEFX
		self.animation = nil
		user = @summon_data[:user]
		self.moveto(user.x,user.y)
		if [2,6].include?(user.direction)
			#EvLib.sum("EffectOverKillReverse",self.x-1,self.y)
			@angle = 60
			@mirror = false
			@forced_z = 2
			@forced_y = -8
			@forced_x = -12
		else
			#EvLib.sum("EffectOverKillReverse",self.x+1,self.y)
			@angle = 300
			@mirror = false
			@forced_z = 2
			@forced_y = -18
			@forced_x =0
		end
	end
	
	def abomGrabSkillTentclePullFX
		user = @summon_data[:user]
		self.moveto(user.x,user.y)
		case user.direction
			when 6
				@forced_z = 2
				@forced_y = -32
				@forced_x = -3
				if user.actor.last_holding_count >= @summon_data[:skill].launch_max
					@forced_y = -16
					@forced_x = 8
				end
			when 4
				@forced_z = 2
				@forced_y = -24
				@forced_x = 0
				if user.actor.last_holding_count >= @summon_data[:skill].launch_max
					@forced_y = -8
					@forced_x = -8
				end
			when 2
				@forced_z = 2
				@forced_y = -32
				@forced_x = 8
			when 8
				@forced_z = -2
				@forced_y = -32
				@forced_x = -8
		end
	end
	def batch_export_chargeXY(user=@summon_data[:user],range=4)
		tmpExport = [user.x,user.y,1]
		self.moveto(user.x,user.y)
		return tmpExport if !user.passable?(tmpExport[0],tmpExport[1],user.direction)
		case user.direction
			when 2 ; tmpTarX = 0 ; tmpTarY = 1
			when 8 ; tmpTarX = 0 ; tmpTarY = -1
			when 6 ; tmpTarX = 1 ; tmpTarY = 0
			when 4 ; tmpTarX = -1 ; tmpTarY = 0
		end
		range.times{
			break if !user.passable?(tmpExport[0],tmpExport[1],user.direction)
			tmpExport[0] += tmpTarX
			tmpExport[1] += tmpTarY
			tmpExport[2] += 1
			break if user == $game_player && $game_map.get_touch_or_region_events_here(tmpExport[0],tmpExport[1])
			#@tmpUserJumpRecord << tmpExport
		}
		tmpExport[2] = [tmpExport[2],4].min
		tmpExport
	end
	def abomGrabSkillGetJumpEfxXY
		user = @summon_data[:user]
		tmpExport = [user.x,user.y,1]
		self.moveto(user.x,user.y)
		return tmpExport if !self.passable?(tmpExport[0],tmpExport[1],user.direction)
		case user.direction
			when 2 ; tmpTarX = 0 ; tmpTarY = 1
			when 8 ; tmpTarX = 0 ; tmpTarY = -1
			when 6 ; tmpTarX = 1 ; tmpTarY = 0
			when 4 ; tmpTarX = -1 ; tmpTarY = 0
		end
		4.times{
				break if !user.passable?(tmpExport[0],tmpExport[1],user.direction)
				tmpExport[0] += tmpTarX
				tmpExport[1] += tmpTarY
				tmpExport[2] += 1
		}
		tmpExport[2] = [tmpExport[2],4].min
		tmpExport
	end
	
	
	
	def abomGrabSkillJumpCheck
		user = @summon_data[:user]
		
		if user.actor.last_holding_count >= @summon_data[:skill].launch_max
			@wait_count = 10
		else
			if user.x == @tmpTarX && user.y == @tmpTarY
				case user.direction
					when 4
						@forced_y += 16
						@forced_x -= 6
					when 6
						@mirror = true
						@forced_y += 20
						@forced_x += 6
				end
				@wait_count = 15
				return
			end
			@summon_data[:user].jump_to(@tmpTarX,@tmpTarY) 
			self.jump_to(@tmpTarX,@tmpTarY)
		end
	end 
	
	def batch_EffectAbomEatDed_init
		user = @summon_data[:user]
		tmpEventIsSummonByUser = false
		chkedNPC = $game_map.events_xy(user.x,user.y).select{|event|
			next if event == user
			next if event.deleted?
			next if !event.npc?
			next if event.actor.is_object
			next if event.actor.is_boss
			next if event.actor.race == "Undead"
			next if !event.actor.dedAnimPlayed
			tmpEventIsSummonByUser = event.summon_data && event.summon_data[:user] == user
			event
		}
		user.actor.add_state("MoralityDown30")
		if chkedNPC.empty?
			$game_map.popup(0,"QuickMsg:Lona/CannotWorks#{rand(2)}",0,0)
			SndLib.sys_buzzer
			return delete
		else
			@zoom_x = 1
			@zoom_y = 1
		end
		abomGrabSkillHoldEFX
		if !chkedNPC.empty?
			if user.actor.last_holding_count >= @summon_data[:skill].launch_max
				user.actor.remove_state_stack("AbomSickly") if user.actor.stat["AbomSickly"] >= 2 #Sickly
				user.actor.remove_state_stack("FeelsSick") #FeelsSick
				tmpTarHP  = chkedNPC[0].actor.battle_stat.get_stat("health",3) /4
				tmpTarSTA = chkedNPC[0].actor.battle_stat.get_stat("sta",3) /6
				bounsPointsToLona = tmpTarHP + tmpTarSTA
				if tmpEventIsSummonByUser
					$game_map.popup(0,"QuickMsg:Lona/Friendly",0,0)
				else
					user.actor.check_Abom_heal_HealthSta(bounsPointsToLona)
					tmpHowManyBall = bounsPointsToLona/50
					summonTimes = [tmpHowManyBall,6].min
					summonTimes.times{
					EvLib.sum(["WasteJumpBloodToPlayer","WasteJumpBloodToPlayer2"].sample,user.x,user.y)
					}
				end
				
			else
				tmpTarHP  = chkedNPC[0].actor.battle_stat.get_stat("health",3)
				tmpTarSTA = chkedNPC[0].actor.battle_stat.get_stat("sta",3)
				tmpTarATK  = chkedNPC[0].actor.battle_stat.get_stat("def",3)
				tmpTarDEF  = chkedNPC[0].actor.battle_stat.get_stat("atk",3)
				tmpTarSUR  = chkedNPC[0].actor.battle_stat.get_stat("survival",3)
				tmpData={
				:user=>user,
				:HP =>tmpTarHP ,
				:STA=>tmpTarSTA,
				:ATK=>tmpTarATK,
				:DEF=>tmpTarDEF,
				:SUR=>tmpTarSUR
				}
				EvLib.sum("ProjAbomSumTentacle",user.x,user.y,tmpData)
				tmpBakDir = user.direction
				user.combat_jump_reverse
				user.direction = tmpBakDir
			end
			EvLib.sum("EffectOverKillReverse",chkedNPC[0].x,chkedNPC[0].y)
			chkedNPC[0].effects=["ZoomOutDelete",0,false,nil,nil,[true,false].sample]
			if $game_player.actor.stat["BloodLust"] ==1 || $game_player.actor.stat["Cannibal"] == 1
				$game_player.actor.mood += 50
			else
				$game_player.actor.mood -= 10
			end
		end
		@opacity = 0
	end
	
	def setup_dungeon_ChestLoot(dateCHK=false,itemAMT=1,closed=2,opened=8)
		tmpDate = $story_stats["DungeonChest_#{$game_map.map_id}"]
		if $game_date.dateAmt > tmpDate || !dateCHK
			self.direction = closed #set graphics to close
			itemAMT.times{
				tmpItem=$game_map.interpreter.reward_item_to_storage
				$game_boxes.box(System_Settings::STORAGE_TEMP_MAP)[tmpItem] = 1
			}
		else
			self.direction = opened #set graphics to open
		end
	end
	
	
	def burningDot_WIS
		if @summon_data[:target].actor.action_state != :death && @temp_count % 10 == 0 ;
			@summon_data[:target].actor.take_skill_effect(@summon_data[:user].actor,$data_arpgskills["Buring_DOT_WIS"],can_sap=false,force_hit=true) ;
			SndLib.sound_flame(report_distance_to_vol_close) ; 
		end
	end
	def burningDot_SUR
		if @summon_data[:target].actor.action_state != :death && @temp_count % 10 == 0 ;
			@summon_data[:target].actor.take_skill_effect(@summon_data[:user].actor,$data_arpgskills["Buring_DOT_SUR"],can_sap=false,force_hit=true) ;
			SndLib.sound_flame(report_distance_to_vol_close) ; 
		end
	end
	
	
	def search_target_unit(user,target,balloon=20)
		usr = user# @summon_data[:user]
		tgt = target#@summon_data[:target]
		d_obj= tgt.actor.is_a?(Game_DestroyableObject)
		t_obj= tgt.actor.is_a?(GameTrap)
		tmpP = $game_player
		if tgt != tmpP && tgt.npc.master !=tmpP && !d_obj && !t_obj && tgt.actor.target.nil?
			tgt.call_balloon(2) if tgt.actor.anomally.nil?
			tgt.actor.anomally=Struct::FakeTarget.new(usr.x,usr.y) 
			tgt.actor.set_alert_level(1)
				if tgt.actor.battle_stat.get_stat("move_speed") <= 0
					tgt.turn_toward_xy(usr.x,usr.y) 
				end
				if tgt.actor.action_state.nil?
					tgt.actor.set_action_state(:none,true) 
				else
					tgt.actor.set_action_state(tgt.actor.action_state,true) 
				end
		elsif tgt!= $game_player && (d_obj || t_obj)
			tgt.call_balloon(balloon)
		end
	end
	

	def player_active_overkill_check
		#return if !$game_player.passable?(self.x,self.y, $game_player.direction)
		return @wait_count = 3 if @summon_data[:user].actor.last_attacker != $game_player
		return @wait_count = 3 if !@summon_data[:user].near_the_target?($game_player,2)
		return @wait_count = 3 if $game_player.actor.action_state != nil && $game_player.actor.action_state != :none
		return @wait_count = 3 if $game_player.animation != nil
		return @wait_count = 3 if !@temp_overkill
		return @wait_count = 3 if $game_player.xy_core_block?(self.x,self.y)
		if $game_player.actor.stat["BloodyMess"] == 1
			SndLib.playerOverKill
			$game_player.moveto(self.x,self.y)
			$game_player.animation = $game_player.animation_player_overkill(@summon_data[:user],$game_player)
		end
	end
	
	def batch_toilet_init(tmpDigged = [true,false].sample,unlimited=false)
		@summon_data={} if !@summon_data
		tmpDigged = tmpDigged
		tmpDigged = false if unlimited
		@summon_data[:UnlimitedWaste] = unlimited
		@summon_data[:DiggedWastePoo] = tmpDigged
		@summon_data[:DiggedWastePee] = tmpDigged
		tmpScat = $story_stats["Setup_ScatEffect"] == 1
		tmpScat ? @opacity = rand(100)+150 : @opacity = 0
		@opacity = 0 if tmpDigged
		@forced_z = -1
		turn_random
		@manual_pattern = rand(3)
	end
	
	def batch_player_set_trap
			user=@summon_data[:user]
			tmpShiftMode = Input.press?(:SHIFT)
			without_AnyExtItem = $game_player.actor.ext_items.any?{|extITEMS|
				next if !extITEMS.nil?
				true
			}
			
			temp_tar_item = $game_player.actor.ext_items
			temp_tar_item=temp_tar_item.select{|tar|  #若物品不是 KEY 以及 不是空的 則選之
				tar = $data_ItemName[tar]
				!tar.nil? && !tar.key_item? && $game_party.has_item?(tar, include_equip = false)
			}
			temp_tar_item = $data_ItemName[temp_tar_item.first]
			noitem = without_AnyExtItem
			p "batch_player_set_trap 0 #{temp_tar_item.item_name}" if temp_tar_item
			if !tmpShiftMode && temp_tar_item && $game_party.has_item?(temp_tar_item)
				temp_tar_item = temp_tar_item
			elsif $game_party.has_item?($data_ItemName["ItemRock"]) && noitem
				temp_tar_item = $data_ItemName["ItemRock"]
			elsif tmpShiftMode && $game_party.has_item?($data_ItemName["ItemRock"])
				temp_tar_item = $data_ItemName["ItemRock"]
			elsif (tmpShiftMode || !temp_tar_item) && !$game_party.has_item?($data_ItemName["ItemRock"])
				user.animation = user.animation_mc_pick_up
				SndLib.sound_equip_armor
				$game_party.gain_item($data_ItemName["ItemRock"],1)
				$game_map.popup(0,"#{1}",$data_ItemName["ItemRock"].icon_index,1)
				#$game_player.actor.ext_items[0] = $data_ItemName["ItemRock"] if noitem
				$game_player.actor.sta -= 1
				return self.delete
			end
			p "batch_player_set_trap 1 #{temp_tar_item.item_name}" if temp_tar_item
			
			
			@direction=user.direction
			if user.passable?(user.x,user.y,user.direction)
				case user.direction
					when 8;temp_x= 0; temp_y=-1
					when 2;temp_x= 0; temp_y=1
					when 4;temp_x=-1; temp_y=0
					when 6;temp_x= 1; temp_y=0
				end
				moveto(user.x+temp_x,user.y+temp_y)
			else
				self.delete
				return
			end
			return delete if without_AnyExtItem && !temp_tar_item
			return delete if batch_trap_same_xy_check
		if $game_player.actor.stat["TrapImprove"] == 1
			set_npc("Bomb_TriggerTrapStun")
		else
			set_npc("Bomb_TriggerTrap")
		end
		@npc.user_redirect=true
		item_dmg_amp = temp_tar_item.dmg_multiplier
		item_dmg = temp_tar_item.weight
		user_sur = $game_player.actor.survival
		final_atk = (user_sur*0.5)+((item_dmg*5)*item_dmg_amp)
		@npc.set_atk(final_atk)
		@npc.refresh
		
		$game_player.actor.sta -=2
		
		@summon_data[:ItemName] = [temp_tar_item.item_name]
		$game_map.popup(0,"#{$game_party.item_number(temp_tar_item)}-1",temp_tar_item.icon_index,-1) #moved to Skill event
		$game_party.lose_item(temp_tar_item,1)
		SndLib.sound_Reload(report_distance_to_vol_close)
		@forced_z = -5
		
		player_SetupTrap
	end
	
	def setup_ForceCHS(forceType=nil,forceI=nil)
		@charset_index = forceI
		set_char_type(forceType,nameAsType=false)
		create_chs_configuration(@charset_index)
	end
	
	def batch_cocona_setCHS(forceType=nil,forceI=nil,wipeEXT=true) #[type,index]
		$game_map.interpreter.chcg_init_cocona
		@manual_CHS_build = true
		if forceType && forceI
			@charset_index = forceI
			set_char_type(forceType,nameAsType=false)
		elsif $story_stats["RecQuestCocona"] >= 28
			@charset_index = 1
			set_char_type("-char-F-TEEN02",nameAsType=false)
		else
			@charset_index = 0
			set_char_type("-char-F-TEEN01",nameAsType=false)
		end
		#@manual_character_index = self.chs_definition.chs_default_index[@charset_index]
		#@character_index = @manual_character_index
		#msgbox self.chs_definition.chs_default_index[@charset_index]
		#@character_index = @manual_character_index.nil? ? chs_definition.chs_default_index[@charset_index] : @manual_character_index
		#@character_index = self.chs_definition.chs_default_index[@charset_index]
		create_chs_configuration(@charset_index)
		if wipeEXT
			@chs_configuration["ext4"] = "nil"
			@chs_configuration["ext3"] = "nil"
			@chs_configuration["ext2"] = "nil"
			@chs_configuration["ext1"] = "nil"
		end
		if $game_NPCLayerMain.stat["Cocona_Dress"] == "Nude"
			@chs_configuration["equip_top"] = "nil"
			@chs_configuration["mid"] = "nil"
			@chs_configuration["equip_bot"] = "nil"
		end
		if $game_NPCLayerMain.stat["Cocona_dirt"] != 0
			@chs_configuration["ext1"] = "FteenC_ext1_dirt_Cocona.png"
		end
		cumLVL = $game_NPCLayerMain.stat["Cocona_Effect_CumButtR"]+$game_NPCLayerMain.stat["Cocona_Effect_CumButtL"]+$game_NPCLayerMain.stat["Cocona_Effect_CreamPie"]
		if cumLVL >= 3
			@chs_configuration["ext3"] = "FteenC_ext4_cums2.png"
		elsif cumLVL >= 1
			@chs_configuration["ext2"] = "FteenC_ext4_cums1.png"
		end
	end
	
	def batch_cocona_setHstats
		if $game_NPCLayerMain.stat["Cocona_Dress"] == "Nude"
			actor.stat.set_stat_m("weak",actor.battle_stat.get_stat("weak")+30,[0,2,3])
		end
		if $game_NPCLayerMain.stat["Cocona_Effect_CumButtR"] == 1
			actor.stat.set_stat_m("weak",actor.battle_stat.get_stat("weak")+20,[0,2,3])
		end
		if $game_NPCLayerMain.stat["Cocona_Effect_CumButtL"] == 1
			actor.stat.set_stat_m("weak",actor.battle_stat.get_stat("weak")+20,[0,2,3])
		end
		if $game_NPCLayerMain.stat["Cocona_Effect_CreamPie"] == 1
			@npc.set_atk(1)
			@npc.set_def(3)
			actor.stat.set_stat_m("weak",actor.battle_stat.get_stat("weak")+20,[0,2,3])
		end
	end
	
	def batch_cocona_setStats
		#$game_map.interpreter.chcg_init_cocona
		if $story_stats["RecQuestCoconaVagTaken"] >= 2
			actor.stat.set_stat_m("weak",32,[0,2,3])
		end
		if $story_stats["RecQuestCocona"].between?(17,20)
			actor.add_fated_enemy([13])
			if $story_stats["RecQuestCoconaVagTaken"] >= 2
				actor.stat.set_stat_m("sta",5,[0])
			end
		end
		tmpGPS = $game_NPCLayerMain.stat
		if tmpGPS["Cocona_DidWhoreJob"] && tmpGPS["Cocona_Hsta"]
			actor.set_sta(tmpGPS["Cocona_Hsta"])
		end
		if tmpGPS["Cocona_DidWhoreJob"] && tmpGPS["Cocona_Hhealth"]
			actor.set_health(tmpGPS["Cocona_Hhealth"])
		end
		if tmpGPS["Cocona_GroinDamaged"]
			tmpGPS["Cocona_GroinDamaged"].times{actor.add_state(13)}
		end
		batch_cocona_setCHS
		batch_cocona_setHstats
	end
	
	def batch_trap_same_xy_check
		$game_map.events_xy(self.x,self.y).any?{|event|
			next if event == self
			next if !event.npc?
			next if event.npc.action_state == :death
			next if event.npc.npc_name == "SkillDummy" && event.through
			SndLib.sys_buzzer
			true
		}
	end
	
	def batch_get_side_dir_to_a_tgt(tgt)
		getDIR = turn_toward_character_get_dir(tgt)
		case getDIR
			when 2,8
				tarDIR = [4,6]
			when 4,6
				tarDIR = [2,8]
			else
				tarDIR = []
		end
		until tarDIR.empty?
			goDIR = tarDIR.shift
			if self.passable?(self.x,self.y,goDIR)
				return goDIR
			end
		end
		return getDIR
	end
	def batch_NPC_side_dodge(tgt)
		self.set_dodge(25)
		self.direction = self.batch_get_side_dir_to_a_tgt(tgt)
		x2=$game_map.round_x_with_direction(self.x,self.direction)
		y2=$game_map.round_y_with_direction(self.y,self.direction)
		#self.jump_to_low(x2,y2)
		self.movetoRolling(x2,y2)
		self.turn_toward_character(tgt)
		self.animation = self.animation_dodge
	end
	def batch_NPC_forward_dodge(tgt)
		self.set_dodge(25)
		self.turn_toward_character(tgt)
		combat_move_forward(self)
		self.animation = self.animation_dodge
	end
	
	
	
	
	
	def batch_MetorStrike_route0
		self.move_speed=6.5
		self.animation = nil
		@direction = 2
		SndLib.sound_HeavyStep(report_distance_to_vol_close+20,80)
		self.through = true
		self.actor.immune_damage = true
		if self.actor.shieldEV && self.actor.shieldEV.actor
			self.actor.shieldEV.actor.immune_damage = true
		end
	end
	
	def batch_MetorStrike_route1
		self.move_speed=6.5
		@opacity = 0
		if !@summon_data[:SkillMarkedTGT]
			self.moveto(summon_data[:SkillMarkedTGT_X],summon_data[:SkillMarkedTGT_Y]-12)
		else
			self.moveto(summon_data[:SkillMarkedTGT].x,summon_data[:SkillMarkedTGT].y-12)
		end
	end
	
	def batch_MetorStrike_route2
		self.move_speed=6.5
		# no tgt mode,   for mind control
		if !@summon_data[:SkillMarkedTGT]
			if self.x != @summon_data[:SkillMarkedTGT_X] || self.y != @summon_data[:SkillMarkedTGT_Y]-12
				turn_toward_xy(@summon_data[:SkillMarkedTGT_X],@summon_data[:SkillMarkedTGT_Y]-12)
				move_straight_force(self.direction)
				@direction = 2
			else
				@wait_count = 3
			end
		else #with a target,
			self.moveto(@summon_data[:SkillMarkedTGT].x,@summon_data[:SkillMarkedTGT].y-12)
			turn_toward_xy(@summon_data[:SkillMarkedTGT].x,@summon_data[:SkillMarkedTGT].y-12)
		end
	end
	def batch_MetorStrike_route3
		self.move_speed=6.5
		self.through = false
		@forced_y =0
		@opacity = 255
		self.jump_to_low(self.x,self.y+12)
	end
	def batch_MetorStrike_route4
		self.move_speed=6.5
		self.animation = @summon_data[:MeteorStrikeAniDataPrepair]
		self.actor.immune_damage = false
		if self.actor.shieldEV && self.actor.shieldEV.actor
			self.actor.shieldEV.actor.immune_damage = false
		end
		self.actor.launch_skill($data_arpgskills["MetorStrikeStompCoreF0"],true)
		#self.actor.launch_skill($data_arpgskills["MetorStrikeStompF0"],true)
		SndLib.sound_HeavyStep(report_distance_to_vol_close+30,50)
		$game_map.interpreter.screen.start_shake((report_distance_to_vol_close*0.1).to_i,3+(report_distance_to_vol_close*0.1).to_i,8)
		@wait_count = 1
	end
	def batch_MetorStrike_route5
		self.actor.launch_skill($data_arpgskills["MetorStrikeStompF0"],true)
	end
	def batch_character_common_death
		return if @summon_data[:user].deleted?
		user = @summon_data[:user]
		EvLib.sum("EffectRefugeeCharDed",1,1,{:user=>user})
		tmpLA = @summon_data[:user].actor.last_attacker
		tmpMA = @summon_data[:user].actor.master
		if tmpLA && tmpMA && tmpMA != tmpLA
			if !tmpLA.actor.friendly?(tmpMA)
				tmpLA.actor.set_aggro(tmpMA.actor,$data_arpgskills["BasicNormal"],300)
			end
		end
	end
	def batch_EffectMCBasicDeepone
		user=@summon_data[:user]
		@direction=user.direction
		moveto(user.x,user.y)
		EvLib.sum("EffectOverKill",self.x,self.y)
		$game_player.jump_to(self.x,self.y)
		if $game_player.actor.stat["RaceRecord"] == "PreDeepone"
			$game_player.actor.healCums("CumsHead",3000)
			$game_player.actor.healCums("CumsTop",3000)
			$game_player.actor.healCums("CumsMid",3000)
			$game_player.actor.healCums("CumsBot",3000)
			$game_player.actor.healCums("CumsMouth",3000)
			$game_player.actor.reBirthSetRace("TrueDeepone")
			$game_player.actor.remove_state("Dizzy")
			$game_player.actor.dirt = 0
			#update Immune STD Basic
			$game_player.actor.immune_tgt_states = $game_player.actor.original_immune_tgt_states.clone
			$data_StateName.each{|name,state|
				next unless state
				next unless state.item_name
				next unless state.type == "STD_Basic"
				$game_player.actor.immune_tgt_states << name
			}
			#remove STD Basic
			reciverStates = $game_player.actor.feature_objects.uniq
			reciverStates.each{|basedState|
				next unless basedState
				next unless basedState.is_a?(RPG::State)
				next unless basedState.item_name
				next unless basedState.type == "STD_Basic"
				$game_player.actor.remove_state(basedState.item_name)
			}

			GabeSDK.getAchievement("TrueDeepone")
		elsif $game_player.actor.stat["RaceRecord"] == "TrueDeepone"
			$game_player.actor.sta -= 50
			$game_player.actor.reBirthSetRace("Deepone")
			$game_player.actor.setup_state("DizzyDeepone",6)
			$game_damage_popups.add($data_StateName["DizzyDeepone"].icon_index, $game_player.x, $game_player.y,[4,6].sample,4,rand(100)+1)
			#$game_player.actor.force_stun("Stun1")
			$game_player.call_balloon(13)
			#$game_player.actor.setup_state("StomachSpasm",3) #StomachSpasm
			#$game_player.actor.setup_state("FeelsSick",3) #FeelsSick
			$game_player.actor.dirt = 0
			$game_player.actor.immune_tgt_states = $game_player.actor.original_immune_tgt_states.clone
		end
		$game_map.interpreter.combat_remove_random_equip(2)
		$game_map.interpreter.combat_remove_random_equip(3)
		$game_map.interpreter.combat_remove_random_equip(4)
		$game_map.interpreter.combat_remove_random_equip(5)
		$game_map.interpreter.combat_remove_random_equip(6)
		$game_map.interpreter.combat_remove_random_equip(7)
		$game_map.interpreter.combat_remove_random_equip(8)
		$game_player.apply_color_palette
		return
	end
	def batch_EffectLonaGrabHit
		if $game_player.actor.action_state != :grabber
			f_target = @summon_data[:target]
			target = $game_map.npcs.select{|ev|
				next if ev.actor.is_object
				next if ev.actor.is_a?(Game_PorjectileCharacter)
				next if ev.actor.is_a?(Game_DestroyableObject)
				next if ev.actor.is_a?(GameTrap)
				next if ev.actor.action_state == :death

				#ignore if unit cant be a fucker
				next unless ev.chs_definition
				next unless ev.chs_definition.supported_fucker
				next unless ev.chs_definition.supported_fucker.any?{|pose|
					next if pose == [0]
					true
				}
				ev.pos?(f_target.x,f_target.y)
			}.sample
			if !target.nil? && target.grab($game_player,false)
				$game_player.actor.holding_efx=self
				$game_player.actor.set_action_state(:grabber)
				$game_player.actor.fucker_target=@summon_data[:target]
				target.actor.fucker_target=$game_player
				$game_player.add_sex_gang(target)
				$game_player.setup_lona_grabber
				$game_player.call_balloon(3)
				target.actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],600,true)
				moveto(target.x,target.y)
			end
		end
		self.delete
	end
	
	def batch_EffectMissileMindControlHit
		failed = false
		tmpTGT=@summon_data[:target]
		timeLimit = 600+($game_player.actor.wisdom*50)
		timeLimit *= 2 if tmpTGT.actor.master == $game_player
		tmpAGGRO = tmpTGT.actor.master != $game_player
		failed = true if tmpTGT == $game_player
		failed = true if $game_player.actor.master#return if player already in control mode
		failed = true if !tmpTGT.npc?
		failed = true if tmpTGT.actor.npc_dead?
		failed = true if tmpTGT.actor.race == "Undead"
		failed = true if tmpTGT.actor.race == "Abomination"
		failed = true if tmpTGT.actor.race == "Others"
		failed = true if tmpTGT.actor.race == "Animal"
		failed = true if tmpTGT.actor.is_object
		failed = true if tmpTGT.actor.is_boss
		failed = true if tmpTGT.actor.is_tiny
		failed = true if tmpTGT.actor.is_small
		failed = true if tmpTGT.actor.is_flyer
		failed = true if tmpTGT.actor.immune_state_effect
		failed = true if tmpTGT.actor.immune_damage
		failed = true if ![nil,:none].include?(tmpTGT.actor.action_state)
		#failed = true if tmpTGT.actor.target
		failed = true if !tmpTGT.actor.ai_state == :none
		failed = true if tmpTGT.combo_original_move_route
		if failed
			tmpTGT.call_balloon(7)
			return SndLib.sys_buzzer
		end
		
		moveto(tmpTGT.x,tmpTGT.y)
		tmpTGT.actor.player_control_mode(on_off=true,canUseSkill=true,withModeCancel=true,withTimer=timeLimit,stunWhenCancel=true,aggroWhenCancel=tmpAGGRO)
		EvLib.sum("EffectHeartFade",tmpTGT.x,tmpTGT.y)
	end
	
	def batch_overmap_FakeLona
		#self.stackWithTarget($game_player)
		moveto($game_player.x,$game_player.y);
		tmpD_Max = System_Settings::GAME_DIR_INPUT_DELAY_DASH;
		$game_player.dirInputCount = tmpD_Max if tmpD_Max > $game_player.dirInputCount;
		if (Input.press?(:SHIFT) || $game_player.actor.weight_immobilized?)
			self.call_balloon(6,-1) if self.balloon_id != 6
		else
			self.balloon_id = 0
		end
	end
	def batch_EffectMCSetPot
		user=@summon_data[:user]
		@direction=user.direction
		moveto(user.x,user.y)
		case user.direction
			when 8;temp_x= 0; temp_y=-1
			when 2;temp_x= 0; temp_y=1
			when 4;temp_x=-1; temp_y=0
			when 6;temp_x= 1; temp_y=0
		end
		tmpDeletePrevPot = nil
		$game_map.events.select{|id,event|
			next if !event.summon_data
			next unless event.summon_data[:PlayerPot]
			tmpDeletePrevPot = event
		}
		if !user.passable?(user.x,user.y,user.direction)
			SndLib.sys_buzzer
			$game_map.popup(0,"QuickMsg:Lona/CannotPlaceHere#{rand(2)}",0,0)
			return self.delete
		elsif !$game_party.has_item?($data_ItemName["ItemMhWoodenClub"])
			SndLib.sys_buzzer
			$game_map.popup(0,"QuickMsg:Lona/OutResources#{rand(2)}",0,0)
			return self.delete
		elsif $game_map.water_floor?(user.x+temp_x,user.y+temp_y)
			SndLib.sys_buzzer
			$game_map.popup(0,"QuickMsg:Lona/WrongPlace#{rand(2)}",0,0)
			return self.delete
		elsif $game_map.bush?(user.x+temp_x,user.y+temp_y)
			SndLib.sys_buzzer
			$game_map.popup(0,"QuickMsg:Lona/WrongPlace#{rand(2)}",0,0)
			return self.delete
		end
		tmpDeletePrevPot.trigger = -1 if tmpDeletePrevPot
		tmpDeletePrevPot.effects=["ZoomOutDeleteFast",0,true] if tmpDeletePrevPot
		$game_map.interpreter.optain_lose_item($data_ItemName["ItemMhWoodenClub"],1)
		$game_player.actor.sta -= 3
		moveto(user.x+temp_x,user.y+temp_y)
		@summon_data[:PlayerWormGuard] = true
		SndLib.WoodenBuild(80)
		data = {
			:PlayerPot => true
			}
		EvLib.sum("PlayerPot",self.x,self.y,data)
		self.delete
	end
	
	def batch_EffectDodge
		user=@summon_data[:user]
		skill=@summon_data[:skill]
		if user == $game_player
			tmpDodgeFrame = user.actor.dodge_frame
		else
			tmpDodgeFrame = [skill.hit_frame,5].max
		end
		user.set_dodge(skill.hit_frame)
		combat_move_forward(user) if tmpDodgeFrame >= System_Settings::Gameplay::DODGE_2_TITLE_REQ
		SndLib.sound_step(report_distance_to_vol_close)
		self.delete
	end
	
	def batch_Projectile_Item_BombShockTimer
		user = @summon_data[:user]
		SndLib.sound_AcidBurn(80,30)
		SndLib.sound_TrapTrigger(80)
		$game_map.interpreter.flash_screen(Color.new(255,255,255,40),20,false)
		$game_map.reserve_summon_event("EfxSmokeStand",user.x,user.y)
		$game_map.reserve_summon_event("EfxSmokeJump" ,user.x,user.y)
		$game_map.reserve_summon_event("EfxSmokeJump" ,user.x,user.y)
		$game_map.reserve_summon_event("EfxSmokeJump" ,user.x,user.y)
		$game_map.npcs.each{|event|
			next if event.deleted?
			next unless event.npc.target == user
			event.npc.targetLock_HP = 1
		}
		user.actor.take_skill_cancel($data_arpgskills["BasicNormal"])
		user.animation = user.animation_atk_sh
		user.move_sneak if user.can_sneak? 
		self.delete
	end
	
	#@summon_data[:user].turn_toward_character(@summon_data[:user].actor.target) if @summon_data[:user].actor.target
	def batch_route_EffectFishFistMasterHeavyPunch
		user = @summon_data[:user]
		target = user.actor.target
		#target = $game_player
		if !user.moving? && !target.nil?# && user.report_range(target) > 0
			SndLib.sound_punch_heavy(user.report_distance_to_vol_close,60)
			tmpCHKnum = 1
			xCHK = [4,6].include?(user.direction)
			yCHK = [8,2].include?(user.direction)
			tmpCHK_X = (user.x - target.x).abs
			tmpCHK_Y = (user.y - target.y).abs
			
			tmpCHKnum = tmpCHK_X if xCHK
			tmpCHKnum = tmpCHK_Y if yCHK
			tmpJustDoIT = user.summon_data[:HeavyPunchStart] || (tmpCHK_X == 0 && tmpCHK_Y == 0)
			if tmpCHKnum >= 1 || tmpJustDoIT
				user.move_speed = 7
				if target.actor.dodged && user.report_range(target) == 1
					user.move_forward_force
				else
					user.move_forward
				end
			end
			user.summon_data[:HeavyPunchStart] = false
		elsif !target
			SndLib.sound_punch_heavy(user.report_distance_to_vol_close,60)
			user.move_speed = 7
			user.move_forward 
		end
	end
	#BroadSwordNormalT2
	def batch_FishFistMasterTatsumakiHold(hkMODE=false)
		return self.delete if @summon_data[:user].actor.action_state != :skill
		return self.delete if @summon_data[:user].actor.skill.nil?
		return self.delete if !["FishFistMasterTatsumakiHold","FishFistMasterTatsumakiHkHold"].include?(@summon_data[:user].actor.skill.name)
		user = @summon_data[:user]
		SndLib.sound_stable_woosh(report_distance_to_vol_close+10,120+rand(10))
		@tmpEfxRound += 1
		#user.turn_random
		if @tmpEfxRound >= 4
			@tmpEfxRound = 0
			self.actor.launch_skill($data_arpgskills["FishFistMasterTatsumakiT2"],true)
		end
		#user.through = true
		if hkMODE && !user.moving?
			user.direction = @summon_data[:b4KickDir]
			EvLib.sum("UniqueFishkindFistMaster_Shadow",user.x,user.y,{:user=>user}) if hkMODE
			user.move_speed = 5
			user.move_forward
			if !user.move_succeed
				user.turn_reverse
				user.move_forward
				@summon_data[:b4KickDir] = user.direction
			end
		elsif user.npc.target != nil && !user.moving? && user.npc.player_control_mode_switch
			user.turn_toward_character(user.npc.target)
			user.move_toward_TargetDumbAI(user.npc.target)
		elsif !user.moving? && user.npc.player_control_mode_switch
			user.move_by_input(ignoreAnimation=true,ignoreInputDelay=true)
		end
		#user.through = false
		self.stackWithTarget(user)
	end
	def batch_FishFistMasterShadowDash(facingDir=@summon_data[:ShadowDashFacingDir],moveDir=@summon_data[:ShadowDashMoveDir])
		user = @summon_data[:user]
		@summon_data[:ShadowDashMoveDir] = user.direction if !@summon_data[:ShadowDashMoveDir]
		@summon_data[:ShadowDashFacingDir] =  user.direction if !@summon_data[:ShadowDashFacingDir]
		tmpPrevDIR = user.direction
		if !user.moving?
			user.move_speed = 6
			EvLib.sum("UniqueFishkindFistMaster_Shadow",user.x,user.y,{:user=>user})
			user.through = true
			user.flying = true
			user.missile = true
			if !user.move_succeed
				user.turn_reverse
				user.move_forward
				@summon_data[:ShadowDashMoveDir] = user.direction
			elsif !user.moving? && user.npc.player_control_mode_switch && !@summon_data[:MindControlDir]
				user.move_by_input(ignoreAnimation=true,ignoreInputDelay=true)
				@summon_data[:ShadowDashMoveDir] = user.direction
				@summon_data[:MindControlDir] = user.direction
			else
				user.direction = @summon_data[:ShadowDashMoveDir]
				user.move_forward
			end
			user.direction = @summon_data[:ShadowDashFacingDir]
			user.through = false
			user.flying = false
			user.missile = false
			self.stackWithTarget(user)
		end
		user.direction = tmpPrevDIR
	end
	def batch_ProjectileFishFistMasterTatsumakiTornadoT1
		@currentSkChkFrame = 0 if !@currentSkChkFrame
		@currentSkRecFrame = 0 if !@currentSkRecFrame
		@currentSkChkFrame = (@delete_frame - actor.delete_when_frame).abs 
		@move_speed = 5
		self.move_forward
		if (@currentSkChkFrame - @currentSkRecFrame >= 20) || move_succeed
			@currentSkRecFrame = @currentSkChkFrame
			$game_damage_popups.add(rand(12)+1,self.x, self.y,2,7)
			actor.launch_skill($data_arpgskills["FishFistMasterTrapTornado"],true)
			self.animation = self.animation_tornado if self.animation.nil?
			SndLib.sound_WaterRiver(report_distance_to_vol_close-30)
		end
	end
	def batch_ProjectileFishFistMasterTatsumakiTornadoT2
		@currentSkChkFrame = 0 if !@currentSkChkFrame
		@currentSkRecFrame = 0 if !@currentSkRecFrame
		@currentSkChkFrame = (@delete_frame - actor.delete_when_frame).abs 
		user = @summon_data[:user]
		tgt = user.actor.target
		@move_speed = 4
		if tgt
			self.move_toward_character(tgt)
		else
			self.move_random
		end
		if (@currentSkChkFrame - @currentSkRecFrame >= 20) || move_succeed
			@currentSkRecFrame = @currentSkChkFrame
			$game_damage_popups.add(rand(12)+1,self.x, self.y,2,7)
			SndLib.sound_WaterRiver(report_distance_to_vol_close-30)
			actor.launch_skill($data_arpgskills["FishFistMasterTrapTornado"],true)
			self.animation = self.animation_tornado if self.animation.nil?
		end
	end
	def batch_FishFistMasterWaterDash(facingDir=@summon_data[:ShadowDashFacingDir],moveDir=@summon_data[:ShadowDashMoveDir],skill="water")
		user = @summon_data[:user]
		@summon_data[:ShadowDashMoveDir] = user.direction if !@summon_data[:ShadowDashMoveDir]
		@summon_data[:ShadowDashFacingDir] =  user.direction if !@summon_data[:ShadowDashFacingDir]
		tmpPrevDIR = user.direction
		batch_FishFistMasterWaterDash_Attack(user,skill)
		if !user.moving?
			user.move_speed = 4.5
			EvLib.sum("UniqueFishkindFistMaster_Shadow",user.x,user.y,{:user=>user})
			if !user.move_succeed
				user.turn_reverse
				user.move_forward
				@summon_data[:ShadowDashMoveDir] = user.direction
			elsif !user.moving? && user.npc.player_control_mode_switch && !@summon_data[:MindControlDir]
				user.move_by_input(ignoreAnimation=true,ignoreInputDelay=true)
				@summon_data[:ShadowDashMoveDir] = user.direction
				@summon_data[:MindControlDir] = user.direction
			else
				user.direction = @summon_data[:ShadowDashMoveDir]
				user.move_forward
			end
			user.direction = @summon_data[:ShadowDashFacingDir]
			self.stackWithTarget(user)
		end
		user.direction = tmpPrevDIR
	end
	def batch_FishFistMasterWaterDash_Attack(user,skill)
		@aniChoose = 0 if !@aniChoose
		@aniChoose += 1
		dirOffset = user.direction_offset
		if @aniChoose % 2  == 0
			ani =	[[7,4+dirOffset,1,0,0],[6,4+dirOffset,10,0,0]]
		else
			ani =	[[7,4+dirOffset,1,0,0],[8,4+dirOffset,10,0,0]]
		end
		user.animation = user.aniCustom(ani,-1)
		if skill == "thunder"
			tgt = user.actor.target
			if !tgt
				case user.direction
					when 4; data = {:user=>user,:tgt_x=>self.x-5+ (-1+rand(3)),:tgt_y=>self.y}
					when 6; data = {:user=>user,:tgt_x=>self.x+5+ (-1+rand(3)),:tgt_y=>self.y}
					when 2; data = {:user=>user,:tgt_x=>self.x,:tgt_y=>self.y+5+ (-1+rand(3))}
					else;   data = {:user=>user,:tgt_x=>self.x,:tgt_y=>self.y-5+ (-1+rand(3))}
				end
			else
				data = {
					:user=>user,
					:tgt_x=>tgt.x,
					:tgt_y=>tgt.y
				}
			end
			EvLib.sum("EfxFishFistMasterMassEle",self.x,self.y,data)
		elsif skill == "water"
			case user.direction
				when 2; fakeTGT = Struct::FakeTarget.new(@x,@y+$game_map.height);
				when 4; fakeTGT = Struct::FakeTarget.new(@x-$game_map.width,@y);
				when 6; fakeTGT = Struct::FakeTarget.new(@x+$game_map.width,@y);
				else; fakeTGT = Struct::FakeTarget.new(@x,@y-$game_map.height);
			end
			data = {
				:skill =>$data_arpgskills["WaterStaffNormal"],
				:user=>user,
				:target=>fakeTGT#user.actor.target
			}
			SndLib.sound_WaterShot(user.report_distance_to_vol_close-10)
			SndLib.sound_WaterSpla(user.report_distance_to_vol_close-30)
			$game_damage_popups.add(rand(12)+1,user.x, user.y,2,7)
			$game_damage_popups.add(rand(12)+1,user.x, user.y,2,7)
			$game_damage_popups.add(rand(12)+1,user.x, user.y,2,7)
			EvLib.sum("EffecFishFistMasterWaterBolt",user.x,user.y,data)
		end
	end
	def batch_EfxFishFistMasterMassEle
		SndLib.sound_TeslaHit(report_distance_to_vol_close-20)
		give_light("cyan")
		3.times{$game_damage_popups.add(rand(12)+1,self.x, self.y,2,8)}
	end
	def batch_WarBossRoom_Hp3DedPiller0
		set_npc("NeutralHp1Sandbag")
		@npc.death_event = "EffectDedEval"
		@npc.delete_when_death = -1
		@npc.is_tiny = true
		@npc.set_atk(100)
		@summon_data = {:hp=>3} if !@summon_data
		@forced_y = -6
		chi= @character_index
		@summon_data[:death_event] = '
			tgtArpgSkill = ["MetorStrikeStompCoreF0","MetorStrikeStompF0"]
			tmpLastAttacker = @summon_data[:user].actor.last_attacker
			tmpLastHitSkill =  @summon_data[:user].npc.last_hit_by_skill
			return if tmpLastAttacker.deleted?
			tmpRangeLA = @summon_data[:user].report_range(tmpLastAttacker)
			@summon_data[:user].set_npc("NeutralHp1Sandbag")
			@summon_data[:user].npc.death_event = "EffectDedEval"
			@summon_data[:user].npc.delete_when_death = -1
			@summon_data[:user].npc.is_tiny = true
			@summon_data[:user].npc.set_atk(100)
			@summon_data[:user].forced_y = -6
			@summon_data[:user].forced_x = 0
			EvLib.sum("EffectOverKill",self.x,self.y) if @summon_data[:user].pattern !=1
			@summon_data[:user].character_index = #{chi}
			@summon_data[:user].direction = 2
			@summon_data[:user].pattern = 1
			if tmpLastAttacker.actor.is_a?(Npc_UniqueOrkindWarBoss) && tmpRangeLA == 0
				if tmpLastHitSkill && tgtArpgSkill.include?(tmpLastHitSkill.name)
					@summon_data[:user].summon_data[:hp] -= 1
					tmpLastAttacker.actor.applyButtHurt(@summon_data[:user].actor)
					@summon_data[:user].delete if @summon_data[:user].summon_data[:hp] <= 0
				end
			end
		'
	end
	def batch_WaterBallMissileProjectileMid_init
		user=@summon_data[:user]
		set_npc("MissileWaterBallMid")
		@direction = user.direction
		@npc.set_target(@summon_data[:target])
		@npc.set_projectile_start(user.x,user.y)
		@npc.set_projectil_prop(@summon_data[:skill])
		@npc.set_fraction(user.actor.fraction)
		@npc.set_wisdom(user.actor.battle_stat.get_stat("wisdom"))
		moveto(user.x,user.y)
		@missile=true
		@npc.user_redirect=true
	end
	def batch_WaterBallMissileProjectileCharge_init
		user=@summon_data[:user]
		@direction = user.direction
		if user.actor.last_holding_count >= @summon_data[:skill].launch_max
			set_npc("MissileWaterBallFul")
			@npc.set_projectil_prop($data_arpgskills["MissileWaterBallFul"])
			user.actor.sta -= 3
			@zoom_x = 1
			@zoom_y = 1
		elsif user.actor.last_holding_count >= @summon_data[:skill].launch_max/2
			set_npc("MissileWaterBallMid")
			@npc.set_projectil_prop($data_arpgskills["MissileWaterBallMid"])
			user.actor.sta -= 2
			@zoom_x = 1
			[4,6].include?(@direction) ? @zoom_y = 0.7 : @zoom_x = 0.7
			@forced_y = -6
		else
			set_npc("MissileWaterBallLow")
			@npc.set_projectil_prop($data_arpgskills["MissileWaterBallLow"])
			@zoom_x = 1
			[4,6].include?(@direction) ? @zoom_y = 0.5 : @zoom_x = 0.5
			@forced_y = -12
		end
		@npc.set_target(@summon_data[:target])
		@npc.set_projectile_start(user.x,user.y)
		@npc.set_fraction(user.actor.fraction)
		@npc.set_wisdom(user.actor.battle_stat.get_stat("wisdom"))
		moveto(user.x,user.y)
		@missile=true
		@npc.user_redirect=true
	end
	def batch_FireBallMissileProjectileCharge_init
		user=@summon_data[:user]
		if user.actor.last_holding_count >= @summon_data[:skill].launch_max
			EvLib.sum("EffectCastingFireBall",user.x,user.y,{:user=>user})
			set_npc("MissileFireBallCharge")
			@direction = user.direction
			@npc.set_target(@summon_data[:target])
			@npc.set_projectile_start(user.x,user.y)
			@npc.set_projectil_prop(@summon_data[:skill])
			@npc.set_fraction(user.actor.fraction)
			@npc.set_wisdom(user.actor.battle_stat.get_stat("wisdom"))
			@zoom_x = 0.5
			@zoom_y = 0.5
			@effects=["XYzoomIn",0,false]
			if user.efx_passable?(user.x,user.y,user.direction)
				case user.direction
				when 8;temp_x= 0; temp_y=-1
				when 2;temp_x= 0; temp_y=1
				when 4;temp_x=-1; temp_y=0
				when 6;temp_x= 1; temp_y=0
				end
				moveto(user.x+temp_x,user.y+temp_y)
			else
				moveto(user.x,user.y)
			end
			@missile=true
			@npc.user_redirect=true
			give_light("lantern")
		else
			EvLib.sum("FireBallChargeLowProjectile",user.x,user.y,{:user=>user})
			self.delete
		end
	end
	def batch_FireBallChargeLowProjectile_init
		user=@summon_data[:user]
		user.turn_toward_character(user.actor.target) if user.npc? && user.actor.target
		case user.direction
			when 8;temp_x= 0; temp_y=-1; @forced_z = -2  ; @forced_y = -20
			when 2;temp_x= 0; temp_y=1 ; @forced_z =  2  ; @forced_y =  -8
			when 4;temp_x=-1; temp_y=0 ; @forced_z =  2  ; @forced_y = -18 ;
			when 6;temp_x= 1; temp_y=0 ; @forced_z =  2  ; @forced_y = -18 ;
		end
		#moveto(user.x+temp_x,user.y+temp_y)
		moveto(user.x,user.y)
		#@missile=true
		@direction = @manual_direction = user.direction
		@angle = get_direction_angle(self.direction)
		$game_damage_popups.add(rand(12)+1,self.x, self.y,2,8)
		$game_damage_popups.add(rand(12)+1,self.x, self.y,2,8)
		$game_damage_popups.add(rand(12)+1,self.x, self.y,2,8)
		SndLib.sound_GunShotgun(report_distance_to_vol_far)
		self.animation = self.animation_KaBom3
		self.animation.loops = 0
		give_light("big_torch")
		set_npc("SkillDummy")
		@npc.user_redirect = true
		@npc.set_wisdom(user.actor.battle_stat.get_stat("wisdom"))
		@npc.launch_skill($data_arpgskills["FireStaffNormalShotgunF0"],true)
		return if [:sex,:grabbed].include?(user.actor.action_state)
		user.actor.sta -= 1 if user == $game_player
		user.set_dodge(15)
		tmpDir = user.direction
		user.combat_jumpback(user)
		user.direction = tmpDir
		user.animation = user.animation_atk_mh_reverse
	end
	def batch_EffectWaterPressureHit_init
		@opacity = 0
		target=@summon_data[:target]
		moveto(target.x,target.y)
		hit_effect_aggro_redirect
		user=@summon_data[:user]
		combat_knockback(user,target)
		if @summon_data[:user].summon_data && @summon_data[:user].summon_data[:user]
			user2=@summon_data[:user].summon_data[:user]
			c = user2.actor.battle_stat.get_stat("mood")
			c += 1
			user2.actor.battle_stat.set_stat("mood",c)
		end
		3.times{
			$game_damage_popups.add(rand(12)+1,self.x, self.y,2,7)
		}
		$game_map.reserve_summon_event("WasteWet",self.x,self.y)
	end
	def batch_EfxLonaTornadoHit_init
		@opacity = 0
		target=@summon_data[:target]
		moveto(target.x,target.y)
		hit_effect_aggro_redirect
		user=@summon_data[:user]
		combat_knockback($game_player,target,range=1,$game_player.direction)
		if @summon_data[:user].summon_data && @summon_data[:user].summon_data[:user]
			user2=@summon_data[:user].summon_data[:user]
			c = user2.actor.battle_stat.get_stat("mood")
			c += 1
			user2.actor.battle_stat.set_stat("mood",c)
		end
		3.times{
			$game_damage_popups.add(rand(12)+1,self.x, self.y,2,7)
		}
		$game_map.reserve_summon_event("WasteWet",self.x,self.y)
	end
	def batch_EffectKnockbackPunchHit_init_base
		target=@summon_data[:target]
		user=@summon_data[:user]
		moveto(target.x,target.y)
		c = user.actor.battle_stat.get_stat("mood")
		c += 1
		user.actor.battle_stat.set_stat("mood",c)
		3.times{
			$game_damage_popups.add(rand(12)+1,self.x, self.y,2,5)
		}
		$game_map.reserve_summon_event("WasteBlood",self.x,self.y) if !target.npc.is_object
	end
	def batch_EffectKnockbackPunchHit_init
		target=@summon_data[:target]
		user=@summon_data[:user]
		batch_EffectKnockbackPunchHit_init_base
		combat_knockback(user,target)
	end
	def batch_EfxWaterNovaKnockbackHit_init
		target=@summon_data[:target]
		user=@summon_data[:user]
		batch_EffectKnockbackPunchHit_init_base
		hit_effect_aggro_redirect
		combat_knockback(user,target)
	end
	def batch_EfxKnockPunchHitRedirect_init
		user = @summon_data[:user].npc.find_redirect_user
		target =@summon_data[:target]
		batch_EffectKnockbackPunchHit_init_base
		hit_effect_aggro_redirect
		combat_knockback(user,target)
	end
	def batch_smallCreatureForcedXY
		forced_x = 10-rand(20)
		@forced_y = 8-rand(24)
	end

	def batch_EffectGrabHit_init
		@nappable=false
		@opacity=0 if !$TEST
		@manual_trigger=-1

		tar = @summon_data[:target]
		usr = @summon_data[:user]
		usrA = usr.actor

		tmpC_byPP = !usrA.target && usr.get_manual_move_type == :control_this_event_with_skill

		if usrA.target == tar || tmpC_byPP
			usr.actor.holding_efx=self
			usr.actor.set_fuck_target(@summon_data[:skill],tar)
			usr.call_balloon(3)
			usr.moveto(usr.x,usr.y)
			tar.moveto(tar.x,tar.y)
		end
		moveto(tar.x,tar.y)

		#force it aggro
		if !tar.actor.no_aggro
			tar.actor.set_aggro(usr.actor,$data_arpgskills["BasicNormal"],600,true)
		end
	end
end #class game event
