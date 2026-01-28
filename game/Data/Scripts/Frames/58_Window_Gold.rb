#==============================================================================
# ** Window_Gold
#------------------------------------------------------------------------------
#  This window displays the party's gold.
#==============================================================================

class Window_Gold < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    super(0, 0, window_width, fitting_height(1))
	contents.font.size = 20
	contents.font.outline = false
    refresh
  end
  #--------------------------------------------------------------------------
  # * Get Window Width
  #--------------------------------------------------------------------------
  def window_width
    return 160
  end
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh
    contents.clear
	#contents.draw_text(0, -7, contents.width - 8, contents.height, $game_text["menu:Shop/TPleft"], 2)
	#contents.draw_text(0, -7, contents.width - 8, contents.height, $game_text["menu:Shop/WtLimit"], 0)
	contents.draw_text(0, 0, contents.width - 8, contents.height, "#{$game_party.gold}p", 2)
	contents.draw_text(0, 0, contents.width - 8, contents.height, "#{(2*$game_player.actor.attr_dimensions["sta"][2] - $game_player.actor.weight_carried).round(1)}w", 0)
    #draw_currency_value(value, currency_unit, 4, 0, contents.width - 8)
  end
  #--------------------------------------------------------------------------
  # * Get Party Gold
  #--------------------------------------------------------------------------
  def value
    $game_party.gold
  end
  #--------------------------------------------------------------------------
  # Get Currency Unit
  #--------------------------------------------------------------------------
  def currency_unit
	#Vocab::currency_unit
  end
  #--------------------------------------------------------------------------
  # * Open Window
  #--------------------------------------------------------------------------
  def open
    refresh
    super
  end
end
