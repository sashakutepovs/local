

class Npc_UniqueFishkindFistMasterT2 < Game_NonPlayerCharacter
	attr_accessor	:get_major_target
	def setup_npc
		super
		@stepSndLibPlayable = false 
						#stance			stanceC CHSindex	stanceWait Speed
		@stance_default_list = [
						[:DodgeCharge		,0		,0			,120	,3.5],
						[:Forward			,1		,0			,60		,2.5],
						[:Defence_idle		,1		,3			,120	,2.5],
						[:Forward			,0		,0			,60		,3.5],
						[:Defence_idle		,1		,3			,120	,2.5],
						[:Forward			,1		,0			,240	,4],
						[:SideWalk			,0		,0			,240	,4],
						[:DodgeCharge		,0		,0			,120	,3.5],
						[:ChargeAtk			,0		,0			,240	,4],
						]
						
						#text
		@skill_Forward		= ["FishFistMasterBasicCombo","FishFistMasterChargeCombo","FishFistMasterTatsumakiHkHold"]
		@skill_ChargeAtk	= ["FishFistMasterBasicCombo","FishFistMasterChargeCombo"]
		@skill_SideWalk		= ["FishFistMasterBasicCombo","FishFistMasterChargeCombo"]
						#["FishFistMasterShadowDash","FishFistMasterTatsumakiHkHold","FishFistMasterCrossedWind","FishFistMasterWaterDash","FishFistMasterThunderDash","FishFistMasterBasicCombo","FishFistMasterChargeCombo"],
						#"skills_killer": ["FishFistMasterLP","FishFistMasterRP","FishFistMasterLK","FishFistMasterUppercutHold","FishFistMasterHLP_Hold","FishFistMasterHRP_Hold","FishFistMasterTatsumakiHold","FishFistMasterTatsumakiHkHold"],
						
		@stance_list = [
						[:ChargeAtk		,3		,5			,300		,3] #charge boss skill
						]
		@stance_current 		= [:Forward		,3		,0			,1		,3.5]
		@stance_name			= @stance_current[0]
		@stance_count 			= @stance_current[1]
		@stance_wait			= @stance_current[3]
		reset_idle_count
		add_fated_enemy([0])
	end
	def stance_next
		return if @event.npc.ai_state == :flee
		return if @event.npc.ai_state == :fucker
		@event.balloon_XYfix = -65535
		@defence_stance_skill_used = false
		@defence_stance_dashed = false
		@stance_list += @stance_default_list if @stance_list.empty?
		@stance_current			= @stance_list.shift
		@stance_name 			= @stance_current[0]
		@stance_count			= @stance_current[1]
		@event.character_index	= @stance_current[2]
		@stance_wait			= @stance_current[3]
		@event.set_manual_move_speed(@stance_current[4])
		@event.move_speed = (@stance_current[4])
		set_move_speed(@stance_current[4])
		case @stance_name
			when :DodgeCharge		#;play_sound(:sound_alert1,@event.report_distance_to_vol_close,140)
									skills = ["FishFistMasterDashHpCombo"]
									@skills_killer_list=@skills_assaulter_list=skills
			when :Forward			#;play_sound(:sound_alert1,@event.report_distance_to_vol_close,140)
									SndLib.sound_equip_armor(@event.report_distance_to_vol_close,70)
									@skills_killer_list=@skills_assaulter_list= @skill_Forward

			when :ChargeAtk			#;play_sound(:sound_alert2,@event.report_distance_to_vol_close,140)
									SndLib.sound_equip_armor(@event.report_distance_to_vol_close,70)
									@skills_killer_list=@skills_assaulter_list= @skill_ChargeAtk

			when :Defence_idle			#;play_sound(:sound_aggro,@event.report_distance_to_vol_close,70)
									SndLib.sound_flame(@event.report_distance_to_vol_close,150)
									@skills_killer_list=@skills_assaulter_list= []
									reset_idle_count
									reset_dodge_count
									@stance_count			= @idle_mode_count
									@stance_wait			= @idle_mode_max
									@event.pattern = 2
		end
		clear_cached_skill
		tgt = get_target
		if tgt && @action_state != :skill && !@event.force_update
			@event.turn_toward_character(tgt)
		end
	end
	
	def check_blocked
		return true if @stance_name == :Defence_idle && [nil,:none].include?(@action_state)
		return super
	end
	
	def stance_refresh #check, not frame update
		@event.character_index = @stance_current[2]
		@event.set_manual_move_speed(@stance_current[4])
		@event.move_speed = (@stance_current[4])
		set_move_speed(@stance_current[4])
	end
	
	#she dont need skill cost
	def process_skill_cost(skill)
		return true
	end
	def update_idle_animation
		
		
	end
	
	
	#use aggro as frame update
	def update_frame
		if @stance_name == :Defence_idle
			@event.step_anime = false
			@event.character_index	= @stance_current[2]
		elsif !@event.moving? && [:none,nil].include?(@action_state) && !@event.animation && @stance_name != :Defence_idle
			@event.step_anime = true
			@event.character_index = 1
		else
			chs_index= @event.charset_index
			@event.character_index = @event.chs_definition.chs_default_index[chs_index]
		end
		update_step_sndlib
		#return player_control_mode_update if @event.move_type == :control_this_event_with_skill
		return if @event.npc.ai_state == :flee
		return if @event.npc.ai_state == :fucker
		#return if @target.nil? || @event.move_type == :combo_skill
		return if [0,1,3,5,7,:combo_skill].include?(@event.move_type)
		update_read_tgt if @stance_name == :Defence_idle
		@stance_wait -= 1 if @action_state != :skill
		stance_next if @stance_wait <= 0 && @action_state != :skill #&& !@event.force_update
		super
	end
	def update_step_sndlib
		return if !@event.moving?
		case @event.pattern
			when 1
				@stepSndLibPlayable = true
			when 2,0
				SndLib.sound_step(@event.report_distance_to_vol_close-30,60) if @stepSndLibPlayable == true
				@stepSndLibPlayable = false
		end
	end
	#################################################################################################################### ANTI KITE
	#def do_dodge_action(tgt,dgd_frame=25,reset=false,dodgeType="back")
	#	tmpDodgeX,tmpDodgey = [@event.x,@event.y]
	#	EvLib.sum("UniqueBossMamaT2_Shadow",tmpDodgeX,tmpDodgey,{:user=>@event})
	#	case dodgeType
	#	when "back";@event.combat_jumpback(@event,checkImmue=true)
	#	when "side";@event.batch_NPC_side_dodge(tgt)
	#	end
	#	@event.set_dodge(dgd_frame)
	#	@event.turn_toward_character(tgt)
	#	return if !reset
	#	SndLib.sound_equip_armor(@event.report_distance_to_vol_close-30,70)
	#	@dodge_tgt_skill_frame		= 0
	#	@dodge_req_frame			= 1+rand(100)
	#	@dodge_again_frame			= 0
	#	@dodge_again_frame_req_frame= 120+rand(180)
	#end



	def update_read_tgt #put to aggro update
		return if !self.target
		#return if !self.target.actor.skill
		#return if self.target.actor.skill.is_support || self.target.actor.action_state != :skill
		return unless self.skill.nil?
		case @stance_name
			when :Forward
			when :ChargeAtk
			when :DodgeCharge
			when :Defence_idle
				return if @event.moving?
				return stance_next if @defence_stance_skill_used == true
				@event.turn_toward_character(get_major_target)
				if @defence_stance_dashed
					if get_major_target && @event.facing_character?(get_major_target)
						@defence_stance_skill_used = true
						launch_skill($data_arpgskills[["FishFistMasterHLP_Hold","FishFistMasterHRP_Hold"].sample],force=true)
					else
						@event.turn_toward_character(get_major_target)
					end
					return
				end
				@dodge_tgt_skill_frame += 1
				destroyable_OBJ= destroyable_OBJ_arounds?
				missile_OBJ = missile_OBJ_arounds?
				if !destroyable_OBJ.nil? && [true,false].sample
					@defence_stance_skill_used = true
					launch_skill($data_arpgskills["FishFistMasterTatsumakiHkHold"],force=true)
					return
				elsif !missile_OBJ.nil?
					#@event.turn_random
					#@defence_stance_dashed = true
					#launch_skill($data_arpgskills["FishFistMasterShadowDash"],force=true)
					@defence_stance_skill_used = true
					launch_skill($data_arpgskills["FishFistMasterDashPunch"],force=true)
					return
				end
				return if !self.target.actor.skill
				return if self.target.actor.action_state != :skill
				return if @event.report_range(self.target) > 4
				if @dodge_tgt_skill_frame >= @dodge_req_frame
					if get_major_target && @event.facing_character?(get_major_target)
						@defence_stance_skill_used = true
						launch_skill($data_arpgskills[["FishFistMasterHLP_Hold","FishFistMasterHRP_Hold"].sample],force=true)
					else
						@event.turn_toward_character(get_major_target)
					end
					return
				elsif @dodge_tgt_skill_frame >= @dodge_req_frame/2
					#@event.turn_toward_character(get_major_target)
					#@defence_stance_dashed = true
					#launch_skill($data_arpgskills["FishFistMasterShadowDash"],force=true) if @event.report_range(self.target) < 2
					@defence_stance_skill_used = true
					launch_skill($data_arpgskills["FishFistMasterDashPunch"],force=true) if @event.report_range(self.target) < 2
					return
				end
		end
	end
	def get_major_target
		return @target if @target
		return @last_attacker if @last_attacker
		return @story_mode_target if @story_mode_target
		nil
	end
	def destroyable_OBJ_arounds?
		tmpReport = $game_map.npcs.select{|ev|
			next if ev.deleted?
			next if ev == @event
			next unless ev.actor.is_a?(Game_PorjectileCharacter) || ev.actor.is_a?(GameTrap)
			next if ev.actor.immune_damage
			next unless @event.report_range(ev) <= 1
			ev
		}
		tmpReport.sample
	end
	def missile_OBJ_arounds?
		tmpReport = $game_map.npcs.select{|ev|
			next if ev.deleted?
			next if ev == @event
			next unless ev.actor.is_a?(Game_PorjectileCharacter)
			next unless @event.report_range(ev) <= 4 && same_xy?(ev) ||  @event.report_range(ev) <= 2
			ev
		}
		tmpReport.sample
	end
	def reset_idle_count
		@idle_mode_count =0
		@idle_mode_max = 120+rand(60)
	end
	def reset_dodge_count
		@dodge_tgt_skill_frame		= 0
		@dodge_req_frame			= 10+rand(10)
		@dodge_again_frame			= 0
		@dodge_again_frame_req_frame= 120+rand(180)
	end
	#def take_skill_hit_aggro(user,skill,can_sap=false,force_hit=false)
	#	super(user,skill,can_sap,force_hit)
	#	launch_skill($data_arpgskills[["FishFistMasterHLP_Hold","FishFistMasterHRP_Hold"].sample],force=true) if blocked?(user) unless self.immune_damage || skill.no_aggro || user.is_object
	#end

	###################################################################################################################
	## 100% overwrite and add 
	def launch_skill(skill,force=false)
		super(skill,force)
	#	return if !super(skill,force)
	#	reset_idle_shield_rape_mode
	#	return if @event.move_type == :control_this_event_with_skill
	#	if [:Metor].include?(@stance_name)
	#		@stance_count -= 1
	#		stance_next if @stance_count <= 0
	#	end
	end

	def apply_stun_effect(state_id)
		@stun_count += 1
		return if @stun_count < 3
		@stun_count =0
		super(state_id)
	end
	
	def take_sap(user)
		return false
	end
	
	def overfatigue_death?
		@stat.get_stat("sta")<=0 
	end
	
	def npc_dead?
		@stat.get_stat("health")<=0 || @stat.get_stat("sta") <= 0
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
				return [:turn_toward_character,tgt] if @stance_name == :Defence_idle
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				if !near
					#if @stance_name == :Defence_idle
					#	return [:move_toward_TargetSmartAI,tgt,faceIT=true]
					#else
						return [:move_toward_TargetSmartAI,tgt]
					#end
				end
				return [:turn_toward_character,tgt]
		end
	end
	
	def friendly?(character)
		super(character)
		#friendly_sign = super(character)
		#return false if friendly_sign && ["Orkind","Goblin"].include?(character.actor.race) && character.npc.get_b_stat("sta") <= 0
		#return friendly_sign
	end

	#def summon_death_event
	#	$game_map.reserve_summon_event(*death_event_data) if !npc.death_event.nil? && !npc.death_event.empty?
	#end
	#
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
	
end


