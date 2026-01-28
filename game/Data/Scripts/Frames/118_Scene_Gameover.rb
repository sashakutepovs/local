#==============================================================================
# ** Scene_Gameover
#------------------------------------------------------------------------------
#  This class performs game over screen processing.
#==============================================================================

class Scene_Gameover < Scene_Base
  #--------------------------------------------------------------------------
  # * Start Processing
  #--------------------------------------------------------------------------
	def start
		super
		$cg.erase
		$bg.erase
		play_gameover_music
		fadeout_frozen_graphics
		create_background
		$game_map.interpreter.chcg_background_color_off
		create_hint 
	end
  #--------------------------------------------------------------------------
  # * Termination Processing
  #--------------------------------------------------------------------------
  def terminate
	@spritePress.dispose
	@spriteZ.dispose
	@spriteContinue.dispose
	super
	dispose_background
  end
  
  
	def create_hint
		spriteSize = 300
		spriteLineH = 20
		spriteH = Graphics.height
		spriteHTar = (spriteH*0.6).round
		spriteXTar=Graphics.width/2 - spriteSize/2
		@spriteOpa = 0
		@spriteUp = true
		
		@spritePress						=Sprite.new
		@spritePress.bitmap					=Bitmap.new(spriteSize, 50)
		@spritePress.bitmap.font.size 		= 24
		@spritePress.bitmap.font.bold 		= true
		@spritePress.bitmap.font.outline	= false
		@spritePress.x		=spriteXTar-2
		@spritePress.y		=spriteHTar+spriteLineH*1
		@spritePress.z		=System_Settings::SCENE_Menu_ContentBase_Z
		@spritePress.opacity		=@spriteOpa
		@spritePress.bitmap.draw_text(0,0	,spriteSize,50,	$game_text["menu:GameOver/Press"],1)
		
		@spriteZ							=Sprite.new
		@spriteZ.bitmap						=Bitmap.new(spriteSize, 50)
		@spriteZ.bitmap.font.size 			= 30
		@spriteZ.bitmap.font.bold 			= true
		@spriteZ.bitmap.font.outline		= false
		@spriteZ.bitmap.font.color			=Color.new(60,255,60)
		@spriteZ.x		=spriteXTar-2
		@spriteZ.y		=spriteHTar+spriteLineH*2
		@spriteZ.z		=System_Settings::SCENE_Menu_ContentBase_Z
		@spriteZ.opacity		=@spriteOpa
		@spriteZ.bitmap.draw_text(0,0	,spriteSize,50,	$game_text[InputUtils.getKeyAndTranslateLong(:C)],1)
		@spriteContinue						=Sprite.new
		@spriteContinue.bitmap				=Bitmap.new(spriteSize, 50)
		@spriteContinue.bitmap.font.size 	= 24
		@spriteContinue.bitmap.font.bold 	= true
		@spriteContinue.bitmap.font.outline	= false
		@spriteContinue.x		=spriteXTar-2
		@spriteContinue.y		=spriteHTar+spriteLineH*3
		@spriteContinue.z		=System_Settings::SCENE_Menu_ContentBase_Z
		@spriteContinue.opacity		=@spriteOpa
		@spriteContinue.bitmap.draw_text(0,0	,spriteSize,50,	$story_stats["GameOverGood"] == 1 ? $game_text["menu:GameOver/Continue_good"] : $game_text["menu:GameOver/Continue_bad"],1)
	end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
	def update
		@spriteOpa -= 5 if !@spriteUp
		@spriteOpa += 5 if @spriteUp
		
		@spriteUp = false if @spriteOpa >= 255
		@spriteUp = true if @spriteOpa <= 200
		
		@spritePress.opacity = @spriteOpa
		@spriteZ.opacity = @spriteOpa
		@spriteContinue.opacity = @spriteOpa
		super 
		if Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK) || Input.trigger?(:MX_LINK) || Input.trigger?(:MZ_LINK)
			goto_title
		end
	end
  #--------------------------------------------------------------------------
  # * Execute Transition
  #--------------------------------------------------------------------------
  def perform_transition
    Graphics.transition(fadein_speed)
  end
  #--------------------------------------------------------------------------
  # * Play Music on Game Over Screen
  #--------------------------------------------------------------------------
  def play_gameover_music
    RPG::BGM.stop
    RPG::BGS.stop
    SndLib.me_play("ME/Mystery",80,100)
  end
  #--------------------------------------------------------------------------
  # * Fade Out Frozen Graphics
  #--------------------------------------------------------------------------
  def fadeout_frozen_graphics
    Graphics.transition(fadeout_speed)
    Graphics.freeze
  end
  #--------------------------------------------------------------------------
  # * Create Background
  #--------------------------------------------------------------------------
	def create_background
		@sprite = Sprite.new
		@sprite.z = System_Settings::SCENE_BASE_Z
		@sprite.bitmap = $story_stats["GameOverGood"] == 1 ? Cache.system("GameOver_good") : Cache.system("GameOver_bad")
	end
  #--------------------------------------------------------------------------
  # * Free Background
  #--------------------------------------------------------------------------
  def dispose_background
    @sprite.bitmap.dispose
    @sprite.dispose
  end
  #--------------------------------------------------------------------------
  # * Get Fade Out Speed
  #--------------------------------------------------------------------------
  def fadeout_speed
    return 60
  end
  #--------------------------------------------------------------------------
  # * Get Fade In Speed
  #--------------------------------------------------------------------------
  def fadein_speed
    return 120
  end
  #--------------------------------------------------------------------------
  # * Transition to Title Screen
  #--------------------------------------------------------------------------
	def goto_title
		case rand(3)
			when 0 ; SndLib.sound_OrcSpot(95)
			when 1 ; SndLib.sound_MaleWarriorSpot(95)
			when 2 ; SndLib.sound_UndeadQuestion(95)
		end
		fadeout_all
		if $story_stats["GameOverGood"] == 1
			SceneManager.goto(Scene_Credits)
		elsif $inheritance
			DataManager.setup_new_game(true,"NoerSewer")
			$inheritance = nil
			SceneManager.goto(Scene_Map)
			GabeSDK.getAchievement("Rebirth")
		else
			SceneManager.goto(Scene_Title)
		end
	end
end
