class Scene_FirstTimeSetup < Scene_Base

	def start
		super
		#$loading_screen.dispose if $loading_screen
		$loading_screen.hide if $loading_screen
		@menu = FirstTimeSetupMenu.new
		@wait_count = 0
		@doneSetting = false
		Graphics.fadein(60)

	end

	def update
		super
		refresh_menu
	end

	def refresh_menu
		#if (Input.trigger?(:B) || Input.trigger?(:C) || Input.trigger?(:Z_LINK) || Input.trigger?(:X_LINK)) && !@doneSetting

		if @menu.clickedDone && !@doneSetting
			@doneSetting = true
			SndLib.closeChest
			Graphics.fadeout(30)
		elsif @doneSetting
			@wait_count += 1
			if @wait_count >= 35
				@menu.dispose if @wait_count >= 30
				Graphics.fadein(5)
				$loading_screen.show if $loading_screen
				$langFirstPick = nil
				DataManager.load_core_data
				return SceneManager.goto(Scene_Title)
			end
		else
			@menu.update
		end
	end
end

#-------------------------------------------------------------------------------
# * Graphics Menu
#-------------------------------------------------------------------------------

class FirstTimeSetupMenu < OptionMenu
	def initialize
		@clickedDone = false
		@prevLang = $lang
		super
		drawHint
		@onBegin = false
	end

	def initialize_options
		buildOptions(:cmdLANG,				$game_text["menu:system/language"], $lang,DataManager.createLangArray)
		buildOptions(:cmdLANG,				$game_text["menu:system/language"], $lang,DataManager.createLangArray)
		buildOptions(:cmdLANG,				$game_text["menu:system/language"], $lang,DataManager.createLangArray)
		buildOptions(:cmdScrRatio,			$game_text["menu:system/screen_scale"],Graphics.getScaleTextHalf,[Graphics.getScaleTextHalf])
		buildOptions(:cmdGamePadUImode,		$game_text["menu:system/GamePadUImode"], DataManager.get_text_constant("LonaRPG","GamePadUImode",16), ["PS","XB","ND","KB"]) #if WolfPad.plugged_in?
		buildOptions(:cmdMouse,				$game_text["menu:system/Mouse"],DataManager.get_constant("LonaRPG","MouseEnable",1) == 1 ? "ON" : "OFF" ,["ON","OFF"])
		buildOptions(:cmdDone,				$game_text["menu:system/language_press_z"],"DONE",["DONE"])
	end
	def clickedDone
		@clickedDone
	end
	def setOPT(setting, value)
		case setting
			when :cmdScrRatio; scrRatio_opt_handler(value)
			when :cmdLANG;  lang_opt_handler(value)
			when :cmdGamePadUImode; padUImode_opt_handler(value)
			when :cmdMouse; mouse_opt_handler(value)
			when :cmdDone; done_opt_handler(value)
		end
	end

	def scrRatio_opt_handler(value)
		return if @onBegin == true
		if Input.repeat?(:LEFT)
			Graphics.toggle_ratio(-1)
		elsif  Input.repeat?(:RIGHT)
			Graphics.toggle_ratio(1)
		else
			Graphics.toggle_ratio
		end
		clear_item(@index)
		@optSettings[@items[@index]] = Graphics.getScaleTextHalf
		draw_item(@index, true)

	end
	def lang_opt_handler(value)
		return if @onBegin == true
		$lang  = value
		DataManager.write_lang_constant
		DataManager.update_Lang
		#System_Settings::MESSAGE_WINDOW_FONT_NAME = [DataManager.get_font_name]
		 if @prevLang != $lang
			@prevLang = "CHANGED"
			draw_resetWarning if @prevLang
		end
	end
	def done_opt_handler(value)
		return if @onBegin == true
		@clickedDone = true
	end

	def padUImode_opt_handler(value)
		return if @onBegin == true
		DataManager.write_constant("LonaRPG","GamePadUImode",value)
		$data_GamePadUImode = value
		InputUtils.update_padSYM_in_UI
		SndLib.bgm_scene_on
		@hint.bitmap.dispose
		drawHint
	end

	def mouse_opt_handler(value)
		return if @onBegin == true
		if value == "ON"
			Mouse.enable
			tmpSet = 1

		else
			Mouse.disable
			tmpSet = 0
		end
		DataManager.write_constant("LonaRPG","MouseEnable",tmpSet)
	end

	def dispose
		@hint.bitmap.dispose
		super
	end


	def initialize_gui_notice
		@text_title = "FIRST TIME SETUP"
		@text_warning = "NO USE"
	end
	def drawHint
		#tmpDef_Y=150
		tmpDef_X=50
		@hint = Sprite.new
		@hint.y = @indexStartY+(@items.length+1)*@indexEachY #Graphics.height-tmpDef_Y
		@hint.z = self.z+2
		@hint.bitmap = Bitmap.new(Graphics.width,60)
		@hint.bitmap.font.size = 24
		#@hint.bitmap.fill_rect(@hint.bitmap.rect,Color.new(100,100,100,100)) #######################
		tmpKey1 = "#{InputUtils.getKeyAndTranslate(:LEFT)} / #{InputUtils.getKeyAndTranslate(:RIGHT)}"
		@hint.bitmap.font.color.set(255,255,255,125)
		@hint.bitmap.font.size = 24
		@hint.bitmap.draw_text(112,1,Graphics.width,@indexEachY,tmpKey1,0)
		@hint.bitmap.font.size = 18
		@hint.bitmap.draw_text(112,16,Graphics.width,@indexEachY,"Prev / Next",0)
		#if DataManager.get_text_constant("LonaRPG","GamePadUImode",16) != "KB"# && WolfPad.plugged_in?
		#	tmpKey2 = "#{InputUtils.getKeyAndTranslate(:Z_LINK)} / #{InputUtils.getKeyAndTranslate(:X_LINK)}"
		#else
		#	tmpKey2 = "Z / X"
		#end
		#@hint.bitmap.font.size = 24
		#@hint.bitmap.draw_text(112-25,1,Graphics.width-250,32,tmpKey2,2)
		#@hint.bitmap.font.size = 18
		#@hint.bitmap.draw_text(112-25,16,Graphics.width-250,32,"Set!",2)
		#@hint.bitmap.font.size = 24
		@hint.bitmap.font.color.set(255,255,255,255)
	end

	def draw_resetWarning
		@warning.dispose if @warning
		@warning = Sprite.new
		@warning.z = self.z+1
		@warning.y = @yFix
		@warning.x = -40
		@warning.bitmap = Bitmap.new(Graphics.width,60)
		@warning.bitmap.font.size = 20
		@warning.bitmap.font.bold = false
		@warning.bitmap.font.outline = false
		@warning.bitmap.draw_text(0,15,580,@indexEachY,$game_text["DataItem:ToNoerRelay/item_name"],2)
	end

end
