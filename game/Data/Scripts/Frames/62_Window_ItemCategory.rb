#==============================================================================
# ** Window_ItemCategory
#------------------------------------------------------------------------------
#  This window is for selecting a category of normal items and equipment
# on the item screen or shop screen.
#==============================================================================

class Window_ItemCategory < Window_HorzCommand
  #--------------------------------------------------------------------------
  # * Public Instance Variables
  #--------------------------------------------------------------------------
  attr_reader   :item_window
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    super(0, 0)
  end
  #--------------------------------------------------------------------------
  # * Get Window Width
  #--------------------------------------------------------------------------
  def window_width
    Graphics.width
  end
  #--------------------------------------------------------------------------
  # * Get Digit Count
  #--------------------------------------------------------------------------
  def col_max
    return 3
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    super
    @item_window.category = current_symbol if @item_window
  end
  #--------------------------------------------------------------------------
  # * Create Command List
  #--------------------------------------------------------------------------
  def make_command_list
    add_command($game_text["menu:Shop/Item"],     :item)
    add_command($game_text["menu:Shop/ArmEquip"],   :weapon)
    add_command($game_text["menu:Shop/Equip"],    :armor)
    #add_command(Vocab::key_item, :key_item)
  end
  #--------------------------------------------------------------------------
  # * Set Item Window
  #--------------------------------------------------------------------------
  def item_window=(item_window)
    @item_window = item_window
    update
  end
end
