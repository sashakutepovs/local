#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
#==============================================================================
# ** Menu_Equips
# Require Yanfly's equip engine script. 
# Grabs SLOT setting from $data_system.equip_type
# @phase definition
#   1 : not doing anything simply show
#	2 : entered page, cursor at right panel, show all item , can press triggeer?(:C) to equip anything
#	3 : @active_slot has not been set yet, selecting slot you want to change equip(setting @active_slot)
#	4 : @active_slot has been set. but cursor is still on the left panel, can trigger?(:B) to cancel @active_slot or trigger?(:C) to change @active_slot
#	5 : @active_slot has been set, cursor at right panel ,selecting the equip you want ot stuff into
#
#==============================================================================



class Menu_Equips < Menu_ContentBase
	SEAL_ICON_ID = 580
	FIXED_ICON_ID = 717
	SLOT_SPRITE = "07equip/equip_slot" #so u can easily hack

	def initialize
		super()
		@phase = 1 #1:show, 2:list all, 3:hover slot, 4:select slot 5:slot equips
		@menu=SceneManager.scene.menu
		@back = Sprite.new(@viewport)
		@back.bitmap = Cache.load_bitmap(ROOT,"07equip/equip_layout")
		@body = Sprite.new(@viewport)
		@body.bitmap = Cache.load_bitmap(ROOT,"07equip/body")
		@body.x = (Graphics.width * 0.261).to_i #167
		@body.y = (Graphics.height * 0.1056).to_i #38
		@body.z = 10+System_Settings::SCENE_Menu_Contents_Z
		
		@slot_sprite = Sprite.new(@viewport)
		@slot_sprite.bitmap = Cache.load_bitmap(ROOT,SLOT_SPRITE)
		@slot_sprite.x = (Graphics.width * 0.261).to_i #167
		@slot_sprite.y = (Graphics.height * 0.0667).to_i #24
		@slot_sprite.z = 20+System_Settings::SCENE_Menu_Contents_Z
		
		@slot_content = Sprite.new(@viewport) # sprite used for drawing equip icons on slots and quick stats	
		@slot_content.bitmap = Bitmap.new(144, 314)
		@slot_content.x = (Graphics.width * 0.24375).to_i #156
		@slot_content.y = (Graphics.height * 0.0667).to_i #24
		@slot_content.z = 30+System_Settings::SCENE_Menu_Contents_Z
		draw_stats_info
		refresh_stats_value
		
		@slot_cursor1 = Sprite.new(@viewport)
		@slot_cursor1.bitmap = Cache.load_bitmap(ROOT,"07equip/select_box")
		@slot_cursor2 = Sprite.new(@viewport)
		@slot_cursor2.bitmap = @slot_cursor1.bitmap
		@slot_cursor2.src_rect.x = 34
		@slot_cursor1.src_rect.width = @slot_cursor2.src_rect.width = 34
		@slot_cursor1.z = @slot_cursor2.z = 30+System_Settings::SCENE_Menu_Contents_Z
		@slot_cursor1.visible = @slot_cursor2.visible = false
			#TopExtra								#Hair									#equip_head(acc1)
			#Top									#Mid									#equip_neck(acc2)
			#Mhand									#MidExtra								#Shand
			#vag									#Bot									#Anal
			#ext item 1			2					3					4					#ext item 5
		@slot_position = {
			#menuEqpID => [x , y]
			17 => [ 18,6],						18 => [ 60, 6],						19 => [103,  6],
			0 => [ 18, 38],						4 => [ 60, 36],						8 => [103,  38],
			1 => [ 13, 70],						5 => [ 60, 75],						9 => [107,  70],
			2 => [ 12, 109],					6 => [ 60, 113],					10 => [108, 109],
			3 => [ 17, 144],					7 => [ 60, 148],					11 => [103, 144],
			12 => [ 12,178],	13 =>[36, 179],	14 => [ 60, 178],	15=>[84,179],	16 => [108, 178]

		}
		@ext_PosList = [12,13,14,15,16]
		@ext_YeaList = [9,10,11,12,13]
		@edgeSlotL = [0,1,2,3,17]
		@edgeSlotR = [8,9,10,11,19]
		@mouse_EquipSlot_rect = []
		@slot_position.each{|tmpSlot|
			@mouse_EquipSlot_rect << [tmpSlot[0],[tmpSlot[1][0]+@slot_content.x,tmpSlot[1][1]+@slot_content.y,26,26]]
		}
		#translate @slot_index to slot_index of 50_System_Settings
		#cuprum lets make @slot_etype a graph, then @slot_index and etype_id can translate each other, so @prev_slot_index can be removed by translating @active_slot to @slot_index
		#example: @slot_index = @slot_etype[@active_slot][1]; @active_slot = @slot_etype[@slot_index][0]
		@slot_etype = {
			#@slot_position => [System_Settings::EQUIP , ?]
			17 => [17],						18 =>[18],						19 =>[19],
			0 => [5],						4 =>[7],						8 =>[8],
			1 => [2],						5 =>[3],						9 =>[14],
			2 => [0],						6 =>[6],						10 =>[1],
			3 => [15],						7 =>[4],						11 =>[16],
			12 => [9],		13 =>[10],		14=>[11], 		15 =>[12],		16=>[13]
		}

		@slot_links = {
		# slot => [down,left,right,up]						[down,left,right,up]							[down,left,right,up]
		17 => [ 0, 17, 18, 12],								18 => [ 4, 17, 19, 14],							19 =>  [8, 18, 17, 16],
		0 =>  [ 1,  0, 4, 17],								4 =>  [ 5,  0,  8, 18],							8 =>  [ 9,  4, 0, 19],
		1 =>  [ 2,  1, 5,  0],								5 =>  [ 6,  1,  9, 4],							9 =>  [10,  5, 1,  8],
		2 =>  [ 3,  2, 6,  1],								6 =>  [ 7,  2, 10, 5],							10=>  [11,  6, 2,  9],
		3 =>  [ 12, 3, 7,  2],								7 =>  [ 14, 3, 11, 6],							11=>  [16,  7, 3,  10],
		12 => [ 0,16,13, 3], 	13 => [ 4, 12, 14, 7],		14=>  [ 4, 13, 15, 7],	15 => [ 4, 14, 16, 7],	16 => [ 8,  15,12, 11]
		}
		# item list window


		@content_settingXYWH = [305, 37, 307, 156]
		@content_viewport = Viewport.new(*@content_settingXYWH)
		@content_viewport.z = 100+System_Settings::SCENE_Menu_Contents_Z
		@content = Sprite.new(@content_viewport)
		@content.x = 10
		
		@item_cursor1 = Sprite.new(@viewport)
		@item_cursor1.bitmap = Cache.load_bitmap(ROOT,"07equip/select_block")
		@item_cursor1.src_rect.width = 143
		@item_cursor2 = Sprite.new(@viewport)
		@item_cursor2.bitmap = Cache.load_bitmap(ROOT,"07equip/select_block")
		@item_cursor2.src_rect.x = 143
		@item_cursor2.src_rect.width = 144
		@item_cursor1.z = @item_cursor2.z = 20+System_Settings::SCENE_Menu_Contents_Z
		@item_cursor1.visible = @item_cursor2.visible = false
		
		@item_info = Sprite.new(@viewport)
		@item_info.bitmap = Bitmap.new(307,121)
		@item_info.x, @item_info.y = 305, 217
		
		bmp = Cache.load_bitmap(ROOT,"08Items/item_arrow")
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
		#bmp.dispose
		@arrow_up.x, @arrow_up.y, @arrow_up.z = 342, 17, 100+System_Settings::SCENE_Menu_Contents_Z
		@arrow_down.x, @arrow_down.y, @arrow_down.z = 342, 199, 100+System_Settings::SCENE_Menu_Contents_Z
		@arrow_up.visible = @arrow_down.visible = false
		
		@blocker_count_bondage = 0
		@blocker_frame = 0
		reset_content_position
		#@prev_active_slot = nil it removed
		@active_slot = nil
		#@prev_slot_index = nil it removed
		@slot_index = nil
		refresh_total_list
		refresh_slot_content
		#refresh_stats
		hide
	end
  
  
  def draw_stats_info
	bmp = @slot_content.bitmap
	bmp.font.size=12
	bmp.font.color=Color.new(20,255,20)
	bmp.font.outline=false
	#bmp.fill_rect(bmp.rect,Color.new(0,255,0))
    base_x, base_y, w, dy = 11, 216, 30, 9
#	draw_text(x, y, width, height, str[, align]) 
	bmp.draw_text(base_x, base_y + dy *			0, w, 10, $game_text["menu:equip/atk"])
    bmp.draw_text(base_x + 31, base_y + dy *	0, w, 10, ':')
	
	bmp.draw_text(base_x, base_y + dy * 		1, w, 10, $game_text["menu:equip/def"])
    bmp.draw_text(base_x + 31, base_y + dy * 	1, w, 10, ':')
	
	bmp.draw_text(base_x, base_y + dy * 		2, w, 10, $game_text["menu:equip/com"])
    bmp.draw_text(base_x + 31, base_y + dy * 	2, w, 10, ':')
	
	bmp.draw_text(base_x, base_y + dy * 		3, w, 10, $game_text["menu:equip/scu"])
    bmp.draw_text(base_x + 31, base_y + dy * 	3, w, 10, ':')
	
	bmp.draw_text(base_x, base_y + dy * 		4, w, 10, $game_text["menu:equip/wis"])
    bmp.draw_text(base_x + 31, base_y + dy * 	4, w, 10, ':')
	
	bmp.draw_text(base_x, base_y + dy * 		5, w, 10, $game_text["menu:equip/con"])
    bmp.draw_text(base_x + 31, base_y + dy * 	5, w, 10, ':')
	
	bmp.draw_text(base_x, base_y + dy * 		6, w, 10, $game_text["menu:equip/sur"])
    bmp.draw_text(base_x + 31, base_y + dy * 	6, w, 10, ':')
		
	bmp.draw_text(base_x, base_y + dy * 		7, w, 10, $game_text["menu:equip/sexy"])
    bmp.draw_text(base_x + 31, base_y + dy * 	7, w, 10, ':')
		
	bmp.draw_text(base_x, base_y + dy * 		8, w, 10, $game_text["menu:equip/weak"])
    bmp.draw_text(base_x + 31, base_y + dy * 	8, w, 10, ':')
		
	bmp.draw_text(base_x, base_y + dy * 		9, w, 10, $game_text["menu:equip/mori"])
    bmp.draw_text(base_x + 31, base_y + dy * 	9, w, 10, ':')
  end
  
	def refresh_stats_value
		bmp = @slot_content.bitmap
		bmp.clear_rect(49, 210, 100, 103)
		bmp.font.size=12
		bmp.font.color=Color.new(20,255,20)
		bmp.font.outline=false
		base_x, base_y, w, dy = 11, 216, 30, 9
		$game_player.actor.portrait.updateExtra()
		tmpLonaY_plus = $chs_data[$game_player.chs_type].cell_y_adjust
		bmp.stretch_blt(Rect.new(46, 178, 128, 128),Cache.chs_character($game_player,true),Rect.new(64,-tmpLonaY_plus,64,64))
		bmp.draw_text(base_x + 40, base_y + dy * 	0, w, 10, @actor.atk.round(2))
		bmp.draw_text(base_x + 40, base_y + dy * 	1, w, 10, @actor.def.round(2))
		bmp.draw_text(base_x + 40, base_y + dy * 	2, w, 10, @actor.combat.round(2))
		bmp.draw_text(base_x + 40, base_y + dy * 	3, w, 10, @actor.scoutcraft.round(2))
		bmp.draw_text(base_x + 40, base_y + dy * 	4, w, 10, @actor.wisdom.round(2))
		bmp.draw_text(base_x + 40, base_y + dy * 	5, w, 10, @actor.constitution.round(2))
		bmp.draw_text(base_x + 40, base_y + dy * 	6, w, 10, @actor.survival.round(2))
		bmp.draw_text(base_x + 40, base_y + dy * 	7, w, 10, @actor.sexy.round)
		bmp.draw_text(base_x + 40, base_y + dy * 	8, w, 10, @actor.weak.round)
		bmp.draw_text(base_x + 40, base_y + dy * 	9, w, 10, @actor.morality.round(2))
	end
  
	def refresh_total_list
		@data = $game_party.equip_items
		refresh_item_list
	end
  
	def refresh_one_slot_list(reset_position = false)
		return unless [3,4,5].include?(@phase)
		slot = @phase == 3 ? @slot_etype[@slot_index][0] : @active_slot
		return if slot.nil?
		if @ext_YeaList.include?(slot)
			@data = $game_party.items.select{|item| !["Key","trait"].include?(item.type)} + $game_party.equip_items
		else
			@data = $game_party.all_items.select {|item|
				#p "asdasdasd #{item.etype_id} #{item.item_name}"
				#p slot
				#p @actor.equip_slots[slot]
				item.etype_id == @actor.equip_slots[slot]
			}
		end
		refresh_item_list
		reset_content_position if reset_position
	end
  
	def refresh_item_list
		@mouse_items_rect = []
		@content.bitmap.dispose if @content.bitmap
		@content.bitmap = Bitmap.new(294, 26*(@data.size+1)/2)
		bmp = @content.bitmap
		ext_mode= @ext_YeaList.include?(@active_slot) || @ext_PosList.include?(@slot_index)
		@data.each_with_index do |item, index|
			x = 147*(index%2)
			y = 26*(index/2)
			@mouse_items_rect << [x+314,y+36,@item_cursor2.src_rect.width,@item_cursor2.src_rect.height] ## start at 180,78
			enable = ext_mode ? true : @actor.equippable?(item)
			bmp.font.size = 16
			bmp.font.outline = false
			bmp.font.color=Color.new(20,255,20, enable ? 255 : 192)
			bmp.draw_text(x+29, y , 200, 18, $game_text[item.name])
			bmp.font.size=12
			slot_no = item.is_a?(RPG::Item) ? "EXT" : $data_system.equip_type[item.etype_id][0]
			bmp.draw_text(x-48, y+14 , 140, 13, "SLOT : #{slot_no}", 2)
			bmp.draw_text(x, y+14 , 140, 13, "NUM : #{$game_party.item_number(item)}", 2)
			draw_icon(bmp, x, y, item.icon_index, enable)
		end
	end
	def refresh_slot_content
		bmp = @slot_content.bitmap
		bmp.clear_rect(0, 0, 145, 210)
		eqps=@actor.equips
		$data_system.equip_type.keys.each.each{|yea_type|
			if @ext_YeaList.include?(yea_type)
				tarSlot = @ext_YeaList.index(yea_type)
				eqp = $data_ItemName[@actor.ext_items[tarSlot]]
			else
				eqp =eqps[yea_type]
			end
			#if yea_type == 9
			#	eqp = $data_ItemName[@actor.ext_items[0]]
			#elsif yea_type == 10
			#	eqp = $data_ItemName[@actor.ext_items[1]]
			#elsif yea_type == 11
			#	eqp = $data_ItemName[@actor.ext_items[2]]
			#elsif yea_type == 12
			#	eqp = $data_ItemName[@actor.ext_items[3]]
			#elsif yea_type == 13
			#	eqp =$data_ItemName[ @actor.ext_items[4]]
			#else
			#	eqp =eqps[yea_type]
			#end
			block_index=get_eqp_block_index(yea_type)
			next draw_icon(bmp,*@slot_position[block_index], SEAL_ICON_ID) if !@ext_YeaList.include?(yea_type) && @actor.equip_slot_sealed?(yea_type)
			next draw_icon(bmp,*@slot_position[block_index], FIXED_ICON_ID) if eqp.nil? && !@ext_YeaList.include?(yea_type) && @actor.equip_slot_fixed?(yea_type)
			next bmp.clear_rect(*@slot_position[block_index], 24,24) if eqp.nil?
			draw_icon(bmp, *@slot_position[block_index], eqp.icon_index)
			draw_icon(bmp,*@slot_position[block_index], FIXED_ICON_ID) if !@ext_YeaList.include?(yea_type) && @actor.equip_slot_fixed?(yea_type)
		}
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
		bmp.draw_text(x, y , 200, 13, name)
	end

	def draw_equip_type(bmp, x, y, item)
		type = $data_system.equip_type[item.etype_id][0]
		bmp.draw_text(x, y , 140, 13, "Slot : #{type}")
	end

	def draw_equip_stack(bmp, x, y, item)
		bmp.draw_text(x, y , 140, 13, "Stack : #{$game_party.item_number(item)}", 2)
	end

	def enter_page
		SndLib.sys_ok
		@phase = 2
		reset_content_position if @equip_number != $game_party.equip_items.size
		@equip_number = nil
		refresh_info
		Input.update
	end
  
	def update
		#p "@phase begin => #{@phase}"
		#p "@real_index => #{@real_index}"
		#p "@active_slot => #{@active_slot}"
		#p "@slot_index = > #{@slot_index}"
		return if !@viewport.visible
		mouse_update_input
		return unless @phase > 1
		update_input
		update_cursor
		update_content_scroll
		update_arrow
	end
	def update_input
		case @phase
			when 2, 5; input_item_list
			when 3, 4; input_equip_slot
		end
	end
	
	def mouse_update_input
		#p @phase #2=item. 3=slots 4=active a slot 5=active a slow. and in item area
		return Mouse.ForceIdle if Input.MouseWheelForceIdle?
		return if !Mouse.enable?
		return mouse_press_cancel if Input.trigger?(:MX_LINK) && @phase >= 2
		tmpWithInMainMenuArea = Mouse.within_XYWH?(0, 0, 156, 360)
		tmpWithInItemArea = Mouse.within_XYWH?(@content_settingXYWH[0],@content_settingXYWH[1],307,181)
		tmpPressed_MZ_LINK = Input.trigger?(:MZ_LINK)
		#Check equip slots click area
		tmpEquipSlotIndex = nil
		@mouse_EquipSlot_rect.length.times {|i|
			spr = @menu.menu_sprites[i]
			next unless Mouse.within_XYWH?(*@mouse_EquipSlot_rect[i][1])
			tmpEquipSlotIndex = @mouse_EquipSlot_rect[i][0]
		}
		sound_played = false
		#back to main menu
		return unless tmpPressed_MZ_LINK || ((Input.trigger?(:L) || Input.trigger?(:R)) && tmpWithInItemArea)
		firstClickBlock = true if @phase == 1
		if !tmpWithInMainMenuArea && (tmpEquipSlotIndex || tmpWithInItemArea) && @phase == 1
			enter_page
			sound_played = true
		end
		#Check equip slots clicks
		if tmpEquipSlotIndex
			refresh_flag = true
			if @phase == 3 && (@slot_index == tmpEquipSlotIndex || @ext_PosList.include?(@slot_index) && @ext_PosList.include?(tmpEquipSlotIndex))
				refresh_flag = false
			elsif @phase == 5 && (@slot_etype[@active_slot][1] == tmpEquipSlotIndex || @ext_YeaList.include?(@active_slot) && @ext_PosList.include?(tmpEquipSlotIndex))
				refresh_flag = false
			end
			firstClickBlock = true if @phase != 4
			if firstClickBlock
				@phase = 3
				set_slot_cursor_position(force = false, tmpEquipSlotIndex)
				@active_slot = nil
				refresh_one_slot_list(true) if refresh_flag
			else
				set_slot_cursor_position(force = false, tmpEquipSlotIndex)
			end
			refresh_info
			input_equip_slot_confirm(playSound= !sound_played)
			sound_played = true
			return
		
		#clicked item area
		elsif tmpWithInItemArea
			if ![2,5].include?(@phase)
				firstClickBlock = true
				SndLib.sys_ok if !sound_played
				sound_played = true
				@active_slot = @slot_etype[@slot_index][0] if @phase == 3
				@phase = 5
				Input.update
				@slot_index = nil
				@item_info.visible = true
				refresh_info
			end
			tmpItemIndex = nil
			@mouse_items_rect.length.times {|i|
				spr = @menu.menu_sprites[i]
				next unless Mouse.within_XYWH?(*@mouse_items_rect[i])
				tmpItemIndex = i
			}
			return if tmpItemIndex && tmpItemIndex >= 12 #if clicked something beyond item list window max(11), do nothing
			if tmpItemIndex && tmpPressed_MZ_LINK
				tmpTranslatedItemNum = ((@content.y + @content_dy).abs / 26).to_i * 2 + tmpItemIndex #translate sprite mouseclicked Y ,and translate to item list index
				if @data.size-1 >= tmpTranslatedItemNum
					last_index = @real_index
					if @real_index != tmpTranslatedItemNum
						@display_index = tmpItemIndex
						@real_index = tmpTranslatedItemNum
						#first update when into click within in item_menu
						SndLib.play_cursor if !sound_played
						sound_played = true
						refresh_info
					else
						process_list_equip if !firstClickBlock
					end
				end
			end #tmpItemIndex && tmpPressed_MZ_LINK
		end
		#
		#p @phase #2=item. 3=slots 4=active a slot 5=active a slow. and in item area
		#p "@slot_index #{@slot_index}"
		#p "@active_slot #{@active_slot}"
		#p "tmpEquipSlotIndex #{tmpEquipSlotIndex}"
	end
	
	def mouse_press_cancel
		return if @phase <=1
		#show
		SndLib.play_cursor
		@active_slot = nil
		@slot_index = nil
		if @phase == 2
			@equip_number = $game_party.equip_items.size
		else 
			reset_content_position
			refresh_total_list
		end
		@phase = 1
		refresh_info
		refresh_slot_content
		update_cursor
		update_arrow
		@menu.activate
	end
	
	# in item list
	def input_item_list
		if @blocker_count_bondage >= 1
			@blocker_frame += 1
			if @blocker_frame >= 60
				@blocker_frame = 0
				@blocker_count_bondage = 0
				@blocker_item = nil
			end
		end
		if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK)
			SndLib.sys_cancel
			if @phase == 2
				@active_slot = nil
				@slot_index = nil
				@equip_number = $game_party.equip_items.size
				show
				@menu.activate
			else
				@phase = 3
				##cuprum tried to remove @prev_slot_index and @prev_active_slot so it wont be too chaotic
				set_slot_cursor_position(force = false, @slot_etype[@active_slot][1])
				@active_slot = nil
				refresh_info
			end
			return
		end
		if Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)
			process_list_equip
		end
		#cuprum when moving  just keep @slot_index nil if phase still 2 or 5
		#down => left => right => up
		#used for checking if cursor is changed
		last_status = [@real_index, @phase]
		if Input.repeat?(:DOWN) || Input.repeat?(:R)
			Input.repeat?(:R) ? tmpPower = 3 : tmpPower = 1
			tmpPower.times{
				if @real_index + 2 > @data.size - 1 # jump to top          
					if @real_index.even? && Input.trigger?(:DOWN)
						@real_index = @display_index = 0
						@content_dy += 26 * ((@data.size+1)/2 - 6) if @data.size > 12
					else
						if @real_index + 1 < @data.size && @real_index.odd?
							@real_index += 1
							@content_dy -= 26 if @display_index == 11
							@display_index = [@real_index, 10].min
						elsif Input.trigger?(:DOWN)
							@real_index = @display_index = 1
							@content_dy += 26 * ((@data.size+1)/2 - 6) if @data.size > 12
						end
					end
				else # cursor down
					@real_index += 2
					if @display_index > 9
						@content_dy -= 26
					end
					@display_index = @display_index + 2 if @display_index < 10
				end
			}
			SndLib.play_cursor
		end # Input.repeat?(:DOWN)
		if Input.repeat?(:LEFT)
			#msgbox "@slot_index ====== #{@slot_index}"
			if @display_index.even? # return to equip slot window, because 0,2 4,6 8,10 slots is beside equip window
				forced_slot_index = nil
				case @display_index
					when 0,2	;forced_slot_index =  @edgeSlotR[0]
					when 4,6	;forced_slot_index =  @edgeSlotR[1]
					when 8		;forced_slot_index =  @edgeSlotR[2]
					when 10		;forced_slot_index =  @edgeSlotR[3]
					else		;forced_slot_index =  @edgeSlotR[4]
				end
				@phase = @phase == 2 ? 3 : 4
				set_slot_cursor_position(force = false, forced_slot_index)
				refresh_one_slot_list(true) if @phase == 3
			else
				@display_index -= 1
				@real_index -= 1
			end
			SndLib.play_cursor
			#msgbox "@slot_index ====== #{@slot_index}"
			#msgbox "@display_index ====== #{@display_index}"
			#return SndLib.play_cursor if last_status != [@real_index, @phase] if forced_slot_index
		end
		if Input.repeat?(:RIGHT)
			if @phase == 2 || @phase == 5
				if @display_index.odd?
					forced_slot_index = nil
					case @display_index
						when 1,3	;forced_slot_index = @edgeSlotL[0]
						when 5,7	;forced_slot_index = @edgeSlotL[1]
						when 9		;forced_slot_index = @edgeSlotL[2]
						when 11		;forced_slot_index = @edgeSlotL[3]
						else		;forced_slot_index = @edgeSlotL[4]
					end
					@phase = @phase == 2 ? 3 : 4
					set_slot_cursor_position(force = false, forced_slot_index)
					refresh_one_slot_list(true) if @phase == 3
				elsif @real_index + 1 < @data.size
					@display_index += 1
					@real_index += 1
				elsif @real_index > 1
					@real_index -= 1
					@display_index -= 1
				elsif @phase == 2
					@phase = 3
					set_slot_cursor_position(force = false, 0)
					refresh_one_slot_list(true)
				else
					@phase = 4
					set_slot_cursor_position(force = false, @slot_etype[@active_slot][1])
				end
			end
			SndLib.play_cursor
		end
		if Input.repeat?(:UP) || Input.repeat?(:L)
			if @phase == 2 || @phase == 5
				Input.repeat?(:L) ? tmpPower = 3 : tmpPower = 1
				tmpPower.times{
					if @real_index < 2 # jump to bottom
						if Input.trigger?(:UP) && @data.size > 0
							if @data.size.even?
								@real_index = (@real_index - 2) % @data.size
								@display_index = @real_index
								@display_index = @real_index.even?? 10 : 11 if @display_index > 11
							else
								@real_index = @data.size - 1
								@display_index = [@real_index, 10].min
							end
							@content_dy -= 26 * ((@data.size+1)/2 - 6) if @data.size > 12
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
			end
			SndLib.play_cursor
		end #Input.repeat?(:UP)
		refresh_info if last_status != [@real_index, @phase]
	end

	#equip slots
	def input_equip_slot
		#slot_connect= @slot_links
		if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK)
			if @phase == 3
				@active_slot = nil
				@slot_index = nil
				reset_content_position
				SndLib.sys_cancel
				show
				@menu.activate
				return
			else
				SndLib.sys_cancel
				# cuprum phase 4 to 3 needs reset_content_position but not always
				@phase = 3
				if !(@ext_YeaList.include?(@active_slot) && @ext_YeaList.include?(@slot_etype[@slot_index][0])) && @active_slot != @slot_etype[@slot_index][0]
					@active_slot = nil
					refresh_one_slot_list(true) 
				else
					@active_slot = nil 
				end
				set_slot_cursor_position
			end
		elsif Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)
			input_equip_slot_confirm
		end
		
		[:DOWN, :LEFT, :RIGHT, :UP].each_with_index do |sym, index|
			next unless Input.repeat?(sym)
			SndLib.play_cursor
			if @edgeSlotL.include?(@slot_index) && index == 1 #LEFT SIDE IS 0 1 2 3
				@phase = @phase == 3 ? 2 : 5
				tar_index = @slot_links[@slot_index][1]
				@slot_index = nil # cuprum if phase to 2 or 5  keep @slot_index at nil
				if @phase == 2
					@data = $game_party.equip_items
					reset_content_scroll# cuprum content.y and dy need reset
				end
				tar_index = @data.size - 1 if tar_index >= @data.size && @data.size <= 12
				tar_index = 0 if tar_index < 0
				@display_index = tar_index
				@real_index = ((@content.y + @content_dy).abs / 26).to_i * 2 + tar_index
				refresh_total_list if @phase == 2
				refresh_info
				break
			end
			if @edgeSlotR.include?(@slot_index) && index == 2 #RIGHT SIDE IS７　８　９　１２
				@phase = @phase == 3 ? 2 : 5
				tar_index = @slot_links[@slot_index][2]
				@slot_index = nil
				if @phase == 2
					@data = $game_party.equip_items
					reset_content_scroll
				end
				if tar_index >= @data.size && @data.size <= 12
					tar_index = @data.size - 1
					tar_index -= 1 if tar_index.odd?
				end
				tar_index = 0 if tar_index < 0
				@display_index = tar_index
				@real_index = ((@content.y + @content_dy).abs / 26).to_i * 2 + tar_index
				refresh_total_list if @phase == 2
				refresh_info
				break
			end
			set_slot_cursor_position(force = false, @slot_links[@slot_index][index])
			refresh_info
			refresh_one_slot_list(true) if @phase == 3 && !(@ext_PosList.include?(@slot_index) && (index == 1 || index == 2))# cuprum reduce lag when moving in ext slots during phase 3
		end #do
	#@active_slot=0
	end #input_equip_slot

	def input_equip_slot_confirm(playSound= true)
		#p "equp input data b4 @active_slot =>#{@active_slot } @slot_index =>#{@slot_index }"
		if @phase == 3
			SndLib.sys_ok if playSound
			@phase = 4
			@active_slot = @slot_etype[@slot_index][0]
		elsif @phase == 4
			if @ext_YeaList.include?(@active_slot) && @ext_YeaList.include?(@slot_etype[@slot_index][0]) && @active_slot == @slot_etype[@slot_index][0]
				tarSlot = @ext_YeaList.index(@active_slot)
				@actor.ext_items[tarSlot] = nil
				refresh_slot_content
				refresh_info
				SndLib.sys_ok if playSound
			elsif @active_slot == @slot_etype[@slot_index][0]
				if @actor.equip_change_ok?(@slot_etype[@slot_index][0])
					remove_equip
					refresh_slot_content
					refresh_one_slot_list
				else
					SndLib.sys_buzzer
				end
			else
				if !(@ext_YeaList.include?(@active_slot) && @ext_YeaList.include?(@slot_etype[@slot_index][0])) #cuprum void unnecessary reset in phase 4
					@active_slot = @slot_etype[@slot_index][0]
					refresh_one_slot_list(true)
				else
					@active_slot = @slot_etype[@slot_index][0]
				end
				SndLib.sys_ok if playSound
				set_slot_cursor_position(true)
			end
		end			  
	end
	def set_slot_cursor_position(force = false, forced_slot_index = nil)
		@slot_index = 0 if @slot_index.nil?
		@slot_index = @slot_position.size-1 if @slot_index > @slot_position.size-1 #protect when @slot_index > @slot_position.size
		@slot_index = forced_slot_index if forced_slot_index
		@slot_cursor1.x = @slot_position[@slot_index][0] + 151
		@slot_cursor2.x = @slot_cursor1.x if ![4,5].include?(@phase) || force
		@slot_cursor1.y = @slot_position[@slot_index][1] + 19
		@slot_cursor2.y = @slot_cursor1.y if ![4,5].include?(@phase) || force
	end

	def update_cursor
		case @phase
			when 1
				@item_cursor1.visible = @item_cursor2.visible = false
				@slot_cursor1.visible = @slot_cursor2.visible = false
			when 2, 5 # item list cursor
				@item_cursor1.visible = @item_cursor2.visible = true
				@item_cursor1.x = @item_cursor2.x = 313 + 147 * (@display_index%2)
				@item_cursor1.y = @item_cursor2.y = 35 + 26 * (@display_index/2)
				r = Graphics.frame_count % 90
				d = 127 * (r%45) / 44
				@item_cursor2.opacity = 128 + (r > 44 ? d : 63 - d)
				@slot_cursor1.visible = false
				@phase == 2 ? @slot_cursor2.visible = false : @slot_cursor2.opacity = 128
				#@slot_cursor2.visible = false if @phase == 2 cuprum bugfix when phase from 3 to 5
			when 3 # slot hover
				@item_cursor1.visible = @item_cursor2.visible = false
				@slot_cursor2.visible = true
				@slot_cursor1.visible = false
				@slot_cursor2.opacity = 255
			when 4# slot selected
				@item_cursor1.visible = @item_cursor2.visible = false
				@slot_cursor1.visible = @slot_cursor2.visible = true
				#@slot_cursor2.visible = false if @phase == 5
				@slot_cursor2.opacity = 128
		end
	end
  
	def update_content_scroll
		return unless [2,5].include?(@phase)
		v = @content_dy.abs > 52 ? 30 : 5
		v = @content_dy.abs < v ? @content_dy : (@content_dy > 0 ? v : -v)
		@content.y += v
		@content_dy -= v
	end
  
	def reset_content_scroll
		#p "reset_content_scroll"
		@content.y = @content_dy = 0
	end
	
  def update_arrow
    if @phase == 1 || @data.size < 12
      @arrow_up.visible = @arrow_down.visible = false
    else
      @arrow_up.visible = @real_index - @display_index > 0
      @arrow_down.visible = @real_index + 12 - @display_index < @data.size
    end
    d = Graphics.frame_count%92/23
    if @arrow_up.visible
      @arrow_up.y = 17 - d * 2
      @arrow_up.y = 15 if d == 3
    end
    if @arrow_down.visible
      @arrow_down.y = 199 + d * 2 
      @arrow_down.y = 201 if d == 3
    end
  end
  
  def refresh_info
    bmp = @item_info.bitmap
    bmp.clear
	if @phase == 2 || @phase == 5
		item = @data[@real_index]
	elsif @phase == 3 || @phase == 4
		item = @ext_PosList.include?(@slot_index) ? $data_ItemName[@actor.ext_items[@slot_etype[@slot_index][0] - 9]] : @actor.equips[@slot_etype[@slot_index][0]]
    else
		return
	end
    return if item.nil?
	bmp.font.outline=false
	bmp.font.color=Color.new(20,255,20)
	draw_text_on_canvas(@item_info,7,0,$game_text[item.description])
  end
  
  def new_line_x
	7
  end
  
  def check_equip_effect_color(line)
    code = line.match(/\<([^\)]+)\>/i)
    if code.nil?
      return line
    else
      return line[code[1].size+2 .. -1]
    end
  end
	# when click :c or mouse click to item in item list.
	def process_list_equip
		item = @data[@real_index]
		if !@ext_YeaList.include?(@active_slot)
			return SndLib.sys_buzzer if !@actor.equippable?(item) || (!item.nil? && !@actor.equip_change_ok?(item.etype_id))
		end
		if @ext_YeaList.include?(@active_slot)
			slot = @active_slot
		else
			slot = @active_slot || item.etype_id
		end
		#if slot isnt ext, and bondage items
		if !@ext_YeaList.include?(slot) && item && @actor.equippable?(item) && item.type_tag == "Bondage" && @blocker_count_bondage <= 2
			if item != @blocker_item
				@blocker_frame = 0
				@blocker_count_bondage = 1
				@blocker_item = item
				return SndLib.sys_buzzer
			end
			@blocker_count_bondage += 1
			@blocker_frame = 0
			return SndLib.sys_buzzer
		end

		#process ext field
		if !@ext_YeaList.include?(slot) #normal equip
			change_equip(slot, item)
		elsif @ext_YeaList.include?(slot) #is_ext_slots?
			tarSlot = @ext_YeaList.index(slot)
			@actor.ext_items[tarSlot] = item.item_name
		end
		SndLib.sys_equip
		refresh_total_list		if	@phase == 2
		refresh_one_slot_list	if	@phase == 5 && !@ext_YeaList.include?(slot)
		refresh_slot_content
		# adjust list position if the item's stack becomes 0.
		if $game_party.item_number(item) < 1
			if @data.size == 0
				# need to do something?
			elsif @real_index > @data.size - 1
				reset_content_position
				@real_index = @data.size - 1
				@display_index = [@real_index, (@real_index.even?? 10 : 11)].min
				@content.y = [-26*((@data.size+1)/2 - 6), 0].min
			elsif @content.y + @content_dy < 0 && @real_index + 11 - @display_index > @data.size
				@real_index -= 2
				@content_dy += 26
			end
		end
		refresh_info
		refresh_stats_change
	end
  
  def get_eqp_block_index(type_id)
	@slot_etype.find{|key,val|val[0] == type_id}[0]
  end
  
	def remove_equip
		return unless @active_slot == @slot_etype[@slot_index][0]
		return if @actor.equips[@slot_etype[@slot_index][0]].nil?
		@actor.change_equip(@slot_etype[@slot_index][0], nil)
		@actor.update_state_frames
		SndLib.sys_equip
		refresh_slot_content
		refresh_one_slot_list
		refresh_info
		refresh_stats_change
	end
	def change_equip(slot, item)
		@actor.change_equip(slot, item)
		@actor.update_state_frames
	end
	def refresh_stats_change
		@actor.refresh           # recalc stats first
		@menu_pages[0].refresh   # now redraw stats UI
		refresh_stats_value
		@actor.refresh           # recalc stats second to get updated data
		@gauge.refresh           # now gauges are in sync
	end

  
  def reset_content_position
    @content.y = @content_dy = @display_index = @real_index = 0
  end
  
	def show
		super
		@menu_pages = SceneManager.scene.contents.contents if @menu_pages.nil?
		@content_viewport.visible = true
		refresh_total_list if @phase != 2
		@phase = 1
		refresh_info
		refresh_slot_content
		refresh_stats_change
	end
  
	def hide
		super
		@content_viewport.visible = false
	end
  
  def dispose
	@back.dispose#use Cached bitmap do not dispose Bitmap
	@body.dispose#use Cached bitmap do not dispose Bitmap
	@slot_sprite.bitmap.dispose
	@slot_sprite.dispose
	@slot_content.bitmap.dispose
	@slot_content.dispose
	@slot_cursor1.dispose#use Cached bitmap do not dispose Bitmap
	@slot_cursor2.dispose#use Cached bitmap do not dispose Bitmap
	@item_cursor1.dispose#use Cached bitmap do not dispose Bitmap
	@item_cursor2.dispose#use Cached bitmap do not dispose Bitmap
	@arrow_up.bitmap.dispose
	@arrow_up.dispose
	@arrow_down.bitmap.dispose
	@arrow_down.dispose	
	@item_info.bitmap.dispose
	@item_info.dispose
	@content.bitmap.dispose
	@content.dispose
	@content_viewport.dispose
	super
  end
  
end
