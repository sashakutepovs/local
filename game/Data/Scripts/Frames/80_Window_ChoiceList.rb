#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
#==============================================================================
# ** Window_ChoiceList
#------------------------------------------------------------------------------
#  This window is used for the event command [Show Choices].
#==============================================================================

class Window_ChoiceList < Window_Command
	include Timeout
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(message_window)
    @viewport = Viewport.new(0, 124, Graphics.width, 107)
	#@viewport.src_rect = Rect.new(,124,107)
    @viewport.z = System_Settings::OPT_CONFRIM_LIST_Z
    @viewport.visible = false
    @viewport_back = Viewport.new
    @viewport_back.z = System_Settings::OPT_CONFRIM_LIST_Z
    @viewport_back.visible = false
    @back = Sprite.new(@viewport_back)
    @back.bitmap = Bitmap.new("Graphics/System/chat_window_black_area50")
    @arrow_up = Sprite.new(@viewport_back)
    @arrow_down = Sprite.new(@viewport_back)
    @arrow_up.bitmap = @arrow_down.bitmap = Bitmap.new("Graphics/System/arrows")
    @arrow_up.src_rect.width = @arrow_down.src_rect.width = @arrow_up.bitmap.width/3
    @arrow_down.src_rect.x = @arrow_down.src_rect.width
    @arrow_up.x = @arrow_down.x = (Graphics.width - @arrow_up.width)/2
    @arrow_up.z = System_Settings::OPT_CONFRIM_ARROW_Z
    @arrow_up.y = 107
    @arrow_down.y = 240
    @option_sprites = []
	@real_index=[]
    @message_window = message_window
	@text_choice=Text.new
	@selected_color= Color.new(255,255,255)
	@normal_color= Color.new(120,120,120)
	@initialized=false
    super(0, 0)
    self.openness = 0
	self.z = System_Settings::OPT_CONFRIM_LIST_Z_TEXT
	self.windowskin =Bitmap.new(1,1)
	@initialized=true
    deactivate
	self.contents=Bitmap.new(1000,1000)
	setup_message_font
  end
  #--------------------------------------------------------------------------
  # * Start Input Processing
  #--------------------------------------------------------------------------
  
	def setup_message_font
		super
		contents.font.size= System_Settings::FONT_SIZE::OPTION_WINDOW
	end
  def start
    update_placement
    refresh
	return if @list.length == 0
    select(0)
    open
    activate
	self.index=0
  end
  
  def create_contents
	self.contents=Bitmap.new(1000,1000) if self.contents.disposed?
	setup_message_font
	#self.contents.font.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
	self.contents.font.name = Font.default_name
	self.contents.font.bold = true
	self.contents.font.color=@normal_color
	for index in 0...@list.length
		next if index == self.index
		draw_item(index)
	end
  end
  
  def open
	super
	@viewport.visible = true
    @viewport_back.visible = true
  end
  
	def update
		return unless @viewport.visible
		super
		update_timeout  if @viewport.visible #呼叫Timeout 模組中的方法
		update_scroll if @viewport.visible
		update_mouse_option_window if self.active
	end
  
  #override
  def cursor_down(wrap = false)
	#可見選項數:5
	super
	@arrow_up.visible =  @list.length >5 && self.index > 4
 	@arrow_down.visible =@list.length >5 && self.index < (@list.length-1)
  end
  
  #override
  def cursor_up(wrap = false)
	#可見選項數:5
    super
	@arrow_up.visible =  @list.length >5 && self.index != 0 
 	@arrow_down.visible =@list.length >5 && self.index < (@list.length-1)
  end
  
  def update_scroll
    return unless @viewport.visible	
	@viewport.oy = item_height * self.index + item_height * center_index if @list.length - self.index > 0
  end
  
  def center_index
	return 3
  end
    
  #--------------------------------------------------------------------------
  # * Update Window Position
  #--------------------------------------------------------------------------
  def update_placement
    self.width = 640#[max_choice_width + 12, 96].max + padding * 2
    self.width = [width, Graphics.width].min
    self.height =150
    self.x = 0
	self.y = Graphics.height/ 3 - 14
  end
  #--------------------------------------------------------------------------
  # * Get Maximum Width of Choices
  #--------------------------------------------------------------------------
  def max_choice_width
    $game_message.choices.collect {|s| text_size(s).width }.max
  end
  #--------------------------------------------------------------------------
  # * Calculate Height of Window Contents
  #--------------------------------------------------------------------------
  def contents_height
    item_max * item_height
  end
  #--------------------------------------------------------------------------
  # * Create Command List
  #--------------------------------------------------------------------------
  def make_command_list
	set_timeout($game_message.timeout) if $game_message.timeout
	@current_last=0
	@real_index=[]
	for ind in 0...$game_message.choices.length
		if $game_message.choices[ind].is_a?(Struct::ConditionalChoice)
			next if $story_stats[$game_message.choices[ind].condition]!="1"
			@real_index.push($game_message.choices[ind].real_index)
			choice=@text_choice[$game_message.choices[ind].choice]
			add_command(choice, :choice)
		else
			@real_index.push(ind)
			choice=$game_message.choices[ind]
			choice=@text_choice[choice]
			add_command(choice, :choice)
		end
	end
	$game_message.choices.clear if @list.length == 0
  end
  
  
  
  #複寫來自Timeout模組的方法
  def on_timeout
	$game_message.timeout=nil
	$game_message.choice_proc.call($game_message.choice_timeout_type)
	deactivate
	close
  end
  #--------------------------------------------------------------------------
  # * Draw Item
  #--------------------------------------------------------------------------
  def draw_item(index)
    rect = item_rect_for_text(index)
	self.contents.font.outline = false
	self.contents.draw_text(item_rect_for_text(index),command_name(index),1)
  end
  
  def draw_selected_item()
    rect = item_rect_for_text(self.index)
	self.contents.font.color=@selected_color
	self.contents.font.outline = false
	self.contents.draw_text(rect,"> #{command_name(self.index)} <",1)  
	self.contents.font.color=@normal_color
  end
  
  #--------------------------------------------------------------------------
  # * Get Activation State of Cancel Processing
  #--------------------------------------------------------------------------
  def cancel_enabled?
    $game_message.choice_cancel_type > 0
  end
  #--------------------------------------------------------------------------
  # * Call OK Handler
  #--------------------------------------------------------------------------
  def call_ok_handler
	$game_temp.choice=@real_index[index]
    $game_message.choice_proc.call(index)
	force_timeout
    close
  end
  
	def cursor_pageup
		3.times{cursor_up}
	end
	def cursor_pagedown
		3.times{cursor_down}
	end
  #--------------------------------------------------------------------------
  # * Call Cancel Handler
  #--------------------------------------------------------------------------
  def call_cancel_handler
	$game_temp.choice=-1
    $game_message.choice_proc.call($game_message.choice_cancel_type - 1)
	force_timeout
    close
  end
  
  def select(index)
	super(index)
	$game_temp.choice=@real_index[index]
	refresh
  end
  
  def refresh
	super
	return if @list.length==0
	@arrow_down.visible = @list.length >5
	draw_selected_item if @initialized
  end
  
	def deactivate
		@arrow_down.visible=false
		@arrow_up.visible=false
		@viewport_back.visible=false
		self.contents.clear
		super
	end
  
	def close
		self.index=0
		super
	end	
	def process_handling
		return unless open? && active
		return process_ok       if ok_enabled?        && (Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK))
		SndLib.sys_buzzer if !cancel_enabled? && (Input.trigger?(:B) || WolfPad.trigger?(:X_LINK))
		return process_cancel   if cancel_enabled?    && (Input.trigger?(:B) || WolfPad.trigger?(:X_LINK))
		return process_pagedown if handle?(:pagedown) && (Input.trigger?(:R) || Input.trigger?(:NUMPAD2))
		return process_pageup   if handle?(:pageup)   && (Input.trigger?(:L) || Input.trigger?(:NUMPAD8))
	end


end
