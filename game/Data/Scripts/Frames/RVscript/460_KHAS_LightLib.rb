#-------------------------------------------------------------------------------
# * [ACE] Khas Ultra Lighting
#-------------------------------------------------------------------------------
# * By Nilo K. (Khas)
# * Version: 1.1
# * Released on: 01.20.2017
#
# * Social Media
# Blog: arcthunder.blogspot.com
# Facebook: facebook.com/khasarc
# Twitter: twitter.com/arcthunder
# Youtube: youtube.com/c/khasarc
#
# * Khas Scripts @ RPG Maker Web forums (official support!)
# forums.rpgmakerweb.com/index.php?/forum/132-khas-scripts
#
#-------------------------------------------------------------------------------
# * Terms of Use
#-------------------------------------------------------------------------------
# Please read the terms of use included with this script. 
# The Khas Ultra Lighting requires the purchase of a license to be used.
# 
#-------------------------------------------------------------------------------
# * Log
#-------------------------------------------------------------------------------
# KUL 1.1 (12.07.2016)
# Khas Graphics Library updated
# Script commands now work with omitted time (instant)
# Fixed [lighting on/off] tag to sync with the switch
# Added F12 reset compatibility
# Added light level: $game_map.shadows.light_level(x, y)
# Added comment tags to override offset
# New add-on: Sticky Jump (use with caution - may not be necessary)
# New add-on: Battle Lighting
# New add-on: Light/Shadow Detector
#
# KUL 1.0 (08.01.2015)
# First release!
#
#-------------------------------------------------------------------------------
# * Requirements
#-------------------------------------------------------------------------------
# 1. Khas Core Library
#    Place the "Khas Core Library" script before KUL.
#
# 2. Khas Graphics Library
#    Place the "Khas Graphics Library" script before KUL.
#
#-------------------------------------------------------------------------------
# * Instructions
#-------------------------------------------------------------------------------
# Please read the Ultra Lighting guide! It's a pdf file inside the demo folder.
#
#-------------------------------------------------------------------------------
# * Light Core (configuration)
#-------------------------------------------------------------------------------
module Light_Core
  
  Lights = { #  <= DO NOT change this!
#-------------------------------------------------------------------------------
# * Lights
#-------------------------------------------------------------------------------
# To create a light, use the following model and paste the code below.
#
# "name" => {
#    :light => "file" / {2 => "file2", 4 => "file4", 6 => "file6", 8 => "file8"},
#    :opacity => a, :variation => b,
#    :static => true/false, :shadows => true/false,
#    :group => "group name",
#    :offset => [ox, oy] / {2=>[ox2,oy2], 4=>[ox4,oy4], 6=>[ox6,oy6], 8=>[[ox8,oy8]}
#  },
# 
#
# You can omit the following to use the defaults:
# :opacity -> 255
# :static -> true
# :shadows -> false
# :group -> no group
# :offset -> [0,0]
#
# 
#
#
# "name" -> Used for identification. Must be between quotation marks, without
#           blank spaces. Can include characters from a to z, 0 to 9 and
#           underlines. Examples:
#           "torch"
#           "1"
#           "light88"
#
# :light -> Light file on Graphics/Lights folder. May be a single file, or
#           a hash containing the file for each direction. Examples:
#
#           :light => "single file",
#
#           :light => {2 => "file2", 4 => "file4", 6 => "file6", 8 => "file8"},
#
#           Where:
#             "file2" -> looking down
#             "file4" -> looking left
#             "file6" -> looking right
#             "file8" -> looking up
#
# :opacity -> Main opacity "a".
# :variation -> "rand(b)" will be added to opacity "a".
#             On each frame, the opacity of a light is:
#             opacity = a + rand(b)
#
# :shadows -> Set to true if the light will cast shadows, false otherwise.
# :static -> Set to true if the light won't move, false otherwise.
#            This option is highly recommended for lights that won't move.
#            It prevents the light to refresh and cast shadows every frame, so 
#            the performance will increase. 
#            A good example is fixed wall lights.
#
# :group ->  The group's name that the light pertains. The light's opacity will 
#            be modified by the group's opacity.
#
# :offset -> Offset for x/y directions. May be a single array, or
#            a hash containing an array for each direction. 
#            OFFSET VALUES MUST BE between -15 and 15 (values out of this range
#            may cast wrong shadows - use at your own risk). Examples: 
#
#           :offset => [ox, oy],
#
#           :offset => {2=>[ox2,oy2], 4=>[ox4,oy4], 6=>[ox6,oy6], 8=>[[ox8,oy8]},
#
#           Where:
#             [ox2, oy2] -> looking down
#             [ox4, oy4] -> looking left
#             [ox6, oy6] -> looking right
#             [ox8, oy8] -> looking up
#
#
#-------------------------------------------------------------------------------
#       ATTENTION! DO NOT FORGET THE COMMAS! - PUT YOUR LIGHTS HERE!
#-------------------------------------------------------------------------------

  "lona_sight" => {
    :light => "lona_sight",
    :opacity => 255, :variation => 0,
    :static => false, :shadows => false,
    :offset => {2=>[0, 16], 4=>[-16, 0], 6=>[16,0], 8=>[0,-16]}
  },
  
    "lantern_player" => {
    :light => "lantern",
    :opacity => 230, :variation => 40,
    :static => false, :shadows => false,
    :offset => {2=>[0,28], 4=>[-28,0], 6=>[28, 0], 8=>[0,-28]}
  },  
  
    "lantern_player_sm" => {
    :light => "lantern",
    :opacity => 165, :variation => 40,
    :static => false, :shadows => false,
    :offset => {2=>[0,28], 4=>[-28,0], 6=>[28, 0], 8=>[0,-28]}
    
  },  
    "lantern" => {
    :light => "lantern",
    :opacity => 170, :variation => 40,
    :static => false, :shadows => false,
    :offset => {2=>[0,28], 4=>[-28,0], 6=>[28, 0], 8=>[0,-28]}
  },
    "lantern_item" => {
    :light => "lantern",
    :opacity => 200, :variation => 40,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
    "lanternSM" => {
    :light => "lanternSM",
    :opacity => 170, :variation => 40,
    :static => true, :shadows => false,
    :offset => {2=>[0,28], 4=>[-28,0], 6=>[28, 0], 8=>[0,-28]}
  },
  
    "lanternSM_item" => {
    :light => "lanternSM",
    :opacity => 170, :variation => 40,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
    "lanternSM_Lpro" => {
    :light => "lanternSM",
    :opacity => 170, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
  
  "simple" => {
    :light => "light",
    :opacity => 255, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
  "big" => {
    :light => "big",
    :opacity => 255, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
  "broken" => {
    :light => "light",
    :opacity => 150, :variation => 100,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
  "torch" => {
    :light => "torch",
    :opacity => 180, :variation => 20,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  "torch_weak" => {
    :light => "torch",
    :opacity => 150, :variation => 20,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
  "blue_torch" => {
    :light => "blue",
    :opacity => 150, :variation => 40,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
  "green_torch_item" => {
    :light => "lanternSM_green",
    :opacity => 100, :variation => 40,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
  "green_torch" => {
    :light => "green",
    :opacity => 150, :variation => 40,
    :static => true, :shadows => false,
    :offset => [0,0]
  },

    "red_torch" => {
    :light => "lanternSM_red",
    :opacity => 215, :variation => 40,
    :static => true, :shadows => false,
    :offset => [0,0]

  },
  
    "red_torch_item" => {
    :light => "lanternSM_red",
    :opacity => 100, :variation => 40,
    :static => true, :shadows => false,
    :offset => [0,0]

  },
  "big_torch" => {
    :light => "big_torch",
    :opacity => 180, :variation => 20,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
  "white" => {
    :light => "white",
    :opacity => 255, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
  "red" => {
    :light => "red",
    :opacity => 255, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
  "green" => {
    :light => "green",
    :opacity => 255, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
  "blue" => {
    :light => "blue",
    :opacity => 255, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
  "violet" => {
    :light => "violet",
    :opacity => 255, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
  "cyan" => {
    :light => "cyan",
    :opacity => 255, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  "cyanTesla" => {
    :light => "cyan",
    :opacity => 0, :variation => 255,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
  "yellow" => {
    :light => "yellow",
    :opacity => true, :variation => 0,
    :static => false, :shadows => false,
    :offset => [0,0]
  },
  
#  "flashlight" => {
#    :light => {2 => "lantern_2", 4 => "lantern_4", 6 => "lantern_6", 8 => "lantern_8"},
#    :opacity => 200, :variation => 10,
#    :static => true, :shadows => false,
#    :offset => {2=>[-6,15], 4=>[-15,-6], 6=>[15,6], 8=>[6,-15]}
#  },
  
#  "window1" => {
#    :light => "window1",
#    :opacity => 255, :variation => 0,
#    :static => true, :shadows => false,
#    :offset => [0,-17]
#  },
#  
#  "window2" => {
#    :light => "window2",
#    :opacity => 255, :variation => 0,
#    :static => true, :shadows => false,
#    :offset => [0,-17]
#  },
#  
#  "window3" => {
#    :light => "window3",
#    :opacity => 255, :variation => 0,
#    :static => true, :shadows => false,
#    :offset => [0,-17]
#  },
#  
#  
#  "window4" => {
#    :light => "window4",
#    :opacity => 255, :variation => 0,
#    :static => true, :shadows => false,
#    :offset => [0,0]
#  },
  
  "red600_5" => {
    :light => "growing_r",
    :opacity => 200, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
    "red600_4" => {
    :light => "growing_r",
    :opacity => 160, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
      "red600_3" => {
    :light => "growing_r",
    :opacity => 120, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
        "red600_2" => {
    :light => "growing_r",
    :opacity => 80, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
        "red600_1" => {
    :light => "growing_r",
    :opacity => 40, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
    "red300_5" => {
    :light => "growing_rs",
    :opacity => 200, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
    "red300_4" => {
    :light => "growing_rs",
    :opacity => 160, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
      "red300_3" => {
    :light => "growing_rs",
    :opacity => 120, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
        "red300_2" => {
    :light => "growing_rs",
    :opacity => 80, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
        "red300_1" => {
    :light => "growing_rs",
    :opacity => 40, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
   
  "green600_5" => {
    :light => "growing_g",
    :opacity => 200, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
    "green600_4" => {
    :light => "growing_g",
    :opacity => 160, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
      "green600_3" => {
    :light => "growing_g",
    :opacity => 120, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
        "green600_2" => {
    :light => "growing_g",
    :opacity => 80, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
        "green600_1" => {
    :light => "growing_g",
    :opacity => 40, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
    "green300_5" => {
    :light => "growing_gs",
    :opacity => 200, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
    "green300_4" => {
    :light => "growing_gs",
    :opacity => 160, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
      "green300_3" => {
    :light => "growing_gs",
    :opacity => 120, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
        "green300_2" => {
    :light => "growing_gs",
    :opacity => 80, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
        "green300_1" => {
    :light => "growing_gs",
    :opacity => 40, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
  
   
  "blue600_5" => {
    :light => "growing_b",
    :opacity => 200, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
    "blue600_4" => {
    :light => "growing_b",
    :opacity => 160, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
      "blue600_3" => {
    :light => "growing_b",
    :opacity => 120, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
        "blue600_2" => {
    :light => "growing_b",
    :opacity => 80, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
        "blue600_1" => {
    :light => "growing_b",
    :opacity => 40, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
    "blue300_5" => {
    :light => "growing_bs",
    :opacity => 250, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
    "blue300_4" => {
    :light => "growing_bs",
    :opacity => 180, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
      "blue300_3" => {
    :light => "growing_bs",
    :opacity => 140, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
        "blue300_2" => {
    :light => "growing_bs",
    :opacity => 80, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
        "blue300_1" => {
    :light => "growing_bs",
    :opacity => 40, :variation => 0,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
    "redfire600_5" => {
    :light => "growing_r",
    :opacity => 200, :variation => 10,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
    "redfire600_4" => {
    :light => "growing_r",
    :opacity => 160, :variation => 10,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
      "redfire600_3" => {
    :light => "growing_r",
    :opacity => 120, :variation => 10,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
        "redfire600_2" => {
    :light => "growing_r",
    :opacity => 80, :variation => 10,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
        "redfire600_1" => {
    :light => "growing_r",
    :opacity => 40, :variation => 10,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
    "redfire300_5" => {
    :light => "growing_rs",
    :opacity => 200, :variation => 10,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
    "redfire300_4" => {
    :light => "growing_rs",
    :opacity => 160, :variation => 10,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
      "redfire300_3" => {
    :light => "growing_rs",
    :opacity => 120, :variation => 10,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
        "redfire300_2" => {
    :light => "growing_rs",
    :opacity => 80, :variation => 10,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
        "redfire300_1" => {
    :light => "growing_rs",
    :opacity => 40, :variation => 10,
    :static => true, :shadows => false,
    :offset => [0,0]
  },
  
  
#-------------------------------------------------------------------------------
# End of light configuration
#------------------------------------------------------------------------------- 
  } #  <= DO NOT change this!
  
  # LIGHT FOLDER
  # You can change the default light folder here (root/Graphics/folder name/).
  Light_Folder = System_Settings::KHAS_Light_Folder
  
  # DISABLE LIGHTS SWITCH
  # Set an switch ID below to temporarily disable light rendering. 
  # If you turn ON this switch, lights won't be rendered.
  #Light_Sw = 999
  
  # DISABLE LIGHTS SWITCH
  # Set an switch ID below to temporarily disable the entire system. 
  # If you turn ON this switch, Ultra Lighting will be disabled.
  UlSys_Sw = 999
  
  # ENABLE SHADOWS
  # Please set this as false if you don't want shadows. By disabling shadows
  # the performance is increased.
  Enable_Shadows = System_Settings::KHAS_Enable_Shadows
  
  # DISABLE STANDARD SHADOWS
  # You may want to disable the standard/automatic shadows from RMVXA.
  # Notice that they will still appear on the editor.
  Disable_STD_Shadows = System_Settings::KHAS_Disable_STD_Shadows
  
  # SHADOW Z COORDINATE
  # You may decrease this if the shadows are overlaying something that they  
  # shouldn't, or increase if they are supposed to overlay something.
  #Shadow_Overlay_Z = 50
  
  # GRAPHICS SETTINGS FILE
  # You can change the default graphics settings file here:
  GS_File = System_Settings::KHAS_GS_File
  
  # GRAPHICS MENU FONT
  # Font name
  GM_Font = System_Settings::MESSAGE_WINDOW_FONT_NAME
  # Font size (title)
  GM_TSize = 32
  # Font size (settings)
  GM_FSize = 18
  # Bold?
  GM_Bold = true
  
end

#-------------------------------------------------------------------------------
# * Requirements
#-------------------------------------------------------------------------------
#
#unless $khas && $khas[:core] >= 1.03
#  warning = Sprite.new
#  warning.bitmap = Bitmap.new(Graphics.width,Graphics.height)
#  warning.bitmap.fill_rect(0,0,Graphics.width,Graphics.height,Color.new(255,255,255))
#  warning.bitmap.font = Font.new("Verdana", 32)
#  warning.bitmap.font.bold = true
#  warning.bitmap.font.outline = false
#  warning.bitmap.font.color.set(255,144,9)
#  warning.bitmap.draw_text(0,Graphics.height/2-32,Graphics.width,32,"PLEASE INSTALL",1)
#  warning.bitmap.draw_text(0,Graphics.height/2,Graphics.width,32,"KHAS CORE LIBRARY 1.03",1)
#  while !Input.trigger?(:C)
#    Input.update
#    Graphics.update
#  end
#  warning.bitmap.dispose
#  warning.dispose
#  exit
#end
#
#unless $khas_graphics[:core] && $khas_graphics[:core] >= 2.0
#  warning = Sprite.new
#  warning.bitmap = Bitmap.new(Graphics.width,Graphics.height)
#  warning.bitmap.fill_rect(0,0,Graphics.width,Graphics.height,Color.new(255,255,255))
#  warning.bitmap.font = Font.new("Verdana", 32)
#  warning.bitmap.font.bold = true
#  warning.bitmap.font.outline = false
#  warning.bitmap.font.color.set(255,144,9)
#  warning.bitmap.draw_text(0,Graphics.height/2-32,Graphics.width,32,"PLEASE INSTALL",1)
#  warning.bitmap.draw_text(0,Graphics.height/2,Graphics.width,32,"KHAS GRAPHICS LIBRARY 2.0",1)
#  while !Input.trigger?(:C)
#    Input.update
#    Graphics.update
#  end
#  warning.bitmap.dispose
#  warning.dispose
#  exit
#end
#
#unless $khas_graphics[:kgl] && $khas_graphics[:kgl] >= 2.0
#  warning = Sprite.new
#  warning.bitmap = Bitmap.new(Graphics.width,Graphics.height)
#  warning.bitmap.fill_rect(0,0,Graphics.width,Graphics.height,Color.new(255,255,255))
#  warning.bitmap.font = Font.new("Verdana", 32)
#  warning.bitmap.font.bold = true
#  warning.bitmap.font.outline = false
#  warning.bitmap.font.color.set(255,144,9)
#  warning.bitmap.draw_text(0,Graphics.height/2-32,Graphics.width,32,"PLEASE INSTALL",1)
#  warning.bitmap.draw_text(0,Graphics.height/2,Graphics.width,32,"KGL2.klib",1)
#  while !Input.trigger?(:C)
#    Input.update
#    Graphics.update
#  end
#  warning.bitmap.dispose
#  warning.dispose
#  exit
#end

#-------------------------------------------------------------------------------
# * Version
#-------------------------------------------------------------------------------

$khas_graphics[:ultra_lighting] = 1.1

#-------------------------------------------------------------------------------
# * Light Core
#-------------------------------------------------------------------------------

module Light_Core
  
  SCShift = 0x02
  SCSize = 0x01 << SCShift
  
end

#-------------------------------------------------------------------------------
# * Graphics Settings
#-------------------------------------------------------------------------------

class Graphics_Settings
  
  include Light_Core
  
  attr_reader :names
  attr_reader :options
  attr_accessor :settings
  
  def initialize
    @names = {}
    @options = {}
    @settings = {}
  end
  
  def add(key, name, default, options)
    @names[key] = name
    @settings[key] = default
    @options[key] = options
    refresh_settings
  end
  
  def refresh_settings
    @settings.each { |s, v| set(s, v) }
  end
    
  def set(setting, value)
  end
  
  def save
=begin
    File.open(GS_File, 'w') do |config|
      @settings.each do |setting, value|
        config.write("[#{setting} #{value}]\n")
      end
    end
=end
  end
  
  def load
    #return unless File.file?(GS_File)
    #File.readlines(GS_File).each do |line|
    #  @settings[line.khas_command.to_sym] = (line.khas_value.is_int? ? line.khas_value.to_i : line.khas_value) if @settings.include?(line.khas_command.to_sym)
    #end
    @settings=System_Settings::KUL_SETTINGS
    refresh_settings
  end
  
end

$kgs = Graphics_Settings.new

#-------------------------------------------------------------------------------
# * Graphics Settings
#-------------------------------------------------------------------------------

class Graphics_Settings
  
  attr_reader :static
  attr_reader :dynamic
  attr_reader :soft_shadows
  attr_reader :light_size
  attr_reader :light_alpha
  
  alias kul_set set
  
  def set_static_light(s)
    return if @static == s
    @static = s
    unless $game_map.nil?
      unless $game_map.lights.nil?
        $game_map.lights.each { |source| source.light.restore if source.light.change_setting? }
      end
    end
  end
  
  def set_dynamic_light(d)
    return if @dynamic == d
    @dynamic = d
    unless $game_map.nil?
      unless $game_map.lights.nil?
        $game_map.lights.each { |source| source.light.restore if source.light.change_setting? }
      end
    end
  end
  
  def set_soft_shadows(s)
    return if @soft_shadows == s
    @soft_shadows = s
    KGL.softShadows(@soft_shadows)
  end
  
  def set_light_size(s)
    return if @light_size == (s.to_f / 100)
    s = 50 if s < 50
    s = 100 if s > 100
    @light_size = s.to_f / 100
    if defined?(Light_Cache)
      Light_Cache.clear
      Light_Cache.build
    end
    unless $game_map.nil?
      unless $game_map.lights.nil?
        $game_map.lights.each { |source| source.light.restore if source.light.change_setting? }
      end
    end
  end
  
  def set_light_alpha(a)
    return if @light_alpha == a
    @light_alpha = a
    KGL.lightBlending(a)
  end
  
  def set(setting, value)
    kul_set(setting, value)
    case setting
      when :static_shadows; set_static_light(value == "ON")
      when :dynamic_shadows; set_dynamic_light(value == "ON")
      when :soft_shadows; set_soft_shadows(value == "ON")
      when :light_size; set_light_size(value)
      when :light_opacity; set_light_alpha(value == "ON")
    end
  end
  
end

#if Light_Core::Enable_Shadows
#  $kgs.add(:static_shadows, "Static Shadows", "ON", ["OFF", "ON"])
#  $kgs.add(:dynamic_shadows, "Dynamic Shadows", "ON", ["OFF", "ON"])
#  $kgs.add(:soft_shadows, "Soft Shadows", "ON", ["OFF", "ON"])
#end
#$kgs.add(:light_size, "Light Size", 100, [70,80,90,100])
#$kgs.add(:light_opacity, "Light Opacity", "ON", ["OFF", "ON"])
$kgs.load

#-------------------------------------------------------------------------------
# * Cache
#-------------------------------------------------------------------------------

module Cache
  
  def self.light(filename)
    load_bitmap("Graphics/#{Light_Core::Light_Folder}/", filename)
  end
  
end

#-------------------------------------------------------------------------------
# * Light Cache
#-------------------------------------------------------------------------------

module Light_Cache
  
  include Light_Core
  
  @@buffer = {}
  
  def self::[](key)
    return @@buffer[key]
  end
  
  def self.build
    for effect in Lights.values
      if effect[:light].is_a?(Hash)
        effect[:light].values.each { |e| Light_Cache.store(e)}
      else
        Light_Cache.store(effect[:light])
      end
    end
  end
  
  def self.clear
    @@buffer.values.each { |b| b.dispose }
    @@buffer.clear
  end
  
  def self.store(key)
    return if @@buffer.keys.include?(key)
    if $kgs.light_size >= 1.0
      @@buffer[key] = Cache.light(key).clone
    else
      source = Cache.light(key)
      sr = Rect.new(0,0,source.width,source.height)
      tr = Rect.new(0,0,source.width*$kgs.light_size,source.height*$kgs.light_size)
      @@buffer[key] = Bitmap.new(tr.width, tr.height)
      @@buffer[key].stretch_blt(tr, source, sr) 
      source.dispose
    end
    KGL.compressAlpha(@@buffer[key])
  end
  
end

Light_Cache.build

#-------------------------------------------------------------------------------
# * Color
#-------------------------------------------------------------------------------

class Color
    
  def light_level(alpha)
    return 255 - ((self.red + self.green + self.blue) * alpha).to_i / 765
  end
  
end

#-------------------------------------------------------------------------------
# * Virtual Char
#-------------------------------------------------------------------------------

class Virtual_Char
  
  attr_accessor :real_x
  attr_accessor :real_y
  attr_accessor :direction
  
  def jump_height
    0
  end
  
end

#-------------------------------------------------------------------------------
# * Light Source
#-------------------------------------------------------------------------------

class Light_Source
  
  include Graphics_Core
  include Light_Core
  
  attr_reader :id
  attr_reader :x
  attr_reader :y
  attr_reader :cx
  attr_reader :cy
  attr_reader :h
  attr_reader :screen_x
  attr_reader :screen_y
  attr_reader :char
  attr_reader :static
  attr_reader :shadows
  
  def initialize
    @bitmap = nil
  end
  
  def dispose
    return if @bitmap.nil?
    @bitmap.dispose
    @bitmap = nil
  end
  
  def restore
    dispose
    refresh_size
    refresh_xyh if @char.light !=nil
    @bitmap = Light_Cache[@key].clone 
    if @shadows && @static && $kgs.static
      KGL.bindShadowbuffer(@bitmap)
      draw_shadow
    end
  end
  
  def change_setting?
    @bitmap != nil
  end
  
  def set_light(id, key)
    @id = id
    @key = key
  end
  
  def set_group(group)
  end
  
  def set_mode(static, shadows)
    @static = (static.nil? ? true : static)
    @shadows = (shadows.nil? ? false : shadows)
    restore
  end
  
  def set_opacity(op, var)
    if op != nil
      @opacity = op
      @variation = (var.nil? ? 0 : var)
    else
      @opacity = 255
      @variation = 0
    end
  end
  
  def set_pos(rx, ry, d)
    @char = Virtual_Char.new
    @char.real_x = rx
    @char.real_y = ry
    @char.direction = d
  end
    
  def follow_char(char)
    @char = char
  end
  
  def set_offset(offset)
    offset = 0 if offset.nil?
    @offset = (offset.is_a?(Hash) ? offset : {2=>offset, 4=>offset, 6=>offset, 8=>offset})
  end
  
  def set_x_offset(offset_x)
    print "offx #{offset_x}\n"
    @offset.keys.each do |key|
      @offset[key][0] = offset_x
    end
  end
  
  def set_y_offset(offset_y)
    print "offy #{offset_y}\n"
    @offset.keys.each do |key|
      @offset[key][1] = offset_y
    end
  end
  
  def opacity
    @variation == 0 ? @opacity : (@opacity + rand(@variation))
  end
  
  def visible?
    @screen_x < Screen_Width && @screen_y < Screen_Height && (@screen_x + @width) > 0 && (@screen_y + @height) > 0
  end
  
  def refresh_size
    @width = Light_Cache[@key].width
    @height = Light_Cache[@key].height
    @half_width = @width/2
    @half_height = @height/2
    @width_offset = @half_width - 16
    @height_offset = @half_height - 16
    @tile_hw = @half_width/32.0 + 0.5
    @tile_hh = @half_height/32.0 + 0.5
  end
  
  def refresh_xyh
    @x = (@char.real_x*32 - @width_offset).to_f + @offset[@char.direction][0]
    @y = (@char.real_y*32 - @height_offset).to_f + @offset[@char.direction][1]
    @cx = @x + @half_width
    @cy = @y + @half_height
    @screen_x = $game_map.adjust_x(@char.real_x)*32-@width_offset + @offset[@char.direction][0] - $game_map.screen.shake
    @screen_y = $game_map.adjust_y(@char.real_y)*32-@height_offset + @offset[@char.direction][1]
    @h = ($game_map.local_height(@char.real_x + 0.4, @char.real_y + 0.4) > $game_map.local_height(@char.real_x + 0.5, @char.real_y + 0.5) ? $game_map.local_height(@char.real_x + 0.4, @char.real_y + 0.4) : $game_map.local_height(@char.real_x + 0.5, @char.real_y + 0.5))
  end
  
  def sbmp 
    @bitmap
  end
    
  def dbmp
    if !@static && @shadows
      KGL.clone(@bitmap, Light_Cache[@key])
      KGL.bindShadowbuffer(@bitmap)
      draw_shadow
    end
    @bitmap
  end
    
  def draw_shadow
    $game_map.casters.shadow(self)
  end
  
end

unless Light_Core::Enable_Shadows
  
  class Light_Source
    
    def restore
      dispose
      refresh_size
      refresh_xyh
      @bitmap = Light_Cache[@key].clone 
    end
    
    def set_mode(static, shadows)
      @static = false
      @shadows = false
      restore
    end
    
    def refresh_xyh
		
      @screen_x = $game_map.adjust_x(@char.real_x)*32-@width_offset + @offset[@char.direction][0] - $game_map.screen.shake
      @screen_y = $game_map.adjust_y(@char.real_y)*32-@height_offset + @offset[@char.direction][1]
    end
    
    def dbmp
      @bitmap
    end
    
    def draw_shadow
    end
    
  end
  
end

#-------------------------------------------------------------------------------
# * Light SKSource
#-------------------------------------------------------------------------------

class Light_SKSource < Light_Source
  
  attr_reader :tile_hw
  attr_reader :tile_hh
  
end

#-------------------------------------------------------------------------------
# * Light MKSource
#-------------------------------------------------------------------------------

class Light_MKSource < Light_Source
  
  def initialize
    super
    @width = {}
    @height = {}
    @half_width = {}
    @half_height = {}
    @width_offset = {}
    @height_offset = {}
    @tile_hw = {}
    @tile_hh = {}
  end
  
  def tile_hw
    @tile_hw[@char.direction]
  end
  
  def tile_hh
    @tile_hh[@char.direction]
  end
  
  def dispose
    return if @bitmap.nil?
    @bitmap.values.each { |b| b.dispose }
    @bitmap = nil
  end
  
  def restore
    dispose
    refresh_size
    refresh_xyh 
    @bitmap = {2 => Light_Cache[@key[2]].clone, 4 => Light_Cache[@key[4]].clone,6 => Light_Cache[@key[6]].clone,8 => Light_Cache[@key[8]].clone}
    @bitmap.values.each {|b| KGL.bindShadowbuffer(b); draw_shadow} if @shadows && @static && $kgs.static
  end
  
  def refresh_size
    for d in [2,4,6,8]
      @width[d] = Light_Cache[@key[d]].width
      @height[d] = Light_Cache[@key[d]].height
      @half_width[d] = @width[d]/2
      @half_height[d] = @height[d]/2
      @width_offset[d] = @half_width[d] - 16
      @height_offset[d] = @half_height[d] - 16
      @tile_hw[d] = @half_width[d]/32.0 + 0.5
      @tile_hh[d] = @half_height[d]/32.0 + 0.5
    end
  end
  
  def visible?
    @screen_x < Screen_Width && @screen_y < Screen_Height && (@screen_x + @width[@char.direction]) > 0 && (@screen_y + @height[@char.direction]) > 0
  end
  
  def refresh_xyh
	
    d = @char.direction
    @x = (@char.real_x*32 - @width_offset[d]).to_f + @offset[d][0]
    @y = (@char.real_y*32 - @height_offset[d]).to_f + @offset[d][1]
    @cx = @x + @half_width[d]
    @cy = @y + @half_height[d]
    @screen_x = $game_map.adjust_x(@char.real_x)*32-@width_offset[d] + @offset[d][0] - $game_map.screen.shake
    @screen_y = $game_map.adjust_y(@char.real_y)*32-@height_offset[d] + @offset[d][1]
    @h = ($game_map.local_height(@char.real_x + 0.4, @char.real_y + 0.4) > $game_map.local_height(@char.real_x + 0.5, @char.real_y + 0.5) ? $game_map.local_height(@char.real_x + 0.4, @char.real_y + 0.4) : $game_map.local_height(@char.real_x + 0.5, @char.real_y + 0.5))
  end
  
  def sbmp
    @bitmap[@char.direction]
  end
    
  def dbmp
    if !@static && @shadows
      KGL.clone(@bitmap[@char.direction], Light_Cache[@key[@char.direction]])
      KGL.bindShadowbuffer(@bitmap[@char.direction])
      draw_shadow
    end
    @bitmap[@char.direction]
  end
  
end

unless Light_Core::Enable_Shadows
  
  class Light_MKSource < Light_Source
    
    def restore
      dispose
      refresh_size
      refresh_xyh
      @bitmap = {2 => Light_Cache[@key[2]].clone, 4 => Light_Cache[@key[4]].clone,6 => Light_Cache[@key[6]].clone,8 => Light_Cache[@key[8]].clone}
    end
    
    def refresh_xyh
	
      d = @char.direction
      @screen_x = $game_map.adjust_x(@char.real_x)*32-@width_offset[d] + @offset[d][0] - $game_map.screen.shake
      @screen_y = $game_map.adjust_y(@char.real_y)*32-@height_offset[d] + @offset[d][1]
    end
    
    def dbmp
      @bitmap[@char.direction]
    end
    
  end
  
end

#-------------------------------------------------------------------------------
# * Shadow
#-------------------------------------------------------------------------------

class Shadow
  
  include Graphics_Core
  include Light_Core
  
  attr_accessor :bitmap
  
  def initialize
    @sprite = nil
    @bitmap = nil
    @color = Color.new(255,255,255,255)
    @r, @g, @b, @a = 255, 255, 255, 0
    @tr, @tg, @tb, @ta = 255, 255, 255, 0
    @br, @bg, @bb, @ba = 0, 0, 0, 0
    @dr, @dg, @db, @da = 0, 0, 0, 0
    @color_phase, @alpha_phase = 0, 0
    @color_dp, @alpha_dp = 0, 0
    @color_timer, @alpha_timer = nil, nil
    @lighting = true # false is origianl , true by 417
  end
  
  def restore
    @bitmap = Bitmap.new(Screen_Width, Screen_Height)
    clear
  end
  
  def dispose
    return if @bitmap.nil?
    @bitmap.dispose
    @bitmap = nil
  end
  
  def give_sprite(s)
    @sprite = s
    @sprite.visible = @lighting
  end
  
  def release_sprite
    @sprite = nil
  end
  
  def clear
    KGL.clear(@bitmap, @color)
  end
  
  def draw
    return if @a <= 0 || !@lighting
    clear
    draw_lights
  end
  
  def draw_lights
    KGL.bindFramebuffer(@bitmap)
    $game_map.lights.each { |source| source.draw_light }
  end
  
  def refresh
    @sprite.visible = @sprite 
	return #417
    refresh_ul
    if @color_timer
      if @color_timer > 0
        @color_phase -= @color_dp
        drgb = Math.cos(@color_phase)+1
        @r = (@br + @dr*drgb).to_i
        @g = (@bg + @dg*drgb).to_i
        @b = (@bb + @db*drgb).to_i
        @color.set(@r, @g, @b)
        @color_timer -= 1
      else
        @r = @tr
        @g = @tg
        @b = @tb
        @color_timer = nil
      end
    end
    if @alpha_timer
      if @alpha_timer > 0
        @alpha_phase -= @alpha_dp
        @a = (@ba + @da*(Math.cos(@alpha_phase)+1)).to_i
        @sprite.opacity = @a
        @alpha_timer -= 1
      else
        @a = @ta
        @alpha_timer = nil
      end
    end
  end
  
  def refresh_ul
    @lighting = true
    @lighting ? show : hide
  end
  
  def set_color(r, g, b, time = nil)
    r = 0 if r < 0; r = 255 if r > 255
    g = 0 if g < 0; g = 255 if g > 255
    b = 0 if b < 0; b = 255 if b > 255
    if time.nil? || time == 0
      @tr = @r = 255 - r
      @tg = @g = 255 - g
      @tb = @b = 255 - b
      @color.set(@r, @g, @b)
      @color_timer = nil
    else
      @color_phase = Math::PI
      @color_dp = @color_phase/time
      @tr, @tg, @tb = 255 - r, 255 - g, 255 - b
      @br, @bg, @bb = @r, @g, @b
      @dr = (@tr - @br)/2
      @dg = (@tg - @bg)/2
      @db = (@tb - @bb)/2
      @color_timer = time - 1
    end
  end
  
  def set_opacity(a, time = nil)
    a = 0 if a < 0
    a = 255 if a > 255
    if time.nil? || time == 0
      @ta = @a = a
      @sprite.opacity = @a unless @sprite.nil?
      @alpha_timer = nil
    else
      @alpha_phase = Math::PI
      @alpha_dp = @alpha_phase/time
      @ta = a
      @ba = @a
      @da = (@ta - @ba)/2
      @alpha_timer = time - 1
    end
  end
  
  def show
    @lighting = true
    @sprite.visible = @lighting if @sprite
    #$game_switches[UlSys_Sw] = !@lighting
  end
  
  def hide
    @lighting = false
    @sprite.visible = @lighting if @sprite
    #$game_switches[UlSys_Sw] = !@lighting
  end
  
  def opacity
    @a
  end
  
	def getRGB
		[(@r-255).abs,(@g-255).abs,(@b-255).abs]
	end
  
  def level(x, y)
    return (255 - @a) unless @bitmap
    return (255 - @a) if x < 0 || y < 0 || x >= Screen_Width || y >= Screen_Height
    @bitmap.get_pixel(x, y).light_level(@a)
  end
  
  def light_level(x, y)
    level($game_map.adjust_x(x) * 32 + 16, $game_map.adjust_y(y) * 32 + 16)
  end
  
end

#-------------------------------------------------------------------------------
# * Shadow Overlay
#-------------------------------------------------------------------------------

class Shadow_Overlay < Sprite
  
  include Light_Core
  
  def initialize
    super(nil)
    $game_map.shadows.restore
    self.bitmap = $game_map.shadows.bitmap
    self.blend_type = 2
    self.opacity = $game_map.shadows.opacity
    self.z = System_Settings::KHAS_SHADOW_Z
    $game_map.shadows.give_sprite(self)
  end
  
  def update
    $game_map.shadows.refresh
    $game_map.shadows.draw
  end
  
  def dispose
    $game_map.shadows.release_sprite
    $game_map.shadows.dispose
    self.bitmap = nil
    super
  end
  
  def marshal_dump
  end
  
end

#-------------------------------------------------------------------------------
# * Game CharacterBase
#-------------------------------------------------------------------------------

class Game_CharacterBase
  
  include Light_Core
  
  attr_accessor :light
  
  alias kul_initialize initialize
  
  def initialize
    kul_initialize
    @light = nil
  end
  
	def give_light(i)
		drop_light
		create_light(i)
	end
  
  def create_light(id)
    effect = Lights[id.to_s]
    if effect.nil?
      print "Warning! Light #{id.to_s} not found!\n"
      return
    end
    @light = (effect[:light].is_a?(Hash) ? Light_MKSource.new : Light_SKSource.new)
    @light.set_light(id.to_s, effect[:light])
    @light.follow_char(self)
    @light.set_group(effect[:group])
    @light.set_offset(effect[:offset])
    @light.set_opacity(effect[:opacity], effect[:variation])
    @light.set_mode(effect[:static], effect[:shadows])
    $game_map.lights << self
  end
  
  def drop_light
    if @light
      $game_map.lights.delete(self)
      @light.dispose
      @light = nil
    end
  end
  
  def carrying_light?
    @light != nil
  end
  
  def restore_light
    @light.restore
  end
  
  def dispose_light
    @light.dispose
  end
  
  def draw_light
    @light.refresh_xyh
    KGL.lightShader($kgs.dynamic ? @light.dbmp : @light.sbmp, @light.screen_x, @light.screen_y, @light.opacity) if @light.visible?
  end
  
end

#-------------------------------------------------------------------------------
# * Game Event
#-------------------------------------------------------------------------------

class Game_Event < Game_Character
  
  #alias kul_extend_setup khas_extend_setup
  #alias kul_call_khas_tag call_khas_tag
  #alias kul_call_khas_command call_khas_command
  
  #def khas_extend_setup
  #  kul_extend_setup
  #  #drop_light
  #end
  
  #def call_khas_tag(t)
  #  kul_call_khas_tag(t)
  #  case t
  #    when "static"; @light.set_mode(true, @light.shadows) if @light
  #    when "dynamic"; @light.set_mode(false, @light.shadows) if @light
  #    when "shadows"; @light.set_mode(@light.static, true) if @light
  #    when "no_shadows"; @light.set_mode(@light.static, false) if @light
  #  end
  #end
  #
  #def call_khas_command(c,v)
  #  kul_call_khas_command(c,v)
  #  case c
  #    when "light"; create_light(v) if @light.nil?
  #    when "group"; @light.set_group(v.to_sym) if @light
  #    when "offset_x"; @light.set_x_offset(v.to_i) if @light
  #    when "offset_y"; @light.set_y_offset(v.to_i) if @light
  #  end
  #end
  
end

#-------------------------------------------------------------------------------
# * Scene Map
#-------------------------------------------------------------------------------

class Scene_Map < Scene_Base
  
  #alias kul_pre_battle_scene pre_battle_scene
  #
  #def pre_battle_scene
  #  kul_pre_battle_scene 
  #  @spriteset.dispose_ultra_graphics
  #end
  
end

#-------------------------------------------------------------------------------
# * Shadow CFF
#-------------------------------------------------------------------------------

class Shadow_CFF
  
  def initialize(x1,x2,y,h)
    @x1 = x1
    @x2 = x2
    @y = y
    @h = h
  end
  
  def cast(light)
    KGL.shadowShaderH(@x1-light.x, @x2-light.x, @y-light.y) if light.cy > @y || light.h >= @h 
  end
  
  def cast_offset(light, ox, oy)
    KGL.shadowShaderH(@x1+ox-light.x, @x2+ox-light.x, @y+oy-light.y) if light.cy > (@y+oy) || light.h >= @h 
  end
  
end

#-------------------------------------------------------------------------------
# * Shadow CBF
#-------------------------------------------------------------------------------

class Shadow_CBF
  
  def initialize(x1,x2,y,h)
    @x1 = x1
    @x2 = x2
    @y = y
    @h = h
  end
  
  def cast(light)
    KGL.shadowShaderH(@x1-light.x, @x2-light.x, @y-light.y) if light.cy < @y || light.h >= @h
  end
  
  def cast_offset(light, ox, oy)
    KGL.shadowShaderH(@x1+ox-light.x, @x2+ox-light.x, @y+oy-light.y) if light.cy < (@y+oy) || light.h >= @h
  end
  
end

#-------------------------------------------------------------------------------
# * Shadow CLF
#-------------------------------------------------------------------------------

class Shadow_CLF
  
  def initialize(y1,y2,x,h)
    @x = x
    @y1 = y1
    @y2 = y2
    @h = h
  end
  
  def cast(light)
    KGL.shadowShaderV(@y1-light.y, @y2-light.y, @x-light.x) if light.cx < @x || light.h >= @h 
  end
  
  def cast_offset(light, ox, oy)
    KGL.shadowShaderV(@y1+oy-light.y, @y2+oy-light.y, @x+ox-light.x) if light.cx < (@x+ox) || light.h >= @h 
  end
  
end

#-------------------------------------------------------------------------------
# * Shadow CRF
#-------------------------------------------------------------------------------

class Shadow_CRF
  
  def initialize(y1,y2,x,h)
    @x = x
    @y1 = y1
    @y2 = y2
    @h = h
  end
  
  def cast(light)
    KGL.shadowShaderV(@y1-light.y, @y2-light.y, @x-light.x) if light.cx > @x || light.h >= @h 
  end
  
  def cast_offset(light, ox, oy)
    KGL.shadowShaderV(@y1+oy-light.y, @y2+oy-light.y, @x+ox-light.x) if light.cx > (@x+ox) || light.h >= @h 
  end
  
end

#-------------------------------------------------------------------------------
# * Shadow CLW
#-------------------------------------------------------------------------------

class Shadow_CLW
  
  def initialize(y1,y2,y0,y3,x)
    @x = x
    @y1 = y1
    @y2 = y2
    @y0 = y0
    @y3 = y3
  end
  
  def cast(light)
    KGL.shadowShaderV(@y1-light.y, @y2-light.y, @x-light.x) if light.cx < @x && light.cy < @y3
    KGL.shadowShaderW(@y1-light.y, @y2-light.y, @x-light.x) if light.cx > @x && light.cy >= @y0
  end
  
  def cast_offset(light, ox, oy)
    KGL.shadowShaderV(@y1+oy-light.y, @y2+oy-light.y, @x+ox-light.x) if light.cx < (@x+ox) && light.cy < (@y3+oy)
    KGL.shadowShaderW(@y1+oy-light.y, @y2+oy-light.y, @x+ox-light.x) if light.cx > (@x+ox) && light.cy >= (@y0+oy)
  end
  
end

#-------------------------------------------------------------------------------
# * Shadow CRW
#-------------------------------------------------------------------------------

class Shadow_CRW
  
  def initialize(y1,y2,y0,y3,x)
    @x = x
    @y1 = y1
    @y2 = y2
    @y0 = y0
    @y3 = y3
  end
  
  def cast(light)
    KGL.shadowShaderV(@y1-light.y, @y2-light.y, @x-light.x) if light.cx > @x && light.cy < @y3
    KGL.shadowShaderW(@y1-light.y, @y2-light.y, @x-light.x) if light.cx < @x && light.cy >= @y0
  end
  
  def cast_offset(light, ox, oy)
    KGL.shadowShaderV(@y1+oy-light.y, @y2+oy-light.y, @x+ox-light.x) if light.cx > (@x+ox) && light.cy < (@y3+oy)
    KGL.shadowShaderW(@y1+oy-light.y, @y2+oy-light.y, @x+ox-light.x) if light.cx < (@x+ox) && light.cy >= (@y0+oy)
  end
  
end

#-------------------------------------------------------------------------------
# * Table Casters
#-------------------------------------------------------------------------------

class Table_Casters < Table
  
  def n?(x,y,b)
    (self[x,y] & b) == 0
  end
  
end

#-------------------------------------------------------------------------------
# * Shadow Casters
#-------------------------------------------------------------------------------

class Shadow_Casters
  
  include Light_Core
  
  attr_reader :width
  attr_reader :height
  
  def initialize(map_width, map_height, loop_x, loop_y)
    @map_width = map_width
    @map_height = map_height
    @loop_x = loop_x
    @loop_y = loop_y
    @ox = @map_width*32
    @oy = @map_height*32
    build_data
  end
  
  def build_data
    @width = ((@map_width - 1) >> SCShift) + 1
    @height = ((@map_height - 1) >> SCShift) + 1
    @data = Array.new(@width) { Array.new(@height) { [] } }
  end
  
  def same_chunk?(x1, y1, x2, y2)
    return false if x2 >= @map_width || y2 >= @map_height
    (x1 >> SCShift == x2 >> SCShift) && (y1 >> SCShift == y2 >> SCShift)
  end
  
  def push(x, y, caster)
    @data[x >> SCShift][y >> SCShift] << caster
  end
  
  def shadow(light)
    if @loop_x || @loop_y
      x1 = (light.char.real_x - light.tile_hw).to_i / SCSize
      x2 = (light.char.real_x + light.tile_hw).to_i / SCSize + 1
      y1 = (light.char.real_y - light.tile_hh).to_i / SCSize
      y2 = (light.char.real_y + light.tile_hh).to_i / SCSize + 1
      if @loop_x
        x1 -= 1 if x1 < 0
        x2 += 1 if x2 >= @width
      else
        x1 = 0 if x1 < 0
        x2 = @width - 1 if x2 >= @width
      end
      if @loop_y
        y1 -= 1 if y1 < 0
        y2 += 1 if y2 >= @height
      else
        y1 = 0 if y1 < 0
        y2 = @height - 1 if y2 >= @height
      end
      for x in x1..x2
        for y in y1..y2
          ox = (x < 0 ? -@ox : 0)
          oy = (y < 0 ? -@oy : 0)
          ox = @ox if x >= @width
          oy = @oy if y >= @height
          if ox == 0 && oy == 0
            for caster in @data[x][y]
              caster.cast(light)
            end
          else
            for caster in @data[x % @width][y % @height]
              caster.cast_offset(light,ox,oy)
            end
          end
        end
      end
    else
      x1 = (light.char.real_x - light.tile_hw).to_i
      x2 = (light.char.real_x + light.tile_hw).to_i
      y1 = (light.char.real_y - light.tile_hh).to_i
      y2 = (light.char.real_y + light.tile_hh).to_i
      x1 = 0 if x1 < 0
      x2 = @map_width - 1 if x2 >= @map_width
      y1 = 0 if y1 < 0
      y2 = @map_height - 1 if y2 >= @map_height
      x1 >>= SCShift
      x2 >>= SCShift
      y1 >>= SCShift
      y2 >>= SCShift
      for x in x1..x2
        for y in y1..y2
          for caster in @data[x][y]
            caster.cast(light)
          end
        end
      end
    end
  end
  
end

#-------------------------------------------------------------------------------
# * Game Map
#-------------------------------------------------------------------------------

class Game_Map
  
  include Light_Core
  
  attr_accessor :lights
  attr_accessor :shadows
  attr_accessor :casters

  
  def initialize_ultra_graphics
    @lights = []
    @shadows = Shadow.new
  end
  
	def setup_ultra_lighting
		prp "setup_ultra_lighting"
		@lights.clear
		@lights << $game_player if $game_player.carrying_light?
		@casters = Khas_Core.shadow_casters(@map_id, @map, @height_map) if Enable_Shadows
		disable_std_shadows if Disable_STD_Shadows
	end
  
	def disable_std_shadows
			data.xsize.times do |x|
				data.ysize.times do |y|
				data[x, y, 0x03] &= 0x0fff0
			end
		end
	end

end

#-------------------------------------------------------------------------------
# * Spriteset Map
#-------------------------------------------------------------------------------

class Spriteset_Map
  
  include Light_Core
  
  alias kul_initialize initialize
  alias kul_update update
  alias kul_dispose dispose
  
  def initialize
    initialize_ultra_graphics
    kul_initialize
  end
  
  def update
    kul_update
    update_ultra_graphics
  end
  
  def dispose
    kul_dispose
    dispose_ultra_graphics
  end
  
  def initialize_ultra_graphics
    @shadow_overlay = Shadow_Overlay.new
    $game_map.lights.each { |source| source.restore_light }
    initialize_fog
  end
  
  def update_ultra_graphics
    @shadow_overlay.update
    update_fog
  end
  
  def dispose_ultra_graphics
    $game_map.lights.each { |source| source.dispose_light }
    dispose_fog
    if @shadow_overlay
      @shadow_overlay.dispose
      @shadow_overlay = nil
    end
  end
  
  def initialize_fog
  end
  
  def update_fog
  end
  
  def dispose_fog
  end
  
end

#-------------------------------------------------------------------------------
# * Khas Core
#-------------------------------------------------------------------------------

module Khas_Core
  
  @@sc_cache = {}
  
  def self.gen_shadow_casters(map, height_map)
    i = 0; j = 0; k = 0
    added = Table_Casters.new(map.width, map.height)
    casters = Shadow_Casters.new(map.width, map.height, map.scroll_type == 2 || map.scroll_type == 3, map.scroll_type == 1 || map.scroll_type == 3)
    for x in 0...map.width
      for y in 0...map.height
        next unless height_map[x,y] > 0
        if height_map.floor?(x,y)
          if added.n?(x,y,0b1) && height_map[x,y] > height_map.lxy(x,y+1)
            added[x,y] |= 0b1
            i = 1
            while(height_map.floor?(x+i,y) && casters.same_chunk?(x,y,x+i,y) && height_map.lxy(x+i,y) > height_map.lxy(x+i,y+1))
              added[x+i,y] |= 0b1
              i += 1
            end
            casters.push(x,y,Shadow_CFF.new(x*32, (x+i)*32, (y+1)*32, height_map[x,y]))
          end
          if added.n?(x,y,0b10) && height_map[x,y] > height_map.lxy(x,y-1)
            added[x,y] |= 0b10
            i = 1
            while(height_map.floor?(x+i,y) && casters.same_chunk?(x,y,x+i,y) && height_map.lxy(x+i,y) > height_map.lxy(x+i,y-1))
              added[x+i,y] |= 0b10
              i += 1
            end
            casters.push(x,y,Shadow_CBF.new(x*32, (x+i)*32, y*32, height_map[x,y]))
          end
          if added.n?(x,y,0b100) && height_map[x,y] > height_map.lxy(x-1,y)
            added[x,y] |= 0b100
            i = 1
            while(height_map.floor?(x,y+i) && casters.same_chunk?(x,y,x,y+i) && height_map.lxy(x,y+i) > height_map.lxy(x-1,y+i))
              added[x,y+i] |= 0b100
              i += 1
            end
            casters.push(x,y,Shadow_CLF.new(y*32, (y+i)*32, x*32, height_map[x,y]))
          end
          if added.n?(x,y,0b1000) && height_map[x,y] > height_map.lxy(x+1,y)
            added[x,y] |= 0b1000
            i = 1
            while(height_map.floor?(x,y+i) && casters.same_chunk?(x,y,x,y+i) && height_map.lxy(x,y+i) > height_map.lxy(x+1,y+i))
              added[x,y+i] |= 0b1000
              i += 1
            end
            casters.push(x,y,Shadow_CRF.new(y*32, (y+i)*32, (x+1)*32, height_map[x,y]))
          end
        end
        if height_map.wall?(x,y)
          if added.n?(x,y,0b10000) && height_map[x,y] > height_map.lxy(x-1,y)
            added[x,y] |= 0b10000
            i = 1
            while(height_map.wall?(x,y+i) && casters.same_chunk?(x,y,x,y+i) && height_map[x,y+i] > height_map.lxy(x-1,y+i))
              added[x,y+i] |= 0b10000
              i += 1
            end
            k = 1
            while(height_map.wall?(x,y-k) && (y-k) > 0 && height_map[x,y-k] > height_map.lxy(x-1,y-k))
              k += 1
            end
            k -= 1
            j = i
            while(height_map.wall?(x,y+j) && (y+j) < map.height && height_map[x,y+j] > height_map.lxy(x-1,y+j))
              j += 1
            end
            casters.push(x,y,Shadow_CLW.new(y*32, (y+i)*32, (y-k)*32, (y+j)*32, x*32))
          end
          if added.n?(x,y,0b100000) && height_map[x,y] > height_map.lxy(x+1,y)
            added[x,y] |= 0b100000
            i = 1
            while(height_map.wall?(x,y+i) && casters.same_chunk?(x,y,x,y+i) && height_map[x,y+i] > height_map.lxy(x+1,y+i))
              added[x,y+i] |= 0b100000
              i += 1
            end
            k = 1
            while(height_map.wall?(x,y-k) && (y-k) > 0 && height_map[x,y-k] > height_map.lxy(x+1,y-k))
              k += 1
            end
            k -= 1
            j = i
            while(height_map.wall?(x,y+j) && (y+j) < map.height && height_map[x,y+j] > height_map.lxy(x+1,y+j))
              j += 1
            end
            casters.push(x,y,Shadow_CRW.new(y*32,(y+i)*32, (y-k)*32, (y+j)*32, (x+1)*32))
          end
        end
      end
    end
    casters
  end
  
  def self.shadow_casters(map_id, map, height_map)
    @@sc_cache.include?(map_id) ? @@sc_cache[map_id] : gen_shadow_casters(map, height_map)
  end
  
  #def self.load_sc_data
  #  for id in Load_Map_Data
  #    map = load_data(sprintf("Data/Map%03d.rvdata2", id))
  #    @@sc_cache[id] = gen_shadow_casters(map, @@height_cache[id])
  #  end
  #end
  
end

#Khas_Core.load_sc_data if Light_Core::Enable_Shadows

#-------------------------------------------------------------------------------
# * Scene Manager
#-------------------------------------------------------------------------------

module SceneManager
  
  class << self
    alias kul_run run
  end
  
  def self.run
    if $kul_ready
      Light_Cache.clear
      Light_Cache.build
    end
    $kul_ready = true
    self.kul_run
  end
  
end
  
#-------------------------------------------------------------------------------
# * End
#-------------------------------------------------------------------------------
