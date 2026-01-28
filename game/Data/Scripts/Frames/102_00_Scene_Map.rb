#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================

# [102] 29223633: Scene_Map
#==============================================================================
# ** Scene_Map
#------------------------------------------------------------------------------
#  This class performs the map screen processing.
#==============================================================================

class Scene_Map < Scene_Base
	
	attr_accessor :hud
	attr_accessor :spriteset
  #--------------------------------------------------------------------------
  # * Start Processing
  #--------------------------------------------------------------------------
	def start
		super
		$game_player.straighten
		$game_map.refresh
		$game_player.light_check
		$game_message.visible = false
		create_spriteset
		create_all_windows
		Cache.clear_chs_material
		@hud = Map_Hud.new
		@hud.hide if $hudForceHide
	end
  

  #--------------------------------------------------------------------------
  # * Execute Transition
  #    Performs a fade in when the screen has been blacked out, such as
  #    immediately after a battle or load. 
  #--------------------------------------------------------------------------
	def perform_transition
		if Graphics.brightness == 0
			Graphics.transition(0)
			fadein(fadein_speed)
		else
			super
		end
	end
  #--------------------------------------------------------------------------
  # * Get Transition Speed
  #--------------------------------------------------------------------------
  def transition_speed
    return 15
  end
  
  
  #--------------------------------------------------------------------------
  # * Pre-Termination Processing
  #--------------------------------------------------------------------------
  def pre_terminate
    super
    pre_title_scene  if SceneManager.scene_is?(Scene_Title)
  end
  #--------------------------------------------------------------------------
  # * Termination Processing
  #--------------------------------------------------------------------------
	def terminate
		SceneManager.snapshot_for_background(false)
		super
		$game_portraits.hide_all_portraits(true)
		dispose_spriteset
		@hud.dispose
		Graphics.frame_rate = 60 ######### for frameBulletSkip
	end
  
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
	def update
		super
		$game_map.update(true)
		$game_player.update
		$game_timer.update
		@spriteset.update
		$game_portraits.update
		update_call_menu if Input.trigger?(:B)
		update_map_hud_input
		frameBulletSkip
	end

	def update_map_hud_input
		if Input.press?(:ALT) || $hudForceHide
			@hud.hide
		else
			@hud.show
		end
		@hud.refresh
	end
	
	def frameBulletSkip
		if Input.checkHoldAllFunctionKeys?
			Graphics.frame_rate = 120
		elsif Graphics.frame_rate != 60
			Graphics.frame_reset
			Graphics.frame_rate = 60
		end
	end
  #--------------------------------------------------------------------------
  # * Determine if Scene Transition Is Possible
  #--------------------------------------------------------------------------
  #--------------------------------------------------------------------------
  # * Update Scene Transition
  #--------------------------------------------------------------------------
  def update_scene
  end
  #--------------------------------------------------------------------------
  # * Update Frame (for Fade In)
  #--------------------------------------------------------------------------
  def update_for_fade
    update_basic
    $game_map.update(false)
    @spriteset.update
  end
  #--------------------------------------------------------------------------
  # * General-Purpose Fade Processing
  #--------------------------------------------------------------------------
  def fade_loop(duration)
	#$game_temp.exec_setup_stage
    duration.times do |i|
      yield 255 * (i + 1) / duration
      update_for_fade
    end
  end
  #--------------------------------------------------------------------------
  # * Fadein Screen
  #--------------------------------------------------------------------------
  def fadein(duration)
    fade_loop(duration) {|v| Graphics.brightness = v;}
  end
  #--------------------------------------------------------------------------
  # * Fadeout Screen
  #--------------------------------------------------------------------------
  def fadeout(duration)
    fade_loop(duration) {|v| Graphics.brightness = 255 - v }
  end
  #--------------------------------------------------------------------------
  # * Screen Fade In (White)
  #--------------------------------------------------------------------------
  def white_fadein(duration)
    fade_loop(duration) {|v| @viewport.color.set(255, 255, 255, 255 - v) }
  end
  #--------------------------------------------------------------------------
  # * Screen Fade Out (White)
  #--------------------------------------------------------------------------
  def white_fadeout(duration)
    fade_loop(duration) {|v| @viewport.color.set(255, 255, 255, v) }
  end
  #--------------------------------------------------------------------------
  # * Create Sprite Set
  #--------------------------------------------------------------------------
  def create_spriteset
    @spriteset = Spriteset_Map.new
  end
  #--------------------------------------------------------------------------
  # * Free Sprite Set
  #--------------------------------------------------------------------------
  def dispose_spriteset
    @spriteset.dispose
    $game_map.dispose_popup
  end
  #--------------------------------------------------------------------------
  # * Create All Windows
  #--------------------------------------------------------------------------
  def create_all_windows
    create_message_window
    create_scroll_text_window
    create_location_window
  end
  #--------------------------------------------------------------------------
  # * Create Message Window
  #--------------------------------------------------------------------------
  def create_message_window
    @message_window = Window_Message.new
  end
  #--------------------------------------------------------------------------
  # * Create Scrolling Text Window
  #--------------------------------------------------------------------------
  def create_scroll_text_window
    @scroll_text_window = Window_ScrollText.new
  end
  #--------------------------------------------------------------------------
  # * Create Map Name Window
  #--------------------------------------------------------------------------
  def create_location_window
    @map_name_window = Window_MapName.new
  end
  #--------------------------------------------------------------------------
  # * Update Player Transfer
  #--------------------------------------------------------------------------
  def update_transfer_player
    perform_transfer if $game_player.transfer?
  end
  #--------------------------------------------------------------------------
  # * Determine if Menu is Called due to Cancel Button
  #--------------------------------------------------------------------------
	def update_call_menu
		#return unless Input.trigger?(:B) to def update
		return if $game_system.menu_disabled || $game_map.interpreter.running?
		return SndLib.sys_buzzer if ![nil,:none].include?($game_player.actor.action_state)
		return SndLib.sys_buzzer if $game_player.npc_control_mode? && ![nil,:none].include?($game_player.actor.master.actor.action_state)
		return SndLib.sys_buzzer if $game_message.busy? || $game_message.visible
		#return SndLib.sys_buzzer if $game_player.moving?
		if $story_stats["Setup_Hardcore"] >= 2 && $game_map.threat && $game_map.nearTheThreaten?($game_player,8)
			$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
			return SndLib.sys_buzzer
		end
		#callQuickSaveLoad			# nope! fuck save scum
		call_menu
	end

  #--------------------------------------------------------------------------
  # * QuickSave and Load
  #--------------------------------------------------------------------------
  
	def callQuickSaveLoad
		return if $story_stats["Setup_Hardcore"] >= 2
		if Input.trigger?(Input::F5)
			quickSave
		elsif Input.trigger?(Input::F6)
			quickLoad
		end
	end
	def quickSave
		SndLib.WoodenBuild
		SceneManager.scene.dispose_spriteset
		DataManager.save_custom_without_header("SavQuick")
		SceneManager.scene.create_spriteset
	end
	
	def quickLoad
		SceneManager.scene.gotoLoadCustomScene("SavQuick")
	end
	
  #--------------------------------------------------------------------------
  # * Call Menu Screen
  #--------------------------------------------------------------------------

	def call_menu
		$hudForceHide = true
		$hudForceHide = true
		$game_portraits.setRprt("nil")
		SndLib.sys_ok
		SceneManager.goto(Scene_Menu)
		Window_MenuCommand::init_command_position
	end
	
  #--------------------------------------------------------------------------
  # * Player Transfer Processing
  #--------------------------------------------------------------------------
	def perform_transfer
		pre_transfer
		$game_player.perform_transfer
		post_transfer
	end
  #--------------------------------------------------------------------------
  # * Preprocessing for Transferring Player
  #--------------------------------------------------------------------------
  def pre_transfer
    @map_name_window.close
    case $game_temp.fade_type
    when 0
      fadeout(fadeout_speed)
    when 1
      white_fadeout(fadeout_speed)
    end
  end
  #--------------------------------------------------------------------------
  # * Post Processing for Transferring Player
  #--------------------------------------------------------------------------
  def post_transfer
    case $game_temp.fade_type
    when 0
      Graphics.wait(fadein_speed / 2)
      fadein(fadein_speed)
    when 1
      Graphics.wait(fadein_speed / 2)
      white_fadein(fadein_speed)
    end
    @map_name_window.open
  end
  #--------------------------------------------------------------------------
  # * Preprocessing for Battle Screen Transition
  #--------------------------------------------------------------------------
  def pre_battle_scene
    Graphics.update
    Graphics.freeze
    @spriteset.dispose_characters
    BattleManager.save_bgm_and_bgs
    BattleManager.play_battle_bgm
    Sound.play_battle_start
  end
  #--------------------------------------------------------------------------
  # * Preprocessing for Title Screen Transition
  #--------------------------------------------------------------------------
  def pre_title_scene
    fadeout(fadeout_speed_to_title)
  end
  #--------------------------------------------------------------------------
  # * Execute Pre-Battle Transition
  #--------------------------------------------------------------------------
  def perform_battle_transition
    Graphics.transition(60, "Graphics/System/BattleStart", 100)
    Graphics.freeze
  end
  #--------------------------------------------------------------------------
  # * Get Fade Out Speed
  #--------------------------------------------------------------------------
  def fadeout_speed
    return 30
  end
  #--------------------------------------------------------------------------
  # * Get Fade In Speed
  #--------------------------------------------------------------------------
  def fadein_speed
    return 30
  end
  #--------------------------------------------------------------------------
  # * Get Fade Out Speed for Title Screen Transition
  #--------------------------------------------------------------------------
  def fadeout_speed_to_title
    return 60
  end
end
