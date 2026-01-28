#A lot of basic things copied and modified from 194_menu_08System.rb
#Why aren't they part of some base class?
class Menu_Input_Base < Menu_ContentBase
#CONSTANTS
	#FONT_COLOR =[20,255,20,255]
	FONT_SIZE = 22
	KEY_FONT_SIZE = 18
	OPACITY_DISABLED = 80
	OPACITY_INACTIVE = 129
	OPACITY_ACTIVE=255
	BASE_LINE = 125
	UNIT_HEIGHT = 21
	OPEN_WAIT= 15
	#BACKGROUND_COLOR = [0,0,0,127]
	
#SETTINGS
	#is first column just a description of option or it can be selected?
	attr_accessor :firstColumnSelectable #default false
	
#PROPERTIES
	#parent window
	attr_accessor :parentWindow
	#is this window active right now?
	attr_accessor :activeSelf
	#child window, nil if none
	attr_accessor :childWindow
	
	
#CONSTRUCTOR/DESTRUCTOR
	
	def initialize(parentWindow)
		super()
		SceneManager.scene_is?(Scene_TitleOptInputMenu) ? @titleMode = false : @titleMode = true
		@firstColumnSelectable = false
		@parentWindow = parentWindow
		@cursor=SceneManager.scene.cursor
		@cursor_row_index=0
		@cursor_column_index=0
		@all_sprites = []
		create_background
		@commands = []
		create_buttons
		@activeSelf = false
		refresh
		set_cursor_position
	end
	
	def getColorModeText
		if @titleMode
			[20,255,20,255]
		else
			[255,255,255,255]
		end
	end
	
	def getColorModeBackground
		if @titleMode
			[0,0,0,127]
		else
			[0,0,0,0]
		end
	end
	
	def dispose
		@all_sprites.each{|sprite|
			sprite.bitmap.dispose
			sprite.dispose
		}
		@childWindow.dispose if !@childWindow.nil?
		super
	end

#VIRTUAL METHODS: fill them up
	def create_background
		#create sprite and bitmap to display as background
	end
	def create_buttons
		#fill @commands in following format:
		#[ [X,X,X,X], [Y,Y,Y,Y], Z]
		# X is sprite for each column of command
		# Y is method that is called if sprite with corresponding index is clicked, nil if no method
		# Z is method to refresh line that gets [X,X,X,X] as parameter
	end
	def skip_cursor_update
		false
	end

#NORMAL METHODS
#Is any window in this window hierarchy active currently?
	def active
		activeSelf || (!@childWindow.nil? && @childWindow.active)
	end
	
	def update
		return @childWindow.update if !@childWindow.nil? && @childWindow.active #pass update to child instead if it or its child active
		return unless @activeSelf
		update_input
	end

	def update_input
		return if @cursor.moving?
		return call_handler		if Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)
		return hide				if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK) || Input.trigger?(:MX_LINK)
		return press_up			if Input.repeat?(:UP)
		return press_down		if Input.repeat?(:DOWN)
		return prev_column		if Input.repeat?(:LEFT)
		return next_column		if Input.repeat?(:RIGHT)
		return next_page		if Input.repeat?(:R)
		return prev_page		if Input.repeat?(:L)
		mouse_input_check if Input.trigger?(:MZ_LINK)
	end

	
	def mouse_input_check
		return Mouse.ForceIdle if Input.MouseWheelForceIdle?
		return if !Mouse.enable?
		@commands.length.times{|tmpRow| #[0]raw. 
			@commands[tmpRow][0].length.times{|i|
				next if !@commands[tmpRow][1][i] # if its nil. skip
				next unless Mouse.within?(@commands[tmpRow][0][i])
				select_opt(i,tmpRow)
			}
		}
	end
		
	def select_opt(tmpX=0,tmpY=0)
		return call_handler if @cursor_column_index == tmpX && @cursor_row_index == tmpY
		p "tmpX #{tmpX} @cursor_column_index #{@cursor_column_index}"
		p "tmpY #{tmpY} @cursor_row_index    #{@cursor_row_index}"
		@cursor_column_index = tmpX
		@cursor_row_index = tmpY
		SndLib.play_cursor
		set_cursor_position
	end
	
	def uniform_text_sprite(x,y,width,height,text, fontSize = FONT_SIZE)
		spr=Sprite.new(@viewport)
		spr.bitmap=Bitmap.new(width,height)
		spr.bitmap.font.color.set(*getColorModeText)
		spr.bitmap.font.size=fontSize
		spr.bitmap.font.bold=false
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
	
  
	def return_from_key_inpur_force_actice
		#only use in parentWindow in main menu
		#unused in here, keep it empty so no crash
	end
	
	def hide
		super
		SndLib.sys_cancel if @activeSelf
		@activeSelf=false
		if !@parentWindow.nil? then
			@parentWindow.show
			@parentWindow.return_from_key_inpur_force_actice
			@parentWindow.set_cursor_position
		end
	end

	def show
		super
		@activeSelf = true
		set_cursor_position
	end

	def darken_single_line_sprites
		@commands.each{
			|cmd|
			next unless cmd[0].length==1
			cmd[0][0].opacity=OPACITY_INACTIVE
		}
	end
  
	def lighten_selected_sprite(selecting=true)
		@commands[@cursor_row_index][0][@cursor_column_index].opacity=OPACITY_ACTIVE
	end
	def darken_selected_sprite
		@commands[@cursor_row_index][0][@cursor_column_index].opacity=OPACITY_INACTIVE
	end
	def call_handler
		SndLib.sys_ok
		@commands[@cursor_row_index][1][@cursor_column_index].call
	end
	
	def press_up
		SndLib.play_cursor
		prev_row
	end
	def press_down
		SndLib.play_cursor
		next_row
	end
	def next_page
		SndLib.play_cursor
		10.times{next_row if @cursor_row_index<@commands.length-1}
	end
	def prev_page
		SndLib.play_cursor
		10.times{prev_row if @cursor_row_index>0}
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
			@cursor_column_index = 0
			lighten_selected_sprite(false)
		end
		set_cursor_position
	end
	
	def prev_column
		return if @commands[@cursor_row_index][0].length == 1 # only one line / no selection ,ex: SAVE_GAME /RETURN_TO_TITLE
		SndLib.play_cursor
		@cursor_column_index=@commands[@cursor_row_index][0].length-1 if (@firstColumnSelectable && (@cursor_column_index-=1) <0) || (!@firstColumnSelectable && (@cursor_column_index-=1) <= 0)
		set_cursor_position
	end
  
	def next_column
		return if @commands[@cursor_row_index][0].length == 1 # only one line / no selection ,ex: SAVE_GAME /RETURN_TO_TITLE
		SndLib.play_cursor
		if @firstColumnSelectable #由於進入設定模式後第0位會被 按鍵名稱所佔用 故直接跳一位
			@cursor_column_index=0 if (@cursor_column_index+=1) >= @commands[@cursor_row_index][0].length
		else
			@cursor_column_index=1 if (@cursor_column_index+=1) >= @commands[@cursor_row_index][0].length
		end
		set_cursor_position
	end
  
	def set_cursor_position
		return if @commands.empty?
		tgtspr=@commands[@cursor_row_index][0][@cursor_column_index]
		@cursor.to_xy(tgtspr.x-(@cursor.bitmap.width+5) ,tgtspr.y+6)
	end
	
	#calls command[2] for each command
	def refresh
		@commands.each{|command_row|
			command_row[2].call(command_row[0]) unless command_row[2].nil? #call refreshers
		}
	end	
end

#Input menu
class Menu_Input_Top < Menu_Input_Base

	
	def initialize(parentWindow)
		super(parentWindow)
		@firstColumnSelectable=true
	end

	def create_background
		@background = Sprite.new(@viewport)
		bitmap = Bitmap.new(640,360)
		bitmap.fill_rect(170,10+18,420,40,Color.new(*getColorModeBackground))
		@background.bitmap = bitmap
		@background.z = 1
		@all_sprites<<@background
	end

	def create_buttons
		keyboardText = InputUtils.get_text("DataInput:Text/Keyboard", "Keyboard")
		gamepadText = InputUtils.get_text("DataInput:Text/Gamepad", "GamePad")
		cancelText = InputUtils.get_text("DataInput:Text/Close", "Close")

		@commands=[
			[[uniform_text_sprite(200, 15+18, 100, 30, keyboardText), uniform_text_sprite(350, 15+18, 100, 30, gamepadText), uniform_text_sprite(500, 15+18, 100, 30, cancelText)], #Labels
			 [			method(:show_keyboard_menu),			method(:show_gamepad_menu),					method(:hide)], #Actions
			 nil] #Refresher
		]
		update_gamepad_availability
	end

	def show_keyboard_menu
		@keyboard_menu = Menu_Input_Bottom.new(self,true) if @keyboard_menu.nil? #caching window
		@childWindow = @keyboard_menu
		lighten_selected_sprite
		@childWindow.show
	end
	
	def show_gamepad_menu
		return if !WolfPad.plugged_in?
		@gamepad_menu = Menu_Input_Bottom.new(self,false) if @gamepad_menu.nil? #caching window
		@childWindow = @gamepad_menu
		lighten_selected_sprite
		@childWindow.show
	end

	def on_child_close
		darken_selected_sprite
		set_cursor_position
	end

	def update_gamepad_availability
		if WolfPad.plugged_in? then
			@commands[0][0][1].opacity = OPACITY_INACTIVE
		else
			@commands[0][0][1].opacity = OPACITY_DISABLED
		end
	end

	def update_input
		update_gamepad_availability
		super
	end
end


#Input menu
class Menu_Input_Bottom < Menu_Input_Base

	attr_accessor :keyboard
	

	FIRST_LINE_COORDINATE = [180, 65+18]
	FIRST_COLUMN_SIZE = 140
	INPUT_CELL_SIZE = [100,30]
	LINE_SIZE = 20
	LINES_DISPLAYED = 12
	RESTORE_DEFAULT_Y_OFFSET = 5 #How much last line ("Restore defaults") is offset by Y

#Arrows settings

#Used for setting position of arrows sprites
	ARROWS_UP = [85, -8]
	ARROWS_DOWN = [85, 248]

#Used for bitmap blitting of arrows
	ARROW_SIZE = [19,12]
	ARROW_1_X = 0
	ARROW_2_X = 90 + ARROW_SIZE[0]
	ARROW_3_X = 180 + ARROW_SIZE[0]*2

	def initialize(parentWindow, keyboard = true)
		@keyboard = keyboard
				
		super(parentWindow)

		create_arrows

		@cursor_column_index=1
		set_cursor_position

		@offset_lines=0 #move menu by X lines up and display only @offset_lines..LINES_DISPLAYED
	end	
		  
	def create_background
		@background = Sprite.new(@viewport)
		bitmap = Bitmap.new(640,360)
		bitmap.fill_rect(170,60+18,420,260, Color.new(*getColorModeBackground))
		@background.bitmap = bitmap
		@background.z = 1
		@all_sprites<<@background
	end

	def create_buttons
		if keyboard then
			@commands = []
			for i in 0..InputUtils.keyList.length-1
				key = InputUtils.keyList[i][0]
				key_text = InputUtils.get_text(InputUtils.keyList[i][1],InputUtils.keyList[i][2])
				x = FIRST_LINE_COORDINATE[0]
				y = FIRST_LINE_COORDINATE[1] + i * LINE_SIZE
				keyValues = Input::SYM_KEYS[key]
				if keyValues.nil? || keyValues.length < 3 then
					keyValue3 = "---"
				else
					keyValue3 = InputUtils.process_key_text(InputUtils.reverse_key_map[keyValues[2]])
				end
				if keyValues.nil? || keyValues.length < 2 then
					keyValue2 = "---"
				else
					keyValue2 = InputUtils.process_key_text(InputUtils.reverse_key_map[keyValues[1]])
				end
				if keyValues.nil? || keyValues.length < 1 then
					keyValue1 = "---"
				else
					keyValue1 = InputUtils.process_key_text(InputUtils.reverse_key_map[keyValues[0]])
				end
		
				newCommand = [
						[uniform_text_sprite(x, y, FIRST_COLUMN_SIZE, INPUT_CELL_SIZE[1], key_text), 
							uniform_text_sprite(x+FIRST_COLUMN_SIZE, y, INPUT_CELL_SIZE[0], INPUT_CELL_SIZE[1], keyValue1, KEY_FONT_SIZE), 
								uniform_text_sprite(x+FIRST_COLUMN_SIZE+INPUT_CELL_SIZE[0], y, INPUT_CELL_SIZE[0], INPUT_CELL_SIZE[1], keyValue2, KEY_FONT_SIZE), 
									uniform_text_sprite(x+FIRST_COLUMN_SIZE+2*INPUT_CELL_SIZE[0], y, INPUT_CELL_SIZE[0], INPUT_CELL_SIZE[1], keyValue3, KEY_FONT_SIZE)],
						[nil,	method(:start_assign_key), method(:start_assign_key), method(:start_assign_key)],
						nil
					]
				@commands << newCommand
			end
		else
			for i in 0..InputUtils.gamepadList.length-1
				key = InputUtils.gamepadList[i][0]
				key_text = InputUtils.get_text(InputUtils.gamepadList[i][1], InputUtils.gamepadList[i][2])
				
				x = FIRST_LINE_COORDINATE[0]
				y = FIRST_LINE_COORDINATE[1] + i * LINE_SIZE
				
				keyValue = WolfPad.keys[key]

				keyValue = "---" if keyValue < 0

				newCommand = [
						[uniform_text_sprite(x, y, FIRST_COLUMN_SIZE+INPUT_CELL_SIZE[0], INPUT_CELL_SIZE[1], key_text),
							#uniform_text_sprite(x+FIRST_COLUMN_SIZE+INPUT_CELL_SIZE[0], y, INPUT_CELL_SIZE[0]*2, INPUT_CELL_SIZE[1], keyValue)],
							uniform_text_sprite(x+FIRST_COLUMN_SIZE+INPUT_CELL_SIZE[0], y, INPUT_CELL_SIZE[0]*2, INPUT_CELL_SIZE[1], InputUtils.process_gamepad_text(keyValue))],
						[nil, method(:start_assign_gamepad)],
						nil
					]

				@commands << newCommand
			end
		end
		
		restoreDefaultText = InputUtils.get_text("DataInput:Text/RestoreDefault","Restore default values")
		@commands << [[nil, uniform_text_sprite(x,y, 400, LINE_SIZE, restoreDefaultText)],
				[nil, method(:load_defaults)],
				nil
			]

		for i in LINES_DISPLAYED..@commands.length-1
			hide_command_line(i)
		end
	end

	def hide_command_line(line)
		@commands[line][0][0].visible = false if @commands[line][0].length>0 && !@commands[line][0][0].nil?
		@commands[line][0][1].visible = false if @commands[line][0].length>1
		@commands[line][0][2].visible = false if @commands[line][0].length>2
		@commands[line][0][3].visible = false if @commands[line][0].length>3
	end
	def show_command_line(line)
		@commands[line][0][0].visible = true if @commands[line][0].length>0 && !@commands[line][0][0].nil?
		@commands[line][0][1].visible = true if @commands[line][0].length>1
		@commands[line][0][2].visible = true if @commands[line][0].length>2
		@commands[line][0][3].visible = true if @commands[line][0].length>3
	end
	def update_command_y_coordinate(line)
		y = coordY(line)
		y += RESTORE_DEFAULT_Y_OFFSET if line == @commands.length-1
		@commands[line][0][0].y = y if @commands[line][0].length>0 && !@commands[line][0][0].nil?
		@commands[line][0][1].y = y if @commands[line][0].length>1
		@commands[line][0][2].y = y if @commands[line][0].length>2
		@commands[line][0][3].y = y if @commands[line][0].length>3
	end
	def coordY(lineIndex)
		return FIRST_LINE_COORDINATE[1]+(lineIndex-@offset_lines)*LINE_SIZE
	end
	
	#create arrows that notify user that there are options higher than currently displayed
	def create_arrows
		arrow_source = Cache.load_bitmap(ROOT,"08Items/item_arrow")#Bitmap.new("#{ROOT}08Items/item_arrow")
		@arrow_up = Sprite.new(@viewport)
		@arrow_up.z = System_Settings::SCENE_Menu_Contents_Z
		@arrow_up.x=FIRST_LINE_COORDINATE[0]+ARROWS_UP[0]
		@arrow_up.y=FIRST_LINE_COORDINATE[1]+ARROWS_UP[1]
		@arrow_up.bitmap = Bitmap.new(ARROW_3_X+ARROW_SIZE[0], ARROW_SIZE[1])
		rect = Rect.new(20, 0, ARROW_SIZE[0], ARROW_SIZE[1])
		@arrow_up.bitmap.blt(ARROW_1_X,		0, arrow_source, rect)
		@arrow_up.bitmap.blt(ARROW_2_X, 	0, arrow_source, rect)
		@arrow_up.bitmap.blt(ARROW_3_X, 	0, arrow_source, rect)


		@arrow_down = Sprite.new(@viewport)
		@arrow_down.z = System_Settings::SCENE_Menu_Contents_Z
		@arrow_down.bitmap = Bitmap.new(ARROW_3_X+ARROW_SIZE[0], ARROW_SIZE[1])
		rect = Rect.new(0, 0, ARROW_SIZE[0], ARROW_SIZE[1])
		@arrow_down.x=FIRST_LINE_COORDINATE[0]+ARROWS_DOWN[0]
		@arrow_down.y=FIRST_LINE_COORDINATE[1]+ARROWS_DOWN[1]
		@arrow_down.bitmap.blt(ARROW_1_X, 	0, arrow_source, rect)
		@arrow_down.bitmap.blt(ARROW_2_X, 	0, arrow_source, rect)
		@arrow_down.bitmap.blt(ARROW_3_X, 	0, arrow_source, rect)

		hide_top_arrows #because initial cursor position is top
		
		@all_sprites << @arrow_up
		@all_sprites << @arrow_down
	end
	def hide_top_arrows
		@arrow_up.visible = false
	end
	def show_top_arrows
		@arrow_up.visible = true
	end
	def hide_bottom_arrows
		@arrow_down.visible = false
	end
	def show_bottom_arrows
		@arrow_down.visible = true
	end
	def refresh_arrows
		if @offset_lines == 0 then
			hide_top_arrows
		else
			show_top_arrows
		end
		if @offset_lines == @commands.length-LINES_DISPLAYED then
			hide_bottom_arrows
		else
			show_bottom_arrows
		end
	end

#if cursor is on last line and we press down, move menu down
	def move_menu_down
		return if @offset_lines == @commands.length
		hide_command_line(@offset_lines)
		show_command_line(@offset_lines+LINES_DISPLAYED)
		@offset_lines += 1
		for i in @offset_lines..@offset_lines+LINES_DISPLAYED-1
			update_command_y_coordinate(i)
		end
	end
#if cursor is on first line and we press up, move menu up
	def move_menu_up
		return if @offset_lines == 0
		@offset_lines -= 1
		show_command_line(@offset_lines)
		hide_command_line(@offset_lines+LINES_DISPLAYED)
		for i in @offset_lines..@offset_lines+LINES_DISPLAYED-1
			update_command_y_coordinate(i)
		end
	end

#if moving cicles list to bottom or top, easier to refresh all elements
	def menu_refresh(line)
		for i in @offset_lines..@offset_lines+LINES_DISPLAYED-1
			hide_command_line(i)
		end
		@offset_lines = line
		for i in @offset_lines..@offset_lines+LINES_DISPLAYED-1
			update_command_y_coordinate(i)
			show_command_line(i)
		end
	end

	def darken_line
		darken_selected_sprite
		@commands[@cursor_row_index][0][0].opacity=OPACITY_INACTIVE if !@commands[@cursor_row_index][0][0].nil?
	end
	def lighten_line
		lighten_selected_sprite
		@commands[@cursor_row_index][0][0].opacity=OPACITY_ACTIVE if !@commands[@cursor_row_index][0][0].nil?
	end
	
	def prev_row
		darken_line
		super
		if @cursor_row_index == @commands.length-1 then
			menu_refresh(@commands.length-LINES_DISPLAYED)
		elsif @cursor_row_index < @offset_lines
			move_menu_up
		end
		refresh_arrows
		set_cursor_position
		lighten_line
	end
	
	def next_row
		darken_line
		super
		if @cursor_row_index == 0 then
			menu_refresh(0)
		else
			move_menu_down if @cursor_row_index >= @offset_lines+LINES_DISPLAYED
		end
		refresh_arrows
		set_cursor_position
		lighten_line
	end

	def prev_column
		darken_selected_sprite
		super
		lighten_selected_sprite
	end
	def next_column
		darken_selected_sprite
		super
		lighten_selected_sprite
	end
	
	def start_assign_key
		if @childWindow.nil? || @childWindow.class != Menu_Input_Key then
			@childWindow.dispose if @childWindow
			@childWindow = Menu_Input_Key.new(self, true)
		end
		@childWindow.keyboard = true
		@childWindow.symbol = InputUtils.keyList[@cursor_row_index][0]
		@childWindow.bind_number = @cursor_column_index-1
		@childWindow.show
	end
	def start_assign_gamepad
		return if !WolfPad.plugged_in?
		if @childWindow.nil? || @childWindow.class != Menu_Input_Key then
			@childWindow.dispose if @childWindow
			@childWindow = Menu_Input_Key.new(self, false)
		end
		@childWindow.keyboard = false
		@childWindow.symbol = InputUtils.gamepadList[@cursor_row_index][0]
		@childWindow.bind_number = @cursor_column_index-1
		@childWindow.show
	end
	def load_defaults
		if @childWindow.nil? || @childWindow.class != Menu_Input_Reset_Defaults then
			@childWindow = Menu_Input_Reset_Defaults.new(self, @keyboard)
		end
		@childWindow.show
	end

	def refresh_current
		refresh_tile(@cursor_row_index,@cursor_column_index-1)
	end
	def refresh_tile(row, column)
		return if @commands[row][0][column+1].nil?
		if @keyboard then
			oldVisibility = @commands[row][0][column+1].visible
			oldSprite = @commands[row][0][column+1]
			oldSprite.bitmap.dispose
			oldSprite.dispose
			symbol = InputUtils.keyList[row][0]
			keysArray = Input::SYM_KEYS[symbol]
			keyText = InputUtils.process_key_text(InputUtils.reverse_key_map[keysArray[column]])
			keyText = "---" if keysArray[column]==0 || keysArray[column].nil?

			@commands[row][0][column+1] = uniform_text_sprite(FIRST_LINE_COORDINATE[0]+FIRST_COLUMN_SIZE+(column)*INPUT_CELL_SIZE[0], coordY(row), INPUT_CELL_SIZE[0], INPUT_CELL_SIZE[1], keyText, KEY_FONT_SIZE)
			@commands[row][0][column+1].visible = oldVisibility
		else
			oldVisibility = @commands[row][0][column+1].visible
			oldSprite = @commands[row][0][column+1]
			oldSprite.bitmap.dispose
			oldSprite.dispose
			symbol = InputUtils.gamepadList[row][0]
			keyText = WolfPad.keys[symbol]
			if keyText < 0
				keyText = "---"
			else
				keyText = InputUtils.process_gamepad_text(keyText)
			end
			
			@commands[row][0][column+1] = uniform_text_sprite(FIRST_LINE_COORDINATE[0]+FIRST_COLUMN_SIZE+INPUT_CELL_SIZE[0], coordY(row), INPUT_CELL_SIZE[0]*2, INPUT_CELL_SIZE[1], keyText)
			@commands[row][0][column+1].visible = oldVisibility
		end
	end
	def refresh_all_tiles
		for r in 0...@commands.length-1
			for c in 0...@commands[r][0].length-1
				refresh_tile(r,c)
			end
		end
	end
	
	def return_from_key_inpur_force_actice
		#only use in parentWindow in main menu
		#unused in here, keep it empty so no crash
	end
	
	def hide
		super
		@parentWindow.on_child_close
		InputUtils.save_keyboard_settings if @keyboard
		InputUtils.save_gamepad_settings if !@keyboard
	end
	def show
		super
		lighten_line
	end
end

class Menu_Input_Reset_Defaults < Menu_Input_Base
	attr_accessor :keyboard
	
	def initialize(parentWindow,keyboard)
		@keyboard = keyboard
		super(parentWindow)
	end
	def create_background
		@language_notice_back = Sprite.new
		@language_notice_back.bitmap = Cache.load_bitmap("Graphics/System/","chat_window_black_area50")
		@language_notice_back.z = System_Settings::SCENE_Menu_Cursor_Z + 2
	
		@language_notice = Sprite.new
		@language_notice.bitmap = Bitmap.new(Graphics.width, Graphics.height)
		@language_notice.z = @language_notice_back.z + 2
	

	
	
		bmp = @language_notice.bitmap
		bmp.font.outline=false
		bmp.font.color.set(*getColorModeText)
		bmp.font.size = 22
		text = InputUtils.get_text("DataInput:Text/RestoreDefaultConfirm", "Confirm or Cancel resetting to default")
		bmp.draw_text(100,140,440,25,text,1)
		
		bmp.font.outline=false
		bmp.font.size = 22
		bmp.font.color = Color.new(0,255,0)
		bmp.draw_text(238,168,166,42,InputUtils.getKeyAndTranslate(:C),0)
		bmp.font.color = Color.new(255,255,0)
		bmp.draw_text(238,168,166,42,InputUtils.getKeyAndTranslate(:B),2)
		bmp.font.color = Color.new(255,255,255)
		bmp.font.size = System_Settings::FONT_SIZE::EVENT_GUI_TITLE_MEDIAN #20
		bmp.draw_text(238,190,166,42,$game_text["DataInput:Key/Confirm"],0)
		bmp.draw_text(238,190,166,42,$game_text["DataInput:Key/Cancel"],2)
		
		

		@all_sprites << @language_notice_back
		@all_sprites << @language_notice
	end
	
	def update_input
		if Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK) || Input.trigger?(:MZ_LINK)then
			InputUtils.load_default_keyboard_settings if @keyboard
			InputUtils.load_default_gamepad_settings if !@keyboard
			@parentWindow.refresh_all_tiles
			return hide
		end
		if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK) || Input.trigger?(:MX_LINK)then
			return hide
		end
	end
	
	def return_from_key_inpur_force_actice
		#only use in parentWindow in main menu
		#unused in here, keep it empty so no crash
	end
	
	def hide
		super
		@language_notice_back.visible=false
		@language_notice.visible=false
	end
	def show
		super
		@language_notice_back.visible=true
		@language_notice.visible=true
	end
end

class Menu_Input_Key < Menu_Input_Base

	attr_accessor :symbol
	attr_accessor :bind_number
	attr_accessor :keyboard
	

	def initialize(parentWindow, keyboard)
		@keyboard = keyboard
		@first_update=true
		super(parentWindow)
	end

	def create_background
		text = InputUtils.get_text("DataInput:Text/EnterKey", "Please press key to assign it")

		@language_notice_back = Sprite.new
		@language_notice_back.bitmap = Cache.load_bitmap("Graphics/System/","chat_window_black_area50")
		@language_notice_back.z = System_Settings::SCENE_Menu_Cursor_Z + 2
	
		@language_notice = Sprite.new
		@language_notice.bitmap = Bitmap.new(Graphics.width, Graphics.height)
		@language_notice.z = @language_notice_back.z + 2
	
		bmp = @language_notice.bitmap
		bmp.font.outline=false
		bmp.font.color.set(*getColorModeText)
		bmp.font.size = 22
		bmp.draw_text(129,129,384,36,text,1)

		@all_sprites << @language_notice_back
		@all_sprites << @language_notice
	end

	def draw_error(errorName, fallback, keyLink, keyNameFallback)
		@language_notice.bitmap.dispose

		text = InputUtils.get_text("DataInput:Text/EnterKey", "Please press key to assign it")

		@language_notice.bitmap = Bitmap.new(Graphics.width, Graphics.height)
		@language_notice.z = @language_notice_back.z + 2
	
		bmp = @language_notice.bitmap
		bmp.font.outline=false
		bmp.font.color.set(*getColorModeText)
		bmp.font.size = 22
		bmp.draw_text(129,129,384,36,text,1)
		
		#hacking in order to be able to resolve #{} from translation text
		text = InputUtils.get_text(errorName, fallback)
		keyName = "???" #Shouldn't appear unless some error
		if !keyName.nil? && keyName != "" then
			keyName = InputUtils.get_text(keyLink, keyNameFallback)
		end
		text = eval('"'+text+'"')

		bmp = @language_notice.bitmap
		bmp.font.color.set(255,5,50,255)
		bmp.draw_text(100,205,440,25,text,1)
	end

	def update_input
		if @keyboard then
			0.upto(255) do |key|
				if Input.trigger?(key) then
					#Escape key cannot be assigned and is used to cancel assigning
					return hide if key == Input::KEYMAP[:ESCAPE]
					return hide if Input::SYM_KEYS[@symbol][@bind_number] == Input::KEYMAP[:ESCAPE] #Do not rebind Escape key
						

					##Find if that key is already in use somewhere
					#usedIn = []
					#Input::SYM_KEYS.each{|k,v|
					#	usedIn << k if v.include?(key) && !InputUtils.multiBindKeys.include?(k)
					#}
				
					#Safety first: there must be at least one key for OK/Cancel/Movement that should always be there.
					if !check_important_keys(key) then
						importantKey = nil
						keyName = nil
						keyNameFallback = nil
						#usedIn.any?{|k| importantKey = k if k==:B || k==:C || k==:UP || k==:DOWN || k==:LEFT || k==:RIGHT}
						if !importantKey.nil? then
							for l in InputUtils.keyList
								keyName = l[1] if l[0]==importantKey
								keyNameFallback = l[2] if l[0]==importantKey
							end
							SndLib.sys_buzzer
						end
						draw_error("DataInput:Text/ErrorImportantKey", "Assigning this key will make \"\#{keyName}\" unassigned!", keyName, keyNameFallback)
						return
					end

					##assigning key: remove from previous keybinds and assign to new one
					#usedIn.each{|keydel|
					#	for i in 0..Input::SYM_KEYS[keydel].length
					#		if Input::SYM_KEYS[keydel][i] == key then
					#			Input::SYM_KEYS[keydel][i] = 0
					#			for k in 0..InputUtils.keyList.length-1
					#				if InputUtils.keyList[k][0] == keydel then
					#					break
					#				end
					#			end
					#			@parentWindow.refresh_tile(k, i)
					#		end
					#	end
					#}
					while Input::SYM_KEYS[@symbol].length < @bind_number #array not guaranteed to have 3 mappings
						Input::SYM_KEYS[@symbol] << 0
					end
					Input::SYM_KEYS[@symbol][@bind_number] = key
					hide
					break
				end
			end
		else #gamepad
			return hide if !WolfPad.plugged_in? #I wonder if it can check that gamepad got unplugged?
			return hide if Input.trigger?(Input::KEYMAP[:ESCAPE]) #if keyboard command to exit
			
			0.upto(InputUtils.MAX_GAMEPAD_BUTTON) do |key|
				if !WolfPad.holds[0,key].nil? && WolfPad.holds[0,key]==1
					if InputUtils.gamepadMenuOnlyList.include?(@symbol)
						#if other menu button has same key, swap their places
						otherSymbol = nil
						InputUtils.gamepadMenuOnlyList.any?{|k|otherSymbol = k if k!=@symbol && WolfPad.keys[k]==key}
						if !otherSymbol.nil?
							WolfPad.keys[otherSymbol] = WolfPad.keys[@symbol]
						end
						
						#set key
						WolfPad.keys[@symbol]=key

						#hide and return
						return hide
					else
						#Menu open button must be assigned no matter what in order to make sure gamepad can assign gamepad buttons.
						if WolfPad.keys[:B] == key then
							WolfPad.keys[:B] = WolfPad.keys[@symbol]
						end

						##Find if that key is already in use somewhere
						#usedIn = []
						#WolfPad.keys.each{|k,v|
						#	usedIn << k if v == key && !InputUtils.gamepadMenuOnlyList.include?(k) && k != @symbol
						#}
					
						##remove key from other bindings
						#usedIn.each{|symb|
						#	WolfPad.keys[symb] = -1 if WolfPad.keys[symb]==key
						#	for k in 0..InputUtils.gamepadList.length-1
						#		if InputUtils.gamepadList[k][0]==symb then
						#			break
						#		end
						#	end
						#	@parentWindow.refresh_tile(k, 0)
						#}
						
						WolfPad.keys[@symbol]=key
						return hide
					end
				end
			end
		end
	end

	def get_key(symbol, number)
		return Input::SYM_KEYS[symbol][number] if Input::SYM_KEYS.has_key?(symbol) && !Input::SYM_KEYS[symbol].nil? && Input::SYM_KEYS[symbol].length > number
		0
	end

	def check_important_keys(key)
		check_input_has_other_key(:B, key) && check_input_has_other_key(:C, key) && check_input_has_other_key(:UP, key) && check_input_has_other_key(:DOWN, key) && check_input_has_other_key(:LEFT,key) && check_input_has_other_key(:RIGHT, key)
	end

	def check_input_has_other_key(symbol, key)
		key1 = get_key(symbol,0)
		key2 = get_key(symbol,1)
		key3 = get_key(symbol,2)
		return (key1!=key && key1!=0) || (key2!=key && key2!=0) || (key3!=key && key3!=0)
	end

	def return_from_key_inpur_force_actice
		#only use in parentWindow in main menu
		#unused in here, keep it empty so no crash
	end
	
	def show
		super
		draw_error("","","","")
		@language_notice_back.visible=true
		@language_notice.visible=true
	end
	def hide
		super
		@parentWindow.refresh_current
		@language_notice_back.visible=false
		@language_notice.visible=false
	end
end
