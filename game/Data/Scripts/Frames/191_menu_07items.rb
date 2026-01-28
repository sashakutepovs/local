#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
#==============================================================================
# ** Menu_Items
#==============================================================================

class Menu_Items < Menu_ContentBase
  
	def initialize
		super()
		@phase = 1 # 1: show, 2: select category, 3: select item, 4: confirm use
		@list_viewport = Viewport.new(156, 79, 456, 156)
		@list_viewport.z = System_Settings::SCENE_Menu_Contents_Z
		
		@back = Sprite.new(@viewport)
		@back.bitmap = Cache.load_bitmap(ROOT,"08Items/item_layout")#Bitmap.new("#{ROOT}08Items/item_layout")

		@category_sprites = Array.new(4){Sprite.new(@viewport)}
		@mouse_top_menu_rect = []
		@mouse_content_dy_rec = 0
		@category_index = 0
		@content_dy = 0
		@display_index = @real_index = 0
		@category_sprites.each_with_index do |spr, index|
			spr.opacity = 192 unless index == 0
			name = [$game_text["menu:items/foods"], $game_text["menu:items/medicine"], $game_text["menu:items/equips"],$game_text["menu:items/other"]].at(index)
			spr.bitmap = Bitmap.new(114, 33)
			spr.bitmap.font.color=Color.new(20,255,20)
			spr.bitmap.font.outline=false
			spr.bitmap.draw_text(spr.src_rect, name, 1)
			spr.x, spr.y, spr.z = 157 + index * 114, 27, System_Settings::SCENE_Menu_Contents_Z
			@mouse_top_menu_rect << [spr.x, spr.y,spr.src_rect.width,spr.src_rect.height]
		end

		@select_block1 = Sprite.new(@viewport)
		@select_block2 = Sprite.new(@viewport)
		@select_block1.bitmap = Cache.load_bitmap(ROOT,"08Items/select_block")#Bitmap.new("#{ROOT}08Items/select_block")
		@select_block2.bitmap = @select_block1.bitmap
		@select_block1.src_rect.width = @select_block1.bitmap.width/2
		@select_block2.src_rect.x = @select_block1.src_rect.width
		@select_block1.z = @select_block2.z = System_Settings::SCENE_Menu_Contents_Z
		@select_block1.visible = @select_block2.visible = false
		
		@contents = [@food = Sprite.new(@list_viewport),
			@medicine = Sprite.new(@list_viewport),
			@other = Sprite.new(@list_viewport),
			@all = Sprite.new(@list_viewport)].each {|spr|spr.z = System_Settings::SCENE_Menu_Contents_Z}
		refresh_category
		refresh_contents
		@item_info = Sprite.new(@viewport)
		@item_info.x, @item_info.y, @item_info.z = 156, 254, System_Settings::SCENE_Menu_Contents_Z
		@item_info.bitmap = Bitmap.new(457,84)
		
		bmp = Cache.load_bitmap(ROOT,"08Items/item_arrow")#Bitmap.new("#{ROOT}08Items/item_arrow")
		@arrow_up = Sprite.new(@viewport)
		@arrow_up.bitmap = Bitmap.new(237, 12)
		rect = Rect.new(20, 0, 19, 12)
		@arrow_up.bitmap.blt(0, 0, bmp, rect)
		@arrow_up.bitmap.blt(109, 0, bmp, rect)
		@arrow_up.bitmap.blt(218, 0, bmp, rect)
		@arrow_down = Sprite.new(@viewport)
		@arrow_down.bitmap = Bitmap.new(237, 12)
		rect = Rect.new(0, 0, 19, 12)
		@arrow_down.bitmap.blt(0, 0, bmp, rect)
		@arrow_down.bitmap.blt(109, 0, bmp, rect)
		@arrow_down.bitmap.blt(218, 0, bmp, rect)
		bmp.dispose
		@arrow_up.x, @arrow_up.y, @arrow_up.z = 265, 63, System_Settings::SCENE_Menu_Contents_Z
		@arrow_down.x, @arrow_down.y, @arrow_down.z = 265, 238, System_Settings::SCENE_Menu_Contents_Z
		@arrow_up.visible = @arrow_down.visible = false
		create_confirm_bitmap
		hide
	end
  
	def create_confirm_bitmap
		@confirm_back = Sprite.new
		@confirm_back.bitmap = Cache.load_bitmap("Graphics/System/","chat_window_black_area50")#Bitmap.new("Graphics/System/chat_window_black_area50")
		@confirm_back.z = 1+System_Settings::SCENE_Menu_Contents_Z
		
		@confirm_layer = Sprite.new
		@confirm_layer.bitmap = Bitmap.new(Graphics.width, Graphics.height)
		@confirm_layer.z = @confirm_back.z + 1+System_Settings::SCENE_Menu_Contents_Z
		#170, 122, 300, 65) 
		bmp = @confirm_layer.bitmap
		bmp.font.size = 18
		bmp.font.color = Color.new(0,255,0)
		bmp.draw_text(238,178,166,42,InputUtils.getKeyAndTranslate(:C),0)
		bmp.font.color = Color.new(255,0,0)
		bmp.draw_text(238,178,166,42,InputUtils.getKeyAndTranslate(:UI_DeleteItem),1)
		bmp.font.color = Color.new(255,255,0)
		bmp.draw_text(238,178,166,42,InputUtils.getKeyAndTranslate(:B),2)
		bmp.font.color = Color.new(255,255,255)
		bmp.font.size = 16
		bmp.draw_text(238,191,166,42,$game_text["menu:items/confirm_accept"],0)
		bmp.draw_text(238,191,166,42,$game_text["menu:items/confirm_drop"],1)
		bmp.draw_text(238,191,166,42,$game_text["menu:items/confirm_cancel"],2)
		@confirm_back.visible = @confirm_layer.visible = false	
	end
  
	def enter_page
		SndLib.sys_ok
		@phase = 2
		@category_index ||= 0
		refresh_category(reset=false)
		move_cursor
		Input.update
	end
	
	def update
		return if !@viewport.visible
		mouse_update_input
		return unless @phase > 1
		update_input
		update_select
		update_content_scroll
		update_arrow
	end
	
	def mouse_update_input
		return Mouse.ForceIdle if Input.MouseWheelForceIdle?
		return if !Mouse.enable?
		return mouse_update_confirm_window if @phase == 4 ##確認畫面更新
		return mouse_press_cancel if Input.trigger?(:MX_LINK) && @phase >= 2
		tmpWithInMainMenuArea = Mouse.within_XYWH?(0, 0, 156, 360)
		tmpWithInItemArea = Mouse.within_XYWH?(152, 65, 456, 185)
		tmpPressed_MZ_LINK = Input.trigger?(:MZ_LINK)
		sound_played = false
		#back to main menu
		if tmpPressed_MZ_LINK && tmpWithInMainMenuArea
			if @phase != 1
				SndLib.sys_cancel if !sound_played
				sound_played = true
				show
			end
			@phase = 1
			@menu.activate
			return
		end
		return unless tmpPressed_MZ_LINK || ((Input.trigger?(:L) || Input.trigger?(:R)) && tmpWithInItemArea)
		#check top index
		tmpTopIndex = nil
		@mouse_top_menu_rect.length.times {|i|
			spr = @menu.menu_sprites[i]
			next unless Mouse.within_XYWH?(*@mouse_top_menu_rect[i])
			tmpTopIndex = i
		}
		if !tmpWithInMainMenuArea && @phase == 1
			enter_page
			sound_played = true
		end
		
		#clicked top area
		if tmpTopIndex && tmpTopIndex != @category_index
			SndLib.play_cursor if !sound_played
			sound_played = true
			@category_index = tmpTopIndex
			refresh_category
			@phase = 2
			move_cursor
		end
		
		#clicked item area
		if tmpWithInItemArea
			if @phase != 3
				firstClickBlock = true #用以阻擋還沒進去時 且直接點了ITEM 0
				SndLib.sys_ok if !sound_played
				sound_played = true
				@phase = 3
				@item_info.visible = true
				refresh_info
			end
			#check item index
			tmpItemIndex = nil
			@mouse_items_rect.length.times {|i|
				spr = @menu.menu_sprites[i]
				next unless Mouse.within_XYWH?(*@mouse_items_rect[i])
				tmpItemIndex = i
			}
			if tmpItemIndex && tmpPressed_MZ_LINK
				#翻譯 sprite 的Y 並轉換成物品列的追加直
				tmpTranslatedItemNum = (@contents[@category_index].y/26).abs*2 + tmpItemIndex
				if @container.size-1 >= tmpTranslatedItemNum
					last_index = @real_index
					if @real_index != tmpTranslatedItemNum
						@display_index = tmpItemIndex
						@real_index = tmpTranslatedItemNum
						if last_index != @real_index || firstClickBlock #第一次進來要刷新
							SndLib.play_cursor if !sound_played
							sound_played = true
							refresh_info
						end
					else
						process_item_confirm if !firstClickBlock
					end
				end
			end
			#p "@mouse_content_dy_rec #{@mouse_content_dy_rec}"  #################### delete if usless
			#p "@contents[@category_index].y/26 #{(@contents[@category_index].y/26).abs}" #usless. its sprite
			#p "((@container.size+1)/2 - 6)   #{((@container.size+1)/2 - 6)}"
			#p "@content_dy #{@content_dy}"
			#p [@real_index, (@real_index.even?? 10 : 11)].min
			#p [-26*((@container.size+1)/2 - 6), 0].min
			#tmpTranslatedItemNum = (@contents[@category_index].y/26).abs*2 + tmpItemIndex
			#
			#p "tmpTranslatedItemNum #{tmpTranslatedItemNum}"
			#p "tmpItemIndex #{tmpItemIndex}"
			#p "@container.size #{@container.size}"
			#p "display_index #{@display_index}"
			#p "real_index #{@real_index}"
		end
	end
	
	def mouse_force_main_menu_pause
		@phase == 4
	end
	def mouse_update_confirm_window
		item_use_confirm_scr_use if Input.trigger?(:MZ_LINK)
		item_use_confirm_scr_dorp if Input.trigger?(:MM_LINK)
		item_use_confirm_scr_cancel if Input.trigger?(:MX_LINK)
	end
	def mouse_press_cancel
		return if @phase <= 1
		@phase -= 1
		SndLib.sys_cancel
		@menu.activate if @phase == 1
		@confirm_back.visible = @confirm_layer.visible = false if @phase == 3
	end
	
	def update_input
		if @phase == 2
			if Input.repeat?(:RIGHT) || Input.repeat?(:LEFT)
				SndLib.play_cursor
				@category_index = (@category_index+1)%4 if Input.repeat?(:RIGHT)
				@category_index = (@category_index-1)%4 if Input.repeat?(:LEFT)
				move_cursor
				refresh_category
			end
			if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK)
				SndLib.sys_cancel
				show
				@menu.activate
			end
			if Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)
				SndLib.sys_ok
				@phase = 3
				@item_info.visible = true
				refresh_info
			end
		elsif @phase == 3
			if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK)
				SndLib.sys_cancel
				@phase = 2
				@item_info.visible = false
			end
			if Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)
				process_item_confirm
			end
			last_index = @real_index
			if Input.repeat?(:UP) || Input.repeat?(:L)
				Input.repeat?(:L) ? tmpPower = 3 : tmpPower = 1
				tmpPower.times{
					if @real_index < 2 # jump to bottom
						if Input.trigger?(:UP)
							if @container.size.even?
								@real_index = (@real_index - 2) % @container.size if @container.size > 0
								@display_index = @real_index
								@display_index = @real_index.even?? 10 : 11 if @display_index > 11
							else
								@real_index = @container.size - 1
								@display_index = [@real_index, 10].min
							end
							@content_dy -= 26 * ((@container.size+1)/2 - 6) if @container.size > 12
						end
					else # cursor up
						@real_index -= 2
						if @display_index >= 2
							@display_index -= 2
						else
							@content_dy += 26
						end
					end
				}
			end #Input.repeat?(:UP)
			if Input.repeat?(:DOWN) || Input.repeat?(:R)
				Input.repeat?(:R) ? tmpPower = 3 : tmpPower = 1
				tmpPower.times{
					if @real_index + 2 > @container.size - 1 # jump to top
						if @real_index.even? && Input.trigger?(:DOWN)
							@real_index = @display_index = 0
							@content_dy += 26 * ((@container.size+1)/2 - 6) if @container.size > 12
						else
							if @real_index + 1 < @container.size && @real_index.odd?
								@real_index += 1
								@content_dy -= 26 if @display_index == 11
								@display_index = [@real_index, 10].min
							elsif Input.trigger?(:DOWN)
								@real_index = @display_index = 1
								@content_dy += 26 * ((@container.size+1)/2 - 6) if @container.size > 12
							end
						end
					else # cursor down
						tmpPower = 2 if Input.repeat?(:R)
						@real_index += 2
						if @display_index > 9
							@content_dy -= 26
						end
						@display_index = @display_index + 2 if @display_index < 10
					end
				}
			end # Input.repeat?(:DOWN)
			if Input.repeat?(:RIGHT) || Input.repeat?(:LEFT)
				if @real_index.even? && @real_index + 1 < @container.size
					@real_index += 1
					@display_index += 1
				elsif @real_index.odd?
					@real_index -= 1
					@display_index -= 1
				end
			end
			if last_index != @real_index
				SndLib.play_cursor
				refresh_info
			end
		elsif @phase == 4
			item_use_confirm_scr_use if Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)
			item_use_confirm_scr_dorp if Input.trigger?(:UI_DeleteItem)
			item_use_confirm_scr_cancel if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK)
		end# end of all @phase and #@phase == 4
	end #def
	
	def item_use_confirm_scr_use
		process_item_use
	end
	def item_use_confirm_scr_dorp
		SndLib.sound_equip_armor(80)
		process_item_drop
	end
	def item_use_confirm_scr_cancel
		SndLib.sys_cancel
		@phase = 3
		@confirm_back.visible = @confirm_layer.visible = false
	end

	def process_item_drop
		item = @container[@real_index]
		return SndLib.sys_buzzer if item.key_item?
		#if hc> 1 && BB && Human && player BB
		if Input.press?(:SHIFT)
			tmpCount = [5,$game_party.item_number(item)].min
			$game_party.lose_item(item,$game_party.item_number(item))
			tmpCount.times{$game_temp.register_item_drop([item.item_name])}
		else
			$game_party.lose_item(item,1)
			$game_temp.register_item_drop([item.item_name])
		end
		set_container
		post_consumtion
		@gauge.refresh
		@menu_pages[0].refresh #main_stats
		@menu_pages[1].refresh #health_states
		refresh_info	  
		@phase = 3
		@confirm_back.visible = @confirm_layer.visible = false
	end
  
	def refresh_info
		@item_info.bitmap.clear
		item = @container[@real_index]
		return if item.nil?
		@item_info.bitmap.font.size=16
		@item_info.bitmap.font.outline=false
		draw_text_on_canvas(@item_info,7,6,$game_text[item.description])
	end
  
	def new_line_x
		7
	end
  
	def check_equip_effect_color(line)
		code = line.match(/\<([^\)]+)\>/i)
		if code.nil?
			#@item_info.bitmap.sfont_color = :green
			return line
		else
			#@item_info.bitmap.sfont_color = code[1].to_sym
			return line[code[1].size+2 .. -1]
		end
	end

	def update_arrow
		@arrow_up.visible = @real_index - @display_index > 0 && @phase > 1
		@arrow_down.visible =
		@real_index + 12 - @display_index < @container.size && @phase > 1
		d = Graphics.frame_count%92/23
		if @arrow_up.visible
			@arrow_up.y = 63 - d*2
			@arrow_up.y = 61 if d == 3
		end
		if @arrow_down.visible
			@arrow_down.y = 238 + d*2
			@arrow_down.y = 240 if d == 3
		end
	end

	def move_cursor
		if @phase == 2
			spr = @category_sprites[@category_index]
			dx = [0, -10, -1, -13].at(@category_index)
			@cursor.to_xy(spr.x + dx, spr.y + 8)
		end
	end

	def refresh_category(reset=true)
		@category_sprites.each_with_index do |spr, index|
			spr.opacity = (index == @category_index && @phase != 1) ? 255 : 128
			@contents[index].visible = index == @category_index
		end
		reset_content_position if reset
		refresh_contents
		set_container
	end
  
	def set_container
		case @category_index
			when 0; @container = item_foods
			when 1; @container = item_medicine
			when 2; @container = item_equips
			when 3; @container = item_other
		end
	end


	def item_foods
		$game_party.items.select{|item| (item.type.eql?("Food") || item.type.eql?("FoodBad") || item.type.eql?("FoodSemen")) && !item.type_tag.eql?("trait")}
	end

	def item_medicine
		$game_party.items.select{|item| item.type.eql?("Medicine") && !item.type_tag.eql?("trait")}
	end

	def item_equips
		$game_party.equip_items
	end

	def item_other
		$game_party.items.select{|item| !item.type.eql?("FoodSemen") && !item.type.eql?("FoodBad") && !item.type.eql?("Food") && !item.type.eql?("Medicine") && !item.type_tag.eql?("trait")}
	end

	def reset_content_position
		@display_index = 0
		@real_index = 0
		@contents.each{|spr|spr.y = 0}
		@content_dy = 0
	end

	def refresh_contents(id = nil)
		idx = id.nil? ? @category_index : id
		sprite = @contents[idx]

		case idx
		when 0; category = item_foods
		when 1; category = item_medicine
		when 2; category = item_equips
		when 3; category = item_other
		else category = []
		end

		# prepare mouse rects only for visible category
		@mouse_items_rect = [] if idx == @category_index

		# ensure the sprite bitmap matches the number of rows required
		rows = (category.size + 1) / 2
		height = [1, 26 * rows].max
		sprite.bitmap.dispose if sprite.bitmap
		sprite.bitmap = Bitmap.new(@list_viewport.rect.width, height)
		sprite.bitmap.clear

		# nothing to draw
		return if category.empty?

		for i in 0...category.length
			item = category[i]
			# color by type (same as original)
			case item.type
			when "Food"; sprite.bitmap.font.color = Color.new(20,255,20)
			when "Medicine"; sprite.bitmap.font.color = Color.new(0,255,255)
			when "Weapon","Armor"; sprite.bitmap.font.color = Color.new(120,120,255)
			else sprite.bitmap.font.color = Color.new(255,255,0)
			end

			row = i / 2
			column = i % 2
			x = 25 + 211 * column
			y = 26 * row

			# only build mouse rects for the visible category (important)
			if idx == @category_index
				@mouse_items_rect << [x + 180, y + 78, @select_block1.width, @select_block1.height]
			end

			sprite.bitmap.font.outline = false
			sprite.bitmap.font.size = 16
			sprite.bitmap.draw_text(x + 29, y - 3, 192, 20, $game_text[category[i].name])
			sprite.bitmap.font.size = 12

			if item.icon_index.is_a?(String)
				rect = Rect.new(0, 0, 24, 24)
				sprite.bitmap.blt(x, y, Cache.normal_bitmap(item.icon_index), rect, @actor.usable?(item) ? 255 : 192)
			else
				rect = Rect.new(item.icon_index % 16 * 24, item.icon_index / 16 * 24, 24, 24)
				sprite.bitmap.blt(x, y, Cache.system("Iconset"), rect, @actor.usable?(item) ? 255 : 192)
			end

			sprite.bitmap.draw_text(x, y + 12, 130, 13, "WT : #{item.weight}", 2)
			sprite.bitmap.draw_text(x, y + 12, 180, 13, "NUM : #{$game_party.item_number(item)}", 2)
		end
	end


	def draw_icon(bmp, x, y, index, enabled = true)
		if index.is_a?(String)
			rect = Rect.new(0, 0, 24, 24)
			bmp.blt(x, y, Cache.normal_bitmap(index), rect, enabled ? 255 : 192)
		else
			rect = Rect.new((index % 16 * 24), (index / 16 * 24), 24, 24)
			bmp.blt(x, y, Cache.system("Iconset"), rect, enabled ? 255 : 192)
		end
	end
  #def draw_icon(bmp, x, y, index, enabled = true)
  #  rect = Rect.new(index % 16 * 24, index / 16 * 24, 24, 24)
  #  bmp.blt(x, y, Cache.system("Iconset"), rect, enabled ? 255 : 192)
  #end
  
	def draw_name(bmp, x, y, name, enabled = true)
		#bmp.sfont_alpha = enabled ? 255 : 192
		bmp.draw_text(x, y , 200, 13, name)
	end
  
	def draw_stack(bmp, x, y, number)
		#bmp.sfont_size = 0
		#bmp.sfont_alpha = 255
		bmp.draw_text(x, y , 150, 13, "stack : #{number}", 2)
		#bmp.sfont_size = 1
	end
  
	def update_select
		if @phase != 3
			@select_block1.visible = @select_block2.visible = false
			return
		end
		@select_block1.visible = @select_block2.visible = true
		#@select_block1.x = @select_block2.x = 201 + 212 * (@display_index % 2)
		@select_block1.x = @select_block2.x = 179 + 212 * (@display_index % 2)
		@select_block1.y = @select_block2.y = 77 + 26 * (@display_index/2)
		r = Graphics.frame_count % 90
		d = 127 * (r%45) / 44
		@select_block2.opacity = 128 + (r > 44 ? d : 63 - d)
	end
  
	def update_content_scroll
		return unless @phase == 3
		content = @contents[@category_index]
		v = @content_dy.abs > 52 ? 30 : 5
		v = @content_dy.abs < v ? @content_dy : (@content_dy > 0 ? v : -v)
		content.y += v
		@content_dy -= v
	end
  
	def process_item_confirm
		item = @container[@real_index]
		if item.nil? #|| !@actor.usable?(item)
			SndLib.sys_buzzer 
			return
		end
		SndLib.sys_ok
		bmp = @confirm_layer.bitmap
		rect = Rect.new(170, 122, 300, 65)
		bmp.clear_rect(rect)
		draw_icon(bmp, 311, 122, item.icon_index)
		bmp.font.size=24
		bmp.draw_text(225, 149, 192, 25, $game_text[item.name], 1)
		@confirm_back.visible = @confirm_layer.visible = true
		@phase = 4
	end
  
	def process_item_use
		item = @container[@real_index]
		return SndLib.sys_buzzer if !@actor.usable?(item)
		return SndLib.sys_buzzer if item.player_item_usage_event_summon && $game_map.isOverMap
		@phase = 3
		@confirm_back.visible = @confirm_layer.visible = false
		if Input.press?(:SHIFT)
			tmpTimes = $game_party.item_number(item)
		else
			tmpTimes = 1
		end
		tmpTimes.times{
			@actor.itemUseBatch(item)
		}
		@actor.refresh
		@actor.update_state_frames
		check_common_event
		SndLib.sys_UseItem
		set_container
		post_consumtion
		@gauge.refresh
		@menu_pages[0].refresh #main_stats
		@menu_pages[1].refresh #health_states
		refresh_info
	end 
  #drop或使用物品後重設游標
	def post_consumtion
		# refresh both 'all' and current category so the bitmaps match the data
		if @category_index == 3
			refresh_contents(3)
		else
			refresh_contents(3)
			refresh_contents(@category_index)
		end

		# If container became empty, bounce back to category select
		set_container if @container.nil?
		if @container.nil? || @container.size == 0
			@phase = 2
			@item_info.visible = false
			reset_content_position
			return
		end

		# If current real index is out of range after consumption, snap to last item
		if @real_index > @container.size - 1
			@real_index = @container.size - 1
			@display_index = [@real_index, (@real_index.even? ? 10 : 11)].min
			rows = (@container.size + 1) / 2
			@contents[@category_index].y = [-26 * (rows - 6), 0].min
			@content_dy = 0
		else
			# old logic: if scrolling is mismatched, correct it
			if @contents[@category_index].y + @content_dy < 0 && @real_index + 11 - @display_index > @container.size
				@real_index -= 2
				@content_dy += 26
			end
		end
	end


  
  def check_common_event
    SceneManager.goto(Scene_Map) if $game_temp.common_event_reserved?
  end
  
  def check_gameover
    SceneManager.goto(Scene_Gameover) if $game_party.all_dead?
  end
  
	def show
		super
		@phase = 1
		@menu_pages=SceneManager.scene.contents.contents if @menu_pages.nil?
		@list_viewport.visible = true
		refresh_category(reset=false)
		move_cursor
	end

	def hide
		super
		@list_viewport.visible = false
	end
  
  def dispose
	@back.dispose #use cached bitmap
    @category_sprites.each do |spr|
      spr.bitmap.dispose
      spr.dispose
    end
    @contents.each do |spr|
      spr.bitmap.dispose if spr.bitmap
      spr.dispose
    end
	@select_block1.dispose #use chached bitmap
	@select_block2.dispose #use chached bitmap
	@item_info.bitmap.dispose
	@item_info.dispose
	@arrow_up.bitmap.dispose
	@arrow_up.dispose
	@arrow_down.bitmap.dispose
	@arrow_down.dispose
	@confirm_back.dispose
	@confirm_layer.bitmap.dispose
	@confirm_layer.dispose
	
    @list_viewport.dispose
	super
  end
  
end
