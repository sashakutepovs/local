#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================




class Game_Player < Game_Character

	attr_accessor :movement, :previous_movement

	alias_method :initialize_pre_stealth, :initialize
	def initialize
		@movement = :normal
		@last_movement=nil
		@camera_key_Pressed_check=0
		initialize_pre_stealth
	end
  
	# Don't use vxa dash
	def dash?
		false
	end  

	#因為姿勢不同傳回不同的character_index
	def character_index
		case movement
			when :normal_overfatigue ;  3
			when :normal_cuffed;        4
			when :normal_fatigue;       2
			when :normal;               0
			when :sneak_overfatigue;    3
			when :sneak_cuffed;         5
			when :sneak;                5
			when :dash_overfatigue ;    3
			when :dash_cuffed;          4
			when :dash_fatigue;         4
			when :dash;                 4
			when :crawl_overfatigue;    3
			when :crawl_cuffed;         3
			when :crawl;                3
			else	;					0
		end
	end
  	
	#update on  35_Game_Player.rb# def movable? , if TRUE   player cannot move
	def process_rule_movable? 
		#return true if actor.weight_immobilized?
		return true if (Input.press?(:ALT) && !Input.checkHoldAllFunctionKeys?) || Input.numpad_dir4 != 0
		#return true if turn_based? && actor.sta <= -100
		#return true if self.animation != nil && !turn_based?
		return true if actor.lonaDeath? || self.animation != nil
	end 
	
    def movement_triggered?
		Input.trigger?(:UP)|| Input.trigger?(:DOWN) || Input.trigger?(:LEFT)|| Input.trigger?(:RIGHT)
	end
	
	def player_dash?
		[:dash, :dash_fatigue, :dash_cuffed, :dash_overfatigue].include?(movement)
	end

	def player_sneak?
		[:sneak, :sneak_overfatigue, :sneak_cuffed].include?(self.movement)
	end
	
	def normal_move?
		[:normal, :normal_fatigue, :normal_cuffed, :normal_overfatigue].include?(self.movement)
	end
	
	def move_by_input(ignoreAnimation=false,ignoreInputDelay=false) #ignoreAnimation is unused on player
		return move_crosshair_by_input if @crosshair && actor.action_state==:skill
		tmpPressed_MRB = Input.trigger?(:MRB)
		if tmpPressed_MRB
			tmpClickedXY = mouse_export_CursorXY
			mouse_get_PathFindingXY(*tmpClickedXY) if tmpClickedXY
		end
		return if !movable?
		return SceneManager.scene.update_call_menu if tmpClickedXY && tmpClickedXY[0] == self.x && tmpClickedXY[1] == self.y && Input.double?(:MRB) #calling menu
		tmpMouse = Mouse.enable? #  mouse new
		tmpDir4 = Input.dir4
		if tmpDir4 > 0
			if tmpDir4 == @direction && @dirInputCount == 0 #若輸入方向等於玩家方向  且非連續輸入則直接移動
				self.direction = tmpDir4
				move_straight(tmpDir4)
			else
				@dirInputCount += 1
				self.direction = tmpDir4
				@pathfinding = false#  mouse new
				@dirInputCount = 1+System_Settings::GAME_DIR_INPUT_DELAY if ignoreInputDelay
				return move_straight(tmpDir4) if @dirInputCount > System_Settings::GAME_DIR_INPUT_DELAY # input delay
			end
		elsif tmpMouse && tmpPressed_MRB #  mouse new
			movePathfindingXY if @pathfinding
			Mouse.ForceMove
		elsif tmpMouse && Input.press?(:MRB) #  mouse new
			mouse_moveTrace #  mouse new
		elsif @pathfinding
			@pathfinding = false if (self.x == @target_PF_x && self.y == @target_PF_y)# || !@move_succeed #  mouse new
			movePathfindingXY
			Mouse.ForceMove
		else
			if tmpMouse
				dir = check_mouseDIR_input
				self.direction = dir if dir > 0
			else
				@dirInputCount = 0
			end
		end
		force_timeout if @action_state.nil?
	end
	
	#new def
	def inputToTriggerEvent? # press z to event in map
		if Input.trigger?(:C)
			@pathfinding = false
			return true
		end
		return false if !Mouse.enable?
		if Input.trigger?(:MLB)
			x = $game_map.display_x + (Mouse.pos?[0]-15) / 32 
			y = $game_map.display_y + (Mouse.pos?[1]-2)/ 32 
			sx = distance_x_from(x) -0.5
			sy = distance_y_from(y)
			#p sx.abs + sy.abs < 2
			return sx.abs + sy.abs < 2 #能否觸發單位僅搜尋十字線與本格 超過則回報FALSE
		else
			return false
		end
	end
	
	#new def
	def mouse_map_XY_trace
		x = $game_map.display_x + (Mouse.pos?[0]-15) / 32 
		y = $game_map.display_y + (Mouse.pos?[1]-2) / 32 
		sx = @crosshair.distance_x_from(x) -0.5
		sy = @crosshair.distance_y_from(y)
		return 0 if sx.abs < 1 && sy.abs < 1
		if sx.abs > sy.abs
			sy != 0 ? sy > 0 ? 8 : 2 : sx > 0 ? 4 : 6
		elsif sy != 0
			sx != 0 ? sx > 0 ? 4 : 6 : sy > 0 ? 8 : 2
		else
			0
		end
	end
	
	#new def
	def move_crosshair_by_input
		if Mouse.enable?
			tmpTrace = mouse_map_XY_trace
			@crosshair.move_selector(tmpTrace) if tmpTrace > 0 && !@crosshair.moving?
			if check_mouse_shift_companion_assemblyCall?
				if Input.trigger?(:MLB)
					@crosshair.summon_data[:MouseClicked] = true
					target = self.get_a_follower_in_a_XY(@crosshair.x,@crosshair.y)
					self.click_a_target(target) if target
				elsif Input.trigger?(:MRB)
					@crosshair.summon_data[:MouseClicked] = true
					target = self.set_player_target_in_a_XY(@crosshair.x,@crosshair.y,noResetMarkAfterAction=true)
					self.set_target_follower_goto_XY(@crosshair.x,@crosshair.y,noResetMarkAfterAction=true) if !target
				end
			end
			
		else
			@crosshair.move_selector(Input.dir4) if Input.dir4 > 0 && !@crosshair.moving?
		end
		self.turn_toward_character(@crosshair)
	end
	
	def update_movement # update on 35_Game_Player.rb
		return if $game_message.busy?
		return if $game_player.cannot_control
		#process_event_inputs if @event_input #sex event
		return if $game_map.interpreter.running?
		move_by_input
		if turn_based?	
			move_overmap
			process_movement_inputs_overmap_only	#體力活動限制、CTRL pass turn、dash
			process_overmap_tb_movement				#overmap移動速度與回合時間消耗
		else
			#process_movement_inputs			#過重訊息
			process_movement_inputs_normal	#主角動作改變
			process_camera_movement_input	#攝影機、轉向
			process_rule_movement_update	#通用update
		end
		process_portrait_inputs				#alt 隱藏portrait
		process_light_update				#movementu有改變才呼叫light_check
	end
	
	
	def process_rule_movement_update
		case self.movement
			when :sneak, :sneak_overfatigue, :sneak_cuffed
				move_sneak
			when :crawl, :crawl_overfatigue, :crawl_cuffed
				move_crawl
			when :dash, :dash_fatigue, :dash_cuffed, :dash_overfatigue
				move_dash
			when :normal,:normal_cuffed,:normal_fatigue,:normal_overfatigue
				move_normal
		end
	end
	
	#進入overmap時設定為overmap專用模式
	def move_overmap
		@move_speed = 4
		self.movement= Input.press?(:SHIFT) ? :dash : :normal
	end
  
	def move_normal
		eqp = actor.equips[0]
		equips_0_id = eqp.nil? ? -1 : eqp.id
		if actor.sta <= 0
			self.movement = :normal_overfatigue
			@move_speed = (0.625*actor.move_speed).round(3)
			@opacity = 255
		elsif player_cuffed?
			self.movement = :normal_cuffed
			@move_speed = (0.90*actor.move_speed).round(3)
			@opacity = 255
		elsif actor.stat["Exhibitionism"] == 0 && player_nude? && actor.preg_level < 4 #no mid dress and no Exhibitionism
			self.movement = :normal_fatigue
			@move_speed = (0.95*actor.move_speed).round(3)
			@opacity = 255
		else
			self.movement = :normal
			@move_speed = (1*actor.move_speed).round(3)
			@opacity = 255
		end
		@move_speed = 4.5 if @move_speed > 4.5
	end
  
	def move_sneak
		eqp = actor.equips[0]
		equips_0_id = eqp.nil? ? -1 : eqp.id
		if actor.sta <= 0
			self.movement = :sneak_overfatigue
			@move_speed = (0.25*actor.move_speed).round(3)
			@opacity = 175
		elsif player_cuffed?
			self.movement = :sneak_cuffed
			@move_speed = (0.65*actor.move_speed).round(3)
			@opacity = 175
		else
			self.movement = :sneak
			@move_speed = (0.75*actor.move_speed).round(3)
			@opacity = 175
		end
		@move_speed = 3.5 if @move_speed > 3.5
	end
  
	def move_crawl
		eqp = actor.equips[0]
		equips_0_id = eqp.nil? ? -1 : eqp.id
		if actor.sta <= 0
			self.movement = :crawl_overfatigue
			@move_speed = (0.50*actor.move_speed).round(3)
			@opacity = 125
		elsif player_cuffed?
			self.movement = :crawl_cuffed
			@move_speed = (0.55*actor.move_speed).round(3)
			@opacity = 125
		else
			self.movement = :crawl
			@move_speed = (0.625*actor.move_speed).round(3)
			@opacity = 125
		end
		@move_speed = 5.5 if @move_speed > 5.5
	end
 
	def move_dash
		return move_normal if player_dash? && (actor.sta<=0 || !Input.press?(:SHIFT))#體力過低dash無效
		equips_0_id = actor.equips[0].nil? ? -1 : actor.equips[0].id
		if actor.sta <= 0
			self.movement = :dash_overfatigue
			@move_speed = (0.625*actor.move_speed).round(3)
			@opacity = 255
		elsif player_cuffed?
			self.movement = :dash_cuffed
			@move_speed = (0.90*actor.move_speed).round(3)
			@opacity = 255
		elsif actor.sta <= 25 && player_cuffed?
			self.movement = :dash_fatigue
			@move_speed = (0.95*actor.move_speed).round(3)
			@opacity = 255
		else
			self.movement = :dash
			@move_speed = (1.25*actor.move_speed).round(3)
			@opacity = 255
		end
		@move_speed = 6 if @move_speed > 6
	end

	def process_movement_inputs_overmap_only
		return if !my_turn? || moving?
		if actor.sta <= -100 && movement_triggered? #Input.dir4 != 0
			SndLib.sys_buzzer
			$game_map.popup(0,"QuickMsg:Lona/sta_too_low#{rand(2)}",0,0)
		elsif Input.trigger?(:CTRL) #CTRL pass turn
			overmap_relax if Input.press?(:SHIFT)
			$story_stats["OverMapEvent_DateCount"] += 10
			handle_on_move_overmap(true)
			finish_turn
		end
	end #process_movement_inputs_overmap_only

	
	def process_overmap_tb_movement
		return if !@move_succeed
		actor.check_TB_parameters_stats # 轉換主角在TB MODE下的移動速度
		actor.movement_count -= 4
		if actor.move_speedTB >= actor.movement_count
			finish_turn
			actor.movement_count  +=  actor.move_speedTB
		end
	end
	

	#相機移動跟轉方向
	def process_camera_movement_input
		return if self.animation != nil || self.moving? || Input.press?(:CTRL)
		tmpInput = Input.numpad_dir4 #  mouse new
		if @camera_key_pressed != 0 && (!Input.press?(:ALT) && tmpInput == 0) #  mouse new
			$game_map.set_display_pos(@x - self.center_x, @y - self.center_y)
			@camera_key_pressed = 0
			return
		elsif !Input.press?(:ALT) && tmpInput == 0 #  mouse new
			return
		end
		tmpInput = Mouse.enable? ? Mouse.GetScreenEdge : tmpInput #  mouse new
		@camera_key_pressed=[Input.dir4,tmpInput].max #  mouse new
		case @camera_key_pressed
			when 2;
				$game_map.set_display_pos(self.x - self.center_x, self.y - self.center_y+3)
				@direction = @camera_key_pressed
			when 4;
				$game_map.set_display_pos(self.x - self.center_x-1, self.y - self.center_y)
				@direction = @camera_key_pressed
			when 6;
				$game_map.set_display_pos(self.x - self.center_x+1, self.y - self.center_y)
				@direction = @camera_key_pressed
			when 8;
				$game_map.set_display_pos(self.x - self.center_x, self.y - self.center_y-3)
				@direction = @camera_key_pressed
			else 0;
				$game_map.set_display_pos(@x - self.center_x, @y - self.center_y)
		end
	end

	
	def can_sneak?
		actor.scoutcraft_trait > 3 && actor.sta > 0
	end
	#主角動作改變，CTRL和SHIFT不能同時按
	def process_movement_inputs_normal
		return if self.animation != nil
		return if (Input.press?(:ALT) && !Input.checkHoldAllFunctionKeys?) || Input.numpad_dir4 != 0
		#p "actor.skill.nil? 1 #{actor.skill.nil?}" #debug
		#p actor.skill.name if !actor.skill.nil? #debug
		#p actor.skill_wait if !actor.skill.nil? #debug
		return if ![:none,nil].include?(@action_state) #|| !actor.skill.nil?
		if Input.trigger?(:CTRL ) && actor.sta > 0 
			if !can_sneak?
				SndLib.sys_buzzer
				$game_map.popup(0,"QuickMsg:Lona/scoutcraft_too_low",0,0) 
			else 
				player_sneak? ? move_normal : move_sneak
				player_sneak? ? SndLib.sys_SneakOff : SndLib.sys_SneakOn
			end
		elsif Input.press?(:SHIFT) # && actor.sta >= 0
			@dirInputCount = System_Settings::GAME_DIR_INPUT_DELAY_DASH if System_Settings::GAME_DIR_INPUT_DELAY_DASH > @dirInputCount
			move_dash if moving?
		end
	end #process_movement_inputs_normal
	
	
	def process_portrait_inputs
		if Input.press?(:ALT) || Input.numpad_dir4 != 0
			$game_portraits.lprt.hide
			$game_portraits.rprt.hide
		end
	end #process_portrait_inputs

	def process_light_update
		if @last_movement !=self.movement
			light_check
			@last_movement = self.movement
		end
	end

end #class Game_Player


class Game_CharacterBase #able to control a npc or events by arrow key or mouse, Player got its own ver
	def move_by_input(ignoreAnimation=false,ignoreInputDelay=false)
		tmpPressed_MRB = Input.trigger?(:MRB)
		if tmpPressed_MRB
			tmpClickedXY = mouse_export_CursorXY
			mouse_get_PathFindingXY(*tmpClickedXY) if tmpClickedXY
		end
		return if self.animation != nil && !ignoreAnimation
		return if grabbed?
		return if moving?
		#self.move_speed = self.npc.move_speed if self.npc? && Input.press?(:SHIFT)
		originalDIR = self.direction
		#@dirInputCount = 0 if !@dirInputCount
		tmpMouse = Mouse.enable? #  mouse new
		tmpDir4 = Input.dir4
		if tmpDir4 > 0
			@dirInputCount = 0 if !@dirInputCount
			@dirInputCount += 1 if !Input.press?(:ALT) || Input.checkHoldAllFunctionKeys?
			self.direction = tmpDir4
			@pathfinding = false#  mouse new
			if @direction_fix
				move_straight(tmpDir4)
				self.direction = originalDIR
			else
				@dirInputCount = 1+System_Settings::GAME_DIR_INPUT_DELAY if ignoreInputDelay
				move_straight(tmpDir4) if @dirInputCount > System_Settings::GAME_DIR_INPUT_DELAY # input delay
			end
			return
		elsif tmpMouse && tmpPressed_MRB #  mouse new
			mouse_get_gotoXY
			move_toward_XY_SmartAI(@target_PF_x,@target_PF_y) if @pathfinding
			self.direction = originalDIR if @direction_fix
		elsif tmpMouse && Input.press?(:MRB) #  mouse new
			mouse_moveTrace #  mouse new
			self.direction = originalDIR if @direction_fix
		elsif @pathfinding
			@pathfinding = false if (self.x == @target_PF_x && self.y == @target_PF_y)# || !@move_succeed #  mouse new
			movePathfindingXY
			Mouse.ForceMove
			self.direction = originalDIR if @direction_fix
		else
			if tmpMouse
				dir = check_mouseDIR_input
				self.direction = dir if dir > 0
			else
				@dirInputCount = 0
			end
		end
	end
	
	def move_by_trace #mostly for camera locked mini game
		return if moving?
		originalDIR = self.direction
		#@dirInputCount = 0 if !@dirInputCount
		tmpMouse = Mouse.enable? #  mouse new
		tmpDir4 = Input.dir4
		if tmpDir4 > 0
			@dirInputCount = 0 if !@dirInputCount
			@dirInputCount += 1 if !Input.press?(:ALT) || Input.checkHoldAllFunctionKeys?
			self.direction = tmpDir4
			@pathfinding = false#  mouse new
			move_straight(tmpDir4) if @dirInputCount > System_Settings::GAME_DIR_INPUT_DELAY # input delay
			self.direction = originalDIR if @direction_fix
			return
		elsif tmpMouse#  mouse new
			mouse_moveTrace #  mouse new
		end
	end
	#new def  use in player and events
	def mouse_moveTrace
		return if !Mouse.enable?
		Mouse.ForceMove
		@pathfinding = false
		x = $game_map.display_x + (Mouse.pos?[0]-15) / 32 
		y = $game_map.display_y + (Mouse.pos?[1]-2)/ 32 
		sx = distance_x_from(x) -0.5
		sy = distance_y_from(y)
		#return if sx.abs < 1 && sy.abs < 1
		#return move_straight(@direction) if sx.abs < 3 && sy.abs < 3
		if sx.abs > sy.abs
			move_straight(sx > 0 ? 4 : 6)
			move_straight(sy > 0 ? 8 : 2) if !@move_succeed && sy != 0
		elsif sy != 0
			move_straight(sy > 0 ? 8 : 2)
			move_straight(sx > 0 ? 4 : 6) if !@move_succeed && sx != 0
		end
	end
	
	#new def  use in player and events input
	def check_mouseDIR_input
		@dirInputCount = 0 if !@dirInputCount
		@dirInputCount += 1 #mouse new
		dir = 0
		return dir unless @dirInputCount >= System_Settings::GAME_DIR_INPUT_DELAY  # mouse new
		return dir if Input.press?(:MLB)
		x = $game_map.display_x + (Mouse.pos?[0]-15) / 32 
		y = $game_map.display_y + (Mouse.pos?[1]-2)/ 32 
		sx = distance_x_from(x) -0.5
		sy = distance_y_from(y)
		return dir if sx.abs < 1 && sy.abs < 1
		dir = Mouse.GetDirection #  mouse new
		dir
	end
	
	#new def  use in player and events, but without input (for now  only in sex grab using by Lona)
	def check_mouseDIR(range = 1)
		return 0 if !Mouse.enable?
		dir = 0
		x = $game_map.display_x + (Mouse.pos?[0]-15) / 32 
		y = $game_map.display_y + (Mouse.pos?[1]-2)/ 32 
		sx = distance_x_from(x) -0.5
		sy = distance_y_from(y)
		return dir if sx.abs < range && sy.abs < range
		dir = Mouse.GetDirection #  mouse new
		dir
	end
	
	def mouse_export_CursorXY
		return if !Mouse.enable?
		x = $game_map.display_x + (Mouse.pos?[0]+16) / 32 
		y = $game_map.display_y + (Mouse.pos?[1]-2)/ 32
		x = (x -0.5).to_i
		y = (y).to_i
		return [x,y]
	end
	#new def  use in player and events
	def mouse_get_PathFindingXY(x,y)#new def   force player to go to a xy
		$mouseMapGrid.start(x,y)
		return if $game_map.terrain_tag(x,y) >= 4
		#return if self.howManyWayEnter?(x,y) == 0
		#(x, y, iterations=25, long_mode=false, short_mode=false, passthrough=@through)
		self.createPath(x,y, iterations=50, long_mode=false, short_mode=true, passthrough=@through)
		#SndLib.play_cursorMove
	end
	
	def mouse_get_gotoXY #new def   force player to go to a xy
		return if !Mouse.enable?
		@pathfinding = true
		x = $game_map.display_x + (Mouse.pos?[0]+16) / 32 
		y = $game_map.display_y + (Mouse.pos?[1]-2)/ 32
		@target_PF_x = (x-0.5).to_i
		@target_PF_y = (y).to_i
	end
end

