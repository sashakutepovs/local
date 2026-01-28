
#Utilities and default settings
module InputUtils
	#Try to load text "name". If it fails to load, writes error in console and displays fallback if it's set. If it is not set, write name we tried to load.
	def self.get_text(name, fallback = nil)
		return "" if name == ""
		res = $game_text[name]
		p "Translation not found: #{name} for language #{DataManager.get_lang_constant}" if res.nil?
		res = fallback if res.nil?
		res = name if res.nil?
		return res
	end
	
	def self.MAX_GAMEPAD_BUTTON
		25
	end
	#Array format: [SYMBOL, Translation_Link, Translation_Fallback, [DefaultKeys]]
	@keyList =[
			[:UP, "DataInput:Key/Up", "Up", 										[:UP,0]],
			[:DOWN, "DataInput:Key/Down", "Down", 									[:DOWN,0]],
			[:LEFT, "DataInput:Key/Left", "Left", 									[:LEFT]],
			[:RIGHT, "DataInput:Key/Right", "Right", 								[:RIGHT]],
			[:B, "DataInput:Key/Cancel", "Cancel/Menu", 							[:LETTER_X,0,:ESCAPE]],
			[:C, "DataInput:Key/Confirm", "Select/Interact", 						[:LETTER_Z,0,:RETURN]],
			[:L, "DataInput:Key/L","L", 											[:PRIOR,:WheelD]],
			[:R, "DataInput:Key/R","R", 											[:NEXT,:WheelU]],
			[:SHIFT, "DataInput:Key/Shift","Shift", 								[:SHIFT]],
			[:CTRL, "DataInput:Key/Ctrl","Ctrl",									[:CONTROL]],
			[:ALT, "DataInput:Key/Alt","Alt", 										[:ALT]],
			[:S1, "DataInput:Key/S1","S1", 											[:LETTER_A]],
			[:S2, "DataInput:Key/S2","S2", 											[:LETTER_S]],
			[:S3, "DataInput:Key/S3","S3", 											[:LETTER_D]],
			[:S4, "DataInput:Key/S4","S4", 											[:LETTER_F]],
			[:S5, "DataInput:Key/S5","S5", 											[:LETTER_Q]],
			[:S6, "DataInput:Key/S6","S6", 											[:LETTER_W]],
			[:S7, "DataInput:Key/S7","S7", 											[:LETTER_E]],
			[:S8, "DataInput:Key/S8","S8", 											[:LETTER_R]],
			[:S9, "DataInput:Key/S9","S9", 											[:SPACE]],
			[:D8, "DataInput:Key/D8","D8", 											[:NUMPAD8]],
			[:D2, "DataInput:Key/D2","D2", 											[:NUMPAD2]],
			[:D4, "DataInput:Key/D4","D4", 											[:NUMPAD4]],
			[:D6, "DataInput:Key/D6","D6", 											[:NUMPAD6]],
			[:UI_SORT, "DataInput:Key/Sort","SORT",									[:LETTER_A]],
			[:UI_DeleteItem, "UI_DeleteItem","UI_DeleteItem",						[:SPACE]]
		]
		
	@hiddenKeys=[
			[:F5, "DataInput:Key/F5","F5", 						[:F5]],
			[:F6, "DataInput:Key/F6","F6", 						[:F6]],
			[:F7, "DataInput:Key/F7","F7", 						[:F7]],
			[:F8, "DataInput:Key/F8","F8", 						[:F8]],
			[:F9, "DataInput:Key/F9","F9", 						[:F9]],
			[:Z_LINK, "DataInput:Pad/Z_link","Menu Select",		[0]],
			[:X_LINK, "DataInput:Pad/X_link","Menu Cancel", 	[0]]
		]



	#Array format: [SYMBOL, Translation_Link, Translation_Fallback, DefaultKey
	@gamepadList=[
		[:UP, "DataInput:Key/Up","Up", 					15],	#d-pad UP
		[:DOWN,"DataInput:Key/Down","Down", 			14],	#d-pad DOWN
		[:LEFT,"DataInput:Key/Left","Left", 			13],	#d-pad LEFT
		[:RIGHT,"DataInput:Key/Right","Right", 			12],	#d-pad RIGHT
		[:B, "DataInput:Key/Menu","Menu", 				10],	#Back <
		[:C, "DataInput:Key/Interact","Interact", 		11],	#start >
		[:X_LINK, "DataInput:Key/X_link","Menu Cancel", 2],		#B
		[:Z_LINK, "DataInput:Key/Z_link","Menu Select", 3],		#A
		#[:R, "DataInput:Key/R","R", 					-1],		#R3
		#[:L, "DataInput:Key/L","L",	 				-1],		#L3
		[:R, "DataInput:Key/L","R", 					8],	#9left mushroom button #pgup
		[:L, "DataInput:Key/R","L",						9],	#9left mushroom button #pgdn
		#[:R, "DataInput:Key/L","L", 					24],		#right mushroom R_UP pgup
		#[:L, "DataInput:Key/R","R",	 				25],		#right mushroom R_DOWN
		[:SHIFT, "DataInput:Key/Shift","Shift", 		17],	#lower right trigger (press only) RT
		[:CTRL, "DataInput:Key/Ctrl","Ctrl", 			7],		#upper left trigger
		[:ALT, "DataInput:Key/Alt","Alt", 				16],	#lower left trigger (press only) LT
		[:S1, "DataInput:Key/S1","S1", 					3],		#A
		[:S2, "DataInput:Key/S2","S2", 					2],		#B
		[:S3, "DataInput:Key/S3","S3", 					1],		#X
		[:S4, "DataInput:Key/S4","S4", 					0],		#Y
		[:S5, "DataInput:Key/S5","S5", 					20],	#right mushroom R_DOWN
		[:S6, "DataInput:Key/S6","S6", 					19],	#right mushroom R_RIGHT
		[:S7, "DataInput:Key/S7","S7", 					18],	#right mushroom R_LEFT
		[:S8, "DataInput:Key/S8","S8", 					21],	#right mushroom R_UP
		[:S5, "DataInput:Key/S5","S5", 					24],	#right mushroom R_DOWN
		[:S6, "DataInput:Key/S6","S6", 					22],	#right mushroom R_RIGHT
		[:S7, "DataInput:Key/S7","S7", 					23],	#right mushroom R_LEFT pgdn
		[:S8, "DataInput:Key/S8","S8", 					25],	#right mushroom R_UP
		[:S9, "DataInput:Key/S9","S9",	 				6],		#upper right trigger
		[:D8, "DataInput:Key/D8","D8", 					25],	#left mushroom L_UP
		[:D2, "DataInput:Key/D2","D2", 					24],	#left mushroom L_DOWN
		[:D4, "DataInput:Key/D4","D4", 					23],	#left mushroom L_LEFT
		[:D6, "DataInput:Key/D6","D6", 					22],		#left mushroom L_RIGHT
		[:UI_Sort, "DataInput:Key/Sort","SORT", 		3],			#A
		[:UI_DeleteItem, "DataInput:Key/UI_DeleteItem","UI_DeleteItem", 		6]		 #upper right trigger
		]

	
	#Mouse default keys
	@mouseDefaultKeys = [
			[:MLB, "DunnoUnused","MLB", 				[:LBUTTON]],
			[:MRB, "ClickMove","MRB", 					[:RBUTTON]],
			[:MZ_LINK, "UI_Confirm","MZ_LINK", 			[:LBUTTON]],
			[:MM_LINK, "UI_Middle","MM_LINK", 			[:MBUTTON]],
			[:MX_LINK, "UI_Cancel","MX_LINK", 			[:RBUTTON]]
		]
	
	#keys can multi binding
	@multiBindKeys = [:MZ_LINK, :MM_LINK,:MX_LINK]
	
	#keys that are not displayed in Key Binding menu
	@mouseKeys = [:MLB,:MRB,:MZ_LINK, :MM_LINK,:MX_LINK]
	
	#list of symbols that are only used in menus
	@gamepadMenuOnlyList=[:X_LINK,:Z_LINK,:R,:L]
	
	#Used to search key symbol by key value. Initialized on first get (Note: initialization must be called after hime's Input:: file)
	@reverse_key_map = nil
	
	#Mouse key getters
	def self.mouse_on
		@keyList << @mouseDefaultKeys[0]
		@keyList << @mouseDefaultKeys[1]
		@keyList << @mouseDefaultKeys[2]
		@keyList << @mouseDefaultKeys[3]
		@keyList << @mouseDefaultKeys[4]
	end
	
	def self.load_MouseDefautKeys_to_ini
		#keyList.last[2] = ButtomName   		@keyList.last[3][0].to_s = buttom string
		InputUtils.mouseDefaultKeys.each do |tmpKey|
			tmpSetKey = tmpKey[2]
			tmpButton = tmpKey[3][0].to_s
			tmpButton = tmpKey[3][0].to_s
			tmpA1 = [nil,"",0].include?($LonaINI["Keyboard"][tmpSetKey+"_0"])
			tmpA2 = [nil,"",0].include?($LonaINI["Keyboard"][tmpSetKey+"_1"])
			tmpA3 = [nil,"",0].include?($LonaINI["Keyboard"][tmpSetKey+"_2"])
			if tmpA1 && tmpA2 && tmpA3
				$LonaINI["Keyboard"][tmpSetKey+"_0"] = tmpButton
				$LonaINI["Keyboard"][tmpSetKey+"_1"] = ""
				$LonaINI["Keyboard"][tmpSetKey+"_2"] = ""
				$LonaINI.save
			end
		end
	end
	
	def self.mouse_off
		@keyList.delete([:MLB, "DunnoUnused","MLB", 				[:LBUTTON]])
		@keyList.delete([:MRB, "ClickMove","MRB", 					[:RBUTTON]])
		@keyList.delete([:MZ_LINK, "UI_Confirm","MZ_LINK", 			[:LBUTTON]])
		@keyList.delete([:MM_LINK, "UI_Middle","MM_LINK", 			[:MBUTTON]])
		@keyList.delete([:MX_LINK, "UI_Cancel","MX_LINK", 			[:RBUTTON]])
	end
	
	def self.mouseDefaultKeys
		@mouseDefaultKeys
	end
	
	def self.multiBindKeys
		return @multiBindKeys
	end
	def self.keyList
		return @keyList
	end
	def self.gamepadList
		return @gamepadList
	end
	def self.gamepadMenuOnlyList
		return @gamepadMenuOnlyList
	end
	def self.reverse_key_map
		if @reverse_key_map.nil? then
			@reverse_key_map = {0 => "---"}
			Input::KEYMAP.each{|k,v| @reverse_key_map[v]=k } #setting up reverse key map
		end
			
		return @reverse_key_map
	end

	
	@keySYM_in_UI = {
		:LETTER_A			=>"A",		:LETTER_L			=>"L",
		:LETTER_B			=>"B",		:LETTER_M			=>"M",
		:LETTER_C			=>"C",		:LETTER_N			=>"N",
		:LETTER_D			=>"D",		:LETTER_O			=>"O",
		:LETTER_E			=>"E",		:LETTER_P			=>"P",
		:LETTER_F			=>"F",		:LETTER_Q			=>"Q",
		:LETTER_G			=>"G",		:LETTER_R			=>"R",
		:LETTER_H			=>"H",		:LETTER_S			=>"S",
		:LETTER_I			=>"I",		:LETTER_T			=>"T",
		:LETTER_J			=>"J",		:LETTER_U			=>"U",
		:LETTER_K			=>"K",		:LETTER_V			=>"V",
		:LBUTTON			=>"ML",		:RBUTTON			=>"MR",
		:MBUTTON			=>"MM",		:XBUTTON1			=>"MB1",
		:XBUTTON2			=>"MB2",	:WheelU				=>"MWU",
		:WheelD				=>"MWD",
		
		:LETTER_W			=>"W",		:RIGHT				=>"➡",
		:LETTER_X			=>"X",		:NUMPAD0			=>"Num0",
		:LETTER_Y			=>"Y",		:NUMPAD1			=>"Num1",
		:LETTER_Z			=>"Z",		:NUMPAD2			=>"Num2",
		:RETURN				=>"⏎",		:NUMPAD3			=>"Num3",
		:BACK				=>"←",		:NUMPAD4			=>"Num4",
		:TAB				=>"↹",		:NUMPAD5			=>"Num5",
		:CONTROL			=>"Ctrl",	:NUMPAD6			=>"Num6",
		:CONTROL			=>"Ctrl",	:NUMPAD6			=>"Num6",
		:UP					=>"⬆",		:NUMPAD7			=>"Num7",
		:DOWN				=>"⬇",		:NUMPAD8			=>"Num8",
		:LEFT				=>"⬅",		:NUMPAD9			=>"Num9",
		
		:SHIFT				=>"⇧",		:THORN				=>"'",
		:CAPITAL			=>"Caps",	:onequarter			=>",",
		:SPACE				=>"SP",		:threequarters		=>".",
		:ESCAPE				=>"Esc",	:questiondown		=>"/",
		:Agrave				=>"`",		:SNAPSHOT			=>"PrtSc",
		:onehalf			=>"-",		:SCROLL				=>"ScrLk",
		:guillemotright		=>"=",		:PRIOR				=>"PgDn",
		:Ucircumflex		=>"[",		:NEXT				=>"PgUp",
		:Yacute				=>"]",		:NUMLOCK			=>"NumLk",
		:Udiaeresis			=>"\\",		:INSERT				=>"Ins",
		:masculine			=>";",		:DELETE				=>"Del",
	
		:DIVIDE				=>"/",		:KEY_7				=>"7",
		:multiply			=>"*",		:KEY_8				=>"8",
		:SUBTRACT			=>"-",		:KEY_9				=>"9",
		:ADD				=>"+",
		:N0					=>"0",
		:KEY_1				=>"1",
		:KEY_2				=>"2",
		:KEY_3				=>"3",
		:KEY_4				=>"4",
		:KEY_5				=>"5",
		:KEY_6				=>"6"
	}
	@keySYMlong_in_UI = {
		:RETURN		=>"Enter",
		:BACK		=>"Backspace",
		:TAB		=>"Tab",
		:SHIFT		=>"Shift",
		:SPACE		=>"Space",
		:CAPITAL	=>"CapsLock"
		
	}
	
	
	def self.update_padSYM_in_UI
		@padSYM_in_UI = {
				0	=>"Ⓨ",
				1	=>"Ⓧ",
				2	=>"Ⓑ",
				3	=>"Ⓐ",
				6	=>"RB",
				7	=>"LB",
				8	=>"R◉",
				9	=>"L◉",
				10	=>"▚",
				11	=>"≡",
				12	=>"➡",
				13	=>"⬅",
				14	=>"⬇",
				15	=>"⬆",
				16	=>"LT",
				17	=>"RT",
				18	=>"L◑",
				19	=>"L◐",
				20	=>"L◒",
				21	=>"L◓",
				22	=>"R◑",
				23	=>"R◐",
				24	=>"R◒",
				25	=>"R◓"
		}
		@padSYMlong_in_UI = {
				10	=>"Select",
				11	=>"Start",
		}
		case $data_GamePadUImode
			when "PS"
				@padSYM_in_UI[0] 	= "▲"	#Y
				@padSYM_in_UI[1] 	= "■"	#X
				@padSYM_in_UI[2] 	= "●"	#B
				@padSYM_in_UI[3] 	= "Ⅹ"	#A
				@padSYM_in_UI[6] 	= "R1"
				@padSYM_in_UI[17]	= "R2"
				@padSYM_in_UI[7]	= "L1"
				@padSYM_in_UI[16]	= "L2"
			when "ND"
				@padSYM_in_UI[1]	= "Ⓨ"
				@padSYM_in_UI[0]	= "Ⓧ"
			when "KB"
				@padSYM_in_UI[0]	= getKeyAndTranslateKeyBoardOnly(:S4)
				@padSYM_in_UI[1]	= getKeyAndTranslateKeyBoardOnly(:S3)
				@padSYM_in_UI[2]	= getKeyAndTranslateKeyBoardOnly(:S2)
				@padSYM_in_UI[3]	= getKeyAndTranslateKeyBoardOnly(:S1)
				@padSYM_in_UI[6]	= getKeyAndTranslateKeyBoardOnly(:S9)
				@padSYM_in_UI[7]	= getKeyAndTranslateKeyBoardOnly(:CTRL)
				@padSYM_in_UI[10]	= getKeyAndTranslateKeyBoardOnly(:B)
				@padSYM_in_UI[11]	= getKeyAndTranslateKeyBoardOnly(:C)
				@padSYM_in_UI[12]	= getKeyAndTranslateKeyBoardOnly(:RIGHT)
				@padSYM_in_UI[13]	= getKeyAndTranslateKeyBoardOnly(:LEFT)
				@padSYM_in_UI[14]	= getKeyAndTranslateKeyBoardOnly(:DOWN)
				@padSYM_in_UI[15]	= getKeyAndTranslateKeyBoardOnly(:UP)
				@padSYM_in_UI[17]	= getKeyAndTranslateKeyBoardOnly(:SHIFT)
				@padSYM_in_UI[18]	= getKeyAndTranslateKeyBoardOnly(:D6)
				@padSYM_in_UI[19]	= getKeyAndTranslateKeyBoardOnly(:D4)
				@padSYM_in_UI[20]	= getKeyAndTranslateKeyBoardOnly(:D2)
				@padSYM_in_UI[21]	= getKeyAndTranslateKeyBoardOnly(:D8)
				@padSYM_in_UI[22]	= getKeyAndTranslateKeyBoardOnly(:S6)
				@padSYM_in_UI[23]	= getKeyAndTranslateKeyBoardOnly(:S7)
				@padSYM_in_UI[24]	= getKeyAndTranslateKeyBoardOnly(:S5)
				@padSYM_in_UI[25]	= getKeyAndTranslateKeyBoardOnly(:S8)
		end
		if $data_GamePadUImode == "PS"
			@padSYM_in_UI[0] 	= "▲"	#Y
			@padSYM_in_UI[1] 	= "■"	#X
			@padSYM_in_UI[2] 	= "●"	#B
			@padSYM_in_UI[3] 	= "Ⅹ"	#A
			@padSYM_in_UI[6] 	= "R1"
			@padSYM_in_UI[17]	= "R2"
			@padSYM_in_UI[7]	= "L1"
			@padSYM_in_UI[16]	= "L2"
		end
	end
	
	#key overrides for display, symbols are taken from Input::KEYMAP
	def self.process_key_text(keySymbol)
		return @keySYM_in_UI[keySymbol] if @keySYM_in_UI[keySymbol]
		keySymbol
	end
	
	#translate and overrides gamepad ID into text symbol
	def self.process_gamepad_text(padSymbol)
		return @padSYM_in_UI[padSymbol] if @padSYM_in_UI[padSymbol]
		"P#{padSymbol}"
	end


	def self.process_gamepad_textLong(padSymbol)
		return @padSYMlong_in_UI[padSymbol] if @padSYMlong_in_UI[padSymbol]
		return @padSYM_in_UI[padSymbol] if @padSYM_in_UI[padSymbol]
		process_gamepad_text(padSymbol)
	end
	
	
	def self.process_key_textLong(keySymbol)
		return @keySYMlong_in_UI[keySymbol] if @keySYMlong_in_UI[keySymbol]
		process_key_text(keySymbol)
	end
	
	#translater for ui
	def self.getKeyAndTranslateKeyBoardOnly(symbol)
		key = symbol
		keyValues = Input::SYM_KEYS[key]
		if InputUtils.reverse_key_map[keyValues[0]] != "---"
			keyResult = InputUtils.reverse_key_map[keyValues[0]]
		elsif InputUtils.reverse_key_map[keyValues[1]] != "---"
			keyResult = InputUtils.reverse_key_map[keyValues[1]]
		elsif InputUtils.reverse_key_map[keyValues[2]] != "---"
			keyResult = InputUtils.reverse_key_map[keyValues[2]]
		else
			return "---"
		end
		process_key_text(keyResult)
	end
	
	
	def self.getKeyAndTranslateLongKeyBoardOnly(symbol)
		key = symbol
		keyValues = Input::SYM_KEYS[key]
		if InputUtils.reverse_key_map[keyValues[0]] != "---"
			keyResult = InputUtils.reverse_key_map[keyValues[0]]
		elsif InputUtils.reverse_key_map[keyValues[1]] != "---"
			keyResult = InputUtils.reverse_key_map[keyValues[1]]
		elsif InputUtils.reverse_key_map[keyValues[2]] != "---"
			keyResult = InputUtils.reverse_key_map[keyValues[2]]
		else
			return "---"
		end
		process_key_textLong(keyResult)
	end
	
	def self.getKeyAndTranslate(symbol)
		if $data_GamePadUImode != "KB" 
		#if WolfPad.plugged_in?
			keyValue = WolfPad.keys[symbol]
			if !keyValue
				keyValue = "ERR"
			elsif keyValue < 0
				keyValue = "---"
			end
			process_gamepad_text(keyValue)
		else
			key = symbol
			keyValues = Input::SYM_KEYS[key]
			if InputUtils.reverse_key_map[keyValues[0]] != "---"
				keyResult = InputUtils.reverse_key_map[keyValues[0]]
			elsif InputUtils.reverse_key_map[keyValues[1]] != "---"
				keyResult = InputUtils.reverse_key_map[keyValues[1]]
			elsif InputUtils.reverse_key_map[keyValues[2]] != "---"
				keyResult = InputUtils.reverse_key_map[keyValues[2]]
			else
				return "---"
			end
			process_key_text(keyResult)
		end
	end
	
	def self.getKeyAndTranslateLong(symbol)
		if $data_GamePadUImode != "KB" 
		#if WolfPad.plugged_in? && !Mouse.usable?
			keyValue = WolfPad.keys[symbol]
			keyValue = "---" if keyValue < 0
			process_gamepad_textLong(keyValue)
		else
			key = symbol
			keyValues = Input::SYM_KEYS[key]
			if InputUtils.reverse_key_map[keyValues[0]] != "---"
				keyResult = InputUtils.reverse_key_map[keyValues[0]]
			elsif InputUtils.reverse_key_map[keyValues[1]] != "---"
				keyResult = InputUtils.reverse_key_map[keyValues[1]]
			elsif InputUtils.reverse_key_map[keyValues[2]] != "---"
				keyResult = InputUtils.reverse_key_map[keyValues[2]]
			else
				return "---"
			end
			process_key_textLong(keyResult)
		end
	end
	
	
	
	def self.load_input_settings
		load_keyboard_settings
		load_gamepad_settings
	end
	def self.load_keyboard_settings
		begin
			@keyList.each{|k|
				Input::SYM_KEYS[k[0]]=[]
				for i in 0..2
					val = $LonaINI["Keyboard"][k[0].to_s+"_#{i}"]
					if !val.nil? && val != 0 && val !="0" then
					#val = load_value("Keyboard", k[0].to_s+"_#{i}", nil)
					#if !val[0].nil? && val[1]>0 && val[0]!="0" then
						#Input::SYM_KEYS[k[0]] << Input::KEYMAP[val[0].to_sym]
						Input::SYM_KEYS[k[0]] << Input::KEYMAP[val.to_sym]
					else
						Input::SYM_KEYS[k[0]] << 0
					end
					Input::SYM_KEYS[k[0]][i] = 0 if Input::SYM_KEYS[k[0]][i].nil?
				end
			}
			@hiddenKeys.each{|k|
				Input::SYM_KEYS[k[0]]=[]
				for i in 0..2
					val = $LonaINI["Keyboard"][k[0].to_s+"_#{i}"]
					if !val.nil? && val != 0 && val !="0" then
					#val = load_value("Keyboard", k[0].to_s+"_#{i}", nil)
					#if !val[0].nil? && val[1]>0 && val[0]!="0" then
						#Input::SYM_KEYS[k[0]] << Input::KEYMAP[val[0].to_sym] 
						Input::SYM_KEYS[k[0]] << Input::KEYMAP[val.to_sym] 
					else
						Input::SYM_KEYS[k[0]] << 0
					end
					Input::SYM_KEYS[k[0]][i] = 0 if Input::SYM_KEYS[k[0]][i].nil?
				end
			}
		rescue
			load_default_keyboard_settings
		end
		#if any of 4 main keys to access keybindings are not assigned, reset to default
		load_default_keyboard_settings if !has_keymap(:B) || !has_keymap(:C) || !has_keymap(:UP) || !has_keymap(:DOWN)
	end
	def self.has_keymap(keySymbol)
		return (Input::SYM_KEYS[keySymbol][0] != nil && Input::SYM_KEYS[keySymbol][0] != 0) || (Input::SYM_KEYS[keySymbol][1] != nil && Input::SYM_KEYS[keySymbol][1] != 0) || (Input::SYM_KEYS[keySymbol][2] != nil && Input::SYM_KEYS[keySymbol][2] != 0)
	end
	def self.load_gamepad_settings
		begin
			@gamepadList.each{|k|
				val = $LonaINI["GamePad"][k[0].to_s]
				if !val.nil? && val != ""
				#if !val.nil? && val != 0 && val !="0" then
					#val = load_value("GamePad", k[0].to_s, nil)
					#if !val[0].nil? && val[1]>0 then
					#WolfPad.keys[k[0]] = val[0].to_i
					WolfPad.keys[k[0]] = val.to_i
				else
					Input::SYM_KEYS[k] << -1
				end
			}
		rescue
			load_default_gamepad_settings
		end
	end

	def self.load_default_settings
		load_default_keyboard_settings
		load_default_gamepad_settings
	end
	
	def self.load_default_keyboard_settings
		@keyList.each{|k|
			Input::SYM_KEYS[k[0]]=[]
			for i in 0...k[3].length
				Input::SYM_KEYS[k[0]] << Input::KEYMAP[k[3][i]]
				Input::SYM_KEYS[k[0]][i] = 0 if Input::SYM_KEYS[k[0]][i].nil? #some KEYMAP are missing so possible nil in array
			end
		}
		@hiddenKeys.each{|k|
			Input::SYM_KEYS[k[0]]=[]
			for i in 0...k[3].length
				Input::SYM_KEYS[k[0]] << Input::KEYMAP[k[3][i]]
				Input::SYM_KEYS[k[0]][i] = 0 if Input::SYM_KEYS[k[0]][i].nil? #some KEYMAP are missing so possible nil in array
			end
		}
		save_keyboard_settings
	end
	
	def self.load_default_gamepad_settings
		@gamepadList.each{|k|
			WolfPad.keys[k[0]] = k[3]
		}
		save_gamepad_settings
	end

	def self.save_input_settings
		save_keyboard_settings
		save_gamepad_settings
	end
	def self.save_keyboard_settings
		@keyList.each{|k|
			keys = Input::SYM_KEYS[k[0]]
			#for i in 0...keys.length #cause reset to default not works bug
			for i in 0...3
				#save_value("Keyboard", k[0].to_s+"_#{i}", reverse_key_map[keys[i]].to_s) if keys[i] != 0
				#save_value("Keyboard", k[0].to_s+"_#{i}", "0") if keys[i] == 0
				$LonaINI["Keyboard"][k[0].to_s+"_#{i}"] = reverse_key_map[keys[i]].to_s if keys[i] != 0
				$LonaINI["Keyboard"][k[0].to_s+"_#{i}"] = "0" if keys[i] == 0
			end
		}
		@hiddenKeys.each{|k|
			keys = Input::SYM_KEYS[k[0]]
			#for i in 0...keys.length #cause reset to default not works bug
			for i in 0...3
				#save_value("Keyboard", k[0].to_s+"_#{i}", reverse_key_map[keys[i]].to_s) if keys[i] !=0
				#save_value("Keyboard", k[0].to_s+"_#{i}", "0") if keys[i] == 0
				$LonaINI["Keyboard"][k[0].to_s+"_#{i}"] = reverse_key_map[keys[i]].to_s if keys[i] !=0
				$LonaINI["Keyboard"][k[0].to_s+"_#{i}"] = "0" if keys[i] == 0
			end
		}
		$LonaINI.save
	end
	def self.save_gamepad_settings
		@gamepadList.each{|k|
			#save_value("GamePad", k[0].to_s, WolfPad.keys[k[0]].to_s)
			$LonaINI["GamePad"][k[0].to_s] = WolfPad.keys[k[0]].to_s
		}
		$LonaINI.save
	end
end



#Use symbols instead of constants
module Input
#overrides hime's dir4 and dir8. They were copied by wolf's so those names.
	
	def self.vxa_dir4
		return @RecordedDIR if self.press?(:DOWN) && self.press?(:LEFT)
		return @RecordedDIR if self.press?(:DOWN) && self.press?(:RIGHT)
		return @RecordedDIR if self.press?(:UP) && self.press?(:LEFT)
		return @RecordedDIR if self.press?(:UP) && self.press?(:RIGHT)
		return 2 if self.press?(:DOWN)
		return 4 if self.press?(:LEFT)
		return 6 if self.press?(:RIGHT)
		return 8 if self.press?(:UP)
		return 0
	end
	#def self.pressed_vxa_dir4
	#	return true if [:UP,:DOWN,:LEFT,:RIGHT].any? {|key| self.trigger?(key)}
	#end
	
	def self.vxa_dir8
		down = self.press?(:DOWN)
		left = self.press?(:LEFT)
		return 1 if down and left
		right = self.press?(:RIGHT)
		return 3 if down and right
		up = self.press?(:UP)
		return 7 if up and left
		return 9 if up and right
		return 2 if down
		return 4 if left
		return 6 if right
		return 8 if up
		return 0
	end

	def self.numpad_dir4
		return 8 if self.press?(:D8)
		return 2 if self.press?(:D2)
		return 4 if self.press?(:D4)
		return 6 if self.press?(:D6)
		return 0
	end
	
	def self.skillKeyPressed?
		[:S1,:S2,:S3,:S4,:S5,:S6,:S7,:S8,:S9].any? {|key| self.press?(key)}
	end
	
		
	def self.getSkillKey
		return $game_player.hotkey_skill_normal if self.press?(:S1)
		return $game_player.hotkey_skill_heavy if self.press?(:S2)
		return $game_player.hotkey_skill_control if self.press?(:S3)
		return $game_player.skill_hotkey_0 if self.press?(:S4)
		return $game_player.skill_hotkey_1 if self.press?(:S5)
		return $game_player.skill_hotkey_2 if self.press?(:S6)
		return $game_player.skill_hotkey_3 if self.press?(:S7)
		return $game_player.skill_hotkey_4 if self.press?(:S8)
		return $game_player.hotkey_other if self.press?(:S9)
		nil
	end
		
	def self.PressedAnySkillKey?
		return true if self.press?(:S1)
		return true if self.press?(:S2)
		return true if self.press?(:S3)
		return true if self.press?(:S4)
		return true if self.press?(:S5)
		return true if self.press?(:S6)
		return true if self.press?(:S7)
		return true if self.press?(:S8)
		return true if self.press?(:S9)
		false
	end
	def self.checkHoldCancel?
		return [:C,:SHIFT,:ALT,:CTRL].any? {|key| self.trigger?(key)}
	end
	def self.checkHoldAllFunctionKeys?
		Input.press?(:CTRL) && Input.press?(:SHIFT) && Input.press?(:ALT)
	end
end

#Making gamepad keybindings accessable from outside.
module WolfPad
	class << self
		#keybinds
		attr_reader :keys
		#current gamepad button states
		attr_reader :holds
		
		#need ability to have key unassigned and game to not crash
		def key_holds(symbol, pad_index)
			return 0 if keyboard_key?(symbol)
			return 0 if @keys[symbol]<0
			@holds[pad_index, @keys[symbol]]
		end
	end
end


