#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
#==============================================================================
# ** Game_Player
#------------------------------------------------------------------------------
# This class handles the player. It includes event starting determinants and
# map scrolling functions. The instance of this class is referenced by
# $game_player.
#==============================================================================

class Game_Player < Game_Character
	include Timeout
	include Sex
	
  #--------------------------------------------------------------------------
  # * Custom Control Triggers
  #--------------------------------------------------------------------------
	
	attr_accessor :hotkey_skill_normal		#default LETTER_A ,use slot_1
	attr_accessor :hotkey_skill_heavy		#default LETTER_S ,use slot_2
	attr_accessor :hotkey_skill_control   	#default LETTER_D ,use slot_3
	
	attr_accessor :skill_hotkey_0 		#default LETTER_F ,use slot_4
	attr_accessor :skill_hotkey_1   	#default LETTER_Q ,use slot_5
	attr_accessor :skill_hotkey_2	  	#default LETTER_W ,use slot_6
	attr_accessor :skill_hotkey_3   	#default LETTER_E ,use slot_7
	attr_accessor :skill_hotkey_4  	    #default LETTER_R ,use slot_8
	attr_accessor :hotkey_other      	#default SPACE throw item 
	attr_accessor :reqUpdateHomNormal      	#ITT update handle on move normal map
	
	
	attr_accessor :slot_skill_normal
	attr_accessor :slot_skill_heavy
	attr_accessor :slot_skill_control
	attr_accessor :slot_hotkey_0
	attr_accessor :slot_hotkey_1
	attr_accessor :slot_hotkey_2
	attr_accessor :slot_hotkey_3
	attr_accessor :slot_hotkey_4
	attr_accessor :slot_hotkey_other
	attr_accessor :slot_RosterCurrent
	attr_accessor :slot_RosterArray
	attr_accessor :manual_sex
	attr_reader	:skill_eff_reserved



	attr_accessor	:mind_control_on_hit_cancel
	attr_accessor	:cannot_trigger
	attr_accessor	:cannot_control
	attr_accessor	:cannot_change_map
	attr_accessor	:sex_mode
	#attr_accessor :event_input #removed in 2023 8 23
	attr_accessor 	:crosshair
	attr_accessor	:overKillEV
	
	attr_accessor	:follower_list
	attr_accessor	:record_companion_name_front
	attr_accessor	:record_companion_name_back
	attr_accessor	:record_companion_name_ext
	attr_accessor	:record_companion_front_date
	attr_accessor	:record_companion_back_date
	attr_accessor	:record_companion_ext_date
	
	
  #--------------------------------------------------------------------------
  # * Public Instance Variables
  #--------------------------------------------------------------------------
	attr_reader   :followers                # Followers (party members)
  
  #--------------------------------------------------------------------------
  #  ARPG System Variables
  #------------	--------------------------------------------------------------
 # attr_accessor   	:action_state	
	attr_reader		:occupied_holes
	attr_reader		:sex_state
	attr_accessor	:grabbing_ev
	attr_accessor	:appetizer_played
	attr_accessor	:afk_count
	attr_accessor	:sex_event_playing
	attr_accessor	:target
	attr_accessor	:pathfinding
	
	attr_accessor	:force_update
	attr_accessor	:force_update_actor
	
	attr_accessor	:fucker_vag
	attr_accessor	:fucker_anal
	attr_accessor	:fucker_mouth
	attr_accessor	:fappers
	
	attr_accessor	:dirInputCount
	attr_accessor	:move_type #useless. but keep it
	attr_accessor	:cancel_refresh
	attr_accessor	:skill_eff_reserved
	@cancel_refresh = false
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
	def initialize
		super
		clear_integrity_record			# 103_Game_Player_HoleIntegrity
		#@vehicle_type = :walk           # Type of vehicle currently being ridden
		#@vehicle_getting_on = false     # Boarding vehicle flag
		#@vehicle_getting_off = false    # Getting off vehicle flag
		@followers = Game_Followers.new(self)
		@transparent = false#$data_system.opt_transparent
		@afk_count=0
		@dodge_frame=0
		@stepSndCount=0
		@skill_eff_reserved = false
		@occupied_holes=Array.new
		@appetizer_played=false
		@sex_event_playing=false
		initialize_hotkey
		init_sex_system
		clear_transfer_info	
		@sex_mode=true
		#@event_input=false #removed in 2023 8 23
		@manual_sex = false
		@follower_list= Array.new
		@record_companion_name_front=nil
		@record_companion_name_back=nil
		@record_companion_ext_back=nil
		@record_companion_front_date=nil
		@record_companion_back_date=nil
		@record_companion_ext_date=nil
		@target=nil
		@target_cooldown=0
		@force_update=true
		@force_update_actor=true
		@dirInputCount = 0
	end
  
	def initialize_hotkey
		@hotkey_skill_normal	=:S1
		@hotkey_skill_heavy		=:S2
		@hotkey_skill_control   =:S3
		@skill_hotkey_0 		=:S4
		@skill_hotkey_1   	    =:S5
		@skill_hotkey_2	  	    =:S6
		@skill_hotkey_3   	    =:S7
		@skill_hotkey_4  	    =:S8
		@hotkey_other      	    =:S9
		@slot_RosterCurrent = 0
		@slot_RosterArray = [
						[101,102,103,nil,nil,nil,nil,nil,nil],
						[nil,nil,nil,nil,nil,nil,nil,nil,nil],
						[nil,nil,nil,nil,nil,nil,nil,nil,nil]
						]
		@slot_skill_normal	=101
		@slot_skill_heavy	=102
		@slot_skill_control =103
		@slot_hotkey_0		=nil
		@slot_hotkey_1		=nil
		@slot_hotkey_2		=nil
		@slot_hotkey_3		=nil
		@slot_hotkey_4		=nil
		@slot_hotkey_other	=nil
	end
  #--------------------------------------------------------------------------
  # * Clear Transfer Player Information
  #--------------------------------------------------------------------------
  def clear_transfer_info
    @transferring = false           # Player transfer flag
    @force_update = true           # Player transfer flag
    @force_update_actor = true           # Player transfer flag
    @new_map_id = 0                 # Destination map ID
    @new_x = 0                      # Destination X coordinate
    @new_y = 0                      # Destination Y coordinate
    @new_direction = 0              # Post-movement direction
  end
  #--------------------------------------------------------------------------
  # * Refresh
  #	增加針對chs系統的處理: chs_type,chs_name
  #--------------------------------------------------------------------------
  def refresh
    @character_name = actor ? actor.character_name : ""
    @character_index = actor ? actor.character_index : 0
	#@chs_name= "Lona"
    @followers.refresh
  end
  #--------------------------------------------------------------------------
  # * Get Corresponding Actor
  #--------------------------------------------------------------------------
  def actor
    $game_party.battle_members[0]
  end
  #--------------------------------------------------------------------------
  # * Determine if Stopping
  #--------------------------------------------------------------------------
  def stopping?
    return false if @vehicle_getting_on || @vehicle_getting_off
    return super
  end
  #--------------------------------------------------------------------------
  # * Player Transfer Reservation
  #     d:  Post move direction (2,4,6,8)
  #--------------------------------------------------------------------------
	def reserve_transfer(map_id, x, y, d = 2)
		@transferring = true
		@force_update = false
		@new_map_id = map_id
		@new_x = x
		@new_y = y
		@new_direction = d
		SceneManager.scene.perform_transfer
	end
  #--------------------------------------------------------------------------
  # * Determine if Player Transfer is Reserved
  #--------------------------------------------------------------------------
  def transfer?
    @transferring
  end
  #--------------------------------------------------------------------------
  # * Execute Player Transfer
  #--------------------------------------------------------------------------
	def perform_transfer
		if transfer?
			set_direction(@new_direction)
			if @new_map_id != $game_map.map_id
				$game_map.setup(@new_map_id)
				$game_map.autoplay
				Cache.clear_chs(true) #清掉除Lona以外所有組好的chs腳色
			end
			moveto(@new_x, @new_y)
			clear_transfer_info
		end
	end
  #--------------------------------------------------------------------------
  # * Determine if Walking Normally
  #--------------------------------------------------------------------------
  def normal_walk?
    !@move_route_forcing
  end
  #--------------------------------------------------------------------------
  # * Determine if Dashing
  #--------------------------------------------------------------------------
  def dash?
    return false if @move_route_forcing
    return false if $game_map.disable_dash?
    #return false if vehicle
    return Input.press?(:A)
  end
  #--------------------------------------------------------------------------
  # * Determine if Debug Pass-through State
  #--------------------------------------------------------------------------
  def debug_through?
    $TEST && Input.press?(:CTRL) #(Input.press?(:CTRL) || WolfPad.press?(:CTRL))
  end
  #--------------------------------------------------------------------------
  # * Detect Collision (Including Followers)
  #--------------------------------------------------------------------------
  def collide?(x, y)
    !@through && (pos?(x, y) || followers.collide?(x, y))
  end
  #--------------------------------------------------------------------------
  # * X Coordinate of Screen Center
  #--------------------------------------------------------------------------
	def center_x
		(Graphics.width / 32 - 1) / 2.0
	end
  #--------------------------------------------------------------------------
  # * Y Coordinate of Screen Center
  #--------------------------------------------------------------------------
	def center_y
		(Graphics.height / 32 - 1) / 2.0
	end
  #--------------------------------------------------------------------------
  # * Set Map Display Position to Center of Screen
  #--------------------------------------------------------------------------
	def center(x, y)
		$game_map.set_display_pos(x - center_x, y - center_y)
	end
  #--------------------------------------------------------------------------
  # * Move to Designated Position
  #--------------------------------------------------------------------------
	def moveto(x, y)
		super
		center(x, y)
		@followers.synchronize(x, y, direction)
	end
  #--------------------------------------------------------------------------
  # * Increase Steps
  #--------------------------------------------------------------------------
  def increase_steps
    super
    $game_party.increase_steps if normal_walk?
  end
  #--------------------------------------------------------------------------
  # * Trigger Map Event
  #     triggers : Trigger array
  #     normal   : Is priority set to [Same as Characters] ?
  #--------------------------------------------------------------------------
	def start_map_event(x, y, triggers, normal,chkItemsPick = false)
		if chkItemsPick
			tmpWithItem = false
			#tmpWithEquip = false
			tmpWithEquip = $game_map.events_xy(x, y).any?{|event|
				next unless event.summon_data
				next if !event.summon_data[:isItem]
				next if event.trigger == -1
				tmpWithItem = true
				next if !event.summon_data[:isEquip]
				true
			}
		end
		$game_map.events_xy(x, y).each do |event|
			if event.trigger_in?(triggers)&& event.normal_priority? == normal
				if chkItemsPick
					if tmpWithItem && tmpWithEquip
						next unless event.summon_data
						next unless event.summon_data[:isEquip]
						return event.start
					elsif tmpWithItem && !tmpWithEquip
						next unless event.summon_data
						next unless event.summon_data[:isItem]
						return event.start
					end
				end
				next if !checkNpcAbleTrigger(event)
				event.start
			end
		end
		#$game_map.events_xy(x, y).each do |event|   #original
		#	if event.trigger_in?(triggers)&& event.normal_priority? == normal
		#		next if !checkNpcAbleTrigger(event)
		#		event.start
		#	end
		#end
	end
	
	def checkNpcAbleTrigger(event)
		tmpNPC = event.npc?
		return true if tmpNPC && ((event.actor.is_a?(GameTrap) || event.actor.is_a?(Game_DestroyableObject)) || event.force_NpcAbleTrigger)
		return true if tmpNPC && npc_control_mode? && event.npc.check_ai_state(actor.master,0,65535,event.actor.sensors[0]) != :none
		return false if tmpNPC && event.npc.check_ai_state(self,0,65535,event.actor.sensors[0]) != :none && event.npc.master != self
		return false if tmpNPC && !event.normal_move_type? && event.npc.master != self
		return false if tmpNPC && cannotTriggerBecauseTrueDeepone(event)
		true
	end
  #--------------------------------------------------------------------------
  # * Determine if Same Position Event is Triggered
  #--------------------------------------------------------------------------
  
  
	def cannotTriggerBecauseTrueDeepone(tmpEvent)
		return false if $game_player.actor.stat["RaceRecord"] != "TrueDeepone"
		return false if tmpEvent.npc.master && tmpEvent.npc.master == $game_player
		return false if tmpEvent.npc.master && tmpEvent.npc.master.npc.master && tmpEvent.npc.master.npc.master == $game_player
		true
	end
	
	
	def check_event_region_trigger_here(tmpX,tmpY)
		tmpEv = nil
		$game_map.events.any?{|ev|
			next unless ev[1].region_trigger
			next unless !ev[1].normal_priority?
			next unless $game_map.region_id(tmpX,tmpY) == ev[1].region_trigger
			next unless ev[1].trigger_in?([0])
			tmpEv = ev[1]
		}
		return if tmpEv == nil
		tmpEv.start
	end
  
  #--------------------------------------------------------------------------
  # * Determine if Front Event is Triggered
  #--------------------------------------------------------------------------
	def check_event_trigger_there(triggers,tmpEvX=@x,tmpEvY=@y,tmpEvD=@direction)
		x2 = $game_map.round_x_with_direction(tmpEvX, tmpEvD)
		y2 = $game_map.round_y_with_direction(tmpEvY, tmpEvD)
		start_map_event(x2, y2, triggers, true)
		check_event_region_trigger_there(x2,y2)
		return if $game_map.any_event_starting?
		return unless $game_map.counter?(x2, y2)
		x3 = $game_map.round_x_with_direction(x2, tmpEvD)
		y3 = $game_map.round_y_with_direction(y2, tmpEvD)
		start_map_event(x3, y3, triggers, true)
		check_event_region_trigger_there(x2,y2)
	end

  def check_event_region_trigger_there(tmpX,tmpY)
	tmpEv = nil
	$game_map.events.any?{|ev|
		next unless ev[1].region_trigger
		next unless ev[1].normal_priority?
		next unless ev[1].trigger_in?([0])
		next unless $game_map.region_id(tmpX,tmpY) == ev[1].region_trigger
		tmpEv = ev[1]
	}
	return if tmpEv == nil
	tmpEv.start
  end
  #--------------------------------------------------------------------------
  # * Determine if Touch Event is Triggered
  #--------------------------------------------------------------------------
  def check_event_trigger_touch(x, y)
    start_map_event(x, y, [1,2], true)
  end
  #--------------------------------------------------------------------------
  # * Processing of Movement via Input from Directional Buttons
  #-------------------------------------------------------------------------
	def move_crosshair_by_input
		@crosshair.move_selector(Input.dir4) if Input.dir4 > 0 && !@crosshair.moving?
		self.turn_toward_character(@crosshair)
	end
	
  #--------------------------------------------------------------------------
  # * Determine if Movement is Possible
  #--------------------------------------------------------------------------
	def movable?
		return false if moving?
		return false if @move_route_forcing
		return false if grabbed?
		return false if process_rule_movable? # update on 140_Old_MovementSystem.rb
		return false if $game_message.busy? || $game_message.visible || $game_map.napping
		return true
	end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
	def update
		if $game_map.cam_target > 0
			last_real_x = $game_map.events[$game_map.cam_target].real_x
			last_real_y = $game_map.events[$game_map.cam_target].real_y
			$game_map.set_event_display_pos(last_real_x - center_x, last_real_y - center_y)
		end
		return if !@force_update
		last_real_x = @real_x
		last_real_y = @real_y
		last_moving = moving?
		update_movement # 140_Old_MovementSystem.rb
		if $game_map.isOverMap
			update_overmap
		else
			update_action_state
			update_normalmap
		end
		return update_npc_control_mode if npc_control_mode? #if player is a shield.  she cant move
		return if @cannot_control #if player is a shield.  she cant move
		update_normal_mode(last_real_x, last_real_y,last_moving)
	end
	def update_normalmap
		return if $game_message.busy?
		return if $game_map.interpreter.running?
		return if turn_based?
		actor.update_state_frames
		return if self.animation != nil
		@afk_count+=1
		if @afk_count >= 60
			@afk_count=0
			handle_on_move_fps_update
		end
		return handle_on_move if @move_succeed
	end

	def update_overmap
		return if $game_message.busy?
		return if $game_map.interpreter.running?
		$cg.erase
		$game_map.interpreter.chcg_background_color_off
		return if !@move_succeed
		handle_on_move_overmap #可操作方法，在overmap上移動成功時呼叫
	end

	def update_npc_control_mode
		$game_map.cam_target = self.actor.master.id
		@move_succeed=false
		update_dodge
		update_from_character_base
		#@followers.update
		update_animation_synced #必須在非常後面才不會出現圖片錯誤
		update_target
	end
	def update_normal_mode(last_real_x, last_real_y,last_moving)
		@move_succeed=false
		update_dodge
		update_from_character_base
		update_scroll(last_real_x, last_real_y)
		update_nonmoving(last_moving) unless moving?
		#@followers.update
		update_animation_synced #必須在非常後面才不會出現圖片錯誤
		update_target
	end
	def update_from_character_base
		update_character_ex_effects
		update_animation
		return update_jump if jumping?
		return update_move if moving?
		return update_stop
	end
	def update_cam_center
		update_scroll(@real_x,@real_y)
	end

	def update_target
		return if @target == nil
		return @target = nil if !@target.npc?
		return @target = nil if @target.deleted? || @target == self || @target.follower[0] ==1 || !$game_map.npcs.include?(@target)
		@target_cooldown +=1
		if @target_cooldown == 300
			@target_cooldown =0
			@target = nil
		end
	end
	
	def title_update_cam #why in player class?!   should move to map
		if $game_map.cam_target > 0
			last_real_x = $game_map.events[$game_map.cam_target].real_x
			last_real_y = $game_map.events[$game_map.cam_target].real_y
			$game_map.set_event_display_pos(last_real_x - center_x, last_real_y - center_y)
		end
		update
	end
	#--------------------------------------------------------------------------
	# * Scroll Processing
	#--------------------------------------------------------------------------

	#def update_scroll_slide(last_real_x, last_real_y)
	#	if $game_map.scrolling?
	#		@no_scroll = true
	#		update_scroll_original(last_real_x, last_real_y)
	#		return
	#	end
	#	@no_scroll = false if moving?
	#	unless @no_scroll
	#		tmpSlide = 0.005
	#		ax1 = $game_map.adjust_x(last_real_x)
	#		ay1 = $game_map.adjust_y(last_real_y)
	#		ax2 = $game_map.adjust_x(@real_x)
	#		ay2 = $game_map.adjust_y(@real_y)
	#		sc_x = (screen_x - Graphics.width/2).abs
	#		sc_y = (screen_y - 10 - Graphics.height/2).abs
	#		$game_map.scroll_down (tmpSlide*sc_y) if screen_y - 10 > Graphics.height/2
	#		$game_map.scroll_left(tmpSlide*sc_x) if screen_x < Graphics.width/2
	#		$game_map.scroll_right(tmpSlide*sc_x) if screen_x > Graphics.width/2
	#		$game_map.scroll_up(tmpSlide*sc_y) if screen_y - 10 < Graphics.height/2
	#	end
	#end
	
	def update_scroll(last_real_x, last_real_y)
		return if $game_map.cam_target != 0
		ax1 = $game_map.adjust_x(last_real_x)
		ay1 = $game_map.adjust_y(last_real_y)
		ax2 = $game_map.adjust_x(@real_x)
		ay2 = $game_map.adjust_y(@real_y)
		$game_map.scroll_down (ay2 - ay1) if ay2 > ay1 && ay2 > center_y
		$game_map.scroll_left (ax1 - ax2) if ax2 < ax1 && ax2 < center_x
		$game_map.scroll_right(ax2 - ax1) if ax2 > ax1 && ax2 > center_x
		$game_map.scroll_up   (ay1 - ay2) if ay2 < ay1 && ay2 < center_y
	end
	
	#--------------------------------------------------------------------------
	# * Processing When Not Moving
	#     last_moving : Was it moving previously?
	#--------------------------------------------------------------------------
	def update_nonmoving(last_moving)
		return if $game_map.interpreter.running?
		if last_moving
			$game_party.on_player_walk
			return if check_touch_event
		end
		if inputToTriggerEvent? && movable? && !actor.lonaDeath?
			@pathfinding = false
			return if Input.skillKeyPressed?
			move_normal
			return if check_action_event(chkItemsPick=true)
			SndLib.sys_trigger
		end
	end
	def npc_control_mode?
		@cannot_control && actor.master && actor.master.get_manual_move_type == :control_this_event_with_skill
	end
  
  #--------------------------------------------------------------------------
  # * Determine if Event Start Caused by Touch (Overlap)
  #--------------------------------------------------------------------------
	def check_touch_event
		check_event_trigger_here([1,2])
		$game_map.setup_starting_event
	end
  #--------------------------------------------------------------------------
  # * Determine if Event Start Caused by [OK] Button
  #--------------------------------------------------------------------------
	def check_action_event(chkItemsPick=false)		#觸發順序
		if @cannot_trigger && !npc_control_mode?
			$game_map.interpreter.parallel_overEvent_popupMsg($game_player.cannot_trigger)
			return SndLib.sys_buzzer
		end
		check_event_trigger_here([0],chkItemsPick)
		return true if $game_map.setup_starting_event
		check_event_trigger_there([0,1,2])
		return true if $game_map.setup_starting_event
		check_region_event
		return $game_map.setup_starting_event
	end
	
	def check_region_event
		return false if !$game_map.isOverMap
		$game_temp.reserve_region_event(region_id)
	end

	def check_event_trigger_here(triggers,chkItemsPick=false)
		start_map_event(@x, @y, triggers, false,chkItemsPick)
		check_event_region_trigger_here(@x, @y)
	end
	
  def force_move_forward
		@through = true
		move_forward
		@through = false
  end
  #--------------------------------------------------------------------------
  # * Determine if Damage Floor
  #--------------------------------------------------------------------------
	def on_water_floor?
		$game_map.water_floor?(@x, @y)
	end
  
  def on_bush_floor?
    $game_map.bush?(@x, @y)
  end
  #--------------------------------------------------------------------------
  # * Move Straight
  #--------------------------------------------------------------------------
  def move_straight(d, turn_ok = true)
		@followers.move if passable?(@x, @y, d)
		super
  end
  #--------------------------------------------------------------------------
  # * Move Diagonally
  #--------------------------------------------------------------------------
  def move_diagonal(horz, vert)
    @followers.move if diagonal_passable?(@x, @y, horz, vert)
    super
  end
  
  
  def chs_config
	actor.stat
  end
	
  def chs_type
  return "Lona" unless sex_mode?
  return "Lona_H"
  #actor.name
  end
  
  def charset_index
	@charset_index.nil? ? @charset_index=0 : @charset_index
  end

	def refresh_chs
		p "$game_player.refresh_chs"
		actor.refresh_part_key_blacklist
		Cache.chs_character(self,true) if !@cancel_refresh
		cancel_refresh = false
		@chs_need_update=true
		actor.stat_changed=false
		actor.portrait.refresh #When loading game, we need to recreate portrait stats data.
	end
	def apply_color_palette
		actor.portrait.update
		refresh_chs
	end
  #回傳Game_Actor的scout_craft屬性
	def scoutcraft
		scout_basic=(actor.scoutcraft_plus)*4
		scout_advanced=(actor.scoutcraft)*4
		scout_dash = -12
		sneak=[:sneak, :sneak_overfatigue, :sneak_cuffed].include?(self.movement)
		dash=[:dash, :dash_fatigue, :dash_cuffed, :dash_overfatigue].include?(self.movement)
		return scout_dash		if dash && self.moving?
		return scout_basic		if !sneak
		return scout_basic		if sneak && scout_basic > scout_advanced
		return scout_advanced	if sneak
	end
  
  def get_char_name
	@character_name
  end
  
  #覆寫CHS::use_chs? 提供Sprite_Character判斷這個腳色是否使用CHS的依據
  #判斷此時的party_leader是否為使用chs的腳色。
	def use_chs?
		true
	end
  
  #def finish_turn
	#super
  #end
  
	def update_skill_holding
		return if @holding_key.nil? || actor.action_state !=:skill #玩家操作時一定會設定holding_key，不為nil時表示有holding技能
		return if $game_map.interpreter.running? || $game_message.busy? 
		if !actor.skill.nil?
			tmpSkillName = actor.skill.name
			if @direction != @prev_direction && $data_arpgskills[tmpSkillName].hold_type == 1 #refresh Animation DIR
				self.set_animation($data_arpgskills[tmpSkillName].hold_animation) if $data_arpgskills[tmpSkillName].hold_animation
				@prev_direction = @direction
			end
			if checkHoldCancel #if pressed other skill key, cancel skill
				actor.process_skill_cost_reverse($data_arpgskills[tmpSkillName])
				SndLib.sound_equip_armor(60,160)
				actor.cancel_holding(false)
				@holding_key=nil
				return p "Hold skill canceled"
			end
		end
		unless Input.press?(@holding_key)
			actor.cancel_holding(true)
			@holding_key=nil
		end
	end
	
	
	def update_GetNextSkillRoster
		#return if @slot_RosterCurrent <= 0
		@slot_RosterCurrent -= 1
		@slot_RosterCurrent = @slot_RosterArray.length-1 if @slot_RosterCurrent < 0
		update_SkillRoster
	end
	def update_GetPrevSkillRoster
		#return if @slot_RosterCurrent >= @slot_RosterArray.length-1
		@slot_RosterCurrent += 1
		@slot_RosterCurrent = 0 if @slot_RosterCurrent > @slot_RosterArray.length-1
		update_SkillRoster
	end
	def update_SkillRoster
		SndLib.sys_DialogBoard(80,200)
		@slot_skill_normal		= @slot_RosterArray[@slot_RosterCurrent][0]
		@slot_skill_heavy		= @slot_RosterArray[@slot_RosterCurrent][1]
		@slot_skill_control		= @slot_RosterArray[@slot_RosterCurrent][2]
		@slot_hotkey_0			= @slot_RosterArray[@slot_RosterCurrent][3]
		@slot_hotkey_1			= @slot_RosterArray[@slot_RosterCurrent][4]
		@slot_hotkey_2			= @slot_RosterArray[@slot_RosterCurrent][5]
		@slot_hotkey_3			= @slot_RosterArray[@slot_RosterCurrent][6]
		@slot_hotkey_4			= @slot_RosterArray[@slot_RosterCurrent][7]
		@slot_hotkey_other		= @slot_RosterArray[@slot_RosterCurrent][8]
		actor.skill_changed = true
	end
	
	def setup_SkillRoster(tmpRoster,tmpSkill,tmpSlot) #if roster > length  setup all skills
		tmpSkill = $data_SkillName[tmpSkill].id if tmpSkill.is_a?(String)
		case tmpSlot
			when 0,:slot_skill_normal	 ;tmpSlot=0 ; @slot_skill_normal		= tmpSkill
			when 1,:slot_skill_heavy	 ;tmpSlot=1 ; @slot_skill_heavy			= tmpSkill
			when 2,:slot_skill_control	 ;tmpSlot=2 ; @slot_skill_control		= tmpSkill
			when 3,:slot_hotkey_0		 ;tmpSlot=3 ; @slot_hotkey_0			= tmpSkill
			when 4,:slot_hotkey_1		 ;tmpSlot=4 ; @slot_hotkey_1			= tmpSkill
			when 5,:slot_hotkey_2		 ;tmpSlot=5 ; @slot_hotkey_2			= tmpSkill
			when 6,:slot_hotkey_3		 ;tmpSlot=6 ; @slot_hotkey_3			= tmpSkill
			when 7,:slot_hotkey_4		 ;tmpSlot=7 ; @slot_hotkey_4			= tmpSkill
			when 8,:slot_hotkey_other	 ;tmpSlot=8 ; @slot_hotkey_other		= tmpSkill
		end
		if tmpRoster > @slot_RosterArray.length-1
			@slot_RosterArray.each{|skRoster|
				skRoster[tmpSlot] = tmpSkill
			}
		else
			@slot_RosterArray[tmpRoster][tmpSlot] = tmpSkill
		end
		actor.skill_changed = true
	end
	def checkHoldCancel
		return false if actor.blocked
		Input.checkHoldCancel?
	end

	def chk_skill_eff_reserved
		return true if @skill_eff_reserved && self.animation
		false
	end
	def update_skill_input #in def update_actor
		return if $game_message.busy? #||$game_map.interpreter.running? #<< in update_actor
		#return if chk_skill_eff_reserved && actor.skill && !actor.check_skill_hit_cancel
		return if chk_skill_eff_reserved
		#return if chk_skill_eff_reserved
		#return if !self.animation.nil? #注意 nap相關與此行有關 replace by chk_skill_eff_reserved
		return update_GetNextSkillRoster if (Input.repeat?(:L) && Input.numpad_dir4 == 0 ) || (Input.repeat?(:L) && Input.press?(:SHIFT))
		return update_GetPrevSkillRoster if (Input.repeat?(:R) && Input.numpad_dir4 == 0 ) || (Input.repeat?(:R) && Input.press?(:SHIFT))
		process_hotkey_input(@hotkey_skill_normal,	@slot_skill_normal)
		process_hotkey_input(@hotkey_skill_heavy,	@slot_skill_heavy)
		process_hotkey_input(@hotkey_skill_control,	@slot_skill_control)
		process_hotkey_input(@skill_hotkey_0,		@slot_hotkey_0)
		process_hotkey_input(@skill_hotkey_1,		@slot_hotkey_1)
		process_hotkey_input(@skill_hotkey_2,		@slot_hotkey_2)
		process_hotkey_input(@skill_hotkey_3,		@slot_hotkey_3)
		process_hotkey_input(@skill_hotkey_4,		@slot_hotkey_4)
		process_hotkey_input(@hotkey_other,			@slot_hotkey_other )
	end
	
	def process_hotkey_input(key,slot)
		return if key.nil? || slot.nil?
		return if actor.action_state == :skill || @blocked
		return if !Input.trigger?(key) && !(Input.press?(key) && @prevSkillKey != key)
		case slot
			#針對normal,control,heavy 做特殊處理
			when 101;process_skill_input(key,"normal");
			when 102;process_skill_input(key,"heavy");
			when 103;process_skill_input(key,"control");
			when nil;return SndLib.sys_buzzer
			else 
				process_custom_skill(key,slot) #slot is a ID ,skill在系統的id =>$data_skills[slot]
		end	
	end
	def rec_skill_and_direction(key)
		@prevSkillKey = key
		@dirInputCount = 0
		tmpDir4 = Input.dir4
		if tmpDir4 > 0
			self.direction = tmpDir4
		elsif Mouse.enable?
			tmpMouseDir4 = Mouse.GetDirection
			self.direction = tmpMouseDir4 if tmpMouseDir4 > 0
		end
	end
	
	def process_custom_skill(key,skill_id)
		skill=$data_skills[skill_id]
		return if !actor.skill_id_usable?(skill_id) #!actor.usable?(skill)
		return if !actor.can_set_skill?($data_skills[skill_id])
		rec_skill_and_direction(key)
		actor.launch_skill($data_arpgskills[skill.type_tag])
		return if actor.skill.nil?
		move_normal unless actor.skill.stealth || self.actor.stat["IntoShadow"] == 1
		@skill_eff_reserved=true if actor.skill.wait_hit_frame
		@holding_key=key if actor.skill.holding?
	end
	
	def process_item_skill(key,skill_name)
		skill=$data_arpgskills[skill_name]
		rec_skill_and_direction(key)
		actor.launch_skill(skill)
		return if skill.nil?
		move_normal unless skill.stealth || self.actor.stat["IntoShadow"] == 1
		@skill_eff_reserved=true if skill.wait_hit_frame
		@holding_key=key if skill.holding?
	end
  
  
	def process_skill_input(key,type)
		rec_skill_and_direction(key)
		actor.launch_player_skill(type)
		return if actor.skill.nil?
		move_normal unless actor.skill.stealth || self.actor.stat["IntoShadow"] == 1
		@skill_eff_reserved=true if actor.skill.wait_hit_frame
		@holding_key=key if actor.skill.holding?
	end
  
	def npc?  
		false
	end
	

	def npc
		self.actor
	end
	
	def is_object
		false
	end
		  
	def perform_dodge
		#p "Game_Player.perform_dodge"
	end
	
	def set_dodge(frame=5)
		actor.dodged=true
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
		@dodge_frame=0
		actor.dodged=false
	end
	
  	
	def set_block(frame=5)
		@blocked=true
		actor.blocked=true
		@dodge_frame=30
	end
  
	def cancel_block
		actor.blocked = false
		@dodge_frame=0
		@blocked = false
	end
  
	def skill_blocked?(attacker)
		( 10 - attacker.direction )== @direction
	end
  
  def get_fake_target()
	case @direction
		when 2; Struct::FakeTarget.new(@x,@y+$game_map.height);
		when 4; Struct::FakeTarget.new(@x-$game_map.width,@y);
		when 6; Struct::FakeTarget.new(@x+$game_map.width,@y);
		when 8; Struct::FakeTarget.new(@x,@y-$game_map.height);
	end
  end

	def setup_stun_effect
		release_chs_group if actor.action_state==:sex
		self.animation=animation_stun
		self.call_balloon(14,-1)
	end
	def setup_fap_effect
		release_chs_group if actor.action_state==:sex
		self.animation=animation_masturbation
		self.call_balloon(0)
	end
	def setup_shock_effect
		release_chs_group if actor.action_state==:sex
		self.animation=animation_grabbed_qte
		self.call_balloon(6)
	end
	def setup_pindown_effect
		release_chs_group if actor.action_state==:sex
		self.animation=animation_pindown_qte
		self.call_balloon(0)
	end
	def setup_cuming_effect
		release_chs_group if actor.action_state==:sex
		self.animation=animation_cuming_qte
		self.call_balloon(0)
	end
  
  def cancel_stun_effect
	#p "cancel_stun_effect"
	return if actor.action_state !=:stun
	self.animation=nil
	@balloon_id=0
  end
  
  
  

  
	def missile
		false
	end
	
	def falying
		false
	end
	
  def lower_balloon?
	return actor.action_state==:stun || actor.action_state==:death || actor.battle_stat.get_stat("sta")<=0
  end
  
  #當處於瞄準狀態時，設定準星,改為控制準星
  def set_crosshair(crosshair)
	@crosshair=crosshair
  end

  #取消設定準星
  def cancel_crosshair
	@crosshair=nil
  end
  
	def setup_lona_grabber
		cancel_stun_effect
		self.animation=animation_grabber_qte(actor.fucker_target.id)
		@move_type=0
		femdonForcePose
	end
  
  
	def update_grab_count
		if @fuckers.empty? #protect when hit target after grab
			unset_chs_sex
			@grabbing_ev.delete if @grabbing_ev
			release_chs_group
			actor.fucker_target=nil
			return
		end
		super
	end
	
	def update_graber
		if actor.fucker_target.nil? || !actor.fucker_target.grabbed?
			release_chs_group
			actor.fucker_target=nil
		elsif actor.fucker_target.passively_grabbed? && actor.fucker_target.grabber!=self
			release_chs_group
			actor.fucker_target=nil
		end
	end
  
  
	def update_action_state
		return if $game_map.interpreter.running? #暫時修正 BY 417
		return if @cannot_control
		#return if [:stun].include?(actor.action_state)
		case actor.action_state
			when :sex;
				update_sex;
			when :grabber;
				update_graber;
			when :grabbed;
				update_grab_count #@module Sex
			when :skill;
				actor.update_skill_eff
				update_skill_holding
			when :stun
				actor.update_stun
			else
				update_skill_input
		end
	end
  
	def update_sex
		#p "test PLAYER  sex count #{actor.skill.name}"
		#p "test PLAYER  sex count #{@sex_count}"
		#p "test PLAYER  sex count #{@sex_receiver}"
		return if $game_map.interpreter.running?
		#2020 1 10 : 發現此處有卡死問題，  actor.skill = nil 為暫時性的治療 問題的本質在玩家的技能未被取消
		return actor.skill = nil if !sex_receiver? || actor.skill
		return release_chs_group if @sex_count>=730
		@sex_count +=1
		#@fuckers = @fuckers.uniq
		#@fappers = @fappers.uniq
		#@fuckers.each{|fkEV|
		#	next if !fkEV
		#	@fappers.delete(fkEV)
		#}
		ev_data={
			:fuckers => Array.new(@fuckers.uniq),
			:fappers => Array.new(@fappers.uniq),
			:holes => Array.new(@occupied_holes),
			:user =>self
		}
		case 
			when @sex_state==1 && @sex_count>=360
				self.state_sex_spread_to_fucker(@fuckers) if sex_receiver?
				cancel_sex_snd
				@sex_state=2 
				$game_map.reserve_summon_event("EfxSexStage_2",self.x,self.y,-1,ev_data) if sex_receiver?
				self.animation=animation_sex_fast;
				actor.set_action_state(:sex,true)
				actor.change_acknowledged
				@fuckers.each{
					|fucker|
						next if fucker.nil?
						next fucker.unset_chs_sex if fucker.actor.fucker_target.nil?
						fucker.animation=fucker.animation_sex_fast
					}
				p "@sex_state=>#{@sex_state} , @sex_count=>#{@sex_count}"
			when @sex_state==2 && @sex_count>=540
				cancel_sex_snd
				$game_map.reserve_summon_event("EfxSexStage_3",self.x,self.y,-1,ev_data) if sex_receiver?
				@sex_state=3
				self.animation=animation_sex_cumming;
				actor.change_acknowledged
				@fuckers.each{
					|fucker|
						next if fucker.nil?
						next fucker.unset_chs_sex if fucker.actor.fucker_target.nil?
						fucker.animation=fucker.animation_sex_cumming
					}
				actor.set_action_state(:sex,true)
				p "@sex_state=>#{@sex_state} , @sex_count=>#{@sex_count}"
			when @sex_state==3 && @sex_count>=720;
				@sex_state=4 #進入CHCG狀態
				cancel_sex_snd
				actor.set_action_state(:sex,true)
				actor.change_acknowledged
				#@sex_count=0
				summon_sex_fetish
				#release_chs_group
				p "@sex_state=>#{@sex_state} , @sex_count=>#{@sex_count}"
		end
	end
  
  
  def chs_definition
	$chs_data["Lona"]
  end
 	
	def near_the_target?(temp_target,temp_range=10)
		sx = distance_x_from(temp_target.x).abs
		sy = distance_y_from(temp_target.y).abs
		((sx**2 + sy**2)**0.5).ceil < (temp_range)
		#sx + sy < (temp_range)
	end
  
  def max_chs_capacity
	$chs_data["Lona"].max_capacity
  end
  
	def set_chs_sex(pose,position=0)
		move_normal #if self.actor.stat["ShadowMaster"] != 1
		set_chs_sex_prev_zoomXY
		@sex_count=0
		@sex_state=1
		actor.stat["sex_pos"]=pose
		actor.stat["sex_position"]=0
		@fucker_vag=nil
		@fucker_anal=nil
		@fucker_mouth=nil
		@chs_need_update=true# [hole_name,race]
			# ex : [["vag","Goblin"] ]
		@fuckers.each{|fker|
								#[holename , race, npc_name]
			@occupied_holes << [chs_definition.get_holename(fker),fker.actor.race ,fker.actor.npc_name,fker]
			actor.alter_sex_exp(@occupied_holes)
			fker.actor.fapping =false
			calc_integrity #Editables/103_Game_Player_HoleIntegrity.rb
			p "@sex_state=>#{@sex_state}"
		}
		ev_data={
			:fuckers => Array.new(@fuckers),
			:fappers => Array.new(@fappers),
			:holes => Array.new(@occupied_holes),
			:user =>self
		}
		case @sex_state
			when 1;self.animation=animation_sex;
				$game_map.reserve_summon_event("EfxSexStage_1",self.x,self.y,-1,ev_data) if sex_receiver?
			when 2;self.animation=animation_sex_fast;
			when 3;self.animation=animation_sex_cumming;
		end
	end #def set_chs_sex
	
	def unset_chs_sex(release=false)
		prp "player.unset_chs_sex",2
		clear_integrity_record #Editables/103.....rb
		actor.stat["sex_pos"]=-1
		actor.stat["sex_position"]=-1
		actor.set_action_state(:none) #if actor.action_state != :death
		actor.determine_death
		tmpWithAFuckerTGT = !actor.fucker_target.nil?
		actor.fucker_target=nil
		@chs_need_update=true
		@story_mode_sex = nil
		@femdonMode = nil
		@sex_state=-1
		set_chs_sex_recover_zoomXY
		if self.actor.sta > 0 && tmpWithAFuckerTGT
			actor.apply_cuming_effect("Stun1")
		elsif self.actor.sta > 0 
			actor.apply_pindown_effect("Stun1")
		else
			self.animation = nil
		end
		@occupied_holes=Array.new
		@appetizer_played=false
		@grabbing_ev.delete unless @grabbing_ev.nil?
		@grabbing_ev=nil
	end
	
	def unset_all_saved_event
		prp "player.unset_all_saved_event",2
		unset_fuckers
		@grabbing_ev	= nil
		@crosshair		= nil
		@overKillEV		= nil
		self.actor.fucker_target = nil
		@target = nil
		actor.target = nil
		actor.last_attacker = nil
		actor.last_hitted_target = nil
		actor.last_used_skill = nil
		actor.last_hit_by_skill = nil
	end
	def unset_fuckers
		@fucker_vag		= nil
		@fucker_anal	= nil
		@fucker_mouth	= nil
		@fappers		= []
	end
	def unset_event_chs_sex
		unset_fuckers
		actor.stat["sex_pos"]=-1
		actor.stat["sex_position"]=-1
		@chs_need_update=true
		self.animation=nil
		actor.set_action_state(:none)
	end
	#判斷腳色是否正被grab
	def grabbed?
		#這裡的actor相依於Battle_System.rb裡的方法
		return false if !use_chs?
		actor.action_state==:grabbed || actor.action_state==:sex
	end
   
	def femdonForcePose #sex.rb
		return if Input.dir4 == 0 && check_mouseDIR(range = 2) == 0
		self.actor.sta -= 2
		dir = [Input.dir4,check_mouseDIR(range = 2)].max
		case dir
			when 8;		@femdonMode = "vag"
			when 2;		@femdonMode = "anal"
			when 4,6;	@femdonMode = "mouth"
			else  ;		@femdonMode = nil
		end
	end
	
	def set_event_chs_sex(pose,position=0)
		actor.stat["sex_pos"]=pose
		actor.stat["sex_position"]=0
		@chs_need_update=true
	end
	
	def sex_mode?
		actor.stat["sex_pos"]!=-1 #|| @sex_mode
	end
	def get_chs_sex_pose
		actor.stat["sex_pos"]
	end
	
	def screen_z
		return (10 +@y*3) +1 if !sex_mode?
		return (10 +@y*3) + -1+chs_config["sex_position"]  if sex_receiver?
		return (10 +@y*3) + 2-chs_config["sex_position"]+1
		#return (@priority_type * 10 +@y*3) + chs_config["sex_position"]  if sex_receiver?
		#return (@priority_type * 10 +@y*3) + 3-chs_config["sex_position"]+1
	end
   
   def sex_receiver?
	actor.stat["sex_position"]==0
   end
   
	
	def summon_sex_fetish
		p "summon_sex_fetish" if $debug_chs
		grabbed_by_lona =@fuckers.any?{|fker|fker.grabber==self}
		ev_data={
			:fuckers => Array.new(@fuckers),
			:fappers => Array.new(@fappers),
			:holes => Array.new(@occupied_holes),
			:grabbed_by_lona =>grabbed_by_lona
		}
		$game_map.reserve_summon_event("GeneralCHCGLauncher",@x,@y,-1,ev_data)
	end
   
   	def quit_sex_gang(char)
		super(char)
	end
   
   #增加將周圍正在fap且fucker_target==自己的腳色收進自己的fappers陣列
	def set_chs_sex_group
		#p "$game_player set_chs_sex_group start @fuckers.length=>#{@fuckers.length}"
		super
		#p "$game_player set_chs_sex_group sex_mode?=>#{sex_mode?}"
		return release_chs_group if !sex_mode? #表示前面原本的內容執行失敗
		self.balloon_id=-1
		ev_data={
			:fuckers => Array.new(@fuckers),
			:fappers => Array.new(@fappers),
			:holes => Array.new(@occupied_holes),
			:user =>self
		}
		if !@grabbing_ev.nil?
		@grabbing_ev.set_alternative_summon_data(ev_data)
		@grabbing_ev.start
		end
		#啟動時將附近正在fapping且fucker_target為自己的npc拉進fapper陣列
		$game_map.events.values.each{
			|ev|
			break if @fappers.length==4
			next if ev.deleted? || ev.erased || !ev.npc? || ev.npc.npc_dead?
			next if !ev.actor.fapping || ev.npc.fucker_target!=self 
			next if @fuckers.include?(ev)
			@fappers << ev
		}
		show_fapper if $debug_event
	end
   
   
	def grab(grabber,passive=true)
		return false if !passive
		return false unless super
		return false if @grabbing_ev
		actor.remove_state(actor.stun_state_id)
		summon_appetizer_ev
		moveto(self.x,self.y)
		return true
	end
   
   def summon_appetizer_ev
    return if @appetizer_played
     ev_data={
     	:fuckers => Array.new(@fuckers),
     	:fappers => Array.new(@fappers),
     	:holes => Array.new(@occupied_holes),
     	:user =>self
     }
	$game_map.reserve_summon_event("GeneralAppetizerLauncher",@x,@y,-1,ev_data) 
   end
   
   
   def show_fapper
	@fappers.each{
		|fper|
		fper.balloon_id=19
	}
   end
   
  
   
   def get_sys_skill_id(current_skill_id,type)
	return current_skill_id if !current_skill_id.nil? && ![101,102,103].include?(current_skill_id) && actor.can_set_skill?($data_skills[current_skill_id])
	return -1 if (skill_id=get_asd_skill_id(type)).nil? 
	return -1 unless actor.can_set_skill?($data_skills[skill_id])
	skill_id
   end
   
	
	def get_asd_skill_id(type)
		skilllist=actor.usable_skills.select{
			|skill|
			skill.type.eql?(type)
		}
		skilllist.empty? ? -1 : skilllist[0].id
	end
	
	def chs_name
		#return "Lona_Overmap" if $game_map.isOverMap && !SceneManager.scene.is_a?(Scene_Menu)
		return "Lona" unless sex_mode?
		return "Lona_H"
	end
	
	def erased
		false
	end
	def summon_data
		{}
	end
	
	def name
		"Lona"
	end
	
	def master
		nil
	end
	
	def npc
		self.actor
	end
	
	def user_redirect
		false
	end
	
	def race
		self.actor.race
	end
	def deleted?
		false
	end
	
	def innocent_spotted?
		surround_evs=Sensors::ActionSkillSight.scan($game_player)
		spotted =false
		surround_evs.each{
			|evs|
			spotted = evs[0].actor.char_spotted?($game_player,1)
			break if spotted
		}
		spotted
	end
   
	def is_actor?
		true
	end
   
end
