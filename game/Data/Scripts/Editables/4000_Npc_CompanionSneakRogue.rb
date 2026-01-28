#怪物在遊戲中的token，在Game_Event中設定怪物時被初始化並傳入，與怪物相關的戰鬥數據均在此處處理
#基本怪物類型，視需求製造class並附寫
#哥布林AI，走三部打一步
class Npc_CompanionSneakRogue < Game_NonPlayerCharacter
	attr_accessor	:movement
	def setup_npc
		gen_wander_range_count
		super
		@movement = :normal
		@default_fucker_condition		= @fucker_condition.clone
		@default_killer_condition 		= @killer_condition.clone
		@default_assaulter_condition	= @assaulter_condition.clone
		skills = ["DaggerHeavy","ThrowingKnivesHeavy", "KatanaNormal"]
		@skills_killer_list=@skills_assaulter_list=skills
		clear_cached_skill
		#@event.summon_data = {} if !@event.summon_data
	end
	
	def set_assaulter_skill(dist)
		super
		gen_wander_range_count if @skill
	end
	
	def set_killer_skill(dist)
		super
		gen_wander_range_count if @skill
	end
	
	def update_frame
		#p "#{@event.summon_data[:CallMarkedX]} #{@event.summon_data[:CallMarkedY]} #{@event.summon_data[:CallMarked]}"
		@event.call_balloon(11,-1) if @event.balloon_id == 0 && @event.summon_data && @event.summon_data[:CallMarked] == true
		move_normal if @master == $game_player && $game_player.check_companion_assemblyCall?
		super
	end
	def check_skill_cancel_by_hit(user,skill)
		move_normal
		super(user,skill)
	end
	def process_skill_result(skill)
		move_normal
		super(skill)
	end
	def move_sneak
		return if @movement == :sneak
		tmpfatigue = self.is_fatigue?
		tmpfatigue_WithState = self.state_stack(14) >= 1 #Fatigue
		return if tmpfatigue && !tmpfatigue_WithState
		@event.character_index = 3
		@movement = :sneak
		@event.opacity = 175
		@stat.set_stat_m("move_speed",2.9,[0,2,3])
		@stat.set_stat("move_speed",@stat.get_stat("move_speed",ActorStat::MAX_STAT))
		@fucker_condition={"sex"=>[65535, "="]}
		@killer_condition={"sex"=>[65535, "="]}
		@assaulter_condition={"sex"=>[65535, "="]}
		@event.set_move_speed
		skills = ["DaggerControl"]
		@skills_killer_list=@skills_assaulter_list=skills
		clear_cached_skill
		SndLib.sound_equip_armor(@event.report_distance_to_vol_close)
	end
	def move_normal
		return if @movement == :normal
		tmpfatigue = self.is_fatigue?
		tmpfatigue_WithState = self.state_stack(14) >= 1 #Fatigue
		return if tmpfatigue && !tmpfatigue_WithState
		@event.character_index = @event.chs_definition.chs_default_index[event.charset_index]
		@movement = :normal
		@event.opacity = 255
		@stat.set_stat_m("move_speed",4,[0,2,3])
		@stat.set_stat("move_speed",@stat.get_stat("move_speed",ActorStat::MAX_STAT))
		@fucker_condition=		@default_fucker_condition
		@killer_condition=		@default_killer_condition
		@assaulter_condition=	@default_assaulter_condition
		@event.set_move_speed
		skills = ["DaggerHeavy","ThrowingKnivesHeavy", "KatanaNormal"]
		@skills_killer_list=@skills_assaulter_list=skills
		clear_cached_skill
		SndLib.sound_equip_armor(@event.report_distance_to_vol_close)
	end
	def scoutcraft
		return @scoutcraft if @movement == :sneak
		return super
	end
	def gen_wander_range_count
		@wander_count = 0
		@wander_range_count = 0
		@wander_range_max = rand(80)+40
	end
	
	def get_move_command
		return if @event.chk_skill_eff_reserved
		assemble = self.master == $game_player && $game_player.check_companion_assemblyCall?
		tgt = get_target
		if @event.follower[0] == 1 && assemble
			return [:move_goto_xy,$game_player.crosshair.x,$game_player.crosshair.y] if $game_player.crosshair.x != @event.x || $game_player.crosshair.y != @event.y
			return if tgt.nil?
			return [:turn_toward_character,tgt]
		end
		return if tgt.nil?
		near = @event.near_the_target?(tgt,safe_distance)
		case @ai_state
			when :fucker
				return [:move_random] if same_xy?(tgt) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !@event.near_the_target?(tgt,2)
				return [:turn_toward_character,tgt]
			else
				return [:turn_toward_character,tgt] if event.follower[1] == 0 && event.summon_data && event.summon_data[:CallMarkedX] == @event.x && event.summon_data[:CallMarkedY] == @event.y
				return [:move_toward_XY_SmartAI,event.summon_data[:CallMarkedX],event.summon_data[:CallMarkedY]] if event.follower[1] == 0 && event.summon_data && event.summon_data[:CallMarkedX] && event.summon_data[:CallMarkedY]
				return [:move_random] if same_xy?(tgt) && !(event.follower[0] == 1 && event.follower[1] ==0) #move_away if same xy
				return [:move_toward_TargetSmartAI,tgt] if !near && !(event.follower[0] == 1 && event.follower[1] ==0)
				return [:turn_toward_character,tgt]
		end
	end
	


end
