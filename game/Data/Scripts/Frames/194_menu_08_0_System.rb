#==============================================================================
# This script is created by Kslander 
#==============================================================================
#==============================================================================
# ** Menu_System
#==============================================================================

class Menu_Exit < Menu_ContentBase
	def enter_page
		SndLib.closeChest
		SceneManager.prevOptChooseSet(@nil)
		SceneManager.goto(Scene_Map)
	end
end

class Menu_System < Menu_ContentBase

	FONT_COLOR =[20,255,20,255]
	FONT_SIZE = 22
	OPACITY_INACTIVE =129
	OPACITY_ACTIVE=255
	BASE_LINE = 125
	UNIT_HEIGHT = 21
	OPEN_WAIT= 15
	EACH_TOP_OPT_HEIGHT=26
	
	
	#GetPrivateProfileString   = Win32API.new('kernel32', 'GetPrivateProfileString'  , 'ppppip'      , 'i')
	#WritePrivateProfileString = Win32API.new('kernel32', 'WritePrivateProfileString', 'pppp'        , 'i')

	def initialize
		super
		@mouse_all_rects = []
		@cursor=SceneManager.scene.cursor
		@cursor_row_index=0
		@cursor_column_index=0
		@wait_count=0
		@phase=0
		@all_sprites=Array.new #所有sprite的容器，用來重設所有sprite顏色使用
		get_scale_text
		#create_language_array
		create_background
		create_sprites
		create_scale_res_sprite
		create_BGM_sprite
		create_SND_sprite
		create_HotKeyLength_sprite
		create_language_notice_sprite
		create_hardcore_notice_sprite
		create_doomCoreMode_notice_sprite
		refresh
		hide
		@activeSelf=false
	end
  
  def create_background
	@main_stats_layout = Sprite.new(@viewport)
    @main_stats_layout.bitmap = Cache.load_bitmap(ROOT,"10system/system_layout")
    @main_stats_layout.z = 1    
  end
  
	def get_scale_text
		@scale_text = Graphics.getScaleTextFull
	end
  
	def create_sprites
		
		@info = Sprite.new(@viewport)
		@info.bitmap = Bitmap.new(Graphics.width, Graphics.height)
		@info.z = 2
		#[[			title_sprite,selection_sprites...], handler],[sprites, handler],	[sprites, handler]...				mouseEXT]
		@commands = []
		@commands << [create_save_game_sprite		,	method(:save_command_handler)		, nil								]
		@commands << [create_load_game_sprite		,	method(:load_command_handler)		, nil								]
		@commands << [create_return_to_title_sprite	,	method(:return_title_handler)		, nil								]
		@commands << [create_hardcore_sprite		,	method(:hardcore_opt_handler)		, method(:refresh_hard_core_opt)	]
		@commands << [create_scat_opt_sprite		,	method(:scat_opt_handler)			, method(:refresh_scat_opt)			]
		@commands << [create_urine_opt_sprite		,	method(:urine_opt_handler)			, method(:refresh_urine_opt)		]
		@commands << [create_fullscreen_opt_sprite	,	method(:fullscreen_opt_handler)		, method(:refresh_fullscreen_opt)	]
		@commands << [create_scale_opt_sprite		,	method(:scale_opt_handler)			, nil								]
		@commands << [create_SND_opt_sprite			,	method(:snd_opt_handler)			, nil								]
		@commands << [create_BGM_opt_sprite			,	method(:bgm_opt_handler)			, nil								]
		@commands << [create_HotkeyRoster_opt_sprite,	method(:hotkeyRoster_opt_handler)	, nil								]
		@commands << [create_KEY_opt_sprite			,	method(:key_opt_handler)			, nil								]
		#@commands << [@language_optArray				,	method(:launguage_opt_handler)	, method(:refresh_language_opt)		]
		#@commands.insert(@commands.length, [create_KEY_opt_sprite, method(:key_opt_handler), nil])
		#contents.insert(1,[$game_text["menu:core/sex_stats"]			,Menu_SexStats			])
		#contents.insert(1, [$game_text["menu:core/body_stats"]			,Menu_HealthStats		])
	end

	def uniform_text_sprite(x,y,width,height,text,mouseTopic=nil)
		spr=Sprite.new(@viewport)
		spr.bitmap=Bitmap.new(width,height)
		spr.bitmap.font.color.set(*FONT_COLOR)
		spr.bitmap.font.size=FONT_SIZE
		spr.bitmap.font.bold=false
		spr.x = x
		spr.y = y
		spr.z = 3
		spr.bitmap.font.outline=false
		spr.bitmap.draw_text(0,0,width,height,text)
		spr.visible=true
		spr.opacity=OPACITY_INACTIVE
		if Mouse.usable? && mouseTopic
			textWitdh = spr.bitmap.text_size(text).width
			textHeight = spr.bitmap.text_size(text).height
			@mouse_all_rects[mouseTopic] = Array.new if !@mouse_all_rects[mouseTopic]
			@mouse_all_rects[mouseTopic] << [spr.x,spr.y+4,textWitdh,textHeight]
		end
		@all_sprites << spr
		spr
	end

	def create_save_game_sprite
		spr=Sprite.new(@viewport)
		spr.bitmap=Bitmap.new(160,30)
		spr.bitmap.font.color.set(*FONT_COLOR)
		spr.bitmap.font.size=28
		spr.x = 198
		spr.y = 2+EACH_TOP_OPT_HEIGHT*1
		spr.z = 3
		spr.bitmap.font.outline=false
		tmpTarText = $game_text["menu:system/save_game"]
		spr.bitmap.draw_text(spr.bitmap.rect,tmpTarText)
		spr.visible=true
		spr.opacity=OPACITY_INACTIVE
		if Mouse.usable?
			textWitdh = spr.bitmap.text_size(tmpTarText).width
			textHeight = spr.bitmap.text_size(tmpTarText).height
			@mouse_all_rects << [[spr.x, spr.y, textWitdh , textHeight]]
		end
		@all_sprites << spr
		[spr]
	end

	def create_load_game_sprite
		spr=Sprite.new(@viewport)
		spr.bitmap=Bitmap.new(160,30)
		spr.bitmap.font.color.set(*FONT_COLOR)
		spr.bitmap.font.size=28
		spr.x = 198
		spr.y = 2+EACH_TOP_OPT_HEIGHT*2
		spr.z = 3
		spr.bitmap.font.outline=false
		tmpTarText = $game_text["menu:system/load_game"]
		spr.bitmap.draw_text(spr.bitmap.rect,tmpTarText)
		spr.visible=true
		spr.opacity=OPACITY_INACTIVE
		if Mouse.usable?
			textWitdh = spr.bitmap.text_size(tmpTarText).width
			textHeight = spr.bitmap.text_size(tmpTarText).height
			@mouse_all_rects << [[spr.x, spr.y, textWitdh , textHeight]]
		end
		@all_sprites << spr
		[spr]
	end
	
	def create_return_to_title_sprite
		spr=Sprite.new(@viewport)
		spr.bitmap=Bitmap.new(240,30)
		spr.bitmap.font.color.set(*FONT_COLOR)
		spr.bitmap.font.size=28
		spr.x = 198
		spr.y = 2+EACH_TOP_OPT_HEIGHT*3
		#spr.y = 50
		spr.z = 3
		spr.bitmap.font.outline=false
		tmpTarText = $game_text["menu:system/return_to_title"]
		spr.bitmap.draw_text(spr.bitmap.rect,tmpTarText)
		spr.visible=true
		spr.opacity=OPACITY_INACTIVE
		if Mouse.usable?
			textWitdh = spr.bitmap.text_size(tmpTarText).width
			textHeight = spr.bitmap.text_size(tmpTarText).height
			@mouse_all_rects << [[spr.x, spr.y, textWitdh , textHeight]]
		end
		@all_sprites << spr
		[spr]
	end

###########################################     語系管理 檢查語言是否存在
	def create_hardcore_sprite
		tmpMouseTargetArray = @mouse_all_rects.length
		[
			uniform_text_sprite(198,BASE_LINE + UNIT_HEIGHT * 0,160,30,$game_text["menu:system/hardcore"]),
			uniform_text_sprite(356,BASE_LINE + UNIT_HEIGHT * 0,100,30,$game_text["menu:system/DiffHard"],tmpMouseTargetArray),
			uniform_text_sprite(420,BASE_LINE + UNIT_HEIGHT * 0,100,30,$game_text["menu:system/DiffHell"],tmpMouseTargetArray),
			uniform_text_sprite(484,BASE_LINE + UNIT_HEIGHT * 0,100,30,$game_text["menu:system/DiffDoom"],tmpMouseTargetArray)
		]
	end

	def create_scat_opt_sprite
		tmpMouseTargetArray = @mouse_all_rects.length
		[
			uniform_text_sprite(198,BASE_LINE + UNIT_HEIGHT * 1,160,30,$game_text["menu:system/scat_fetish"]	),
			uniform_text_sprite(356,BASE_LINE + UNIT_HEIGHT * 1,60,30,"ON"										,tmpMouseTargetArray),
			uniform_text_sprite(420,BASE_LINE + UNIT_HEIGHT * 1,60,30,"OFF"										,tmpMouseTargetArray)
		]
	end

	def create_urine_opt_sprite
		tmpMouseTargetArray = @mouse_all_rects.length
		[
			uniform_text_sprite(198,BASE_LINE + UNIT_HEIGHT * 2,160,30,$game_text["menu:system/urine_fetish"]),
			uniform_text_sprite(356,BASE_LINE + UNIT_HEIGHT * 2,60,30,"ON"					,tmpMouseTargetArray),
			uniform_text_sprite(420,BASE_LINE + UNIT_HEIGHT * 2,60,30,"OFF"					,tmpMouseTargetArray)
		]
	end

	def create_fullscreen_opt_sprite
		tmpMouseTargetArray = @mouse_all_rects.length
		[
			uniform_text_sprite(198,BASE_LINE + UNIT_HEIGHT * 3,160,30,$game_text["menu:system/full_screen"]),
			uniform_text_sprite(356,BASE_LINE + UNIT_HEIGHT * 3,60,30,"ON"					,tmpMouseTargetArray),
			uniform_text_sprite(420,BASE_LINE + UNIT_HEIGHT * 3,60,30,"OFF"					,tmpMouseTargetArray)
		]
	end
	
	def create_scale_opt_sprite
		tmpMouseTargetArray = @mouse_all_rects.length
		[
			uniform_text_sprite(198,BASE_LINE + UNIT_HEIGHT * 4,160,30,$game_text["menu:system/screen_scale"]),
			uniform_text_sprite(356,BASE_LINE + UNIT_HEIGHT * 4,60,30,"                           ",tmpMouseTargetArray),
			uniform_text_sprite(356,BASE_LINE + UNIT_HEIGHT * 4,60,30,"                           ",tmpMouseTargetArray) #for mouse. double a line.
		]
	end
	
	def create_SND_opt_sprite
		tmpMouseTargetArray = @mouse_all_rects.length
		[
		uniform_text_sprite(198,BASE_LINE + UNIT_HEIGHT * 5,160,30,$game_text["menu:system/SNDvol"]),
		uniform_text_sprite(356,BASE_LINE + UNIT_HEIGHT * 5,15,30,"<<<",tmpMouseTargetArray),
		uniform_text_sprite(376,BASE_LINE + UNIT_HEIGHT * 5,15,30,"<",tmpMouseTargetArray),
		uniform_text_sprite(476,BASE_LINE + UNIT_HEIGHT * 5,15,30,">",tmpMouseTargetArray),
		uniform_text_sprite(496,BASE_LINE + UNIT_HEIGHT * 5,15,30,">>>",tmpMouseTargetArray)
		]
	end
	
	def create_BGM_opt_sprite
		tmpMouseTargetArray = @mouse_all_rects.length
		[
		uniform_text_sprite(198,BASE_LINE + UNIT_HEIGHT * 6,160,30,$game_text["menu:system/BGMvol"]),
		uniform_text_sprite(356,BASE_LINE + UNIT_HEIGHT * 6,15,30,"<<<",tmpMouseTargetArray),
		uniform_text_sprite(376,BASE_LINE + UNIT_HEIGHT * 6,15,30,"<",tmpMouseTargetArray),
		uniform_text_sprite(476,BASE_LINE + UNIT_HEIGHT * 6,15,30,">",tmpMouseTargetArray),
		uniform_text_sprite(496,BASE_LINE + UNIT_HEIGHT * 6,15,30,">>>",tmpMouseTargetArray)
		]
	end
	
	def create_HotkeyRoster_opt_sprite
		tmpMouseTargetArray = @mouse_all_rects.length
		[
		uniform_text_sprite(198,BASE_LINE + UNIT_HEIGHT * 7,160,30,$game_text["menu:system/HotkeyRosterLength"]),
		uniform_text_sprite(376,BASE_LINE + UNIT_HEIGHT * 7,15,30,"<",tmpMouseTargetArray),
		uniform_text_sprite(476,BASE_LINE + UNIT_HEIGHT * 7,15,30,">",tmpMouseTargetArray)
		]
	end
	
	def create_KEY_opt_sprite
		tmpMouseTargetArray = @mouse_all_rects.length
		[
		uniform_text_sprite(198,BASE_LINE + UNIT_HEIGHT * 8,160,30,""),
		uniform_text_sprite(198,BASE_LINE + UNIT_HEIGHT * 8,160,30,InputUtils.get_text("menu:system/KEYbind", "Keybinding"),tmpMouseTargetArray)
		]
	end
	
	###########################################################################

	def create_scale_res_sprite(x=356,y=BASE_LINE + UNIT_HEIGHT * 4,width=160,height=30)
		@scale_res_spr=Sprite.new(@viewport)
		@scale_res_spr.bitmap=Bitmap.new(width,height)
		@scale_res_spr.bitmap.font.color.set(*FONT_COLOR)
		@scale_res_spr.bitmap.font.size=FONT_SIZE
		@scale_res_spr.bitmap.font.bold=false
		@scale_res_spr.x = x
		@scale_res_spr.y = y
		@scale_res_spr.z = 3
		@scale_res_spr.bitmap.font.outline=false
		@scale_res_spr.bitmap.draw_text(0,0,width,height,@scale_text)
		@scale_res_spr.visible=true
		@scale_res_spr.opacity=255
		#if Mouse.usable?
		#	textWitdh = @scale_res_spr.bitmap.text_size(@scale_text).width
		#	textHeight = @scale_res_spr.bitmap.text_size(@scale_text).height
		#	@mouse_all_rects << [[@scale_res_spr.x, @scale_res_spr.y+4, textWitdh , textHeight]]
		#end
	end
	###########################################################################
	
	def create_SND_sprite(x=376,y=BASE_LINE + UNIT_HEIGHT * 5,width=110,height=30)
		@snd_res_spr=Sprite.new(@viewport)
		@snd_res_spr.bitmap=Bitmap.new(width,height)
		@snd_res_spr.bitmap.font.color.set(*FONT_COLOR)
		@snd_res_spr.bitmap.font.size=FONT_SIZE
		@snd_res_spr.bitmap.font.bold=false
		@snd_res_spr.x = x
		@snd_res_spr.y = y
		@snd_res_spr.z = 3
		@snd_res_spr.bitmap.font.outline=false
		@snd_res_spr.bitmap.draw_text(0,0,width,height,$data_SNDvol,1)
		@snd_res_spr.visible=true
		@snd_res_spr.opacity=255
	end 
	def create_BGM_sprite(x=376,y=BASE_LINE + UNIT_HEIGHT * 6,width=110,height=30)
		@bgm_res_spr=Sprite.new(@viewport)
		@bgm_res_spr.bitmap=Bitmap.new(width,height)
		@bgm_res_spr.bitmap.font.color.set(*FONT_COLOR)
		@bgm_res_spr.bitmap.font.size=FONT_SIZE
		@bgm_res_spr.bitmap.font.bold=false
		@bgm_res_spr.x = x
		@bgm_res_spr.y = y
		@bgm_res_spr.z = 3
		@bgm_res_spr.bitmap.font.outline=false
		@bgm_res_spr.bitmap.draw_text(0,0,width,height,$data_BGMvol,1)
		@bgm_res_spr.visible=true
		@bgm_res_spr.opacity=255
	end
	def create_HotKeyLength_sprite(x=376,y=BASE_LINE + UNIT_HEIGHT * 7,width=110,height=30)
		@hotkey_length_spr=Sprite.new(@viewport)
		@hotkey_length_spr.bitmap=Bitmap.new(width,height)
		@hotkey_length_spr.bitmap.font.color.set(*FONT_COLOR)
		@hotkey_length_spr.bitmap.font.size=FONT_SIZE
		@hotkey_length_spr.bitmap.font.bold=false
		@hotkey_length_spr.x = x
		@hotkey_length_spr.y = y
		@hotkey_length_spr.z = 3
		@hotkey_length_spr.bitmap.font.outline=false
		@hotkey_length_spr.bitmap.draw_text(0,0,width,height,$game_player.slot_RosterArray.length,1)
		@hotkey_length_spr.visible=true
		@hotkey_length_spr.opacity=255
	end
	#@resSprY = (BASE_LINE + UNIT_HEIGHT *3)

	###########################################################################
	def create_language_array 
		tmpWindex =64
		@language_optArray= [ uniform_text_sprite(198,BASE_LINE + UNIT_HEIGHT * 8,160,30,$game_text["menu:system/language"]) ]
		@langFOlderCheck = DataManager.createLangArray
		@langIndex = 0
		@langFOlderCheck.each{|tmpLng|
			@langIndex += 1
			@language_optArray << uniform_text_sprite(292+(tmpWindex*@langIndex),BASE_LINE + UNIT_HEIGHT * 8,60,30,tmpLng)
		}
	end
###########################################################################
	
	def refresh_scale_res_text
		@scale_res_spr.dispose
		get_scale_text
		create_scale_res_sprite
	end
	def refresh_SND_res_text
		@snd_res_spr.dispose
		create_SND_sprite
		SndLib.ppl_Cheer
		SndLib.bgs_scene_on
	end
	
	def refresh_BGM_res_text
		@bgm_res_spr.dispose
		create_BGM_sprite
		SndLib.bgm_scene_on
	end
	def refresh_hotkey_length_res_text
		@hotkey_length_spr.dispose
		create_HotKeyLength_sprite
	end

	
###########################################     語系管理
	#def create_language_opt_sprite #檢查語系是否存在
	#	@tmpArray
	#end
  
  
  def refresh_language_opt(sprites) #ui繪製語系
	darken_seletion_sprites(sprites)
	sprites[1+@langFOlderCheck.index($lang)].opacity=OPACITY_ACTIVE
  end
###########################################     語系管理 END
  
	def create_language_notice_sprite
		@language_notice_back = Sprite.new
		@language_notice_back.bitmap = Cache.load_bitmap("Graphics/System/","chat_window_black_area50")
		@language_notice_back.z = 1+ System_Settings::SCENE_Menu_Cursor_Z 
		
		@language_notice = Sprite.new
		@language_notice.bitmap = Bitmap.new(Graphics.width, Graphics.height)
		@language_notice.z = @language_notice_back.z + 1
		
		bmp = @language_notice.bitmap
		bmp.font.outline=false
		bmp.font.color.set(*FONT_COLOR)
		bmp.font.size = 22
		bmp.draw_text(129,129,384,36,$game_text["menu:system/language_change"],1)
		
		bmp.font.size = 26
		bmp.font.color.set(20,255,255,255)
		bmp.draw_text(289,177,64,29,InputUtils.getKeyAndTranslate(:C),1)
		
		bmp.font.size = 26
		bmp.font.color.set(20,255,255,255)
		bmp.draw_text(257,205,128,25,$game_text["menu:system/language_press_z"],1)
		@language_notice_back.visible = @language_notice.visible = false
	end
  
	def create_hardcore_notice_sprite
		@hardcore_notice_back = Sprite.new
		@hardcore_notice_back.bitmap = Cache.load_bitmap("Graphics/System/","chat_window_black_area50")
		@hardcore_notice_back.z = 1+ System_Settings::SCENE_Menu_Cursor_Z 
			
		@hardcore_notice = Sprite.new
		@hardcore_notice.bitmap = Bitmap.new(Graphics.width, Graphics.height)
		@hardcore_notice.z = @hardcore_notice_back.z + 1
		
		bmp = @hardcore_notice.bitmap
			bmp.font.outline=false
			bmp.font.size = 50
			bmp.font.color.set(255,100,150,255)
			bmp.draw_text(70,35, 500,48,$game_text["menu:system/HellCoreMode0"],1)
			bmp.font.size = 20
			bmp.font.color.set(*FONT_COLOR)
			bmp.draw_text(50,89, 540,36,$game_text["menu:system/HellCoreMode1"],1)
			bmp.draw_text(50,109,540,36,$game_text["menu:system/HellCoreMode2"],1)
			bmp.draw_text(50,129,540,36,$game_text["menu:system/HellCoreMode3"],1)
			bmp.draw_text(50,149,540,36,$game_text["menu:system/HellCoreMode4"],1)
		
			bmp.font.outline=false
			bmp.font.size = 22
			bmp.font.color = Color.new(0,255,0)
			bmp.draw_text(238,168,166,42,InputUtils.getKeyAndTranslate(:C),0)
			bmp.font.color = Color.new(255,255,0)
			bmp.draw_text(238,168,166,42,InputUtils.getKeyAndTranslate(:B),2)
			bmp.font.color = Color.new(255,255,255)
			bmp.font.size = 20
			bmp.draw_text(238,190,166,42,$game_text["DataInput:Key/Confirm"],0)
			bmp.draw_text(238,190,166,42,$game_text["DataInput:Key/Cancel"],2)
		@hardcore_notice_back.visible = @hardcore_notice.visible = false
	end
  
	def create_doomCoreMode_notice_sprite
		@doomCoreMode_notice = Sprite.new
		@doomCoreMode_notice.bitmap = Bitmap.new(Graphics.width, Graphics.height)
		@doomCoreMode_notice.z = @hardcore_notice_back.z + 1
		
		bmp = @doomCoreMode_notice.bitmap
			bmp.font.outline=false
			bmp.font.size = 50
			bmp.font.color.set(255,100,150,255)
			bmp.draw_text(70,35, 500,48,$game_text["menu:system/DoomCoreMode0"],1)
			bmp.font.size = 20
			bmp.font.color.set(*FONT_COLOR)
			bmp.draw_text(50,89, 540,36,$game_text["menu:system/DoomCoreMode1"],1)
			bmp.draw_text(50,109,540,36,$game_text["menu:system/DoomCoreMode2_OLD"],1)
			bmp.draw_text(50,129,540,36,$game_text["menu:system/DoomCoreMode2"],1)
			bmp.draw_text(50,149,540,36,$game_text["menu:system/DoomCoreMode4"],1)
			bmp.draw_text(50,169,540,36,$game_text["menu:system/DoomCoreMode3"],1)
		
			bmp.font.outline=false
			bmp.font.size = 22
			bmp.font.color = Color.new(0,255,0)
			bmp.draw_text(238,188,166,42,InputUtils.getKeyAndTranslate(:C),0)
			bmp.font.color = Color.new(255,255,0)
			bmp.draw_text(238,188,166,42,InputUtils.getKeyAndTranslate(:B),2)
			bmp.font.color = Color.new(255,255,255)
			bmp.font.size = 20
			bmp.draw_text(238,210,166,42,$game_text["DataInput:Key/Confirm"],0)
			bmp.draw_text(238,210,166,42,$game_text["DataInput:Key/Cancel"],2)
		@hardcore_notice_back.visible = @doomCoreMode_notice.visible = false
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
		if @hardcore_notice_back.visible
			return hardcore_opt_handler(tmp_agree=true)		if (Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK))
			return hardcore_opt_handler(tmp_agree=false)	if (Input.trigger?(:B) || WolfPad.trigger?(:X_LINK))
			return
		end
		return call_handler		if Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)
		return 					if @language_notice_back.visible
		return back_to_mainmenu if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK)
		return next_row  		if Input.repeat?(:DOWN)
		return prev_row  		if Input.repeat?(:UP)
		return prev_column  	if Input.repeat?(:LEFT)
		return next_column  	if Input.repeat?(:RIGHT)
	end
	def mouse_update_input
		return Mouse.ForceIdle if Input.MouseWheelForceIdle?
		return if !Mouse.enable?
		if @hardcore_notice_back.visible
			return Mouse.ForceIdle if Input.MouseWheelForceIdle?
			return hardcore_opt_handler(tmp_agree=true)		if Input.trigger?(:MZ_LINK)
			return hardcore_opt_handler(tmp_agree=false)	if Input.trigger?(:MX_LINK)
		end
		return back_to_mainmenu if Input.trigger?(:MX_LINK) && @phase == 1
		return unless Input.trigger?(:MZ_LINK)
		tmpWithInWholePage = !Mouse.within_XYWH?(0, 0, 156, 360)
		#tmpWithInMainMenuArea = Mouse.within_XYWH?(0, 0, 156, 360)
		firstClickBlock = true if @phase == 0
		enter_page if @phase == 0 && tmpWithInWholePage
		#return back_to_mainmenu if @phase == 1 && !tmpWithInWholePage
		tmpIndexWriteX = nil
		tmpIndexWriteY = nil
		@mouse_all_rects.length.times{|iX|
			if @mouse_all_rects[iX].length == 1
				next unless Mouse.within_XYWH?(*@mouse_all_rects[iX][0])
				tmpIndexWriteX = iX
				tmpIndexWriteY = 0
			else
				@mouse_all_rects[iX].length.times{|iY|
					next unless Mouse.within_XYWH?(*@mouse_all_rects[iX][iY])
					tmpIndexWriteX = iX
					tmpIndexWriteY = iY+1
					
				}
			end
		}
		#p "Mouse.GetMouseXY #{Mouse.GetMouseXY}"
		#p "@phase #{@phase}"
		#p "tmpIndexWriteX = #{tmpIndexWriteX} @cursor_row_index #{@cursor_row_index}"
		#p "tmpIndexWriteY = #{tmpIndexWriteY} @cursor_column_index #{@cursor_column_index}"
		return if !tmpIndexWriteX && !tmpIndexWriteY
		if tmpIndexWriteX != @cursor_row_index || tmpIndexWriteY != @cursor_column_index
			mouse_clicked(tmpIndexWriteX,tmpIndexWriteY)
		elsif tmpIndexWriteX == @cursor_row_index && tmpIndexWriteY == @cursor_column_index
			call_handler if !firstClickBlock
		end
	end
	

	def mouse_force_main_menu_pause
		@hardcore_notice_back.visible
	end
	def call_handler
		SndLib.sys_ok
		@commands[@cursor_row_index][1].call
	end
	
	def mouse_clicked(tmpIndexWriteX=0,tmpIndexWriteY=0)
		SndLib.play_cursor
		@cursor_row_index = tmpIndexWriteX
		@cursor_column_index = tmpIndexWriteY
		selections=@commands[@cursor_row_index][0]
		darken_single_line_sprites
		set_cursor_position
		lighten_selected_sprite(false)
	end
	
	def next_row
		SndLib.play_cursor
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
	SndLib.play_cursor
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
	SndLib.play_cursor
	@cursor_column_index=@commands[@cursor_row_index][0].length-1 if (@cursor_column_index-=1) <=0
	set_cursor_position
  end
  
	def next_column
		return if @commands[@cursor_row_index][0].length == 1 # only one line / no selection ,ex: SAVE_GAME /RETURN_TO_TITLE
		SndLib.play_cursor
		@cursor_column_index=1 if (@cursor_column_index+=1) >=@commands[@cursor_row_index][0].length
		set_cursor_position
	end
  
	def set_cursor_position
		tgtspr=@commands[@cursor_row_index][0][@cursor_column_index]
		@cursor.to_xy(tgtspr.x-(@cursor.bitmap.width+5) ,tgtspr.y+6)
	end
  
  def refresh
	@commands.each{
		|command_row|
		command_row[2].call(command_row[0]) unless command_row[2].nil? #call refreshers
	}
  end
  
  
	def enter_page
		SndLib.sys_ok
		@phase=1
		@active =true
		@cursor.visible=true
		#if !Mouse.enable?
		#	@cursor_column_index=0
		#	@cursor_row_index=0
		#end
		darken_single_line_sprites
		Input.update
		lighten_selected_sprite(false)
		refresh
		set_cursor_position
	end
  
	def return_from_key_inpur_force_actice
		@active = true
		@activeSelf=true
	end
	def show
		super
		#!@childWindow.nil? && @childWindow.active
		p "!@childWindow.nil? #{!@childWindow.nil?}"
		p "@childWindow.active #{@childWindow.active}" if !@childWindow.nil?
		p "show on system page"
		#if !Mouse.enable?
		#	@cursor_column_index=0
		#	@cursor_row_index=0
		#end
		darken_single_line_sprites
		@active=false
		@activeSelf=true
	end
  
	def hide
		super
		#if !Mouse.enable?
		#	@cursor_column_index=0
		#	@cursor_row_index=0
		#end
		darken_single_line_sprites
		@active=false
		@activeSelf=false
	end

	def active
		activeSelf || (!@childWindow.nil? && childWindow.active)
	end
	
	def hide_key_input_window
		return if !@childWindow.nil? && !@childWindow.active
		@childWindow.childWindow.hide if !@childWindow.nil? && !@childWindow.childWindow.nil?
		@childWindow.hide if !@childWindow.nil?
		
	end
	
	def mouse_press_cancel
		hide_key_input_window
	end
	
	def back_to_mainmenu
		hide_key_input_window
		SndLib.sys_cancel
		darken_single_line_sprites
		@phase = 0
		@menu.activate
	end  
  
  #handlers 
  
=begin

$story_stats["Setup_Hardcore"]            #0 or 1 #高難度　SAT需求增加 todo:將不准ＭＥＮＵ　ＳＡＶＥ　ＳＡＶＥ改成每ＨＡＮＤＬＥＮＡＰ　ＳＡＶＥ一次
$story_stats["Setup_ScatEffect"]        #0 or 1 #是否排泄
=end
  
  def save_command_handler
	return SndLib.sys_buzzer if $story_stats["MenuSysSavegameOff"] >= 1
	return SndLib.sys_buzzer if $story_stats["Setup_Hardcore"] >= 2
	SceneManager.goto(Scene_Save)
  end

	def load_command_handler
		return SndLib.sys_buzzer if $story_stats["MenuSysSavegameOff"] >= 1
		return SndLib.sys_buzzer if $story_stats["Setup_Hardcore"] >= 2
		SceneManager.goto(Scene_Load_OnGameMenu)
	end
	
  def return_title_handler
	return SndLib.sys_buzzer if $story_stats["MenuSysReturnTitleOff"] >= 1
	@return_to_title = true
	SceneManager.clear_PrevTitle_index_rec
	SceneManager.goto(Scene_Title)
  end
  
  
  def fullscreen_opt_handler
	@cursor_column_index == 1 ? Graphics.fullscreen_mode : Graphics.windowed_mode
	refresh_scale_res_text
	refresh
  end
  
	def scat_opt_handler
	return SndLib.sys_buzzer if $story_stats["MenuSysScatOff"] >= 1
		tmpPrev = $story_stats["Setup_ScatEffect"]
		$story_stats["Setup_ScatEffect"] = 2 - @cursor_column_index
		refresh
		if $story_stats["Setup_ScatEffect"] ==0
			$story_stats["record_giveup_PeePoo"] +=1 if $story_stats["Setup_ScatEffect"] != tmpPrev
			$game_player.actor.fetishPooPoo(false)
		else
			$game_player.actor.fetishPooPoo(true)
		end
	end

	def urine_opt_handler
	return SndLib.sys_buzzer if $story_stats["MenuSysUrineOff"] >= 1
		tmpPrev = $story_stats["Setup_UrineEffect"]
		$story_stats["Setup_UrineEffect"] = 2 - @cursor_column_index
		refresh
		if $story_stats["Setup_UrineEffect"] ==0
			$story_stats["record_giveup_PeePoo"] +=1 if $story_stats["Setup_UrineEffect"] != tmpPrev
			$game_player.actor.fetishPeePee(false)
		else
			$game_player.actor.fetishPeePee(true)
		end
	end

	def scale_opt_handler
		Graphics.toggle_ratio#=@cursor_column_index
		refresh_scale_res_text
		refresh
	end
	def bgm_opt_handler
		case @cursor_column_index
			when 1 ;$data_BGMvol -= 30
			when 2 ;$data_BGMvol -= 5
			when 3 ;$data_BGMvol += 5
			when 4 ;$data_BGMvol += 30
		end
		$data_BGMvol = 100 if $data_BGMvol > 100
		$data_BGMvol = 0 if $data_BGMvol < 0
		DataManager.write_vol_constant("BGMvol",$data_BGMvol)
		refresh_BGM_res_text
		refresh
	end
	def snd_opt_handler
		case @cursor_column_index
			when 1 ;$data_SNDvol -= 30
			when 2 ;$data_SNDvol -= 5
			when 3 ;$data_SNDvol += 5
			when 4 ;$data_SNDvol += 30
		end
		$data_SNDvol = 100 if $data_SNDvol > 100
		$data_SNDvol = 0 if $data_SNDvol < 0
		DataManager.write_vol_constant("SNDvol",$data_SNDvol)
		refresh_SND_res_text
		refresh
	end
	
	def hotkeyRoster_opt_handler
		case @cursor_column_index
			when 1
					return SndLib.sys_buzzer if $game_player.slot_RosterArray.length <= 1
					;$game_player.slot_RosterArray.pop
			when 2
					return SndLib.sys_buzzer if $game_player.slot_RosterArray.length >= 9
					;$game_player.slot_RosterArray << [nil,nil,nil,nil,nil,nil,nil,nil,nil]
		end
		$game_player.slot_RosterCurrent = 0 if $game_player.slot_RosterCurrent > $game_player.slot_RosterArray.length-1
		refresh_hotkey_length_res_text
		refresh
	end
	
	def nil_opt_handler
		p "OPT todo"
	end
  
	def launguage_opt_handler
		if @language_notice_back.visible
			@language_notice_back.visible = false
			@language_notice.visible = false
		else
			$lang=@langFOlderCheck[@cursor_column_index-1]
			DataManager.write_lang_constant
			DataManager.update_Lang
			@language_notice_back.dispose
			create_language_notice_sprite
			@language_notice_back.visible	=	true
			@language_notice.visible 		=	true
		end
		refresh
	end
  
	def hardcore_opt_handler(tmp_agree=false)
		return SndLib.sys_buzzer if $story_stats["MenuSysHardcoreOff"] >= 1
		return SndLib.sys_buzzer if $story_stats["Setup_Hardcore"] >= 2
		tmpPrev = $story_stats["Setup_Hardcore"]
		#$story_stats["Setup_Hardcore"] = @cursor_column_index-1 #0(non-hardcore) or 1(hardcore)
		case @cursor_column_index-1
			when 0
				$story_stats["Setup_Hardcore"] = @cursor_column_index-1
			when 1
				if @hardcore_notice_back.visible
					 if tmp_agree
						$story_stats["Setup_Hardcore"] = @cursor_column_index-1
						$story_stats["Setup_HardcoreAmt"] = $game_date.date[0..2]
						SndLib.ppl_CheerGroup(100)
					else
						SndLib.ppl_BooGroup(100)
					end
					@hardcore_notice_back.visible = false
					@hardcore_notice.visible = false
				else
					@hardcore_notice_back.visible	=	true
					@hardcore_notice.visible 		=	true
				end
			when 2
				if @hardcore_notice_back.visible
					 if tmp_agree
					 $story_stats["record_giveup_hardcore"] = "#{$game_date.dateAmt.to_s(16).upcase}"
						$story_stats["Setup_Hardcore"] = @cursor_column_index-1
						$story_stats["Setup_HardcoreAmt"] = $game_date.date[0..2]
						SndLib.ppl_CheerGroup(100)
					else
						SndLib.ppl_BooGroup(100)
					end
					@hardcore_notice_back.visible = false
					@doomCoreMode_notice.visible = false
				else
					@hardcore_notice_back.visible	=	true
					@doomCoreMode_notice.visible 		=	true
				end
			
		end
		refresh
		return if $story_stats["Setup_Hardcore"] == tmpPrev
		if $story_stats["Setup_Hardcore"] <= 0
			GabeSDK.getAchievement("record_giveup_hardcore")
			$story_stats["record_giveup_hardcore"] +=1
			$game_player.actor.fetishHardcore(false)
		else
			$game_player.actor.fetishHardcore(true)
		end
	end
  #refreshers , link real values and sprite display here  
  #param : sprites =>[title_sprite , selection_1, selection2 .....]
  
	def refresh_hard_core_opt(sprites)
		darken_seletion_sprites(sprites)
		sprites[1+$story_stats["Setup_Hardcore"]].opacity=OPACITY_ACTIVE
	end
	
	def refresh_scat_opt(sprites)	
		darken_seletion_sprites(sprites)
		sprites[2- $story_stats["Setup_ScatEffect"]].opacity=OPACITY_ACTIVE
	end
	
	def refresh_urine_opt(sprites)	
		darken_seletion_sprites(sprites)
		sprites[2- $story_stats["Setup_UrineEffect"]].opacity=OPACITY_ACTIVE
	end
	
	def refresh_fullscreen_opt(sprites)
		darken_seletion_sprites(sprites)
		sprites[Graphics.fullscreen? ? 1 : 2].opacity=OPACITY_ACTIVE
	end
	
	
  def refresh_scale_opt(sprites)
	#if Graphics.ratio==0
	#	sprites[3].opacity=OPACITY_ACTIVE
	#else
	#	sprites[Graphics.ratio].opacity=OPACITY_ACTIVE
	#end
	#Graphics.toggle_ratio
	#sprites[1].opacity=255
	#get_scale_text
  end
  
	#passing update call to input menu if it's open instead
	def update
		return @childWindow.update if !@childWindow.nil? && @childWindow.active
		return if !@viewport.visible
		mouse_update_input
		return unless @active
		update_input if @activeSelf
	end
	def mouse_force_main_menu_pause
		return true if @return_to_title
		false
	end
	def key_opt_handler
		@childWindow = Menu_Input_Top.new(self) if @menuInput.nil?
		self.hide
		@childWindow.show
	end
	def darken_seletion_sprites(sprites)
		sprites.each do |spr| spr.opacity=OPACITY_INACTIVE; end
	end
  
  def dispose
	@childWindow.dispose if !@childWindow.nil?
	@main_stats_layout.bitmap.dispose
	@main_stats_layout.dispose
	@language_notice_back.bitmap.dispose
	@language_notice_back.dispose
	@hardcore_notice_back.bitmap.dispose
	@hardcore_notice_back.dispose
	@info.dispose
	@info.bitmap.dispose
	@language_notice.bitmap.dispose
	@language_notice.dispose
	@hardcore_notice.bitmap.dispose
	@hardcore_notice.dispose
	@doomCoreMode_notice.bitmap.dispose
	@doomCoreMode_notice.dispose
	@scale_res_spr.dispose
	@bgm_res_spr.dispose
	@snd_res_spr.dispose
	@hotkey_length_spr.dispose
	@all_sprites.each do 
		|spr|  
		spr.bitmap.dispose
		spr.dispose
	end
	super
  end
  
  
  
  
end
