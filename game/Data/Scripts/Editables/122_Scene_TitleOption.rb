class Scene_TitleOptions < Scene_Map

	def start
		super
		@background_sprite = Sprite.new
		@background_sprite.bitmap = Cache.load_bitmap("Graphics/System/TitleScreen/","titleOptBg")
		@background_sprite.z = System_Settings::TITLE_COMMAND_WINDOW_Z-1
		update_BG_pic_scale
		@menu = TitleOptionMenu.new
	end
	def update_BG_pic_scale
		# Calculate zoom with a tiny epsilon to cover rounding error
		@saved_Graphics_width = Graphics.width
		@saved_Graphics_height = Graphics.height
		zoom_x = Graphics.width.to_f  / @background_sprite.bitmap.width  + 0.002
		zoom_y = Graphics.height.to_f / @background_sprite.bitmap.height + 0.002
		@background_sprite.zoom_x = zoom_x
		@background_sprite.zoom_y = zoom_y
		@background_sprite.x = ((Graphics.width  - @background_sprite.bitmap.width  * @background_sprite.zoom_x) / 2).to_i
		@background_sprite.y = ((Graphics.height - @background_sprite.bitmap.height * @background_sprite.zoom_y) / 2).to_i
	end
	def update_map_background_color
		@spriteset.create_map_background
		#tmpMapBGSave = $game_map.interpreter.map_background_color_export
		#$game_map.interpreter.map_background_color_off
		#$game_map.interpreter.map_background_color(*tmpMapBGSave)
	end
	def update_screen_scale
		update_BG_pic_scale
		update_map_background_color
	end
	def update
		super
		update_screen_scale if Graphics.width != @saved_Graphics_width || Graphics.height != @saved_Graphics_height
		refresh_menu
	end

	def terminate
		super
		@background_sprite.dispose
		@menu.dispose
	end



	def dispose_background
		@background_sprite.dispose
	end

	def refresh_menu
		if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK) || Input.trigger?(:MX_LINK)
			SndLib.sys_cancel
			return SceneManager.goto(Scene_MapTitle)
		end
		@menu.update
	end
end

#-------------------------------------------------------------------------------
# * Graphics Menu
#-------------------------------------------------------------------------------

class TitleOptionMenu < OptionMenu
	def initialize
		init_map_background_color_items
		super
		if SceneManager.prevTitleOptChoose != nil
			refresh_index(SceneManager.prevTitleOptChoose)
		end
	end

	## this is a todo for mapBG color auto file name
	def init_map_background_color_items
		result = DataManager.get_map_background_color_result
		# Array with file names only
		file_names = result.keys
		@mapBGcolor_hash = result
		@mapBGcolor_name = file_names
	end
	def initialize_options
		buildOptions(:cmdFullScr,      $game_text["menu:system/full_screen"],Graphics.fullscreen? ? "ON" : "OFF" ,["ON","OFF"])
		buildOptions(:cmdScrSize,      $game_text["menu:system/screen_size"],Graphics.getScaleTextHalf,[Graphics.getScaleTextHalf])
		buildOptions(:cmdScreenScale,  $game_text["menu:system/screen_scale"]+"(Alpha)", $LonaINI["Screen"]["ScreenScale"],["16:9","16:10","4:3"]) if $TEST
		buildOptions(:cmdSNDvol,       $game_text["menu:system/SNDvol"], $data_SNDvol, (0..100).step(5).to_a)
		buildOptions(:cmdBGMvol,       $game_text["menu:system/BGMvol"], $data_BGMvol, (0..100).step(5).to_a)
		#buildOptions(:cmdMapBgMode,    $game_text["menu:system/MapBgMode"], DataManager.get_text_constant("LonaRPG","MapBgMode",128), @mapBGcolor_name)
		buildOptions(:cmdMapBgMode,    $game_text["menu:system/MapBgMode"], $LonaINI["LonaRPG"]["MapBgMode"], @mapBGcolor_name)
		buildOptions(:cmdGamePadUImode,$game_text["menu:system/GamePadUImode"], DataManager.get_text_constant("LonaRPG","GamePadUImode",16), ["PS","XB","ND","KB"]) #if WolfPad.plugged_in?
		buildOptions(:cmdLANG,         $game_text["menu:system/language"], $lang,DataManager.createLangArray)
		buildOptions(:cmdMouse,        $game_text["menu:system/Mouse"], $LonaINI["LonaRPG"]["MouseEnable"] == 1 ? "ON" : "OFF" ,["ON","OFF"])
		#buildOptions(:cmdPrtAutoFocus, "PrtFocusMode(DEV)",	$data_PrtFocusMode,[0,1,2])
		buildOptions(:cmdKeyBinding,   $game_text["menu:system/KEYbind"], "",[""])

		buildOptions(:block1,   "", "",[""])
		buildOptions(:oev_OutDress_always_parallel,	"oev_OutDress_always_parallel", $LonaINI["GameOptions"]["oev_OutDress_always_parallel"] == 1 ? "ON" : "OFF",["ON","OFF"])
		buildOptions(:ui_opt_warping,			"ui_opt_warping", $LonaINI["GameOptions"]["ui_opt_warping"] == 1 ? "ON" : "OFF",["ON","OFF"])
		buildOptions(:ui_opt_warping_mouse_off,	"ui_opt_warping_mouse_off", $LonaINI["GameOptions"]["ui_opt_warping_mouse_off"] == 1 ? "ON" : "OFF",["ON","OFF"])


		#todo, started with block will be banned in option
		buildOptions(:block3,   "", "",[""])
		buildOptions(:block4,   "CACHE", "",[""])
		buildOptions(:PrecacheLonaPoseBitmaps,	"PrecacheLonaPoseBitmaps", $LonaINI["Cache"]["PrecacheLonaPoseBitmaps"] == 1 ? "ON" : "OFF",["ON","OFF"])
		buildOptions(:PrecacheLonaChcgBitmaps,	"PrecacheLonaChcgBitmaps", $LonaINI["Cache"]["PrecacheLonaChcgBitmaps"] == 1 ? "ON" : "OFF",["ON","OFF"])
		buildOptions(:PrecacheLonaAllBitmaps,	"PrecacheLonaAllBitmaps", $LonaINI["Cache"]["PrecacheLonaAllBitmaps"] == 1 ? "ON" : "OFF",["ON","OFF"])
		buildOptions(:PrecacheNpcPrtBitmaps,	"PrecacheNpcPrtBitmaps", $LonaINI["Cache"]["PrecacheNpcPrtBitmaps"] == 1 ? "ON" : "OFF",["ON","OFF"])
		buildOptions(:DisablePartsClear,		"DisablePartsClear", $LonaINI["Cache"]["DisablePartsClear"] == 1 ? "ON" : "OFF",["ON","OFF"])
		buildOptions(:DisableChsMaterialClear,	"DisableChsMaterialClear", $LonaINI["Cache"]["DisableChsMaterialClear"] == 1 ? "ON" : "OFF",["ON","OFF"])
		buildOptions(:DisableChsDataCacheClear,	"DisableChsDataCacheClear", $LonaINI["Cache"]["DisableChsDataCacheClear"] == 1 ? "ON" : "OFF",["ON","OFF"])



		#buildOptions(:PrecacheLonaPoseBitmaps,	"PrecacheLonaPoseBitmaps", DataManager.get_constant("Cache","PrecacheLonaPoseBitmaps",1) == 1 ? "ON" : "OFF",["ON","OFF"])
		#buildOptions(:PrecacheLonaChcgBitmaps,	"PrecacheLonaChcgBitmaps", DataManager.get_constant("Cache","PrecacheLonaChcgBitmaps",1) == 1 ? "ON" : "OFF",["ON","OFF"])
		#buildOptions(:PrecacheLonaAllBitmaps,	"PrecacheLonaAllBitmaps", DataManager.get_constant("Cache","PrecacheLonaAllBitmaps",1) == 1 ? "ON" : "OFF",["ON","OFF"])
		#buildOptions(:PrecacheNpcPrtBitmaps,	"PrecacheNpcPrtBitmaps", DataManager.get_constant("Cache","PrecacheNpcPrtBitmaps",1) == 1 ? "ON" : "OFF",["ON","OFF"])
		#buildOptions(:DisablePartsClear,		"DisablePartsClear", DataManager.get_constant("Cache","DisablePartsClear",1) == 1 ? "ON" : "OFF",["ON","OFF"])
		#buildOptions(:DisableChsMaterialClear,	"DisableChsMaterialClear", DataManager.get_constant("Cache","DisableChsMaterialClear",1) == 1 ? "ON" : "OFF",["ON","OFF"])
		#buildOptions(:DisableChsDataCacheClear,	"DisableChsDataCacheClear", DataManager.get_constant("Cache","DisableChsDataCacheClear",1) == 1 ? "ON" : "OFF",["ON","OFF"])

		#DEBUG
		if $TEST
			buildOptions(:block5,   "", "",[""])
			buildOptions(:block6,   "DEBUG", "",[""])
			buildOptions(:CHK_POSE_BITMAP,   "CHK_POSE_BITMAP", "",[""])
			buildOptions(:CHK_NAME_ORDER,   "CHK_NAME_ORDER", "",[""])
		end
	end

	def initialize_gui_notice
		@text_title = $game_text["menu:title/OPTIONS"]
		@text_warning = $game_text["menu:system/language_change"]
	end
	def setOPT(setting, value)
		case setting
		when :cmdFullScr; fullScr_opt_handler(value)
		when :cmdScrSize; scrSize_opt_handler(value)
		when :cmdScreenScale; scrScale_opt_handler(value)
		when :cmdPrtAutoFocus; prt_focus_handler(value)
		when :cmdBGMvol; bgm_opt_handler(value)
		when :cmdSNDvol; snd_opt_handler(value)
		when :cmdMapBgMode; mapBg_opt_handler(value)
		when :cmdGamePadUImode; padUImode_opt_handler(value)
		when :cmdKeyBinding; keyBinging_opt_handler(value)
		when :cmdLANG; lang_opt_handler(value)
		when :cmdMouse; mouse_opt_handler(value)
		when :oev_OutDress_always_parallel; oev_OutDress_always_parallel_opt_handler(value)
		when :ui_opt_warping; ui_opt_warping_opt_handler(value)
		when :ui_opt_warping_mouse_off; ui_opt_warping_mouse_off_opt_handler(value)
		when :PrecacheLonaPoseBitmaps; cacheLonaPoseBitmaps_opt_handler(value)
		when :PrecacheLonaChcgBitmaps; cacheLonaChcgBitmaps_opt_handler(value)
		when :PrecacheLonaAllBitmaps; cacheLonaAllBitmaps_opt_handler(value)
		when :PrecacheNpcPrtBitmaps; cacheNpcPrtBitmaps_opt_handler(value)
		when :DisablePartsClear; chsPartsClear_opt_handler(value)
		when :DisableChsMaterialClear; chsMaterialClear_opt_handler(value)
		when :DisableChsDataCacheClear; chsDataCacheClear_opt_handler(value)
		when :CHK_POSE_BITMAP; chk_pose_bitmap_handler(value)
		when :CHK_NAME_ORDER; chk_name_order_handler(value)
		end
	end

	def initialize_lines_setting
		super
		if SceneManager.prevTitleOpt_TopIndex
			@top_index = SceneManager.prevTitleOpt_TopIndex
		end
	end



	def chk_pose_bitmap_handler(value)
		return if @onBegin
		Cache.precache_lona_prt_bitmap("all", debug=true)
		@text_warning = "All scanned"
		draw_resetWarning
		initialize_gui_notice
	end

	def chk_name_order_handler(_value = nil)
		return if @onBegin
		DataManager.dbg_name_order_scan
		@text_warning = "_NameOrderScanLog.txt Saved"
		draw_resetWarning
		initialize_gui_notice
	end



	def mouse_opt_handler(value)
		return if @onBegin
		enabled = (value == "ON")
		enabled ? Mouse.enable : Mouse.disable
		$LonaINI["LonaRPG"]["MouseEnable"] = enabled ? 1 : 0
		$LonaINI.save
	end


	def oev_OutDress_always_parallel_opt_handler(value)
		return if @onBegin
		enabled = (value == "ON")
		$LonaINI["GameOptions"]["oev_OutDress_always_parallel"] = enabled ? 1 : 0
		$LonaINI.save
	end


	def ui_opt_warping_opt_handler(value)
		return if @onBegin
		enabled = (value == "ON")
		$LonaINI["GameOptions"]["ui_opt_warping"] = enabled ? 1 : 0
		$LonaINI.save
	end

	def ui_opt_warping_mouse_off_opt_handler(value)
		return if @onBegin
		enabled = (value == "ON")
		$LonaINI["GameOptions"]["ui_opt_warping_mouse_off"] = enabled ? 1 : 0
		$LonaINI.save
	end

	def cacheNpcPrtBitmaps_opt_handler(value)
		return if @onBegin == true
		enabled = (value == "ON")
		num = value == "ON" ? 1 : 0
		$LonaINI["Cache"]["PrecacheNpcPrtBitmaps"] = num
		$LonaINI.save
		draw_resetWarning
	end
	def chsPartsClear_opt_handler(value)
		return if @onBegin == true
		enabled = (value == "ON")
		num = value == "ON" ? 1 : 0
		$LonaINI["Cache"]["DisablePartsClear"] = num
		$LonaINI.save
		draw_resetWarning
	end

	def chsMaterialClear_opt_handler(value)
		return if @onBegin == true
		enabled = (value == "ON")
		num = value == "ON" ? 1 : 0
		$LonaINI["Cache"]["DisableChsMaterialClear"] = num
		$LonaINI.save
		draw_resetWarning
	end

	def chsDataCacheClear_opt_handler(value)
		return if @onBegin == true
		enabled = (value == "ON")
		num = value == "ON" ? 1 : 0
		$LonaINI["Cache"]["DisableChsDataCacheClear"] = num
		$LonaINI.save
		draw_resetWarning
	end

	def cacheLonaPoseBitmaps_opt_handler(value)
		return if @onBegin == true
		enabled = (value == "ON")
		num = value == "ON" ? 1 : 0
		#redraw_targeted_option(:PrecacheLonaAllBitmaps) if enabled #not works. turn off for now
		$LonaINI["Cache"]["PrecacheLonaAllBitmaps"] = 0 if enabled
		$LonaINI["Cache"]["PrecacheLonaPoseBitmaps"] = num
		$LonaINI.save
		draw_resetWarning
	end

	def cacheLonaChcgBitmaps_opt_handler(value)
		return if @onBegin == true
		enabled = (value == "ON")
		num = value == "ON" ? 1 : 0

		#redraw_targeted_option(:PrecacheLonaAllBitmaps) if enabled #not works. turn off for now
		$LonaINI["Cache"]["PrecacheLonaAllBitmaps"] = 0 if enabled
		$LonaINI["Cache"]["PrecacheLonaChcgBitmaps"] = num
		$LonaINI.save
		draw_resetWarning
	end

	def cacheLonaAllBitmaps_opt_handler(value)
		return if @onBegin == true
		enabled = (value == "ON")
		num = value == "ON" ? 1 : 0

		#redraw_targeted_option(:PrecacheLonaPoseBitmaps) if enabled #not works. turn off for now
		#redraw_targeted_option(:PrecacheLonaChcgBitmaps) if enabled #not works. turn off for now
		$LonaINI["Cache"]["PrecacheLonaPoseBitmaps"] = 0 if enabled
		$LonaINI["Cache"]["PrecacheLonaChcgBitmaps"] = 0 if enabled
		$LonaINI["Cache"]["PrecacheLonaAllBitmaps"] = num
		$LonaINI.save

		draw_resetWarning
	end

	def keyBinging_opt_handler(value)
		return if @onBegin == true
		SceneManager.goto(Scene_TitleOptInputMenu)
	end

	def fullScr_opt_handler(value)
		return if @onBegin == true
		value == "ON" ? Graphics.fullscreen_mode : Graphics.windowed_mode
	end

	def scrSize_opt_handler(value)
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

	def scrScale_opt_handler(value)
		return if @onBegin == true
		$LonaINI["Screen"]["ScreenScale"] = value
		$LonaINI.save
		Graphics.checkScreenScale
		Graphics.toggle_ratio(0)
		dispose
		initialize
		clear_item(@index)
		@optSettings[@items[@index]] = $LonaINI["Screen"]["ScreenScale"]
		draw_item(@index, true)
		draw_resetWarning
	end

	def prt_focus_handler(value)
		return if @onBegin == true
		clear_item(@index)
		$data_PrtFocusMode = value
		@optSettings[@items[@index]] = $data_PrtFocusMode
		$LonaINI["LonaRPG"]["PrtFocusMode"] = $data_PrtFocusMode
		$LonaINI.save
		draw_item(@index, true)

	end

	def snd_opt_handler(value)
		return if @onBegin == true
		$data_SNDvol = value
		DataManager.write_vol_constant("SNDvol",$data_SNDvol)
		SndLib.bgs_scene_on
	end
	def bgm_opt_handler(value)
		return if @onBegin == true
		$data_BGMvol = value
		DataManager.write_vol_constant("BGMvol",$data_BGMvol)
		SndLib.bgm_scene_on
	end

	def padUImode_opt_handler(value)
		return if @onBegin == true
		$LonaINI["LonaRPG"]["GamePadUImode"] = value
		$LonaINI.save
		$data_GamePadUImode = value
		InputUtils.update_padSYM_in_UI
		SndLib.bgm_scene_on
	end

	def mapBg_opt_handler(value)
		return if @onBegin == true


		#@mapBGcolor_hash = result
		#@mapBGcolor_name = file_names

		$LonaINI["LonaRPG"]["MapBgMode"] = value
		$LonaINI.save
		$game_map.map_background_changed = true
		$data_ToneMode = @mapBGcolor_hash[value]

		#$data_ToneMode = value
		#DataManager.write_constant("LonaRPG","MapBgMode",$data_ToneMode)
		#$game_map.map_background_changed = true
	end

	def lang_opt_handler(value)
		return if @onBegin == true
		$lang  = value
		DataManager.write_lang_constant
		DataManager.update_Lang
		if @prevLang != $lang
			@prevLang = "CHANGED"
			draw_resetWarning if @prevLang
		end
	end
	def refresh_index(i)
		SceneManager.prevTitleOptChooseSet(i)
		super(i)
		SceneManager.prevTitleOpt_TopIndex_set(@top_index)
	end

end
