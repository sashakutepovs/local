#-------------------------------------------------------------------------------
# * [ACE] Khas Ultra Lighting - Light Groups Add-on
#-------------------------------------------------------------------------------
# * By Nilo K. (Khas)
# * Version: 1.1
# * Released on: 12.07.2016
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
# KUL-LG 1.1 (12.07.2016)
# Script commands now work with omitted time (instant)
#
# KUL-LG 1.0 (08.01.2015)
# First release!
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
# Please read the Ultra Lighting guide! It's a pdf file inside the demo folder.
#
#-------------------------------------------------------------------------------
# * Requirements
#-------------------------------------------------------------------------------

unless $khas_graphics && $khas_graphics[:ultra_lighting] >= 1.1
  warning = Sprite.new
  warning.bitmap = Bitmap.new(Graphics.width,Graphics.height)
  warning.bitmap.fill_rect(0,0,Graphics.width,Graphics.height,Color.new(255,255,255))
  warning.bitmap.font = Font.new(System_Settings::MESSAGE_WINDOW_FONT_NAME, 32)
  warning.bitmap.font.bold = true
  warning.bitmap.font.outline = false
  warning.bitmap.font.color.set(255,144,9)
  warning.bitmap.draw_text(0,Graphics.height/2-32,Graphics.width,32,"PLEASE INSTALL",1)
  warning.bitmap.draw_text(0,Graphics.height/2,Graphics.width,32,"KHAS ULTRA LIGHTING 1.1",1)
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

$khas_graphics[:light_groups] = 1.1

#-------------------------------------------------------------------------------
# * Light Source
#-------------------------------------------------------------------------------

class Light_Source
  
  def set_group(group)
    @group = group
    $game_map.add_lgroup(group) if group
  end
  
  def opacity
    @group.nil? ? (@variation == 0 ? @opacity : (@opacity + rand(@variation))) : (@variation == 0 ? @opacity : (@opacity + rand(@variation)))*$game_map.lgroups[@group].f
  end
  
end

#-------------------------------------------------------------------------------
# * Shadow
#-------------------------------------------------------------------------------

class Shadow
  
  attr_accessor :rgroups
  
  alias klg_initialize initialize
  alias klg_refresh refresh
  
  def initialize
    @rgroups = []
    klg_initialize
  end
  
  def refresh
    klg_refresh
    @rgroups.each { |g| $game_map.lgroups[g].update }
  end
  
  def group_opacity(group, op, time = nil)
    $game_map.lgroups[group].set(op/255.0, time) if $game_map.lgroups[group]
  end
  
end

#-------------------------------------------------------------------------------
# * Game Map
#-------------------------------------------------------------------------------

class Game_Map
  
  attr_accessor :lgroups

  alias klg_init_ultra_graphics initialize_ultra_graphics
  
  def initialize_ultra_graphics
    klg_init_ultra_graphics
    @lgroups = {}
  end
  
  def add_lgroup(group)
    @lgroups[group] = Smooth_Alpha.new(1.0, group) unless @lgroups[group]
  end
  
end

#-------------------------------------------------------------------------------
# * Smooth Alpha
#-------------------------------------------------------------------------------

class Smooth_Alpha
  
  attr_reader :f
  
  def initialize(ff, group)
    @f = ff
    @group = group
  end
  
  def update
    @timer > 0 ? refresh : set(@target)
  end
  
  def update?
    @timer != nil
  end
  
  def refresh
    @phase -= @dp
    @f = @base + @delta*(Math.cos(@phase)+1)
    @timer -= 1
  end
  
  def set(target, time = nil)
    if time.nil? || time == 0
      @f = target
      @timer = nil
      $game_map.shadows.rgroups.delete(@group)
    else
      @phase = Math::PI
      @dp = @phase/time
      @target = target
      @base = @f
      @delta = (@target - @base)/2
      @timer = time - 1
      $game_map.shadows.rgroups << @group
    end
  end
  
end

#-------------------------------------------------------------------------------
# * End
#-------------------------------------------------------------------------------