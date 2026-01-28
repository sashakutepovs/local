

class Npc_UniqueOrkindWarBoss < Game_NonPlayerCharacter
	attr_accessor	:buttHurt
	def setup_npc
		super
		@stepSndLibPlayable = false 
						#stance			stanceC CHSindex	stanceWait Speed
		@stance_default_list = [
						[:Metor			,9		,0			,600	,3],
						[:Charge		,0		,0			,60		,3.5],
						[:Combat		,0		,0			,400	,3.5],
						[:Charge		,0		,0			,60		,3.5],
						[:Defence		,20		,5			,180	,2.7],
						[:CallGobs		,1		,0			,60		,2.7],
						[:Defence		,20		,5			,420	,2.7],
						]
		@stance_list = [
						#[:Defence		,3		,5			,300		,2.5] #charge boss skill
						[:Charge		,0		,0			,150	,3.5], #charge boss skill
						[:Defence		,20		,5			,60     ,2.7]
						]
		@stance_current 		= [:Combat		,3		,0			,1		,3.5]
		@stance_name			= @stance_current[0]
		@stance_count 			= @stance_current[1]
		@stance_wait			= @stance_current[3]
		@callGOB_frame_req_frame_default = 325
		@callGOB_frame					= 0
		@callGOB_frame_req_frame		= @callGOB_frame_req_frame_default
		#add_fated_enemy([0])
		
		
		
		############################# HEV
		@idle_to_sex_mode_count = 0
		@idle_to_sex_mode_count_max = 180
		@idle_rape_meatshield_count = 0
		@idle_rape_meatshield_count_max = 60
		@idle_rape_cumming_count = 0
		@idle_rape_cumming_count_max = 12
		@idle_rape_b4cuminside = 0
		@idle_rape_b4cuminside_max = 120
		@idle_rape_cuminside = 0
		@idle_rape_cuminside_max = 180
		
		@idle_aniArr_b4coom = (0..20).collect { |i| [7, 2, 1 + i / 2,0, i % 2] }
		@idle_aniArr_cooming = (0..20).collect { |i| [8, 2, 1 + i / 2,0, i % 2] }
		@idle_aniArr_shieldRape = [
			[6,3,2 ,0 ,1],
			[7,3,2 ,0 ,1],
			[8,3,2 ,0 ,1],
			[8,3,2 ,0 ,0],
			[8,3,2 ,0 ,1],
			[8,3,2 ,0 ,0],
			[8,3,2 ,0 ,1],
			[8,3,2 ,0 ,0],
			[8,3,2 ,0 ,1],
			[8,3,2 ,0 ,0],
			[8,3,2 ,0 ,1],
			[8,3,2 ,0 ,0],
			[7,3,8 ,0 ,0],
			[6,3,8 ,0 ,0],
			[6,3,60,0 ,1]
		]
	end
	
	def stance_next
		return if @event.npc.ai_state == :flee
		return if @event.npc.ai_state == :fucker
		@stance_list += @stance_default_list if @stance_list.empty?
		@stance_current			= @stance_list.shift
		@stance_name 			= @stance_current[0]
		@stance_count			= @stance_current[1]
		@event.character_index	= @stance_current[2]
		@stance_wait			= @stance_current[3]
		@event.set_manual_move_speed(@stance_current[4])
		@event.move_speed = (@stance_current[4])
		@event.balloon_XYfix = -65535
		set_move_speed(@stance_current[4])
		#self.set_survival(npc.survival)
		#self.set_def(npc.def)

		#case @stance_name
		#	when :CallGobs			;play_sound(:sound_alert1,@event.report_distance_to_vol_close,140)
		#							@callGOB_frame = 0
		#							skills = []
		#							@skills_killer_list=@skills_assaulter_list=skills
		#							launch_skill($data_arpgskills["NpcHeavyForwardSlashCombo"])
		#							stance_next
		#	when :Metor				#;play_sound(:sound_aggro,@event.report_distance_to_vol_close,70)
		#							@callGOB_frame = 0
		#							skills = ["NpcHeavyForwardSlashCombo"]
		#							@skills_killer_list=@skills_assaulter_list=skills
		#
		#	when :Combat			;play_sound(:sound_alert2,@event.report_distance_to_vol_close,100)
		#							skills = ["NpcHeavyForwardSlashCombo","NpcHeavyForwardSlashCombo"]
		#							@skills_killer_list=@skills_assaulter_list=skills
		#
		#	when :Charge			;play_sound(:sound_skill,@event.report_distance_to_vol_close-10,80)
		#							skills = ["NpcHeavyForwardSlashCombo","NpcHeavyForwardSlashCombo"]
		#							@skills_killer_list=@skills_assaulter_list=skills
		#
		#	when :Defence			;play_sound(:sound_lost,@event.report_distance_to_vol_close,120)
		#							#self.set_survival(npc.survival*2)
		#							#self.set_def(npc.def*1.5)
		#							SndLib.sound_shield_up(@event.report_distance_to_vol_close)
		#							skills = ["NpcHeavyForwardSlashCombo"]
		#							@skills_killer_list=@skills_assaulter_list=skills
		#end
		case @stance_name
			when :CallGobs			;play_sound(:sound_alert1,@event.report_distance_to_vol_close,140)
									@callGOB_frame = 0
									skills = []
									@skills_killer_list=@skills_assaulter_list=skills
									launch_skill($data_arpgskills["NpcCallGob"])
									stance_next
			when :Metor				#;play_sound(:sound_aggro,@event.report_distance_to_vol_close,70)
									@callGOB_frame = 0
									skills = ["NpcMeteorStrike"]
									@skills_killer_list=@skills_assaulter_list=skills

			when :Combat			;play_sound(:sound_alert2,@event.report_distance_to_vol_close,100)
									skills = ["NpcCleaveMH","NpcHeavyForwardSlashCombo"]
									@skills_killer_list=@skills_assaulter_list=skills

			when :Charge			;play_sound(:sound_skill,@event.report_distance_to_vol_close-10,80)
									skills = ["NpcHeavyForwardSlashCombo","NpcChargeBig"]
									@skills_killer_list=@skills_assaulter_list=skills

			when :Defence			;play_sound(:sound_lost,@event.report_distance_to_vol_close,120)
									#self.set_survival(npc.survival*2)
									#self.set_def(npc.def*1.5)
									SndLib.sound_shield_up(@event.report_distance_to_vol_close)
									skills = ["NpcCleaveMH"]
									@skills_killer_list=@skills_assaulter_list=skills
		end
		clear_cached_skill
		tgt = get_target
		if tgt && @action_state != :skill && !@event.force_update
			@event.turn_toward_character(tgt)
		end
	end
	
	def applyButtHurt(attacker)
		return if self.action_state == :stun
		EvLib.sum("EffectOverKill",@event.x,@event.y)
		@event.npc_stop_update(false,false)
		@event.end_combo_skill
			if with_ShieldEV?
				tar = self.shieldEV.actor
				resultHP=100
				resultSTA=20
			else
				tar = self
				resultHP=100
				resultSTA=200
			end
			attribute= tar.battle_stat.get_stat("health")
			tar.battle_stat.set_stat("health",attribute-resultHP)
			$game_damage_popups.add(resultHP, @event.x, @event.y, 2,1,1.4)
			attribute= tar.battle_stat.get_stat("sta")
			tar.battle_stat.set_stat("sta",attribute-resultSTA)
			$game_damage_popups.add(resultSTA, @event.x, @event.y, 2,2,1.4)
		@buttHurt = true
		force_shock("Stun3") if !npc_dead?
		@buttHurt = false
		play_sound(:sound_aggro,@event.report_distance_to_vol_close,140)
		@event.jump_to(@event.x,@event.y)
		@stance_count -= 1
		#do damage popup
	end
	
	def check_blocked
		return true if @stance_name == :Defence && [nil,:none].include?(@action_state)
		return super
	end
	
	#def stance_refresh #check, not frame update
	#	@event.character_index = @stance_current[2]
	#	@event.set_manual_move_speed(@stance_current[4])
	#	@event.move_speed = (@stance_current[4])
	#	set_move_speed(@stance_current[4])
	#end
	
	#she dont need skill cost
	def process_skill_cost(skill)
		return true
	end
	
	#use aggro as frame update
	def update_frame
		update_step_sndlib
		return player_control_mode_update if @event.move_type == :control_this_event_with_skill
		return if @event.npc.ai_state == :flee
		return if @event.npc.ai_state == :fucker
		#return if @target.nil? || @event.move_type == :combo_skill
		return if [0,1,3,5,7,:combo_skill].include?(@event.move_type)
		update_read_tgt
		@stance_wait -= 1 if @action_state != :skill
		stance_next if @stance_wait <= 0 && @action_state != :skill #&& !@event.force_update
		super
	end
	def update_step_sndlib
		return if !@event.moving?
		case @event.pattern
			when 1
				SndLib.sound_step_chain(@event.report_distance_to_vol_close-70,60) if @stepSndLibPlayable == true
				@stepSndLibPlayable = false
			when 3
				SndLib.sound_HeavyStep(@event.report_distance_to_vol_close+20,70) if @stepSndLibPlayable == true
				@stepSndLibPlayable = false
			when 2,0
				@stepSndLibPlayable = true
		end
	end
	################################################################################################################### ANTI KITE
	
	def do_CallGOB
		@event.turn_toward_character(self.target) if self.target
		SndLib.sound_equip_armor(@event.report_distance_to_vol_close-30,70)
		@callGOB_frame					= 0
		@callGOB_frame_req_frame		= @callGOB_frame_req_frame_default
		launch_skill($data_arpgskills["NpcCallGob"])
	end
	def decrease_callGOB_frame
		@callGOB_frame -= 2 if @callGOB_frame > 0
	end
	def update_read_tgt #put to aggro update
		return if @event.move_type == :control_this_event_with_skill
		return decrease_callGOB_frame if self.action_state == :skill
		return decrease_callGOB_frame if !self.skill.nil?
		return decrease_callGOB_frame if [:Metor].include?(@stance_name)
		return decrease_callGOB_frame unless !self.target || (self.target && @event.report_range(self.target) >= 4 && self.target.moving?)
		@callGOB_frame += 1
		@callGOB_frame += 1 if self.target && @event.report_range(self.target) >= 7
		do_CallGOB if @callGOB_frame >= @callGOB_frame_req_frame
	end
	
	###################################################################################################################
	## 100% overwrite and add 
	def launch_skill(skill,force=false)
		return if !super(skill,force)
		reset_idle_shield_rape_mode
		return if @event.move_type == :control_this_event_with_skill
		if [:Metor].include?(@stance_name)
			@stance_count -= 1
			stance_next if @stance_count <= 0
		end
	end

	def apply_stun_effect(state_id)
		return if !@buttHurt
		super(state_id)
	end
	
	def take_sap(user)
		return false
	end
	
	#def overfatigue_death?
	#	@stat.get_stat("sta")<=0 
	#end
	
	def npc_dead?
		@stat.get_stat("health")<=0 || @stat.get_stat("sta") <= -3
	end
	
	def get_move_command
		return if @event.chk_skill_eff_reserved
		tgt = get_target
		return [:move_random] if tgt.nil?
		near = @event.near_the_target?(tgt,safe_distance)
		case @event.npc.ai_state
			when :fucker
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !@event.near_the_target?(tgt,2)
				return [:turn_toward_character,tgt]
			else
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				if !near
					if @stance_name == :Defence
						return [:move_toward_TargetSmartAI,tgt,faceIT=true]
					else
						return [:move_toward_TargetSmartAI,tgt]
					end
				end
				return [:turn_toward_character,tgt]
		end
	end
	
	def friendly?(character)
		friendly_sign = super(character)
		return false if friendly_sign && ["Orkind","Goblin"].include?(character.actor.race) && character.npc.get_b_stat("sta") <= 0
		return friendly_sign
	end

	def summon_death_event
		$game_map.reserve_summon_event(*death_event_data) if !npc.death_event.nil? && !npc.death_event.empty?
	end
	
	#def update_npc_stat
	#	return @event.end_combo_skill if @event.combo_original_move_route && @event.move_route != 3
	#	super
	#end
	
	def process_death
		return p" nothing to do @event.id=>#{@event.id}" if @action_state == :death
		@event.balloon_XYfix = 0
		ded_unset_chs_sex
		return if @action_state == :sex
		$game_map.npcs.each{|event|
			next unless event.summon_data
			next unless event.summon_data[:WarbossCallGobs]
			next if event.deleted?
			event.npc.battle_stat.set_stat_m("sta",0,[0,2,3])
			event.npc.battle_stat.set_stat_m("health",0,[0,2,3])
		}
		if $game_player.actor.is_a_ProtectShield && $game_player.actor.master == @event
			$game_map.interpreter.cam_center(0)
			$game_player.actor.map_loading_reset_stats
		end
		@target=nil
		add_state(1)
		set_alert_level(0)
		play_sound(:sound_death,map_token.report_distance_to_vol_close_npc_vol)
		set_action_state(:death,true)
	end
	
	def player_control_mode(on_off=true,canUseSkill=false,withModeCancel=false,withTimer=false)
		@player_control_mode_skills = ["NpcCleaveMHBash","NpcBasicSh_Combo","NpcMeteorStrike","NpcChargeBig","NpcMasturbationMale","NpcFuckerGrab"]
		super(on_off,canUseSkill)
		#@skills_killer_list=@skills_assaulter_list=skills
	end
	
	def eval_ev_check
		return true if @evalEvSummoned || @event.summon_data[:evalEV]
		@evalEvSummoned = true
		EvLib.sum("loadEvalStartEV",1,1,{:user=>@event})
		false
	end
	
	def reset_idle_shield_rape_mode
		@idle_to_sex_mode_count = 0
		@idle_rape_meatshield_count = 0
		@idle_rape_cumming_count = 0
		@idle_rape_b4cuminside = 0
		@idle_rape_cuminside = 0
		@idle_rape_meatshield_mode = nil
	end
	def player_control_mode_update
		$game_player.stackWithTarget(@event,tmpX=0,tmpY=0)
		$game_player.direction = @event.direction
		return if !eval_ev_check
		return reset_idle_shield_rape_mode if ![nil,:none].include?(self.action_state)
		return reset_idle_shield_rape_mode if self.skill
		return reset_idle_shield_rape_mode if @stat.get_stat("sta") <= 0
		if !@event.moving? && Input.trigger?(:C)
			reset_idle_shield_rape_mode
			@event.animation = nil
			self.play_sound(:sound_skill,@event.report_distance_to_vol_close_npc_vol,120)
			$game_player.check_event_trigger_there([0],tmpEvX=@event.x,tmpEvY=@event.y,tmpEvD=@event.direction)
		end
		return if @event.summon_data[:rapeloop_battle_mode]
		if @event.moving?
			reset_idle_shield_rape_mode
			@event.animation = nil
		else
			@event.control_this_event(checkSkill=true,ignoreAnimation=true) if @event.animation
			@idle_to_sex_mode_count += 1 if @idle_to_sex_mode_count_max > @idle_to_sex_mode_count
		end
		
		@idle_rape_meatshield_mode = @idle_to_sex_mode_count >= @idle_to_sex_mode_count_max
		
		if @idle_rape_meatshield_mode
			@idle_rape_meatshield_count += 1
			
			if @idle_rape_cuminside >= @idle_rape_cuminside_max
				reset_idle_shield_rape_mode
				self.play_sound(:sound_death,@event.report_distance_to_vol_close_npc_vol,80)
				$story_stats["sex_record_vaginal_count"] += 1
				evalData = '
					tmp_evPick = ["EventVag_CumInside_OvercumStay","EventVag_CumInside_Overcum_Peein"].sample
					$game_player.actor.stat["EventVagRace"] = "Orkind"
					$game_player.actor.stat["EventVag"] = "CumInside1"
					$game_player.actor.stat["vagopen"] = 1
					$game_player.actor.stat["pose"] = [1,4].sample
					load_script("Data/HCGframes/#{tmp_evPick}.rb")
				'
				$game_temp.loadEval(evalData)
			elsif @idle_rape_cuminside >= 1 ############################################################################# dev part
				@idle_rape_cuminside += 1
				if @idle_rape_cuminside % 20 == 0
					evalData = '
						$game_player.actor.prtmood(["p4ahegao","p4cuming","p4health_damage"].sample)
						$game_portraits.setRprt("Lona")
						$game_player.actor.stat["AllowOgrasm"] = true
						$game_player.actor.stat["vagopen"] = 1
						$game_player.actor.stat["ShockBody"] = rand(2)
						prevPreg = $game_player.actor.stat["preg"]
						$game_player.actor.stat["preg"] += 1 if $game_player.actor.stat["preg"] <3
						$game_player.actor.stat["EventTargetPart"] = "Vag"
						$game_player.actor.stat["EventVagRace"] = "Orkind"
						$game_player.actor.stat["EventVag"] = "WarBossEV4"
						$game_player.actor.portrait.update
						$game_portraits.rprt.set_position(278-7,-155+10)
						$game_portraits.rprt.shake
						$game_player.actor.stat["preg"] = prevPreg
						'
					@event.summon_data[:evalEV].summon_data[:evalData] = evalData
					@event.summon_data[:evalEV].start
					EvLib.sum("EffectSexServiceIngratiateHit",@x,@y,{:target => $game_player,:user => @event ,:prtMood=>false, :refreshPortrait => false})
				end
				@event.animation = @event.aniCustom(@idle_aniArr_cooming,-1) if !@event.animation
				
			#########################cumming
			elsif @idle_rape_b4cuminside >= @idle_rape_b4cuminside_max
				@idle_rape_cumming_count = 0
				@idle_rape_meatshield_count = 0
				@idle_rape_cuminside = 1
				@idle_rape_b4cuminside = 0
				self.play_sound(:sound_death,@event.report_distance_to_vol_close_npc_vol,110)
				@event.animation = @event.aniCustom(@idle_aniArr_cooming,-1)
			elsif @idle_rape_b4cuminside >= 1
				@idle_rape_b4cuminside += 1
				if @idle_rape_b4cuminside % 40 == 0
					evalData = '
						$game_player.actor.prtmood("p4shame")
						$game_portraits.setRprt("Lona")
						$game_player.actor.stat["AllowOgrasm"] = true
						$game_player.actor.stat["vagopen"] = 1
						$game_player.actor.stat["EventTargetPart"] = "Vag"
						$game_player.actor.stat["EventVagRace"] = "Orkind"
						$game_player.actor.stat["EventVag"] = "WarBossEV1"
						$game_player.actor.portrait.update
						$game_portraits.rprt.set_position(278-2,-155+15)
						$game_portraits.rprt.shake
						'
					@event.summon_data[:evalEV].summon_data[:evalData] = evalData
					@event.summon_data[:evalEV].start
					EvLib.sum("EffectSexServiceIngratiateHit",@x,@y,{:target => $game_player,:user => @event ,:prtMood=>false, :refreshPortrait => false})
				end
				@event.animation = @event.aniCustom(@idle_aniArr_b4coom,-1) if !@event.animation
				
			#########################b4 cumming
			elsif @idle_rape_cumming_count >= @idle_rape_cumming_count_max
				@idle_rape_cumming_count = 0
				@idle_rape_meatshield_count = 0
				@idle_rape_cuminside = 0
				@idle_rape_b4cuminside = 1
				play_sound(:sound_aggro,@event.report_distance_to_vol_close,120)
				@event.animation = @event.aniCustom(@idle_aniArr_b4coom,-1)
				
			#########################basic frame fuck
			elsif @idle_rape_meatshield_count >= @idle_rape_meatshield_count_max -40
				if @idle_rape_meatshield_count == @idle_rape_meatshield_count_max -40
					evalData = '
						$game_player.actor.prtmood("p4shame")
						$game_portraits.setRprt("Lona")
						$game_player.actor.stat["AllowOgrasm"] = true
						$game_player.actor.stat["vagopen"] = 1
						$game_player.actor.stat["EventTargetPart"] = "Vag"
						$game_player.actor.stat["EventVagRace"] = "Orkind"
						$game_player.actor.stat["EventVag"] = "WarBossEV1"
						$game_player.actor.portrait.update
						$game_portraits.rprt.set_position(278,-155)
						'
					@event.summon_data[:evalEV].summon_data[:evalData] = evalData
					@event.summon_data[:evalEV].start
				elsif @idle_rape_meatshield_count == @idle_rape_meatshield_count_max -35
					evalData = '
						$game_player.actor.prtmood("p4pee")
						$game_portraits.setRprt("Lona")
						$game_player.actor.stat["AllowOgrasm"] = true
						$game_player.actor.stat["vagopen"] = 1
						$game_player.actor.stat["EventTargetPart"] = "Vag"
						$game_player.actor.stat["EventVagRace"] = "Orkind"
						$game_player.actor.stat["EventVag"] = "WarBossEV2"
						$game_player.actor.portrait.update
						$game_portraits.rprt.set_position(278-7,-155+10)
						'
					@event.summon_data[:evalEV].summon_data[:evalData] = evalData
					@event.summon_data[:evalEV].start
				elsif @idle_rape_meatshield_count == @idle_rape_meatshield_count_max -25
					@idle_rape_cumming_count += 1
					evalData = '
						$game_player.actor.prtmood(["p4ahegao","p4cuming","p4health_damage"].sample)
						$game_portraits.setRprt("Lona")
						$game_player.actor.stat["AllowOgrasm"] = true
						prevPreg = $game_player.actor.stat["preg"]
						$game_player.actor.stat["preg"] += 1 if $game_player.actor.stat["preg"] <3
						$game_player.actor.stat["vagopen"] = 1
						$game_player.actor.stat["EventTargetPart"] = "Vag"
						$game_player.actor.stat["EventVagRace"] = "Orkind"
						$game_player.actor.stat["EventVag"] = "WarBossEV3"
						$game_player.actor.portrait.update
						$game_portraits.rprt.set_position(278-2,-155+15)
						$game_portraits.rprt.shake
						$game_player.actor.stat["preg"] = prevPreg
						'
					@event.animation = @event.aniCustom(@idle_aniArr_shieldRape,-1)
					self.play_sound(:sound_skill,@event.report_distance_to_vol_close_npc_vol) if rand(100) > 60
					
					@event.summon_data[:evalEV].summon_data[:evalData] = evalData
					@event.summon_data[:evalEV].start
					EvLib.sum("EffectSexServiceIngratiateHit",@x,@y,{:target => $game_player,:user => @event ,:prtMood=>false, :refreshPortrait => false})
					EvLib.sum("WasteSemenOrcish",@event.x,@event.y) if rand(100) > 95
					EvLib.sum("WasteSemen",@event.x,@event.y) if rand(100) > 90
					$game_player.actor.take_skill_effect(self,$data_arpgskills["BasicSexDmg_receiver"],can_sap=false,force_hit=true)
				elsif @idle_rape_meatshield_count == @idle_rape_meatshield_count_max -3
					evalData = '
						$game_portraits.setRprt("Lona")
						$game_player.actor.stat["AllowOgrasm"] = true
						$game_player.actor.stat["vagopen"] = 1
						$game_player.actor.stat["ShockBody"] = 0
						$game_player.actor.stat["EventTargetPart"] = "Vag"
						$game_player.actor.stat["EventVagRace"] = "Orkind"
						$game_player.actor.stat["EventVag"] = "WarBossEV2"
						$game_player.actor.portrait.update
						$game_portraits.rprt.set_position(278-7,-155+10)
						'
					@event.summon_data[:evalEV].summon_data[:evalData] = evalData
					@event.summon_data[:evalEV].start
				elsif @idle_rape_meatshield_count == @idle_rape_meatshield_count_max
					@idle_rape_meatshield_count = 0
					evalData = '
						$game_portraits.setRprt("Lona")
						$game_player.actor.stat["AllowOgrasm"] = true
						$game_player.actor.stat["vagopen"] = 1
						$game_player.actor.stat["ShockBody"] = 0
						$game_player.actor.stat["EventTargetPart"] = "Vag"
						$game_player.actor.stat["EventVagRace"] = "Orkind"
						$game_player.actor.stat["EventVag"] = "WarBossEV1"
						$game_player.actor.portrait.update
						$game_portraits.rprt.set_position(278,-155)
						'
					@event.summon_data[:evalEV].summon_data[:evalData] = evalData
					@event.summon_data[:evalEV].start
				end
				
			end
		end
	end #player_control_mode_update
end


