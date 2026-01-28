#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
#==============================================================================
# ** Window_Message
#------------------------------------------------------------------------------
#  This message window is used to display text.
#==============================================================================

class Window_Message < Window_Base
	include Timeout
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    super(0, 0, window_width, window_height)
    self.z = System_Settings::MESSAGE_WINDOW_Z
    self.openness = 0
    create_all_windows
    create_back_bitmap
	create_narrator_back
    create_back_sprite
	get_lang_str
    clear_instance_variables
  end
  
  def get_lang_str
	tmpStr2Lang = System_Settings::MESSAGE_STR2_LANG
	@str2Lang = tmpStr2Lang.include?($lang)
  end
  
  def create_narrator_back
	@narrator_back = Sprite.new
	@narrator_back.z = System_Settings::NARRATOR_MODE_Z
	@narrator_back.bitmap = Cache.system("chat_window_black_area50.png")
	@narrator_back.visible = false
  end
  
  #--------------------------------------------------------------------------
  # * Get Window Width
  #--------------------------------------------------------------------------
  def window_width
    Graphics.width
  end
  #--------------------------------------------------------------------------
  # * Get Window Height
  #--------------------------------------------------------------------------
  def window_height
    fitting_height(visible_line_number)
  end
  
  def fitting_height(wtv)
	System_Settings::MESSAGE_WINDOW_HEIGHT
  end
  #--------------------------------------------------------------------------
  # * Clear Instance Variables
  #--------------------------------------------------------------------------
  def clear_instance_variables
    @fiber = nil                # Fiber
    @background = 0             # Background type
    @position = 2               # Display position
    clear_flags
  end
  #--------------------------------------------------------------------------
  # * Clear Flag
  #--------------------------------------------------------------------------
  def clear_flags
    @show_fast = false          # Fast forward flag
    @line_show_fast = false     # Fast forward by line flag
    @pause_skip = false         # Input standby omission flag
  end
  #--------------------------------------------------------------------------
  # * Get Number of Lines to Show
  #--------------------------------------------------------------------------
  def visible_line_number
    return MESSAGE_WINDOW_VISIBLE_LINES
  end
  #--------------------------------------------------------------------------
  # * Free
  #--------------------------------------------------------------------------
  def dispose
    super
    dispose_all_windows
    dispose_back_bitmap
    dispose_back_sprite
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
	def update
		super
		update_alt_hide_window
		update_timeout # 呼叫Timeout module的方法
		update_all_windows
		update_back_sprite
		update_fiber
		update_scroll
	end

	def update_scroll
		return if !@message_board
		self.oy += line_height if Input.press?(:DOWN)
		self.oy -= line_height if Input.press?(:UP)
		self.oy += line_height*10 if Input.press?(:R) || Input.repeat?(:R)
		self.oy -= line_height*10 if Input.press?(:L) || Input.repeat?(:L)
		self.oy = 0 if self.oy<0
		if @content_height
			max_oy = @content_height-self.height
			max_oy = 0 if max_oy < 0
			self.oy = max_oy if self.oy > max_oy
		else
			self.oy = 0
		end
	end
  
  #--------------------------------------------------------------------------
  # * 按下alt時隱藏式窗
  #--------------------------------------------------------------------------
  def update_alt_hide_window
    if Input.press?(:ALT) || Input.numpad_dir4 != 0 # WolfPad.lstick4 != 0
		if self.y != System_Settings::MESSAGE_HIDE_Y
			self.y = System_Settings::MESSAGE_HIDE_Y
		end
    elsif self.y == System_Settings::MESSAGE_HIDE_Y
     #self.y = System_Settings::MESSAGE_ORIGINAL_Y#一開始是259，後來調整成240，可在System_Settings.rb中調整
		case @position
			when 0;	self.y = System_Settings::MESSAGE_ORIGINAL_Y_TOP
			when 1;	self.y = System_Settings::MESSAGE_ORIGINAL_Y_MID
			when 2;	self.y = System_Settings::MESSAGE_ORIGINAL_Y_BOT
			when 3;	self.y = System_Settings::MESSAGE_ORIGINAL_Y_BOARD
			else  ;	self.y = System_Settings::MESSAGE_ORIGINAL_Y_BOT
		end
    end
  end
  #--------------------------------------------------------------------------
  # * Update Fiber
  #--------------------------------------------------------------------------
  def update_fiber
    if @fiber
      @fiber.resume
    elsif $game_message.busy? && !$game_message.scroll_mode
      @fiber = Fiber.new { fiber_main }
      @fiber.resume
    else
      $game_message.visible = false
    end
  end
  #--------------------------------------------------------------------------
  # * Create All Windows
  #--------------------------------------------------------------------------
  def create_all_windows
    @gold_window = Window_Gold.new
    @gold_window.x = Graphics.width - @gold_window.width
    @gold_window.y = 0
    @gold_window.openness = 0
    @choice_window = Window_ChoiceList.new(self)
    @number_window = Window_NumberInput.new(self)
    @item_window = Window_KeyItem.new(self)
  end
  #--------------------------------------------------------------------------
  # * Create Background Bitmap
  #--------------------------------------------------------------------------
  def create_back_bitmap
    @back_bitmap = Bitmap.new(width, height)
    rect1 = Rect.new(0, 0, width, 12)
    rect2 = Rect.new(0, 12, width, height - 24)
    rect3 = Rect.new(0, height - 12, width, 12)
    @back_bitmap.gradient_fill_rect(rect1, back_color2, back_color1, true)
    @back_bitmap.fill_rect(rect2, back_color1)
    @back_bitmap.gradient_fill_rect(rect3, back_color1, back_color2, true)
  end
  #--------------------------------------------------------------------------
  # * Get Background Color 1
  #--------------------------------------------------------------------------
  def back_color1
    Color.new(0, 0, 0, 160)
  end
  #--------------------------------------------------------------------------
  # * Get Background Color 2
  #--------------------------------------------------------------------------
  def back_color2
    Color.new(0, 0, 0, 0)
  end
  #--------------------------------------------------------------------------
  # * Create Background Sprite
  #--------------------------------------------------------------------------
  def create_back_sprite
    @back_sprite = Sprite.new
    @back_sprite.bitmap = @back_bitmap
    @back_sprite.visible = false
    @back_sprite.z = z - 1
  end
  #--------------------------------------------------------------------------
  # * Free All Windows
  #--------------------------------------------------------------------------
  def dispose_all_windows
    @gold_window.dispose
    @choice_window.dispose
    @number_window.dispose
    @item_window.dispose
  end
  #--------------------------------------------------------------------------
  # * Free Background Bitmap
  #--------------------------------------------------------------------------
  def dispose_back_bitmap
    @back_bitmap.dispose
  end
  #--------------------------------------------------------------------------
  # * Free Background Sprite
  #--------------------------------------------------------------------------
  def dispose_back_sprite
    @back_sprite.dispose
  end
  #--------------------------------------------------------------------------
  # * Update All Windows
  #--------------------------------------------------------------------------
  def update_all_windows
    @gold_window.update
    @choice_window.update
    @number_window.update
    @item_window.update
  end
  #--------------------------------------------------------------------------
  # * Update Background Sprite
  #--------------------------------------------------------------------------
  def update_back_sprite
    @back_sprite.visible = (@background == 1)
    @back_sprite.y = y
    @back_sprite.opacity = openness
    @back_sprite.update
  end
  #--------------------------------------------------------------------------
  # * Main Processing of Fiber
  #--------------------------------------------------------------------------
  def fiber_main
    $game_message.visible = true
    update_background
    update_placement
    loop do
      process_all_text if $game_message.has_text?
      process_input
      $game_message.clear
      @gold_window.close
      Fiber.yield
      break unless text_continue?
    end
    close_and_wait
    $game_message.visible = false
    @fiber = nil
  end
  #--------------------------------------------------------------------------
  # * Update Window Background
  #--------------------------------------------------------------------------
  def update_background
    @background = $game_message.background
    self.opacity = @background == 0 ? 255 : 0
  end
  #--------------------------------------------------------------------------
  # * Update Window Position
  #--------------------------------------------------------------------------
  def update_placement
    @position = $game_message.position
	case @position
		when 0;	self.y = System_Settings::MESSAGE_ORIGINAL_Y_TOP
		when 1;	self.y = System_Settings::MESSAGE_ORIGINAL_Y_MID
		when 2;	self.y = System_Settings::MESSAGE_ORIGINAL_Y_BOT
		when 3;	self.y = System_Settings::MESSAGE_ORIGINAL_Y_BOARD #board_mode
		else  ;	self.y = System_Settings::MESSAGE_ORIGINAL_Y_BOT
	end
    @gold_window.y = y > 0 ? 0 : Graphics.height - @gold_window.height
  end
  #--------------------------------------------------------------------------
  # * Process All Text
  #--------------------------------------------------------------------------
	def process_all_text
		open_and_wait
		text = convert_escape_characters($game_message.all_text)
		pos = {}
		new_page(text, pos)
		process_character(text.slice!(0, 1), text, pos) until text.empty?
	end
  
  #--------------------------------------------------------------------------
  # * Normal Character Processing
  #--------------------------------------------------------------------------
  
	def process_character(c,text,pos)
		if pos[:x] + next_word_width(c, text) >= self.contents.width
			pos[:new_x] = new_line_x
			process_new_line(c, pos)
		end
		super(c,text,pos)
		recordLogText(c,text)
		@line_show_fast = ($game_message.position==3 || $game_message.narrator)
	end
  
  
  #wordwarp test
  
  
  #def next_word_width(c, text)
  #  return 0 if c.eql?("\e")
  #  non_english= c.ord > 127
  #  c= "aa" if non_english
  #  word_width = text_size(c).width
  #  return word_width if text.empty? || non_english || c.strip.empty?
  #  return word_width #+ text_size(text[0, text.index(/\s/)]).width
  #end

	#def next_word_width(c, text)
	#	word_width = text_size(c).width
	#	return word_width if text.empty?
	#	return word_width + text_size(text[0, text.index(/\s/)]).width
	#end
  
	def next_word_width(c, text)
		return 0 if c.eql?("\e")
		c= "aa" if @str2Lang
		word_width = text_size(c).width
		return word_width if text.empty? || @str2Lang || c.strip.empty?
		if @str2Lang
			return word_width
		else
			return word_width + text_size(text[0, text.index(/\s/)]).width
		end
	end
	
		
	def	recordLogText(c,text)
		return if c.eql?("\e")
		if @message_board
			case c
			#when "\""
			#	return
			when "\n"
				return $story_stats["logBoard"] << "\\n\f"
			when "\f"
				return $story_stats["logBoard"] << "\\n\f"
				 
			end
			$story_stats["logBoard"] << c
			if $story_stats["logBoard"].bytesize >= 2000
				$story_stats["logBoard"][0..500] = ''
				$story_stats["logBoard"][0] = "\\}"
			end
		else
			return $story_stats["logTxt"] << "\\n\f" if text.empty?
			case c
			when "\n"
				return $story_stats["logTxt"] << "\\n\f"
			when "\f"
				return $story_stats["logTxt"] << "\\n\f"
			end
			$story_stats["logTxt"] << c
			if $story_stats["logTxt"].bytesize >= 3000
				$story_stats["logTxt"][0..500] = ''
				$story_stats["logTxt"][0] = "\\}"
			end
		end
	end

  #--------------------------------------------------------------------------
  # * Input Processing
  #--------------------------------------------------------------------------
  def process_input
    if $game_message.choice?
      input_choice
    elsif $game_message.num_input?
      input_number
    elsif $game_message.item_choice?
      input_item
    else
      input_pause unless @pause_skip
    end
  end
  #--------------------------------------------------------------------------
  # * Open Window and Wait for It to Fully Open
  #--------------------------------------------------------------------------
  def open_and_wait
    open
    Fiber.yield until open?
  end
  #--------------------------------------------------------------------------
  # * Close Window and Wait for It to Fully Close
  #--------------------------------------------------------------------------
  def close_and_wait
	force_timeout
	@narrator_back.visible = false
	$game_message.narrator = false
	@message_board = false
	close
	Fiber.yield until all_close?
  end
  #--------------------------------------------------------------------------
  # * Determine if All Windows Are Fully Closed
  #--------------------------------------------------------------------------
  def all_close?
    close? && @choice_window.close? &&
    @number_window.close? && @item_window.close?
  end
  #--------------------------------------------------------------------------
  # * Determine Whether to Continue Displaying Text 
  #--------------------------------------------------------------------------
  def text_continue?
    $game_message.has_text? && !settings_changed?
  end
  #--------------------------------------------------------------------------
  # * Determine if Background and Position Changed
  #--------------------------------------------------------------------------
  def settings_changed?
    @background != $game_message.background ||
    @position != $game_message.position
  end
  #--------------------------------------------------------------------------
  # * Wait
  #--------------------------------------------------------------------------
  def wait(duration)
	return if timeout?
    duration.times { Fiber.yield }
  end
  #--------------------------------------------------------------------------
  # * Update Fast Forward Flag
  #--------------------------------------------------------------------------
  def update_show_fast
    @show_fast = true if Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK) || (Mouse.enable? && Input.trigger?(:MZ_LINK) )
  end
  #--------------------------------------------------------------------------
  # * Wait After Output of One Character
  #--------------------------------------------------------------------------
  def wait_for_one_character
    update_show_fast
    Fiber.yield unless @show_fast || @line_show_fast
  end
  #--------------------------------------------------------------------------
  # * New Page
  #--------------------------------------------------------------------------
	def new_page(text, pos)
		self.oy = 0
		adjust_message_window_size if !@message_board
		contents.clear
		draw_face($game_message.face_name, $game_message.face_index, 0, 0)
		reset_font_settings
		pos[:x] = new_line_x
		pos[:y] = 0
		pos[:new_x] = new_line_x
		pos[:height] = calc_line_height(text)
		clear_flags
	end
  #--------------------------------------------------------------------------
  # * Get New Line Position
  #--------------------------------------------------------------------------
  def new_line_x
    $game_message.face_name.empty? ? 0 : 112
  end
  #--------------------------------------------------------------------------
  # * Normal Character Processing
  #--------------------------------------------------------------------------
  def process_normal_character(c, pos, text)
	super
    wait_for_one_character
  end
  #--------------------------------------------------------------------------
  # * New Line Character Processing
  #--------------------------------------------------------------------------
	def process_new_line(text, pos)
		#@line_show_fast = false
		creating_new_page = need_new_page?(text, pos)
		@line_show_fast = ($game_message.position==3 || $game_message.narrator)
		super
		if !@message_board && need_new_page?(text, pos)
			input_pause
			new_page(text, pos)
		end
		if !creating_new_page
			@content_height = pos[:y]+pos[:height]+standard_padding
		end
	end
  #--------------------------------------------------------------------------
  # * Determine if New Page Is Needed
  #--------------------------------------------------------------------------
  def need_new_page?(text, pos)
    pos[:y] + pos[:height] > contents.height && !text.empty?
  end
  #--------------------------------------------------------------------------
  # * New Page Character Processing
  #--------------------------------------------------------------------------
  def process_new_page(text, pos)
    text.slice!(/^\n/)
    input_pause
    new_page(text, pos)
  end
  #--------------------------------------------------------------------------
  # * Icon Drawing Process by Control Characters
  #--------------------------------------------------------------------------
  def process_draw_icon(icon_index, pos)
    super
    wait_for_one_character
  end
  #--------------------------------------------------------------------------
  # * Control Character Processing
  #     code : the core of the control character
  #            e.g. "C" in the case of the control character \C[1].
  #     text : character string buffer in drawing processing (destructive)
  #     pos  : draw position {:x, :y, :new_x, :height}
  #--------------------------------------------------------------------------
  def process_escape_character(code, text, pos)
    case code.upcase
    when '$'
      @gold_window.open
    when '.'
      wait(15)
    when '|'
      wait(60)
    when '!'
      input_pause
    when '>'
      @line_show_fast = true
    when '<'
      @line_show_fast = false
    when '^'
      @pause_skip = true
    else
      super
    end
  end
  #--------------------------------------------------------------------------
  # * Input Pause Processing
  #--------------------------------------------------------------------------
	def input_pause
		self.pause = true
		#System_Settings::MESSAGE_SKIP_FRAME
		wait(System_Settings::MESSAGE_SKIP_FRAME)
		Fiber.yield until Input.trigger?(:B) || Input.trigger?(:C) ||  (Mouse.enable? && Input.trigger?(:MZ_LINK) || Input.trigger?(:MX_LINK)) || Input.MsgSkipKeyPressed?|| timeout? || (WolfPad.trigger?(:Z_LINK) || WolfPad.trigger?(:X_LINK)) || Input.PressedAnySkillKey?
		force_timeout
		@timeout=false
		Input.update
		self.pause = false
	end
  #--------------------------------------------------------------------------
  # * Choice Input Processing
  #--------------------------------------------------------------------------
  def input_choice
    @choice_window.start
    Fiber.yield while @choice_window.active
	input_pause if !$game_message.choice?
  end
  #--------------------------------------------------------------------------
  # * Number Input Processing
  #--------------------------------------------------------------------------
  def input_number
    @number_window.start
    Fiber.yield while @number_window.active
  end
  #--------------------------------------------------------------------------
  # * Item Selection Processing
  #--------------------------------------------------------------------------
  def input_item
    @item_window.start
    Fiber.yield while @item_window.active
  end
  
  #--------------------------------------------------------------------------
  # * Get Line Height
  #--------------------------------------------------------------------------
  def line_height
    return System_Settings::MESSAGE_STD_LINE_HEIGHT
  end
  #--------------------------------------------------------------------------
  # * Get Standard Padding Size
  #--------------------------------------------------------------------------
  def standard_padding
    return System_Settings::MESSAGE_STD_PADDING
  end
end
