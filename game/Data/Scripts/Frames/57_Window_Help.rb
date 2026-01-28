#==============================================================================
# ** Window_Help
#------------------------------------------------------------------------------
#  This window shows skill and item explanations along with actor status.
#==============================================================================

class Window_Help < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(line_number = 2)
    super(0, 0, Graphics.width, fitting_height(line_number))
  end
  #--------------------------------------------------------------------------
  # * Set Text
  #--------------------------------------------------------------------------
  def set_text(text)
    if text != @text
      @text = text
      refresh
    end
  end
  #--------------------------------------------------------------------------
  # * Clear
  #--------------------------------------------------------------------------
  def clear
    set_text("")
  end
  #--------------------------------------------------------------------------
  # * Set Item
  #     item : Skills and items etc.
  #--------------------------------------------------------------------------
  def set_item(item)
    set_text(item ? $game_text[item.description] : "")
  end
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh
    contents.clear
    draw_text_ex(4, 0, @text)
  end
  
  #--------------------------------------------------------------------------
  # * Normal Character Processing
  #--------------------------------------------------------------------------
  def process_normal_character(c, pos, text)
    text_width = text_size(c).width
	if pos[:x] + text_width >= self.contents.width
      pos[:new_x] = new_line_x
      process_new_line(c, pos)
    end    
	contents.font.outline = false
	contents.font.size = 18
    draw_text(pos[:x], pos[:y], text_width * 2, pos[:height], c)
    pos[:x] += text_width
  end
  
  
  def process_escape_character(code, text, pos)
   case code.upcase
   when 'N'
  	process_new_line(text, pos)
   else
     super
   end
  end

  
  def new_line_x
     standard_padding / 2 
  end
  
  def next_word_width(c, text)
    return 0 if c.eql?("\e")
    non_english= c.ord > 127
    c= "aa" if non_english
    word_width = text_size(c).width
    return word_width if text.empty? || non_english || c.strip.empty?
    return word_width + text_size(text[0, text.index(/\s/)]).width
  end


end
