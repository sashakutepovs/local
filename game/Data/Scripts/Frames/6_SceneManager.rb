#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
#==============================================================================
# ** SceneManager
#------------------------------------------------------------------------------
#  This module manages scene transitions. For example, it can handle
# hierarchical structures such as calling the item screen from the main menu
# or returning from the item screen to the main menu.
#==============================================================================

module SceneManager
	#--------------------------------------------------------------------------
	# * Module Instance Variables
	#--------------------------------------------------------------------------
	@scene = nil 								# current scene object
	@stack = []									# stack for hierarchical transitions
	@background_bitmap = nil					# background bitmap
	@prevOptChoose = nil						# last option between scene
	@prevTitleOptChoose = nil						# last option Only in Title OPT
	#--------------------------------------------------------------------------
	# * Execute
	#--------------------------------------------------------------------------
	def self.run
		DataManager.init
		#Audio.setup_midi if use_midi?
		@scene = first_scene_class.new
		@scene.main while @scene
	end
  #--------------------------------------------------------------------------
  # * setOPT 
  #--------------------------------------------------------------------------
  def self.first_scene_class
    Scene_Title
  end
  
  def self.prevOptChoose # ingame menu saved index & for game title
		@prevOpt_saved_index
  end
  def self.prevOptChooseSet(tmpVal) # ingame menu saved index & for game title
		@prevOpt_saved_index = tmpVal
  end
  def self.prevTitleOptChoose  #titleOption saved index for keybinding menu
	  @prevTitleOpt_saved_index
  end
  def self.prevTitleOptChooseSet(tmpVal) #titleOption saved index for keybinding menu
		@prevTitleOpt_saved_index = tmpVal
  end
  def self.prevTitleOpt_TopIndex #titleOption saved index for keybinding menu
	  @prevTitleOpt_saved_TopIndex
  end
  def self.prevTitleOpt_TopIndex_set(tmpVal) #titleOption saved index for keybinding menu
	  @prevTitleOpt_saved_TopIndex = tmpVal
  end
  def self.clear_PrevTitle_index_rec
	  @prevTitleOpt_saved_TopIndex = nil
	  @prevTitleOpt_saved_index = nil
	  @prevOpt_saved_index = nil
  end
  #--------------------------------------------------------------------------
  # * Use MIDI?
  #--------------------------------------------------------------------------
  def self.use_midi?
    false
  end
  #--------------------------------------------------------------------------
  # * Get Current Scene
  #--------------------------------------------------------------------------
  def self.scene
    @scene
  end
  #--------------------------------------------------------------------------
  # * Determine Current Scene Class
  #--------------------------------------------------------------------------
  def self.scene_is?(scene_class)
    @scene.instance_of?(scene_class)
  end
  #--------------------------------------------------------------------------
  # * Direct Transition
  #--------------------------------------------------------------------------
  def self.goto(scene_class)
    @scene = scene_class.new
  end
  #--------------------------------------------------------------------------
  # * Call
  #--------------------------------------------------------------------------
	def self.call(scene_class)
		msgbox "fucking return #{@scene}"
		@stack.push(@scene)
		@scene = scene_class.new
	end
  #--------------------------------------------------------------------------
  # * Return to Caller
  #--------------------------------------------------------------------------
	def self.return
		msgbox "fucking return #{@scene}"
		@scene = @stack.pop
	end
  #--------------------------------------------------------------------------
  # * Clear Call Stack
  #--------------------------------------------------------------------------
  def self.clear
    @stack.clear
  end
  #--------------------------------------------------------------------------
  # * Exit Game
  #--------------------------------------------------------------------------
  def self.exit
    @scene = nil
  end
  #--------------------------------------------------------------------------
  # * Create Snapshot to Use as Background
  #--------------------------------------------------------------------------
  def self.snapshot_for_background(blur=true)
    @background_bitmap.dispose if @background_bitmap
    @background_bitmap = Graphics.snap_to_bitmap
    @background_bitmap.blur if blur
  end
  #--------------------------------------------------------------------------
  # * Get Background Bitmap
  #--------------------------------------------------------------------------
  def self.background_bitmap
    @background_bitmap
  end
  
end
