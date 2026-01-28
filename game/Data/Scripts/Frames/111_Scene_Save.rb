#==============================================================================
# ** Scene_Save
#------------------------------------------------------------------------------
#  This class performs save screen processing. 
#==============================================================================

class Scene_Save < Scene_File
  #--------------------------------------------------------------------------
  # * Get Help Window Text
  #--------------------------------------------------------------------------
  def help_window_text
    Vocab::SaveMessage
  end
  #--------------------------------------------------------------------------
  # * Get File Index to Select First
  #--------------------------------------------------------------------------
  def first_savefile_index
    DataManager.last_savefile_index
  end
  #--------------------------------------------------------------------------
  # * Confirm Save File
  #--------------------------------------------------------------------------
	def on_savefile_ok
		super
		return SndLib.sys_buzzer if $story_stats["Setup_Hardcore"] >= 2
		$game_player.drop_light
		$game_map.viewport1=nil
		if DataManager.save_game(@index)
			on_save_success
		else
			SndLib.sys_buzzer
		end
	end
  #--------------------------------------------------------------------------
  # * Processing When Save Is Successful
  #--------------------------------------------------------------------------
	def on_save_success
		SndLib.WoodenBuild
		SceneManager.goto(Scene_Menu)
	end
  
  def on_savefile_cancel
    SndLib.sys_cancel
    SceneManager.goto(Scene_Menu)
  end
end

  #--------------------------------------------------------------------------
  # * AUTO
  #--------------------------------------------------------------------------