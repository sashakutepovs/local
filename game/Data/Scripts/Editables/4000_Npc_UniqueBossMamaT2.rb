#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#標準型人類，發現目標就是衝過去狂扁
class Npc_UniqueBossMamaT2 < Game_NonPlayerCharacter
	def setup_npc
		super
						#stance			stanceC CHSindex	stanceWait Speed
		@stance_default_list = [
						[:Charge		,6		,0			,360		,4.5], #normal AI
						[:WaterfowlDance,1		,4			,180		,3],  #Boss skill waterfowlDance
						[:Charge		,6		,0			,240		,4.5], #normal AI
						[:Defence		,3		,1			,360		,2.6], #charge boss skill
						[:WaterfowlDance,1		,4			,180		,3]  #Boss skill waterfowlDance
						]
		@stance_list = [
						[:Charge		,4		,0			,15		,4],	 #normal AI
						[:Defence		,3		,1			,360		,2.6] #charge boss skill
						]
		@stance_current 		= [:Defence		,3		,1			,60		,1]
		@stance_name			= @stance_current[0]
		@stance_count 			= @stance_current[1]
		@stance_wait			= @stance_current[3]
		@dodge_tgt_skill_frame		= 0
		@dodge_req_frame			= 1+rand(70)
		@dodge_again_frame			= 0
		@dodge_again_frame_req_frame= 80+rand(120)
		add_fated_enemy([0])
	end
	
	def stance_next
		@event.balloon_XYfix = -65535
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
			when :Defence			;SndLib.katana_start_heavy(@event.report_distance_to_vol_close)
									skills = ["KatanaBossChargeLine"]
									@skills_killer_list=@skills_assaulter_list=skills
									
			when :Charge			;SndLib.katana_start_light(@event.report_distance_to_vol_close)
									skills = ["KatanaBossMamaNormal", "KatanaFullAOE"]
									@skills_killer_list=@skills_assaulter_list=skills
									
			when :WaterfowlDance	;SndLib.katana_start_heavy(@event.report_distance_to_vol_close,150)
									skills = ["KatanaWaterflowDance"]
									@skills_killer_list=@skills_assaulter_list=skills
		end
		clear_cached_skill
		tgt = get_target
		if tgt && @action_state != :skill && !@event.force_update
			do_dodge_action(tgt,dgd_frame=25)
			#return if tgt == $game_player
			#if tgt.npc.master && tgt.npc.master.npc? && tgt.npc.master.npc.action_state != :death
			#	self.set_aggro(tgt.npc.master,$data_arpgskills["BasicNormal"],300,no_action_change = true)
			#end
		end
	end
	
	def do_dodge_action(tgt,dgd_frame=25,reset=false,dodgeType="back")
		tmpDodgeX,tmpDodgey = [@event.x,@event.y]
		EvLib.sum("UniqueBossMamaT2_Shadow",tmpDodgeX,tmpDodgey,{:user=>@event})
		case dodgeType
			when "back";@event.combat_jumpback(@event,checkImmue=true)
			when "side";@event.batch_NPC_side_dodge(tgt)
		end
		@event.set_dodge(dgd_frame)
		@event.turn_toward_character(tgt)
		return if !reset
		SndLib.sound_equip_armor(@event.report_distance_to_vol_close-30,70)
		@dodge_tgt_skill_frame		= 0
		@dodge_req_frame			= 1+rand(70)
		@dodge_again_frame			= 0
		@dodge_again_frame_req_frame= 80+rand(120)
	end

	def update_read_tgt #put to aggro update
		return @dodge_again_frame += 1 if @dodge_again_frame_req_frame > @dodge_again_frame
		return if !self.target
		return if !self.target.actor.skill || self.target.actor.action_state != :skill
		return if self.target.actor.skill.is_support
		@dodge_tgt_skill_frame += 1
		@dodge_tgt_skill_frame += 1 if self.target.facing_character?(@event)
		if @dodge_tgt_skill_frame >= @dodge_req_frame
			do_dodge_action(self.target,dgd_frame=25,reset=true,dodgeType="side")
			stance_next if rand(100) >= 80
		end
	end
	
	def stance_refresh #check, not frame update
		@event.character_index	= @stance_current[2]
		@event.set_manual_move_speed(@stance_current[4])
		@event.move_speed = (@stance_current[4])
		set_move_speed(@stance_current[4])
	end
	
	def get_move_command
		stance_refresh
		tgt = get_target
		return [:move_random] if tgt.nil?
		stance_refresh
		near = @event.near_the_target?(tgt,safe_distance)
		case self.ai_state
			when :fucker
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !@event.near_the_target?(tgt,2)
				return [:turn_toward_character,tgt]
			else
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !near
				return [:turn_toward_character,tgt]
		end
	end
	
	#she dont need skill cost
	def process_skill_cost(skill)
		return true
	end

	#use aggro as frame update
	def update_frame
		return if @event.move_type == :control_this_event_with_skill || @event.move_type == :control_this_event
		update_step_sndlib
		update_read_tgt
		add_fated_enemy([0])
		@stance_wait -= 1 if @action_state != :skill
		stance_next if @stance_wait <= 0 && @action_state != :skill #&& !@event.force_update
		super
	end
	
	def update_step_sndlib
		return if !@event.moving?
		case @event.pattern
			when 1,3
				SndLib.sound_step(@event.report_distance_to_vol_close-40,130) if @stepSndLibPlayable == true
				@stepSndLibPlayable = false
			when 2,0
				@stepSndLibPlayable = true
		end
	end
	
	## 100% overwrite and add 
	def launch_skill(skill,force=false)
		return if !super
		if [:WaterfowlDance,:Defence].include?(@stance_name)
			@stance_count -= 1
			stance_next if @stance_count <= 0
		end
	end
	
	#def take_aggro(attacker,skill,no_action_change=false)
	#	return if @action_state == :skill
	#	super
	#end

	def apply_stun_effect(state_id)
		return
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

	def process_death
		@event.balloon_XYfix = 0
		super
	end
	################################################# PC control mode
	def player_control_mode_hack_data
		skills = ["KatanaBossMamaNormal", "KatanaFullAOE","KatanaWaterflowDance","KatanaBossChargeLine"]
		@skills_killer_list=@skills_assaulter_list=skills
		@event.move_speed = 4.5
		set_move_speed(4.5)
		clear_cached_skill
	end
end
