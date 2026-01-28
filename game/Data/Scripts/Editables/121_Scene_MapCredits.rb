#==============================================================================
#
# GaryCXJk - Hacked Together Credits Script v1.02
# * Last Updated: 2014.08.03
# * Level: Easy
# * Requires: N/A
#
#==============================================================================


#==============================================================================
#
# Changelog:
#
# 2014.08.03 - v1.02
#
# * Added: You can now change the opacity using CXJ::HT_CREDITS.opacity
# * Added: Custom fonts can now be set
# * Added: Unicode now implemented, you can use \u{hex-value} to display the
#          character
# * Added: Icon font support
# * Added: A script can now be run when the credits end
# * Fixed: Now the credits data is moved to a separate class, allowing for
#          multiple credits files
# * Fixed: White lines are now ignored in the timeline block
#
#------------------------------------------------------------------------------
# 2012.01.13 - v1.01
#
# * Fixed: Made the window update automatically
#
#------------------------------------------------------------------------------
# 2012.01.03 - v1.00
#
# * Initial release
#
#==============================================================================
#
# Okay, here's the thing. RPG Maker VX Ace's message system can be very
# flexible, to the point where you can use it as a basic credits system.
# However, sometimes you want that little bit more flexibility. So, at these
# times it would be very nice to see a credits system.
#
# Now this isn't the best credits script there could be, hence its name. That
# doesn't mean it's bad though, it only means it's still very basic, kind of
# for people who want to work with a quick script, and that the code is a bit
# messy.
#
#==============================================================================
#
# Installation:
#
# Make sure to put this below Materials, but above Main Process.
#
# This script adds aliases for several methods. If you are sure no method that
# is used by other scripts get overridden, you can place it anywhere,
# otherwise, make sure this script is loaded after any other script overriding
# these methods, otherwise this script stops working.
#
#------------------------------------------------------------------------------
# Aliased methods:
#
# * class Scene_Base
#   - update_basic
#
#==============================================================================
#
# Usage:
#
# There are two ways to use this script. First is changing the current scene
# to Scene_Credits. It will automatically return to the last scene after it's
# done. This scene is completely bare, save for the credits stuff. Any music
# or other effect should be done before this scene. You can also subclass it
# to add new functionality.
#
# The other way is to open a Window_Credits. You can either open one yourself
# or use CXJ::HT_CREDITS.refresh to open a global window. To close the window,
# use CXJ::HT_CREDITS.terminate_message. Finally, CXJ::HT_CREDITS.credits_end?
# checks if the credits reach its end.
#
# A credits file is a regular text file which contains various data. It
# consists of several blocks, defined by square brackets. The [credits]
# section is the actual credits text. You can use certain formatting for that.
# None of the formatting will transfer over to the next line.
#
# \IFT[code]  - Insert an icon font character.
# \C          - Change color. The value that follows is four characters wide,
#               and is a hexadecimal value representing RGBA.
# \{          - Enlargen the text by eight.
# \}          - Shrink the text by eight.
# \Ax         - Align the text to the center position.
#               L:   Align left.
#               C:   Align center.
#               R:   Align right.
# \Px         - Sets the center position.
#               L:   At a quarter of the screen.
#               C:   At the center.
#               R:   At three quarters of the screen.
#               0-8: A position between the left and right position of the
#                    screen.
# \>>         - Will process the next line on the same line as the current.
#
# There is also an easy way to insert unicode characters, by using \u{code},
# where code is the hexadecimal code value of the glyph you want to insert.
# Do note that the u has to be lower case.
#
# The [timeline] section defines events that should happen during the credits
# sequence. You can define methods here, either as a symbol or as an evaluated
# line. You correctly format the lines as follows:
#
# time_in_seconds:method string
# time_in_seconds::symbol
#
# Example:
#
# 5.00:puts('Haldo world!')
# 5.10::make_font_bigger
#
# The [on_credits_end] block is actually a script block, which triggers once
# the script terminates, either by reaching the end or by getting terminated
# by the player. As the script is run inside the Window_Credits class, you
# can use the methods of this class inside this script.
#
# Finally, [settings] contains the settings. You can assign settings however
# you like, if you like. If you decide not to change a setting, you can always
# remove them.
#
# font            - The font or fonts (comma separated and in double quotes).
# line_height     - The font size.
# color           - The font color, as an eight character hexadecimal value.
# duration        - The duration of the credits sequence.
# scroll_duration - The duration of the scrolling text.
# speed           - The speed of the scrolling text.
#
#------------------------------------------------------------------------------
# Icon fonts:
#
# Icon fonts are generally used for web applications, but I decided to add
# compatibility for it in this credits script. Basically an icon font is a
# font that only contains icons. This makes the images very scalable.
#
# To define an icon font, you need to make a hash, which contains the
# following blocks:
#
# :name   - The name of the font as it's defined in the font itself
# :prefix - The prefix, used to identify the font
# :glyph  - A list of glyphs
#
# The glyph block in itself is a hash as well, where the key is the identifier
# of the font, and the value is the hexadecimal value associated with the
# glyph.
#
# In the demo I've added an example. I've used FontAwesome as the icon font
# to show how it works. I also added a short bit below to show you the
# structure of the hash.
#
# FONTAWESOME = {}
# FONTAWESOME[:name] = "FontAwesome"
# FONTAWESOME[:prefix] = "fa-"
# FONTAWESOME[:glyph] = {}
# FONTAWESOME[:glyph]["adjust"] = "f042"
# FONTAWESOME[:glyph]["adn"] = "f170"
#
#==============================================================================
#
# License:
#
# CC0 1.0 Universal (CC0 1.0)
# Public Domain Dedication
#
# The complete license can be read here:
# https://creativecommons.org/publicdomain/zero/1.0/legalcode
#
# The license as it is described below can be read here:
# https://creativecommons.org/publicdomain/zero/1.0/deed
#
# No Copyright
#
# The person who associated a work with this deed has dedicated the work to the
# public domain by waiving all of his or her rights to the work worldwide under
# copyright law, including all related and neighboring rights, to the extent
# allowed by law.
#
# You can copy, modify, distribute and perform the work, even for commercial
# purposes, all without asking permission. See Other Information below.
#
# Other Information
#
# * In no way are the patent or trademark rights of any person affected by CC0,
#   nor are the rights that other persons may have in the work or in how the
#   work is used, such as publicity or privacy rights.
# * Unless expressly stated otherwise, the person who associated a work with
#   this deed makes no warranties about the work, and disclaims liability for
#   all uses of the work, to the fullest extent permitted by applicable law.
# * When using or citing the work, you should not imply endorsement by the
#   author or the affirmer.
#
#------------------------------------------------------------------------------
# Clarifications and reasoning:
#
# This script has been given a CC0 license because I feel it deserves to be
# used by everyone without restriction. This ensures that people don't feel
# obligated to add a license notice or credits whenever the script is being
# used.
#
# Additional reasoning:
#
# This script is actually pretty easy to implement yourself, and I feel it's
# a bit unfair to ask more from the ones who use it other than that the script
# is being used. Besides, asking to be credited on a credits page? That's
# pretty redundant.
#
# I also feel like there are better ways to implement a credits sequence,
# especially with the experience I've gained since.
#
#------------------------------------------------------------------------------
# Extra notes:
#
# You are free to pick the following names when you give credit:
#
# * GaryCXJk
# * Gary A.M. Kertopermono
# * G.A.M. Kertopermono
# * GARYCXJK
#
# I actually don't mind if you don't credit me, but it would always be nice.
#
# This script was originally hosted on:
# http://area91.multiverseworks.com
#
#==============================================================================
#
# The code below defines the settings of this script, and are there to be
# modified.
#
#==============================================================================

module CXJ
  module HT_CREDITS
    # General settings
    BASE_FONT = System_Settings::MESSAGE_WINDOW_FONT_NAME # Base font
    BASE_HEIGHT = 24                            # Base line height
    TEXT_COLOR = Color.new(255, 255, 255, 255)  # Default color
    DEFAULT_DURATION = 15                       # Duration of sequence in secs
    DEFAULT_SCROLL_DURATION = 0                 # Scoll duration in secs
    DEFAULT_SPEED = 1.0                         # Scroll speed
    ALLOW_MANUAL_CREDITS_CLOSE = true           # Manually close Scene_Credits?

    # Searches through the following files.
    # It iterates through the file list. If a file can't be found, it moves
    # on to the next file. Otherwise it loads the data and skips the rest.
    # When using a packaged file, you can append it with a symbol name. This
    # way you can store the data in a general package.
    CREDITS_FILE = ["Text/Credits.txt"]

    # This list defines the file extensions of packaged files.
    CREDITS_PACKAGED = [
    "rvdata2",
    ]

    # Font icons
    # These are icons embedded in fonts. There isn't much use for it, which
    # is why I didn't highlight this feature, but in case you do want to use
    # them, I've included a sample in the demo.

    ICON_FONTS = []

    #ICON_FONTS.push(IFT_FontAwesome::FONTAWESOME) if $imported.has_key?("IconFontTable-FontAwesome")

    #------------------------------------------------------------------------
    # Use this module (CXJ::HT_CREDITS::METHODS) or Window_Credits to add new
    # methods.
    #------------------------------------------------------------------------
    module METHODS
      def haldo
        puts("Haldo!")
      end
    end
  end
end

#==============================================================================
#
# The code below should not be altered unless you know what you're doing.
#
#==============================================================================

class HT_Credits_Data

  #------------------------------------------------------------------------
  # Initializes the credits.
  #------------------------------------------------------------------------
  def initialize(filename = '')
    @credits_base_font = CXJ::HT_CREDITS::BASE_FONT
    @credits_base_height = CXJ::HT_CREDITS::BASE_HEIGHT
    @credits_base_color = CXJ::HT_CREDITS::TEXT_COLOR
    @credits_base_duration = CXJ::HT_CREDITS::DEFAULT_DURATION
    @credits_base_scroll_duration = CXJ::HT_CREDITS::DEFAULT_SCROLL_DURATION
    @credits_base_speed = CXJ::HT_CREDITS::DEFAULT_SPEED
    @credits_text = []
    @credits_timeline = {}
    @credits_height = 0
    @credits_height_list = []
    @credits_on_credits_end_script = ""
    @credits_base_scroll_duration = CXJ::HT_CREDITS::DEFAULT_DURATION if @credits_base_scroll_duration == 0
    if(filename.empty?)
      CXJ::HT_CREDITS::CREDITS_FILE.each do |filename|
        process_file(filename)
        break if !@credits_text.empty?
      end
    else
      process_file(filename)
    end
  end

  #------------------------------------------------------------------------
  # Gets credits data as a Hash.
  #------------------------------------------------------------------------
  def get_credits_data
    data = {
    :credits => @credits_text,
    :timeline => @credits_timeline,
    :on_credits_end => @credits_on_credits_end_script,
    :settings => {
      :font => @credits_base_font,
      :line_height => @credits_base_height,
      :color => @credits_color,
      :duration => @credits_base_duration,
      :scroll_duration => @credits_base_scroll_duratino,
      :speed => @credits_base_speed,
      }
    }
  end

  #------------------------------------------------------------------------
  # Store credits data as a file.
  #------------------------------------------------------------------------
  def store_credits_data(filename)
    save_data(get_credits_data, filename)
  end

  #------------------------------------------------------------------------
  # Process a file.
  #------------------------------------------------------------------------
  def process_file(filename)
    filedata = filename.split(/:/)
    filename = filedata[0]
    return unless File.exists?(filename)
    extname = File.extname(filename)
    ext = extname[1, extname.size - 1]
    if CXJ::HT_CREDITS::CREDITS_PACKAGED.include?(ext)
      if(filedata.size > 1)
        process_packaged(filename, filedata[1].to_sym)
      else
        process_packaged(filename)
      end
    else
      process_text(filename)
    end
  end

  #------------------------------------------------------------------------
  # Process packaged credits data.
  #------------------------------------------------------------------------
  def process_packaged(filename, symbol = nil)
    credits_data = load_data(filename)
    return if(credits_data.nil?)
    if !symbol.nil?
      return if credits_data[symbol].nil?
      credits_data = credits_data[symbol]
    end
    return if @credits_text.nil?
    @credits_text = credits_data[:credits] if !credits_data[:credits].nil?
    @credits_timeline = credits_data[:timeline] if !credits_data[:timeline].nil?
    @credits_on_credits_end_script = credits_data[:on_credits_end] if !credits_data[:on_credits_end].nil?
    settings = {}
    settings = credits_data[:settings] if !credits_data[:settings].nil?
    @credits_base_font = settings[:font] if !settings[:font].nil?
    @credits_base_height = settings[:line_height] if !settings[:line_height].nil?
    @credits_color = settings[:color] if !settings[:color].nil?
    @credits_base_duration = settings[:duration] if !settings[:duration].nil?
    @credits_base_scroll_duration = settings[:scroll_duration] if !settings[:scroll_duration].nil?
    @credits_base_speed = settings[:speed] if !settings[:speed].nil?
    calculate_total_height
  end

  #------------------------------------------------------------------------
  # Process a text file.
  #------------------------------------------------------------------------
  def process_text(filename)
    credits_content = ''
    File.open(filename, "r") do |file|
      credits_content = file.read()
    end
    tag_open = :none
    credits_content.split(/[\r\n]/).each do |line|
      if line =~ /^\s*\[(.*)\]\s*$/i
        case $1
        when "credits"
          tag_open = :credits
        when "timeline"
          tag_open = :timeline
        when "settings"
          tag_open = :settings
        when "on_credits_end"
          tag_open = :on_credits_end
          @credits_on_credits_end_script = ""
        end
      else
        case tag_open
        when :credits
          line.gsub!(/\\/)    { "\e" }
          line.gsub!(/\e\e/)  { "\\" }
          @credits_text.push(line)
        when :timeline
          linepos = line.index(":")
          unless linepos.nil?
            linedata = line[0, linepos]
            posdata = line.split(/\./)
            curpos = posdata[0].to_i
            subpos = posdata[1].to_i
            subpos/= 10.0 while subpos > 1.0
            @credits_timeline[curpos + subpos] = line[linepos + 1, line.size - (linepos + 1)]
          end
        when :on_credits_end
          @credits_on_credits_end_script+= line
          @credits_on_credits_end_script+= "\n"
        when :settings
          if line =~ /^\s*(\w+)\s*=\s*(.+)\s*$/
            case $1
            when "font"
              @credits_base_font = eval("[" + $2 + "]")
            when "line_height"
              @credits_base_height = $2.to_i
            when "color"
              @credits_color = process_color($2)
            when "duration"
              @credits_base_duration = $2.to_f
            when "scroll_duration"
              @credits_base_scroll_duration = $2.to_f
            when "speed"
              @credits_base_speed = $2.to_i
            end
          end
        end
      end
    end
    calculate_total_height
  end

  #------------------------------------------------------------------------
  # Calculate total height.
  #------------------------------------------------------------------------
  def calculate_total_height
    @credits_height = 0
    height_poll = 0
    last_i = 0
    for i in 0 ... text_count
      text = text(i)
      height_poll = [height_poll, get_line_height(text)].max
      next if text =~ /\e>>/
      @credits_height+= height_poll
      while last_i <= i
        @credits_height_list[last_i] = height_poll
        last_i+=1
      end
      height_poll = 0
    end
    @credits_height+= height_poll
    while last_i < text_count
      @credits_height_list[last_i] = height_poll
      last_i+=1
    end
  end

  #------------------------------------------------------------------------
  # Process a color.
  # Colors are done in hexadecimal format.
  #------------------------------------------------------------------------
  def process_color(color)
    vals = '0123456789abcdef'
    value = 0
    color = color.downcase
    while !color.empty?
      value = (value << 4) | vals.index(color.slice!(0, 1))
    end
    Color.new((value >> 24) & 0xff, (value >> 16) & 0xff, (value >> 8) & 0xff, value & 0xff)
  end
  
  #------------------------------------------------------------------------
  # The base line height.
  #------------------------------------------------------------------------
  def base_font
    @credits_base_font
  end
  
  #------------------------------------------------------------------------
  # The base line height.
  #------------------------------------------------------------------------
  def base_height
    @credits_base_height
  end

  #------------------------------------------------------------------------
  # The default color.
  #------------------------------------------------------------------------
  def default_color
    @credits_base_color
  end

  #------------------------------------------------------------------------
  # The amount of lines stored.
  #------------------------------------------------------------------------
  def text_count
    @credits_text.size
  end

  #------------------------------------------------------------------------
  # The duration of the credits sequence.
  #------------------------------------------------------------------------
  def default_duration
    @credits_base_duration
  end

  #------------------------------------------------------------------------
  # The duration of the scrolling text.
  #------------------------------------------------------------------------
  def default_scroll_duration
    @credits_base_scroll_duration
  end

  #------------------------------------------------------------------------
  # The default speed for the scrolling text.
  # Ignored if the duration of the credits sequence is set.
  #------------------------------------------------------------------------
  def default_speed
    @credits_base_speed
  end

  #------------------------------------------------------------------------
  # A text line.
  #------------------------------------------------------------------------
  def text(index)
    @credits_text[index]
  end

  #------------------------------------------------------------------------
  # The total height of the scrolling text.
  #------------------------------------------------------------------------
  def total_height
    @credits_height
  end
    
  #------------------------------------------------------------------------
  # The height of a given line.
  #------------------------------------------------------------------------
  def get_line_height(text)
    return @credits_height_list[text] if text.kind_of?(Numeric)
    result = base_height
    text.slice(/^.*$/).scan(/\e[\{\}]/).each do |esc|
      result += 8 if result <= 64 && esc == "\e{"
    end
    result
  end

  #------------------------------------------------------------------------
  # Get the timeline data.
  #------------------------------------------------------------------------
  def get_timeline_data
    @credits_timeline
  end
  
  #------------------------------------------------------------------------
  # Get the script that should execute on credit end.
  #------------------------------------------------------------------------
  def get_on_credits_end
    return @credits_on_credits_end_script
  end
end

module CXJ
  module HT_CREDITS
    DEFAULT_CREDITS = HT_Credits_Data.new
  end
end

class Window_Credits < Window_Base
  
  include CXJ::HT_CREDITS::METHODS
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(credits_data = nil)
    super(0, 0, Graphics.width, Graphics.height)
    self.opacity = 0
    self.arrows_visible = false
	self.z = System_Settings::SCENE_CREDIT_TEXT_Z
    @credits_data = credits_data
    @credits_data = CXJ::HT_CREDITS::DEFAULT_CREDITS if @credits_data.nil?
    hide
    @credits_running = false
  end
  #--------------------------------------------------------------------------
  # * Set Credits Data
  #--------------------------------------------------------------------------
  def set_credits_data(credits_data)
    @credits_data = credits_data
  end
  #--------------------------------------------------------------------------
  # * Get Standard Padding Size
  #--------------------------------------------------------------------------
  def standard_padding
    return 0
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    super
    update_message if @text
    start_message if !@text
  end
  #--------------------------------------------------------------------------
  # * Start Message
  #--------------------------------------------------------------------------
  def start_message
    @frame_count = 0
    @frame_rate = Graphics.frame_rate
    @frame_end = (@credits_data.default_duration * @frame_rate).floor
    @frame_end = (@credits_data.default_speed * @credits_data.total_height).ceil unless @frame_end > 0
    @text = true
    calculate_speed
    refresh
    show
    @credits_running = true
  end
  #--------------------------------------------------------------------------
  # * Calculate Height of Window Contents
  #--------------------------------------------------------------------------
  def contents_height
    @all_text_height ? @all_text_height : super
  end
  #--------------------------------------------------------------------------
  # * Update Message
  #--------------------------------------------------------------------------
  def update_message
    self.oy = @scroll_pos + @speed * @frame_count
    val = @timeline[@frame_count]
    if !val.nil?
      if val.instance_of?(Symbol)
        method(val).call
      else
        eval(val)
      end
    end
    @frame_count+=1
    terminate_message if credits_end?
  end
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh
    reset_font_settings
    @all_text_height = @credits_data.total_height
    create_contents
    draw_all_text
    set_timeline
    self.oy = @scroll_pos = -height
  end
  #--------------------------------------------------------------------------
  # * End Message
  #--------------------------------------------------------------------------
  def terminate_message
    if @credits_running
      @credits_running = false
      eval(@credits_data.get_on_credits_end)
    end
    hide
  end
  
  #------------------------------------------------------------------------
  # If the credits have ended.
  #------------------------------------------------------------------------
  def credits_end?
    @frame_count > @frame_end
  end
  
  #------------------------------------------------------------------------
  # Draws all text.
  #------------------------------------------------------------------------
  def draw_all_text
    y = 0
    index = 0
    while index < @credits_data.text_count
      create_line(index, y)
      while index < @credits_data.text_count && @credits_data.text(index) =~ /\e>>/
        index+= 1
        create_line(index, y)
      end
      y+= @credits_data.get_line_height(index)
      index+= 1
    end
  end
  
  #------------------------------------------------------------------------
  # Initializes the timeline.
  #------------------------------------------------------------------------
  def set_timeline
    @timeline = {}
    @credits_data.get_timeline_data.each do |key,value|
      dur = (key * @frame_rate).floor
      val = value
      val = value[1, value.size - 1].to_sym if(value[0] == ":")
      @timeline[dur] = val
    end
  end
  
  #------------------------------------------------------------------------
  # Calculate the text speed.
  #------------------------------------------------------------------------
  def calculate_speed
    def_duration = @credits_data.default_scroll_duration * 1.0
    @speed = @credits_data.default_speed
    @remainder = 0
    if def_duration > 0
      frame_duration = def_duration * @frame_rate * 1.0
      @speed = (@credits_data.total_height + Graphics.height) / frame_duration
    end
  end
  
  #------------------------------------------------------------------------
  # Create a line.
  #------------------------------------------------------------------------
  def create_line(index, yPos)
    text = @credits_data.text(index).to_s.clone
    line_height = @credits_data.get_line_height(index)
    bitmap = Bitmap.new(Graphics.width, Graphics.height)
    data = {:x => 0, :y => 0, :align => 1, :pos => 0}
    bitmap.font.name = @credits_data.base_font
    bitmap.font.size = System_Settings::FONT_SIZE::SCENE_CREDIT_BASIC
    bitmap.font.color = CXJ::HT_CREDITS::TEXT_COLOR
    pos = "C"
    if text =~ /P([LCR])/i
      pos = $1
    end
    process_char(text.slice!(0, 1), text, bitmap, line_height, data) while !text.empty?
    case data[:align]
    when 0
      xPos = Graphics.width / 2 + data[:pos]
    when 1
      xPos = (Graphics.width - data[:x]) / 2 + data[:pos]
    when 2
      xPos = Graphics.width / 2 - data[:x] + data[:pos]
    end
    line_width = [1,data[:x]].max
    place_rect = Rect.new(0, 0, line_width, [line_height * 2, Graphics.height].min)
    contents.blt(xPos, yPos, bitmap, place_rect,200)
    bitmap.dispose
  end

  #------------------------------------------------------------------------
  # Process a character.
  #------------------------------------------------------------------------
  def process_char(char, text, bitmap, line_height, data)
    if char == "\e"
      process_special_character(text.slice!(0, 1), text, bitmap, line_height, data)
    else
      rect = bitmap.text_size(char)
      bitmap.font.outline = false
	  
      bitmap.draw_text(data[:x], data[:y], rect.width * 2, line_height, char)
      data[:x]+= rect.width
    end
  end
  
  #------------------------------------------------------------------------
  # Get icon font
  #------------------------------------------------------------------------
  def get_icon_font(font_code)
    CXJ::HT_CREDITS::ICON_FONTS.each do |icon_font|
      prefix = icon_font[:prefix]
      return icon_font if font_code.start_with?(prefix)
    end
    return nil
  end
  
  #------------------------------------------------------------------------
  # Process a special character.
  #------------------------------------------------------------------------
  def process_special_character(char, text, bitmap, line_height, data)
    case char
    when "i", "I"
      if text.slice(0,2).upcase == "FT"
        text.slice!(0,2)
        font_code = text.slice!(/^\[.+?\]/)[/[^\[\]]+/] #/
        icon_font = get_icon_font(font_code)
        return if icon_font.nil?
        glyph_name = font_code.to_s.clone
        glyph_name.slice!(0,icon_font[:prefix].size)
        return if !icon_font[:glyph].has_key?(glyph_name)
        return_char = eval("\"\\u{" + icon_font[:glyph][glyph_name] + "}\"")
        current_font_name = bitmap.font.name
        bitmap.font.name = icon_font[:name]
        rect = bitmap.text_size(return_char)
        bitmap.draw_text(data[:x], data[:y], rect.width * 2, line_height, return_char)
        bitmap.font.name = current_font_name
        data[:x]+= rect.width
      end
    when "c", "C"
      bitmap.font.color = @credits_data.process_color(text.slice!(0, 8))
    when "{"
      bitmap.font.size += System_Settings::FONT_SIZE::SCENE_CREDIT_SWITCH if bitmap.font.size <= System_Settings::FONT_SIZE::SCENE_CREDIT_MAX
    when "}"
      bitmap.font.size -= System_Settings::FONT_SIZE::SCENE_CREDIT_SWITCH if bitmap.font.size >= System_Settings::FONT_SIZE::SCENE_CREDIT_MAX
    when "a", "A"
      align = text.slice!(0, 1)
      case align
      when "l", "L"
        data[:align] = 0
      when "r", "R"
        data[:align] = 2
      when "c", "C"
        data[:align] = 1
      end
    when ">"
      text.slice!(0, 1)
    when "p", "P"
      cur_char = text.slice!(0, 1)
      if cur_char =~ /[0-8]/i
        data[:pos] = Graphics.width / ((cur_char.to_i - 4) * 2)
      else
        case cur_char
        when "L"
          data[:pos] = 0 - Graphics.width / 2
        when "R"
          data[:pos] = Graphics.width / 2
        when "C"
          data[:pos] = 0
        end
      end
    when "u"
      next_char = text.slice(0, 1)
      return_char = '';
      if next_char != "{"
        return_char = eval("\"\\u{" + text.slice!(0, 4) + "}\"")
      else
        next_char = "";
        eval_char = "\"\\u";
        while next_char != "}" && !text.empty?
          next_char = text.slice!(0, 1)
          eval_char+= next_char
        end
        eval_char+= "\"";
        return_char = eval(eval_char)
      end
      rect = bitmap.text_size(return_char)
      bitmap.draw_text(data[:x], data[:y], rect.width * 2, line_height, return_char)
      data[:x]+= rect.width
    end
  end
end

class Scene_Credits < Scene_Map
  #--------------------------------------------------------------------------
  # * Start Processing
  #--------------------------------------------------------------------------
  def start
	$loading_screen.dispose if $loading_screen
	if $game_player.force_update == true
		#$game_party.setup_starting_members
		$game_map.setup($data_tag_maps["Credit"].sample)
		$game_player.moveto(1,1)
		#$game_player.opacity = 0
		$game_portraits.lprt.hide
		$game_portraits.rprt.hide
		#$game_player.followers.visible = false
		#$game_player.refresh
		#$game_player.make_encounter_count
	
		#@character_name = $game_player.character_name
		#@character_index = $game_player.character_index
		$game_player.force_update = false
		Graphics.frame_count = 0
	end
	
	super
	draw_TheEnd_mode
	$game_system.menu_disabled = true
	@hud.hide
	@window_credits = Window_Credits.new
	$game_map.clear_fog
	@rebirthWait= 120
	$hudForceHide = true
	$hudForceHideAll = true
	$balloonForceHide = true
  end
  
	def draw_TheEnd_mode
		tmpW=Graphics.width
		tmpH=Graphics.height
		@foreground_TheEnd = Sprite.new
		@foreground_TheEnd.bitmap = Bitmap.new(Graphics.width, Graphics.height)
		@foreground_TheEnd.z = System_Settings::TITLE_FOREGROUND_Z
		@foreground_TheEnd.bitmap.font.size = System_Settings::FONT_SIZE::SCENE_CREDIT_END
		@foreground_TheEnd.bitmap.font.outline = false
		rect = Rect.new(0, (tmpH/2)-40, Graphics.width-10,60)
		@foreground_TheEnd.bitmap.draw_text(rect,"THANKS FOR PLAYING", 1)
		@foreground_TheEnd.opacity = 0
	end
  #------------------------------------------------------------------------
  # Update
  #------------------------------------------------------------------------
  def update
    super
		if Input.trigger?(:B) || Input.trigger?(:C) || WolfPad.trigger?(:X_LINK) || WolfPad.trigger?(:Z_LINK) || Input.trigger?(:MX_LINK) || Input.trigger?(:MZ_LINK)#&& CXJ::HT_CREDITS::ALLOW_MANUAL_CREDITS_CLOSE) || @window_credits.credits_end?
			@ending = true
		end
		@foreground_TheEnd.opacity +=1 if @window_credits.credits_end? && @foreground_TheEnd.opacity < 200
		@window_credits.terminate_message if @foreground_TheEnd.opacity >= 200 && @credits_running == true
		if @ending
			@window_credits.credits_end? ? SndLib.ppl_Cheer : SndLib.ppl_Boo
			@foreground_TheEnd.dispose
			@window_credits.terminate_message
			fadeout_all
			if $inheritance
				$game_player.force_update = false
				DataManager.setup_new_game(true,"NoerSewer")
				$inheritance = nil
				SceneManager.goto(Scene_Map)
				GabeSDK.getAchievement("Rebirth")
			else
				$game_player.force_update = true
				SceneManager.goto(Scene_MapTitle)
			end
		end
  end
end

module CXJ
  module HT_CREDITS
    #------------------------------------------------------------------------
    # Refresh the credits window.
    # It will automatically create and open a window if it hasn't.
    #------------------------------------------------------------------------
    def self.refresh(credits_data = nil)
      if @credits_window.nil?
        @credits_window = Window_Credits.new(credits_data)
        @credits_viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
        @credits_viewport.z = 300
        @credits_window.viewport = @credits_viewport
      end
      if (@credits_data.nil? && !credits_data.nil?) || (!credits_data.nil? && @credits_data != credits_data)
        @credits_data = credits_data
        @credits_window.set_credits_data(credits_data)
      end
      @credits_window.start_message
    end
    
    #------------------------------------------------------------------------
    # Update.
    #------------------------------------------------------------------------
    def self.update
      @credits_window.update if !@credits_window.nil? && @credits_window.visible
    end
    
    #------------------------------------------------------------------------
    # Whether the credits have ended or not.
    #------------------------------------------------------------------------
    def self.credits_end?
      @credits_window.credits_end?
    end
    
    #------------------------------------------------------------------------
    # Manually terminates the window.
    #------------------------------------------------------------------------
    def self.terminate_message
      @credits_window.terminate_message
    end
    
    #------------------------------------------------------------------------
    # Gets the opacity of the credits window.
    #------------------------------------------------------------------------
    def self.opacity
      return @credits_window.contents_opacity
    end
    
    #------------------------------------------------------------------------
    # Sets the opacity of the credits window.
    #------------------------------------------------------------------------
    def self.opacity=(value)
      @credits_window.contents_opacity=value
    end
  end
end

#==============================================================================
# ** Scene_Base
#------------------------------------------------------------------------------
#  This is a super class of all scenes within the game.
#==============================================================================

class Scene_Base
  #--------------------------------------------------------------------------
  # * Alias: Update Frame (Basic)
  #--------------------------------------------------------------------------
	scene_base_update_basic_cxj_htcredits = instance_method(:update_basic)
	define_method :update_basic do
		scene_base_update_basic_cxj_htcredits.bind(self).call
		CXJ::HT_CREDITS.update
	end
end
