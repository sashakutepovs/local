class Scene_ModDismatchWarning < Scene_MenuBase
	#def initialize
	#end
end
#for load quick save
class Scene_CustomModeLoad < Scene_MenuBase
	
	def initialize
		@doomMode = DataManager.customLoadName == "SavDoomMode"
	end
	
	def start
		super
		createDoomSaveWarning if @doomMode
	end
	
	def createDoomSaveWarning
		SndLib.ppl_CheerGroup(100)
		@doomSave_notice_back = Sprite.new
		@doomSave_notice_back.bitmap = Cache.load_bitmap("Graphics/System/","chat_window_black_area50")
		@doomSave_notice_back.z = 1+ System_Settings::SCENE_Menu_Cursor_Z 
			
		@doomSave_notice = Sprite.new
		@doomSave_notice.bitmap = Bitmap.new(Graphics.width, Graphics.height)
		@doomSave_notice.z = @doomSave_notice_back.z + 1
		tmpXYfix = 20
		
		bmp = @doomSave_notice.bitmap
			bmp.font.outline=false
			bmp.font.size = 40
			bmp.font.color.set(255,255,255,255)
			bmp.draw_text(70,35+tmpXYfix, 500,48,$game_text["menu:system/DoomCoreMode_Load0"],1)
			bmp.font.size = 30
			bmp.draw_text(50,80+tmpXYfix,540,36,$game_text["menu:system/DoomCoreMode_Load1"],1)
			bmp.font.size = 20
			bmp.draw_text(50,104+tmpXYfix,540,36,$game_text["menu:system/DoomCoreMode2_OLD"],1)
			bmp.draw_text(50,124+tmpXYfix,540,36,$game_text["menu:system/DoomCoreMode2"],1)
			bmp.draw_text(50,144+tmpXYfix,540,36,$game_text["menu:system/DoomCoreMode4"],1)
			bmp.draw_text(50,164+tmpXYfix,540,36,$game_text["menu:system/DoomCoreMode3"],1)
		
			bmp.font.outline=false
			bmp.font.size = 22
			bmp.font.color = Color.new(0,255,0)
			bmp.draw_text(238,208+tmpXYfix,166,42,InputUtils.getKeyAndTranslate(:C),0)
			bmp.font.color = Color.new(255,255,0)
			bmp.draw_text(238,208+tmpXYfix,166,42,InputUtils.getKeyAndTranslate(:B),2)
			bmp.font.color = Color.new(255,255,255)
			bmp.font.size = 20
			bmp.draw_text(238,230+tmpXYfix,166,42,$game_text["DataInput:Key/Confirm"],0)
			bmp.draw_text(238,230+tmpXYfix,166,42,$game_text["DataInput:Key/Cancel"],2)
		@doomSave_notice_back.visible = @doomSave_notice.visible = true
	end
	
	def update
		super
		if @doomMode
			mouse_update_hardcore_input
			return doomSaveLoad if Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)
			return doomSaveCancel if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK)
			return
		else
			customSaveLoad
		end
	end
	
	def mouse_update_hardcore_input
		return Mouse.ForceIdle if Input.MouseWheelForceIdle?
		return if !Mouse.enable?
		return doomSaveLoad if Input.trigger?(:MZ_LINK)
		return doomSaveCancel if Input.trigger?(:MX_LINK)
	end
	
	def customSaveLoad
		if DataManager.customModeLoad(DataManager.customLoadName)
			on_load_success 
		else
			SndLib.sys_buzzer
			SceneManager.goto(Scene_Map)
		end
	end
	
	def doomSaveCancel
		SceneManager.goto(Scene_MapTitle)
		SndLib.ppl_BooGroup(100)
	end
	
	def doomSaveLoad
		if DataManager.doomModeLoad
			on_load_success 
		else
			@doomModeSaveFound = false
			SndLib.sys_buzzer
		end
	end
	def terminate
		super
		@doomSave_notice_back.dispose if @doomMode
		@doomSave_notice.dispose if @doomMode
	end
	def on_load_success
		Cache.clear
		$titleCreateActorReq = true
		$story_stats["record_GameLoaded"] += 1 if $story_stats["Setup_Hardcore"] < 2
		if @doomMode
			SndLib.ppl_CheerGroup(100)
		else
			SndLib.sys_LoadGame
		end
		SceneManager.clear_PrevTitle_index_rec
		fadeout_all
		$game_system.on_after_load
		SceneManager.goto(Scene_Map)
		$game_player.refresh_chs
		#$game_player.actor.portrait.refresh # already in $game_player.refresh_chs
		$game_player.actor.portrait.update
		DataManager.saveFileDeleteDoom if @doomMode
	end
end
