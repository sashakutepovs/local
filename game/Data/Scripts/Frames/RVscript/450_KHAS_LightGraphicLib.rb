#-------------------------------------------------------------------------------
# * [ACE] Khas Graphics Library
#-------------------------------------------------------------------------------
# * By Nilo K. (Khas)
# * Version: 2.0
# * Released on: 01/22/2017
#
# Blog: arcthunder.blogspot.com
# Facebook: facebook.com/khasarc
# Twitter: twitter.com/arcthunder
# Youtube: youtube.com/c/khasarc
#
#-------------------------------------------------------------------------------
# * Terms of Use
#-------------------------------------------------------------------------------
# When using KHAS GRAPHICS LIBRARY (the script), including its library, you 
# agree with the following terms:
# 1. If you purchased a license to one of my scripts, credit is not required. 
#    Otherwise, you must give credit to Khas (if you want, a link to my blog is 
#    always appreciated);
# 2. You can use the script for free in both non-commercial and commercial 
#    projects;
# 4. You can edit the script for using in your own project. However, you are 
#    not allowed to share/distribute any modified version;
# 5. If you want to share a Khas script, don’t post the direct download link,
#    redirect the user to my blog instead;
# 6. The script can not be ported to any RPG Maker version than VX Ace.
#
#-------------------------------------------------------------------------------
# * Updates
#-------------------------------------------------------------------------------
# Please check my blog for KGL updates!
#
#-------------------------------------------------------------------------------
# * Requirements
#-------------------------------------------------------------------------------
# 1. Khas Core Library
#    Place the "Khas Core Library" script before KGL.
#
# 2. Khas Graphics Library file
#    Place the "KGL2.klib" file in your game's System folder.
#    You can customize the library location if you need.
#
#-------------------------------------------------------------------------------
# * Graphics Core (configuration)
#-------------------------------------------------------------------------------

module Graphics_Core
  
  # LIBRARY FOLDER
  # If you want to place the "KGL2.klib" file in another folder,
  # please change the string below.
  KGL_Folder = "System/"
  
  # SCREEN RESOLUTION
  # Change this if you are using a custom resolution script.
  Screen_Width = Graphics.width
  Screen_Height = Graphics.height
  
end

#-------------------------------------------------------------------------------
# * Requirements
#-------------------------------------------------------------------------------

unless $khas && $khas[:core]
  warning = Sprite.new
  warning.bitmap = Bitmap.new(Graphics.width,Graphics.height)
  warning.bitmap.fill_rect(0,0,Graphics.width,Graphics.height,Color.new(255,255,255))
  warning.bitmap.font = Font.new(System_Settings::MESSAGE_WINDOW_FONT_NAME, 32)
  warning.bitmap.font.bold = true
  warning.bitmap.font.outline = false
  warning.bitmap.font.color.set(255,144,9)
  warning.bitmap.draw_text(0,Graphics.height/2-32,Graphics.width,32,"PLEASE INSTALL",1)
  warning.bitmap.draw_text(0,Graphics.height/2,Graphics.width,32,"KHAS CORE LIBRARY 1.03",1)
  while !Input.trigger?(:C)
    Input.update
    Graphics.update
  end
  warning.bitmap.dispose
  warning.dispose
  exit
end

#-------------------------------------------------------------------------------
# * KGL
#-------------------------------------------------------------------------------

module KGL
  
  def self.function(name, p="")
    Win32API.new("#{Graphics_Core::KGL_Folder}KGL2.klib", name, p, "i")
  end
  
  @@version =  KGL.function("kglVersion")
  @@load = KGL.function("kglLoad")
  @@blank = KGL.function("kglBlank","i")
  @@clear = KGL.function("kglClear","ii") 
  @@invert = KGL.function("kglInvert","i")
  @@clone = KGL.function("kglClone","ii")
  @@bindFramebuffer =  KGL.function("kglBindFramebuffer","i")
  @@bindShadowbuffer =  KGL.function("kglBindShadowbuffer","i")
  @@unbindFramebuffer =  KGL.function("kglUnbindFramebuffer")
  @@unbindShadowbuffer =  KGL.function("kglUnbindShadowbuffer")
  @@clearFramebuffer =  KGL.function("kglClearFramebuffer")
  @@compressAlpha = KGL.function("kglCompressAlpha", "i")
  @@lightBlending = KGL.function("kglLightBlending", "i")
  @@lightShader = KGL.function("kglLightShader", "iiii")
  @@softShadows = KGL.function("kglSoftShadows", "i")
  @@shadowShaderH = KGL.function("kglShadowShaderH", "iii")
  @@shadowShaderV = KGL.function("kglShadowShaderV", "iii")
  @@shadowShaderW = KGL.function("kglShadowShaderW", "iii")
  
  def self.run
    KGL.load
    print "Khas Graphics Library #{KGL.version}\n"
  end
  
  def self.compressRGBA(color)
    r = color.red.to_i
    g = color.green.to_i
    b = color.blue.to_i
    a = color.alpha.to_i
    r | (g << 8) | (b << 16) | (a << 24)
  end
  
  def self.compressBGRA(color)
    r = color.red.to_i
    g = color.green.to_i
    b = color.blue.to_i
    a = color.alpha.to_i
    b | (g << 8) | (r << 16) | (a << 24)
  end
  
  def self.version
    @@version.call().to_f / 100
  end
  
  def self.load
    @@load.call()
  end
  
  def self.bindFramebuffer(bitmap)
    @@bindFramebuffer.call(bitmap.__id__)
  end
  
  def self.bindShadowbuffer(bitmap)
    @@bindShadowbuffer.call(bitmap.__id__)
  end
  
  def self.unbindFramebuffer()
    @@unbindFramebuffer.call()
  end
  
  def self.unbindShadowbuffer()
    @@unbindShadowbuffer.call()
  end
  
  def self.clearFramebuffer()
    @@clearFramebuffer.call()
  end
  
  def self.loadFramebuffer(bitmap, x, y)
    @@loadFramebuffer.call(bitmap.__id__, x, y)
  end
  
  def self.blank(bitmap)
    @@blank.call(bitmap.__id__)
  end
  
  def self.clear(bitmap, color)
    @@clear.call(bitmap.__id__, KGL.compressBGRA(color))
  end
  
  def self.invert(bitmap)
    @@invert.call(bitmap.__id__)
  end
  
  def self.clone(target, source)
    @@clone.call(target.__id__, source.__id__)
  end
  
  def self.compressAlpha(bitmap)
    @@compressAlpha.call(bitmap.__id__)
  end
  
  def self.lightBlending(b)
    @@lightBlending.call(b ? 1 : 0)
  end
  
  def self.lightShader(light, tx, ty, opacity)
    return if opacity <= 0
    @@lightShader.call(light.__id__, tx, ty, opacity)
  end
  
  def self.softShadows(s)
    @@softShadows.call(s ? 1 : 0)
  end
  
  def self.shadowShaderH(x1, x2, y)
    @@shadowShaderH.call(x1, x2, y)
  end
  
  def self.shadowShaderV(y1, y2, x)
    @@shadowShaderV.call(y1, y2, x)
  end
  
  def self.shadowShaderW(y1, y2, x)
    @@shadowShaderW.call(y1, y2, x)
  end
  
end

KGL.run

#-------------------------------------------------------------------------------
# * Version
#-------------------------------------------------------------------------------

$khas_graphics[:core] = 2.0
$khas_graphics[:kgl] = KGL.version

#-------------------------------------------------------------------------------
# * Framebuffer
#-------------------------------------------------------------------------------

class Framebuffer < Sprite
  
  include Graphics_Core
  
  def initialize(viewport = nil, width = Screen_Width, height = Screen_Height)
    super(viewport)
    self.bitmap = Bitmap.new(width, height)
  end
  
  def bind
    KGL.bindFramebuffer(self.bitmap)
  end
  
  def unbind
    KGL.unbindFramebuffer()
  end
  
  def clear
    KGL.clearFramebuffer()
  end
  
  def dispose
    self.bitmap.dispose
    super
  end
  
end

#-------------------------------------------------------------------------------
# * End
#-------------------------------------------------------------------------------
