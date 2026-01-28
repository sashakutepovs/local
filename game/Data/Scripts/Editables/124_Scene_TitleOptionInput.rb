class Scene_TitleOptInputMenu < Scene_Map #Scene_Base
	ROOT = 'Graphics/System/Menu/'
	attr_reader :menu
	attr_reader :cursor
	attr_reader :gauge
	attr_reader :contents
	def start
		super
		@background_sprite = Sprite.new
		@background_sprite.bitmap = Cache.load_bitmap("Graphics/System/TitleScreen/","titleOptBg")
		@background_sprite.z = System_Settings::TITLE_COMMAND_WINDOW_Z-1
		contents = []
		contents << [""				,Input_TitleOptMenu			]
		create_menu(Array.new(contents.length){|id|contents[id][0]})
		@menu_index =0
		@menu.set_index(@menu_index)
		create_cursor
		create_contents(Array.new(contents.length){|id|contents[id][1].new})
		switch_page
		process_ok
	end

  
	def create_cursor
		@cursor = Menu_Cursor.new(20, @menu.current_y - 1,Cache.system("Menu/cursorW"))
	end
  
	def create_menu(command_names)
		@menu_index ||= 0
		@menu = Menu_Command.new(command_names)
		@menu.set_index(@menu_index)
	end
  
  
	def create_contents(contents)
		@contents = Menu_Contents.new(contents)
	end
	
	def switch_page
		@contents.switch_page(@menu_index)
	end
  
	def update
		super
		update_cursor
		update_contents
		if @menu.active
			SceneManager.goto(Scene_TitleOptions)
		end
	end
  
	def update_cursor
		@cursor.to_xy(20, @menu.current_y + 5) if @menu.active
		@cursor.update
	end
	

	def terminate
		super
		InputUtils.update_padSYM_in_UI
		@background_sprite.dispose
		dispose_sprites
	end
	
	def update_contents
		@contents.update
	end
	
	def process_ok
		@contents.process_ok(@menu_index) if @menu.active
	end
  
	def dispose_sprites
		@menu.dispose
		@contents.dispose
		@cursor.dispose
	end
	
	def return_from_key_inpur_force_actice
		#only use in parentWindow in main menu
		#unused in here, keep it empty so no crash
	end
end # Scene_Menu
#==============================================================================
# This script is created by Kslander 
#==============================================================================
#==============================================================================
# ** Menu_System
#==============================================================================

class Input_TitleOptMenu < Menu_ContentBase

	FONT_COLOR =[255,255,255,255]
	OPACITY_INACTIVE =129
	OPACITY_ACTIVE=255
	BASE_LINE = 125
	UNIT_HEIGHT = 21
	OPEN_WAIT= 0
	
	#GetPrivateProfileString   = Win32API.new('kernel32', 'GetPrivateProfileString'  , 'ppppip'      , 'i')
	#WritePrivateProfileString = Win32API.new('kernel32', 'WritePrivateProfileString', 'pppp'        , 'i')

  def initialize
    super
	@cursor=SceneManager.scene.cursor
	@cursor_row_index=0
	@cursor_column_index=0
	@wait_count=1
	@phase=0
	@all_sprites=Array.new #所有sprite的容器，用來重設所有sprite顏色使用
	get_scale_text
	create_sprites
	refresh
	hide
	@activeSelf=false
	key_opt_handler
  end
  
	def get_scale_text
		@scale_text = Graphics.getScaleTextFull
	end
  
	def create_sprites
		@info = Sprite.new(@viewport)
		@info.bitmap = Bitmap.new(Graphics.width, Graphics.height)
		@info.z = 2
		@commands=[
			[create_KEY_opt_sprite		,	method(:key_opt_handler)	, 	nil]
		]
	end

	def key_opt_handler
		@childWindow = Menu_Input_Top.new(self) #if @menuInput.nil?
		self.hide
		@childWindow.show
	end
	
	def uniform_text_sprite(x,y,width,height,text)
		spr=Sprite.new(@viewport)
		spr.bitmap=Bitmap.new(width,height)
		spr.bitmap.font.color.set(*FONT_COLOR)
		spr.bitmap.font.size = System_Settings::FONT_SIZE::SCENE_INPUT_OPTIONS
		spr.x = x
		spr.y = y
		spr.z = 3
		spr.bitmap.font.outline=false
		spr.bitmap.draw_text(0,0,width,height,text)
		spr.visible=true
		spr.opacity=OPACITY_INACTIVE
		@all_sprites << spr
		spr
	end


	def create_KEY_opt_sprite
		[
		uniform_text_sprite(198,BASE_LINE + UNIT_HEIGHT*-4 -7,160,30,InputUtils.get_text("", "Keybinding")),
		uniform_text_sprite(198,BASE_LINE + UNIT_HEIGHT,160,30,"")
		]
	end
	
  
  def darken_single_line_sprites
	@commands.each{
		|cmd|
		next unless cmd[0].length==1
		cmd[0][0].opacity=OPACITY_INACTIVE
	}
  end
  
  def lighten_selected_sprite(selecting=true)
	return if @commands[@cursor_row_index][0].length>1 && !selecting
	@commands[@cursor_row_index][0][@cursor_column_index].opacity=OPACITY_ACTIVE
  end
  
  def update_input
		return if @cursor.moving?
		return call_handler		if Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)
		return back_to_mainmenu if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK)
		return next_row  		if Input.repeat?(:DOWN)
		return prev_row  		if Input.repeat?(:UP)
		return prev_column  	if Input.repeat?(:LEFT)
		return next_column  	if Input.repeat?(:RIGHT)
  end
  
	def call_handler
		@commands[@cursor_row_index][1].call
	end
	
	def next_row
		@cursor_row_index=0 if (@cursor_row_index+=1)>=@commands.length
		selections=@commands[@cursor_row_index][0]
		darken_single_line_sprites
		if selections.length > 1 
			@cursor_column_index=1 if @cursor_column_index >= selections.length || @cursor_column_index==0
		else
			@cursor_column_index= 0
			lighten_selected_sprite(false)
		end
		set_cursor_position
	end
  
  def prev_row  
	@cursor_row_index = @commands.length-1 if  (@cursor_row_index-=1) <0
	selections=@commands[@cursor_row_index][0]
	darken_single_line_sprites
	if selections.length > 1 
		@cursor_column_index=1 if @cursor_column_index >= selections.length || @cursor_column_index==0
	else
		@cursor_column_index= 0
		
		lighten_selected_sprite(false)
	end
	set_cursor_position
  end
  
  def prev_column
	return if @commands[@cursor_row_index][0].length == 1 # only one line / no selection ,ex: SAVE_GAME /RETURN_TO_TITLE
	@cursor_column_index=@commands[@cursor_row_index][0].length-1 if (@cursor_column_index-=1) <=0
	set_cursor_position
  end
  
  def next_column
	return if @commands[@cursor_row_index][0].length == 1 # only one line / no selection ,ex: SAVE_GAME /RETURN_TO_TITLE
	@cursor_column_index=1 if (@cursor_column_index+=1) >=@commands[@cursor_row_index][0].length
	set_cursor_position
  end
  
	def set_cursor_position
		tgtspr=@commands[@cursor_row_index][0][@cursor_column_index]
		@cursor.to_xy(tgtspr.x-(@cursor.bitmap.width+5) ,tgtspr.y+6)
	end
  
	def update
		if !@childWindow.nil? && @childWindow.active then #child is active, pass update to child
			@childWindow.update
		else #we are active ourselves so process update
			back_to_mainmenu
		end
	end
  
  def refresh
	@commands.each{
		|command_row|
		command_row[2].call(command_row[0]) unless command_row[2].nil? #call refreshers
	}
  end
  
	def active
		activeSelf || (!@childWindow.nil? && childWindow.active)
	end
  
	def enter_page
		@phase=1
		@active =true
		@cursor.visible=true
		@cursor_column_index=0
		@cursor_row_index=0
		darken_single_line_sprites
		Input.update
		lighten_selected_sprite(false)
		refresh
		set_cursor_position
	end
  
  def show
	super
	@cursor_column_index=0
	@cursor_row_index=0
	darken_single_line_sprites
	@active=false
	@activeSelf=true #here @active=false happens, like wth? It's shown just now so it should be active, no?
  end
  
  def hide
	super
	@cursor_column_index=0
	@cursor_row_index=0
	@cursor_row_index=0
	@cursor_column_index=0
	darken_single_line_sprites
	@active=false
		@activeSelf=false
  end


	def back_to_mainmenu
		darken_single_line_sprites
		@phase = 0
		@menu.activate
	end  
  
  
  def darken_seletion_sprites(sprites)
	sprites.each do |spr| spr.opacity=OPACITY_INACTIVE; end
  end
  
  def dispose
		@childWindow.dispose if !@childWindow.nil?
		@info.dispose
		@info.bitmap.dispose
		@all_sprites.each do 
		|spr|  
		spr.bitmap.dispose
		spr.dispose
	end
	super
  end
	
	def return_from_key_inpur_force_actice
		#only use in parentWindow in main menu
		#unused in here, keep it empty so no crash
	end
end

