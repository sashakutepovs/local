#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
#==============================================================================
# ** Game_Event
#------------------------------------------------------------------------------
#  This class handles events. Functions include event page switching via
# condition determinants and running parallel process events. Used within the
# Game_Map class.
#==============================================================================
#==============================================================================
# Custom move_type list:
#
#	0 : fixed
#	1 : random
#	2 : approach(move_toward_player)
#	3 : custom
#	4 : move_toward_xy(investigate)
#	5 : move_type_return
#	6 : move_npc_movement
#
#==============================================================================

class Game_Event < Game_Character
	include PreLaunchConfig
	include Sex
	attr_accessor :character_index
	#--------------------------------------------------------------------------
	# * Public Instance Variables
	#--------------------------------------------------------------------------
	attr_accessor :trigger                  # trigger
	attr_accessor   :list                   # list of event commands
	attr_reader   :starting                 # starting flag
	attr_accessor	:npc
	attr_reader	:none_count
	attr_reader	:priority_type
	attr_reader	:move_route
	attr_reader	:move_route_forcing
	attr_reader	:move_route_index
	attr_reader	:page
	attr_accessor	:skill_eff_reserved
	attr_accessor	:player_control_mode_timer
	attr_accessor	:move_type
	attr_accessor :debug_this_one
	attr_accessor :single_chs
	attr_accessor :follower
	attr_accessor :custom_page
	attr_accessor :summoner_id
	attr_accessor :traffic_jam_abandom
	#attr_accessor :player_reward_point
	attr_reader	:npc_name
	attr_reader	:summon_data
	attr_accessor	:nappable 				#nap後事件是否依然存在，預設true，暫存性事件預設為false
	attr_accessor	:nap_initialize			#What to do when nap,
											#-1 > default >  always reinit
											#0  > common > will not reinit, init day / night # basicly usless
											#1  > day common > will not reinit, only init  when day # basicly usless
											#2  > night common > will not reinit, only init when night # basicly usless
											#3  > will not reinit.
	attr_accessor	:reset_strong			#重社事件時是否重新處理整個page(包含位置)
	attr_accessor :foreign_event				#是否事由library傳入的物件。
	attr_accessor :grab_boundary
	attr_reader	:last_refreshed			#最後一次refresh這個事件的日期
	attr_reader	:selector				#事件是否為選取框類型
	attr_reader	:erased
	attr_reader	:is_overmap_char
	attr_accessor :flying
	attr_accessor :missile
	attr_accessor :force_update
	attr_accessor :force_update_actor
	attr_accessor :c #char wont return to original X Y D
	attr_accessor :force_NpcAbleTrigger #NPC ??????????(??) ?????????
	attr_accessor :overmapFollower
	attr_accessor :delete_frame
	attr_accessor :isFish
	attr_accessor :isFloat
	attr_accessor :region_trigger
	attr_accessor :failedMoveRngMove
	attr_accessor :failedMoveCount
	attr_accessor :move_frequency
	attr_accessor :dodge_frame
	attr_accessor :manual_page_index
	attr_accessor :manual_pattern
	attr_accessor	:manual_priority
	attr_accessor :backgroundEvent
	attr_reader 	:original_x
	attr_reader 	:original_y
	attr_accessor	:overmap_char
	attr_accessor	:over_trigger
	attr_reader	:sensor_freq
	attr_reader	:show_in_fog
	attr_reader	:sex_state
	attr_reader	:event
	attr_reader	:traffic_jam_return
	attr_accessor	:skill_eff_reserved
	attr_accessor	:npc_detached
	#attr_accessor	:trade_point
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     event:  RPG::Event
  #--------------------------------------------------------------------------
	def initialize(map_id, event,summon_data=nil)
		super()
		#return self.name if @simpleEvent #setupExtraContents(getInitPage,@nap_initialize) if @simpleEvent
		@map_id = map_id
		@event = event
		@id = @event.id
		moveto(@event.x, @event.y)
		@dodge_frame=0
		@deleted=false
		@turn_count=5
		@debug_this_one=false
		@sensor_stop_count=0
		@traffic_jam_wait_frame =0
		@traffic_jam_abandom = 0
		@follower=[0,0,0,0] #[0] is a follower?  [1]1= follow,0=stand [2]1front 0back -1EXT [3]unused
		@single_chs=true
		@summon_data=summon_data
		@nap_initialize=-1
		@nappable=true
		@reset_strong=true
		@initialized=false
		@foreign_event=false
		@npc_detached= false
		@region_trigger = nil #nil??????nil?????????region_id???
		@over_trigger = nil #nil?0,1 ???nil?????????????? ?1????(lock)? 0 ????
		@overmap_char = nil
		@is_overmap_char=false
		@skill_eff_reserved = false
		@flying=false
		@isFish=false
		@isFloat=false
		@missile=false
		@selector=false
		@overmapFollower=false
		@delete_frame=-1
		@grab_count=0
		@grab_boundary=180
		@show_in_fog=true
		#@player_reward_point =0 #unused
		@traffic_jam_return =0
		@force_update = false
		@force_update_actor = true
		@reach_anomally_count =0
		@failedMoveRngMove = false
		@failedMoveCount = 0
		init_sex_system
		refresh
	end
  #--------------------------------------------------------------------------
  # * Initialize Public Member Variables
  #--------------------------------------------------------------------------
	def init_public_members
		super
		@trigger = nil
		@list = nil
		@starting = false
	end

  #--------------------------------------------------------------------------
  # * Initialize Private Member Variables
  #--------------------------------------------------------------------------
	def init_private_members
		super
		@move_type = 0                        # Movement type
		@erased = false                       # Temporary erase flag
		@page = nil                           # Event page
	end


  #--------------------------------------------------------------------------
  # * Memorize Move Route
  # * ????????
  #--------------------------------------------------------------------------
	def memorize_move_route
		@original_move_route        = @move_route
		@original_move_route_index  = @move_route_index
		@original_x= self.x
		@original_y= self.y
	end


  #--------------------------------------------------------------------------
  # * Detect Collision with Character
  #--------------------------------------------------------------------------
  # * Detect Collision with Player (Including Followers)y
  #--------------------------------------------------------------------------
  def collide_with_player_characters?(x, y)
    normal_priority? && $game_player.collide?(x, y)
  end
  #--------------------------------------------------------------------------
  # * Lock (Processing in Which Executing Events Stop)
  #--------------------------------------------------------------------------
  def lock
    unless @locked
      @prelock_direction = @direction
      turn_toward_player
      @locked = true
    end
  end
  #--------------------------------------------------------------------------
  def collide_with_characters?(x, y)
    super || collide_with_player_characters?(x, y)
  end
  #--------------------------------------------------------------------------
  # * Detect Collision with Player (Including Followers)y
  #--------------------------------------------------------------------------
  def collide_with_player_characters?(x, y)
    normal_priority? && $game_player.collide?(x, y)
  end

  #--------------------------------------------------------------------------
  # * Unlock
  #--------------------------------------------------------------------------
  def unlock
    if @locked
      @locked = false
      set_direction(@prelock_direction)
    end
  end


	def update_routine_move
		return if @stop_count < stop_count_threshold
		super
	end

	def process_npc_end_route
		restore_move_route
		@original_x=nil
		@original_y=nil
		@npc.target_lost=false
		@move_type = @manual_move_type.nil? ? @page.move_type : @manual_move_type
		@move_frequency = @manual_move_frequency.nil? ? @page.move_frequency : @manual_move_frequency
		@direction=@page.graphic.direction
	end

	def process_npc_DestroyForceRoute
		@original_x=nil
		@original_y=nil
		@npc.target_lost=false
		@move_type = @manual_move_type.nil? ? @page.move_type : @manual_move_type
		@move_frequency = @manual_move_frequency.nil? ? @page.move_frequency : @manual_move_frequency
	end

	def get_manual_move_speed
		@manual_move_speed
	end
	def set_manual_character_index(tmpNum)
		@manual_character_index = tmpNum
	end
	def set_manual_move_speed(tmpNum)
		@manual_move_speed = tmpNum
	end
	def get_manual_move_type
		@manual_move_type
	end
	def set_manual_move_type(tmpNum)
		@manual_move_type = tmpNum
	end
	def manual_move_type=(tmpNum)
		@manual_move_type = tmpNum
	end
	def set_manual_trigger(tmpNum)
		@manual_trigger = tmpNum
	end
	def set_move_frequency(tmpNum)
		@manual_move_frequency = tmpNum
	end
	def set_sensor_freq(tmpNum)
		@sensor_freq = tmpNum
	end

	def left_job?
		return false if @original_x.nil? || @original_y.nil?
		return false if @original_x==self.x && @original_y==self.y
		return true  if @npc.action_state!=:none || @original_move_route
		return true  if @npc.target_lost
		return true
	end

	def update #33_Game_CharacterBase.rb
		update_character_ex_effects
		update_animation
		return update_jump if jumping?
		return update_move if moving?
		return update_stop
	end
  #----------

	def update_stop
		if !turn_based? || my_turn? || @overmapFollower
			update_npc_stop
			#super
			@stop_count += 1 unless @locked #33_Game_CharacterBase.rb
			update_routine_move if @move_route_forcing #34_Game_Character.rb
			update_self_movement
			finish_turn
		end
	end
	def update_npc_stop
		return if !@npc || @npc_detached
		@npc.update_npc_steps if @missile
		return if !use_chs?
			tmpfatigue = @npc.is_fatigue?
			tmpfatigue_WithState = @npc.state_stack(14) >= 1 #Fatigue
			if tmpfatigue && !tmpfatigue_WithState #sta???????????
				@character_index  = @manual_character_index.nil? ? 3 : @manual_character_index
				@npc.add_state("Fatigue") if @npc.state_stack(14) == 0
			elsif !tmpfatigue && tmpfatigue_WithState
				chs_index= @charset_index
				@character_index = self.chs_definition.chs_default_index[chs_index]
				@npc.remove_state(14)
			end
	end
	def pages
		@pages
	end

  def update_delete_frame
	return @delete_frame -= 1 if @delete_frame > 0
	if @delete_frame == 0
		@npc.set_action_state(:death,true) if @npc && @npc.action_state != :death
		@opacity -= 5
		self.delete if @opacity <=50
	end
  end



	#??????NPC?????????NPC?????????????????????force_route
	def update_npc
	#p "update_npc @npc.nil?=>#{@npc.nil?} @erased=>#{@erased} @npc_detached=>#{@npc_detached} !npc.action_changed?=>#{!npc.action_changed?}" if @debug_this_one
		return if $game_map.interpreter.running? || $game_message.busy?
		return if !@npc || erased?
		return update_npc_skill if @combo_original_move_route && @npc.action_state == :skill
		return if !@force_update_actor
		setup_npc_effect if @npc.action_changed?
		update_delete_frame
		return if @npc_detached
		#return if @npc.action_state == :death
		case @npc.action_state
			when :death
				update_rez_dead_npc
			when :sex;
				update_npc_sex
				update_npc_dodge_and_aggro
			when :skill;
				update_npc_skill;
				update_npc_dodge_and_aggro
			when :grabber;
				update_npc_grabber;
				update_npc_dodge_and_aggro
			when :grabbed;
				update_npc_grabbed;
				update_npc_dodge_and_aggro
			else
				#p "Asdasdasd #{@npc.action_state}"
				update_npc_control_mode if @player_control_mode_timer
				unset_chs_sex if sex_mode? && !@eventSexMode && !@story_mode_sex # to protect Error CHSH happen in ghost frame
				@npc.update_state_frames;
				@npc.update_stun;
				update_npc_sensor;
				update_npc_dodge_and_aggro
		end
	end
	def update_npc_control_mode
		@player_control_mode_timer -= 1
		self.actor.player_control_mode(false) if @player_control_mode_timer <= 0
	end
	def update_npc_dodge_and_aggro
		update_dodge
		@npc.update_frame
	end
	def npc_story_mode(tmpSet,tmpDestroyForceRoute=true)
		if tmpDestroyForceRoute
			self.process_npc_DestroyForceRoute if self.npc?
			self.moveto(@x,@y)
		end
		@force_update = tmpSet
		@force_update_actor = !tmpSet
	end

	def npc_stop_update(tmpSet,tmpDestroyForceRoute=true)
		if tmpDestroyForceRoute
			self.process_npc_DestroyForceRoute if self.npc?
			self.moveto(@x,@y)
		end
		@force_update = false
		@force_update_actor = !tmpSet
	end

	def update_npc_grabber
		if @npc.fucker_target.nil? || !@npc.fucker_target.grabbed?
			unset_chs_sex #2022_11_16
			@npc.set_action_state(:none)
			@npc.fucker_target=nil
		elsif @npc.fucker_target.passively_grabbed? && @npc.fucker_target.grabber!=self
			unset_chs_sex #2022_11_16
			@npc.set_action_state(:none)
			@npc.fucker_target=nil
		end
	end

  #3 ????sex
	def update_npc_grabbed
		return @grabber.set_chs_sex_group if @grabber == $game_player
		@grab_count+=1
		if @grab_count > @grab_boundary
			actor.set_action_state(:none,true)
			return
		end
		return unless @grab_count == @grab_boundary
		return set_chs_sex_group if @grabber.nil?
		if @grabber.fuckers.empty? || @grabber.actor.fucker_target.nil?
			@grabber.add_sex_gang(self)
			actor.fucker_target = @grabber
			@grabber.set_chs_sex_group
		else
			@grabber.set_chs_sex_group
		end
	end

	def update_npc_sex
		return if @story_mode_sex == true
		return unset_chs_sex if actor.target != nil && [nil, :none, :death, :skill].include?(actor.target.actor.action_state) && !sex_receiver?# && !self.use_chs?
		return unset_chs_sex if actor.fucker_target == nil && actor.target == nil && actor.action_state == :sex && !sex_receiver?
		return unset_chs_sex if self.actor.fucker_target != nil && self.actor.fucker_target.actor.action_state != :sex && !sex_receiver?
		return if !sex_receiver?
		return release_chs_group if @sex_count>740
		@sex_count+=1
		@fuckers.reject!{|fker| !fker.sex_mode?}
		if @fuckers.length==0
			release_chs_group
			return
		end
		case
			when @sex_state==1 && @sex_count>=360
				self.state_sex_spread_to_fucker(@fuckers) if sex_receiver?
				@sex_state=2
				actor.set_action_state(:sex,true)
			when @sex_state==2 && @sex_count>=540
				@sex_state=3
				actor.set_action_state(:sex,true)
			when @sex_state==3 && @sex_count>=720;
				#run_STD_check = sex_receiver?
				#tgtFuckers = []
				#tgtFuckers+=fuckers
				self.state_sex_spread_to_reciver(@fuckers) if sex_receiver?
				actor.set_action_state(:none,true)
				release_chs_group
				@npc.refresh
				@sex_count=0
			end
	end



	#??action_state
	def update_npc_skill
		return unless @npc.action_state==:skill
		@npc.update_skill_eff
	end

	def setup_npc_effect
		@grab_count=0
		case @npc.action_state
			when :death;
				setup_dead_npc
			when nil;
				if @npc.target_lost
					setup_return
				else
					set_move_speed
				end
			when :none;
				if @npc.ai_state==:flee
					@traffic_jam_return = 0
					@reach_anomally_count = 0
					setup_flee
				elsif @npc.alert_level==1
					@traffic_jam_return = 0
					@reach_anomally_count = 0
					@opacity = 255
					setup_investigate
				elsif @npc.alert_level==2
					@traffic_jam_return = 0
					@reach_anomally_count = 0
					@opacity = 255
					setup_track_target
				elsif @npc.target_lost
					setup_return
				else
					setup_return
				end
			when :skill;
				setup_skill_effect;
			when :stun;
				setup_stun_effect;
			when :grabbed;
				setup_npc_grabbed;
			when :grabber;
				setup_npc_grabber;
			when :sex;
				setup_npc_sex;
		end
		cancel_stun_effect if @npc.action_state != :death && @prev_action_state == :stun && @npc.action_state != :stun
		if @prev_action_state== :sex && @npc.action_state != :sex && @npc.action_state != :death
			release_chs_group #if @prev_action_state== :sex && @npc.action_state!=:sex
		end
		@move_type = 0 if @npc.move_speed == 0 && @move_type != 3 #for combo skill controller.
		@prev_action_state=@npc.action_state
		@npc.change_acknowledged
	end

	def set_move_speed
		return if @page.nil? || @npc.nil?
		if @page.move_speed <@npc.move_speed
			@move_speed=@page.move_speed
		else
		@move_speed=@npc.move_speed
		end
	end

	def setup_stun_effect
	#msgbox "@prev_action_state=>#{@prev_action_state}"
	#if [:sex,:grabbed,:grabber].include?(@prev_action_state)
	release_chs_group
	actor.set_action_state(:stun,true)
	#end
	@move_type=0
	self.animation=animation_stun if use_chs?
		#@npc.show_states
		#sap ?13 ???stun?14
		if @npc.sapped
			self.call_balloon(13,-1)
		else
			self.call_balloon(14,-1)
		end
	end#14

	def setup_fap_effect
		release_chs_group
		actor.set_action_state(:stun,true)
		@move_type=0
		self.animation=animation_masturbation if use_chs?
		self.call_balloon(0)
	end#14

	def setup_shock_effect
		release_chs_group
		actor.set_action_state(:stun,true)
		@move_type=0
		self.animation=animation_grabbed_qte if use_chs?
		self.call_balloon(6)
	end#14

	def setup_pindown_effect
		release_chs_group
		actor.set_action_state(:stun,true)
		@move_type=0
		self.animation=animation_pindown_qte if use_chs?
		self.call_balloon(0)
	end#14

	def setup_cuming_effect
		release_chs_group
		actor.set_action_state(:stun,true)
		@move_type=0
		self.animation=animation_cuming_qte if use_chs?
		self.call_balloon(0)
	end#14


	def setup_skill_effect
		@move_type=0
		return @npc.reset_skill if @npc.skill.nil?
		self.animation=send(@npc.current_animation) unless @npc.current_animation.nil?
		@skill_eff_reserved=true if !@npc.skill.nil? && @npc.skill.wait_hit_frame
	end


  def setup_npc_sex
	#return unset_chs_sex if !sex_receiver? && actor.fucker_target.nil?
	if !sex_receiver? && !actor.fucker_target.nil? && !actor.fucker_target.fuckers.include?(self) #female mode
		actor.reset_aggro
		return unset_chs_sex
	end
	if actor.fucker_target.nil? && !sex_receiver? #male mode
		actor.reset_aggro
		return unset_chs_sex
	end
	@move_type=0
	cancel_sex_snd
	actor.reset_skill
	actor.skill=nil
	@npc.set_action_state(:sex)
	@npc.change_acknowledged
	case @sex_state
		when 1;
			self.animation=animation_sex;
			$game_map.reserve_summon_event("EfxSexStage_1",self.x,self.y,-1,{:user=>self}) if sex_receiver?;
		when 2;
			self.animation=animation_sex_fast;
			$game_map.reserve_summon_event("EfxSexStage_2",self.x,self.y,-1,{:user=>self}) if sex_receiver?;
		when 3;
			self.animation=animation_sex_cumming;
			$game_map.reserve_summon_event("EfxSexStage_3",self.x,self.y,-1,{:user=>self}) if sex_receiver?;
		when 4;release_chs_group if sex_receiver?
	end
  end

  def setup_npc_grabber
	return self.unset_chs_sex if actor.fucker_target.nil?
	cancel_stun_effect
	self.animation=animation_grabber_qte(actor.fucker_target.id)
	@move_type=0
  end

	def setup_npc_grabbed
		cancel_stun_effect
		moveto(self.x,self.y)
		@move_type=0
		self.animation=animation_grabbed_qte
		actor.reset_skill
		actor.change_acknowledged
	end

	def update_npc_sensor
		if turn_based?
			return if !my_turn?
		else
			return if (@sensor_stop_count+=1) < sensor_stop_count_threshold
		end
		return if @npc.action_state==:sex || @npc.action_state==:stun
		@npc.sense_target(self,1)
		@sensor_stop_count=0
	end


	def setup_return
		set_move_speed
		if self.is_follower?
			return @move_type = :companion_chase_character_front if @summon_data && @summon_data[:followerFRONT]
			return @move_type = :companion_chase_character_back if @summon_data && @summon_data[:followerBACK]
			return @move_type = :companion_chase_character_ext if @summon_data && @summon_data[:followerEXT]
			return @move_type = 3
		end
		@move_type = :move_type_return
		@move_frequency = 5
	end

	def setup_flee
		@story_mode_sex = nil
		@move_type=7
		@move_speed=@npc.move_speed
		set_awareness_ballon
	end

	def setup_investigate
		@story_mode_sex = nil
		self.animation=nil
		set_awareness_ballon
		memorize_move_route unless @original_move_route
		@move_route_forcing=false
		set_move_speed
		@move_type = 4
		@move_frequency = 5
	end

	def setup_track_target
		@story_mode_sex = nil
		self.animation=nil
		set_awareness_ballon
		memorize_move_route unless @original_move_route
		@move_speed= @npc.move_speed
		@move_frequency = 5 if @move_frequency !=5
		$game_map.isOverMap ? @move_type=2: @move_type=6
		@move_route_forcing=false
	end

  def set_awareness_ballon
		aware = @npc.balloon_id
		self.balloon_id=aware if aware!=0
  end
	def update_rez_dead_npc
		#p "sdasdasd #{@npc.dedAnimPlayed} "
		return @npc.set_action_state(:death,true) if !@npc.dedAnimPlayed ## test_update line 11102022
		return if !@update_rez
		return if sex_mode?
		return if self.deleted? || @npc.action_state != :death
		return if @npc.is_object
		@rez_begin = true if @rez_begin.nil?
		if @rez_begin
			@forced_z = 0
			@forced_x = 0
			@forced_y = 0
			@direction_fix = @page.direction_fix
			@walk_anime	= @manual_walk_anime.nil? ? @page.walk_anime : @manual_walk_anime
			@step_anime	= @manual_step_anime.nil? ? @page.step_anime : @manual_step_anime
			@through = @manual_through.nil? ? @page.through : @manual_through
			@trigger = @manual_trigger.nil? ? @page.trigger : @manual_trigger
			@priority_type = @manual_priority.nil? ? @page.priority_type : @manual_priority
			chs_index = @charset_index
			@character_index = @manual_character_index = self.chs_definition.chs_default_index[chs_index]
			@pattern = @manual_pattern = 1
			self.animation = self.overkill_animation_fast_rez
			@rez_begin = false
		end
		return if self.animation# && @rez_begin == true
		clear_effects
		@rez_begin = nil
		@update_rez = nil
		@npc.battle_stat.set_stat_m("health",@npc.battle_stat.get_stat("health",2),[0])
		@npc.battle_stat.set_stat_m("sta",@npc.battle_stat.get_stat("sta",2),[0])
		@npc.process_target_lost if @npc.target
		@manual_move_type ? @move_type = @manual_move_type : @move_type = @page.move_type
		@npc.set_action_state(nil,true)
		@npc.dedAnimPlayed_reset
		@npc.change_acknowledged
		@npc.remove_state(1)
	end

	def get_start_rez
		@update_rez
	end
	def set_start_rez(tar)
		@update_rez = tar
	end

	def update_combo_skill
		if actor.npc_dead? #actor.action_state == :death
			npc_stop_update(false,false)
			restore_move_route
			process_npc_DestroyForceRoute    #off common because npc still moving after death, but cause npc dead with walking sprite
			process_npc_end_route   #u
			combo_force_move_route_clearn #a addon to stop npc use walking speite when death,   make this function update b4 death.
			actor.update_npc_stat
		else
			actor.set_action_state(:none)
		end
	end

	def end_combo_skill
		if @npc.npc_dead? #actor.action_state == :death
			combo_force_move_route_clearn
			npc_stop_update(false,false)
			restore_move_route
			actor.update_npc_stat
		else
			combo_force_move_route_reset
			combo_force_move_route_clearn
			@npc.combo_end_target_reset
			npc_stop_update(false)
		end
	end

	def setup_dead_npc
		return unset_chs_sex if @story_mode_sex
		return @npc.set_action_state(:sex,true) if sex_mode?
		clear_effects
		cancel_stun_effect
		@move_type = 0
		@npc.change_acknowledged
		@priority_type=0
		@forced_z = 8
		@through=true
		@trigger = -1
		@update_rez = nil
		@direction_fix = true
		setup_drop_item
		@npc.pick_death_animation
		@npc.set_dedAnimPlayed(true)
		setup_npc_death_animation
		@npc.summon_death_event
		if @npc.delete_immediately? #Galv_MoveRouteExtra
			@opacity=0
			delete
			return
		end
		$story_stats["record_killcount"]["#{@npc.npc_name}"] += 1 if traceKillCount
		@delete_frame = @npc.delete_when_death if @delete_frame==-1 && !@npc.delete_when_death.nil? && @npc.delete_when_death !=-1
		movetoRolling(@x,@y) if moving?
	end

	#for event
	def setup_dead_event(cropse_graphics=0)
		@chs_need_update=true
		$game_player.delete_follower(@id)
		$game_map.delete_npc(self) if @npc
		@npc = nil
		@through = true
		@priority_type = 0
		@npc_detached = true
		@trigger = -1
		@manual_trigger = -1
		@move_type = 0
		@manual_move_type = nil
		@balloon_id = 0
		setup_cropse_graphics(cropse_graphics)
	end
	def cancel_stun_effect
		@balloon_id=0
		self.animation=nil
	end

	def setup_cropse_graphics(tmpPick=rand(3),tmpInit=false)
		@walk_anime = false
		@step_anime = false
		@forced_y = -10+rand(21)
		@forced_x = -10+rand(21)
		case tmpPick
			when 0 #over f
				@direction = 6
				@manual_character_index = 7
				@character_index = 7 if !tmpInit
				@manual_pattern = 0
				@pattern= @manual_pattern if !tmpInit
			when 1 #blood
				@direction = 6
				@manual_character_index = 7
				@character_index = 7 if !tmpInit
				@manual_pattern = [1,2].sample
				@pattern= @manual_pattern if !tmpInit
			else #over kill
				@direction = 8
				@manual_character_index = 7
				@character_index = 7 if !tmpInit
				@manual_pattern = 2
				@pattern= @manual_pattern if !tmpInit
		end
		#msgbox "d=#{@direction} p#{@pattern} ci#{@character_index}"
	end

	def setup_drop_item
		return unless @npc.action_state==:death
		p "setup_drop_item =>#{@event.name}"
		itemlist=@npc.get_drop_list
		itemDropped = []
		itemlist.each{
			|item|
			next if item.nil?
			next if itemDropped.include?(item)
			itemDropped << item if $data_ItemName[item] && ["Weapon","Armor"].include?($data_ItemName[item].type)
			$game_map.reserve_summon_event(item,@x,@y)
		}
		@npc.change_acknowledged
	end

	def setup_npc_death_animation
		npc_ani=@npc.get_animation
		if !npc_ani.nil? && use_chs?
			self.animation=send(npc_ani)
		end
	end


  def at_left_position?
	return self.x==@original_x && self.y==@original_y
  end

  def target_acquired?
	!@npc.get_target.nil? && @npc.action_changed?
  end





	def set_move_goto_xy(x,y)
		@move_type = :move_goto_original_xy
		@move_goto_X = x
		@move_goto_Y = y
	end


  #--------------------------------------------------------------------------
  # * Update During Autonomous Movement
  #--------------------------------------------------------------------------
	def normal_move_type?
		[
			0,1,2,3,9,10,11,
			:companion_chase_character_ext,
			:companion_chase_character_back,
			:companion_chase_character_front,
			:move_toward_player_no_rng,
			:move_away_from_player
		].include?(@move_type)
	end
	def update_self_movement
		return if @move_type == 0
		return if stop_count_threshold > @stop_count
		case @move_type
			when 1;  move_type_random
			when 2;  move_type_toward_player
			when :move_toward_player_no_rng;  move_toward_player_no_rng
			when 3,:move_type_custom;  move_type_custom
			when :move_away_from_player;  move_away_from_character($game_player)

			# ?mode and return mode
			when 4;  move_type_xy #when alert lvl 1,   ? mode
			when :move_type_xy_end;  move_type_xy_end # a short idle b4 move_type_return
			when :move_type_return;  move_type_return # when cannot find target. back to original XY

			when 6;  move_npc_movement
			when 7; return if @npc.get_target.nil? #flee
					move_away_from_character(@npc.get_target)
			when 8,:move_search_player;  move_search_player # when encounter, and saw player
			when 9,:companion_chase_character_ext;  companion_chase_character_ext($game_player) if self.follower[1] == 1
			when 10,:companion_chase_character_back; companion_chase_character_back($game_player)
			when 11,:companion_chase_character_front; companion_chase_character_front($game_player)
			when 12; companion_move_type_xy
			when 13; move_by_trace #mostly for event camera like cannon minigame.
			when :combo_skill; move_type_custom #combo prework
			when 15; stackWithTarget(@summon_data[:target],@stackX,@stackY)
			when 16; move_patrol
			when 17; move_patrol_search_player
			when :control_this_event_with_skill; control_this_event(checkSkill=self.npc?,ignoreAnimation=true) #full control a npc. and able to use skill
			when :control_this_event; control_this_event(checkSkill=false) #control no skill
			when :move_goto_original_xy; move_goto_xy(@move_goto_X,@move_goto_Y) #control no skill
		end
	end

	#put this on their moveroute or set move_type = 12(suggest move_type)
	#only support player basic charge and normal skills
	def control_this_event(checkSkill=self.npc?,ignoreAnimation=false)
		@move_frequency		= 5
		return if @animation && !ignoreAnimation
		if self.actor
			if Input.press?(:SHIFT)
				@move_speed = self.actor.move_speed
			else
				@move_speed = self.actor.move_speed-1
			end
			@move_speed = 1 if @move_speed < 1
			tmpSkillList = self.actor.player_control_mode_skills if checkSkill
			if checkSkill && self.npc? && [:none,nil].include?(self.npc.action_state) && self.npc? && tmpSkillList.length >= 1 #todo add skill usable?
				tmpSuccess = false
				if Input.trigger?(:S1) && !tmpSkillList[0].nil? then self.actor.launch_skill($data_arpgskills[tmpSkillList[0]],true)	; tmpSuccess =true ; end
				if Input.trigger?(:S2) && !tmpSkillList[1].nil? then self.actor.launch_skill($data_arpgskills[tmpSkillList[1]],true)	; tmpSuccess =true ; end
				if Input.trigger?(:S3) && !tmpSkillList[2].nil? then self.actor.launch_skill($data_arpgskills[tmpSkillList[2]],true)	; tmpSuccess =true ; end
				if Input.trigger?(:S4) && !tmpSkillList[3].nil? then self.actor.launch_skill($data_arpgskills[tmpSkillList[3]],true)	; tmpSuccess =true ; end
				if Input.trigger?(:S5) && !tmpSkillList[4].nil? then self.actor.launch_skill($data_arpgskills[tmpSkillList[4]],true)	; tmpSuccess =true ; end
				if Input.trigger?(:S6) && !tmpSkillList[5].nil? then self.actor.launch_skill($data_arpgskills[tmpSkillList[5]],true)	; tmpSuccess =true ; end
				if Input.trigger?(:S7) && !tmpSkillList[6].nil? then self.actor.launch_skill($data_arpgskills[tmpSkillList[6]],true)	; tmpSuccess =true ; end
				if Input.trigger?(:S8) && !tmpSkillList[7].nil? then self.actor.launch_skill($data_arpgskills[tmpSkillList[7]],true)	; tmpSuccess =true ; end
				if Input.trigger?(:S9) && !tmpSkillList[8].nil? then self.actor.launch_skill($data_arpgskills[tmpSkillList[8]],true)	; tmpSuccess =true ; end
				if tmpSuccess
					@player_control_mode_timer -= 60 if @player_control_mode_timer
					return self.actor.play_sound(:sound_skill,self.report_distance_to_vol_close_npc_vol) if rand(100) > 60
				end
			end
		end
		return if self.moving?
		self.move_by_input(ignoreAnimation)
	end
	def move_patrol
		@wait_count -= 1 if @wait_count > 0
		return if moving? || @wait_count >= 1
		@move_patrol_count = 0 if !@move_patrol_count
		case @move_patrol_count
			when 0..5
					@move_patrol_count += 1
					move_random
			when 5..9
					move_forward
					@move_patrol_count += 1
			when 10..13
					turn_random
					@wait_count = 60+rand(90)
					@move_patrol_count += 1
			else
					@move_patrol_count = 0
		end
	end

	def move_patrol_search_player
		@wait_count -= 1 if @wait_count > 0
		return if moving? || @wait_count >= 1
		@move_patrol_count = 0 if !@move_patrol_count
		case @move_patrol_count
			when 0..9
					@move_patrol_count += 1
					move_search_player
			when 10..13
					turn_random
					@wait_count = 60+rand(90)
					@move_patrol_count += 1
			else
					@move_patrol_count = 0
		end
	end

   #get command from npc , used only when tracking target
	def move_npc_movement
		cmd=@npc.get_move_command
		return if cmd.nil?
		send(*cmd)
	end


	def too_close?(target)
		return false if target.nil?
		near_the_target?(target,@npc.safe_distance)
	end

	def move_return_teleport_to_orignal_xy
		self.npc_story_mode(false,tmpDestroyForceRoute=false)
		@opacity = @move_return_XY_original_opacity if !@move_return_XY_original_opacity.nil?
		self.actor.immune_damage = @move_return_XY_original_immune_damage if !@move_return_XY_original_immune_damage.nil?
		@move_return_XY_original_opacity = nil
		@move_return_XY_original_immune_damage = nil
		@traffic_jam_return =0
		moveto(@original_x,@original_y)
	end
	def move_return_fade_setup
		@opacity -= 15
		return if @move_return_XY_original_opacity
		self.npc_story_mode(true,tmpDestroyForceRoute=false)
		@move_return_XY_original_opacity = @opacity
		@move_return_XY_original_immune_damage = self.actor.immune_damage
		self.actor.immune_damage = true
	end

	def move_return_XY_SmartAI(tgtx,tgty,no_strand=true)
		if @failedMoveRngMove
			if @failedMoveCount >= (self.move_speed*3).round
				@failedMoveRngMove = false
				@failedMoveCount = 0
			else
				if !@move_succeed
					#p "mode move_random #{@failedMoveCount}"
					@failedMoveCount += 1
					@traffic_jam_return +=1
					return self.move_random if @failedMoveCount >= (self.move_speed*3).round
				else
					#p "mode movePathfinding #{@failedMoveCount}"
					@failedMoveCount += 1
					@traffic_jam_return +=1
					return self.movePathfindingXY
				end
			end
		end
		move_toward_xy(tgtx,tgty,false)
		if !@move_succeed && !@failedMoveRngMove
			#p "Path created"
			@traffic_jam_return +=1
			@failedMoveRngMove = true
			@failedMoveCount = 0
			createPath(tgtx,tgty) if !self.all_way_block?
		end
		#sx = distance_x_from(tgtx)
		#sy = distance_y_from(tgty)
		#if self.near_the_xy?(tgtx,tgty,2) && xy_core_block?(tgtx,tgty)
		#	@traffic_jam_return +=1
		#	turn_toward_xy(tgtx,tgty)
		#	return
		#end
		#if sx.abs > sy.abs
		#	move_straight(sx > 0 ? 4 : 6) if @sx!=0
		#	@traffic_jam_return +=1 if !@move_succeed
		#	move_straight(sy > 0 ? 8 : 2) if !@move_succeed && no_strand
		#else
		#	move_straight(sy > 0 ? 8 : 2) if @sy!=0
		#	@traffic_jam_return += 1 if !@move_succeed
		#	move_straight(sx > 0 ? 4 : 6) if !@move_succeed && no_strand
		#end
	end

	def move_toward_character(character)
		super
		move_random if !@move_succeed
	end

	def move_toward_characterRNG(character)
		if [true,false].sample
			move_toward_character(character)
		else
			move_random
		end
	end

	# Smart AI toward XY (e.g., mouse click)
	def move_toward_XY_SmartAI(tmpX, tmpY)
		@last_target_xy ||= [nil, nil]

		if @failedMoveRngMove
			if @failedMoveCount >= (self.move_speed * 2).round
				@failedMoveRngMove = false
				@failedMoveCount = 0
			else
				@failedMoveCount += 1
				return !@move_succeed ? self.move_random : self.movePathfindingXY
			end
		end

		move_toward_xy(tmpX, tmpY, false)

		if !@move_succeed && !@failedMoveRngMove
			if @last_target_xy != [tmpX, tmpY]
				createPath(tmpX, tmpY) unless self.all_way_block?
				@last_target_xy = [tmpX, tmpY]
			end
			@failedMoveRngMove = true
			@failedMoveCount = 0
		end
	end

	# Smart AI that follows a target (with optional facing)
	def move_toward_TargetSmartAI(character, faceIT = false)
		if @failedMoveRngMove
			if @failedMoveCount >= (self.move_speed * 2).round
				@failedMoveRngMove = false
				@failedMoveCount = 0
			else
				@failedMoveCount += 1
				!@move_succeed ? self.move_random : self.movePathfinding(character)
				self.turn_toward_character(character) if faceIT
				return
			end
		end

		move_toward_character(character)
		self.turn_toward_character(character) if faceIT

		if !@move_succeed && !@failedMoveRngMove
			@failedMoveRngMove = true
			@failedMoveCount = 0
			createPath(character.x, character.y) unless self.all_way_block?
		end
	end

	# Dumb AI that rushes the target but still avoids wall loops a bit
	def move_toward_TargetDumbAI(character)
		if @failedMoveRngMove
			if @failedMoveCount >= (self.move_speed * 2).round
				@failedMoveRngMove = false
				@failedMoveCount = 0
			else
				@failedMoveCount += 1
				return move_random
			end
		end

		move_toward_character(character)

		if !@move_succeed && !@failedMoveRngMove
			@failedMoveRngMove = true
			@failedMoveCount = 0
		end
	end

=begin
	#mostly for mouse input
	def move_toward_XY_SmartAI(tmpX,tmpY)
		if @failedMoveRngMove
			if @failedMoveCount >= (self.move_speed*2).round
				@failedMoveRngMove = false
				@failedMoveCount = 0
			else
				if !@move_succeed
					#p "mode move_random #{@failedMoveCount}"
					@failedMoveCount += 1
					return self.move_random
				else
					#p "mode movePathfinding #{@failedMoveCount}"
					@failedMoveCount += 1
					return self.movePathfindingXY
				end
			end
		end
		move_toward_xy(tmpX,tmpY,false)
		if !@move_succeed && !@failedMoveRngMove
			#p "Path created"
			@failedMoveRngMove = true
			@failedMoveCount = 0
			createPath(tmpX,tmpY) if !self.all_way_block?
		end
	end

	def move_toward_TargetSmartAI(character,faceIT=false)
		if @failedMoveRngMove
			if @failedMoveCount >= (self.move_speed*2).round
				@failedMoveRngMove = false
				@failedMoveCount = 0
			else
				if !@move_succeed
					#p "mode move_random #{@failedMoveCount}"
					@failedMoveCount += 1
					self.move_random
					self.turn_toward_character(character) if faceIT
					return
				else
					#p "mode movePathfinding #{@failedMoveCount}"
					@failedMoveCount += 1
					self.movePathfinding(character)
					self.turn_toward_character(character) if faceIT
					return
				end
			end
		end
		move_toward_character(character)
		self.turn_toward_character(character) if faceIT
		if !@move_succeed && !@failedMoveRngMove
			#p "Path created"
			@failedMoveRngMove = true
			@failedMoveCount = 0
			createPath(character.x,character.y) if !self.all_way_block?
		end
	end

	def move_toward_TargetDumbAI(character)
		if @failedMoveRngMove
			if @failedMoveCount >= (self.move_speed*2).round
				@failedMoveRngMove = false
				@failedMoveCount = 0
			else
				#p @failedMoveCount
				@failedMoveCount += 1 if @move_succeed
				return move_random
			end
		end
		move_toward_character(character)
		if !@move_succeed && !@failedMoveRngMove
			@failedMoveRngMove = true
			@failedMoveCount = 0
		end
	end
=end
	def move_type_return
		if self.is_follower? #|| @forced_move_type_return_off
			process_npc_end_route
			self.direction = @original_direction
		elsif @forced_move_type_return_off #no idea why this effect to other move_type.
			process_npc_DestroyForceRoute
		elsif at_left_position?
			process_npc_end_route
		else
			if @original_x.nil? && @original_y.nil?
				@move_type = @manual_move_type.nil? ? @page.move_type : @manual_move_type
			elsif @traffic_jam_return > 15
				if @opacity > 0 #when teleport fade.
					move_return_fade_setup
				else
					move_return_teleport_to_orignal_xy
				end
			else
				turn_toward_xy(@original_x,@original_y) if !@move_succeed
				if self.near_xy_but_blocked?(@original_x,@original_y)
					@traffic_jam_return +=1
				else
					move_return_XY_SmartAI(@original_x,@original_y)
				end
			end
		end
	end

	def move_type_xy
		if self.is_follower?
			@original_direction = self.direction
			@move_type = :move_type_return
			@investigate_count = nil
		elsif (!reach_anomally?) && @traffic_jam_return < 5
			if (self.x != @npc.anomally.x || self.y != @npc.anomally.y) && !self.near_xy_but_blocked?(@npc.anomally.x,@npc.anomally.y)
				self.move_return_XY_SmartAI(@npc.anomally.x,@npc.anomally.y)
			end
			if !@move_succeed
				@traffic_jam_abandom += 1
				turn_toward_xy(@npc.anomally.x,@npc.anomally.y)
			end
			if @traffic_jam_abandom > 5
				@traffic_jam_abandom = 0
				@move_type = :move_type_return
				@npc.anomally = nil
			end
		else
			@investigate_count = 60 if @investigate_count.nil?
			@npc.anomally = nil
			#p "@investigate_count #{@investigate_count}"
			@investigate_count -= 1
			if @investigate_count <= 0
				@move_type = :move_type_xy_end
				@investigate_count = 60
			end

		end
	end

	def move_type_xy_end
		@investigate_count -= 1
		if @investigate_count <= 0
			@investigate_count = nil
			@move_type = :move_type_return
		end
	end


	def reach_anomally?
		return true if @npc.anomally.nil?
		@reach_anomally_count +=1
		return true if self.near_xy_but_blocked?(@npc.anomally.x,@npc.anomally.y)
		if @reach_anomally_count >= 30
			return true if @npc.anomally.x==self.x && @npc.anomally.y==self.y
		else
			return false
		end
		return false
		#@traffic_jam_return =0
		#@npc.anomally.x==self.x && @npc.anomally.y==self.y
	end
	def near_xy_but_blocked?(tmpX,tmpY)
		return true if self.report_range_xy(tmpX,tmpY) <= 1 && self.facing_xy?(tmpX,tmpY) && !self.passable?(self.x,self.y,self.direction)
		return false
	end
  #--------------------------------------------------------------------------
  # * Determine if Near Visible Area of Screen
  #     dx:  A certain number of tiles left/right of screen's center
  #     dy:  A certain number of tiles above/below screen's center
  #--------------------------------------------------------------------------
  def near_the_screen?(dx = 12, dy = 8)
    ax = $game_map.adjust_x(@real_x) - Graphics.width / 2 / 32
    ay = $game_map.adjust_y(@real_y) - Graphics.height / 2 / 32
    ax >= -dx && ax <= dx && ay >= -dy && ay <= dy

  end
  #--------------------------------------------------------------------------
  # * Calculate Threshold of Counter for Stopping Autonomous Movement Startup
  #--------------------------------------------------------------------------
  def stop_count_threshold
    30 * (5 - @move_frequency)
  end

  #--------------------------------------------------------------------------
  # * Calculate Threshold of Counter for SensorStop
  #--------------------------------------------------------------------------
  def sensor_stop_count_threshold
	return @npc.sensor_freq if @npc && @npc.alert_level> 0
	return @sensor_freq if @npc && @sensor_freq
	return stop_count_threshold
  end
  #--------------------------------------------------------------------------
  # * Move Type : Random
  #--------------------------------------------------------------------------
	def move_type_random
		case rand(6)
		when 0..1;  move_random
		when 2..4;  move_forward
		when 5;     @stop_count = 0
					update_npc unless @npc.nil?
		end
	end
  #--------------------------------------------------------------------------
  # * Move Type : Approach
  #--------------------------------------------------------------------------
	def move_type_toward_player
		if near_the_player?
			case rand(6)
				when 0..3;  move_toward_player
				when 4;     move_random
				when 5;     move_forward
			end
		else
			move_random
		end
	end

	def move_type_toward_player
		if near_the_player?
			case rand(6)
			when 0..3;  move_toward_player
			when 4;     move_random
			when 5;     move_forward
			end
		else
			move_random
		end
	end

	def move_search_player
		case rand(6)
			when 0..2; 		move_toward_player
			when 3;     	move_forward
			when 4..5;     	move_random
		end
	end
	def move_toward_player_no_rng
		sx = distance_x_from($game_player.x).abs
		sy = distance_y_from($game_player.y).abs
		x2 = $game_map.round_x_with_direction(self.x, self.direction)
		y2 = $game_map.round_y_with_direction(self.y, self.direction)
		return if $game_map.events_xy_nt(x2, y2).any?{|event| event.move_type == self.move_type && self.facing_character?(event) && self.facing_character?($game_player)}
		return turn_toward_character($game_player) if sx + sy <= 1
		move_toward_character($game_player)
	end

  #--------------------------------------------------------------------------
  # * Determine if Near Player
  #--------------------------------------------------------------------------
	def near_the_player?
		sx = distance_x_from($game_player.x).abs
		sy = distance_y_from($game_player.y).abs
		sx + sy < 25
	end
	#--------------------------------------------------------------------------
	# * Determine if Near target 417 ver
	#--------------------------------------------------------------------------
	def near_the_target?(temp_target=$game_player,temp_range=10)
		sx = distance_x_from(temp_target.x).abs
		sy = distance_y_from(temp_target.y).abs
		((sx**2 + sy**2)**0.5).ceil < (temp_range)
		#sx + sy < (temp_range)
	end

	def near_the_xy?(temp_x=1,temp_y=1,temp_range=10)
		sx = distance_x_from(temp_x).abs
		sy = distance_y_from(temp_y).abs
		sx + sy < (temp_range)
	end

	def report_range(temp_target=$game_player)
		sx = distance_x_from(temp_target.x).abs
		sy = distance_y_from(temp_target.y).abs
		sx + sy
	end

	def report_rangeRound(temp_target=$game_player)
		sx = distance_x_from(temp_target.x).abs
		sy = distance_y_from(temp_target.y).abs
		[sx,sy].max
	end

	def report_range_xy(tmpX,tmpY)
		sx = distance_x_from(tmpX).abs
		sy = distance_y_from(tmpY).abs
		sx + sy
	end
  #--------------------------------------------------------------------------
  # * Move Type : Custom
  #--------------------------------------------------------------------------
	def move_type_custom
		update_routine_move
	end
  #--------------------------------------------------------------------------
  # * Clear Starting Flag
  #--------------------------------------------------------------------------
	def clear_starting_flag
		@starting = false
		$game_map.starting_events.delete(self) #antiLag
	end
  #--------------------------------------------------------------------------
  # * Determine if Contents Are Empty
  #--------------------------------------------------------------------------
  def empty?
    !@list || @list.size <= 1
  end
  #--------------------------------------------------------------------------
  # * Determine if One of Specified Triggers
  #     triggers : Trigger array
  #--------------------------------------------------------------------------
  def trigger_in?(triggers)
    triggers.include?(@trigger)
  end
  #--------------------------------------------------------------------------
  # * Start Event
  #--------------------------------------------------------------------------
	def start
		return if (empty? || npc_disabled?) #&& (!@debug_this_one && $TEST )
		@starting = true
		lock if trigger_in?([0,1,2]) || @over_trigger==1
		$game_map.starting_events << self if @starting #antiLag
	end
  #--------------------------------------------------------------------------
  # * Temporarily Erase
  #--------------------------------------------------------------------------

	def erase
		@erased = true
		refresh
	end
	def erased?
		@erased
	end
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
	def refresh
		new_page = @erased ? nil : find_proper_page
		setup_page(new_page) if !new_page || new_page != @page
	end
  #--------------------------------------------------------------------------
  # * Find Event Page Meeting Conditions
  #--------------------------------------------------------------------------
	def find_proper_page
		@manual_trigger=nil
		@manual_priority=nil
		@manual_through=nil
		page=find_current_labeled_page if isLabeledEvent? || @custom_page#???????????PreLaunchConfig.rb
		if page.nil?
			page = @event.pages.reverse.find {|page| conditions_met?(page)}
			@page_index=@event.pages.index(page)
		end
		@page_index+=1
		begin
		setupExtraContents(getInitPage,@nap_initialize)
		rescue
			raise $!.message + "\n in setupExtraContents,  event.id=>#{@event.id} , event.name =>#{@event.name} x =>#{@event.x} y=>#{@event.y}"
		end
		@initialized=true
		return page
	end
  #--------------------------------------------------------------------------
  # * Determine if Event Page Conditions Are Met
  #--------------------------------------------------------------------------
	def conditions_met?(page)
		c = page.condition
		return true
	end
  #--------------------------------------------------------------------------
  # * Event Page Setup
  #--------------------------------------------------------------------------
	def setup_page(new_page)
		@page = new_page
		if @page
			# setup_labeled_page
			#@use_chs = current_page_charset?
			current_page_charset? ? setup_charset_page_settings : setup_page_settings
		else
			clear_page_settings
		end
		setup_npc_effect if !@npc.nil?#??npc?????
		update_bush_depth
		clear_starting_flag
		check_event_trigger_auto
		setupExtraLateContents(getInitPage)# if @lateInit
	end



  #--------------------------------------------------------------------------
  # * Clear Event Page Settings
  #--------------------------------------------------------------------------
  def clear_page_settings
    @tile_id          = 0
    @character_name   = ""
    @character_index  = 0
    @move_type        = 0
    @through          = true
    @trigger          = nil
    @list             = nil
    @interpreter      = nil
	@charset_index	  = nil
	@chs_configuration = nil
	@chs_need_update =true
	@custom_trigger =nil
  end
  #--------------------------------------------------------------------------
  # * Set Up Event Page Settings
  #--------------------------------------------------------------------------
	def setup_page_settings
		#p "setup_page_settings event.id=>#{@event.id}, event.name =>#{@event.name}" if @debug_this_one
		@tile_id          = @page.graphic.tile_id
		if use_chs? #chs got its own build.
			@character_name   = @page.graphic.character_name
			@character_index  = @page.graphic.character_index
			################ CHECK_HERE
			if @original_direction != @page.graphic.direction
				@direction          = @page.graphic.direction
				@original_direction = @direction
				@prelock_direction  = 0
			end
			if @original_pattern != @page.graphic.pattern
				@pattern            = @page.graphic.pattern
				@original_pattern   = @pattern
			end
		else #to support mod api
			@character_name   = @manual_character_name.nil? ? @page.graphic.character_name : @manual_character_name
			@character_name   = "../../" + @maunal_graphic_path + "Graphics/Characters/" + @character_name if @maunal_graphic_path
			@character_index  = @manual_page_index.nil? ? @page.graphic.character_index : @manual_page_index
			if @original_direction != @page.graphic.direction
				@direction          = @manual_direction.nil? ? @page.graphic.direction : @manual_direction
				@original_direction = @direction
				@prelock_direction  = 0
			end
			if @original_pattern != @page.graphic.pattern
				@pattern            = @manual_pattern.nil? ?  @page.graphic.pattern : @manual_pattern
				@original_pattern   = @pattern
			end
		end
		@move_type          = @manual_move_type.nil? && !deleted? ? @page.move_type : @manual_move_type
		@move_speed         = @manual_move_speed.nil? ? @page.move_speed : @manual_move_speed
		@move_frequency     = @page.move_frequency
		@move_route         = @page.move_route
		@move_route_index   = 0
		@move_route_forcing = false
		@walk_anime         = @manual_walk_anime.nil? ? @page.walk_anime : @manual_walk_anime
		@step_anime         = @manual_step_anime.nil? ? @page.step_anime : @manual_step_anime
		@direction_fix      = @page.direction_fix
		@through            = @manual_through.nil? ? @page.through : @manual_through
		@priority_type      = @manual_priority.nil? ? @page.priority_type : @manual_priority
		@trigger            = @manual_trigger.nil? ? @page.trigger : @manual_trigger
		@list               = @page==getInitPage ? filter_list(@page.list) : @page.list
		@interpreter = @trigger == 4 ? Game_Interpreter.new : nil
		@chs_need_update=true
		#p "done setup_page_settings event.id=>#{@event.id}, event.name =>#{@event.name}" if @debug_this_one
	end

  #--------------------------------------------------------------------------
  # * Determine if Touch Event is Triggered
  #--------------------------------------------------------------------------
  def check_event_trigger_touch(x, y)
    return if $game_map.interpreter.running?
    if @trigger == 2 && $game_player.pos?(x, y)
      start if !jumping? && normal_priority?
    end
  end


  def check_event_trigger_over(x,y)
	return if $game_map.interpreter.running?
     if @over_trigger && !self.moving? && $game_player.pos?(x, y)
      start if !jumping?
    end
  end
  #--------------------------------------------------------------------------
  # * Determine if Autorun Event is Triggered
  #--------------------------------------------------------------------------
  def check_event_trigger_auto
    start if @trigger == 3
  end

	def check_event_trigger_region
		return unless trigger_in?([1,2])
		return if $game_map.interpreter.running?
		start if @region_trigger == $game_map.region_id($game_player.x,$game_player.y)
	end

	def npc_disabled? #true willnot start . check if npc can be trigger
		return false if @npc.nil? || @force_NpcAbleTrigger
		return false if $game_map.isOverMap
		return true if @npc.action_state == :stun
		return true if @npc.action_state == :sex
		#if self.name.include?("Cocona")
		#p "normal_move_type? #{normal_move_type?}"
		#p "!@npc.target #{!@npc.target}"
		#p "[nil,:none].include?(npc.ai_state) #{[nil,:none].include?(npc.ai_state)}"
		#p "@move_type #{@move_type}}"
		#end
		return false if (normal_move_type? && !@npc.target) || [nil,:none].include?(npc.ai_state)
		return true
	end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------

	def update
		#return if @backgroundEvent #moved to 31_Game_Map.rb def update_events
		return if ($game_map.interpreter.running? || $game_pause) && !@force_update
		update_npc
		super
		tmpNpc_disabled = npc_disabled?
		check_event_trigger_auto if !tmpNpc_disabled
		check_event_trigger_region if !tmpNpc_disabled
		check_event_trigger_over(self.x,self.y) if !npc_disabled? || @over_trigger==1
		update_animation_synced
		return unless @interpreter
		@interpreter.setup(@list, @event.id) unless @interpreter.running?
		@interpreter.update
	end

	#Optimization mod by Teravisor
	#matching whole string is slower than comparing leftmost 6 character by approximately 10-20%. This method is called a lot so its loss is around 1% of all time.
	def current_page_charset?
		return false if @page.nil?
		@page.graphic.character_name.include?("-char-".freeze)
		#@page.graphic.character_name[0..5]=="-char-".freeze
		#res = !/-char-.+/.match(@page.graphic.character_name).nil?
	end

  #--------------------------------------------------------------------------
  # ???charset???????????setup_page_settings?????CHS_Data???
  # ???????????????????????????
  #--------------------------------------------------------------------------
	def setup_charset_page_settings
		#p "setup charset_page_settings #{@event.id}, event.name =>#{@event.name}" if  @debug_this_one
		setup_page_settings
		#??chs???????
		if !@manual_CHS_build
			set_charset_index
			set_char_type(@page.graphic.character_name)
			#set_char_name(@chs_name)
			#@character_index=chs_definition.chs_default_index[@charset_index]
			create_chs_configuration(@charset_index) #if !@chs_configuration #???????????????charset
		end
		@character_index = @manual_character_index.nil? ? chs_definition.chs_default_index[@charset_index] : @manual_character_index
		@original_pattern = @manual_pattern.nil? ? 1 : @manual_pattern
		@pattern = @manual_pattern.nil? ? 1 : @manual_pattern
		#@original_pattern = 1
		#@pattern = 1
		@chs_need_update=true
		#p "done setup charset_page_settings #{@event.id}, event.name =>#{@event.name}" if  @debug_this_one
	end

	def set_charset_index
		x = @character_index % 4 * 3 + @pattern
		y = @character_index / 4
		@charset_index = y * 12 + x
	end

  #--------------------------------------------------------------------------
  # *?? Game_CharacterBase. update_anime_pattern?????CHS?????
  # *Update Animation Pattern
  #--------------------------------------------------------------------------
  def update_anime_pattern
    if !@step_anime && @stop_count > 0
	  @pattern  = 1 if @walk_anime
    else
      @pattern = (@pattern + 1) % 4
    end
  end

	def deleted?
		@deleted
	end

	def delete
		drop_light
		@chs_need_update=true
		$game_player.delete_follower(@id)
		#$game_player.cancel_crosshair if self == $game_player.crosshair
		$game_map.delete_npc(event) if @npc
		@npc_detached = true
		@move_type = 0
		@manual_move_type = nil
		@balloon_id = 0
		@deleted=true
	end

	def delete_crosshair
		$game_player.cancel_crosshair if self == $game_player.crosshair
		delete
	end

	def npc?
		!@npc.nil?
	end
	def is_actor?
		!@npc.nil?
	end

  #???????????
	def set_npc(npc)
		p "set_npc #{npc} event.id=#{@event.id} / event.name =>#{@event.name} X =>#{@event.x} X =>#{@event.y}"
		@npc_name=npc
		@npc=$data_npcs[npc].get_npc
		raise "npc must Extend Game_NonPlayerCharacter class"  unless @npc.kind_of?(Game_NonPlayerCharacter)
		@npc.event=self
		$game_map.register_npc(self)
		@sensor_freq=@npc.sensor_freq
		@move_speed=$data_npcs[npc].move_speed
		@npc.set_default_state($data_npcs[npc].default_state)
		@npc.set_extra_event_data
		@delete_frame = @npc.delete_when_frame if !@npc.delete_when_frame.nil? && @npc.delete_when_frame != -1
	end



	def force_delete_frame(tmpNum)
		@delete_frame = tmpNum
		@npc.delete_when_frame =  tmpNum if self.npc?
	end

	def super_near_the_player?
		sx = distance_x_from($game_player.x).abs
		sy = distance_y_from($game_player.y).abs
		sx<=1 && sy<=1
	end

	def report_distance_to_XY(x,y)
		sx = distance_x_from(x).abs
		sy = distance_y_from(y).abs
		index = [sx,sy].max
		index
	end
	def report_distance_to_vol_far
		#tmpTar = $game_player
		$game_map.cam_target > 0 ? tmpTar = $game_map.events[$game_map.cam_target] : tmpTar = $game_player
		index = report_distance_to_XY(tmpTar.x,tmpTar.y)
		#index = report_distance_to_XY($game_map.display_x.to_i ,$game_map.display_y.to_i)
		90- ((index / 2 ).to_i * 7)
	end

	def report_distance_to_vol_close
		#tmpTar = $game_player
		$game_map.cam_target > 0 ? tmpTar = $game_map.events[$game_map.cam_target] : tmpTar = $game_player
		index = report_distance_to_XY(tmpTar.x,tmpTar.y)
		#index = report_distance_to_XY($game_map.display_x.to_i ,$game_map.display_y.to_i)
		90- ((index / 2 ).to_i * 10)
	end

	def report_distance_to_vol_close_npc_vol
		#tmpTar = $game_player
		$game_map.cam_target > 0 ? tmpTar = $game_map.events[$game_map.cam_target] : tmpTar = $game_player
		index = report_distance_to_XY(tmpTar.x,tmpTar.y)
		#index = report_distance_to_XY($game_map.display_x.to_i ,$game_map.display_y.to_i)
		65- ((index / 2 ).to_i * 10)
	end

	def scoutcraft
		return 1 if @npc.nil?
		@npc.scoutcraft
	end

  def npc_data
	$data_npcs[@npc_name]
  end

  def move_toward_xy(tgtx,tgty,no_strand=true)
    sx = distance_x_from(tgtx)
    sy = distance_y_from(tgty)
    if sx.abs > sy.abs
      move_straight(sx > 0 ? 4 : 6) if @sx!=0
      move_straight(sy > 0 ? 8 : 2) if !@move_succeed && no_strand
	  else
      move_straight(sy > 0 ? 8 : 2) if @sy!=0
	  move_straight(sx > 0 ? 4 : 6) if !@move_succeed && no_strand
    end

  end


  def get_page_index
	calc_index=@event.pages.index(@page)
	return @page_index if calc_index.nil?
	return calc_index+1
  end

	def use_chs?
		#@use_chs
		current_page_charset?
	end

	def get_char_name
		use_chs? ? @chs_name : @character_name
	end

  def set_summon_data(data=nil)
	@summon_data=data
  end

  def set_region_trigger(region_id)
	@region_trigger=region_id
  end

  #???????nap??????
  def nappable?
	@nappable
  end

	def nap_refresh
		#p "nap_refresh #{event.id}" if @debug_this_one
		@last_refreshed=$game_date.dateAmt
		@initialized=false
		@erased=false
		@deleted=false
		refresh
	end

	def name=(val)
		@event.name = val
	end
	def name
		@event.name
	end

  def set_overmap_char(name)
	@is_overmap_char=true
	@overmap_char=$story_stats.overmap_char(name,self)
	#return if !self.near_the_xy?(@overmap_char.overmap_x,@overmap_char.overmap_y,15)
	tmpLocX = self.x
	tmpLocY = self.y
	p "moveto=>#{@overmap_char.overmap_x != self.x || @overmap_char.overmap_y!=self.y}"
	moveto(*@overmap_char.location) if @overmap_char.overmap_x != self.x || @overmap_char.overmap_y!=self.y
	if !self.near_the_target?($game_player,4)
		moveto(tmpLocX,tmpLocY)
	end
  end

  def save_overmap_stat
	p "save_overmap_stat event.name=>#{@event.name}, event.id =>#{self.id}location=>(#{self.x},#{self.y})"
	@overmap_char.overmap_x=self.x
	@overmap_char.overmap_y=self.y
  end

  def get_self_switch(keyname)
	key = [@map_id, @id, keyname]
	$game_self_switches[key]
  end

	def init_jump_page(page_id,terran_tag=0) #417 dev,  based on esl, without map update, not saved, only use when init
		#$game_map.force_pages[$game_map.map_id] = {} if !$game_map.force_pages[$game_map.map_id]
		#$game_map.force_pages[$game_map.map_id][@id] = page_id
		#self.force_page = page_id
		#@ev_terrain_tag = terran_tag
		@page_index =page_id
		@ev_terrain_tag = terran_tag
		@ev_terrain_tag = nil if terran_tag <= 0
		@custom_page = page_id
		#tarPageData = find_current_labeled_page
	end

	def force_page(page_id,terran_tag=nil)
		@custom_page = page_id
		set_event_terrain_tag(terran_tag) if terran_tag != nil
		#refresh
	end

  def actor
	@npc
  end


	def perform_dodge
		#p "Game_Event.perform_dodge"
	end

	def set_dodge(frame=5)
		actor.dodged = true
		@dodge_frame=frame
	end

	def update_dodge
		return if @dodge_frame==0
		@dodge_frame-=1
		if @dodge_frame==0
			cancel_dodge  if actor.dodged
			cancel_block  if actor.blocked
		end
	end

	def cancel_dodge
		@dodge_frame = 0
		actor.dodged = false
	end

  #??????????????target : Game_Character
  def dead_end?(threat)
	sx = distance_x_from(threat.x)
    sy = distance_y_from(threat.y)
	if sx.abs > sy.abs
		threat_dir = sx > 0 ? 6 : 4
	else
		threat_dir = sy > 0 ? 2 : 8
	end
	all_dir=[2,4,6,8]
	all_dir.delete(threat_dir)
	all_dir.each{
		|dir|
		return false if passable?(@x,@y,dir)
	}
	true
  end

  def get_fake_target()
	case @direction
		when 2; Struct::FakeTarget.new(@x,@y+$game_map.height);
		when 4; Struct::FakeTarget.new(@x-$game_map.width,@y);
		when 6; Struct::FakeTarget.new(@x+$game_map.width,@y);
		when 8; Struct::FakeTarget.new(@x,@y-$game_map.height);
	end
  end

  def indirect_projectile?
	@missile && !@npc.effective?
  end

	def passable?(x, y, d)
		return super if !npc? && !@selector && !@overmapFollower && !@isFish
		x2 = $game_map.round_x_with_direction(x, d)
		y2 = $game_map.round_y_with_direction(y, d)
		player_tile = $game_player.x==x2 && $game_player.y==y2
		can_pass_map = $game_map.passable?(x2,y2,d)
		can_pass_terrain4 =($game_map.terrain_tag(x2,y2)!=4)
		return selector_passable?(x2,y2) if @selector #??????????
		return false if @overmapFollower && !overmapFollower_passable?(x2,y2)
		return true  if $game_map.isOverMap && player_tile
		return false if player_tile && !@missile
		return false if @waterOnly && !$game_map.water_floor?(x2, y2)
		return true  if can_pass_terrain4 && @isFish && fish_passable(x,y,x2,y2,d)
		return true  if can_pass_terrain4 && self.through && can_pass_map && !@flying && !$game_map.isOverMap #for small npc,
		return true  if can_pass_terrain4 && @flying && !$game_map.isOverMap #test for small npc, delete if this cause bugs
		return true  if can_pass_terrain4 && @missile
		return true  if self.npc? && self.npc.alert_level == 0 && can_pass_terrain4 && can_pass_map && $game_map.npcs.any?{|ev| ev.npc.master == self && ev.pos?(x2,y2)}  #npc.master through
		return false if self.npc? && $game_map.events_xy_nt(x2, y2).any?{|event| event.npc? && (!event.npc.friendly?(self)|| event.npc.friendly_fire)}
		#return false if $game_map.terrain_tag(x,y) == 4 #old
		#return false if $game_map.terrain_tag(x,y) == 4 && !can_pass_terrain4 #new a patch so unit wont stuck in terrian tag 4
		return false if !can_pass_terrain4 #new a patch so unit wont stuck in terrian tag 4
		super
  end

  def fish_passable(x,y,x2,y2,d)
	return false if $game_map.events_xy_nt(x2, y2).any?{|event| event.npc? || event.normal_priority?}
	return false if !($game_map.water_floor?(x2, y2) || $game_map.water_floor?(x, y))
	return false if !($game_map.terrain_tag(x2,y2)==0 || ($game_map.terrain_tag(x2,y2)!=4 && $game_map.passable?(x2,y2,d)))
	return true
  end

  def overmapFollower_passable?(tmpX,tmpY)
	return false if $game_player.x==tmpX && $game_player.y==tmpY
	return true
  end

  def selector_passable?(x,y)
	#p $game_map.get_SightHpAndDist($game_player.x,$game_player.y,x,y)[0]
	#p $game_map.get_SightHpAndDist($game_player.x,$game_player.y,x,y)[0] <= 0
	if @selector_limited_screen_edge
		return false if !@summon_data[:user]
		cam_x = $game_map.display_x.to_i+Graphics.ScreenGridEdgeX
		cam_y = $game_map.display_y.to_i+Graphics.ScreenGridEdgeY
		return false if ((x-cam_x).abs > Graphics.ScreenGridEdgeX || (y-cam_y).abs > Graphics.ScreenGridEdgeY)
	end
	return false if !@selector_ignore_range && $game_map.get_SightHpAndDist($game_player.x,$game_player.y,x,y)[0] <= 0
	return true if @selector_range<0
	return false if $game_map.terrain_tag(x,y) == 4
	dist_x=(x-$game_player.x).abs
	dist_y=(y-$game_player.y).abs
	return false if dist_x >= @selector_range-1 || dist_y>= @selector_range-1
	return dist_x+dist_y<  @selector_range
  end


	def selector_range_reached?(dir)
		x2 = $game_map.round_x_with_direction(@x, dir)
		y2 = $game_map.round_y_with_direction(@y, dir)
		dist_x=(x2-$game_player.x).abs
		dist_y=(y2-$game_player.y).abs
		return true if dist_x >= @selector_range-1 || dist_y>= @selector_range-1
		return dist_x+dist_y >=@selector_range
	end

	def on_water_floor?
		$game_map.water_floor?(@x, @y)
	end

	def move_selector(dir)
		return if selector_range_reached?(dir) && @selector_range>0
		move_straight(dir)
	end


	def skill_blocked?(attacker)
		( 10 - attacker.direction )== @direction
	end


	#def update_move
	#	return if @npc && @npc.action_state==:skill
	#	super
	#end

  def on_movement_finished
  	  @npc.update_npc_steps if @npc
  end

  def lower_balloon?
	return false if !@npc
	return @npc.action_state==:stun || @npc.action_state==:death || @npc.stat.get_stat("sta")<=0
  end


	def death_event?
		return false if @summon_data.nil?
		return @summon_data[:death_event]
	end

	def sex_mode?
		return false if !use_chs?
		@chs_configuration["sex_pos"] != -1
	end
	def get_chs_sex_pose
		@chs_configuration["sex_pos"]
	end

	def chs_config
		@chs_configuration
	end


	def character_index
		return @character_index if !use_chs?
		return 0 if sex_mode?
		return @character_index
	end

	def screen_z
		return @forced_z+screen_z_PlusRate if !sex_mode?
		return @forced_z+screen_z_SexPlusRate + -1+chs_config["sex_position"] if sex_receiver?
		return self.actor.fucker_target.screen_z + 2-chs_config["sex_position"]+1 if npc? && sex_mode? && !sex_receiver? && self.actor.fucker_target != nil
		return @forced_z+screen_z_PlusRate + 2-chs_config["sex_position"]+1
		#return @forced_z+screen_z_SexPlusRate + chs_config["sex_position"] if sex_receiver?
		#return self.actor.fucker_target.screen_z + 3-chs_config["sex_position"]+1 if npc? && sex_mode? && !sex_receiver? && self.actor.fucker_target != nil
		#return @forced_z+screen_z_PlusRate + 3-chs_config["sex_position"]+1
	end

	def screen_z_SexPlusRate
		(10 +@y*3) #default priority_type
	end
	def screen_z_PlusRate
		(@priority_type * 10 +@y*3)
	end
   def  set_alternative_summon_data(alternative_data)
	@summon_data=alternative_data
   end

	def hit_effect_aggro_redirect(skill=$data_arpgskills["BasicNormal"])
		return if @summon_data.nil?
		target=@summon_data[:target]
		return if target.nil? || target==$game_player
		target.npc.take_aggro(@summon_data[:user].actor,skill)
	end

	def release_chs_group
		super
		@npc.refresh
	end


	def overMapEventErase
		@over_trigger = nil
		@trigger = -1
		self.erase
	end

	def overMapEventSetOpacity(tmpRange = 4)
		return self.delete if $game_map.events_xy(self.x,self.y).any?{ |event| event != self && !event.overmapFollower}
		self.report_range <= tmpRange ? self.opacity = 255 : self.opacity = 0
	end

	def overMapEventErase
		@over_trigger = nil
		@trigger = -1
		self.erase
	end


	def set_original_xy(x,y)
		@original_x = x
		@original_y = y
	end

	def setup_audience
		#@failedMoveCount = 0
		#@traffic_jam_return = 0
		memorize_move_route unless @original_move_route
	end

=begin
	#called in move_route to setup trap npcs
		data={
		 :icon_index => 15,
		 :pic_name =>"item_icon01",
		 :npc_name => nil,
		 :detach =>false
		}
=end
	def setup_common_trap
		@character_index=@summon_data[:icon_index]
		@character_name=@summon_data[:pic_name]
		#item =@summon_data[:used_item]
		#set_npc(@summon_data[:npc_name])
		#@npc_detached=@summon_data[:detach]
	end

	def chs_name
		sex_mode? ? @chs_name_h : @chs_name
	end

	def wildSpawnEnemy_setup
		return if $story_stats["OverMapEvent_enemy"] == 0
		return if $story_stats["OnRegionMapSpawnRace"] == 0 || $story_stats["OverMapEvent_name"] == 0
		if $story_stats["OverMapEvent_saw"] != 1
			@manual_move_type = 17
			@move_type = 17
		else
			@manual_move_type = 8
			@move_type = 8
		end
	end

	def traceLastAttacker(tmpWho,tmpChkTar)
		return false if !tmpWho
		return false if !tmpWho.actor
		return true if tmpWho == tmpChkTar
		return true if !tmpWho.actor.master.nil? && tmpWho.actor.master == tmpChkTar
		return true if !tmpWho.actor.master.nil? && !tmpWho.actor.master.actor.master.nil? &&  tmpWho.actor.master.actor.master == tmpChkTar
		return false
	end

	def traceKillCount
		return false if @npc.is_object
		return true if traceLastAttacker(@npc.last_attacker,$game_player)
		return false
	end

	def traceOverKill(tmpWho,temp_killer,mora=nil,tarState=nil)
		@temp_overkill = false
		if traceLastAttacker(temp_killer,$game_player)
			$game_map.interpreter.optain_morality(mora) if mora
			$game_player.actor.add_state(tarState) if tarState
			if @summon_data[:user] #if player are the killer set fate enemy around
				tmpData = [tmpUser=@summon_data[:user],tmpTarget= @summon_data[:user].actor.last_attacker,sightPower=15]
				$game_map.set_around_NPCs_hate_unit_fraction(*tmpData)
			end
				#p "tmpWho.actor.glory_death?   >>> #{tmpWho.actor.glory_death?}"
				#p "tmpWho.actor.player_glory_kill? >>>>#{tmpWho.actor.player_glory_kill?}"
				#msgbox "asd"
			if tmpWho.actor.glory_death? || tmpWho.actor.player_glory_kill?
				EvLib.sum("EffectOverKill",self.x,self.y)
				@temp_overkill= true #if tmpWho.actor.player_glory_kill?
			end
		end
	end





	def move_straight_force(d)
		$game_map.TERFIX2_remove_pos_to_event(self)
		super(d)
		$game_map.add_event_to_pos_hash(self)
	end

	def move_straight(d, turn_ok = true)
		$game_map.TERFIX2_remove_pos_to_event(self)
		super(d,turn_ok)
		$game_map.add_event_to_pos_hash(self)
	end

	def moveto(x, y)
		$game_map.TERFIX2_remove_pos_to_event(self)
		super(x,y)
		$game_map.add_event_to_pos_hash(self)
	end

	def move_diagonal(horz, vert)
		$game_map.TERFIX2_remove_pos_to_event(self)
		super(horz, vert)
		$game_map.add_event_to_pos_hash(self)
	end
	def jump(x_plus, y_plus,tmpPeak=10)
		$game_map.TERFIX2_remove_pos_to_event(self)
		super(x_plus, y_plus, tmpPeak)
		$game_map.add_event_to_pos_hash(self)
	end
	def jump_low(x_plus, y_plus,tmpPeak=5)
		$game_map.TERFIX2_remove_pos_to_event(self)
		super(x_plus, y_plus, tmpPeak)
		$game_map.add_event_to_pos_hash(self)
	end
end

