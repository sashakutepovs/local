#==============================================================================
# ** Scene_Base
#------------------------------------------------------------------------------
#  This is a super class of all scenes within the game.
#==============================================================================

class Scene_Base
  attr_accessor :spriteset
  #--------------------------------------------------------------------------
  # * Main
  #--------------------------------------------------------------------------
  def main	
	#p "#{self.class} starting.     SceneManager.scene=>#{SceneManager.scene.class} TIME=#{Time.now.strftime("%Y%m%d  %H:%M:%S-%L")}"
	start
	post_start
	update until scene_changing?
	pre_terminate
	terminate
	#Input.clear_keyboard_state
  end
  #--------------------------------------------------------------------------
  # * Start Processing
  #--------------------------------------------------------------------------
  def start
    create_main_viewport
  end
  #--------------------------------------------------------------------------
  # * Post-Start Processing
  #--------------------------------------------------------------------------
  def post_start
    perform_transition
    Input.update
  end
  #--------------------------------------------------------------------------
  # * Determine if Scene Is Changing
  #--------------------------------------------------------------------------
  def scene_changing?
    SceneManager.scene != self
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
	def update
		update_basic
		trigger_debug_window_entry #520_YanflyF10.rb
		mouse_cursor_update #560_Mouse_Support.rb
	end
  #--------------------------------------------------------------------------
  # * Update Frame (Basic)
  #--------------------------------------------------------------------------
	def update_basic
		Graphics.update
		Input.update
		update_all_windows
		updateAchievement #no more gabe
	end
	
  #--------------------------------------------------------------------------
  # * Achievement Bullshit
  #--------------------------------------------------------------------------
	def updateAchievement
		return if !@achNeedUpdate
		@achTime -= 1
		if @achTime <= 0
			@achNeedUpdate = false
			@tmpSprite.dispose
		elsif @achTime <= 100
			@tmpSprite.y -= 3
		else
			@tmpSprite.y += 4 unless @tmpSprite.y >= 5
		end
	end
	
	def achievementPopup(tmpTop="",tmpBot="",tmpTime=300,achIcon=nil)
		@tmpSprite.dispose if @tmpSprite
		tmpGW = Graphics.width/3
		tmpGH = Graphics.height/3
		@achNeedUpdate = true
		@achTime = tmpTime
		@tmpSprite=Sprite.new
		@tmpSprite.bitmap	=Bitmap.new(tmpGW,tmpGH)
		@tmpSprite.x = 5+Graphics.width/2 - tmpGW/2
		@tmpSprite.y = -50
		@tmpSprite.z = System_Settings::SCENE_AchievementPopup_Z
		@tmpSprite.bitmap=Bitmap.new("Graphics/System/AchUlk.png")
		if achIcon
			png_loc = GabeSDK.GetACHlist[achIcon.to_sym][3] ? GabeSDK.GetACHlist[achIcon.to_sym][3] : "Graphics/System/ACH/"
			@tmpSprite.bitmap.blt(5 , 5 ,Bitmap.new("#{png_loc}#{achIcon}.png"),Rect.new(0, 0, 32, 32))
		end
		@tmpSprite.bitmap.font.size = 16
		@tmpSprite.bitmap.font.bold = true
		@tmpSprite.bitmap.font.outline = false
		@tmpSprite.bitmap.font.color=Color.new(255,255,0,255)
		@tmpSprite.bitmap.draw_text(16,-2, tmpGW,25,tmpTop,1)
		@tmpSprite.bitmap.font.size = 18
		@tmpSprite.bitmap.font.color=Color.new(125,255,0,255)
		@tmpSprite.bitmap.draw_text(16,17, tmpGW,25,tmpBot,1)
	end
	
	#for unlock
	def achievementGet(tmpAchName="",tmpIcon=nil)
		SndLib.sys_Achievement(80)
		achievementPopup("Achievement unlocked",tmpAchName,300,achIcon=tmpIcon)
	end
	
	#for make progress
	def achievementSetStat(tmpProg="")
		SndLib.sys_Achievement(60,200)
		achievementPopup("Achievement Progress",tmpProg,180)
	end
  
  #--------------------------------------------------------------------------
  # * Pre-Termination Processing
  #--------------------------------------------------------------------------
  def pre_terminate
  end
  #--------------------------------------------------------------------------
  # * Termination Processing
  #--------------------------------------------------------------------------
  def terminate
    Graphics.freeze
    dispose_all_windows
    dispose_main_viewport
  end
  #--------------------------------------------------------------------------
  # * Execute Transition
  #--------------------------------------------------------------------------
  def perform_transition
    Graphics.transition(transition_speed)
  end
  #--------------------------------------------------------------------------
  # * Get Transition Speed
  #--------------------------------------------------------------------------
  def transition_speed
    return 10
  end
  #--------------------------------------------------------------------------
  # * Create Viewport
  #--------------------------------------------------------------------------
  def create_main_viewport
    @viewport = Viewport.new
    @viewport.z = System_Settings::SCENE_BASE_Z
  end
  #--------------------------------------------------------------------------
  # * Free Viewport
  #--------------------------------------------------------------------------
  def dispose_main_viewport
    @viewport.dispose
  end
  #--------------------------------------------------------------------------
  # * Update All Windows
  #--------------------------------------------------------------------------
  def update_all_windows
    instance_variables.each do |varname|
      ivar = instance_variable_get(varname)
      ivar.update if ivar.is_a?(Window)
    end
  end
  #--------------------------------------------------------------------------
  # * Free All Windows
  #--------------------------------------------------------------------------
  def dispose_all_windows
    instance_variables.each do |varname|
      ivar = instance_variable_get(varname)
      ivar.dispose if ivar.is_a?(Window)
    end
  end
  #--------------------------------------------------------------------------
  # * Return to Calling Scene
  #--------------------------------------------------------------------------
  def return_scene
	msgbox "its a fucking scene return again"
    SceneManager.return
  end
  def return_map
    SceneManager.goto(Scene_Map)
  end
  #--------------------------------------------------------------------------
  # * Fade Out All Sounds and Graphics
  #--------------------------------------------------------------------------
  def fadeout_all(time = 1000)
    RPG::BGM.fade(time)
    RPG::BGS.fade(time)
    RPG::ME.fade(time)
    Graphics.fadeout(time * Graphics.frame_rate / 1000)
    RPG::BGM.stop
    RPG::BGS.stop
    RPG::ME.stop
  end
  #--------------------------------------------------------------------------
  # * Determine if Game Is Over
  #   Transition to the game over screen if the entire party is dead.
  #--------------------------------------------------------------------------
	def check_gameover
		SceneManager.goto(Scene_Gameover) if $game_party.all_dead?
	end
  
  
	def gotoLoadCustomScene(tmpFile)
		DataManager.customLoadNameSet(tmpFile)
		SceneManager.goto(Scene_CustomModeLoad)
	end
end
