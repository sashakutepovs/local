

#-------------------------------------------------------------------------------
# * Graphics Menu
#-------------------------------------------------------------------------------

class OptionMenu < Sprite

	def initialize
		super(nil)
		initialize_basic_setting
		initialize_gui_notice
		initialize_lines_setting
		initialize_basic_opt
		initialize_options
		draw_title
		draw_items
		initialize_arrows
		@onBegin = false
	end

	def initialize_basic_opt
		@optSymbol = {}
		@optNames = {}
		@optOptions = {}
		@optSettings = {}
	end
	def initialize_lines_setting
		tmpW = Graphics.width
		tmpH = Graphics.height
		@visible_lines = ((tmpH - @indexStartY) / @indexEachY) - 3  #how many lines it can display, -1 more because arrows

		# NEW: scroll tracking
		@top_index = 0 if !@top_index
	end
	def initialize_gui_notice
		@text_title = "TITLE"
		@text_warning = "WARNING"
	end
	def initialize_basic_setting
		#screen_w = Graphics.width   # 640
		#screen_h = Graphics.height  # 360
		@yFix = 40
		@indexStartY =  (Graphics.height * 0.2).to_i
		@indexEachY = 26
		@indexStartX = (0.1 * Graphics.width).to_i #64
		@indexOptWitdh = (0.65 * Graphics.width).to_i #416
		self.bitmap = Bitmap.new(Graphics.width, Graphics.height)
		self.x = Graphics.width/2
		self.y =  Graphics.height/2
		self.y += @yFix
		self.ox        = (0.425 * Graphics.width).to_i   # originally 272/640
		self.oy        = (0.578 * Graphics.height).to_i  # originally 208/360
		self.z = System_Settings::TITLE_COMMAND_WINDOW_Z
		self.bitmap.font.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
		self.bitmap.font.outline = false
		self.bitmap.font.bold = false
		@prevLang = $lang
		@optRect_w     = (0.556 * Graphics.width).to_i   # originally 356/640
		@optRect_x     = (0.15  * Graphics.width).to_i   # originally 96/640
		@onBegin = true
	end
	def initialize_options
		#todo, started with block will be banned in option
		buildOptions(:block1,   "asd1", "",[""])
		buildOptions(:block2,   "asd2", "",[""])
		buildOptions(:block3,   "asd3", "",[""])
	end
	def setOPT(setting, value)
		case setting
			when :block1; #asd(value) #put a def u want execute
			when :block2; #asd(value)
			when :block3; #asd(value)
		end
	end

	#########3 option def example
	#def asd(value)
	#	return if @onBegin == true
	#	enabled = (value == "ON")
	#	num = value == "ON" ? 1 : 0
	#	DataManager.write_constant("Cache","DisablePartsClear",num)
	#	draw_resetWarning
	#end
	def initialize_arrows
		# === arrow sprites ===
		arrow_source = Cache.system("Menu/08Items/item_arrow")

		@arrow_up = Sprite.new(@viewport)
		@arrow_up.z = System_Settings::SCENE_Menu_Contents_Z
		@arrow_up.x = @optRect_x+20
		commonWitdh = @indexOptWitdh - @indexStartX
		@arrow_up.bitmap = Bitmap.new(commonWitdh, 12)
		rect = Rect.new(20, 0, 19, 12)
		@arrow_up.bitmap.blt(0,		0,	arrow_source, rect)
		@arrow_up.bitmap.blt(commonWitdh/2-19/2, 	0,	arrow_source, rect)
		@arrow_up.bitmap.blt(commonWitdh-19  , 	0,	arrow_source, rect)
		@arrow_up.visible=false
		@arrow_up.y = @indexStartY -6



		@arrow_down = Sprite.new(@viewport)
		@arrow_down.z = System_Settings::SCENE_Menu_Contents_Z
		@arrow_down.bitmap = Bitmap.new(commonWitdh, 12)

		rect = Rect.new(0, 0, 19, 12)
		@arrow_down.x = @optRect_x+20
		@arrow_down.bitmap.blt(0, 	0, arrow_source, rect)
		@arrow_down.bitmap.blt(commonWitdh/2-19/2, 0, arrow_source, rect)
		@arrow_down.bitmap.blt(commonWitdh-19  , 0, arrow_source, rect)
		@arrow_down.visible=false
		@arrow_down.y =  (@indexStartY+ @visible_lines * @indexEachY) + @indexEachY*2
		update_arrows
	end


	def refresh_settings
		@optSettings.each { |s, v| setOPT(s, v) }
	end
	def buildOptions(key, name, default, options)
		@optSymbol[key] = key
		@optNames[key] = name
		@optSettings[key] = default
		@optOptions[key] = options
		refresh_settings
	end

	def update_arrows
		if @items.size > @visible_lines
			@arrow_up.visible   = (@top_index > 0)
			@arrow_down.visible = (@top_index+1 + @visible_lines < @items.size) #+1 becasue it count from 0.
		else
			@arrow_up.visible   = false
			@arrow_down.visible = false
		end

		#p "sdlkfgjksdlkfgjsldfjglsdkjfg"
		#p @optSymbol[@items[@index]]
		#p @optNames[@items[@index]]
		#p @optSettings[@items[@index]]
		#p @optOptions[@items[@index]]
		#p "sdlkfgjksdlkfgjsldfjglsdkjfg2"


		#p @items[@index]
		#p @optSettings[@items[@index]]
	end

	def update
		refresh_index(@index + 1) if Input.repeat?(:DOWN)
		refresh_index(@index - 1) if Input.repeat?(:UP)
		refresh_index(@index + 3) if Input.repeat?(:R)
		refresh_index(@index - 3) if Input.repeat?(:L)
		next_option if Input.trigger?(:RIGHT) || Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)
		previous_option if Input.trigger?(:LEFT)
		update_arrows
		mouse_input_check
	end


	def dispose
		self.bitmap.dispose
		@warning.dispose if @warning
		@arrow_up.dispose
		@arrow_down.dispose
		super
	end

	# -----------------------------
	# Adjust refresh_index to scroll
	# -----------------------------
	def refresh_index(i)
		tmpIndex = @index
		size = @items.size
		return if size == 0
		
		warp = $LonaINI["GameOptions"]["ui_opt_warping"] == 1 && !($LonaINI["GameOptions"]["ui_opt_warping_mouse_off"] == 1 && Mouse.enable?)
		@index = if warp
			i % size
		else
			[[i, 0].max, size - 1].min
		end

		SndLib.play_cursor if tmpIndex != @index

		if @index < @top_index
			@top_index = @index
		elsif @index > @top_index + @visible_lines
			@top_index = @index - @visible_lines
		end

		redraw_visible_items
	end


	def redraw_visible_items
		self.bitmap.clear
		draw_title
		self.bitmap.font.size = System_Settings::FONT_SIZE::SCENE_TITLE_OPTIONS  #reset to default
		self.bitmap.font.bold = false
		range = @items[@top_index..(@top_index + @visible_lines)]
		range.each_with_index do |item, i|
			actual_index = @top_index + i
			draw_item(actual_index, actual_index == @index, i)
		end
	end

	def draw_title
		self.bitmap.font.size = System_Settings::FONT_SIZE::SCENE_TITLE_OPTIONS_TITLE #title only
		self.bitmap.font.bold = true
		self.bitmap.font.color.set(255,255,255)
		x = (Graphics.width * 0.0625).to_i #40
		y = (Graphics.height * 0.03333).to_i #12
		self.bitmap.draw_text(x,y,Graphics.width,32,@text_title,0) #todo.. i should just make another bitmap for this
	end

	#def draw_resetWarning
	#	@warning.dispose if @warning
	#	@warning = Sprite.new
	#	@warning.z = self.z+1
	#	@warning.y = @yFix
	#	@warning.x = (Graphics.width * -0.0625).to_i #- 40
	#	#@warning.bitmap = Bitmap.new(Graphics.width, (Graphics.height * 0.1667).to_i) # 640 60
	#	@warning.bitmap = Bitmap.new(Graphics.width, 60) # 640 60
	#	@warning.bitmap.font.size = System_Settings::FONT_SIZE::SCENE_TITLE_RESET_WARNING
	#	@warning.bitmap.font.bold = false
	#	@warning.bitmap.font.outline = false
	#	@warning.bitmap.draw_text(0,0,620,32,@text_warning,2)
	#end
	def draw_resetWarning
		@warning.dispose if @warning
		@warning = Sprite.new
		@warning.z = self.z + 1
		@warning.y = (Graphics.width * 0.03125).to_i  # 20
		@warning.x = 0  # 貼齊最左邊

		# 固定寬 = Graphics.width, 高 = 60
		@warning.bitmap = Bitmap.new(Graphics.width, 60)
		@warning.bitmap.font.size = System_Settings::FONT_SIZE::SCENE_TITLE_RESET_WARNING
		@warning.bitmap.font.bold = false
		@warning.bitmap.font.outline = false

		xFix = (Graphics.width * 0.03125).to_i #20
		# 在整個 bitmap 的範圍內繪製，靠右對齊 (align = 2)
		@warning.bitmap.draw_text(0, 0, Graphics.width-xFix, 60, @text_warning, 2)
	end

	def draw_items
		@index = 0
		@items = []
		@optNames.keys.each { |k| @items << k }
		redraw_visible_items
	end


	#def draw_item(i, active = false, row = nil)
	#	row ||= i - @top_index  # calculate visible row if not passed
	#	c = (active ? 255 : 192)
	#	self.bitmap.font.color.set(c,c,c)
	#
	#	textRectY = @yFix
	#	eachOpt_MouseY_Fix = (@indexEachY/2).to_i
	#
	#	# init rect arrays if needed
	#	@mouse_all_rectsL ||= []
	#	@mouse_all_rectsR ||= []
	#
	#	y = @indexStartY + row * @indexEachY
	#
	#	# draw option name
	#	self.bitmap.draw_text(@indexStartX, y, @indexOptWitdh, @indexEachY, @optNames[@items[i]], 0)
	#
	#	if active && @optSettings[@items[i]] != ""
	#		# active option with value → show < VALUE >
	#		self.bitmap.draw_text(356, y, 96, @indexEachY, "< #{@optSettings[@items[i]]} >", 1)
	#		@mouse_all_rectsL[i] = Rect.new(356,      eachOpt_MouseY_Fix+(textRectY-3)*2+row*@indexEachY,96,@indexEachY)
	#		@mouse_all_rectsR[i] = Rect.new(356+96,   eachOpt_MouseY_Fix+(textRectY-3)*2+row*@indexEachY,96,@indexEachY)
	#	elsif active
	#		# active option without a value → click anywhere
	#		@mouse_all_rectsL[i] = Rect.new(@indexStartX, eachOpt_MouseY_Fix+(textRectY-3)*2+row*@indexEachY,@indexOptWitdh,@indexEachY)
	#		@mouse_all_rectsR[i] = Rect.new(@indexStartX, eachOpt_MouseY_Fix+(textRectY-3)*2+row*@indexEachY,@indexOptWitdh,@indexEachY)
	#	else
	#		# inactive option → just draw value
	#		self.bitmap.draw_text(356, y, 96, @indexEachY, @optSettings[@items[i]].to_s, 1)
	#		@mouse_all_rectsL[i] = Rect.new(@indexStartX, eachOpt_MouseY_Fix+(textRectY-3)*2+row*@indexEachY,@indexOptWitdh,@indexEachY)
	#		@mouse_all_rectsR[i] = Rect.new(@indexStartX, eachOpt_MouseY_Fix+(textRectY-3)*2+row*@indexEachY,@indexOptWitdh,@indexEachY)
	#	end
	#end
	def draw_item(i, active = false, displayed_index = nil)
		displayed_index ||= i - @top_index
		return if displayed_index < 0 || displayed_index > @visible_lines  # skip invisible

		y = @indexStartY + displayed_index * @indexEachY
		c = active ? 255 : 192
		self.bitmap.font.color.set(c, c, c)

		# Draw option name
		self.bitmap.draw_text(@indexStartX, y, @indexOptWitdh, @indexEachY, @optNames[@items[i]], 0)
		item_mouse_rect(i, y,active)
	end
	def item_mouse_rect(i, y,active)
		mouse_rect_y = y + @indexEachY / 2
		@mouse_all_rectsL ||= []
		@mouse_all_rectsR ||= []

		if active && @optSettings[@items[i]] != ""
			self.bitmap.draw_text(@optRect_w, y, @optRect_x, @indexEachY, "< #{@optSettings[@items[i]]} >", 1)
			@mouse_all_rectsL[i] = Rect.new(@optRect_w, 			mouse_rect_y, @optRect_x, @indexEachY)
			@mouse_all_rectsR[i] = Rect.new(@optRect_w + @optRect_x,		mouse_rect_y, @optRect_x, @indexEachY)
		elsif active
			@mouse_all_rectsL[i] = Rect.new(@indexStartX,	mouse_rect_y, @indexOptWitdh, @indexEachY)
			@mouse_all_rectsR[i] = Rect.new(@indexStartX,	mouse_rect_y, @indexOptWitdh, @indexEachY)
		else
			self.bitmap.draw_text(@optRect_w, y, @optRect_x, @indexEachY, @optSettings[@items[i]].to_s, 1)
			@mouse_all_rectsL[i] = Rect.new(@indexStartX,	mouse_rect_y, @indexOptWitdh, @indexEachY)
			@mouse_all_rectsR[i] = Rect.new(@indexStartX,	mouse_rect_y, @indexOptWitdh, @indexEachY)
		end
	end

	#def mouse_input_check
	#	return Mouse.ForceIdle if Input.MouseWheelForceIdle?
	#	return if !Mouse.enable?
	#	return if !Input.trigger?(:MZ_LINK)
	#	#return SndLib.sys_buzzer if Input.trigger?(:MX_LINK)
	#	tmpIndexL = @index
	#	tmpIndexR = @index
	#	tmpIndexWriteL = @index
	#	tmpIndexWriteR = @index
	#	@mouse_all_rectsL.length.times{|i|
	#		next unless Mouse.within?(@mouse_all_rectsL[i])
	#		tmpIndexWriteL = i
	#	}
	#	@mouse_all_rectsR.length.times{|i|
	#		next unless Mouse.within?(@mouse_all_rectsR[i])
	#		tmpIndexWriteR = i
	#	}
	#	if  tmpIndexWriteL && tmpIndexWriteL != tmpIndexL
	#		refresh_index(tmpIndexWriteL) if tmpIndexWriteL
	#		SndLib.play_cursor
	#	elsif  tmpIndexWriteR && tmpIndexWriteR != tmpIndexR
	#		refresh_index(tmpIndexWriteR) if tmpIndexWriteR
	#		SndLib.play_cursor
	#	elsif Input.trigger?(:MZ_LINK) && !Mouse.within?(@mouse_all_rectsR[@index]) && !Mouse.within?(@mouse_all_rectsL[@index])
	#		return SndLib.sys_buzzer
	#	elsif Input.trigger?(:MZ_LINK) && Mouse.within?(@mouse_all_rectsR[@index])
	#		next_option
	#	elsif Input.trigger?(:MZ_LINK) && Mouse.within?(@mouse_all_rectsL[@index])
	#		previous_option
	#	elsif Input.trigger?(:MZ_LINK)
	#		next_option
	#	end
	#end
	def mouse_input_check
		return Mouse.ForceIdle if Input.MouseWheelForceIdle?
		return if !Mouse.enable?
		return if !Input.trigger?(:MZ_LINK)

		tmpIndexL = @index
		tmpIndexR = @index
		tmpIndexWriteL = @index
		tmpIndexWriteR = @index

		# Only check visible items
		(@top_index..[@top_index + @visible_lines, @items.size - 1].min).each do |i|
			if Mouse.within?(@mouse_all_rectsL[i])
				tmpIndexWriteL = i
			end
			if Mouse.within?(@mouse_all_rectsR[i])
				tmpIndexWriteR = i
			end
		end

		if tmpIndexWriteL != tmpIndexL
			refresh_index(tmpIndexWriteL)
			SndLib.play_cursor
		elsif tmpIndexWriteR != tmpIndexR
			refresh_index(tmpIndexWriteR)
			SndLib.play_cursor
		elsif Input.trigger?(:MZ_LINK)
			# now tmpIndexWriteL / R points to the clicked visible option
			if Mouse.within?(@mouse_all_rectsR[@index])
				next_option
			elsif Mouse.within?(@mouse_all_rectsL[@index])
				previous_option
			else
				SndLib.sys_buzzer
			end
		end
	end


	def next_option
		options = @optOptions[@items[@index]]
		current = @optSettings[@items[@index]]
		optSYM = @optSymbol[@items[@index]]

		# Find current option index
		oi = options.index(current) || 0
		oi = (oi + 1) % options.size

		# Update setting
		@optSettings[@items[@index]] = options[oi]
		setOPT(optSYM, options[oi])
		SndLib.play_cursor

		# Redraw current item safely
		redraw_current_item
	end

	def previous_option
		options = @optOptions[@items[@index]]
		current = @optSettings[@items[@index]]
		optSYM = @optSymbol[@items[@index]]

		# Find current option index
		oi = options.index(current) || 0
		oi = (oi - 1) % options.size

		# Update setting
		@optSettings[@items[@index]] = options[oi]
		setOPT(optSYM, options[oi])
		SndLib.play_cursor

		# Redraw current item safely
		redraw_current_item
	end

	# Helper to redraw the currently selected item accounting for scroll
	def redraw_current_item
		row = @index - @top_index
		if row < 0
			@top_index = @index
			redraw_visible_items
		elsif row > @visible_lines
			@top_index = @index - @visible_lines
			redraw_visible_items
		else
			clear_item(@index)
			draw_item(@index, true)
		end
	end

	def clear_item(i)
		row = i - @top_index
		return if row < 0 || row > @visible_lines
		self.bitmap.clear_rect(@indexStartX, @indexStartY + row*@indexEachY, @indexOptWitdh, @indexEachY)
	end
	# Redraw a specific option by its symbol/key
	def redraw_targeted_option(key)
		return unless @items.include?(key)

		i = @items.index(key)   # find index of the option
		row = i - @top_index

		#p "CURRENT #{@index - @top_index}"
		#p "TARGET #{row}"

		# Adjust scroll if target is off-screen
		if row < 0
			@top_index = i
			redraw_visible_items
		elsif row > @visible_lines
			@top_index = i - @visible_lines
			redraw_visible_items
		else
			clear_item(i)
			draw_item(i, i == @index, row)
		end
	end

end
