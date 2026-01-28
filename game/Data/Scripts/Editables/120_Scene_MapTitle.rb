

$titleCreateActorReq = true

#==============================================================================
# ** Scene_Title
#==============================================================================

class Scene_Title < Scene_Base
	#--------------------------------------------------------------------------
	# * Start
	#--------------------------------------------------------------------------
	def start
		return SceneManager.goto(Scene_FirstTimeSetup) if $langFirstPick
		return SceneManager.goto(Scene_MapTitle) if $TEST
		SceneManager.goto(Scene_MapTitle) if DataManager.get_constant("LonaRPG","LaunchWarning",1) == 1
		SceneManager.goto(Scene_AdultContentWarning) if DataManager.get_constant("LonaRPG","LaunchWarning",1) != 1
	end
	#--------------------------------------------------------------------------
	# * Terminate
	#--------------------------------------------------------------------------
	def terminate
		SceneManager.snapshot_for_background
		Graphics.fadeout(Graphics.frame_rate)
	end
end



class Scene_AdultContentWarning < Scene_Base

	def start
		$loading_screen.dispose if $loading_screen
		super
		create_warning_posters
	end

	def create_warning_posters
		@warning_poster=Sprite.new(@viewport)
		@warning_poster.visible=true
		#if $lang == "CHT"
		#	@warning_poster.bitmap=Bitmap.new("Graphics/Pictures/WarningCHT_anti_iWIN.png") #從頭到尾才用這一次，不用Cache
		if FileTest.exist?("Graphics/Pictures/Warning#{$lang}.png")
			@warning_poster.bitmap=Bitmap.new("Graphics/Pictures/Warning#{$lang}.png") #從頭到尾才用這一次，不用Cache
		else
			@warning_poster.bitmap=Bitmap.new("Graphics/Pictures/WarningENG.png") #if no file, use eng.
		end
	end

	def perform_transition
		super
		Graphics.fadein(120)
	end

	def update
		super
		if Input.press?(:LETTER_Z) || WolfPad.trigger?(:Z_LINK)
			SndLib.ppl_Cheer
			SceneManager.goto(Scene_MapTitle)
		end
	end

	def terminate
		super
		DataManager.write_constant("LonaRPG","LaunchWarning",1)
		@warning_poster.dispose
	end
end #end class

#==============================================================================
# ** Scene_MapTitle
#==============================================================================
class Scene_MapTitle < Scene_Map
	attr_accessor   :character_name           # character graphic filename
	attr_accessor   :character_index          # character graphic index
	def start
		$loading_screen.dispose if $loading_screen
		if $titleCreateActorReq == true
			Cache.clear
			DataManager.create_game_objects
			DataManager.setup_new_game(false)
			$hudForceHide = true
			$balloonForceHide = true
			tmpPickID = Array.new
			tmpPickID << "TitleMarket"
			tmpPickID << "TitleMarketDed" 		if DataManager.get_rec_constant("RecEndLeaveNoer") == 1 && !$DEMO
			tmpPickID << "Title666"				if DataManager.get_rec_constant("RecEndLeaveNoer") == 1 && !$DEMO
			tmpPickID << "TitleHiveBattle"		if DataManager.get_rec_constant("RecEndLeaveNoer") == 1 && !$DEMO

			tmpPickID = tmpPickID.sample
			rnd_map_id = $data_tag_maps[tmpPickID].sample
			$game_map.setup(rnd_map_id)
			$game_player.moveto(59,55)
			$game_portraits.lprt.hide
			$game_portraits.rprt.hide
			$game_player.force_update = false
			$game_system.menu_disabled = true
			$titleCreateActorReq = false
			Graphics.frame_count = 0
		end
		super
		@hud.hide
		@menu = TitleMenu.new
	end

	def update
		super
		#return if Input.trigger?(:B)
		@menu.update
	end

	def terminate
		#SceneManager.snapshot_for_background
		super
		@menu.dispose
	end

end

#-------------------------------------------------------------------------------
# * Graphics Menu
#-------------------------------------------------------------------------------

class TitleMenu < OptionMenu

	#def initialize
	#	super(nil)
	#	create_foreground
	#	create_background
	#	tmpW = Graphics.width
	#	tmpH = Graphics.height
	#	self.bitmap = Bitmap.new(tmpW,tmpH)
	#	self.x = 0
	#	self.y = 57
	#	self.bitmap.font.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
	#	self.bitmap.font.outline = false
	#	self.bitmap.font.bold = true
	#	self.z = System_Settings::TITLE_COMMAND_WINDOW_Z
	#	self.bitmap.font.size = System_Settings::FONT_SIZE::SCENE_TITLE_OPTIONS
	#	#self.bitmap.font.name = ["Denk One"] if $lang == "ENG"
	#	@onBegin = true
	#	@optSymbol = {}
	#	@optNames = {}
	#	@optOptions = {}
	#	@optSettings = {}
	#	init_AutoSaveFile
	#	initialize_options
	#	draw_items
	#	if SceneManager.prevOptChoose != nil
	#		refresh_index(SceneManager.prevOptChoose)
	#	elsif DataManager.saveFileExistsRGSS?
	#		refresh_index(1) #CONTINUE
	#	end
	#	@onBegin = false
	#end

	def initialize
		create_foreground
		create_background
		super
		init_AutoSaveFile
		@onBegin = true
		if SceneManager.prevOptChoose != nil
			refresh_index(SceneManager.prevOptChoose)
		elsif DataManager.saveFileExistsRGSS?
			refresh_index(1) #CONTINUE
		end
		@onBegin = false
	end

	def initialize_basic_setting
		super
		self.bitmap.font.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
		self.bitmap.font.bold = true
		self.bitmap.font.outline = false
		self.bitmap.font.size = System_Settings::FONT_SIZE::SCENE_TITLE_OPTIONS
		@indexStartX = 64 #(0.1176 * Graphics.width).to_i #64
		@indexStartY =  (Graphics.height * 0.36).to_i
		@indexEachY = 21
		self.x = 0
		self.y = 0
		self.ox = 0
		self.oy = 0
	end

	def initialize_gui_notice
		@text_title = ""
		@text_warning = ""
	end
	def init_AutoSaveFile
		@autoSaveFile = nil
		fileE = DataManager.userDataPath_FileSaveAuto_E
		fileS = DataManager.userDataPath_FileSaveAuto_S
		if File.exist?(fileE) && !File.exist?(fileS)
			@autoSaveFile = "SavAutoE"
		elsif !File.exist?(fileE) && File.exist?(fileS)
			@autoSaveFile = "SavAutoS"
		elsif File.exist?(fileE) && File.exist?(fileS)
			mtime1 = File.mtime(fileE)
			mtime2 = File.mtime(fileS)
			if mtime1 > mtime2
				@autoSaveFile = "SavAutoE"
			elsif mtime1 < mtime2
				@autoSaveFile = "SavAutoS"
			else
				puts "#{fileE} and #{fileS} were modified at the same time."
			end
		end
		@autoSaveFile
	end
	####################################################### Option handler
	####################################################### Option handler
	####################################################### Option handler

	def mods_scan_folder
		modFolder = Dir.entries("ModScripts/_Mods/")
		modFolder.delete(".")
		modFolder.delete("..")
		modFolder
	end
	def initialize_options
		#buildOptions(:handlerCmdBossRush,		"G8魔王挑戰賽", 									"",[""])
		#buildOptions(:handlerGameRestart,		"DEV_"+$game_text["menu:system/reset"],	 			"",[""]) if $TEST
		buildOptions(:handlerCmdNewGame,		$game_text["menu:title/NEW_GAME"],				"",[""])
		buildOptions(:handlerCmdContinue,		$game_text["menu:title/CONTINUE"], 				"",[""])
		buildOptions(:handlerCmdTLoadDoom,		$game_text["menu:system/DoomCoreMode_Load0"],	"",[""]) if DataManager.saveFileExistsDOOM?
		buildOptions(:handlerCmdTLoadAuto,		$game_text["menu:system/autosave"],				"",[""]) if @autoSaveFile
		buildOptions(:handlerCmdOptions,		$game_text["menu:title/OPTIONS"], 				"",[""])
		buildOptions(:handlerCmdACHlist,		$game_text["menu:title/ACH"], 					"",[""])
		buildOptions(:handlerCmdCredit,			$game_text["menu:title/CREDITS"], 				"",[""])
		buildOptions(:handlerSupportMe,			$game_text["menu:title/SupportMe"], 			"",[""])
		buildOptions(:MODS,						"MODS",											"",[""]) if !mods_scan_folder.empty? && $mod_manager.mods.size > 0
		buildOptions(:handlerCmdExit,			$game_text["menu:title/EXIT_GAME"], 			"",[""])
	end

	def setOPT(setting, value)
		case setting
		when :handlerCmdNewGame;	handlerCmdNewGame(value)
		when :handlerCmdContinue;	handlerCmdContinue(value)
		when :handlerCmdBossRush;	handlerCmdBossRush(value)
		when :handlerCmdTLoadDoom;	handlerCmdTLoadDoom(value)
		when :handlerCmdTLoadAuto;	handlerCmdTLoadAuto(value)
		when :handlerCmdOptions;	handlerCmdOptions(value)
		when :handlerCmdACHlist;	handlerCmdACHlist(value)
		when :handlerCmdCredit;		handlerCmdCredit(value)
		when :MODS;					handlerCmdMods(value)
		when :handlerSupportMe;		handlerSupportMe(value)
		when :handlerGameRestart;	handlerGameRestart(value)
		when :handlerCmdExit;		handlerCmdExit(value)
		end
	end



	def handlerCmdMods(value)
		return if @onBegin == true
		SndLib.openChest
		@titleReqCacheClear = false
		SceneManager.goto(ModManagerScene)
	end

	def handlerGameRestart(value) #SAMPLE by ultrarev
		return if @onBegin == true
		begin
			if $TEST
				spawn("Game.exe console test")
			else
				spawn("Game.exe")
			end
		rescue => e
			msgbox $game_text["umm:manager:top_menu/restart_failed"]
			p e.message + "\n" + e.backtrace.join("\n")
		end
		exit 0
	end
	def handlerSupportMe(value)
		return if @onBegin == true
		SndLib.openChest
		Thread.new { system("start http://lonadev.idv.tw/")}
		sleep 0.9
	end
	def handlerCmdNewGame(value)
		return if @onBegin == true
		SndLib.closeChest
		$titleCreateActorReq = true
		if $TEST
			$game_map.setup($data_system.start_map_id)
			$game_player.moveto($data_system.start_x, $data_system.start_y)
			$game_map.interpreter.new_game_setup ##29_Functions_417
			$hudForceHide = false
			$balloonForceHide = false
		else
			$game_map.setup($data_tag_maps["TutorialOP"].sample)
			$game_player.moveto(0, 0)
			$hudForceHide = true
			$balloonForceHide = true
		end
		SceneManager.scene.fadeout_all
		SceneManager.prevOptChooseSet(nil)
		SceneManager.prevTitleOptChooseSet(nil)
		$game_map.interpreter.change_map_weather_cleaner
		$game_player.force_update = true
		$game_system.menu_disabled = false
		SceneManager.goto(Scene_Map)
	end
	def handlerCmdBossRush(value)
		return if @onBegin == true
		SndLib.closeChest
		$titleCreateActorReq = true
		#$TEST = false
		$game_map.setup($data_tag_maps["BossRushPicker"].sample)
		$game_player.moveto(0, 0)
		$game_map.interpreter.new_game_setup ##29_Functions_417
		$hudForceHide = false
		$balloonForceHide = false
		SceneManager.scene.fadeout_all
		SceneManager.prevOptChooseSet(nil)
		SceneManager.prevTitleOptChooseSet(nil)
		$game_map.interpreter.change_map_weather_cleaner
		$game_player.force_update = true
		$game_system.menu_disabled = false
		SceneManager.goto(Scene_Map)
	end

	def handlerCmdContinue(value)
		return if @onBegin == true
		SndLib.openChest
		@titleReqCacheClear = false
		$game_map.interpreter.chcg_background_color_off
		SceneManager.goto(Scene_Load)
	end

	def handlerCmdTLoadDoom(value)
		return if @onBegin == true
		SndLib.openChest
		$game_map.interpreter.chcg_background_color_off
		SceneManager.scene.gotoLoadCustomScene("SavDoomMode")
	end
	def handlerCmdTLoadAuto(value)
		return if @onBegin == true
		$game_map.interpreter.chcg_background_color_off
		SceneManager.scene.gotoLoadCustomScene(@autoSaveFile)
	end

	def handlerCmdOptions(value)
		return if @onBegin == true
		SndLib.openChest
		@titleReqCacheClear = false
		SceneManager.goto(Scene_TitleOptions)
	end

	def handlerCmdCredit(value)
		return if @onBegin == true
		SndLib.closeChest
		$titleCreateActorReq = true
		$game_player.force_update = true
		$game_map.interpreter.chcg_background_color_off
		SceneManager.scene.fadeout_all
		SceneManager.goto(Scene_Credits)
	end

	def handlerCmdACHlist(value)
		return if @onBegin == true
		SndLib.openChest
		@titleReqCacheClear = false
		SceneManager.goto(Scene_ACHlistMenu)
	end

	def handlerCmdExit(value)
		return if @onBegin == true
		SndLib.ppl_Boo
		SceneManager.scene.fadeout_all
		SceneManager.exit
	end
	####################################################### END
	def update
		return SndLib.sys_buzzer if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK)
		@foreground_spriteJoy.opacity = WolfPad.plugged_in? ? 255 : 0
		update_crypto_wallets_Y
		return refresh_index(@index + 1) if Input.repeat?(:DOWN)
		return refresh_index(@index - 1) if Input.repeat?(:UP)
		return refresh_index(@index + 1) if Input.repeat?(:R)
		return refresh_index(@index - 1) if Input.repeat?(:L)
		return runOption if Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)
		mouse_input_check
	end

	def next_option #do nothing in title screen
		runOption
	end
	def previous_option #do nothing in title screen
		runOption
	end
	def dispose_foreground
		@foreground_sprite.bitmap.dispose
		@foreground_sprite.dispose
		@foreground_spriteJoy.dispose
		@foreground_crypto_wallets.dispose
	end
	def dispose_background
		@sprite1.bitmap.dispose
		@sprite1.dispose
		@sprite2.bitmap.dispose
		@sprite2.dispose
	end
	def dispose
		SceneManager.snapshot_for_background
		dispose_background
		dispose_foreground
		super
	end
	def refresh_index(i)
		tmpIndex = @index
		size = @items.size
		return if size == 0

		warp = $LonaINI["GameOptions"]["ui_opt_warping"] == 1 && !($LonaINI["GameOptions"]["ui_opt_warping_mouse_off"] == 1 && Mouse.enable?)
		@index = if warp
		(i % size)
		else
			[[i, 0].max, size - 1].min
		end

		SndLib.play_cursor if tmpIndex != @index && !@onBegin

		if @index < @top_index
			@top_index = @index
		elsif @index > @top_index + @visible_lines
			@top_index = @index - @visible_lines
		end

		SceneManager.prevOptChooseSet(@index)
		redraw_visible_items
	end

	def draw_item(i, active = false, displayed_index = nil)
		displayed_index ||= i - @top_index
		return if displayed_index < 0 || displayed_index > @visible_lines  # skip invisible

		y = @indexStartY + displayed_index * @indexEachY
		c = active ? 255 : 192
		self.bitmap.font.color.set(c, c, c)

		activeX = (active ? 5 : 0)
		# Draw option name
		self.bitmap.draw_text(@indexStartX+activeX, y, @indexOptWitdh, @indexEachY, @optNames[@items[i]], 0)
		item_mouse_rect(i, y,active)
	end

	def item_mouse_rect(i, y,active)
		mouse_rect_y = y#-@indexEachY/2 #(y + @indexEachY / 2)
		@mouse_all_rectsL ||= []
		@mouse_all_rectsR ||= []
		textWitdh = self.bitmap.text_size(@optNames[@items[i]]).width
		@mouse_all_rectsL[i] = Rect.new(@indexStartX,	mouse_rect_y+3, textWitdh, @indexEachY)
		@mouse_all_rectsR[i] = Rect.new(@indexStartX,	mouse_rect_y+3, textWitdh, @indexEachY)
	end
	def draw_resetWarning
		@warning.dispose if @warning
		@warning = Sprite.new
	end
	def create_background
		@sprite1 = Sprite.new
		@sprite2 = Sprite.new
		bmp1 = Cache.load_bitmap("Graphics/System/TitleScreen/","titleOptBg")
		bmp2 = Cache.load_bitmap("Graphics/System/TitleScreen/","Title")
		@sprite1.bitmap = bmp1
		@sprite2.bitmap = bmp2
		@sprite1.z = System_Settings::TITLE_BACKGROUND1
		@sprite2.z = System_Settings::TITLE_BACKGROUND2

		# Calculate zoom with a tiny epsilon to cover rounding error
		zoom_x = Graphics.width.to_f  / bmp1.width  + 0.002
		zoom_y = Graphics.height.to_f / bmp1.height + 0.002

		[@sprite1, @sprite2].each do |s|
			s.zoom_x = zoom_x
			s.zoom_y = zoom_y
			s.x = ((Graphics.width  - s.bitmap.width  * s.zoom_x) / 2).to_i
			s.y = ((Graphics.height - s.bitmap.height * s.zoom_y) / 2).to_i
		end
		@sprite2.x = 0
		@sprite2.y = (Graphics.height * 0.02778).to_i #10
	end
	def center_sprite(sprite)
		sprite.ox = sprite.bitmap.width / 2
		sprite.oy = sprite.bitmap.height / 2
		sprite.x = Graphics.width / 2
		sprite.y = Graphics.height / 2
	end

	#def create_foreground
	#	@foreground_sprite = Sprite.new
	#	@foreground_spriteJoy = Sprite.new
	#	@foreground_sprite.bitmap = Bitmap.new(Graphics.width, Graphics.height)
	#	@foreground_spriteJoy.bitmap = Bitmap.new(Graphics.width, Graphics.height)
	#	@foreground_sprite.z = System_Settings::TITLE_FOREGROUND_Z
	#	@foreground_spriteJoy.z = System_Settings::TITLE_FOREGROUND_Z
	#
	#	draw_game_title# if $data_system.opt_draw_title
	#	draw_crypto_wallets
	#	draw_joystick_mode
	#end
	def create_foreground
		# Dispose old sprites if re-created
		@foreground_sprite.dispose if @foreground_sprite && !@foreground_sprite.disposed?
		@foreground_spriteJoy.dispose if @foreground_spriteJoy && !@foreground_spriteJoy.disposed?

		# Create sprites sized to screen
		@foreground_sprite    = Sprite.new
		@foreground_spriteJoy = Sprite.new

		@foreground_sprite.bitmap    = Bitmap.new(Graphics.width, Graphics.height)
		@foreground_spriteJoy.bitmap = Bitmap.new(Graphics.width, Graphics.height)

		@foreground_sprite.z    = System_Settings::TITLE_FOREGROUND_Z
		@foreground_spriteJoy.z = System_Settings::TITLE_FOREGROUND_Z

		# Position them at top-left (fill entire screen)
		@foreground_sprite.x = 0
		@foreground_sprite.y = 0
		@foreground_spriteJoy.x = 0
		@foreground_spriteJoy.y = 0

		draw_game_title   # if $data_system.opt_draw_title
		draw_crypto_wallets
		draw_joystick_mode
	end

	def draw_crypto_wallets
		@foreground_crypto_wallets = Sprite.new
		@foreground_crypto_wallets.z = System_Settings::TITLE_FOREGROUND_Z
		@foreground_crypto_wallets.bitmap = Bitmap.new("Graphics/System/CryptoWallet.png")

		font_size = System_Settings::FONT_SIZE::SCENE_TITLE_VER_INFO
		text_height = font_size + 4
		margin = 1.5
		bottom_offset = text_height * 1 + margin * 3

		@foreground_crypto_wallets_zoom = 1.0
		@foreground_crypto_wallets.zoom_x = @foreground_crypto_wallets_zoom
		@foreground_crypto_wallets.zoom_y = @foreground_crypto_wallets_zoom

		bmp = @foreground_crypto_wallets.bitmap
		@foreground_crypto_wallets.x = Graphics.width - (bmp.width * @foreground_crypto_wallets_zoom).to_i - 10
		@foreground_crypto_wallets.y = Graphics.height - (bmp.height * @foreground_crypto_wallets_zoom).to_i - bottom_offset
	end
	def update_crypto_wallets_Y
		return if !@foreground_crypto_wallets
		font_size = System_Settings::FONT_SIZE::SCENE_TITLE_VER_INFO
		text_height = font_size + 4
		margin = 4
		@items[@index] == :handlerSupportMe ? @foreground_crypto_wallets_zoom = 2.0 : @foreground_crypto_wallets_zoom = 1.0
		@foreground_crypto_wallets.zoom_x = @foreground_crypto_wallets_zoom
		@foreground_crypto_wallets.zoom_y = @foreground_crypto_wallets_zoom

		bmp = @foreground_crypto_wallets.bitmap
		if WolfPad.plugged_in?
			bottom_offset = text_height * 2 + margin * 3
		else
			bottom_offset = text_height * 1 + margin * 3
		end

		@foreground_crypto_wallets.x = Graphics.width - (bmp.width * @foreground_crypto_wallets_zoom).to_i - 10
		@foreground_crypto_wallets.y = Graphics.height - (bmp.height * @foreground_crypto_wallets_zoom).to_i - bottom_offset
	end
	def draw_game_title
		font_size = System_Settings::FONT_SIZE::SCENE_TITLE_VER_INFO
		@foreground_sprite.bitmap.font.size = font_size
		@foreground_sprite.bitmap.font.outline = false

		# Position: near bottom, 30 pixels from bottom edge
		text_height = font_size + 4
		y = Graphics.height - text_height - 10

		rect = Rect.new(0, y, Graphics.width - 10, text_height)
		@foreground_sprite.bitmap.draw_text(rect, " " + DataManager.export_full_ver_info, 2)
	end

	def draw_joystick_mode
		font_size = System_Settings::FONT_SIZE::SCENE_TITLE_VER_INFO
		@foreground_spriteJoy.bitmap.font.size = font_size
		@foreground_spriteJoy.bitmap.font.outline = false

		# Slightly above game title text
		text_height = font_size + 4
		y = Graphics.height - (text_height * 2) - 12

		rect = Rect.new(0, y, Graphics.width - 10, text_height)
		@foreground_spriteJoy.bitmap.draw_text(rect, $game_text["menu:title/GamepadMode"], 2)
		@foreground_spriteJoy.opacity = 0
	end

	def runOption
		options = @optOptions[@items[@index]]
		current = @optSettings[@items[@index]]
		optSYM= @optSymbol[@items[@index]]
		oi = 0
		for i in 0...options.size
			oi = i if options[i] == current
		end
		oi = (oi + 1) % options.size
		@optSettings[@items[@index]] = options[oi]
		clear_item(@index)
		draw_item(@index, true)
		setOPT(optSYM,options[oi])
	end



end #end class


class NewGameSewer < Scene_Base
	def start
		super
		DataManager.setup_new_game(tmp_tomap=true,tagName="NoerSewer")
		SceneManager.goto(Scene_Map)
		$game_map.interpreter.new_game_setup ##29_Functions_417
	end
end

class NewGameTutorialOP < Scene_Base
	def start
		super
		DataManager.setup_new_game(tmp_tomap=true,tagName="TutorialOP")
		SceneManager.goto(Scene_Map)
	end
end

class Empty < Scene_Base
	def start
		super
	end
end

########################################### OLD MOUSE INPUT BACKUP
#class TitleMenu < Sprite
#	#overwrite
#	def draw_item(i, active = false)
#		c = (active ? 255 : 192)
#		activeX = (active ? 5 : 0)
#		textRectX = 58
#		textRectY = 70
#		textWitdh = self.bitmap.text_size(@optNames[@items[i]]).width
#		self.bitmap.font.color.set(c,c,c)
#		self.bitmap.draw_text(textRectX+activeX,textRectY+i*20,416,32,@optNames[@items[i]],0)
#		#p @optNames[@items[i]]
#		#p self.bitmap.text_size(@optNames[@items[i]]).width
#		@mouse_all_rects = Array.new if !@mouse_all_rects
#		@mouse_all_rects[i] = Rect.new(textRectX,(textRectY-3)*2+i*20,textWitdh,32)
#	end
#
#	def mouse_input_check
#		return Mouse.ForceIdle if Input.MouseWheelForceIdle?
#		return if !Mouse.enable?
#		#return SndLib.sys_buzzer if Input.trigger?(:MZ_LINK) && !Mouse.within?(@mouse_all_rects[@index])
#		return SndLib.sys_buzzer if Input.trigger?(:MX_LINK)
#		return if !Input.trigger?(:MZ_LINK)
#		tmpIndex = @index
#		tmpIndexWrite = @index
#		@mouse_all_rects.length.times{|i|
#			next unless Mouse.within?(@mouse_all_rects[i])
#			tmpIndexWrite = i
#			#p @mouse_all_rects[i]
#		}
#		if tmpIndexWrite && tmpIndexWrite != tmpIndex
#			refresh_index(tmpIndexWrite) if tmpIndexWrite
#			SndLib.play_cursor
#		elsif Input.trigger?(:MZ_LINK) && !Mouse.within?(@mouse_all_rects[@index])
#			return SndLib.sys_buzzer
#		elsif Input.trigger?(:MZ_LINK)
#			runOption
#		end
#	end
#end
