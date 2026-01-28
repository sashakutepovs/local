#==============================================================================
# ** Window_ItemList
#------------------------------------------------------------------------------
#  This window displays a list of party items on the item screen.
#==============================================================================

class Window_ItemList < Window_Selectable
  #--------------------------------------------------------------------------
  # * Object Initialization
	#--------------------------------------------------------------------------
	attr_accessor 		:sort_rule
	attr_accessor 		:prev_sort_rule
	attr_accessor 		:sort_reverse
	def initialize(x, y, width, height)
		super
		@category = :none
		@data = []
		@sort_rule = {
			:main_mode 			=> nil,
			:type_tag 			=> nil,
			:type 				=> nil,
			:prev_type		 	=> nil,
			:prev_main_mode 	=> nil,
			:prev_type_tag 		=> nil
		}
		@prev_sort_rule = {}
		@sort_reverse = false
	end
  #--------------------------------------------------------------------------
  # * Set Category
  #--------------------------------------------------------------------------
  def category=(category)
    return if @category == category
    @category = category
    refresh
    self.oy = 0
  end
  #--------------------------------------------------------------------------
  # * Get Digit Count
  #--------------------------------------------------------------------------
  def col_max
    return 2
  end
  #--------------------------------------------------------------------------
  # * Get Number of Items
  #--------------------------------------------------------------------------
  def item_max
    @data ? @data.size : 1
  end
  #--------------------------------------------------------------------------
  # * Get Item
  #--------------------------------------------------------------------------
  def item
    @data && index >= 0 ? @data[index] : nil
  end
  #--------------------------------------------------------------------------
  # * Get Activation State of Selection Item
  #--------------------------------------------------------------------------
  def current_item_enabled?
    enable?(@data[index])
  end
  #--------------------------------------------------------------------------
  # * Include in Item List?
  #--------------------------------------------------------------------------
  def include?(item)
    case @category
    when :item
      item.is_a?(RPG::Item) && !item.key_item
    when :weapon
      item.is_a?(RPG::Weapon)
    when :armor
      item.is_a?(RPG::Armor)
    when :key_item
      item.is_a?(RPG::Item) && item.key_item
    else
      false
    end
  end
  #--------------------------------------------------------------------------
  # * Display in Enabled State?
  #--------------------------------------------------------------------------
  def enable?(item)
    $game_party.usable?(item)
  end
  #--------------------------------------------------------------------------
  # * Create Item List
  #--------------------------------------------------------------------------
 	 def make_item_list
		@data = $game_party.all_items.select {|item| include?(item) }
		sort_item_list#(tmpMode=@record_main_mode,tmpTag=@record_type_tag)
		#@data.push(nil) if include?(nil)
	 end
	def sort_item_list
		if @data && !@data.empty?
			@data.sort_by! {|it|
				if @sort_rule[:type_tag]
					type_tag = (it.type_tag == @sort_rule[:type_tag] ) ? 0 : 1
				else
					type_tag = (it.type_tag == "Money") ? 0 : 1
				end
				if @sort_rule[:type]
					it_type = (it.type == @sort_rule[:type] ) ? 0 : 1 if @sort_rule[:type]
				else
					it_type = it.type.is_a?(String) ? it.type : ""
				end
				#it_type = (it.type == @sort_rule[:type] ) ? 0 : 1 if @sort_rule[:type]
				it_key = (it.key_item?) ? 1 : 0
				it_tag = it.type_tag.is_a?(String) ? it.type_tag : ""
				#it_type = it.type.is_a?(String) ? it.type : ""
				it_name = it.item_name.is_a?(String) ? it.item_name : ""
				case @sort_rule[:main_mode]
					when "Default"	; export = [type_tag, it_key, it_type, it_name, it_tag, it.price]
					when "Price" 	; export = [it.price]
					when "Weight"	; export = [it.weight]
					when "Amount"	; export = [$game_party.item_number(it)]
					when "Type"		; export = [it_type, it_key, type_tag, it_name, it_tag, it.price]
					else			; export = [type_tag, it_key, it_type, it_name, it_tag, it.price]
				end
				export
			}
			@data.reverse! if @sort_reverse
		end
		@data.push(nil) if include?(nil)
	end
	def switch_sort_reverse
		if @sort_reverse
			@sort_reverse = false
		else
			@sort_reverse = true
		end
	end
  #--------------------------------------------------------------------------
  # * Restore Previous Selection Position
  #--------------------------------------------------------------------------
  def select_last
    select(@data.index($game_party.last_item.object) || 0)
  end
  #--------------------------------------------------------------------------
  # * Draw Item
  #--------------------------------------------------------------------------
  def draw_item(index)
    item = @data[index]
    if item
      rect = item_rect(index)
      rect.width -= 4
		contents.font.size = 20
		contents.font.outline = false
      draw_item_name(item, rect.x, rect.y, enable?(item))
      draw_item_number(rect, item)
    end
  end
  #--------------------------------------------------------------------------
  # * Draw Number of Items
  #--------------------------------------------------------------------------
  def draw_item_number(rect, item)
   # draw_text(rect, sprintf(":%2d", $game_party.item_number(item)), 2)
	contents.font.size = 16
	contents.font.outline = false
	draw_text(rect, "#{(item.weight).round(1)}w   #{item.get_sell_price}p   x#{$game_party.item_number(item)}", 2)
  end
  #--------------------------------------------------------------------------
  # * Update Help Text
  #--------------------------------------------------------------------------
  def update_help
    @help_window.set_item(item)
  end
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh
    make_item_list
    create_contents
    draw_all_items
  end
end
