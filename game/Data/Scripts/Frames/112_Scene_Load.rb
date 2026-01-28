#==============================================================================
# ** Scene_Load
#------------------------------------------------------------------------------
#  This class performs load screen processing. 
#==============================================================================

class Scene_Load < Scene_File
	
	def start
		@currentMax = item_max
		@insertedIndex = 0
		@indexAutosaveE = nil
		@indexAutosaveS = nil
		@indexDoomsave = nil
		@gameModData = $mod_manager.output_data_to_array
		super
	end
	
	def create_savefile_windows #ref from game file
		@savefile_windows = Array.new(@currentMax) do |i|
			Window_SaveFile.new(savefile_height, i)
		end
		@savefile_windows.each do |window| 
			window.x = 32
			window.viewport = @savefile_viewport
		end
		addLoadOption($game_text["menu:system/autosave"],"autoE") if DataManager.saveFileExistsAUTO_E?
		addLoadOption($game_text["menu:system/autosave"],"autoS") if DataManager.saveFileExistsAUTO_S?
		addLoadOption($game_text["menu:system/DoomCoreMode_Load0"],"doom") if DataManager.saveFileExistsDOOM?
	end
	
	def addLoadOption(tmpText,tmpSaveType)
		@currentMax += 1
		@insertedIndex += 1
		@savefile_windows << Window_SaveFile.new(savefile_height,@currentMax-1)
		@savefile_windows.last.viewport = @savefile_viewport
		@savefile_windows.last.opacity = 0
		@savefile_windows.last.contents.font.size = 24
		@savefile_windows.last.draw_text(58, 20, 200, 30,tmpText, 2)
		case tmpSaveType
			when "autoE"
				@indexAutosaveE = @currentMax
				modification_time = File.mtime(DataManager.userDataPath_FileSaveAuto_E)
				tmpText = modification_time.strftime('%Y-%m-%d %H:%M:%S')
				@savefile_windows.last.contents.font.size = 16
				@savefile_windows.last.draw_text(6, 24, 200, 30,tmpText, 0)
			when "autoS"; @indexAutosaveS = @currentMax
				modification_time = File.mtime(DataManager.userDataPath_FileSaveAuto_S)
				tmpText = modification_time.strftime('%Y-%m-%d %H:%M:%S')
				@savefile_windows.last.contents.font.size = 16
				@savefile_windows.last.draw_text(6, 24, 200, 30,tmpText, 0)
			when "doom"; @indexDoomsave = @currentMax
				modification_time = File.mtime(DataManager.userDataPath_FileSaveDoom)
				tmpText = modification_time.strftime('%Y-%m-%d %H:%M:%S')
				@savefile_windows.last.contents.font.size = 16
				@savefile_windows.last.draw_text(6, 24, 200, 30,tmpText, 0)
		end
	end
	
	def top_index=(index)
		index = 0 if index < 0
		index = @currentMax - visible_max if index > @currentMax - visible_max
		@savefile_viewport.oy = index * savefile_height
	end
	
	def cursor_down(wrap)
		@index = (@index + 1) % @currentMax if @index < @currentMax - 1 || wrap
		ensure_cursor_visible
	end
	def cursor_up(wrap)
		@index = (@index - 1 + @currentMax) % @currentMax if @index > 0 || wrap
		ensure_cursor_visible
	end
	
	def cursor_pagedown
		if top_index + visible_max < @currentMax
		self.top_index += visible_max
		@index = [@index + visible_max, @currentMax - 1].min
		end
	end
	#--------------------------------------------------------------------------
	# * Get Help Window Text
	#--------------------------------------------------------------------------
	def help_window_text
		Vocab::LoadMessage
	end

	#--------------------------------------------------------------------------
	# * Get File Index to Select First
	#--------------------------------------------------------------------------
	def first_savefile_index
		DataManager.latest_savefile_index
	end
	#--------------------------------------------------------------------------
	# * Confirm Save File
	#--------------------------------------------------------------------------
	def on_savefile_ok
		return if createModWarning_created  #i think i need hack input
		return createModWarning(mode = "game_clearn_save_modded") if !createModWarning_created && !@mod_infested_window_poped && @gameModData.empty? && !@savefile_windows[@index].modded_data.empty? #Save is infested by mod
		return createModWarning(mode = "game_modded_save_clearn") if !createModWarning_created && !@mod_infested_window_poped && !@gameModData.empty? && @savefile_windows[@index].modded_data.empty? #game is modded but save is clearn
		return createModWarning(mode = "both_modded_but_dismatch") if !createModWarning_created && !@mod_infested_window_poped && !@gameModData.empty? && !@savefile_windows[@index].modded_data.empty? && @gameModData != @savefile_windows[@index].modded_data #Mod Dismatch


		return SceneManager.scene.gotoLoadCustomScene("SavAutoE") if @index+1 == @indexAutosaveE
		return SceneManager.scene.gotoLoadCustomScene("SavAutoS") if @index+1 == @indexAutosaveS
		return SceneManager.scene.gotoLoadCustomScene("SavDoomMode") if @index+1 == @indexDoomsave
		super
		if DataManager.load_game(@index)
			on_load_success
		else
			SndLib.sys_buzzer
		end
	end

################################################################ MESSY FLOP, should make it in a scene like doomload,   not like this.  but it woeks

	def refresh_cursor(last_index,current_index)
		return if createModWarning_created
		@mod_infested_window_poped = nil
		#createModWarning_dispose
		super
	end
	def update_savefile_selection
		#if createModWarning_created
		#	return unless (Mouse.enable? && (Input.trigger?(:MZ_LINK) || Input.trigger?(:MX_LINK))) || (Input.trigger?(:C) || Input.trigger?(:B))
		#	createModWarning_dispose
		#	return
		#end
		if createModWarning_created
			return @mod_infested_window_input_delay += 1 if @mod_infested_window_input_delay_max >= @mod_infested_window_input_delay
			@mod_infested_window_start_fade = true if Input.trigger?(:MZ_LINK) || Input.trigger?(:MX_LINK) || Input.trigger?(:C) || Input.trigger?(:B) || WolfPad.trigger?(:X_LINK) || WolfPad.trigger?(:Z_LINK)
			if createModWarning_created && @mod_infested_window_start_fade && @mod_warning_sprite.opacity > 0
				if !@mod_infested_window_confirmed_snd_played && @mod_warning_sprite.opacity > 250
					@mod_infested_window_confirmed_snd_played = true
					SndLib.sound_HumanRoar(90,60)
				end
				@mod_warning_sprite_back.opacity -= 25
				@mod_warning_sprite.opacity -= 25
			elsif createModWarning_created && @mod_infested_window_start_fade && @mod_warning_sprite.opacity <= 0
				createModWarning_dispose
			end
			return
		end
		super
	end
	def update_cursor
		return if createModWarning_created
		super
	end
	#def update
	#	if createModWarning_created && @mod_warning_sprite.opacity > 0
	#		@mod_warning_sprite_back.opacity -= 20
	#		@mod_warning_sprite.opacity -= 20
	#	end
	#	super
	#end
##################### save warning window
	def createModWarning_dispose
		@mod_warning_sprite_back.dispose if @mod_warning_sprite_back
		@mod_warning_sprite.dispose if @mod_warning_sprite
		@mod_warning_sprite = nil
		@mod_warning_sprite_back = nil
		#@mod_infested_window_poped = nil
	end
	def createModWarning_created
		@mod_warning_sprite && @mod_warning_sprite_back
	end

	def createModWarning(mode)
		SndLib.sound_HumanRoar(100)
		@mod_infested_window_poped = true
		@mod_infested_window_start_fade = false
		@mod_infested_window_confirmed_snd_played = false
		@mod_infested_window_input_delay = 0
		@mod_infested_window_input_delay_max = 5
		@mod_warning_sprite_back = Sprite.new
		@mod_warning_sprite_back.bitmap = Cache.load_bitmap("Graphics/System/","chat_window_black_area50")
		@mod_warning_sprite_back.z = 1+ System_Settings::SCENE_Menu_Cursor_Z

		@mod_warning_sprite = Sprite.new
		@mod_warning_sprite.bitmap = Bitmap.new(Graphics.width, Graphics.height)
		@mod_warning_sprite.z = @mod_warning_sprite_back.z + 1
		tmpXYfix = 20

		bmp = @mod_warning_sprite.bitmap
		bmp.font.outline=false
		bmp.font.size = 40
		#bmp.font.color.set(255,125,125,255)
		bmp.font.color.set(255,255,255,255)
		bmp.draw_text(70,35+tmpXYfix, 500,48,$game_text["menu:system/DoomCoreMode_Load1"],1)
		bmp.font.size = 30
		#bmp.font.color.set(255,255,125,255)
		bmp.font.color.set(255,255,255,255)
		bmp.draw_text(50,80+tmpXYfix,540,36,$game_text["menu:mod/ModDismatch1"],1)
		bmp.font.size = 20
		line_height = 20
		starting_Y = 124
		ext_text = "!!"
		case mode
			when "game_clearn_save_modded"
				bmp.font.color.set(255,0,0,255)
				bmp.draw_text(50,starting_Y+(line_height*0)+tmpXYfix,540,36,ext_text+"game_clearn_save_modded"+ext_text,1)
				bmp.font.color.set(255,255,255,128)
				bmp.draw_text(50,starting_Y+(line_height*1)+tmpXYfix,540,36,"game_modded_save_clearn",1)
				bmp.font.color.set(255,255,255,128)
				bmp.draw_text(50,starting_Y+(line_height*3)+tmpXYfix,540,36,"both_modded_but_dismatch",1)
			when "game_modded_save_clearn"
				bmp.font.color.set(255,255,255,128)
				bmp.draw_text(50,starting_Y+(line_height*0)+tmpXYfix,540,36,"game_clearn_save_modded" ,1)
				bmp.font.color.set(255,0,0,255)
				bmp.draw_text(50,starting_Y+(line_height*1)+tmpXYfix,540,36,ext_text+"game_modded_save_clearn"+ext_text,1)
				bmp.font.color.set(255,255,255,128)
				bmp.draw_text(50,starting_Y+(line_height*2)+tmpXYfix,540,36,"both_modded_but_dismatch",1)
			when "both_modded_but_dismatch"
				bmp.font.color.set(255,255,255,128)
				bmp.draw_text(50,starting_Y+(line_height*0)+tmpXYfix,540,36,"game_clearn_save_modded",1)
				bmp.font.color.set(255,255,255,128)
				bmp.draw_text(50,starting_Y+(line_height*1)+tmpXYfix,540,36,"game_modded_save_clearn",1)
				bmp.font.color.set(255,0,0,255)
				bmp.draw_text(50,starting_Y+(line_height*2)+tmpXYfix,540,36,ext_text+"both_modded_but_dismatch"+ext_text,1)
		end
		bmp.font.size = 24
		#bmp.font.color.set(255,125,125,255)
		bmp.font.color.set(255,255,255,255)
		bmp.draw_text(50,starting_Y+(line_height*4)+tmpXYfix,540,36,$game_text["menu:mod/ModDismatch2"],1)
#
		#bmp.font.outline=false
		#bmp.font.size = 22
		#bmp.font.color = Color.new(0,255,0)
		#bmp.draw_text(238,208+tmpXYfix,166,42,InputUtils.getKeyAndTranslate(:C),0)
		#bmp.font.color = Color.new(255,255,0)
		#bmp.draw_text(238,208+tmpXYfix,166,42,InputUtils.getKeyAndTranslate(:B),2)
		#bmp.font.color = Color.new(255,255,255)
		#bmp.font.size = 20
		#bmp.draw_text(238,230+tmpXYfix,166,42,$game_text["DataInput:Key/Confirm"],0)
		#bmp.draw_text(238,230+tmpXYfix,166,42,$game_text["DataInput:Key/Cancel"],2)

	end
	#--------------------------------------------------------------------------
	# * Processing When Load Is Successful
	#--------------------------------------------------------------------------
	def on_load_success
		$story_stats["record_GameLoaded"] += 1 if $story_stats["Setup_Hardcore"] < 2
		$titleCreateActorReq = true
		SceneManager.clear_PrevTitle_index_rec
		SndLib.sys_LoadGame
		fadeout_all
		$game_system.on_after_load
		SceneManager.goto(Scene_Map)
		$game_player.refresh_chs
		#$game_player.actor.portrait.refresh # already in $game_player.refresh_chs
		$game_player.actor.portrait.update
	end

	def on_savefile_cancel
		SndLib.sys_cancel
		SceneManager.goto(Scene_MapTitle)
	end
	def terminate
		@mod_warning_sprite_back.dispose if @mod_warning_sprite_back
		@mod_warning_sprite.dispose if @mod_warning_sprite
		super
	end
end

class Scene_Load_OnGameMenu < Scene_Load
	def on_savefile_cancel
		SndLib.sys_cancel
		SceneManager.goto(Scene_Menu)
	end
	def on_load_success
		Cache.clear
		super
		weather_recover_data
	end
end
