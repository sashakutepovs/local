#==============================================================================
# 
# ▼ Yanfly Engine Ace - Debug Extension v1.01
# -- Last Updated: 2012.01.05
# -- Level: Easy, Normal
# -- Requires: n/a
# 
#==============================================================================
#==============================================================================
# ▼ Updates
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# 2015.09.01 - Delayed the generation of the windows until they are needed.
# 2012.01.05 - Script no longer conflicts with conditional Key presses.
# 2012.01.04 - Started Script and Finished.
# 
#==============================================================================
# ▼ Introduction
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# While the RPG Maker VX Ace debug menu gets the basics done, this script will
# add on even more functionality. This script provides an extended debug menu,
# common event shortcuts that can be ran from a few key presses, and even an
# input console to manually insert code and run it.
# 
#==============================================================================
# ▼ Instructions
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# To install this script, open up your script editor and copy/paste this script
# to an open slot below ▼ Materials/素材 but above ▼ Main. Remember to save.
# 
# -----------------------------------------------------------------------------
# Debug Shortcuts - Only during $TEST and $BTEST mode
# -----------------------------------------------------------------------------
# Alt   + F5-F9 - Common Event Debug Shortcut
# Ctrl  + F5-F9 - Common Event Debug Shortcut
# Shift + F5-F9 - Common Event Debug Shortcut
# F9 on the map - Open Debug Menu.
# 
# F10 anywhere - Opens up the Debug Entry Window.
#   Here, you may enter in a piece of code and the script itself will run it
#   using the current scene as its host. So long as the code doesn't contain
#   any syntax errors, it'll run right immediately. Idea by OriginalWij.
# 
#==============================================================================
# ▼ Compatibility
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This script is made strictly for RPG Maker VX Ace. It is highly unlikely that
# it will run with RPG Maker VX without adjusting.
# 
#==============================================================================

module YEA
  module DEBUG
    
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # - Common Event Shortcut Settings -
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # Here, you can define common event shortcuts to launch during test play
    # mode and pressing the right shortcut combination. If you do not wish to
    # use a particular shortcut key, set it to 0.
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # Common event shortcuts when holding down ALT and pressing an F5-F9 key.
    ALT ={ # Only works during test play mode.
      :F5 => 0,
      :F6 => 0,
      :F7 => 0,
      :F8 => 0,
      :F9 => 0,
    } # Do not remove this.
    
    # Common event shortcuts when holding down CTRL and pressing an F5-F9 key.
    CTRL ={ # Only works during test play mode.
      :F5 => 0,
      :F6 => 0,
      :F7 => 0,
      :F8 => 0,
      :F9 => 0,
    } # Do not remove this.
    
    # Common event shortcuts when holding down SHIFT and pressing an F5-F9 key.
    SHIFT ={ # Only works during test play mode.
      :F5 => 0,
      :F6 => 0,
      :F7 => 0,
      :F8 => 0,
      :F9 => 0,
    } # Do not remove this.
    
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # - Debug Menu Settings -
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # The following adjusts debug menu data. There's no real need to edit
    # anything here unless you feel like it. Here's what the commands do:
    #   :switches     Adjust switches like default.
    #   :variables    Adjust variables like default.
    #   :teleport     Teleport to different maps.
    #   :battle       Enter the selected battle.
    #   :events       Call common events from menu.
    #   :items        Adjust item quantities.
    #   :weapons      Adjust weapon quantities.
    #   :armours      Adjust armour quantities.
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # Command window layout for the debug menu. Determines order and which
    # commands will be shown in the command window.
    COMMANDS =[
      [ :switches,  "Switches"],
      [:variables, "Variables"],
      [ :teleport,  "Teleport"],
      [   :battle,    "Battle"],
      [   :events,    "Events"],
      [    :items,     "Items"],
      [  :weapons,   "Weapons"],
      [  :armours,   "Armours"],
    ] # Do not remove this.
    
  end # DEBUG
end # YEA


module Input
  
  #--------------------------------------------------------------------------
  # constants - Created by OriginalWij and Yanfly
  #--------------------------------------------------------------------------
  DEFAULT = [:DOWN, :LEFT, :RIGHT, :UP, :A, :B, :C, :X, :Y, :Z, :L, :R,
    :SHIFT, :CTRL, :ALT, :F5, :F6, :F7, :F8, :F9]
  
  LETTERS = {}
  LETTERS['A'] = 65; LETTERS['B'] = 66; LETTERS['C'] = 67; LETTERS['D'] = 68
  LETTERS['E'] = 69; LETTERS['F'] = 70; LETTERS['G'] = 71; LETTERS['H'] = 72
  LETTERS['I'] = 73; LETTERS['J'] = 74; LETTERS['K'] = 75; LETTERS['L'] = 76
  LETTERS['M'] = 77; LETTERS['N'] = 78; LETTERS['O'] = 79; LETTERS['P'] = 80
  LETTERS['Q'] = 81; LETTERS['R'] = 82; LETTERS['S'] = 83; LETTERS['T'] = 84
  LETTERS['U'] = 85; LETTERS['V'] = 86; LETTERS['W'] = 87; LETTERS['X'] = 88
  LETTERS['Y'] = 89; LETTERS['Z'] = 90
  
  NUMBERS = [48, 49, 50, 51, 52, 53, 54, 55, 56, 57]
  NUMPAD = [96, 97, 98, 99, 100, 101, 102, 103, 104, 105]
  
  BACK   = 0x08; ENTER  = 0x0d; SPACE  = 32;  SCOLON = 186; ESC    = 157
  QUOTE  = 222; EQUALS = 187; COMMA  = 188; USCORE = 189; PERIOD = 190
  SLASH  = 191; LBRACE = 219; RBRACE = 221; BSLASH = 220; TILDE  = 192
  F10    = 121; F11    = 122; F12    = 123; CAPS   = 20;  NMUL   = 106; NPLUS  = 107
  NSEP   = 108; NMINUS = 109; NDECI  = 110; NDIV   = 111; 
  
  Extras = [USCORE, EQUALS, LBRACE, RBRACE, BSLASH, SCOLON, QUOTE, COMMA,
   PERIOD, SLASH, NMUL, NPLUS, NSEP, NMINUS, NDECI, NDIV]

  #--------------------------------------------------------------------------
  # initial module settings - Created by OriginalWij and Yanfly
  #--------------------------------------------------------------------------
  GetKeyState = Win32API.new("user32", "GetAsyncKeyState", "i", "i") 
  GetCapState = Win32API.new("user32", "GetKeyState", "i", "i") 
  KeyRepeatCounter = {}
  
  module_function
  #--------------------------------------------------------------------------
  # new method: default_key? - Created by Yanfly
  #--------------------------------------------------------------------------
  def self.default_key?(key)
    return true if key.is_a?(Integer) && key < 30
    return DEFAULT.include?(key)
  end
  
  #--------------------------------------------------------------------------
  # new method: adjust_key - Created by OriginalWij
  #--------------------------------------------------------------------------
  def self.adjust_key(key)
    key -= 130 if key.between?(130, 158)
    return key
  end
  
  #--------------------------------------------------------------------------
  # new method: key_pressed? - Created by OriginalWij
  #--------------------------------------------------------------------------
  def self.key_pressed?(key)
    if (GetKeyState.call(key).abs & 0x8000 == 0x8000)
      KeyRepeatCounter[key] = 0
      return true
    end
    return false
  end
  
  #--------------------------------------------------------------------------
  # new method: typing? - Created by Yanfly
  #--------------------------------------------------------------------------
  def self.typing?
    return true if repeat?(SPACE)
    for i in 'A'..'Z'
      return true if repeat?(LETTERS[i])
    end
    for i in 0...NUMBERS.size
      return true if repeat?(NUMBERS[i])
      return true if repeat?(NUMPAD[i])
    end
    for key in Extras
      return true if repeat?(key)
    end
    return false
  end
  
  #--------------------------------------------------------------------------
  # new method: key_type - Created by Yanfly
  #--------------------------------------------------------------------------
  def self.key_type
    return " " if repeat?(SPACE)
    for i in 'A'..'Z'
      next unless repeat?(LETTERS[i])
      return upcase? ? i.upcase : i.downcase
    end
    for i in 0...NUMBERS.size
      return i.to_s if repeat?(NUMPAD[i])
      if !press?(KEYMAP[:SHIFT])
        return i.to_s if repeat?(NUMBERS[i])
      elsif repeat?(NUMBERS[i])
        case i
        when 1; return "!"
        when 2; return "@"
        when 3; return "#"
        when 4; return "$"
        when 5; return "%"
        when 6; return "^"
        when 7; return "&"
        when 8; return "*"
        when 9; return "("
        when 0; return ")"
        end
      end
    end
    for key in Extras
      next unless repeat?(key)
      case key
      when USCORE; return press?(KEYMAP[:SHIFT]) ? "_" : "-"
      when EQUALS; return press?(KEYMAP[:SHIFT]) ? "+" : "="
      when LBRACE; return press?(KEYMAP[:SHIFT]) ? "{" : "["
      when RBRACE; return press?(KEYMAP[:SHIFT]) ? "}" : "]"
      when BSLASH; return press?(KEYMAP[:SHIFT]) ? "|" : "\\"
      when SCOLON; return press?(KEYMAP[:SHIFT]) ? ":" : ";"
      when QUOTE;  return press?(KEYMAP[:SHIFT]) ? '"' : "'"
      when COMMA;  return press?(KEYMAP[:SHIFT]) ? "<" : ","
      when PERIOD; return press?(KEYMAP[:SHIFT]) ? ">" : "."
      when SLASH;  return press?(KEYMAP[:SHIFT]) ? "?" : "/"
      when NMUL;   return "*"
      when NPLUS;  return "+"
      when NSEP;   return ","
      when NMINUS; return "-"
      when NDECI;  return "."
      when NDIV;   return "/"
      end
    end
    return ""
  end
  
  #--------------------------------------------------------------------------
  # new method: upcase? - Created by Yanfly
  #--------------------------------------------------------------------------
  def self.upcase?
    return !press?(KEYMAP[:SHIFT]) if GetCapState.call(CAPS) == 1
    return true if press?(KEYMAP[:SHIFT])
    return false
  end
  
end # Input

#==============================================================================
# ■ Clipboard
#==============================================================================
module Clipboard
  # Version: 1.2.3
  # Last Update: March 22nd, 2014
  # Author: Zalerinian (~ZF)
  # Clipboard functions
  OpenClipboard = Win32API.new('user32', 'OpenClipboard', ['I'], 'I');
  CloseClipboard = Win32API.new('user32', 'CloseClipboard', [], 'I');
  EmptyClipboard = Win32API.new('user32', 'EmptyClipboard', [], 'I');
  GetClipboardData = Win32API.new('user32', 'GetClipboardData', ['I'], 'I');
  SetClipboardData = Win32API.new('user32', 'SetClipboardData', ['I', 'I'], 'I');
  Alloc = Win32API.new('kernel32', 'GlobalAlloc', ['I','I'], 'I');
  Lock = Win32API.new('kernel32', 'GlobalLock', ['I'], 'P');
  Unlock = Win32API.new('kernel32', 'GlobalUnlock', ['I'], 'I');
  Len = Win32API.new('kernel32', 'lstrlenA', ['P'], 'I');
  Copy = Win32API.new('kernel32', 'lstrcpyA', ['I', 'P'], 'P');
  LockI = Win32API.new('kernel32', 'GlobalLock', ['I'], 'I');
  
  
  #--------------------------------------------------------------------------
  # Clipboard: GetText                                             NEW METHOD
  #  * This method will get the text currently on the users clipboard and
  #  * return it.
  #--------------------------------------------------------------------------
  def self.GetText
    result = ""
    if OpenClipboard.Call(0) != 0
      if (h = GetClipboardData.Call(1)) != 0
        if (p = Lock.Call(h)) != 0
          result = p;
          Unlock.Call(h);
        end
      end
      CloseClipboard.Call;
    end
    return result;
  end
  
  #--------------------------------------------------------------------------
  # Clipboard: SetText                                             NEW METHOD
  #  * This will allow you to set the text of the clipboard so that the user
  #  * may paste information elsewhere.
  #--------------------------------------------------------------------------  
  def self.SetText(text)
    if (text == nil) || (text == "")
      return
    end
    if OpenClipboard.Call(0) != 0
      EmptyClipboard.Call();
      len = Len.Call(text);
      hmem = Alloc.Call(0x2000, len+1);
      pmem = LockI.Call(hmem);
      Copy.Call(pmem, text);
      SetClipboardData.Call(1, hmem);
      Unlock.Call(hmem);
      CloseClipboard.Call;
    end
  end
end # Clipboard

#==============================================================================
# ■ SceneManager
#==============================================================================

module SceneManager
  
  #--------------------------------------------------------------------------
  # new method: self.force_recall
  #--------------------------------------------------------------------------
  def self.force_recall(scene_class)
    @scene = scene_class
  end
  
end # SceneManager

#==============================================================================
# ■ Sprite_DebugMap
#==============================================================================


#==============================================================================
# ■ Scene_Base
#==============================================================================

class Scene_Base
	#include EvLib
	#
	## bring in the singleton methods as instance methods
	#EvLib.singleton_methods.each do |m|
	#	define_method(m) do |*args, &block|
	#		EvLib.send(m, *args, &block)
	#	end
	#end


	#attr_accessor :code_rec
	#attr_accessor :code_rec_cur
  
  #--------------------------------------------------------------------------
  # alias method: update_basic
  #--------------------------------------------------------------------------
  
  #--------------------------------------------------------------------------
  # new method: trigger_debug_window_entry
  #--------------------------------------------------------------------------
  def trigger_debug_window_entry
		#return unless $TEST || $BTEST
		if Input.trigger?(Input::F10)
			SndLib.sys_ok
			process_debug_window_entry
		end
  end
  #--------------------------------------------------------------------------
  # new method: process_debug_window_entry
  #--------------------------------------------------------------------------
	#def process_debug_window_entry
	#	if !$data_ConsoleCodeREC
	#		$data_ConsoleCodeREC = [] if !$TEST
	#		$data_ConsoleCodeREC = [
	#			'load_script("asd.rb")',
	#			'EvLib.GMI.new_game_GetDebugSkills',
	#			'EvLib.UpLang'
	#		] if $TEST
	#		
	#	end
	#	$data_ConsoleCodeREC_cur = 0 if $data_ConsoleCodeREC_cur
	#	Graphics.freeze
	#	viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
	#	viewport.z = 8000
	#	@debug_entry_window = Window_DebugEntry.new($data_ConsoleCodeREC)
	#	@debug_entry_window.viewport = viewport
	#	@debug_entry_window_PRP_REC = Window_Debug_PRP_REC.new
	#	@debug_entry_window_PRP_REC.viewport = viewport
	#	Graphics.transition(4)
	#	#---
	#	update_debug_window_entry
	#	#---
	#	Graphics.freeze
	#	@debug_entry_window.dispose
	#	@debug_entry_window = nil
	#	@debug_entry_window_PRP_REC.dispose
	#	@debug_entry_window_PRP_REC = nil
	#	viewport.dispose
	#	Graphics.transition(4)
	#end
  def process_debug_window_entry
	  #==========================================================
	  # 1. 讀取 ConsoleHistory.txt（若無→建立）
	  #==========================================================
	  history_path = File.join(Dir.pwd, "UserData/ConsoleHistory.txt")
	  console_history = []
	  
	  
	  # 若檔案不存在 → 建立空檔案
	  unless File.exist?(history_path)
		  File.open(history_path, "w:utf-8") {}  # 空檔案
	  end
	  
	  begin
		  # 讀取、strip、排除 ENTER 空白行
		  lines = File.readlines(history_path, chomp: true)
		  console_history = lines.map { |s| s.strip }.reject(&:empty?)
	  rescue => err
		  prp "History Load Error: #{err.message}", 1
		  console_history = []
	  end
	  #==========================================================
	  # 2. 根據 $TEST 與 $data_ConsoleCodeREC 建立 Console 記錄
	  #==========================================================
	  if $TEST && !$data_ConsoleCodeREC
		  # TEST 模式 → 讀入歷史 + 放三個常用指令於末端
		  $data_ConsoleCodeREC = console_history.clone
		  
		  debug_cmds = [
			  'load_script("asd.rb")',
			  'EvLib.GMI.new_game_GetDebugSkills',
			  'EvLib.UpLang'
		  ]
		  
		  # 確保歷史中若有舊版本 → 移除
		  debug_cmds.each { |cmd| $data_ConsoleCodeREC.delete(cmd) }
		  
		  # 加到最新位置
		  debug_cmds.each { |cmd| $data_ConsoleCodeREC << cmd }
		  
	  elsif !$data_ConsoleCodeREC
		  # 非 TEST → 只吃歷史紀錄（可能是空）
		  $data_ConsoleCodeREC = console_history.clone
	  end
	  
	  #==========================================================
	  # 後續為你原本的初始化流程
	  #==========================================================
	  $data_ConsoleCodeREC_cur = 0 if $data_ConsoleCodeREC_cur
	  Graphics.freeze
	  viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
	  viewport.z = 8000
	  @debug_entry_window = Window_DebugEntry.new($data_ConsoleCodeREC)
	  @debug_entry_window.viewport = viewport
	  @debug_entry_window_PRP_REC = Window_Debug_PRP_REC.new
	  @debug_entry_window_PRP_REC.viewport = viewport
	  Graphics.transition(4)
	  update_debug_window_entry
	  Graphics.freeze
	  @debug_entry_window.dispose
	  @debug_entry_window = nil
	  @debug_entry_window_PRP_REC.dispose
	  @debug_entry_window_PRP_REC = nil
	  viewport.dispose
	  Graphics.transition(4)
  end
  
  
  #--------------------------------------------------------------------------
  # new method: update_debug_window_entry
  #--------------------------------------------------------------------------
	def update_debug_window_entry
		execute_command = nil
		loop do
			Graphics.update
			Input.update
			@debug_entry_window.update
			@debug_entry_window_PRP_REC.update
			if Input.trigger?(Input::ESC)
				SndLib.sys_cancel
				if @debug_entry_window.text.size > 0
					@debug_entry_window.text = ""
				else
					break
				end
				
			elsif Input.press?(:SHIFT) && Input.trigger?(Input::F10)
				break execute_command = "resetRGSS"
			elsif Input.trigger?(Input::F10)
				SndLib.sys_cancel
				break
			elsif Input.trigger?(Input::ENTER)
				code = @debug_entry_window.text
				begin
					$data_ConsoleCodeREC = $data_ConsoleCodeREC.last(System_Settings::Console::HISTORY_CAP-1) if $data_ConsoleCodeREC.length >= System_Settings::Console::HISTORY_CAP
					$data_ConsoleCodeREC << code
					@debug_entry_window.code_rec = $data_ConsoleCodeREC
					prp "=> #{code}",2
					eval(code)
					SndLib.sys_ok
					@debug_entry_window.clearn_characters
					@debug_entry_window.update_record_array($data_ConsoleCodeREC,code)
					@debug_entry_window.refresh
					@debug_entry_window_PRP_REC.refresh
					save_console_history
					#end
				rescue Exception => ex
					begin
						evlibCode = "EvLib."+code
						$data_ConsoleCodeREC = $data_ConsoleCodeREC.last(System_Settings::Console::HISTORY_CAP-1) if $data_ConsoleCodeREC.length >= System_Settings::Console::HISTORY_CAP
						$data_ConsoleCodeREC << code
						@debug_entry_window.code_rec = $data_ConsoleCodeREC
						#prp "=> #{evlibCode}",2
						eval(evlibCode)
						SndLib.sys_ok
						code = evlibCode
						@debug_entry_window.clearn_characters
						@debug_entry_window.update_record_array($data_ConsoleCodeREC,code)
						@debug_entry_window.refresh
						@debug_entry_window_PRP_REC.refresh
						save_console_history
						#end
					rescue Exception => ex
						prp "ERROR: #{ex.message}",1	#print error message
						@debug_entry_window_PRP_REC.refresh
						SndLib.sys_buzzer
					end
				end
			end
		end
		eval(execute_command) if execute_command
	end
	def save_console_history
		begin
			# 遊戲根目錄
			path = File.join(Dir.pwd, "UserData/ConsoleHistory.txt")
			
			# 最多 10 行
			lines = $data_ConsoleCodeREC.last(System_Settings::Console::HISTORY_CAP)
			
			# 寫入文字檔
			File.open(path, "w:utf-8") do |file|
				lines.each { |l| file.puts(l) }
			end
			
		rescue Exception => ex
			prp "SAVE HISTORY ERROR: #{ex.message}", 1
		end
	end
	def resetRGSS
		begin
			if $TEST
				spawn("Game.exe console test")
			else
				spawn("Game.exe")
			end
		rescue => e
			msgbox $game_text["umm:manager:top_menu/restart_failed"]
			p e.message + "\n" + e.backtrace.join("\n")
		end
		exit 0
	end
end # Scene_Base

class Window_Debug_PRP_REC < Window_Base
	def initialize
		dx = -standard_padding
		@dy = 0 - standard_padding
		dw = Graphics.width + standard_padding * 2
		dh = Graphics.height
		super(dx, @dy, dw, dh)

		contents.font.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
		contents.font.bold = false
		contents.font.italic = false
		contents.font.shadow = false
		contents.font.outline = true
		contents.font.size = System_Settings::FONT_SIZE::CONSOLE_OUTPUT
		contents.font.color = Color.new(255, 255, 255)

		self.z -= 1
		self.y = -dh
		self.opacity = 255

		refresh
	end

	def refresh
		contents.clear
		max_lines = contents.height / contents.font.size

		contents.font.color = Color.new(255, 255, 255)
		contents.draw_text(
			Rect.new(4, Graphics.height - contents.font.size * 4, Graphics.width - standard_padding, 24),
			" " + DataManager.export_full_ver_info,
			2
		)

		$PRP_REC.each_with_index do |(rec, color), i|
		break if i >= max_lines

			contents.font.color = case color
				when 1 then Color.new(255, 63, 0)
				when 2 then Color.new(42, 255, 0)
				when 3 then Color.new(66, 101, 255)
				when 4 then Color.new(0, 255, 255)
				when 5 then Color.new(255, 0, 255)
				when 6 then Color.new(255, 255, 0)
				else Color.new(255, 255, 255)
			end

			contents.draw_text(Rect.new(8, i * contents.font.size, 8192, 24), rec, 0)
		end
	end

	def update
		super
		return if self.y >= @dy
		self.y += Graphics.height / 4
		self.y = @dy if self.y >= @dy
	end
end




class Window_DebugEntry < Window_Base
	attr_accessor :text
	attr_accessor :code_rec
	
	def initialize(code_rec)
		dx = -standard_padding
		dy = Graphics.height - fitting_height(1) + standard_padding
		dw = Graphics.width + standard_padding * 2
		dh = fitting_height(1)
		super(dx, dy, dw, dh)
		contents.font.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
		contents.font.bold = false
		contents.font.italic = false
		contents.font.shadow = false
		contents.font.outline = false
		contents.font.size = System_Settings::FONT_SIZE::CONSOLE_INPUT
		contents.font.color = Color.new(255, 255, 255)
		self.opacity = 0
		@text = ""
		update_record_array(code_rec,current_code=nil)
		@text_pos = 0
		@rect = Rect.new(4, 0, 8192, 24)
		refresh
	end
	
	def refresh
		contents.clear
		cw = contents.width
		contents.fill_rect(0, 0, cw, line_height, Color.new(192, 192, 192))
		contents.fill_rect(1, 1, contents.width-2, line_height-2, Color.new(0, 0, 0))
		if @blink
			tmpTEXT = @text.clone
			contents.draw_text(@rect, tmpTEXT.insert(@text_pos, "|"), 0)
		else
			tmpTEXT = @text.clone
			contents.draw_text(@rect, tmpTEXT.insert(@text_pos, " "), 0)
		end
	end
			
	def update
		super
		@blink = !@blink if (Graphics.frame_count % 30 == 0)
		maximum = 256
		if Input.repeat?(:DOWN) && $data_ConsoleCodeREC.length > 0
			@text = "#{$data_ConsoleCodeREC[@current_code_rec]}"
			@text_pos = @text.size
			@current_code_rec += 1
			@current_code_rec = $data_ConsoleCodeREC.length-1 if @current_code_rec > $data_ConsoleCodeREC.length-1
		# user clipboard access:
		elsif Input.repeat?(:LETTER_V) && Input.press?(:CTRL) && @text.size <= maximum
			clipboard_text = Clipboard.GetText
			if @text[@text_pos] == 'v'
				char_arr = @text.chars
				char_arr.delete_at(@text_pos)
				@text = char_arr.join
			end
			if @text.size + clipboard_text.size <= maximum
				@text.insert(@text_pos, clipboard_text)
				@text_pos += clipboard_text.size
			end
		#
		elsif Input.repeat?(:UP) && $data_ConsoleCodeREC.length > 0
			@text = "#{$data_ConsoleCodeREC[@current_code_rec]}"
			@text_pos = @text.size
			@current_code_rec -= 1
			@current_code_rec = 0 if @current_code_rec < 0
		elsif Input.repeat?(:RIGHT) && @text.size > 0
			Input.press?(:CTRL) ? @text_pos += 7 : @text_pos += 1
			if @text_pos > @text.size
				SndLib.sys_buzzer
				@text_pos = @text.size
			end
		elsif Input.repeat?(:LEFT) && @text.size > 0
			Input.press?(:CTRL) ? @text_pos -= 7 : @text_pos -=1
			if @text_pos < 0
				SndLib.sys_buzzer
				@text_pos = 0
			end
		elsif Input.repeat?(:DELETE)# && @text.size > 0
			Input.press?(:CTRL) ? howMany = 7 : howMany =1
			howMany.times{
				if @text_pos >= @text.size
					#SndLib.sys_buzzer
					@text_pos = @text.size
				else
					@text[@text_pos] = ""
				end
			}
		elsif Input.typing? && @text.size <= maximum
			#@text += Input.key_type
			@text.insert(@text_pos, Input.key_type)
			@text_pos +=1
		elsif Input.repeat?(Input::BACK) && @text.size > 0
			Input.press?(:CTRL) ? howMany = 7 : howMany =1
			howMany.times{
				return if @text_pos == 0
				@text[@text_pos - 1] = ""
				@text_pos -=1
			}
		end
		refresh
	end
	def clearn_characters
		@text_pos = 0
		@text = ""
	end
	def update_record_array(data,importCode=nil)
		$data_ConsoleCodeREC = data
		$data_ConsoleCodeREC.shift if $data_ConsoleCodeREC.length >= System_Settings::CONSOLE_MAX_RECORD #remove first array 
		$data_ConsoleCodeREC = $data_ConsoleCodeREC.uniq #remove same command
		@current_code_rec = [0,$data_ConsoleCodeREC.length-1].max
		if importCode && $data_ConsoleCodeREC.include?(importCode) #if same command. move this input to array last index
			$data_ConsoleCodeREC.delete(importCode)
			$data_ConsoleCodeREC << importCode
		end
	end
end # Window_DebugEntry
