#-------------------------------------------------------------------------------
# * [ACE] Khas Ultra Graphics - Ultra Fog Add-on
#-------------------------------------------------------------------------------
# * By Nilo K. (Khas)
# * Version: 1.00
# * Released on: 09.27.2015 (the Foggy Time update)
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
# This is a free add-on that can only be used with Khas Ultra Lighting.
# The Khas Ultra Lighting requires the purchase of a license to be used.
# 
#-------------------------------------------------------------------------------
# * Requirements
#-------------------------------------------------------------------------------
# 1. Khas Core Library
#    Place the "Khas Core Library" script before this add-on.
#
# 2. Khas Graphics Library
#    Place the "Khas Graphics Library" script before this add-on.
#
# 3. Khas Ultra Lighting
#    Place the "Khas Ultra Lighting" script before this add-on.
#
#-------------------------------------------------------------------------------
# * Instructions
#-------------------------------------------------------------------------------
# 1. Create your fogs on the configuration part;
# 2. Adjust the fog settings;
# 3. Place fog graphics in the Fog folder;
# 3. Place a fog on any map by using the notetag [fog fog_name].
#
# You can also turn fogs on/off on the Graphics Settings menu!
#
#-------------------------------------------------------------------------------
# * Fog Core (configuration)
#-------------------------------------------------------------------------------
  
module Fog_Core
  
  Fogs = { #  <= DO NOT change this!
#-------------------------------------------------------------------------------
# Fog configuration
#-------------------------------------------------------------------------------
# To create a fog, use the following model and paste the code below.
#
# "name" => {
#    :graphic => "file"
#    :opacity => a,
#    :blend => b,
#    :vx => c,
#    :vy => d
#  },
#
#
# "name" -> Used for identification. Must be between quotation marks. Examples:
#           "fog"
#           "awesomefog"
#           "fog88"
#
# :graphic -> Fog file on Graphics/Fog folder. Must be a single file. Example:
#
#           :fog => "file name", 
#
# :opacity -> Fog's main opacity "a", must be between 0 and 255. Example:
# 
#           :opacity => 200,
#
# :blend -> Fog's blend type "b". Can be 0 (normal), 1 (add) or 2 (subtract).
# 
#           :blend => 2,
#
# :vx => c -> Fog's velocity x
# :vy => d -> Fog's velocity y
#           Velocity that the fog moves per frame. Can be float. Example:
#
#           :vx => 2,
#           :vy => 0.1,
#
#
#-------------------------------------------------------------------------------
#       ATTENTION! DO NOT FORGET THE COMMAS! - PUT YOUR FOGS HERE!
#-------------------------------------------------------------------------------

  "simple" => {
    :graphic => "fog1",
    :opacity => 150,
    :blend => 0,
    :vx => 0.07,
    :vy => 0.01
  },
  
  
  "forestfog" => {
    :graphic => "fog_dots",
    :opacity => 100,
    :blend => 0,
    :vx => 0.00,
    :vy => 0.1
  },
  
  
  "mountain" => {
    :graphic => "fog1",
    :opacity => 50,
    :blend => 0,
    :vx => 0.5,
    :vy => 0.00
  },
  
  "mountainUP" => {
    :graphic => "fog1",
    :opacity => 50,
    :blend => 0,
    :vx => 0.0,
    :vy => 0.5
  },
  
  
  "mountainLEFT" => {
    :graphic => "fog1",
    :opacity => 50,
    :blend => 0,
    :vx => 0.5,
    :vy => 0
  },
  
  
  "mountainLEFT_slow" => {
    :graphic => "fog1",
    :opacity => 50,
    :blend => 0,
    :vx => 0.1,
    :vy => 0
  },
  

  
  "mountainUP_slow" => {
    :graphic => "fog1",
    :opacity => 50,
    :blend => 0,
    :vx => 0.0,
    :vy => 0.1
  },
  "SubCity" => {
    :graphic => "fog1",
    :opacity => 25,
    :blend => 2,
    :vx => 0.0,
    :vy => 0.0
  },
  
  "mountainDown_slow" => {
    :graphic => "fog1",
    :opacity => 50,
    :blend => 0,
    :vx => 0.0,
    :vy => -0.1
  },
  "mountainDown_fast" => {
    :graphic => "fog1",
    :opacity => 50,
    :blend => 0,
    :vx => 0.0,
    :vy => -1
  },
  
  "cave" => {
    :graphic => "fog_dots",
    :opacity => 100,
    :blend => 0,
    :vx => 0.0,
    :vy => 0.0
  },
  
  
  "cave_fall" => {
    :graphic => "fog_dots",
    :opacity => 130,
    :blend => 0,
    :vx => 0.0,
    :vy => -0.1
  },
  "infested_Cave" => {
    :graphic => "infested_Cave",
    :opacity => 130,
    :blend => 0,
    :vx => 0.0,
    :vy => -0.05
  },
  
  "infested_fall" => {
    :graphic => "infested_dots",
    :opacity => 150,
    :blend => 2,
    :vx => 0.0,
    :vy => -0.1
  },
  
  "infested_fall_storm" => {
    :graphic => "FogStorm",
    :opacity => 60,
    :blend => 2,
    :vx => 10.0,
    :vy => -0.1
  },
  "infested_fallSM" => {
    :graphic => "infested_dots",
    :opacity => 100,
    :blend => 2,
    :vx => 0.0,
    :vy => -0.1
  },

  "mountain_storm" => {
    :graphic => "FogStorm",
    :opacity => 100,
    :blend => 0,
    :vx => 10.0,
    :vy => -0.1
  },
    "smoke_sybaris" => {
    :graphic => "fog3",
    :opacity => 70,
    :blend => 2,
    :vx => 0.2,
    :vy => 0.0
  }
  
  
#-------------------------------------------------------------------------------
# End of fog configuration
#-------------------------------------------------------------------------------
} #  <= DO NOT change this!

  # FOG FOLDER
  # You can change the default fog folder here (root/Graphics/folder name/).
  Fog_Folder = "Fog"
  
  # DISABLE FOG SWITCH
  # Set an switch ID below to temporarily disable fog. 
  # If you turn ON this switch, fog will be invisible.
  #Fog_Sw = 999
  
  # FOG Z
  # You can change the fog's Z coordinate here:
  #Fog_Z = 40
  
end

#-------------------------------------------------------------------------------
# * Requirements
#-------------------------------------------------------------------------------

unless $khas_graphics && $khas_graphics[:ultra_lighting] >= 1.0
  warning = Sprite.new
  warning.bitmap = Bitmap.new(Graphics.width,Graphics.height)
  warning.bitmap.fill_rect(0,0,Graphics.width,Graphics.height,Color.new(255,255,255))
  warning.bitmap.font = Font.new(System_Settings::MESSAGE_WINDOW_FONT_NAME, 32)
  warning.bitmap.font.bold = false
  warning.bitmap.font.outline = false
  warning.bitmap.font.color.set(255,144,9)
  warning.bitmap.draw_text(0,Graphics.height/2-32,Graphics.width,32,"PLEASE INSTALL",1)
  warning.bitmap.draw_text(0,Graphics.height/2,Graphics.width,32,"KHAS ULTRA LIGHTING 1.0",1)
  while !Input.trigger?(:C)
    Input.update
    Graphics.update
  end
  warning.bitmap.dispose
  warning.dispose
  exit
end

#-------------------------------------------------------------------------------
# * Version
#-------------------------------------------------------------------------------

$khas_graphics[:ultra_fog] = 1.0

#-------------------------------------------------------------------------------
# * Cache
#-------------------------------------------------------------------------------
  
module Cache
  
  def self.fog(filename)
    load_bitmap("Graphics/#{Fog_Core::Fog_Folder}/", filename)
  end
  
end

#-------------------------------------------------------------------------------
# * Fog Cache
#-------------------------------------------------------------------------------
  
module Fog_Cache
  
  include Fog_Core
  
  def self.initialize
    @@buffer = {}
    Fogs.values.each { |f| Fog_Cache.store(f[:graphic]) }
  end
  
  def self::[](key)
    return @@buffer[key]
  end
  
  def self.store(key)
    return if @@buffer.keys.include?(key)
    @@buffer[key] = Cache.fog(key).clone
  end
  
end

Fog_Cache.initialize

#-------------------------------------------------------------------------------
# * Plane Fog
#-------------------------------------------------------------------------------

class Plane_Fog < Plane
  
  include Fog_Core
  
  def initialize(id)
    super(nil)
    self.bitmap = Fog_Cache[Fogs[id][:graphic]]
    self.blend_type = Fogs[id][:blend]
    self.opacity = Fogs[id][:opacity]
    self.z = System_Settings::KHAS_FOG_Z
    @vx = Fogs[id][:vx]
    @vy = Fogs[id][:vy]
    @x = (@vx.is_a?(Float) ? 0.0 : 0)
    @y = (@vy.is_a?(Float) ? 0.0 : 0)
  end
  
  def update
    @x += @vx
    @y += @vy
    self.ox = $game_map.display_x*32 + @x
    self.oy = $game_map.display_y*32 + @y
  end
  
  def dispose
    self.bitmap = nil
    super
  end
  
end

#-------------------------------------------------------------------------------
# * Spriteset Map
#-------------------------------------------------------------------------------

class Spriteset_Map
  
  include Fog_Core
  
  def initialize_fog
    @fog = Plane_Fog.new($game_map.fog) if $game_map.fog && $kgs.fog
  end
  
  def update_fog
    if @fog
      @fog.update
      @fog.visible = true
    end
  end
  
  def dispose_fog
    @fog.dispose if @fog
    @fog = nil
  end
  
end

#-------------------------------------------------------------------------------
# * Game Map
#-------------------------------------------------------------------------------

class Game_Map
  
  include Fog_Core
  
  attr_accessor :fog
  
  alias kuf_extend_setup khas_extend_setup
  alias kuf_call_khas_command call_khas_command
  
  def khas_extend_setup
    kuf_extend_setup
    clear_fog
  end
  
  def call_khas_command(c,v)
    kuf_call_khas_command(c,v)
    set_fog(v) if c == "fog"
  end
  
  def clear_fog
    return if @fog.nil? || SceneManager.spriteset.nil?
    SceneManager.spriteset.dispose_fog
    @fog = nil
  end
  
  def set_fog(id)
    clear_fog
    if Fogs.include?(id)
      @fog = id
      SceneManager.spriteset.initialize_fog if SceneManager.spriteset
    end
  end
  
end

#-------------------------------------------------------------------------------
# * Graphics Settings
#-------------------------------------------------------------------------------

class Graphics_Settings
  
  attr_reader :fog
  
  alias kuf_set set
  
  def set_fog(f)
    return if @fog == f
    @fog = f
  end

  def set(setting, value)
    kuf_set(setting, value)
    set_fog(value == "ON") if setting == :fog
  end
  
end

$kgs.add(:fog, "Fog", "ON", ["OFF", "ON"])
$kgs.load

#-------------------------------------------------------------------------------
# * End
#-------------------------------------------------------------------------------
