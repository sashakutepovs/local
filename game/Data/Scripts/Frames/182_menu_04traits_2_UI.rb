#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
#==============================================================================
# ** Menu_Traits
#==============================================================================
class Menu_Traits < Menu_ContentBase

	PANEL_LEFT=1
	PANEL_RIGHT=2
	def initialize
		super
		@active=false
		init_datas
		create_background
		create_total_point
		create_info_panel
		create_basic_trait_indicator
		create_icon_trays
		create_cursor
		refresh
	end
	def init_datas
		@blank_trait_state_id = System_Settings::TRAIT::BLANK_ID
		@basic_trait_list 	=	@actor.basic_traits
		@gift_traits 		=	System_Settings::TRAIT::LIST.flatten
		@cursor_phase= 0 	#current cursor column , value=>0:basic_trait; 1:accept button;  2:gift_traits
		@current_panel= 0	#default left panel,at basic_trait
		@cursor_column_index = 0 
		@icon_trays=Array.new 
		@trait_points=@actor.trait_point
		@gift_trait_selected=Array.new
		@basic_trait_selected=Hash.new
		@gift_flashing = Hash.new
		@gift_selected_boxes = Hash.new
		@basic_trait_list.each do |trait|@basic_trait_selected[trait[1]]=0; end
	end
	def reset_trait_system
		@trait_points=@actor.trait_point
		@gift_trait_selected=Array.new
		@basic_trait_selected=Hash.new
		@gift_flashing.each{|key,spr|spr.visible=false}
		@gift_flashing.clear
		@basic_trait_list.each do |trait|@basic_trait_selected[trait[1]]=0; end
	end
	def create_background
		@back = Sprite.new(@viewport)
		src_bmp=Cache.load_bitmap(ROOT,"05_trait/trait_layout")
		back_bmp=Bitmap.new(src_bmp.width,src_bmp.height)
		back_bmp.blt(0,0,src_bmp,src_bmp.rect)
		back_bmp.font.outline=false
		back_bmp.font.size = 20
		back_bmp.font.color=Color.new(20,255,20)
		back_bmp.draw_text(460, 25, 150, 35, "#{$game_text["menu:traits/point_left"]} :           ",2)
		#bmp.draw_text(460, 300, 30, 35, "Z",0)
		#bmp.font.size =24
		#bmp.draw_text(400, 300, 150, 35, "PRESS")
		#bmp.draw_text(500, 300, 150, 35,"TO SPEND UR POINTS")
		@back.bitmap=back_bmp
	end
	def create_total_point
		@total_point_sprite = Sprite.new(@viewport)
		@total_point_sprite.x = 585
		@total_point_sprite.y = 25
		@total_point_sprite.visible=true
		bmp=Bitmap.new(150,35)
		bmp.font.size = 30
		bmp.font.outline=false
		bmp.font.color=Color.new(20,255,20)
		@total_point_sprite.bitmap=bmp
	end
	def create_icon_trays		
		@icon_trays=
		[
			[create_basic_trait_list,Rect.new(0, 0, 36, 36) 	,	5	,	PANEL_LEFT	,	method(:basic_trait_handler)	,	method(:basic_trait_refresher)	],
			[create_accept_button	,Rect.new(0, 35, 174, 35)   ,	1	,	PANEL_LEFT	,	method(:accept_handler)			, 	method(:accept_refresher)		],
			[create_gift_trait_list	,Rect.new(0, 140, 26, 26)	,	9	,	PANEL_RIGHT	,	method(:gift_trait_handler)		,	method(:gift_trait_refresher)	] 
		]
		@panels=[[@basic_trait_icons,[@accept_sprite_green]],[@gift_trait_icons]]
	end
	def create_basic_trait_list
		@mouse_basic_trait_rect = []
		@basic_trait_icons=Array.new(@basic_trait_list.size){|index|
			trait_id=@basic_trait_list[index][0]
			spr=Sprite.new(@viewport)
			spr.bitmap = Bitmap.new(36,36)
			spr.bitmap.blt(2,2,Cache.system("32px_iconset"),Rect.new(trait_id % 8 * 32, trait_id / 8 * 32, 32, 32))
			spr.x= 156 + 8 +33*index
			spr.y= 38
			spr.visible=true
			@mouse_basic_trait_rect << [spr.x,spr.y,36,36]
			spr
		}
	end
   

	def create_gift_trait_list
		@mouse_gift_trait_rect = []
		@gift_trait_icons=Array.new(@gift_traits.size){
			|index|
			trait_id = @gift_traits[index]
			next if trait_id.nil?
			spr=Sprite.new(@viewport)
			trait_id.is_a?(String) ? icon_index=$data_StateName[trait_id].icon_index : icon_index = 0
			bmp=Bitmap.new(26,26)
			if icon_index.is_a?(String)
				bmp.blt(1,1,Cache.normal_bitmap(icon_index),Rect.new(0, 0, 24, 24))
			else
				bmp.blt(1,1,Cache.system("Iconset"),Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24))
			end

			spr.bitmap = bmp;
			spr.x= 365+ index % 9 * 26;
			spr.y= 67 + (index / 9 * 26); #edit
			@mouse_gift_trait_rect << [spr.x,spr.y,26,26]
			spr
		}
		@gift_trait_icons
	end
   
  #sprite used to draw 0+xxx
  def create_basic_trait_indicator
	@basic_trait_screen=Sprite.new(@viewport)
	@basic_trait_screen.x = 161
	@basic_trait_screen.y = 18
	bmp=Bitmap.new(184, 117)
	bmp.fill_rect(bmp.rect,Color.new(90,160,12))
	bmp.font.color=Color.new(20,255,20)
	bmp.font.size = 16
	@basic_trait_screen.bitmap=bmp
  end
   
   
   def create_accept_button
	bmp_dimension=[174, 90]
	text=$game_text["menu:traits/accept"].upcase #Grab from text file
	font_size = 60 
	
	@accept_sprite_red	=Sprite.new(@viewport)
	@accept_sprite_green=Sprite.new(@viewport)
	bmp_red=Bitmap.new(*bmp_dimension)
	bmp_green=Bitmap.new(*bmp_dimension)
	bmp_red.font.size	=	font_size
	bmp_green.font.size	=	font_size
	bmp_red.font.outline	=false
	bmp_green.font.outline	=false
	bmp_red.font.color	=	Color.new(255,0,0)
	bmp_green.font.color=	Color.new(20,255,20)
	
	bmp_red.draw_text(bmp_red.rect,text,1)
	bmp_green.draw_text(bmp_green.rect,text,1)
	
	@accept_sprite_red.bitmap=bmp_red
	@accept_sprite_green.bitmap=bmp_green
	@accept_sprite_red.visible=true
	@accept_sprite_green.visible=true
	@accept_sprite_red.x=162
	@accept_sprite_red.y=73#73
	@accept_sprite_green.x=162
	@accept_sprite_green.y=73#73
	@accept_sprite_red.opacity=0
	@accept_sprite_green.z=25
	@accept_sprite_red.z =50
	@mouse_accept_button_rect = [@accept_sprite_red.x,@accept_sprite_red.y,174, 90]
	[@accept_sprite_green]
  end
  
  def create_info_panel
	@info_panel=Sprite.new(@viewport)
	@info_panel.x=156
	@info_panel.y=139
	@info_panel.bitmap = Bitmap.new(184, 194)
  end
   
  def create_cursor
	@local_cursor=Menu_Cursor.new(@accept_sprite_green.x,@accept_sprite_green.y,Cache.system("Menu/05_trait/select_block"))
	@local_cursor.visible=false
	@local_cursor.src_rect=Rect.new(0, 0, 36, 35)
	@local_cursor.viewport=@viewport
	@local_cursor.to_xy(@accept_sprite_green.x,@accept_sprite_green.y,false)
	@local_cursor.z = 100
  end
  
  def enter_page  
    SndLib.sys_ok
	@active=true
	@cursor_phase=0
	@cursor_column_index=0
	set_cursor_src_rect
	set_cursor_location
	@accept_sprite_red.visible=false
	Input.update
	@local_cursor.visible=true
	refresh
  end
  
	def update
		return if !@viewport.visible
		mouse_update_input
		return unless @active
		update_input
		update_icon_flashing
		update_accept_flashing
		update_cursor_flashing
	end

	def mouse_update_input
		return Mouse.ForceIdle if Input.MouseWheelForceIdle?
		return if !Mouse.enable?
		return mouse_press_cancel if Input.trigger?(:MX_LINK) && @active
		tmpPressed_MZ_LINK = Input.trigger?(:MZ_LINK)
		tmpWithInMainMenuArea = Mouse.within_XYWH?(0, 0, 156, 360)
		return unless tmpPressed_MZ_LINK && !tmpWithInMainMenuArea
		firstClickBlock = !@active
		enter_page if !@active
		
		tmpGiftTraitIndex = nil
		@mouse_gift_trait_rect.length.times {|i|
			spr = @menu.menu_sprites[i]
			next unless Mouse.within_XYWH?(*@mouse_gift_trait_rect[i])
			tmpGiftTraitIndex = i
		}
		tmpBasicTraitIndex = nil
		@mouse_basic_trait_rect.length.times {|i|
			spr = @menu.menu_sprites[i]
			next unless Mouse.within_XYWH?(*@mouse_basic_trait_rect[i])
			tmpBasicTraitIndex = i
		}
		tmpWithInAcceptButton = Mouse.within_XYWH?(*@mouse_accept_button_rect)
		#p "@cursor_phase #{@cursor_phase}" #basictrait=0 accept=1 #trait=3
		#p "@cursor_column_index #{@cursor_column_index}" #accept = 0
		#p "tmpBasicTraitIndex #{tmpBasicTraitIndex}"
		#p "tmpGiftTraitIndex #{tmpGiftTraitIndex}"
		#p "WithInAccept #{Mouse.within_XYWH?(*@mouse_accept_button_rect)}"
		if tmpBasicTraitIndex
			firstClickBlock = true if @cursor_phase != 0 || @cursor_column_index != tmpBasicTraitIndex
			@cursor_phase = 0
			@cursor_column_index = tmpBasicTraitIndex
			refresh_trait_info
		elsif tmpWithInAcceptButton
			firstClickBlock = true if @cursor_phase != 1 || @cursor_column_index != 0
			@cursor_phase = 1
			@cursor_column_index = 0
		elsif tmpGiftTraitIndex
			firstClickBlock = true if @cursor_phase != 2 || @cursor_column_index != tmpGiftTraitIndex
			@cursor_phase = 2
			@cursor_column_index = tmpGiftTraitIndex
			refresh_trait_info
		end
		if tmpBasicTraitIndex ||  tmpWithInAcceptButton || tmpGiftTraitIndex
			SndLib.play_cursor if firstClickBlock
			set_cursor_src_rect
			set_cursor_location
			call_handler if !firstClickBlock
		end
	end

	def mouse_press_cancel
		return if !@active
		back_to_mainmenu
	end
	
	def update_input
		return if @cursor.moving?
		return back_to_mainmenu if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK)
		return call_handler		if Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)
		return next_row  		if Input.repeat?(:DOWN)
		return prev_row  		if Input.repeat?(:UP)
		return prev_column  	if Input.repeat?(:LEFT)
		return next_column  	if Input.repeat?(:RIGHT)
	end
  
  
  
  def update_icon_flashing
	return if @gift_flashing.empty?
	r = Graphics.frame_count % 30
    d = 127 * (r%15) / 14
    opacity = 128 + (r > 14 ? d : 63 - d)
	@gift_flashing.each{
		|key,spr|
		spr.opacity = opacity 
	}
  end
  
  def update_cursor_flashing
    r = Graphics.frame_count % 90
    d = 127 * (r%45) / 44
    @local_cursor.opacity = 128 + (r > 44 ? d : 63 - d)
  end
  
  
  
  def update_accept_flashing
	return  if @trait_points == @actor.trait_point#temporary ,if nothing to do return 
	r = Graphics.frame_count % 30
    d = 255 * (r%15) / 14
    @accept_sprite_red.opacity = r > 14 ? d : 255 - d
  end
  
  
	def back_to_mainmenu
		SndLib.sys_cancel
		@active=false
		@menu.activate  
		@local_cursor.visible=false
		@accept_sprite_red.visible=false
		reset_trait_system
		refresh
	end
  
	def call_handler
		@icon_trays[@cursor_phase][4].call
	end
  
  def next_row  
	SndLib.play_cursor 
	total_tray_count=@icon_trays.length
	tray_length=@icon_trays[@cursor_phase][0].length
	row_length=@icon_trays[@cursor_phase][2]
	unit_per_row =@icon_trays[@cursor_phase][2]
	@cursor_column_index = 0 if @icon_trays[@cursor_phase][0].length ==1
	if  tray_length == 1
		@cursor_column_index = 0
		@cursor_phase+=1
		skip_nil_index(1)
	#尋找下一行最接近當下x位置的非nil格子
	elsif(@cursor_column_index+unit_per_row < tray_length)
		position=@cursor_column_index % unit_per_row 
		#找到下一行的起始index
		next_line_start = @cursor_column_index + unit_per_row-(@cursor_column_index % unit_per_row) #檢查下一行同一個x座標上是否有東西，有的話直接過去
		if !@icon_trays[@cursor_phase][0][(next_line_start+position)].nil?
			@cursor_column_index =next_line_start+position
		else #沒有的話移動到下一行之後的下一個非nil的格子
		   @cursor_column_index = next_line_start
		   skip_nil_index(1)
		end
	else
		@cursor_phase+=1
		@cursor_phase = total_tray_count-1 if @cursor_phase>=total_tray_count
		@cursor_column_index=0 
		skip_nil_index(1)
	end
	refresh_trait_info
  end
  
  
  def prev_row
	SndLib.play_cursor 
	total_tray_count=@icon_trays.length
	tray_length=@icon_trays[@cursor_phase][0].length
	unit_per_row =@icon_trays[@cursor_phase][2]
	if  tray_length == 1
		@cursor_column_index= tray_length
		@cursor_phase-=1
		skip_nil_index(-1)
	elsif(@cursor_column_index-unit_per_row > 0)
		position= @cursor_column_index % unit_per_row
		prev_line_end = @cursor_column_index - (@cursor_column_index % unit_per_row)#找到上一行的最後index
		if !@icon_trays[@cursor_phase][0][(prev_line_end-unit_per_row+ position)].nil? #檢查上一行同一個x座標上是否有東西，有的話直接過去
			@cursor_column_index = prev_line_end-unit_per_row+position
		else #沒有的話移動到上一個非nil的格子
		   @cursor_column_index = prev_line_end
		   skip_nil_index(-1)
		end
	else
		@cursor_column_index=tray_length
		@cursor_phase = 0 if @cursor_phase < 0
		@cursor_phase-=1
		skip_nil_index(-1)
	end
	refresh_trait_info
  end

  
  def prev_column
	return switch_panel(false) if (@cursor_column_index -=1) % @icon_trays[@cursor_phase][2] == @icon_trays[@cursor_phase][2]-1
	return switch_panel(false) if @icon_trays[@cursor_phase][0][@cursor_column_index].nil? && empty_till_edge?(false)
	SndLib.play_cursor 
	skip_nil_index(-1)
	set_cursor_location 
	refresh_trait_info
  end
  
  def next_column 
	return switch_panel(true) if (@cursor_column_index +=1) % @icon_trays[@cursor_phase][2] == 0
	return switch_panel(true) if @icon_trays[@cursor_phase][0][@cursor_column_index].nil? && empty_till_edge?(true)
	SndLib.play_cursor 
	skip_nil_index(1)
	set_cursor_location 
	refresh_trait_info
  end
  
  
  def switch_panel(forward)
	SndLib.play_cursor 
	@prev_phase=@cursor_phase #記錄當下的cursor作為回來時使用
	new_panel= @icon_trays[@cursor_phase][3] == PANEL_LEFT ? PANEL_RIGHT : PANEL_LEFT
	for i in 0...@icon_trays.length
		if @icon_trays[i][3] == new_panel
			@cursor_phase = i 
			break
		end
	end
	@cursor_column_index= forward ? 0 : @icon_trays[@cursor_phase][0].length-1
	skip_nil_index(1)
	set_cursor_location
	set_cursor_src_rect
	refresh_trait_info
  end
  
  def empty_till_edge?(forward)
	empty_till_edge=true
	unit_per_row = @icon_trays[@cursor_phase][2]
	if forward
		addition= 1
		edge =unit_per_row - @cursor_column_index % unit_per_row -1
	else
		addition= -1
		edge =  @cursor_column_index % unit_per_row -1
	end
	current_index=@cursor_column_index
	for i in 0...edge
		if !@icon_trays[@cursor_phase][0][(current_index+=addition)].nil?
			empty_till_edge=false 
			break
		end
	end
	empty_till_edge
  end
  
  #skip_nil index in row , 如果當下的index到下/上一排為止都是nil，直接換頁
  def skip_nil_index(addition)
	tray_length=@icon_trays[@cursor_phase][0].length
	while @icon_trays[@cursor_phase][0][@cursor_column_index].nil?
		@cursor_column_index=tray_length if @cursor_column_index <0
		@cursor_column_index=0 if @cursor_column_index >tray_length
		@cursor_column_index+=addition
	end
  end
  
	def set_cursor_location
		spr=@icon_trays[@cursor_phase][0][@cursor_column_index]
		tgty = @cursor_phase == 1 ?  spr.y + 29  : spr.y#特例處理 ACCEPT 那張圖的問題
		@local_cursor.to_xy(spr.x,tgty,false)
	end
  
  
  def set_cursor_src_rect
	@local_cursor.src_rect=@icon_trays[@cursor_phase][1]
  end
  
  
  def refresh
	refresh_basic_trait_screen
	refresh_total_point
	refresh_trait_info
	refresh_trait_icon
  end
  
  def new_line_x;
   6
  end
  
  def refresh_total_point
	@total_point_sprite.bitmap.clear_rect(0, 0, 150, 35)
	@total_point_sprite.bitmap.draw_text(0, 0, 150, 35, @trait_points.to_s)
  end
  
  
  def refresh_trait_info
	set_cursor_src_rect
	set_cursor_location
	@icon_trays[@cursor_phase][5].call 
  end
  
  def refresh_basic_trait_screen
	bmp=@basic_trait_screen.bitmap
	bmp.clear
	bmp.font.outline = false
	@basic_trait_list = @actor.basic_traits
	@basic_trait_list.each_with_index{
		|trait,index|
		trait_id=@basic_trait_list[index][1]
		current=@basic_trait_list[index][2].to_i
		added=@basic_trait_selected[trait_id]
		text = added == 0 ? current : "#{current}+#{added}"
		bmp.draw_text(7+index*33, 54, 33, 21, text, 1)	
	}
  end
  
  def refresh_trait_icon
	trait_addable_list = @actor.gift_trait_addable_list(@gift_trait_selected)
	@gift_trait_icons.each_with_index{
		|spr,index|
		gift_trait_id=@gift_traits[index]
		next if spr.nil? || gift_trait_id== @blank_trait_state_id
		trait_id = @gift_traits[index]
		spr.bitmap.blt(1,1,Cache.system("Iconset"),Rect.new(657 % 16 * 24, 657 / 16 * 24, 24, 24)) if @actor.state_stack(trait_id) >=1
		case trait_addable_list[trait_id]#spr_type(trait_id)
			when 0 #can pick
				spr.blend_type = 0
				spr.opacity = 255
			when 1 #not fit, need more
				spr.blend_type = 0
				spr.opacity = 128
			when 2 #not allowed
				spr.blend_type = 2
				spr.opacity =50
			when 3 #already picked
				spr.blend_type = 1
				spr.opacity = 255
			when 4 #not fit, but closed, need more
				spr.blend_type = 1
				spr.opacity = 128
		end
	}
  end
  
  
	def draw_info_panel(item)
		if !item
			tmpName = ""
			tmpDesp = ""
		else
			tmpName = $game_text[item.name]
			tmpDesp = $game_text[item.description]
		end
		bmp=@info_panel.bitmap
		bmp.clear
		bmp.font.outline=false
		@str2Lang ? bmp.font.size=30 : bmp.font.size=26
		bmp.font.color=Color.new(255,255,255)
		bmp.draw_text(6, 0, 185, 38,tmpName)
		bmp.font.size=22
		draw_text_on_canvas(@info_panel,new_line_x,14,tmpDesp,true)
	end
  
  def accept_refresher
	@info_panel.bitmap.clear
  end
  
	def basic_trait_refresher
		draw_info_panel($data_ItemName[@basic_trait_list[@cursor_column_index][1]])
	end
  
  def gift_trait_refresher
	gift_trait=@gift_traits[@cursor_column_index]
	return if gift_trait.nil?
	draw_info_panel($data_StateName[gift_trait])
  end
  
  def basic_trait_handler
	tmpTarget=@basic_trait_list[@cursor_column_index][1]
	tmpAdded = @basic_trait_selected[tmpTarget]
	tmpCurrent = @basic_trait_list[@cursor_column_index][2]
	tmpTotal = 1+tmpAdded+tmpCurrent
	#p "------------------------------------------------------"
	#p "@basic_trait_list[@cursor_column_index][0] => #{@basic_trait_list[@cursor_column_index][0]}"
	#p "@basic_trait_list[@cursor_column_index][1] => #{@basic_trait_list[@cursor_column_index][1]}"
	#p "@basic_trait_list[@cursor_column_index][2] => #{@basic_trait_list[@cursor_column_index][2]}"
	#p "@basic_trait_list[@cursor_column_index][3] => #{@basic_trait_list[@cursor_column_index][3]}"
	#p "@basic_trait_selected =>                      #{@basic_trait_selected}"
	#p "tmpAdded =>                                   #{tmpAdded}"
	#p "tmpCurrent =>                                 #{tmpCurrent}"
	#p "tmpTotal =>                                   #{tmpTotal}"
	#p "------------------------------------------------------"
	return SndLib.sys_buzzer if @trait_points <= 0 || !@actor.basic_trait_addable?(tmpTotal)
	SndLib.sys_ok
	@trait_points-=1
	@accept_sprite_red.visible = true
	@basic_trait_selected[@basic_trait_list[@cursor_column_index][1]] += 1
	refresh
  end
  
  def basic_trait_max?(tmpTrait)
	@basic_trait_list[@cursor_column_index][2] + @basic_trait_selected
  end
  
	def gift_trait_handler
		gift_trait_id=@gift_traits[@cursor_column_index] #trait_id , @blank_trait_state_id is a system state indicating empty space
		#return SndLib.sys_buzzer if gift_trait_id==@blank_trait_state_id || !@actor.state_addable?(gift_trait_id) || @trait_points <= 0 || @actor.gift_trait_addable?(gift_trait_id,@gift_trait_selected) != 0
		return SndLib.sys_buzzer if gift_trait_id==@blank_trait_state_id || !@actor.state_addable?(gift_trait_id) || @trait_points <= 0 || @actor.gift_trait_addable_list(@gift_trait_selected)[gift_trait_id] != 0
		SndLib.sys_ok
		if @gift_trait_selected.include?(gift_trait_id)		
			@gift_trait_selected.delete(gift_trait_id)
			@gift_flashing[gift_trait_id].visible=false
			@trait_points+=1
		else
			@gift_flashing[gift_trait_id]=gift_select_box(@cursor_column_index)
			@gift_trait_selected << gift_trait_id
			@trait_points-=1
		end
		@accept_sprite_red.visible = (@actor.trait_point != @trait_points)
	refresh
	end
  
  def gift_select_box(index)
	spr=Sprite.new(@viewport)
	spr.bitmap=Cache.system("Iconset")
	spr.src_rect=Rect.new(657 % 16 * 24, 657 / 16 * 24, 24, 24)
	spr.x= 365+ index % 9 * 26 +1 
	spr.y= 67 + index / 9 * 26 +1
	spr
  end
  
  def accept_handler
	SndLib.sys_ok
	accept_basic_traits
	accept_gift_traits
	clear_selection_data
	@actor.trait_point = @trait_points
	@actor.refresh
	@actor.update_state_frames
	@accept_sprite_red.visible=false
	@accept_sprite_red.opacity=0
	refresh
	SceneManager.scene.contents.refresh
	SceneManager.scene.gauge.refresh
  end
  
  
  def accept_basic_traits
	@basic_trait_selected.each{
		|key,value|
		for i in 0...value
			item= $data_ItemName[key]
			@actor.item_apply(@actor,item)
			@actor.use_item(item)
		end
	}
  end
  
  def clear_selection_data
	@basic_trait_selected.keys.each{|key| @basic_trait_selected[key]=0}
	@gift_trait_selected=Array.new
  end

	def accept_gift_traits
		@gift_trait_selected.each{|gift_trait|
			if $data_StateName[gift_trait].common_tags && !$data_StateName[gift_trait].common_tags["traitItemID"].nil?
				traitItemID = $data_StateName[gift_trait].common_tags["traitItemID"]
				item = $data_ItemName[traitItemID]
				return msgbox "traitItemID=>#{traitItemID} not found" if !item
				p "#{gift_trait} : trait itemID found  = > #{item.item_name}"
				@actor.item_apply(@actor,item)
				@actor.use_item(item)
			end
			@actor.add_state(gift_trait)
		}
 	end
  
  def dispose
	@basic_trait_screen.bitmap.dispose
	@basic_trait_screen.dispose
	@accept_sprite_red.bitmap.dispose	
	@accept_sprite_red.dispose	
	@accept_sprite_green.bitmap.dispose
	@accept_sprite_green.dispose
	@back.bitmap.dispose
	@back.dispose
	@total_point_sprite.bitmap.dispose
	@total_point_sprite.dispose
	@basic_trait_screen.bitmap.dispose
	@basic_trait_screen.dispose
	@info_panel.bitmap.dispose
	@info_panel.dispose
	@local_cursor.dispose
	@gift_flashing.each{|f|f.dispose}
	@gift_trait_icons.each do 
		|gt_icon|
		gt_icon.bitmap.dispose	
		gt_icon.dispose
	end
   @basic_trait_icons.each do
		|bt_icon|
		bt_icon.bitmap.dispose	
		bt_icon.dispose
	end  
   super
  end
  
end

