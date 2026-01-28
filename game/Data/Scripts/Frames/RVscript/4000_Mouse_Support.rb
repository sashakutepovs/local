
#supported wheel, by Teravisor
#original code by sumptuaryspade@live.ca - Basic Mouse System v2.7d



# if File.exists?("System/MouseWheel.dll") && !const_defined?(:Get_Message)
begin
	Get_Wheel_Position = Win32API.new('System/LonaMouseWheel.dll', 'get_mouse_wheel', 'V', 'I')
	#Unload_Mouse_Wheel = Win32API.new('System/LonaMouseWheel.dll', 'unload', 'V', 'V')
rescue
	Get_Wheel_Position = nil
end




CPOS = Win32API.new 'user32', 'GetCursorPos', ['p'], 'v'
WINX = Win32API.new 'user32', 'FindWindowEx', ['l','l','p','p'], 'i'
SMET = Win32API.new 'user32', 'GetSystemMetrics', ['i'], 'i'
WREC = Win32API.new 'user32', 'GetWindowRect', ['l','p'], 'v'
SHOWMOUS = Win32API.new 'user32', 'ShowCursor', 'i', 'i'
#LOCKMOUS = Win32API.new 'user32', 'ClipCursor', 'i', 'i'
module Mouse
		@enabled = false
		@setup = false
	def self.setup
		@enabled = false
		@coreX = 0.0 + ((Graphics.width/2) - Graphics.width)
		@coreY = 0.0 + ((Graphics.height/2) - Graphics.height)
		@lastPosX = 0
		@lastPosY = 0
		@lastPosX2 = 0
		@lastPosY2 = 0
		@idle_timer = 0
		@idle_timer_max = 360
		@idle = true
		@setup = true
		$mouseCursor = Mouse_Cursor.new
		$mouseMapGrid = Mouse_DrawGridOnMap.new
		p "Mouse.setup Done"
	end

	def self.update
		return false unless @enabled
		@window_loc = WINX.call(0,0,"RGSS PLAYER",0)
		rect = '0000000000000000'
		cursor_pos = '00000000'
		WREC.call(@window_loc, rect)
		#--------------------------------------------------
		#Doc Edit: get addition data for window
		#--------------------------------------------------
		side, top, side_end, top_end = rect.unpack("ll11")
		CPOS.call(cursor_pos)
		@m_x, @m_y = cursor_pos.unpack("ll")
		w_x = side + SMET.call(5) + SMET.call(45)
		w_y = top + SMET.call(6) + SMET.call(46) + SMET.call(4)
		@m_x -= w_x; @m_y -= w_y

		# Old formul:
		#@m_x = [[@m_x, 0].max,Graphics.width].min
		#@m_y = [[@m_y, 0].max,Graphics.height].min

		#--------------------------------------------------
		# New formul (most sync. and smothly):
		#--------------------------------------------------
		if Graphics.fullscreen?
			scr_w = SMET.call(0);
			scr_h = SMET.call(1);
		else
			scr_w = side_end - side;
			scr_h = top_end - top - 24;
		end

		if @m_x < 0
			@m_x = 0;
		elsif @m_x > (scr_w-1)
			@m_x = (scr_w-1);
		end
		@m_x += 0.0;
		@m_x = (@m_x / scr_w) * 100;
		@m_x = ((Graphics.width * @m_x) / 100)
		@m_x.nan? ? @m_x = 0 : @m_x = @m_x.to_i #if nan.  back to 0
		
		if @m_y < 0
			@m_y = 0;
		elsif @m_y > (scr_h-1)
			@m_y = (scr_h-1);
		end
		@m_y += 0.0;
		@m_y = (@m_y / scr_h) * 100;
		@m_y = ((Graphics.height * @m_y) / 100)
		@m_y.nan? ? @m_y = 0 : @m_y = @m_y.to_i #if nan.  back to 0
		self.UpdateIdle
		return true
	end
	
	def self.working?
		return false unless @enabled
		return true
	end
	#def self.update
	#	return false unless @enabled
	#	@window_loc = WINX.call(0,0,"RGSS PLAYER",0)
	#	rect = '0000000000000000'
	#	cursor_pos = '00000000'
	#	WREC.call(@window_loc, rect)
	#	side, top = rect.unpack("ll")
	#	CPOS.call(cursor_pos)
	#	@m_x, @m_y = cursor_pos.unpack("ll")
	#	w_x = side + SMET.call(5) + SMET.call(45)
	#	w_y = top + SMET.call(6) + SMET.call(46) + SMET.call(4)
	#	@m_x -= w_x; @m_y -= w_y
	#	@m_x = [[@m_x, 0].max,Graphics.width].min
	#	@m_y = [[@m_y, 0].max,Graphics.height].min
	#	self.UpdateIdle
	#	return true
	#end

	#def self.ReleaseWheelDll
	#	Unload_Mouse_Wheel.call if !Get_Wheel_Position.nil?
	#end

	def self.setuped?
		@setup
	end
	def self.pos?
		return[-50,-50] unless self.update
		return [@m_x, @m_y]
	end
	def self.moving? #check in outside
		if @m_x != @lastPosX2 || @m_y != @lastPosY2
			@lastPosX2 = @m_x
			@lastPosY2 = @m_y
			true
		else
			false
		end
	end
	def self.GetMouseXY #check in outside
		[@m_x,@m_y]
	end
	def self.ForceMove #check in outside
		@lastPosX2 = -1
		@lastPosY2 = -1
	end
	def self.ForceIdle
		@m_x = @lastPosX
		@m_y = @lastPosY
		@idle = true
		@idle_timer = -10
	end
	def self.UpdateIdle
		if @idle_timer < 0
			@idle_timer += 1
			return true
		elsif @m_x != @lastPosX || @m_y != @lastPosY || Input.MousePressed?
			@lastPosX = @m_x
			@lastPosY = @m_y
			@idle_timer = @idle_timer_max
		elsif @idle_timer > 0
			@idle_timer -= 1
		end
		@idle = @idle_timer <= 0
	end

	def self.within?(rect)
		return unless self.update
		return false if @m_x < rect.x or @m_y < rect.y
		bound_x = rect.x + rect.width; bound_y = rect.y + rect.height
		return true if @m_x < bound_x and @m_y < bound_y
		return false
	end

	def self.within_XYWH?(tmpX,tmpY,tmpW,tmpH)
		return unless self.working?
		return false if @m_x < tmpX or @m_y < tmpY
		bound_x = tmpX + tmpW; bound_y = tmpY + tmpH
		return true if @m_x < bound_x and @m_y < bound_y
		return false
	end

	def self.disable
		@enabled = false
		InputUtils.mouse_off
		InputUtils.load_input_settings
		SHOWMOUS.call(1)
	end

	def self.enable
		@enabled = true
		SHOWMOUS.call(0)
		InputUtils.mouse_on
		InputUtils.load_input_settings
	end

	def self.enable?
		@enabled && !@idle
	end

	def self.usable?
		@enabled
	end

	def self.idle?
		@idle
	end

	def self.get_idle_opacity
		@idle_timer
	end

	def self.GetDirection
		x = @coreX + @m_x
		y = @coreY + @m_y+4
		angle = Math.atan(x.abs/y.abs) * (180 / Math::PI)
		angle = (90 - angle) + 90 if x > 0 && y > 0
		angle += 180 if x < 0 && y >= 0
		angle = 90 - angle + 180 + 90 if x < 0 && y < 0
		#p "angleC = #{x} #{y}  #{angle}"
		#return 8 if angle < 60 || angle > 298
		#return 6 if angle < 119
		#return 2 if angle < 240
		#return 4 if angle < 298
		return 0 if angle == 0
		return 8 if angle <= 45 || angle >= 315
		return 6 if angle <= 135
		return 2 if angle <= 225
		return 4 if angle <= 315
		return 0
	end
	def self.GetScreenEdge
		return 4 if @m_x <= 0+5
		return 8 if @m_y <= 0+5
		return 2 if @m_y >= Graphics.height-5
		return 6 if @m_x >= Graphics.width-5
		return 0
	end

end

###############################################################################################################
module Input #550_InputMenu.rb
	#unused OEM key replace with wheel, DUmb Dumb but i dont need too much new code.
	@lastMouseWheel = 0
	@RecordedDIR=0
	@MouseSkipKeyPressed = 0
	@doubleTapTimer = 0
	@doubleTapKeyRec = nil

	class <<self
		alias :old_update :update
	end

	def self.update
		old_update
		self.MouseUpdate
		self.UpdatelastDirRecord
		self.UpdateDoubleTap
	end

	def self.UpdateDoubleTap
		return if !@doubleTapKeyRec
		@doubleTapTimer -= 1
		if @doubleTapTimer <= 0 && !self.trigger?(@doubleTapKeyRec)
			@doubleTapKeyRec = nil
			@doubleTapTimer = 0
		end
	end

	def self.double?(key)
		return false if !self.trigger?(key)
		if @doubleTapKeyRec == key && @doubleTapTimer >= 0
			@doubleTapKeyRec = nil
			@doubleTapTimer = 0
			return true
		else
			@doubleTapKeyRec = key
			@doubleTapTimer = 15
			return false
		end
	end

	def self.UpdatelastDirRecord
		@RecordedDIR= 2 if self.trigger?(:DOWN)
		@RecordedDIR= 4 if self.trigger?(:LEFT)
		@RecordedDIR= 6 if self.trigger?(:RIGHT)
		@RecordedDIR= 8 if self.trigger?(:UP)
	end
	def self.MousePressed? #mostly used to check mouse idle
		return true if [:LBUTTON,:RBUTTON,:MBUTTON,:XBUTTON1,:XBUTTON2].any? {|key| self.press?(key)}
		return true if [:WheelU,:WheelD].any? {|key| self.trigger?(key)}
		return true if self.WheelReport != nil
		false
	end
	def self.MouseButtoned? #for main menu check
		return true if [:LBUTTON,:RBUTTON,:MBUTTON,:XBUTTON1,:XBUTTON2].any? {|key| self.press?(key)}
		return true if self.WheelReport != nil
		false
	end
	def self.Mouse_LR_Pressed? # unused
		return true if self.press?(:MX_LINK)
		return true if self.press?(:MZ_LINK)
		return false
	end

	def self.Mouse_Wheeled? #for main menu check
		return true if [:WheelU,:WheelD].any? {|key| self.trigger?(key)}
		return false
	end


	def self.MouseWheelForceIdle? #when input scroll or key board. force idle
		return true if [:UP,:DOWN,:LEFT,:RIGHT].any? {|key| self.trigger?(key)}
		return true if [:UP,:DOWN,:LEFT,:RIGHT].any? {|key| self.repeat?(key)}
		#return true if self.repeat?(:L)
		#return true if self.repeat?(:R)
		return false
	end
	def self.MsgSkipKeyPressed?
		return true if self.press?(:CTRL)
		if self.press?(:MZ_LINK)
			@MouseSkipKeyPressed += 1
			return true if @MouseSkipKeyPressed >= 30
		else
			@MouseSkipKeyPressed = 0
			return false
		end
	end



	def self.KeyboardMouseGetScreenEdgeDir4 #new def
		tmpDir4 = self.dir4
		return self.dir4 if dir4 > 0
		return 0 if !Mouse.enable?
		tmpDir4 = Mouse.GetScreenEdge
		return tmpDir4 if tmpDir4 > 0
		0
	end
	def self.KeyboardMouseDir4 #new def
		tmpDir4 = self.dir4
		return self.dir4 if dir4 > 0
		return 0 if !Mouse.enable?
		tmpDir4 = Mouse.GetDirection
		return tmpDir4 if self.press?(:MRB) && tmpDir4 > 0
		0
	end

	#def self.TriggerMouseDir4?(tgtdir)
	#	#return false if !self.trigger?(:MRB)
	#	input_dir = [self.KeyboardMouseDir4,self.KeyboardMouseGetScreenEdgeDir4].max
	#	result = false
	#	case tgtdir
	#		when :DOWN	; result = true if input_dir == 2
	#		when :LEFT	; result = true if input_dir == 4
	#		when :RIGHT	; result = true if input_dir == 6
	#		when :UP	; result = true if input_dir == 8
	#	else
	#		return false
	#	end
	#	return false unless Mouse.enable?
	#	if self.press?(:MRB)
	#		if @RecordedMouseTriggerDIR != input_dir
	#			@RecordedMouseTriggerDIR = input_dir
	#			return result
	#		else
	#			return false
	#		end
	#	end
	#end
	def self.TriggerMouseDir4?(tgtdir)
		return false unless Mouse.enable?
		@RecordedMouseTriggerDIR = 0 if !self.press?(:MRB)
		return false unless self.press?(:MRB)

		input_dir = [self.KeyboardMouseDir4, self.KeyboardMouseGetScreenEdgeDir4].max

		dir_map = {
			:DOWN => 2,
			:LEFT => 4,
			:RIGHT => 6,
			:UP => 8
		}

		return false unless dir_map.key?(tgtdir)

		expected_dir = dir_map[tgtdir]
		return false if input_dir != expected_dir

		# Trigger only if direction changed since last time
		if @RecordedMouseTriggerDIR != input_dir
			@RecordedMouseTriggerDIR = input_dir
			return true
		end

		return false
	end
	def self.UpdateMouseDirTriggerReset
		@RecordedMouseTriggerDIR = nil unless self.press?(:MRB)
	end
	if Get_Wheel_Position.nil?
		def self.WheelReport
			nil
		end
	else
		def self.WheelReport #new def #true up, false down
			tmpREC = @lastMouseWheel
			tmpPos = Get_Wheel_Position.call
			@lastMouseWheel = tmpPos
			if tmpPos < tmpREC
				true
			elsif tmpPos > tmpREC
				false
			else
				nil
			end
		end
	end

	def self.MouseUpdate #new def
		return if !Mouse.usable?
		tmpWheelReport = self.WheelReport
		if !tmpWheelReport.nil?
			if tmpWheelReport
				key = KEYMAP[:WheelU].to_i
			else
				key = KEYMAP[:WheelD].to_i
			end
			if @state[key]# && DOWN_STATE_MASK == DOWN_STATE_MASK
				@released[key] = false
				@pressed[key]  = true if (@triggered[key] = !@pressed[key])
				@repeated[key] < 17 ? @repeated[key] += 1 : @repeated[key] = 15
			elsif !@released[key] and @pressed[key]
				@triggered[key] = false
				@pressed[key]   = false
				@repeated[key]  = 0
				@released[key]  = true
			else
				@released[key]  = false
			end
		end
	end
end

class Scene_Base
	def mouse_cursor_update
		pos = Mouse.pos?
		$mouseMapGrid.update
		$mouseCursor.x = pos[0] -1#+ CURSOR_OFFSET_X
		$mouseCursor.y = pos[1] -1#+ CURSOR_OFFSET_Y
		$mouseCursor.opacity = Mouse.enable? ? 255 : 75 #[50,Mouse.get_idle_opacity].max
		return $mouseCursor.set_icon(542) if Input.press?(:MLB) || Input.press?(:MRB)
		return $mouseCursor.set_icon(541)
	end
end

class Mouse_Cursor < Sprite_Base
	def initialize
		super
		#@icon = 541
		#@iconClick = 542
		@icon = nil
		@icon_bitmap = Cache.system("Iconset")
		self.bitmap = Bitmap.new(24,24)
		set_icon(541)
		self.z = System_Settings::SCENE_Menu_CursorMouse_Z
		self.opacity = 0
	end
	def set_icon(icon)
		return if @icon == icon
		@icon = icon
		draw_cursor(@icon)
	end
	def draw_cursor(icon)
		self.bitmap.clear
		rect = Rect.new(icon % 16 * 24, icon / 16 * 24, 24, 24)
		self.bitmap.blt(0, 0, @icon_bitmap, rect)
	end
end

#only used in game_map
class Mouse_DrawGridOnMap < Sprite_Base
	def initialize
		super
		self.bitmap = Bitmap.new(32,32)
		self.bitmap.fill_rect(self.bitmap.rect,Color.new(255,255,255))
		self.bitmap.clear_rect(1,1,30,30)
		self.bitmap.clear_rect(0,8,32,16)
		self.bitmap.clear_rect(8,0,16,32)
		#self.bitmap.clear_rect(4,0,8,32)
		self.opacity = 0
		self.z = System_Settings::MOUSE_GRID_ON_MAP_Z #MAP_VP2_Z
		@updateX = 0
		@updateY = 0
	end

	def start(tmpX,tmpY)
		self.x = $game_map.adjust_x(tmpX) * 32
		self.y = $game_map.adjust_y(tmpY) * 32
		self.opacity = 250
		@updateX = tmpX
		@updateY = tmpY
	end

	def update
		return if self.opacity <= 0
		self.x = $game_map.adjust_x(@updateX) * 32
		self.y = $game_map.adjust_y(@updateY) * 32
		self.opacity -= 25
	end
end


###############################################################################################################


#class Window_Selectable < Window_Base
class Window_ChoiceList < Window_Command
	#alias mouse_update update
	#def update
	#	mouse_update
	#	update_mouse_option_window if self.active
	#end
	def update_mouse_option_window
		return Mouse.ForceIdle if Input.MouseWheelForceIdle?
		return if !Mouse.enable?
		tmpPressed_MZ_LINK = Input.trigger?(:MZ_LINK)
		return process_cancel if Input.trigger?(:MX_LINK) && cancel_enabled?
		return if !Mouse.within_XYWH?(@viewport.rect.x,@viewport.rect.y,@viewport.rect.width,@viewport.rect.height+standard_padding) #可Window_ChoiceList Window_Command viewport
		return if !tmpPressed_MZ_LINK

		#p "mouseXY #{Mouse.GetMouseXY}"
		tmpOptionIndex = self.index
		target_rect = [-1,-1,-1,-1]
		item_max.times {|i|
			x_fix = self.x - self.ox
			y_fix = (self.y + standard_padding + (i*item_height)) - self.oy  #self.oy 為卷軸Y
			x_fix += self.viewport.rect.x - self.viewport.ox if !self.viewport.nil?
			x_fix = item_rect(i).x+(item_rect(i).width/2) - (text_size(command_name(i)).width/2)
			x_fix += standard_padding
			w_fix = text_size(command_name(i)).width
			exportRect = [x_fix,y_fix,w_fix,item_height]
			next unless Mouse.within_XYWH?(*exportRect)
			self.index = i
			target_rect = exportRect
			#p "self.index #{self.index}"
			#p "item_rect(self.index) #{item_rect(self.index)}"
			#p "command_name(index) #{command_name(self.index)}"
			##p text_width(command_name(self.index))
		}
		if self.index != tmpOptionIndex
			select(self.index)
			SndLib.play_cursor
			return
		elsif tmpPressed_MZ_LINK && ok_enabled? && Mouse.within_XYWH?(*target_rect)
			process_ok
			SndLib.play_cursor
		elsif tmpPressed_MZ_LINK
			SndLib.sys_buzzer
		end
	end
end


class Window_TradeStorageLeft < Window_ItemList #sample for normal trade
	def mouse_input
		return Mouse.ForceIdle if Input.MouseWheelForceIdle?
		return if !Mouse.enable?
		@mouse_all_rects = []
		item_max.times {|i|
			rect = item_rect(i)
			rect.x += self.x + standard_padding - self.ox
			rect.y += self.y + standard_padding - self.oy
			if !self.viewport.nil?
				rect.x += self.viewport.rect.x - self.viewport.ox
				rect.y += self.viewport.rect.y - self.viewport.oy
			end
			@mouse_all_rects.push(rect)
		}
		tmpIndex = self.index
		item_max.times {|i|
			next unless Mouse.within?(@mouse_all_rects[i])
			self.index = i
		}
		if self.index != tmpIndex
			select(self.index)
			SndLib.play_cursor
			return
		end
	end
	def within_index
		item_max.times {|i|
		return true if Mouse.within?(@mouse_all_rects[i]) }
		return false
	end
end

class Scene_File < Scene_MenuBase
	#alias mouse_update update
	#def update
	#	mouse_update
	#	mouse_input
	#end
	def mouse_input
		return if !Mouse.enable?
		return on_savefile_cancel if Input.trigger?(:MX_LINK) #and Mouse.within?(rectttl)
		return if !Input.trigger?(:MZ_LINK)
		xx = 0
		yy = 20
		saveWidth = Graphics.width/2-32
		rectcm1 = Rect.new(xx, yy, saveWidth, savefile_height)
		rectcm2 = Rect.new(xx, yy + rectcm1.height, saveWidth, savefile_height)
		rectcm3 = Rect.new(xx, yy + rectcm1.height * 2, saveWidth, savefile_height)
		rectcm4 = Rect.new(xx, yy + rectcm1.height * 3, saveWidth, savefile_height)
		rectttl = Rect.new(xx, yy, saveWidth, rectcm1.height * 4)
		@scroll = self.top_index
		last_index = @index
		@index = (0 + @scroll) if Mouse.within?(rectcm1)
		@index = (1 + @scroll) if Mouse.within?(rectcm2)
		@index = (2 + @scroll) if Mouse.within?(rectcm3)
		@index = (3 + @scroll) if Mouse.within?(rectcm4)
		if @index != last_index
			refresh_cursor(last_index,@index)
			#SndLib.play_cursor
			#@savefile_windows[last_index].selected = false
			#@savefile_windows[@index].selected = true
			#@overview_window.set_file_index(@index)
		elsif Input.trigger?(:MZ_LINK) and Mouse.within?(rectttl)
			on_savefile_ok
		elsif Input.trigger?(:MZ_LINK) and !Mouse.within?(rectttl)
			SndLib.sys_buzzer
		end
	end
end
############################################################################################
############################################################################################
############################################################################################




