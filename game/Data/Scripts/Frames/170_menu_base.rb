#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
# Scene Menu
# Overwritten methods:
# - class Scene_Menu < Scene_MenuBase
#   - start
#   - create_background
#   - update
#   - terminate



#==============================================================================
# ** Scene_Menu
#------------------------------------------------------------------------------
#  Rewrite scene.
#==============================================================================

class Scene_Menu < Scene_MenuBase
#class Scene_Menu < Scene_Map
	ROOT = 'Graphics/System/Menu/'
	attr_reader :menu
	attr_reader :gauge
	attr_reader :cursor
	attr_reader :contents
	attr_reader :menu_index
	attr_reader :mouse_all_rects
	def start
		DataManager.doAutoSave(tmpDepose=false,doomOnly=true)  if !$game_system.menuSystem_disabled && !$game_map.interpreter.running? && !$game_message.busy?
		$hudForceHide = true
		$balloonForceHide = true
		$cg.erase
		$bg.erase
		contents = []
		contents << [$game_text["menu:core/main_stats"]			,Menu_MainStats			] 
		contents << [$game_text["menu:core/body_stats"]			,Menu_HealthStats		] 
		contents << [$game_text["menu:core/sex_stats"]			,Menu_SexStats			] 
		contents << [$game_text["menu:core/equips"]				,Menu_Equips			] if !$game_player.cannot_control
		contents << [$game_text["menu:core/items"]				,Menu_Items				] if !$game_player.cannot_control
		contents << [$game_text["menu:core/skills"]				,Menu_SkillAndHotkey	] if !$game_player.cannot_control
		contents << [$game_text["menu:core/traits"]				,Menu_Traits			] 
		contents << [$game_text["menu:core/letter"]				,Menu_Quests			] 
		contents << [$game_text["menu:core/system"]				,Menu_System			] if !$game_system.menuSystem_disabled
		#contents << [$game_text["menu:Shop/Cancel"]				,Menu_Exit				] if Mouse.usable?
		$game_portraits.setRprt("Lona")
		create_background
		create_menu(Array.new(contents.length){|id|contents[id][0]})
		create_gauge
		if SceneManager.prevOptChoose
			@menu_index = SceneManager.prevOptChoose
			@menu.set_index(@menu_index)
		end
		create_cursor
		create_contents(Array.new(contents.length){|id|contents[id][1].new})
		switch_page
		SndLib.bgs_scene_on
		SndLib.bgm_scene_on
		
		
	end
  
	def create_background
		@background = Sprite.new
		@background.z = System_Settings::SCENE_BASE_Z
		@background.bitmap = SceneManager.background_bitmap
		@background.color.set(165, 115, 125, 120)
		@background.tone.set(-20,-55,-120,255)
		@background2 = Sprite.new
		@background2.z = System_Settings::SCENE_BASE_Z
		@background2.bitmap = Cache.load_bitmap(ROOT,"background")
		@background2.color.set(20, 20, 20, 255)
	end
  
  def create_cursor
	@cursor = Menu_Cursor.new(20, @menu.current_y - 1,Cache.system("Menu/cursor"))
  end
  
	def create_menu(command_names)
		@menu_index ||= 0
		@menu = Menu_Command.new(command_names)
		@menu.set_index(@menu_index)
	end
  
  def create_gauge
    @gauge = Menu_Gauge.new($game_party.menu_actor)
  end
  
  def create_contents(contents)
	@contents = Menu_Contents.new(contents)
  end
  
  def switch_page
    @contents.switch_page(@menu_index)
  end
  
	def update
		super
		update_cursor
		update_input
		update_contents
	end
  
	def update_cursor
		@cursor.to_xy(20, @menu.current_y + 5) if @menu.active
		@cursor.update
	end
	
	def update_input
		#return mouse_input if Mouse.MousePressed?
		if @menu.active
			if Input.repeat?(:UP) || Input.repeat?(:DOWN) || Input.repeat?(:R) || Input.repeat?(:L)
				return if Mouse.enable? && !Mouse.within_XYWH?(0, 0, 156, 360)
				tmpPage = Input.repeat?(:DOWN)? 1 : -1 if Input.repeat?(:UP) || Input.repeat?(:DOWN)
				tmpPage = Input.repeat?(:R)? 1 : -1 if Input.repeat?(:R) || Input.repeat?(:L)
				warp = $LonaINI["GameOptions"]["ui_opt_warping"] == 1 && !($LonaINI["GameOptions"]["ui_opt_warping_mouse_off"] == 1 && Mouse.enable?)
				if warp
					tmpD = (@menu_index + tmpPage) % @menu.size
				else
					tmpD = @menu_index + tmpPage
					tmpD = [[tmpD, 0].max, @menu.size - 1].min
				end
				process_switchMenuIndex(tmpD)
			elsif Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)
				process_ok
			elsif Input.trigger?(:B) || WolfPad.trigger?(:X_LINK)
				process_exit_menu
			end
		end
		if SceneManager.scene.is_a?(Scene_Map) then
			$game_player.cancel_refresh=true
		end
		mouse_input if Mouse.enable?
	end
	
	def process_switchMenuIndex(tmpD)
		@menu_index = tmpD
		@menu.set_index(@menu_index)
		SceneManager.prevOptChooseSet(@menu_index)
		switch_page
		SndLib.play_cursor
	end
	
	def process_exit_menu
		SndLib.closeChest
		SceneManager.prevOptChooseSet(@nil)
		SceneManager.goto(Scene_Map)
		$game_temp.reserve_common_event(:Dropitem)
	end
	
	def mouse_input
		return Mouse.ForceIdle if Input.dir4 > 0
		return if !Mouse.enable?
		return if @contents.main_menu_stop_update?(@menu_index)
		tmpPressed_MZ_LINK = Input.trigger?(:MZ_LINK)
		tmpPressed_MX_LINK = Input.trigger?(:MX_LINK)
		return process_exit_menu if tmpPressed_MX_LINK && @menu.active
		return if !(Input.trigger?(:L) || Input.trigger?(:R) || tmpPressed_MZ_LINK)
		tmpWithInControlArea = Mouse.within_XYWH?(0, 0, 156, 360)
		return if (Input.trigger?(:L) || Input.trigger?(:R)) && tmpWithInControlArea #滾輪於主選單無用
		@contents.main_menu_mouse_press_cancel(@menu_index) if tmpWithInControlArea && tmpPressed_MZ_LINK
		tmpProcessIndex = -1
		@menu.menu_sprites.length.times {|i|
			spr = @menu.menu_sprites[i]
			next unless Mouse.within_XYWH?(spr.x, spr.y+7,  @menu.sprites_width_record[i], spr.height)
			tmpProcessIndex = i
		}
		if @contents.mouse_no_need_update?(@menu_index)
			@menu.activate
		else
			tmpWithInControlArea ? @menu.activate : @menu.deactivate
		end
		if tmpProcessIndex >= 0 && tmpWithInControlArea && tmpProcessIndex != @menu_index
			process_switchMenuIndex(tmpProcessIndex)
		#elsif tmpProcessIndex >= 0 && tmpWithInControlArea && tmpProcessIndex == @menu_index
		#	#智障解 最後一個選項為EXIT
		#	process_ok if @menu.menu_sprites.length == @menu_index +1
		end
	end
	
	def mouse_within_MainOptions_area
		Mouse.within_XYWH?(spr.x, spr.y,  @menu.sprites_width_record[i], spr.height)
	end
	
	def update_contents
		@contents.update
	end
	
	def process_ok
		@contents.process_ok(@menu_index) if @menu.active
	end
	
	def terminate
		$game_player.actor.skill_changed=true
		$game_player.actor.update_state_frames
		$game_player.light_check
		
		$game_portraits.getPortrait("Lona").update #to fix a bug cause portrait z > message window Z
		
		$hudForceHide = false
		$balloonForceHide = false
		Graphics.freeze
		dispose_sprites
		SndLib.scene_off
	end
  
	def dispose_sprites
		@background.dispose
		@background2.dispose
		@menu.dispose
		@contents.dispose
		@gauge.dispose
		@cursor.dispose
		#Cache.clear_email
	end
 
 
end # Scene_Menu

#==============================================================================
# ** Menu_Command
#------------------------------------------------------------------------------
#  Sprites used for display.
#==============================================================================

class Menu_Command
  
	attr_reader :active
	attr_reader :menu_sprites
	attr_reader :sprites_width_record
	
	def initialize(command_names)
		@index = 0
		@sprites_width_record = []
		@menu_sprites = Array.new(command_names.size){Sprite.new}
		@menu_sprites.each_with_index do |spr, index|
			spr.bitmap = Bitmap.new(120,28)
			spr.z = 1
			spr.bitmap.font.size= 20
			spr.bitmap.font.bold = true
			spr.bitmap.font.outline = false
			spr.bitmap.draw_text(spr.src_rect, command_names[index])
			spr.x = index == @menu_index ? 52 : 49
			spr.y = 28 + index*18
			spr.z = System_Settings::SCENE_Menu_Command_Z
			spr.opacity = index == @menu_index ? 255 : 128
			@sprites_width_record << spr.bitmap.text_size(command_names[index]).width
		end
		@active = true
		refresh
	end
	
	
	def set_index(value)
		@index = value
		refresh
	end

	def size
		@menu_sprites.size
	end
  
  def refresh
    return unless @active
    @menu_sprites.each_with_index {|spr, id|
    spr.opacity, spr.x = id == @index ? [255, 52] : [128, 49]}
  end
  
  def activate
    @active = true
  end
  
  def deactivate
    @active = false
  end
  
  def turn_off
	@menu_sprites.each{|spr| spr.visible=false}
  end
  
  def current_y
    return @menu_sprites[@index].y
  end
  
  def dispose
    @menu_sprites.each{|spr| spr.dispose}
  end
  

  def turn_off
    @menu_sprites.each{|spr| spr.visible = false}
  end
  
end

#==============================================================================
# ** Menu_Cursor
#------------------------------------------------------------------------------
#  Sprite and movement.
#==============================================================================

class Menu_Cursor < Sprite
  def initialize(tx, ty,bitmap)
    super()
    self.x = @tar_x = tx
    self.y = @tar_y = ty
    self.bitmap = bitmap
    self.z = System_Settings::SCENE_Menu_Cursor_Z
  end
  
  def to_xy(tx, ty,smooth=true)
	@tar_x, @tar_y = tx, ty
	self.x , self.y= @tar_x, @tar_y unless smooth
  end
  
	def update
		unless @tar_x == self.x 
			distance = @tar_x - self.x
			v = (distance.abs/5.0).ceil
			v = distance.abs < v ? distance : (distance > 0 ? v : -v)
			self.x += v
		end
		unless @tar_y == self.y
			distance = @tar_y - self.y
			v = (distance.abs/5.0).ceil
			v = distance.abs < v ? distance : (distance > 0 ? v : -v)
			self.y += v
		end
	end
  
  def moving?
	@tar_x != self.x  && @tar_y != self.y
  end
  
end

#==============================================================================
# ** Menu_Contents
#------------------------------------------------------------------------------
#  Menu contents wrapper.
#==============================================================================

class Menu_Contents  
	attr_reader :contents
  def initialize(contents)# menu, actor, cursor, gauge)
	@contents=contents
	@menu=SceneManager.scene.menu
  end
  
	def process_ok(index)
		#return unless [1,4,5,6].include?(index)
		return unless @contents[index].respond_to?(:enter_page)
		@menu.deactivate
		@contents[index].enter_page
	end
  
	def process_ok(index)
		#return unless [1,4,5,6].include?(index)
		return unless @contents[index].respond_to?(:enter_page)
		@menu.deactivate
		@contents[index].enter_page
	end
	def main_menu_stop_update?(index)
		@contents[index].mouse_force_main_menu_pause
	end
	def mouse_no_need_update?(index)
		@contents[index].mouse_no_need_update
	end
	def main_menu_mouse_press_cancel(index)
		@contents[index].mouse_press_cancel
	end
  
	def update
		@contents.each {|i| next if i.nil? ; i.send(:update)}
	end
  
	def refresh
		@contents.each{|c|c.refresh if c.respond_to?(:refresh)} #注意不是每一個Menu都有定義refresh
	end
  
  def switch_page(menu_index)
    @contents.each_with_index {
	|item, index|
		index == menu_index ? item.show : item.hide 
	}#rescue next}
  end
  
  def dispose #kabom
    @contents.each {|i| i.dispose ;}#rescue next }
  end
  
  def turn_off
   @contents.each{|i| i.hide rescue next}
  end
  
end

#==============================================================================
# ** Menu_ContentBase
#==============================================================================

class Menu_ContentBase
  ROOT = 'Graphics/System/Menu/'
  def initialize
	tmpStr2Lang = System_Settings::MESSAGE_STR2_LANG
	@str2Lang = tmpStr2Lang.include?($lang)
    @viewport = Viewport.new
	@viewport.z = System_Settings::SCENE_Menu_ContentBase_Z
	@actor=$game_party.menu_actor
    @cursor=SceneManager.scene.cursor
	@gauge=SceneManager.scene.gauge
	@menu=SceneManager.scene.menu
  end
  
  
	def find_and_eval_interpolations(a_string)
		return "" if a_string.nil?
		left_bracket = 0
		start_char = -1
		i = 0
		while i < a_string.length-1
			c = a_string[i]
			if c == "#" && i<a_string.length-1 && a_string[i+1] == "{" then
				left_bracket += 1
				start_char = i
				i+=1
			elsif c == "{" && start_char>=0 then
				left_bracket+=1
			end
			if c== "}" && left_bracket>0 then
				left_bracket-=1
				if left_bracket == 0 then
				begin
					evaled = eval('"'+a_string[start_char..i]+'"')
				rescue => ex
					p "EVAL FAILED IN TEXT #{a_string} ERROR: #{ex}"
					evaled = ""
				end
					return a_string[0...start_char]+evaled+find_and_eval_interpolations(a_string[i+1...a_string.length])
				end
			end
			i += 1
		end
		return a_string #No valid #{...} inside or mismatching { } brackets
	end
	def show
		@viewport.visible = true
	end
  
	def hide
		@viewport.visible = false
	end
  
  def update
  end
  
  def dispose
	@cursor=nil #disposed at Scene_Menu
	@gauge =nil #disposed at Scene_Menu
	@menu  =nil #disposed at Scene_Menu
    @viewport.dispose
  end

	def mouse_force_main_menu_pause
		false
	end
	def mouse_no_need_update
		false
	end
	def mouse_press_cancel
	end
#================================================================================================================================
#*	Partial Migration for Message System
#******Damn it , thats almost half the Window_Base class(key functions) here... Why don't the one who wrote this just extend 
#******Window_Base and enjoy the written functions...
#================================================================================================================================
  
  def convert_escape_characters(text)
    result = text.to_s.clone
    result.gsub!(/\\/)            { "\e" }
    result.gsub!(/\e\e/)          { "\\" }
    result.gsub!(/\eV\[(\d+)\]/i) { $game_variables[$1.to_i] }
    result.gsub!(/\eV\[(\d+)\]/i) { $game_variables[$1.to_i] }
    result.gsub!(/\eN\[(\d+)\]/i) { actor_name($1.to_i) }
    result.gsub!(/\eP\[(\d+)\]/i) { party_member_name($1.to_i) }
    result.gsub!(/\eG/i)          { Vocab::currency_unit }
    result
  end

  #alias_method :convert_escape_characters_pre_dialog, :convert_escape_characters
  #def convert_escape_characters(text)
    # Inject external text before processing escapes.
  #  convert_escape_characters_pre_dialog(text.gsub(/\\T\[([^\]]+)\]/i) { $game_text[$1] })
  #end
  
  def reset_font_settings(canvas)
	canvas.bitmap.font.color.set(Cache.system("Window").get_pixel(64 + (0 % 8) * 8, 96 + (0 / 8) * 8))
    canvas.bitmap.font.size = Font.default_size
    canvas.bitmap.font.bold = Font.default_bold
    canvas.bitmap.font.italic = Font.default_italic
  end
  
  
	def draw_text_on_canvas(canvas, x, y, text,no_reset_font=false)
		reset_font_settings(canvas) unless no_reset_font
		text = convert_escape_characters(text)
		pos = {:x => x, :y => y, :new_x => x, :height => calc_line_height(canvas,text)}
		process_character(canvas,text.slice!(0, 1), text, pos) until text.empty?
	end
  

  
  def process_character(canvas,c, text, pos)
    case c
    when "\n"   # New line
      process_new_line(canvas,text, pos)
    when "\e"   # Control character
	  code=obtain_escape_code(text)
	return if code.nil?
      process_escape_character(canvas,code, text, pos)
    else        # Normal character
      process_normal_character(canvas,c, pos, text)
    end
  end
  
  def obtain_escape_code(text)
    text.slice!(/^[\$\.\|\^!><\{\}\\]|^[A-Z]+/i)
  end
  
  def process_escape_character(canvas,code, text, pos)
    case code
	when 'C'
		param=text.slice!(/^\[[^\[\]]+\]/)[/[^\[\]]+/].to_i rescue 0
		canvas.bitmap.font.color.set(Cache.system("Window").get_pixel(64 + (param % 8) * 8, 96 + (param / 8) * 8))
	when 'n'
		process_new_line(canvas,text, pos)
	when '{'
      make_font_bigger(canvas)
    when '}'
      make_font_smaller(canvas)
	else
		process_normal_character(canvas,code,pos, text)
	end
  end
  
  def process_new_line(canvas,text,pos)
	pos[:x] = pos[:new_x]
    pos[:y] += pos[:height]
    pos[:height] = calc_line_height(canvas,text)
  end
  
  def calc_line_height(canvas,text, restore_font_size = true)
    result = [16, canvas.bitmap.font.size].max
    last_font_size = canvas.bitmap.font.size
    text.slice(/^.*$/).scan(/\e[\{\}]/).each do |esc|
      make_font_bigger(canvas)  if esc == "\e{"
      make_font_smaller(canvas) if esc == "\e}"
      result = [result, canvas.bitmap.font.size].max
    end
    canvas.bitmap.font.size = last_font_size if restore_font_size
    result
  end
  
  #--------------------------------------------------------------------------
  # * Increase Font Size
  #--------------------------------------------------------------------------
  def make_font_bigger(canvas)
    canvas.bitmap.font.size += 8 if canvas.bitmap.font.size <= 64
  end
  #--------------------------------------------------------------------------
  # * Decrease Font Size
  #--------------------------------------------------------------------------
  def make_font_smaller(canvas)
    canvas.bitmap.font.size -= 8 if canvas.bitmap.font.size >= 16
  end
  
  def new_line_x
	0
  end
  
	def process_normal_character(canvas,c, pos,text="")
		if c.eql?("\f")
			text_width = 0
		else
			text_width = canvas.bitmap.text_size(c).width
		end
		if pos[:x] + next_word_width(canvas,c,text,text_width) >= canvas.bitmap.width
			pos[:new_x] = new_line_x
			process_new_line(canvas,c, pos)
		end
		canvas.bitmap.draw_text(pos[:x], pos[:y], text_width * 2, pos[:height], c)
		pos[:x] += text_width
	end
  

  
	def next_word_width(canvas,c,text,word_width)
		return 0 if c.eql?("\e")
		c= "aa" if @str2Lang
		return word_width if text.empty? || @str2Lang || c.strip.empty?
		if @str2Lang
			word_width
		else
			textLength = text.index(/\s/)
			return word_width if !textLength
			word_width + canvas.bitmap.text_size(text[0, textLength]).width
		end
	end
  
  
  
end

#==============================================================================
# ** Menu_Gauge
#------------------------------------------------------------------------------
#  Bottom-left gauges.
#==============================================================================

class Menu_Gauge < Menu_ContentBase
	def initialize(actor)
		@viewport = Viewport.new
		@viewport.z = System_Settings::SCENE_Menu_ContentBase_Z
		@actor=$game_party.menu_actor
		@actor = actor
		bmp = Cache.load_bitmap(ROOT,"main_bars")#Bitmap.new("#{ROOT}main_bars")
		@unit_w, @unit_h = bmp.width/2, bmp.height/4
		@gauge_sprites = Array.new(8){Sprite.new(@viewport)}
		@gauge_sprites.each_with_index do |spr, index|
			spr.bitmap = bmp
			spr.z = index.even? ? 2+System_Settings::SCENE_Menu_Gauge_Z : 1+System_Settings::SCENE_Menu_Gauge_Z
			#spr.src_rect = Rect.new(@unit_w*(index%2), @unit_h*(index/2), @unit_w, @unit_h)
			spr.src_rect = Rect.new(@unit_w*(index%2), @unit_h*(index/2), @unit_w, @unit_h)
			spr.x = 33
			spr.y = 254 + 23*(index/2)
			spr.y += 6 if index >= 6
		end

		@gauge_info = Sprite.new(@viewport)
		@gauge_info.bitmap = Bitmap.new(Graphics.width, Graphics.height)
		@gauge_info.z = System_Settings::SCENE_Menu_Gauge_Z
		refresh
	end
  
  def refresh
    bmp = @gauge_info.bitmap
    bmp.clear 
    @gauge_sprites.each_with_index do |spr, index|
      case index
      when 0 #hp
        spr.src_rect.width = @unit_w * @actor.health / @actor.battle_stat.get_stat("health",ActorStat::MAX_STAT)
      when 2 #sta
        spr.src_rect.width = @unit_w * @actor.sta / @actor.battle_stat.get_stat("sta",ActorStat::MAX_STAT)
      when 4 #sat
        spr.src_rect.width = @unit_w * @actor.sat / @actor.battle_stat.get_stat("sat",ActorStat::MAX_STAT)
      when 6 #exp
        if @actor.max_level?
          spr.src_rect.width = @unit_w 
          break 
        end
        current_exp = @actor.exp
        exp_for_current_lv = @actor.exp_for_level(@actor.level)
        exp_for_next_lv = @actor.exp_for_level(@actor.level+1)
        exp_now = @actor.exp - exp_for_current_lv
        exp_need = exp_for_next_lv - exp_for_current_lv
        spr.src_rect.width = @unit_w * exp_now.to_f / exp_need
		bmp.font.bold = false
		bmp.font.size = 14
		bmp.font.outline = false
		bmp.font.color=Color.new(0,255,0,255)
		bmp.draw_text(33, 315, @unit_w, 12, "#{exp_now} / #{exp_need}", 2)
      end
    end
	bmp.font.bold = true
	bmp.font.outline = false
	bmp.font.color=Color.new(0,255,0,255)
	bmp.font.size = 21
	bmp.draw_text(33, 209,     120, 20, $game_text["menu:main_stats/name"])
	bmp.font.size = 14
	bmp.draw_text(33, 226, @unit_w, 16, $game_text["menu:core_stats/ca"])
	bmp.draw_text(33, 226, @unit_w, 16,"#{$game_player.actor.weight_carried.round(1)} / #{(2*$game_player.actor.attr_dimensions["sta"][2]).round(1)}",2)
	bmp.font.bold = false
	bmp.font.size = 14
	
	tmpHP_MAX = @actor.battle_stat.get_stat("health",ActorStat::MAX_STAT)
	bmp.draw_text(33, 239, @unit_w, 16, $game_text["menu:core_stats/hp"])
	bmp.draw_text(33, 239, @unit_w, 16, "#{@actor.health.ceil} / #{tmpHP_MAX.ceil}", 2)

	tmpSTA_MAX = @actor.battle_stat.get_stat("sta",ActorStat::MAX_STAT)
	bmp.draw_text(33, 262, @unit_w, 16, $game_text["menu:core_stats/sta"])
	bmp.draw_text(33, 262, @unit_w, 16, "#{@actor.sta.ceil} /  #{tmpSTA_MAX.ceil}", 2)
	
	tmpSAT_MAX = @actor.battle_stat.get_stat("sat",ActorStat::MAX_STAT)
    bmp.draw_text(33, 285, @unit_w, 16, $game_text["menu:core_stats/sat"])
    bmp.draw_text(33, 285, @unit_w, 16, "#{@actor.sat.ceil} /  #{tmpSAT_MAX.ceil}", 2)
	
    bmp.draw_text(33, 303, @unit_w, 16, $game_text["menu:core_stats/next_lv"], 2)
    bmp.draw_text(33, 303, @unit_w, 16, "LV#{$game_actors[1].level}")
  end
  
  
  def dispose
	@gauge_info.dispose
    @gauge_sprites.each{|i|i.dispose}
	@viewport.dispose
  end
  
  
end

#==============================================================================
# ** Sprite
#------------------------------------------------------------------------------
#  Add alignment method.
#==============================================================================
class Sprite
  
  #set sprite's anchor point, pos is the same as numpad.
  def align(pos)
    case pos%3
    when 0; self.ox = self.src_rect.width
    when 1; self.ox = 0
    when 2; self.ox = self.src_rect.width/2
    end
    
    case (pos-1)/3
    when 0; self.oy = self.src_rect.height
    when 1; self.oy = self.src_rect.height/2
    when 2; self.oy = 0
    end
  end
  
end
