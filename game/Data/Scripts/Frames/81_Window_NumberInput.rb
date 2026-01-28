#==============================================================================
# ** Window_NumberInput
#------------------------------------------------------------------------------
#  This window is used for the event command [Input Number].
#==============================================================================

class Window_NumberInput < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
	OFS = 12
	WLH = 24
  def initialize(message_window)
    @message_window = message_window
    super(0, 0, 0, 0)
    @number = 0
    @digits_max = 1
    @index = 0
    self.openness = 0
    self.z = System_Settings::NUMBER_INPUT_Z
    deactivate
  end
  #--------------------------------------------------------------------------
  # * Start Input Processing
  #--------------------------------------------------------------------------
  def start
    @digits_max = $game_message.num_input_digits_max
    @number = $game_variables[$game_message.num_input_variable_id]
    @number = [[@number, 0].max, 10 ** @digits_max - 1].min
    @index = 0
    update_placement
    create_contents
    refresh
    open
    activate
  end
  #--------------------------------------------------------------------------
  # * Update Window Position
  #--------------------------------------------------------------------------
 #def update_placement
 #  self.width = @digits_max * 20 + padding * 2
 #  self.height = fitting_height(1)
 #  self.x = (Graphics.width - width) / 2
 #  if @message_window.y >= Graphics.height / 2
 #    self.y = @message_window.y - height - 8
 #  else
 #    self.y = @message_window.y + @message_window.height + 8
 #  end
 #end
  #--------------------------------------------------------------------------
  # * Move Cursor Right
  #     wrap : Wraparound allowed
  #--------------------------------------------------------------------------
  def cursor_right(wrap)
    if @index < @digits_max - 1 || wrap
      @index = (@index + 1) % @digits_max
    end
  end
  #--------------------------------------------------------------------------
  # * Move Cursor Left
  #     wrap : Wraparound allowed
  #--------------------------------------------------------------------------
  def cursor_left(wrap)
    if @index > 0 || wrap
      @index = (@index + @digits_max - 1) % @digits_max
    end
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
	def update
		super
		process_cursor_move
		process_digit_change
		process_handling
		update_cursor
		mouse_input if SceneManager.scene_is?(Scene_Map) and self.active
	end
  #--------------------------------------------------------------------------
  # * Cursor Movement Processing
  #--------------------------------------------------------------------------
  def process_cursor_move
    return unless active
    last_index = @index
    cursor_right(Input.trigger?(:RIGHT)) if Input.repeat?(:RIGHT)
    cursor_left (Input.trigger?(:LEFT))  if Input.repeat?(:LEFT)
    SndLib.play_cursor if @index != last_index
  end
  #--------------------------------------------------------------------------
  # * Change Processing for Digits
  #--------------------------------------------------------------------------
	def process_digit_change(forced=nil)
		return unless active
		if Input.repeat?(:UP) || Input.repeat?(:DOWN) || Input.repeat?(:L) || Input.repeat?(:R)
			SndLib.play_cursor
			place = 10 ** (@digits_max - 1 - @index)
			n = @number / place % 10
			@number -= n * place
			n = (n + 1) % 10 if Input.repeat?(:UP) || Input.repeat?(:L)
			n = (n + 9) % 10 if Input.repeat?(:DOWN) || Input.repeat?(:R)
			@number += n * place
			refresh
		end
	end
  #--------------------------------------------------------------------------
  # * Handling Processing for OK and Cancel
  #--------------------------------------------------------------------------
  def process_handling
    return unless active
    return process_ok     if Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)
    return process_cancel if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK)
  end
  #--------------------------------------------------------------------------
  # * Processing When OK Button Is Pressed
  #--------------------------------------------------------------------------
  def process_ok
    SndLib.sys_ok
    $game_variables[$game_message.num_input_variable_id] = @number
    deactivate
    close
  end
  #--------------------------------------------------------------------------
  # * Processing When Cancel Button Is Pressed
  #--------------------------------------------------------------------------
  def process_cancel
    SndLib.sys_cancel
    deactivate
    close
  end
  #--------------------------------------------------------------------------
  # * Get Rectangle for Displaying Item
  #--------------------------------------------------------------------------
  def item_rect(index)
    Rect.new(index * 20, 0, 20, line_height)
  end
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
 #def refresh
 #  contents.clear
 #  change_color(normal_color)
 #  s = sprintf("%0*d", @digits_max, @number)
 #  @digits_max.times do |i|
 #    rect = item_rect(i)
 #    rect.x += 1
 #    draw_text(rect, s[i,1], 1)
 #  end
 #end
  #--------------------------------------------------------------------------
  # * Update Cursor
  #--------------------------------------------------------------------------
  def update_cursor
    cursor_rect.set(item_rect(@index))
  end
  
  ################################################################################### Mouse
  
	def mouse_input
		hold_rect = []
		xx = self.x + OFS
		yy = self.y + OFS
		width = 20
		rectttl = Rect.new(xx, yy, self.contents.width, WLH)
		for i in Range.new(0, @digits_max - 1)
			hold_rect.push(Rect.new(xx, yy, width, WLH))
			xx += width
		end
		for i in Range.new(0, @digits_max - 1)
			@index = i if Mouse.within?(hold_rect[i])
		end
		@rectOK = Rect.new(xx, yy, 34, 24)
		@rectNUM = Rect.new(self.x + OFS, yy, @digits_max * 20, WLH)
		self.process_ok if Mouse.within?(@rectOK) and Input.press?(:MZ_LINK)
		process_mouse_change#if Mouse.within?(@rectNUM)
	end
	def refresh
		contents.clear
		change_color(normal_color)
		s = sprintf("%0*d", @digits_max, @number)
		@digits_max.times do |i|
			rect = item_rect(i)
			rect.x += 1
			draw_text(rect, s[i,1], 1)
		end
		draw_text(self.contents.width - 24, 0, 34, WLH, "OK")
	end
	def update_placement
		self.width = @digits_max * 20 + padding * 2 + 34
		self.height = fitting_height(1)
		self.x = (Graphics.width - width) / 2
		if @message_window.y >= Graphics.height / 2
			self.y = @message_window.y - height - 8
		else
			self.y = @message_window.y + @message_window.height + 8
		end
	end
	def process_mouse_change
		return unless active
		place = 10 ** (@digits_max - 1 - @index)
		n = @number / place % 10
		@number -= n * place
		if Input.trigger?(:MZ_LINK)
			if Mouse.within?(@rectOK)
				return process_ok
			elsif Mouse.within?(@rectNUM)
				n = (n + 1) % 10
				SndLib.play_cursor
			else
				SndLib.sys_buzzer
			end
		elsif Input.trigger?(:MX_LINK)
			if Mouse.within?(@rectOK)
				return process_cancel
			elsif Mouse.within?(@rectNUM)
				n = (n + 9) % 10
				SndLib.play_cursor
			else
				return process_cancel
			end
		end
		@number += n * place
		refresh
	end
	 
	
  
  
end
