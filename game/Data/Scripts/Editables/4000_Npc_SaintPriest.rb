#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#標準型人類，發現目標就是衝過去狂扁

class Sensors::SaintSupportShield< Sensors::Multi
	def self.type;				:support;	end
	def self.sight_hp;			4;			end
	def self.use_iff?;			false;		end
	def self.ignore_dead?;		false;		end
	def self.ignore_object?;	true;		end
	def self.friendly_only?;	true;		end
	def self.calc_signal_strength(character,target,sight_hp,mine_value)
		return 100 if character.actor.check_tgt_shield?(target)
		return -400
	end
end #class sensors

class Npc_SaintPriest < Game_NonPlayerCharacter
	
	def setup_npc
		gen_wander_range_count
		super
						#stance			stanceWait S
		@stance_default_list = [
						[:Support		,9 ,60],
						[:Attack		,2 ,120]#normal AI
						]
		@stance_list = [
						[:Support		,9 ,60]#normal AI
						]
		@stance_current 		= [:Attack		,2 ,120]
		@stance_name			= @stance_current[0]
		@stance_count 			= @stance_current[1]
		@stance_wait			= @stance_current[2]
	end
	
	def stance_next
		@stance_list += @stance_default_list if @stance_list.empty?
		@stance_current			= @stance_list.shift
		@stance_name 			= @stance_current[0]
		@stance_count 			= @stance_current[1]
		@stance_wait			= @stance_current[2]
		case @stance_name
			when :Attack			;skills = ["NpcCurvedSaintSmite", "NpcBasicSh", "BasicHeavy","NpcMarkMoralityDown"]
									@skills_killer_list=@skills_assaulter_list=skills
									
			when :Support			;skills = ["NpcBasicSh","BasicHeavy","NpcMarkMoralityDown"]
									@skills_killer_list=@skills_assaulter_list=skills
		end
		clear_cached_skill
	end
	
	def update_frame
		@stance_wait -= 1 if @action_state != :skill
		stance_next if @stance_wait <= 0 && @action_state != :skill #&& !@event.force_update
		super
	end
	
	def launch_skill(skill,force=false)
		return if !super
		if @stance_name ==  :Attack
			@stance_count -= 1
			stance_next if @stance_count <= 0
		end
	end
	
	def sense_target(character,mode=0)
		detected=nil
		sensors.each{
			|sensor|
			detection=sensor.sense(character,$game_map.all_characters) #所有腳色包含主角
			next if detection==0 || detection[1] < 0 #[target,distance,signal_strength,sensortype]
			detected = detection if detected.nil? || detected[2]< detection[2]
		}
		if detected.nil?
			return if @aggro_frame != 0
			if @alert_level==2 || @target
				return @targetLock_HP -= 1 if @targetLock_HP > 0 && @target && @target.actor && @target.actor.action_state != :death #npc will hold target for a short time
				process_target_lost
			end
		else
			process_target(*detected)
		end
	end
	
	#def check_tgt_rez?(target)
	#	return false if target.get_start_rez == true
	#	return true if target.actor.action_state == :death && !target.deleted?
	#	return false
	#end
	def check_tgt_shield?(target)
		return true if !target.actor.with_ShieldEV? && (target.actor.skill && target.actor.action_state == :skill && !target.actor.skill.is_support)
		return false
	end
	
	def check_support_skill_friendly(target)
		if self.friendly?(target)
			true
		else
			process_target_lost
			false
		end
	end
	
	def process_target(target,distance,signal,sensor_type)
		#return if @action_state == :skill && @skill.is_support
		return super unless friendly?(target) #敵人通通交給原版處理，原版就是設計來面對敵人的。
		process_alert_level(target,distance,signal,sensor_type)
		process_ai_state(target,distance,signal,sensor_type)
		return unless @alert_level==2
		#return if progress_NpcRezDed(target,distance,signal,sensor_type)
		return if progress_support_shield(target,distance,signal,sensor_type)
		#return if progress_heal(target,distance,signal,sensor_type)
	end
	
	#def progress_NpcRezDed(target,distance,signal,sensor_type)
	#	return false if !check_support_skill_friendly(target)
	#	return false if !check_tgt_rez?(target)
	#	if !can_launch_skill?($data_arpgskills["NpcRezDed"])
	#		return false
	#	else
	#		@target = target
	#	end
	#	@event.turn_toward_character(target)
	#	@targetLock_HP = 0
	#	launch_skill($data_arpgskills["NpcRezDed"])
	#	true
	#end
	
	def progress_support_shield(target,distance,signal,sensor_type)
		return false if !check_support_skill_friendly(target)
		return false if !check_tgt_shield?(target)
		if !can_launch_skill?($data_arpgskills["NpcSaintProtectShield"])
			return false
		else
			@target = target
		end
		@event.turn_toward_character(target)
		@targetLock_HP = 0
		launch_skill($data_arpgskills["NpcSaintProtectShield"])
		true
	end
	
	#def progress_heal(target,distance,signal,sensor_type)
	#	return false if !check_support_skill_friendly(target)
	#	return false if [:sex,:grabbed].include?(@action_state)
	#	return false if [:sex,:grabbed].include?(target.actor.action_state)
	#	if !can_launch_skill?($data_arpgskills["NpcShamanBuff"])
	#		return false
	#	else
	#		@target = target
	#	end
	#	@event.turn_toward_character(target)
	#	@targetLock_HP = 0
	#	launch_skill($data_arpgskills["NpcShamanBuff"])
	#	true
	#end
	
	def set_assaulter_skill(dist)
		super
		gen_wander_range_count if @skill
	end
	
	def set_killer_skill(dist)
		super
		gen_wander_range_count if @skill
	end

	def gen_wander_range_count
		@wander_count = 0
		@wander_range_count = 0
		@wander_range_max = rand(80)+40
	end
	
	def get_move_command
		return if @event.chk_skill_eff_reserved
		tgt = get_target
		return [:move_random] if tgt.nil?
		return self.process_target_lost if tgt.deleted?
		near = @event.near_the_target?(tgt,safe_distance)
		case @event.npc.ai_state
			when :fucker
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !@event.near_the_target?(tgt,2)
				return [:turn_toward_character,tgt]
			else
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !near
				@wander_range_count += 1
				return [:move_toward_TargetSmartAI,tgt] if @wander_range_count % @wander_range_max == 0
				return [:turn_toward_character,tgt]
		end
	end
	
	def aggro_allowed?(attacker,skill)
		return false if @skill && @skill.is_support && @skill.no_interrupt && @action_state == :skill
		return super
	end
end
