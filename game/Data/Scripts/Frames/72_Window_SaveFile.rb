#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
#==============================================================================
# ** Window_SaveFile
#------------------------------------------------------------------------------
#  This window displays save files on the save and load screens.
#==============================================================================

class Window_SaveFile < Window_Base
  #--------------------------------------------------------------------------
  # * Public Instance Variables
  #--------------------------------------------------------------------------
  attr_reader   :selected                 # selected
  attr_reader   :modded_data
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     index : index of save files
  #--------------------------------------------------------------------------
	def initialize(height, index)
		tmpGW = Graphics.width
		super(tmpGW/20, index * height, tmpGW/2-tmpGW/20, height)
		@file_index = index
		contents.font.size = System_Settings::FONT_SIZE::WINDOW_FILE_SAVE_SLOT
		contents.font.outline = false
		refresh
		@selected = false
	end
	#--------------------------------------------------------------------------
	# * Refresh
	#--------------------------------------------------------------------------
	#tmpModded = header[:mod_data] && !header[:mod_data].empty?
	#tmpTar.insert(0, "MODDED ") if tmpModded
	def refresh
		contents.clear
		change_color(normal_color)
		name = "File" + " #{@file_index + 1}"
		@name_width = text_size(name).width
		header = DataManager.load_header(@file_index)
		header = Hash.new("ERROR") if !header && DataManager.saveFileExistsRGSS_slot?(@file_index+1)
		modded = header && header[:mod_data] && !header[:mod_data].empty?
		@modded_data = {}
		#name.insert(0,"MODDED ") if modded
		contents.font.size = System_Settings::FONT_SIZE::WINDOW_FILE_SAVE_SLOT
		contents.font.outline = false
		draw_text(6, 0, 200, line_height, name)
		draw_playtime(-6, contents.height - line_height+3, contents.width - 4, 2, header)
		draw_lvl(6, contents.height - line_height+3, contents.width - 4, 2, header)
		draw_date(6, contents.height - line_height+3, contents.width - 4, 2, header)
		draw_title(-6, 7, contents.width - 4, 2, header)
		@modded_data = header[:mod_data] if modded
		draw_modded(-6, 7, contents.width - 4, 2, header) if modded
	end
  #--------------------------------------------------------------------------
  # * Draw Play Time
  #--------------------------------------------------------------------------
	def draw_playtime(x, y, width, align, header)
		return unless header
		contents.font.size = System_Settings::FONT_SIZE::WINDOW_FILE_PLAYTIME
		contents.font.outline = false
		begin
			tmpTar = "#{header[:playtime_s]}"
		rescue
			tmpTar= "ERROR"
		end
		contents.draw_text(x, y-4, width, line_height,tmpTar, 2)
	end
	def draw_modded(x, y, width, align, header)
		return unless header
		contents.font.size = System_Settings::FONT_SIZE::WINDOW_FILE_PLAYTIME
		contents.font.outline = false
		begin
			tmpTar = "MOD"
		rescue
			tmpTar= "ERROR"
		end
		contents.draw_text(x, y-4, width, line_height,tmpTar, 1)
	end
	def draw_date(x, y, width, align, header)
		return unless header
		contents.font.size = System_Settings::FONT_SIZE::WINDOW_FILE_DATE
		contents.font.outline = false
		begin ;tmpTar = "#{header[:date]}" ;rescue ;tmpTar= "ERROR" ;end
		contents.draw_text(x, y-4, width, line_height,tmpTar, 1)
	end
  
  
	def draw_lvl(x, y, width, align, header)
		return unless header
		contents.font.size = System_Settings::FONT_SIZE::WINDOW_FILE_LVL
		contents.font.outline = false
		begin
			tmpTar = "#{header[:stat_lv]}"
		rescue
			tmpTar= "ERROR"
		end
		contents.draw_text(x, y-4, width, line_height,tmpTar, 0)
	end

	def draw_title(x, y, width, align, header)
		return unless header
		contents.font.size = System_Settings::FONT_SIZE::WINDOW_FILE_TITLE
		contents.font.outline = false
		begin
			tmpTar = $game_text[header[:title]]
		rescue
			tmpTar= "ERROR"
		end
		contents.draw_text(x, y-4, width, line_height,tmpTar, 2)
	end
  #--------------------------------------------------------------------------
  # * Set Selected
  #--------------------------------------------------------------------------
  def selected=(selected)
    @selected = selected
    update_cursor
  end
  #--------------------------------------------------------------------------
  # * Update Cursor
  #--------------------------------------------------------------------------
  def update_cursor
    if @selected
      cursor_rect.set(0, 0, contents.width , contents.height)
      #cursor_rect.set(0, 0, @name_width + 8, line_height)
    else
      cursor_rect.empty
    end
  end
end
