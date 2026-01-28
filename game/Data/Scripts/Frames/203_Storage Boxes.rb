

module Storage_Boxes_Setting

  BOXES = [ # Do not remove.

    # This first Box has the ID 0. IDs go up by 1 with each box.
    {
        # The name of the box to be displayed (eg. crate, barrel, chest).
        name: "Drawer",
        # Size of the box (set to 0 for infinite).
        size: 15,
        # SE (Sound Effect) played when opening the box. If left black, the
        # default will be used.
        open_sound: {
            name: "Open5",  # Name of SE
            volume: 80,     # Volume to play it at (0-100%)
            pitch: 100,     # Pitch to play it at (50-150%)
        },
        # Same as above, but played when closing the box.
        close_sound: {
            name: "Close1", # Name of SE
            volume: 80,     # Volume to play it at (0-100%)
            pitch: 100,     # Pitch to play it at (50-150%)
        },
    },

    {
        name: "Drawer",
        size: 20,
        # This will make no sound played (rather than the default) when this
        # box is opened.
        open_sound: {},
        # This will make no sound played (rather than the default) when this
        # box is closed.
        close_sound: {},
    },

    {
        name: "Bank",
        size: 0,
    },

    {
        name: "Jewelery Box",
        size: 10,
    },

  ]# Do not remove.
end

#==============================================================================
# Game_Boxes
#==============================================================================
class IMP1_Game_Boxes
  include Storage_Boxes_Setting
  #--------------------------------------------------------------------------
  # Creates the empty boxes.
  #--------------------------------------------------------------------------
	def initialize
		@boxes = []
		@storeItemPrice = {}
		@storeTP = 0
		@defaultPlayerItems  ={}
		@defaultPlayerArmors ={}
		@defaultPlayerWeapons={}
		@defaultPlayerGold   =0

	end
  #--------------------------------------------------------------------------
  # Returns box with the specified id, or returns a new, empty, default box.
  #--------------------------------------------------------------------------
	def setup(box_id, name= $game_text["menu:Box/Target"] , size=0,open_sound=nil, close_sound=nil)
		p "storageSETUP box_id => #{box_id}"
		p "storageSETUP name => #{name}"
		p "storageSETUP size => #{size}"
		BOXES[box_id] = {
		name: name,
		size: size,
		open_sound: open_sound,
		close_sound: close_sound
		}
	end
  #--------------------------------------------------------------------------
  # Returns box with the specified id, or returns a new, empty, default box.
  #--------------------------------------------------------------------------
  def box(box_id)
    @boxes[box_id] ||= {}
    if BOXES[box_id].nil?
      setup(box_id)
    end
    return @boxes[box_id]
  end
  #--------------------------------------------------------------------------
  # Checks how many of item there are in box_id.
  #--------------------------------------------------------------------------
  def item_number(item_to_check, box_id)
    return box(box_id)[item_to_check]
  end
  
  #--------------------------------------------------------------------------
  # Adds amount to item in box.
  #--------------------------------------------------------------------------
	def add_item(item, amount, box_id, overfill=:max)
		resultItem = nil
		@boxes[box_id].any?{
			|tmpBoxItem|
			next if [0,nil].include?(tmpBoxItem)
			#next if tmpBoxItem[0] != item  #will cause double item
			next if tmpBoxItem[0].id 			!= item.id
			next if tmpBoxItem[0].type 			!= item.type
			next if tmpBoxItem[0].name 			!= $game_text[item.name]
			next if tmpBoxItem[0].icon_index 	!= item.icon_index
			resultItem = tmpBoxItem[0]
		}
		resultItem = item if resultItem == nil
		
		if overfill == :force || space_for(item, amount, box_id)
			box(box_id)[resultItem] ||= 0
			box(box_id)[resultItem] += amount
		elsif overfill == :max
			box(box_id)[resultItem] ||= 0
			box(box_id)[resultItem] += capacity(box)
		end
	end
  #--------------------------------------------------------------------------
  # Removes amount from item in box.
  #--------------------------------------------------------------------------
  def remove_item(item, amount, box, fail_if_impossible=true)
    return if @boxes[box][item].nil?
    if @boxes[box][item] - amount < 0
      return if fail_if_impossible
      @boxes[box][item] = 0
    else
      @boxes[box][item] -= amount
    end
    @boxes[box].delete(item) if @boxes[box][item] <= 0
  end
  
	def clear(box)
		return if @boxes[box].nil?
		@boxes[box].clear
		@storeItemPrice = {}
		@storeTP = 0
	end
  
	def get_price(box)
		return 0 if @boxes[box].nil?
		tmpTotal = 0
		@boxes[box].each{
			|item|
			tmpTotal += item[0].get_sell_price*item[1]
		}
		tmpTotal
	end
  
##############################################################################
	
	def buildBarter(box_id,good,storeTP) #new def based on json and item hash
		@item_name_trade_mode = true #remove when manual shop is removed
		good.each{|itemName,itemData|
			p itemName
			p itemData
			next if !$data_ItemName[itemName]
			next if itemData["amount"] <= 0
			itemData["price"] = 0 if !itemData["price"]
			setStoreWithPrice(box_id,$data_ItemName[itemName],itemData["price"],itemData["amount"])
		}
		@defaultPlayerItems   = $game_party.get_items.clone
		@defaultPlayerArmors  = $game_party.get_armors.clone
		@defaultPlayerWeapons = $game_party.get_weapons.clone
		@defaultPlayerGold   = $game_party.gold
		@storeTP = storeTP
	end

	def buildStore(box_id,goods,storeTP)
		@item_name_trade_mode = false #remove when manual shop is removed
			######################################## make store 
			#data 0item 1:weapon 2:armor
			#id
			#original price? 0,0   custom price? nil,price
			#[0,150,0,0,rand(5)], #ItemNoerTea
			#[0,50 ,nil,($data_items[50].price*1.25).round,rand(5)],  #ItemCoin1
		goods.each{|item|
			item << rand(3) if !item[4]
			next if item[4] == 0
			item[3] =  item[3].round
			case item[0]
				when 0 ;
						item[2] != nil ? price = item[3] = $data_items[item[1]].price : price = item[3]
						setStoreWithPrice(box_id,$data_items[item[1]],price,item[4])
						item[2] = nil
				when 1 ;
						item[2] != nil ? price = item[3] = $data_weapons[item[1]].price : price = item[3]
						setStoreWithPrice(box_id,$data_weapons[item[1]],price,item[4])
						item[2] = nil
				when 2 ;
						item[2] != nil ? price = item[3] = $data_armors[item[1]].price : price = item[3]
						setStoreWithPrice(box_id,$data_armors[item[1]],price,item[4])
						item[2] = nil
			end
		}
		#@defaultGoods =  goods
		@defaultPlayerItems   = $game_party.get_items.clone
		@defaultPlayerArmors  = $game_party.get_armors.clone
		@defaultPlayerWeapons = $game_party.get_weapons.clone
		@defaultPlayerGold   = $game_party.gold
		@storeTP = storeTP
	end
	
	def get_defaultPlayeritems
		@defaultPlayerItems
	end
	def get_defaultPlayerweapons
		@defaultPlayerWeapons
	end
	def get_defaultPlayerarmors
		@defaultPlayerArmors
	end
	def get_defaultPlayerGold
		@defaultPlayerGold
	end
	
	def setStoreWithPrice(box_id,item,price,howMany)
		@boxes[box_id] ||= {}
		if BOXES[box_id].nil?
			setup(box_id)
		end
		return if howMany <= 0
		#@boxes[box_id][item] = howMany
		add_item(item, howMany, box_id)
		@storeItemPrice[item] = price
	end
	def get_storeTP
		@storeTP
	end
	def set_storeTP(val)
		@storeTP = val
	end
	
	def setStoreItemPrice(item,price)
		@storeItemPrice[item] = price
	end
	def getStoreItemPrice(item)
		return 0 if @storeItemPrice[item].nil?
		@storeItemPrice[item]
	end
	def getStoreItemExist?(item)
		return false if @storeItemPrice[item].nil?
		return true if @storeItemPrice[item]
		false
	end
	#[tmpTP,$game_date.dateAmt,$game_date.dateAmt+1+rand(4),good]
	def exportStoreItems(box_id,tmpHash,tmpTP)
		if @item_name_trade_mode #after all mmove to json  remove id mode
			good = Hash.new
			return good if @boxes[box_id].nil?
			@boxes[box_id].each{|boxItem,boxItemAmt|
				next unless boxItemAmt >= 1
				inListPrice = boxItem.price
				inListPrice = tmpHash[0][boxItem.item_name]["price"] if tmpHash[0][boxItem.item_name]
				good[boxItem.item_name] = Hash.new
				good[boxItem.item_name]["price"] = inListPrice #tmpHash[0][item[0].item_name]["Price"]
				good[boxItem.item_name]["amount"] = boxItemAmt
			}
			tmpHash[1] = tmpTP
			tmpHash[0] = good
			return good
		end
		##################################################
		good = Array.new
		return good if @boxes[box_id].nil?
		@boxes[box_id].each{|item|
			next unless item[1] >= 1
			if item[0].is_a?(RPG::Item)
				type = 0
			elsif item[0].is_a?(RPG::Weapon)
				type = 1
			else
				type = 2
			end
			itemInListPrice = 0
			itemInList = tmpHash[0].any?{|ary|
				ary[2] = nil
				itemInListPrice = ary[3]
				case ary[0]
					when 0 ;
							$data_items[ary[1]] == item[0]
					when 1 ; 
							$data_weapons[ary[1]] == item[0]
					when 2 ; 
							$data_armors[ary[1]] == item[0]
				end
			}
			itemInList ? price = itemInListPrice : price = item[0].price
			good << [type,item[0].id,nil,price,item[1]]
		}
		tmpHash[1] = tmpTP
		tmpHash[0] = good
		return good
	end
  #######################################################################################
	def itemOnBoxNum?(box,tarItem) #DEV
		tarItem = $data_ItemName[tarItem] if tarItem.is_a?(String)
		resultItem = 0
		return false if @boxes[box].nil?
		tmpResult = @boxes[box].any?{
			|item|
			next if [0,nil].include?(item)
			next unless item[0] == tarItem
			resultItem = item[1]
			true
		}
		resultItem
	end
	
  
	def itemTypeOnBoxNum?(box,tarType) #DEV
		resultItem = 0
		return false if @boxes[box].nil?
		tmpResult = @boxes[box].each{|item|
			next if [0,nil].include?(item)
			next unless item[0].type == tarItem
			resultItem += item[1]
		}
		resultItem
	end  
	
	def item_PotData_HowMany(tarData)
		temp_val=0
		all_items.each{
			|item|
			next unless item.pot_data
			next unless item.pot_data[tarData]
				amt=item_number(item)*item.pot_data[tarData].to_i
				for i in 0...amt
					temp_val += 1
				end
		}
		temp_val
	end
	

	def itemPotDataOnBoxNum?(box, tarData)
		resultItem = 0
		return false if @boxes[box].nil?
		tmpResult = @boxes[box].each{
			|item|
			next if [0,nil].include?(item)
			next unless item[0].pot_data
			next unless item[0].pot_data[tarData]
			resultItem += item[1]*item[0].pot_data[tarData].to_i
			true
		}
		resultItem
	end

	#def drop_raw(box,tmpBasedOn=$game_date.dateAmt,rawList = ["RawSemen","RawWaste","RawMeat","RawPlant","RawMilk","RawSemen","RawOther"])
	#	return if @boxes[box].nil?
	#	@boxes[box].each{
	#		|item|
	#		next unless rawList.include?(item[0].type_tag)
	#		next unless item[0].addData
	#		item[0].raw_date ? tmpDropAMT = item[0].raw_date.to_i : tmpDropAMT = 1
	#		if tmpBasedOn % tmpDropAMT == 0
	#			amt = 1+rand(item[1])
	#			@boxes[box][item[0]] -= amt
	#			@boxes[box].delete(item[0]) if @boxes[box][item[0]] <= 0
	#		end
	#	}
	#end
	#if item is raw and rottened,  destroy it
	def update_rotten_items(box)
		return if @boxes[box].nil?

		@boxes[box].dup.each do |item_obj, quantity|  # Use .dup to avoid modifying during iteration
			next unless item_obj.raw_date

			tmpDropAMT = item_obj.raw_date.to_i.nonzero? || 1
			if $game_date.dateAmt % tmpDropAMT == 0
				amt = 1 + rand(quantity)

				if item_obj.rot_progress
					raw_progress_item = $data_ItemName[item_obj.rot_progress[0]]
					raw_progress_amt = item_obj.rot_progress[1]

					@boxes[box][raw_progress_item] ||= 0
					@boxes[box][raw_progress_item] += raw_progress_amt * amt
				end

				@boxes[box][item_obj] -= amt
				@boxes[box].delete(item_obj) if @boxes[box][item_obj] <= 0
			end
		end
	end
  
	def itemOnBox?(box,tarItem)
		return false if @boxes[box].nil?
		tmpResult = @boxes[box].any?{
			|item|
			next if [0,nil].include?(item)
			next unless item[0] == tarItem
			resultItem = item
			true
		}
		tmpResult
	end
	
	def get_weight(box)
		return 0 if @boxes[box].nil?
		tmpTotal = 0
		@boxes[box].each{
			|item|
			next if [0,nil].include?(item)
			tmpTotal += item[0].weight*item[1]
		}
		tmpTotal = tmpTotal.round(1)
	end

  def empty?(box)
    return @boxes[box].nil?
  end
  
  def get_box(tarBox)
	@boxes[tarBox]
  end
  
  def write_box(tarBox,tmpWrite)
	@boxes[tarBox] = tmpWrite
  end
  
  #--------------------------------------------------------------------------
  # Returns true if there is enough room for multiple items.
  #--------------------------------------------------------------------------
  def space_for(item, amount, box)
    return (capacity(box) >= amount || BOXES[box][:size] == 0)
  end
  #--------------------------------------------------------------------------
  # Returns how full the box is.
  #--------------------------------------------------------------------------
  def fullness(box_id)
    i = 0
    box(box_id).each do |item, amount|
      i += amount
    end
    return i
  end
  #--------------------------------------------------------------------------
  # Returns the remaining space in a box.
  #--------------------------------------------------------------------------
  def capacity(box_id)
    return BOXES[box_id][:size] - fullness(box_id)
  end
  #--------------------------------------------------------------------------
  # Returns either the amount of items in a box, or a fraction of the amount 
  # in the box out of the box's capacity.
  #--------------------------------------------------------------------------
  def how_full(box_id, denom = true)
    i = fullness(box_id)
    return "#{i}/#{BOXES[box_id][:size]}" if denom
    return i.to_s
  end
  #--------------------------------------------------------------------------
  # Returns true if there's space in the box.
  #--------------------------------------------------------------------------
  def space?(box)
    return true if BOXES[box][:size] == 0
    return capacity(box) > 0
  end
  #--------------------------------------------------------------------------
  # Returns true if the box is full.
  #--------------------------------------------------------------------------
  def full?(box)
    return !space?(box)
  end
  
end # IMP1_Game_Boxes

#==============================================================================
# Scene_ItemStorage
#==============================================================================
class Scene_ItemStorage < Scene_MenuBase
  #--------------------------------------------------------------------------
  # Added to take box_id into account.
  #--------------------------------------------------------------------------
	def hud
	end
	
	def initializ
		super
		@mouse_all_rects = []
	end
	def prepare(box_id, taking = false)
		@box_id = box_id
		@taking = taking
		@key_press_delay = 0
		@key_press_each_chk = 0
		@key_press_til_max_chk = 6
		@key_press_til_max = 30
	end
  #--------------------------------------------------------------------------
  # Creates background and windows.
  #--------------------------------------------------------------------------
	def start
		super
		SndLib.openChest #play_open_sound
		create_windows
	end
  #--------------------------------------------------------------------------
  # Creates windows.
  #--------------------------------------------------------------------------
	def create_windows
		create_window_ItemStorageLeft
		create_window_ItemStorageRight(@box_id)
		@bag_title = Window_BoxTitle.new(0, $game_text["menu:Box/Body"])
		@box_title = Window_BoxTitle.new((Graphics.width/2),Storage_Boxes_Setting::BOXES[@box_id][:name], @box_id)
		@trade_sort_window = nil
		if @taking
			@box_window.activate.select_last
			@bag_window.deactivate.select_last
		else
			@bag_window.activate.select_last
			@box_window.deactivate.select_last
		end
	end

	def create_window_ItemStorageLeft
		@bag_window = Window_ItemStorageLeft.new
	end
	def create_window_ItemStorageRight(boxID=@box_id)
		@box_window = Window_ItemStorageRight.new(boxID)
	end
  #--------------------------------------------------------------------------
  # Frame update.
  #--------------------------------------------------------------------------
	def update
		super
		update_item_selection
		mouse_input
	end
	

  #--------------------------------------------------------------------------
  # Update input.
	#--------------------------------------------------------------------------
	def update_item_selection
		if @trade_sort_window
			return press_sort_return if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK) || (Mouse.enable? &&  Input.trigger?(:MX_LINK))
			update_sort_window
		elsif Input.trigger?(:B) || WolfPad.trigger?(:X_LINK) || (Mouse.enable? &&  Input.trigger?(:MX_LINK))#x
			SndLib.closeChest#play_close_sound
			SceneManager.goto(Scene_Map)
		elsif Input.press?(:SHIFT)
			move_item("max") if Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK) #|| (Mouse.enable? && Input.trigger?(:MZ_LINK))
		elsif Input.trigger?(:UI_SORT)
			create_sort_window
			SndLib.openChest
		elsif Input.trigger?(:S9)
			move_item(10)
		elsif (Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK))
			move_item
		elsif Input.press?(:S9)
			@key_press_delay += 1
			@key_press_each_chk += 1
			if @key_press_delay >= @key_press_til_max && @key_press_each_chk >= @key_press_til_max_chk
				@key_press_each_chk = 0
				move_item(10)
			end
		elsif Input.press?(:C) || WolfPad.press?(:Z_LINK) || Input.press?(:MZ_LINK)
			@key_press_delay += 1
			@key_press_each_chk += 1
			if @key_press_delay >= @key_press_til_max && @key_press_each_chk >= @key_press_til_max_chk
				@key_press_each_chk = 0
				move_item
			end
		elsif Input.trigger?(:LEFT) && !@bag_window.active
			SndLib.play_cursor
			switch_over
		elsif Input.trigger?(:RIGHT) && !@box_window.active
			SndLib.play_cursor
			switch_over
		else
			@key_press_delay = 0
			@key_press_each_chk = 0
		end
	end

	def update_sort_window
		@trade_sort_window.update
		#return press_sort_return if @trade_sort_window.choosed == "Return"
		if !@trade_sort_window.choosed.nil?
			handlerSort(@trade_sort_window.choosed)  #&& @trade_sort_window.choosed != "Return"
			@trade_sort_window.choosed = nil
			return
		end
	end

	def handlerSort(value)
		SndLib.sys_DialogBoard
		#dispose_sort_window
		p @bag_window.sort_rule
		p value
		if @prev_bag_window_active
			@bag_window.index = 0
			@bag_window.prev_sort_rule = @bag_window.sort_rule if @bag_window.prev_sort_rule != @bag_window.sort_rule
			@bag_window.switch_sort_reverse if @bag_window.prev_sort_rule == @bag_window.sort_rule
			@bag_window.sort_rule = @bag_window.sort_rule.merge(value)
			p @bag_window.sort_rule
			p value
			@bag_window.refresh
		elsif @prev_box_window_active
			@box_window.index = 0
			@box_window.prev_sort_rule = @box_window.sort_rule if @box_window.prev_sort_rule != @box_window.sort_rule
			@box_window.switch_sort_reverse if @box_window.prev_sort_rule == @box_window.sort_rule
			@box_window.sort_rule.merge(value)
			@box_window.refresh
		end
		#p "handler tgt  #{tmpSortTgt}"
		#p "handler < #{@bag_window.sort_rule}"
		#p "handler > #{@box_window.sort_rule}"
		refresh
	end
	def press_sort_return
		SndLib.sys_DialogBoard
		dispose_sort_window
	end

	def create_sort_window
		@prev_bag_window_active = @bag_window.active
		@prev_box_window_active = @box_window.active
		@trade_sort_window = Trade_Sort_Command.new
		@bag_window.active = false if @bag_window
		@box_window.active = false if @box_window
	end
	def dispose_sort_window
		@trade_sort_window.dispose if @trade_sort_window
		@trade_sort_window = nil
		@bag_window.active = @prev_bag_window_active if @bag_window
		@box_window.active = @prev_box_window_active if @box_window
	end
	def switch_over
		if @bag_window.active
			@bag_window.deactivate
			@box_window.activate
		else
			@box_window.deactivate
			@bag_window.activate
		end
		@box_window.update_cursor
		@bag_window.update_cursor
	end
	def switch_beg(play_snd=true)
		SndLib.play_cursor if play_snd
		@box_window.deactivate
		@bag_window.activate
		@box_window.update_cursor
		@bag_window.update_cursor
	end
	def switch_box(play_snd=true)
		SndLib.play_cursor if play_snd
		@bag_window.deactivate
		@box_window.activate
		@box_window.update_cursor
		@bag_window.update_cursor
	end
  #--------------------------------------------------------------------------
  # Move item from one side to the other.
  #--------------------------------------------------------------------------
  #417 fix 
	def move_item(val=nil)
		withdrawn = deposited = false
		if @box_window.active && can_move_item_to_inventory?(@box_window.item)
			item = @box_window.item
			if val == "max"
				box_item_num = $game_boxes.item_number(item, @box_id)
			elsif val && val.is_a?(Numeric) && val >= 1
				box_item_num = [$game_boxes.item_number(item, @box_id),val].min
			else
				box_item_num = 1
			end
			$game_boxes.remove_item(item, box_item_num, @box_id)
			$game_party.gain_item(item, box_item_num)
			SndLib.sys_equip(80,140)
			withdrawn = true
		elsif @bag_window.active && can_move_item_to_box?(@bag_window.item)
			item = @bag_window.item
			if val == "max"
				party_item_num = $game_party.item_number(item)
			elsif val && val.is_a?(Numeric) && val >= 1
				party_item_num = [$game_party.item_number(item),val].min
			else
				party_item_num = 1
			end
			$game_party.lose_item(item, party_item_num)
			$game_boxes.add_item(item, party_item_num, @box_id)
			SndLib.sys_equip 
			deposited = true
		end
		if !(withdrawn || deposited)
			SndLib.sys_buzzer
		end
		refresh
	end
  
	def can_move_item_to_box?(item)
		if @bag_window.index < 0 or item.nil?
			return false
		elsif !$game_boxes.space?(@box_id) or !@bag_window.enable?(item)
			return false
		else
			return true
		end
	end
  #--------------------------------------------------------------------------
  # Returns true if item can be moved from the box to the inventory.
  #--------------------------------------------------------------------------
	def can_move_item_to_inventory?(item)
		if @box_window.index < 0 or item.nil?
			return false
		else
			return true
		end
	end
  #--------------------------------------------------------------------------
  # Refreshes windows.
  #--------------------------------------------------------------------------
	def refresh
		@box_window.refresh
		@bag_window.refresh
		@bag_title.refresh
		@box_title.refresh
		#refresh_help_window
	end
  #--------------------------------------------------------------------------
  # Refreshes the help window
  #--------------------------------------------------------------------------
	def refresh_help_window
		@box_window.call_update_help
		@bag_window.call_update_help
	end
  #--------------------------------------------------------------------------
  # Termination Processing.
  #--------------------------------------------------------------------------
	def terminate
		super
		dispose_sort_window if @trade_sort_window
		@bag_window.dispose
		@box_window.dispose
		# @help_window.dispose
		@bag_title.dispose
		@box_title.dispose
	end


	############################################################3 MOUSE


	def mouse_can_control?
		return false if @trade_sort_window
		return true
	end

	def mouse_input
		return Mouse.ForceIdle if Input.MouseWheelForceIdle?
		return if !Mouse.enable?
		return if @trade_confirm_window
		return if @trade_sort_window
		#return mouse_exit if Input.trigger?(:MX_LINK)
		return switch_beg(play_snd=true) if !@bag_window.active? && Mouse.within?(@bag_window) && mouse_can_control?
		return switch_box(play_snd=true) if !@box_window.active? && Mouse.within?(@box_window) && mouse_can_control?
		#return switch_beg if !@bag_window.active? && Mouse.within?(@bag_window) && mouse_can_control? && (Input.repeat?(:L) || Input.repeat?(:R))
		#return switch_box if !@box_window.active? && Mouse.within?(@box_window) && mouse_can_control? && (Input.repeat?(:L) || Input.repeat?(:R))
		return if !Input.trigger?(:MZ_LINK)
		mouse_input_result
	end
	def mouse_input_result
		if @box_window.active?
			currentBox = @box_window
		else
			currentBox = @bag_window
		end
		@mouse_all_rects = []
		currentBox.item_max.times {|i|
			rect = currentBox.item_rect(i)
			rect.x += currentBox.x + currentBox.standard_padding - currentBox.ox
			rect.y += currentBox.y + currentBox.standard_padding - currentBox.oy
			if !currentBox.viewport.nil?
				rect.x += currentBox.viewport.rect.x - currentBox.viewport.ox
				rect.y += currentBox.viewport.rect.y - currentBox.viewport.oy
			end
			@mouse_all_rects.push(rect)
		}

		tmpIndex = currentBox.index
		currentBox.item_max.times {|i|
			next unless Mouse.within?(@mouse_all_rects[i])
			currentBox.index = i if mouse_can_control?
		}
		return SndLib.play_cursor if currentBox.index != tmpIndex && mouse_can_control?
		mouse_update_click_selection(currentBox,tmpIndex=currentBox.index)
	end
	#def mouse_exit
	#		SndLib.closeChest
	#		SceneManager.goto(Scene_Map)
	#end
	def mouse_update_click_selection(currentBox,tmpIndex)
		return if @trade_confirm_window
		return if @trade_sort_window
		if Input.trigger?(:MZ_LINK) && !mouse_within_index(currentBox,tmpIndex)
			SndLib.sys_buzzer
		elsif Input.press?(:SHIFT) && Input.trigger?(:MZ_LINK)
			move_item("max")
		elsif Input.trigger?(:MZ_LINK)
			move_item
		end
	end
	def mouse_within_index(currentBox,tmpIndex)
		currentBox.item_max.times {|i|
			return true if Mouse.within?(@mouse_all_rects[tmpIndex])
		}
		return false
	end


end # Scene_ItemStorage
#==============================================================================
# Window_Item_StorageLeft
#==============================================================================
class Window_ItemStorageLeft < Window_ItemList
	#--------------------------------------------------------------------------
	# Edited to make there only one column, to change the positioning and make 
	# it inactive by default.
	#--------------------------------------------------------------------------
	def make_item_list
		@data = $game_party.all_items.select {|item| include?(item) }
		sort_item_list#(tmpMode=@record_type_tag,tmpTag=@record_type_tag)
		#@data.push(nil) if include?(nil)
	end
	def initialize
		y_pos = fitting_height(-1)
		y_pos += fitting_height(1)
		super(0, y_pos, Graphics.width/2, Graphics.height-y_pos)
		refresh
	end
  #--------------------------------------------------------------------------
  # Checks item for note
  #--------------------------------------------------------------------------
	def enable?(item)
		return false if item.key_item?
		return !(item.key_item?)
	end
  #--------------------------------------------------------------------------
  # Include all items
  #--------------------------------------------------------------------------
  def include?(item)
    !item.nil?
  end
  #--------------------------------------------------------------------------
  # * Number of columns
  #--------------------------------------------------------------------------
  def col_max
    return 1
  end
  #--------------------------------------------------------------------------
  # * If moved item over, select existing item
  #--------------------------------------------------------------------------
  def refresh
    super
    if @data[@index].nil?
      cursor_up(true)
    end
  end
  #--------------------------------------------------------------------------
  # * Get Number of Items
  #--------------------------------------------------------------------------
  def item_max
    @data ? [1, @data.size].max : 1
  end
  
end # Window_ItemStorageLeft

#==============================================================================
# Window_ItemStorageRight
#==============================================================================
class Window_ItemStorageRight < Window_ItemList
	attr_reader :data
	#--------------------------------------------------------------------------
	# Edited to make there only one column, to change the positioning and make 
	# it inactive by default.
	#--------------------------------------------------------------------------
	def initialize(box_id)
		@box_id = box_id
		y_pos = fitting_height(-1)
		y_pos += fitting_height(1)
		super(Graphics.width/2, y_pos, Graphics.width/2, Graphics.height-y_pos)
		@sort_rule[:type_tag] = "Money"
		refresh
	end
  #--------------------------------------------------------------------------
  # Include all items
  #--------------------------------------------------------------------------
  def include?(item)
    !item.nil?
  end
  def enable?(item)
    true
  end
  #--------------------------------------------------------------------------
  # * Create Item List
  #--------------------------------------------------------------------------
 	 def make_item_list
		@data = $game_boxes.box(@box_id).keys.select {|item| include?(item) }
		sort_item_list#(tmpMode=@record_type_tag,tmpTag=@record_type_tag)
		#@data.push(nil) if include?(nil)
	end
  #--------------------------------------------------------------------------
  # * Number of columns
  #--------------------------------------------------------------------------
  def col_max
    return 1
  end
  #--------------------------------------------------------------------------
  # * Draw Number of Items
  #--------------------------------------------------------------------------
  def draw_item_number(rect, item)
    #draw_text(rect, sprintf(":%2d", $game_boxes.item_number(item, @box_id)), 2)
	self.contents.font.size = 16
	self.contents.font.outline = false
    self.contents.draw_text(rect, sprintf("#{(item.weight).round(1)}w   #{item.get_sell_price}p   x#{$game_boxes.item_number(item, @box_id)}"), 2)
  end
  #--------------------------------------------------------------------------
  # * If moved item over, select existing item
  #--------------------------------------------------------------------------
  def refresh
    super
    if @data[@index].nil?
      cursor_up(true)
    end
  end
  #--------------------------------------------------------------------------
  # * Get Number of Items
  #--------------------------------------------------------------------------
  def item_max
    @data ? [1, @data.size].max : 1
  end
end # Window_ItemStorageRight

#==============================================================================
# Window_BoxTitle
#==============================================================================
class Window_BoxTitle < Window_Base
  #--------------------------------------------------------------------------
  # Initialization.
  #--------------------------------------------------------------------------
  def initialize(x, t, box = nil)
    y_pos = fitting_height(-1)
    super(x, y_pos, Graphics.width/2, fitting_height(1))
	contents.font.outline = false
    @box = box
    @title = t
    refresh
  end
  #--------------------------------------------------------------------------
  # Frame update.
  #--------------------------------------------------------------------------
  def update
    super
    if is_box_title?
      a = $game_boxes.how_full(@box, true) != @text 
      b = $game_boxes.how_full(@box, false) != @text
      if a and b
        refresh
      end
    end
  end
  #--------------------------------------------------------------------------
  # Draws the contents.
  #--------------------------------------------------------------------------
  def refresh
    self.contents.clear
    self.contents.draw_text(0, 0, (Graphics.width/2)-32, line_height, @title)
    if is_box_title?
      draw_box_amount(Storage_Boxes_Setting::BOXES[@box][:size] != 0)
	  else
      draw_text(0, 0, contents.width, contents.height, "#{(2*$game_player.actor.attr_dimensions["sta"][2] - $game_player.actor.weight_carried).round(1)}w", 2)
    end
  end
  #--------------------------------------------------------------------------
  # Displays how full the box is.
  #--------------------------------------------------------------------------
  def draw_box_amount(draw_maximum)
	text = $game_boxes.how_full(@box, draw_maximum)
	tmpPrice = $game_boxes.get_price(@box)
	tmpWeight = $game_boxes.get_weight(@box)
	self.contents.font.size = 24  #here!!
	self.contents.draw_text(0, 0, (Graphics.width/2)-32, line_height,"#{tmpWeight}w   #{tmpPrice}p   x#{text}", 2)
  end
  #--------------------------------------------------------------------------
  # Returns whether this instance is the title of a box.
  #--------------------------------------------------------------------------
  def is_box_title?
    return !@box.nil?
  end
  #--------------------------------------------------------------------------
  # Returns whether this instance is the title of the player's inventory.
  #--------------------------------------------------------------------------
  def is_inventory_title?
    return @box.nil?
  end
end # Window_BoxTitle





##################################################################################################
################################################################################################## Storage Trade
##################################################################################################
##################################################################################################



class Scene_TradeStorage < Scene_ItemStorage
	def create_windows
		create_window_ItemStorageLeft(noBuy=@noBuy,noSell=@noSell)
		create_window_ItemStorageRight(boxID=@box_id)
		@help_window = WindowTradeStoreHelp.new(4)
		@bag_title = Window_TradeBoxTitle.new(0, $game_text["menu:Box/Body"],tmpSelfMode=true)
		@box_title = Window_TradeBoxTitle.new((Graphics.width/2),Storage_Boxes_Setting::BOXES[@box_id][:name],tmpSelfMode=false)
		@box_window.help_window = @help_window
		@bag_window.help_window = @help_window
		@bag_window.help_window.back_opacity = 200
		@box_window.activate.select_last
		@bag_window.activate.select_last
		@box_window.deactivate.select_last
		@prev_temp_choice = $game_temp.choice
		@trade_confirm_window = nil
		@trade_sort_window = nil
	end
	
	def create_window_ItemStorageLeft(noBuy=@noBuy,noSell=@noSell)
		@bag_window = Window_TradeStorageLeft.new(noBuy,noSell,extData=nil)
	end
	def create_window_ItemStorageRight(boxID=@box_id,noBuy=@noBuy,noSell=@noSell)
		@box_window = Window_TradeStorageRight.new(boxID,noBuy,noSell,extData=nil)
	end

	def switch_over
		super
		refresh_help_window
	end
	def switch_beg(play_snd=true)
		super(play_snd)
		refresh_help_window
	end
	def switch_box(play_snd=true)
		super(play_snd)
		refresh_help_window
	end
	def refresh
		super
		refresh_help_window
	end
	
	def mouse_can_control?
		return false if @trade_confirm_window
		return super
	end
	def prepare(box_id,noSell=false,noBuy=false,characterHASH)
		@noSell = noSell
		@noBuy = noBuy
		@box_id = box_id
		@characterHASH = characterHASH
		@characterTP = @characterHASH[1]
		@needConfirmB4Close = false
		@resetToDefault= false
		@key_press_delay = 0
		@key_press_each_chk = 0
		@key_press_til_max_chk = 6
		@key_press_til_max = 30
		
		$game_boxes.set_storeTP(@characterTP)
	end
	def create_confirm_window
		@prev_bag_window_active = @bag_window.active
		@prev_box_window_active = @box_window.active
		@trade_confirm_window = Trade_Confirm_Command.new
		@bag_window.active = false if @bag_window
		@box_window.active = false if @box_window
	end
	def dispose_confirm_window
		@trade_confirm_window.dispose if @trade_confirm_window
		@trade_confirm_window = nil
		@bag_window.active = @prev_bag_window_active
		@box_window.active = @prev_box_window_active
	end
	def create_sort_window
		@prev_bag_window_active = @bag_window.active
		@prev_box_window_active = @box_window.active
		@trade_sort_window = Trade_Sort_Command.new
		@bag_window.active = false if @bag_window
		@box_window.active = false if @box_window
	end
	def dispose_sort_window
		@trade_sort_window.dispose if @trade_sort_window
		@trade_sort_window = nil
		@bag_window.active = @prev_bag_window_active if @bag_window
		@box_window.active = @prev_box_window_active if @box_window
	end
	def update_item_selection
		if @trade_confirm_window
			return press_trade_ThinkAgain if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK) || (Mouse.enable? &&  Input.trigger?(:MX_LINK))
			@trade_confirm_window.update
			case @trade_confirm_window.choosed
				when :Accept ; press_trade_Accept
				when :Return ; press_trade_ThinkAgain
				when :Cancel ; press_trade_Cancel
			end
		elsif @trade_sort_window
			return press_sort_return if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK) || (Mouse.enable? &&  Input.trigger?(:MX_LINK))
			update_sort_window
		elsif @needConfirmB4Close && ((Input.trigger?(:B) || WolfPad.trigger?(:X_LINK)) || (Mouse.enable? && Input.trigger?(:MX_LINK)))
			@needConfirmB4Close = false
			create_confirm_window
			SndLib.openChest
		elsif Input.trigger?(:B) || WolfPad.trigger?(:X_LINK) || (Mouse.enable? &&  Input.trigger?(:MX_LINK)) #x
			SndLib.closeChest
			SceneManager.goto(Scene_Map)
		elsif Input.press?(:SHIFT)
			move_item("max") if Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)# || (Mouse.enable? && Input.trigger?(:MZ_LINK))
		elsif Input.trigger?(:UI_SORT)
			create_sort_window
			SndLib.openChest
		elsif Input.trigger?(:S9)
			move_item(10)
		elsif (Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK))
			move_item
		elsif Input.press?(:S9)
			@key_press_delay += 1
			@key_press_each_chk += 1
			if @key_press_delay >= @key_press_til_max && @key_press_each_chk >= @key_press_til_max_chk
				@key_press_each_chk = 0
				move_item(10)
			end
		elsif Input.press?(:C) || WolfPad.press?(:Z_LINK) || Input.press?(:MZ_LINK)
			@key_press_delay += 1
			@key_press_each_chk += 1
			if @key_press_delay >= @key_press_til_max && @key_press_each_chk >= @key_press_til_max_chk
				@key_press_each_chk = 0
				move_item
			end
		elsif Input.trigger?(:LEFT) && !@bag_window.active
			SndLib.play_cursor
			switch_over
		elsif Input.trigger?(:RIGHT) && !@box_window.active
			SndLib.play_cursor
			switch_over
		else
			@key_press_delay = 0
			@key_press_each_chk = 0
		end
	end
	
	def	press_trade_Cancel
		@resetToDefault= true
		SndLib.sys_PaperTear
		SceneManager.goto(Scene_Map)
	end
	def press_trade_ThinkAgain
		SndLib.sys_DialogBoard
		@needConfirmB4Close = true
		dispose_confirm_window
		dispose_sort_window
	end
	def press_trade_Accept
		SndLib.closeChest
		@resetToDefault= false
		SndLib.sound_step_chain(100,90)
		SceneManager.goto(Scene_Map)
	end
	def terminate
		dispose_confirm_window
		if @resetToDefault
			$game_party.set_items($game_boxes.get_defaultPlayeritems)
			$game_party.set_weapons($game_boxes.get_defaultPlayerweapons)
			$game_party.set_armors($game_boxes.get_defaultPlayerarmors)
			$game_party.set_gold($game_boxes.get_defaultPlayerGold)
		else
			@characterTP = $game_boxes.get_storeTP
			$game_boxes.set_storeTP(0) if $game_boxes.get_storeTP < 0
			$game_boxes.exportStoreItems(System_Settings::STORAGE_TEMP,@characterHASH,$game_boxes.get_storeTP)
		end
		super
	end
	
	def move_item(val=nil)
		withdrawn = deposited = false
			#將物品買入
		if @box_window.active && can_move_item_to_inventory?(@box_window.item)
			item = @box_window.item
			item_price = $game_boxes.getStoreItemPrice(item)
			return SndLib.sys_buzzer if item.key_item?
			@characterTP < 0 ? absTP = @characterTP.abs : absTP  = 0 #若對方沒錢了則紀錄ABS負數版的TP
			if val == "max"
				if ($game_party.gold+absTP) >= $game_boxes.item_number(item, @box_id)*item_price
					box_item_num = $game_boxes.item_number(item, @box_id)
				else
					box_item_num = (($game_party.gold+absTP) / item_price).to_i
				end
			elsif val && val.is_a?(Numeric) && val >= 1
				if ($game_party.gold+absTP) >= $game_boxes.item_number(item, @box_id)*item_price
					box_item_num = $game_boxes.item_number(item, @box_id)
				else
					box_item_num = (($game_party.gold+absTP) / item_price).to_i
				end
				box_item_num = [box_item_num,val].min
			else
				box_item_num = 1
			end
			return SndLib.sys_buzzer if box_item_num <= 0
			tmpResult = item_price*box_item_num
			$game_boxes.set_storeTP($game_boxes.get_storeTP + tmpResult)
			@characterTP = $game_boxes.get_storeTP
			
			if absTP >= 1 #若對方沒錢則扣對方賒帳
				if tmpResult > absTP #若扣款大於對方負數ABS則扣玩家款
					tmpVal = tmpResult-absTP 
					$game_party.lose_gold(tmpVal)
				end
			else
				$game_party.lose_gold(tmpResult)
			end
			$game_boxes.remove_item(item, box_item_num, @box_id)
			$game_party.gain_item(item, box_item_num)
			#p "asdasdasd=> #{box_item_num}  #{item_price}  #{$game_boxes.get_storeTP}  #{$game_party.gold}"
			SndLib.sys_equip(80,140)
			@needConfirmB4Close = true
			withdrawn = true
			
			
			
			#將物品賣出
		elsif @bag_window.active && can_move_item_to_box?(@bag_window.item)
			item = @bag_window.item
			item_price = item.get_sell_price
			return SndLib.sys_buzzer if item.key_item?
			if val == "max"
				if $game_boxes.get_storeTP >= $game_party.item_number(item)*item_price
					party_item_num = $game_party.item_number(item)
				else
					party_item_num = (@characterTP / item_price).to_i
				end
			elsif val && val.is_a?(Numeric) && val >= 1
				party_item_num = [$game_party.item_number(item),val].min
			else
				party_item_num = 1
			end
			return SndLib.sys_buzzer if party_item_num <= 0 #若購買量小等於0則不做事
			tmpResult = $game_boxes.get_storeTP - item_price*party_item_num #將商店金錢-購買量*單價
			getRest = tmpResult < 0 #若質為負數則取肘對方的餘款
			getRestVal = $game_boxes.get_storeTP #記錄對方的餘款
			#tmpResult = [tmpResult,0].max #保護商店的金錢  避免出現負數
			$game_boxes.set_storeTP(tmpResult) #寫入TP至商店紀錄
			@characterTP = $game_boxes.get_storeTP  #寫入TP至UI
			$game_party.lose_item(item, party_item_num)
			if getRest
				$game_party.gain_gold(getRestVal) if getRestVal > 0 #必須大於0才入帳
			else
				$game_party.gain_gold(item_price*party_item_num)
			end
			itemInListPrice = 0
			itemInListNumber = 0
			itemInList = @characterHASH[0].any?{|ary|
				itemInListPrice = ary[3]
				itemInListNumber = ary[4]
				case ary[0]
					when 0 ;
							$data_items[ary[1]] == item
					when 1 ; 
							$data_weapons[ary[1]] == item
					when 2 ; 
							$data_armors[ary[1]] == item
				end
			}
			if !itemInList
				itemInListPrice = 0
				itemInListNumber = 0
			end
			
			if itemInList && itemInListPrice > item.get_sell_price
				$game_boxes.setStoreWithPrice(@box_id,item,itemInListPrice,party_item_num)
			else
				$game_boxes.setStoreWithPrice(@box_id,item,item.price,party_item_num)
			end
			SndLib.sys_equip
			@needConfirmB4Close = true
			deposited = true
		end
		if !(withdrawn || deposited)
			SndLib.sys_buzzer
		end
		refresh
	end
	
	
	
	##################################################################### can SELL?
	def can_move_item_to_box?(item)
		if @bag_window.index < 0 or item.nil?
			return false
		elsif !$game_boxes.space?(@box_id) or !@bag_window.enable?(item)
			return false
		else
			if @noSell
				@box_title.warningTP
				return false
			elsif item.get_sell_price == 0
				return false
			end
			if item.get_sell_price > $game_boxes.get_storeTP
				@box_title.warningTP
				SndLib.sys_buzzer
			end
			return true
		end
	end
	
	##################################################################### can BUY?
	def can_move_item_to_inventory?(item)
		if @box_window.index < 0 or item.nil?
			return false
		else
			@characterTP < 0 ? absTP = @characterTP.abs : absTP  = 0
			if ($game_boxes.getStoreItemPrice(item) > $game_party.gold+absTP) || @noBuy
				@bag_title.warningTP
				return false
			end
			return true
		end
	end
end #Scene_TradeStorage


class Window_TradeStorageLeft < Window_ItemList
  #--------------------------------------------------------------------------
  # Edited to make there only one column, to change the positioning and make 
  # it inactive by default.
  #--------------------------------------------------------------------------
	def initialize(noBuy,noSell,extData)
		@noBuy = noBuy
		@noSell = noSell
		@extData = extData
		y_pos = fitting_height(2)
		y_pos += fitting_height(1)
		super(0, y_pos, Graphics.width/2, Graphics.height-y_pos)
		self.z = System_Settings::SCENE_Menu_ContentBase_Z
		refresh
	end
	
	############################# to STORAGE ITEM BAN LIST
	def enable?(item)
		return false if @noSell
		return false if item.key_item?
		return false if item.get_sell_price >= $game_boxes.getStoreItemPrice(item) && $game_boxes.getStoreItemExist?(item)
		return false if ["SurgeryCoupon","TravelTricket","Key"].include?(item.type_tag)
		return !(item.key_item?)
	end
	#--------------------------------------------------------------------------
	# Include all items
	#--------------------------------------------------------------------------
	def include?(item)
		!item.nil?
	end
	#--------------------------------------------------------------------------
	# * Number of columns
	#--------------------------------------------------------------------------
	def col_max
		return 1
	end
	#--------------------------------------------------------------------------
	# * If moved item over, select existing item
	#--------------------------------------------------------------------------
	def refresh
		super
		if @data[@index].nil?
		cursor_up(true)
		end
	end
	#--------------------------------------------------------------------------
	# * Get Number of Items
	#--------------------------------------------------------------------------
	def item_max
		@data ? [1, @data.size].max : 1
	end
end # Window_ItemStorageLeft




class Window_TradeStorageRight < Window_ItemList
  attr_reader :data
  #--------------------------------------------------------------------------
  # Edited to make there only one column, to change the positioning and make 
  # it inactive by default.
  #--------------------------------------------------------------------------
	def initialize(box_id,noBuy,noSell,extData)
		@box_id = box_id
		@noBuy = noBuy
		@noSell = noSell
		@extData = extData
		y_pos = fitting_height(2)
		y_pos += fitting_height(1)
		super(Graphics.width/2, y_pos, Graphics.width/2, Graphics.height-y_pos)
		@sort_rule[:type_tag] = "Money"
		self.z = System_Settings::SCENE_Menu_ContentBase_Z
		refresh
	end
	#--------------------------------------------------------------------------
	# Include all items
	#--------------------------------------------------------------------------
	def include?(item)
		!item.nil?
	end
	def enable?(item)
		return false if @noBuy
		true
	end
	#--------------------------------------------------------------------------
	# * Create Item List
	#--------------------------------------------------------------------------
	def make_item_list
		@data = $game_boxes.box(@box_id).keys.select {|item| include?(item) }
		sort_item_list#(tmpMode=@record_type_tag,tmpTag=@record_type_tag)
		#@data.push(nil) if include?(nil)
	end
	#--------------------------------------------------------------------------
	# * Number of columns
	#--------------------------------------------------------------------------
	def col_max
		return 1
	end
	#--------------------------------------------------------------------------
	# * Draw Number of Items
	#--------------------------------------------------------------------------
	def draw_item_number(rect, item)
		#draw_text(rect, sprintf(":%2d", $game_boxes.item_number(item, @box_id)), 2)
		self.contents.font.size = 16
		self.contents.font.outline = false
		item.weight = 0 if !item.weight
		self.contents.draw_text(rect, sprintf("#{(item.weight).round(1)}w   #{$game_boxes.getStoreItemPrice(item)}p   x#{$game_boxes.item_number(item, @box_id)}"), 2)
	end
  #--------------------------------------------------------------------------
  # * If moved item over, select existing item
  #--------------------------------------------------------------------------
  def refresh
    super
    if @data[@index].nil?
      cursor_up(true)
    end
  end
  #--------------------------------------------------------------------------
  # * Get Number of Items
  #--------------------------------------------------------------------------
  def item_max
    @data ? [1, @data.size].max : 1
  end
end # Window_ItemStorageRight

class Window_TradeBoxTitle < Window_Base
  #--------------------------------------------------------------------------
  # Initialization.
  #--------------------------------------------------------------------------
	def initialize(x, t,tmpSelfMode= false)
		@selfMode = tmpSelfMode
		y_pos = fitting_height(0)
		tmpWitdh = (Graphics.width/32)+(Graphics.width/2)
		tmpX = (Graphics.width-tmpWitdh)/2
		@selfMode ? tmpWindowX = 0 : tmpWindowX = Graphics.width - tmpX
		super(tmpWindowX, y_pos, tmpX, fitting_height(3))
		self.z = System_Settings::SCENE_Menu_ContentBase_Z
		contents.font.outline = false
		@title = t
		@redFlash = false
		@redFlashFrameDefault = 15
		@redFlashFrame = @redFlashFrameDefault
		
		refresh
	end
  
	def draw_box_amount
		self.contents.clear
		self.contents.font.size = 24
		tmpPlayerTP = $game_party.gold
		tmpStoreTP = $game_boxes.get_storeTP
		if @selfMode
			self.contents.draw_text(0, 0, contents.width, line_height, @title,0)
			self.contents.draw_text(0, 0, contents.width, line_height,"#{(2*$game_player.actor.attr_dimensions["sta"][2] - $game_player.actor.weight_carried).round(1)}w", 2)
			if tmpStoreTP < 0
				self.contents.font.size = 18
				self.contents.draw_text(0, 0, contents.width, line_height*3,"#{tmpPlayerTP} + #{tmpStoreTP.abs} =", 0)
				self.contents.font.size = 24
				self.contents.draw_text(0, 0, contents.width, line_height*5,"#{tmpPlayerTP+tmpStoreTP.abs} TP", 0)
			else
				self.contents.draw_text(0, 0, contents.width, line_height*5,"#{tmpPlayerTP} TP", 0)
			end
		
		else
			self.contents.draw_text(0, 0, contents.width, line_height, @title,2)
			self.contents.draw_text(0, 0, contents.width, line_height*5,"#{tmpStoreTP} TP", 2)
		end
	end
	
	def warningTP
		@redFlash = true
			@redFlashFrame = @redFlashFrameDefault
	end
	
	def refresh
		draw_box_amount
		if @redFlash && @redFlashFrame >= 1
			@redFlashFrame -= 1
			self.contents.font.color=Color.new(50+rand(205),25,25,255)
		else
			@redFlash = false
			@redFlashFrame = @redFlashFrameDefault
			self.contents.font.color=Color.new(255,255,255,255)
		end
	end
	
	def update
		super
		refresh
	end
end

class WindowTradeStoreHelp < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
	def initialize(line_number = 4)
		tmpWitdh = (Graphics.width/32)+(Graphics.width/2)
		tmpX = (Graphics.width-tmpWitdh)/2
		super(tmpX, 0, tmpWitdh, fitting_height(line_number))
		self.z = System_Settings::SCENE_Menu_ContentBase_Z
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
	def process_normal_character(c, pos,text)
		contents.font.outline = false
		contents.font.size = System_Settings::FONT_SIZE::SCENE_STORAGE_HELP
		process_normal_character_wordwarp(c, pos,text)
	end
	def process_escape_character(code, text, pos)
		case code.upcase
			when 'N'
				process_new_line(text, pos)
			else
				super
		end
	end


end




##########################################
class Trade_Confirm_Command < Sprite
	attr_accessor 		:choosed
	def initialize
		super(nil)
		@basic_X = 0 if !@basic_X
		@basic_Y = 57 if !@basic_Y
		@basic_I = 24 if !@basic_I
		tmpW = Graphics.width
		tmpH = Graphics.height
		self.bitmap = Bitmap.new(tmpW,tmpH)
		self.x = @basic_X
		self.y = @basic_Y
		self.bitmap.font.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
		self.bitmap.font.outline = false
		self.bitmap.font.bold = true
		self.z = 2+System_Settings::SCENE_Menu_ContentBase_Z
		self.bitmap.font.size = 24
		@onBegin = true
		@optSymbol = {}
		@optNames = {}
		@optOptions = {}
		@optSettings = {}
		@choosed = nil
		firstTimeBuildOPT
		create_background
		draw_items
		refresh_index(1)
		@onBegin = false
	end


	def create_background
		@sprite1 = Sprite.new
		@sprite1.bitmap = Cache.load_bitmap("Graphics/System/","chat_window_black_area50")
		@sprite1.z =  1+System_Settings::SCENE_Menu_ContentBase_Z
		center_sprite(@sprite1)
	end

	def center_sprite(sprite)
		sprite.ox = sprite.bitmap.width / 2
		sprite.oy = sprite.bitmap.height / 2
		sprite.x = Graphics.width / 2
		sprite.y = Graphics.height / 2
	end

	def firstTimeBuildOPT
		buildOptions(:Return,		$game_text["menu:Shop/Return"],					"",[:Return])
		buildOptions(:Accept,		$game_text["menu:traits/accept"],				"",[:Accept])
		buildOptions(:Cancel,		$game_text["DataInput:Key/Cancel"],				"",[:Cancel])
	end
	def buildOptions(key, name, default, options)
		@optSymbol[key] = key
		@optNames[key] = name
		@optSettings[key] = default
		@optOptions[key] = options
		refresh_settings
	end
	def refresh_settings
		@optSettings.each { |s, v| setOPT(s, v) }
	end
	def setOPT(setting, value)
		case setting
			when :Accept;	handlerAccept(value)
			when :Return;	handlerReturn(value)
			when :Cancel;	handlerCancel(value)
		end
	end
	def handlerAccept(value)
		return if @onBegin == true
		@choosed = value
	end
	def handlerReturn(value)
		return if @onBegin == true
		@choosed = value
	end
	def handlerCancel(value)
		return if @onBegin == true
		@choosed = value
	end
	def update
		refresh_index(@index + 1) if Input.trigger?(:DOWN)
		refresh_index(@index - 1) if Input.trigger?(:UP)
		runOption if Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)
		mouse_input_check
	end

	def mouse_input_check
		return Mouse.ForceIdle if Input.MouseWheelForceIdle?
		return if !Mouse.enable?
		return if !Input.trigger?(:MZ_LINK)
		#return SndLib.sys_buzzer if Input.trigger?(:MX_LINK)
		tmpIndex = @index
		tmpIndexWrite = @index
		@mouse_all_rects.length.times{|i|
			next unless Mouse.within?(@mouse_all_rects[i])
			tmpIndexWrite = i
		}
		if  tmpIndexWrite && tmpIndexWrite != tmpIndex
			refresh_index(tmpIndexWrite) if tmpIndexWrite
			SndLib.play_cursor
		elsif Input.trigger?(:MZ_LINK) && !Mouse.within?(@mouse_all_rects[@index])
			return SndLib.sys_buzzer
		elsif Input.trigger?(:MZ_LINK)
			runOption
		end
	end

	def refresh_index(i)
		SndLib.play_cursor if !@onBegin
		clear_item(@index)
		draw_item(@index)
		@index = i % @items.size
		clear_item(@index)
		SceneManager.prevOptChooseSet(@index)
		draw_item(@index, true)
	end

	def draw_items
		@index = 0
		@items = []
		@optNames.keys.each { |k| @items << k }
		draw_item(0,true)
		for i in 1...@items.size
			draw_item(i)
		end
	end

	def dispose
		@sprite1.dispose
		self.bitmap.dispose
		super
	end

	def draw_item(i, active = false)
		c = (active ? 255 : 192)
		textWitdh = self.bitmap.text_size(@optNames[@items[i]]).width
		textRectX = (Graphics.width/2) - (textWitdh/2)
		textRectY = 13+@basic_Y
		self.bitmap.font.color.set(c,c,c)
		self.bitmap.draw_text(textRectX,textRectY+i*@basic_I,416,32,@optNames[@items[i]],0)
		@mouse_all_rects = Array.new if !@mouse_all_rects
		@mouse_all_rects[i] = Rect.new(textRectX,(textRectY-3)*2+i*@basic_I,textWitdh,32)
	end

	def runOption
		options = @optOptions[@items[@index]]
		current = @optSettings[@items[@index]]
		optSYM= @optSymbol[@items[@index]]
		oi = 0
		for i in 0...options.size
			oi = i if options[i] == current
		end
		oi = (oi + 1) % options.size
		@optSettings[@items[@index]] = options[oi]
		clear_item(@index)
		draw_item(@index, true)
		setOPT(optSYM,options[oi])
	end

	def clear_item(i)
		textRectY = 21+@basic_Y
		self.bitmap.clear_rect(25,textRectY+i*@basic_I,416,20)
	end

end

##########################################
class Trade_Sort_Command < Trade_Confirm_Command
	def initialize
		@basic_Y = 25
		super
	end
	def firstTimeBuildOPT
		buildOptions(:Default,		"Default",					"",[{:main_mode => "Default", 	:type_tag => nil} ])
		buildOptions(:Price,		"Price",					"",[{:main_mode => "Price", 	:type_tag => nil} ])
		buildOptions(:Weight,		"Weight",					"",[{:main_mode => "Weight", 	:type_tag => nil} ])
		buildOptions(:Amount,		"Amount",					"",[{:main_mode => "Amount", 	:type_tag => nil} ])
		buildOptions(:T_Food,		"T_Food",					"",[{:main_mode => "Type",		:type_tag => nil, :type => "Food"}])
		buildOptions(:T_Med,		"T_Med",					"",[{:main_mode => "Type",		:type_tag => nil, :type => "Medicine"}])
		buildOptions(:T_Waste,		"T_Waste",					"",[{:main_mode => "Type",		:type_tag => nil, :type => "Waste"}])
		buildOptions(:T_Weapon,		"T_Weapon",					"",[{:main_mode => "Type",		:type_tag => nil, :type => "Weapon"}])
		buildOptions(:T_Armor,		"T_Armor",					"",[{:main_mode => "Type",		:type_tag => nil, :type => "Armor"}])
	end
	def setOPT(setting, value)
		handlerReturn(value) if setting
	end
end



##########################################
class Scene_BankStorage < Scene_ItemStorage
	def create_window_ItemStorageLeft
		@bag_window = Window_BankStorageLeft.new
	end
end

class Window_BankStorageLeft < Window_ItemStorageLeft
	def enable?(item)
		return false if item.common_tags["Lock_BankStorage"]
		return super
	end
end

##########################################
class Scene_TravelStorage < Scene_ItemStorage
	def create_window_ItemStorageLeft
		@bag_window = Window_TravelStorageLeft.new
	end
end

class Window_TravelStorageLeft < Window_ItemStorageLeft
	def enable?(item)
		return false if item.common_tags["Lock_TravelStorage"]
		return super
	end
end

