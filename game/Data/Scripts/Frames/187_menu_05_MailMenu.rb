#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================

# Menu Quests
#==============================================================================
# ** Menu_Quests
#==============================================================================

class Menu_Quests < Menu_ContentBase

	CONTENT_WIDTH = (Graphics.width*0.49375).to_i #316
	CONTENT_HEIGHT = (Graphics.height*0.784375).to_i #251

	def initialize
		super
		@phase = 1 #1: show, 2:category, 3: quest list, 4: content scroll
		@category_index		= 0
		@mail_index_shown	= 0 #the index for the mail which is curently shown in the info panel=
		@list_viewport = Viewport.new(163, 106, 119, 225)#viewport for mail list
		@list_viewport.z = 3+System_Settings::SCENE_Menu_Contents_Z
		@content_viewport = Viewport.new(293,67,321,271)
		@content_viewport.z	= 3+System_Settings::SCENE_Menu_Contents_Z
		@viewport.z = 3+System_Settings::SCENE_Menu_Contents_Z
		create_background
		create_category_arrow
		create_mail_arrows
		create_mail_content_arrow
		create_category_sprite
		create_category_name_sprite
		create_info_sprite #@mail_content
		#create_space_hint_sprite #press space to xxxx
		create_mail_lists
		@current_list=nil
		refresh_category
		hide
	end


	def create_mail_content_arrow #閱讀器ARROW
		@content_arr_up= Sprite.new
		@content_arr_down= Sprite.new
		@content_arr_up.bitmap		=	Cache.system("Menu/08Items/item_arrow")
		@content_arr_down.bitmap	=	Cache.system("Menu/08Items/item_arrow")
		@content_arr_down.src_rect.width = @content_arr_down.bitmap.width/2
		@content_arr_up.src_rect.width = @content_arr_down.src_rect.width
		@content_arr_up.src_rect.x = @content_arr_up.src_rect.width + 1
		#p @content_viewport.rect.x
		#p @content_viewport.rect.y #321
		#p @content_viewport.rect.width
		#p @content_viewport.rect.height
		#p (@content_viewport.rect.x + @content_viewport.rect.width/2) - @content_arr_down.src_rect.width/2
		#p  @content_viewport.rect.y + @content_arr_down.src_rect.height/2
		#msgbox "asdasdasd"
		#@content_arr_up.x = 450
		@content_arr_down.x = @content_arr_up.x = (@content_viewport.rect.x + @content_viewport.rect.width/2) - @content_arr_down.src_rect.width/2
		#@content_arr_up.y = 67
		@content_arr_up.y = @content_viewport.rect.y
		@content_arr_down.z = @content_arr_up.z = 4 + System_Settings::SCENE_Menu_Contents_Z
		#@content_arr_down.x = 450
		#@content_arr_down.y = 338
		@content_arr_down.y = @content_viewport.rect.y + @content_arr_down.src_rect.height/2
		@content_arr_down.visible	=	false
		@content_arr_up.visible		=	false
	end



	def create_mail_arrows # for mail list
		@arrow_up = Sprite.new
		@arrow_down = Sprite.new
		@arrow_up.bitmap = @arrow_down.bitmap =Cache.system("Menu/08Items/item_arrow")
		@arrow_down.src_rect.width = @arrow_down.bitmap.width/2
		@arrow_up.src_rect.width = @arrow_down.src_rect.width
		@arrow_up.src_rect.x = @arrow_up.src_rect.width + 1
		@arrow_up.x = @arrow_down.x = 214
		@arrow_up.y, @arrow_down.y = 92, 334
		@arrow_up.z = @arrow_down.z = 20+System_Settings::SCENE_Menu_Contents_Z
		@arrow_up.visible=false
		@arrow_down.visible=false
	end


	def create_background
		@back = Sprite.new(@viewport)
		@back.z = System_Settings::SCENE_Menu_Contents_Z
		@back.bitmap = Cache.load_bitmap(ROOT,"06quest/quest_layout")
	end

	def create_mail_lists
		@quest_list= []
		@quest_list << QuestList.new($game_system.unread_mails	,	Viewport.new(@list_viewport.rect)	, @mail_content	,	@content_arr_up	,@content_arr_down)
		@quest_list << QuestList.new($game_system.read_mails	,	Viewport.new(@list_viewport.rect)	, @mail_content	,	@content_arr_up	,@content_arr_down)
		@quest_list << QuestList.new($game_system.all_mails		,	Viewport.new(@list_viewport.rect)	, @mail_content	,	@content_arr_up	,@content_arr_down)
		@quest_list << QuestList.new($game_system.deleted_mails	,	Viewport.new(@list_viewport.rect)	, @mail_content	,	@content_arr_up	,@content_arr_down)
		@quest_list[3].no_delete=true
	end

	def create_category_arrow
		@category_arrow = Sprite.new(@viewport)
		@category_arrow.bitmap = Cache.load_bitmap(ROOT,"06quest/arrows")
		@category_arrow.src_rect = Rect.new(15, 0, 15, 10)
		@category_arrow.z = 20+System_Settings::SCENE_Menu_Contents_Z
		@category_arrow.visible = false
	end

	def create_category_name_sprite
		@category_name = Sprite.new(@viewport)
		@category_name.bitmap = Bitmap.new(133, 31)
		@category_name.x, @category_name.y = 156, 64
		@category_name.z = 3+System_Settings::SCENE_Menu_Contents_Z
	end


	def create_category_sprite
		@mouse_category_rect = []
		@category_sprites = Array.new(4){Sprite.new(@viewport)}
		@category_sprites.each_with_index do |spr, index|
			spr.bitmap = Bitmap.new(24,24)
			icon_index = icons[icons.keys[index]]
			bmp = -1
			rect = -1
			if icon_index.is_a?(String)
				bmp = Cache.normal_bitmap(icon_index)
				rect = Rect.new(0, 0, 24, 24)
			else
				bmp = Cache.system("Iconset")
				rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
			end
			spr.bitmap.blt(0, 0, bmp, rect)
			spr.opacity = 128
			spr.x, spr.y = 164 + index * 30, 29
			@mouse_category_rect << [spr.x,spr.y,24,24]
		end
	end
	#def create_category_sprite
	#	@mouse_category_rect = []
	#	@category_sprites = Array.new(4){Sprite.new(@viewport)}
	#	bmp = Cache.system("Iconset")
	#	@category_sprites.each_with_index do |spr, index|
	#		spr.bitmap = Bitmap.new(24,24)
	#		icon_index = icons[icons.keys[index]]
	#		rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
	#		spr.bitmap.blt(0, 0, bmp, rect)
	#		spr.opacity = 128
	#		spr.x, spr.y = 164 + index * 30, 29
	#		@mouse_category_rect << [spr.x,spr.y,24,24]
	#	end
	#end

	def create_space_hint_sprite
		@hint_sprite = Sprite.new(@viewport)
		@hint_sprite.z = System_Settings::SCENE_Menu_Contents_Z
		@hint_sprite.bitmap= Bitmap.new(200,20)
		@hint_sprite.bitmap.font.size = 10
		@hint_sprite.bitmap.font.outline = false
		@hint_sprite.x = 413
		@hint_sprite.y = 330
		tmpKey = "#{InputUtils.getKeyAndTranslate(:C)} #{$game_text["menu:letter/to_delete"]}"
		@hint_sprite.bitmap.draw_text(0, 0,200,20,tmpKey,2)
		@hint_sprite.visible = false
	end


	#replacement for Window_QuestData used to display content of mail
	def create_info_sprite
		#@empty_bitmap = Bitmap.new(CONTENT_WIDTH,CONTENT_HEIGHT)
		#bmp=Bitmap.new(321,271)
		@mail_content=Sprite.new(@content_viewport)
		reset_content_position
		@mail_content.bitmap = nil
		#@back.bitmap.clear_rect(293, 25, 320, 39)
		@mail_title= Sprite.new(@viewport)
		@mail_title.x = 293
		@mail_title.y = 24
		@mail_title.z = 3+System_Settings::SCENE_Menu_Contents_Z
		@mail_title.bitmap=Bitmap.new(320, 39)
		#@mail_title.bitmap.fill_rect(@mail_title.bitmap.rect,Color.new(255,0,0))
	end


	# The icon for the categorys
	def icons
		{
			:all		=>	226,
			:read		=>	236,
			:unread		=>	238,
			:deleted	=>	227
		}
	end

	def category_names
		[
			[:unread	,	$game_text["menu:letter/unread"]	],
			[:read		,	$game_text["menu:letter/read"]		],
			[:all		,	$game_text["menu:letter/all"]		],
			[:deleted	,	$game_text["menu:letter/deleted"]	]
		]
	end

	def clear_mail_content
		@mail_content.bitmap=nil
	end


	def enter_page
		SndLib.sys_ok
		@phase = 2
		refresh_category
		Input.update
	end

	def update
		return if !@viewport.visible
		mouse_update_input
		return if @phase == 1
		update_current_list
		update_category_arrow
		update_arrow
		update_mail_content_arrows
		update_input
	end

	#若信件內容超過螢幕高度時顯示的上下箭頭
	def update_mail_content_arrows
		return if !@content_arr_down.visible && !@content_arr_down.visible
		d = Graphics.frame_count%92/23
		@content_arr_up.y	= (d == 3) ?  58 : (58 - d*2 )		if	@content_arr_up.visible
		@content_arr_down.y	= (d == 3) ?  338 : (338 - d*2 )	if	@content_arr_down.visible
		update_mail_content_arrows_opacity
	end
	def update_mail_content_arrows_opacity
		return if !@mail_content
		return if !@content_arr_down.visible && !@content_arr_down.visible
		#p "@mail_content.y #{@mail_content.y}" if	@content_arr_up.visible
		#p "@mail_content.height #{@mail_content.height}" if	@content_arr_up.visible
		#p "@mail_content.bitmap.height #{@mail_content.bitmap.height}" if	@content_arr_up.visible
		#p "@mail_content.bitmap.rect #{@mail_content.bitmap.rect}" if	@content_arr_up.visible
		#p "@content_viewport.rect #{@content_viewport.rect}" if	@content_arr_up.visible
		if @mail_content.y >= 0
			@content_arr_up.opacity = 50
		else
			@content_arr_up.opacity = 255
		end
		if (@mail_content.y < 0 && @mail_content.y.abs + @content_viewport.rect.height > @mail_content.height) || (@content_viewport.rect.height >= @mail_content.height)
			@content_arr_down.opacity = 50
		else
			@content_arr_down.opacity = 255
		end
	end

	def update_arrow
		d = Graphics.frame_count%92/23
		if @arrow_up.visible
			@arrow_up.y = 92 - d
			@arrow_up.y = 91 if d == 3
		end
		if @arrow_down.visible
			@arrow_down.y = 334 + d
			@arrow_down.y = 335 if d == 3
		end
	end


	def update_current_list
		return if @current_list.nil?
		return leave_quest if !@current_list.active
		@current_list.update
		@arrow_up.visible = @current_list.can_scroll_up?
		@arrow_down.visible = @current_list.can_scroll_down?
		if @current_list.mail_index != @mail_index_shown
			refresh_mail_content
			@mail_index_shown = @current_list.mail_index
		end
	end




	def back_to_mailmenu(playSnd = true)
		@phase=1
		SndLib.sys_cancel if playSnd
		@menu.activate
		@list_viewport.visible=false
		@quest_list.each{|qlist|qlist.hide}
		@category_arrow.visible=false
	end


	def leave_quest
		@phase = 2
		SndLib.sys_cancel
		@current_list = nil
		@mail_content.bitmap = nil
		@arrow_up.visible		= false
		@arrow_down.visible	= false
	end

	def select_mail
		SndLib.sys_ok
		@phase = 4
	end


	def mouse_update_input
		#p @phase #1=show. 2=catagory 3=mailList
		return Mouse.ForceIdle if Input.MouseWheelForceIdle?
		return if !Mouse.enable?
		return mouse_press_cancel if Input.trigger?(:MX_LINK) && @phase >= 2
		tmpWithInMainMenuArea = Mouse.within_XYWH?(0, 0, 156, 360)
		tmpPressed_MZ_LINK = Input.trigger?(:MZ_LINK)
		tmp_WithInList = Mouse.within?(@list_viewport.rect)
		tmp_WithInScroll = Mouse.within?(@content_viewport.rect)
		return unless (tmpPressed_MZ_LINK && !tmpWithInMainMenuArea) || ((Input.trigger?(:L) || Input.trigger?(:R)) && (tmp_WithInList || tmp_WithInScroll))
		if !tmpWithInMainMenuArea && @phase == 1
			enter_page
			sound_played = true
		end

		tmpCategoryIndex = nil
		@mouse_category_rect.length.times {|i|
		                                   next unless Mouse.within_XYWH?(*@mouse_category_rect[i])
		                                  tmpCategoryIndex = i
		                                  }
		#p @quest_list[tmpCategoryIndex] if tmpCategoryIndex
		#進入上方主選單
		if tmpCategoryIndex
			@category_index = tmpCategoryIndex
			SndLib.sys_DialogNarrClose(90) if !sound_played
			sound_played = true
			refresh_category
			refresh_current_category
			refresh_arrows
			@quest_list[@category_index].cur_group.quit_read_mail if @quest_list[@category_index].cur_group.reading_mail && @category_index
			@quest_list.each{|qlist|qlist.leave_mail} if @phase != 2

			#進入信件列表
		elsif tmp_WithInList && @phase != 3 && @category_index
			enter_category

			#於信件列表
		elsif tmp_WithInList && @phase == 3 && @category_index
			curProgress = @quest_list[@category_index]
			curProgress.cur_group.quit_read_mail if curProgress.cur_group.reading_mail #若讀信 則取消
			currentMouseXY = Mouse.GetMouseXY
			tmpInListMouseTarget = nil
			mouseClickedTar = ((currentMouseXY[1] - @list_viewport.rect.y)+curProgress.viewport.oy)/curProgress.cur_group.rec_LINE_HEIGHT
			p "mouseClickedTar #{mouseClickedTar}"
			clickedTarget = mouse_clicked_mail(mouseClickedTar)
			p "clickedTarget #{clickedTarget}"
			return if !clickedTarget
			return curProgress.mouse_set_clicked_mail(clickedTarget[1],clickedTarget[2]) if clickedTarget[1] != curProgress.mail_index || clickedTarget[2] != curProgress.group_index
			return curProgress.expand_cur_group				if tmpPressed_MZ_LINK && curProgress.cur_group.header?(curProgress.mail_index) && !curProgress.cur_group.expand?
			return curProgress.collapse_cur_group			if tmpPressed_MZ_LINK && curProgress.cur_group.header?(curProgress.mail_index) && curProgress.cur_group.expand?





			#p "base_y #{curProgress.base_y}"
			#p "mail_count #{curProgress.mail_count}"
			#p "scroll_amt #{curProgress.scroll_amt}"
			#p "@viewport.oy #{curProgress.viewport.oy}"
			#p "cur_group #{curProgress.cur_group}"
			#p "last_mail_index #{curProgress.cur_group.last_mail_index(curProgress.mail_index)}"

			#p "mail_index #{curProgress.mail_index}"
			#p "mail_index_list #{curProgress.cur_group.mail_index_list}"
			#p "group_index #{curProgress.group_index}"
			#p "@quest_list[@category_index] #{@quest_list[@category_index]}"

			#p "@quest_list #{@quest_list}"
			#p "all mail_rects #{curProgress.cur_group.mail_rects}"
			#p "current mail_rect #{curProgress.cur_group.mail_rect(curProgress.mail_index)}"

			#p "mail_rect.y #{curProgress.cur_group.mail_rect(curProgress.mail_index).y}"
			#TODO 取消列表捲動效果 修正捲動過量時的問題 取得MOUSE RECT
			#todo Main_index = i 並辨認該物件是否為EXPAND  否則NEXT

			#curProgress.mail_list[curProgress.mail_index].name
			#return curProgress.expand_cur_group				if tmpPressed_MZ_LINK && curProgress.cur_group.header?(curProgress.mail_index) && !curProgress.cur_group.expand?
			#return curProgress.collapse_cur_group			if tmpPressed_MZ_LINK && curProgress.cur_group.header?(curProgress.mail_index) && curProgress.cur_group.expand?

			#於信件卷軸列表
		elsif tmp_WithInScroll && @category_index
			@phase = 3
			@quest_list[@category_index].enter_reading_mode
		end
	end

	def mouse_clicked_mail(id=nil) #將 clicked index 翻譯成 mail_index 及 group_index
		return nil if id==nil
		curProgress = @quest_list[@category_index]
		translatedArray = [] #clicked.id #realIndex ,groupIndex #name
		tmpCount = -1
		tmpGroupCount = -1
		#p "all_mails #{curProgress.all_mails}"
		#p "mail_group #{curProgress.mail_group[0].sender_name}"
		#p "mail_group #{curProgress.mail_group[1].sender_name}"
		#p "mail_group mail_index_list #{curProgress.mail_group[0].mail_index_list}"
		#p "mail_group mail_index_list #{curProgress.mail_group[1].mail_index_list}"
		#p "mail_group expand #{curProgress.mail_group[0].expand?}"
		#p "mail_group expand #{curProgress.mail_group[1].expand?}"
		curProgress.mail_group.each{|group|
			 tmpCount += 1
			tmpGroupCount += 1
			next translatedArray << [tmpCount,group.mail_index_list[0],tmpGroupCount ,group.sender_name] if !group.expand?
			if group.expand?
			tmpListCount = -1
			translatedArray << [tmpCount,group.mail_index_list[0],tmpGroupCount ,group.sender_name]
			group.mail_index_list.each{|groupList|
					tmpListCount += 1
					next if tmpListCount == 0
					tmpCount += 1
					translatedArray << [tmpCount,groupList ,tmpGroupCount,"subMail"]
				}
			end
			}
		translatedArray[id]
	end

	def mouse_press_cancel
		return if @phase <= 1
		@quest_list[@category_index].cur_group.quit_read_mail
		curProgress = @quest_list[@category_index]
		curProgress.leave_mail

		update_current_list
		update_category_arrow
		update_arrow
		update_mail_content_arrows

		back_to_mailmenu(false)
	end
	def update_input
		return if @current_list
		return back_to_mailmenu if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK)
		return enter_category   if Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)
		return next_category 	if Input.trigger?(:RIGHT)
		return last_category 	if Input.trigger?(:LEFT)
	end

	def enter_category
		@phase = 3
		SndLib.sys_ok
		@current_list= @quest_list[@category_index]
		@quest_list.each{|qlist|qlist.hide}
		@current_list.enter
		refresh_arrows
	end

	def refresh_arrows
		return unless @current_list
		@arrow_up.visible	= @current_list.can_scroll_up?
		@arrow_down.visible	= @current_list.can_scroll_down?
	end

	def next_category
		@category_index = (@category_index+1) %  @quest_list.length
		SndLib.sys_DialogNarrClose(90)
		#@hint_sprite.visible = (@category_index != 3) #deleted mails
		refresh_category
		refresh_current_category
		refresh_arrows
	end

	def last_category
		SndLib.sys_DialogNarrClose(90)
		@category_index = (@category_index-1) %  @quest_list.length
		#@hint_sprite.visible = (@category_index != 3) #deleted mails
		refresh_category
		refresh_current_category
		refresh_arrows
	end

	def update_category_arrow
		@category_arrow.visible = @phase == 2
		return unless @category_arrow.visible
		@category_arrow.x = @category_sprites[@category_index].x + 6
		d = Graphics.frame_count % 92 / 23
		@category_arrow.y = 16 + d * 2
		@category_arrow.y = 18 if d == 3
	end


	#when content goes out of length , create another page and add to the end of mail_content
	def lengthen_mail_content
		cur_content = @mail_content.bitmap
		new_content = Bitmap.new(CONTENT_WIDTH,cur_content.height+CONTENT_HEIGHT)
		new_content.blt(0,0,cur_content,cur_content.rect)
		new_content.font=cur_content.font
		@mail_content.bitmap = new_content
	end


	def refresh_mail_content
		reset_content_position
		clear_mail_content
		cur_mail=@current_list.current_mail
		@mail_title.bitmap.clear
		@mail_title.bitmap.font.outline = false
		unless cur_mail.nil?
			@mail_title.bitmap.draw_text(@mail_title.bitmap.rect, cur_mail.name, 1)
			rendered_image = Cache.email(cur_mail.symbol)
			if !rendered_image.nil?
				@mail_content.bitmap = rendered_image
				return
			end
			@mail_content.bitmap =Bitmap.new(CONTENT_WIDTH,CONTENT_HEIGHT)
			@mail_content.bitmap.font.outline=false
			@mail_content.src_rect = Rect.new(0,0,CONTENT_WIDTH,CONTENT_HEIGHT) #reset everytime we refresh mail content a.k.a: show mail content
			#@mail_content.bitmap.font.size=20
			draw_text_on_canvas(@mail_content,10,10,cur_mail.text)
			Cache.set_email(cur_mail.symbol,@mail_content.bitmap)
		end
	end

	def process_new_line(canvas,text,pos)
		pos[:x] = pos[:new_x]
		pos[:y] += pos[:height]
		pos[:height] = calc_line_height(canvas,text)
		lengthen_mail_content if pos[:y]+pos[:height] >= canvas.bitmap.height
	end

	#def reset_font_settings(canvas)
	#canvas.bitmap.font.color.set(Cache.system("Window").get_pixel(64 + (0 % 8) * 8, 96 + (0 / 8) * 8))
	#  canvas.bitmap.font.size = #Font.default_size
	#  canvas.bitmap.font.bold = Font.default_bold
	#  canvas.bitmap.font.italic = Font.default_italic
	#end

	def new_line_x
		10
	end

	def reset_content_position
		#@mail_content.x = 293
		#@mail_content.y = 71
		@mail_content.x = 0
		@mail_content.y = 0
	end

	def refresh_current_category
		case @category_index
		when 0; mails = $game_system.unread_mails
		when 1; mails = $game_system.read_mails
		when 2; mails = $game_system.all_mails
		when 3; mails = $game_system.deleted_mails
		end
		@quest_list[@category_index].set_mails(mails)
	end

	def refresh_category
		@category_sprites.each_with_index do |spr, index|
			spr.opacity = (index == @category_index && @phase > 1) ? 255 : 128
		end
		@category_name.bitmap.clear
		text = category_names[@category_index][1]
		bmp=@category_name.bitmap
		bmp.font.outline = false
		bmp.font.size = 22
		@category_name.bitmap.draw_text(bmp.rect, text, 1)
		for list_index in 0...@quest_list.length
			list_index == @category_index ? @quest_list[list_index].show : @quest_list[list_index].hide
		end
	end

	def show
		super
		@phase = 1
		refresh_category
		update_current_list
		#@hint_sprite.visible	=	true
		@list_viewport.visible	=	true
	end

	def hide
		super
		@quest_list.each{|qlist|qlist.hide}
		@list_viewport.visible	=	false
		#@hint_sprite.visible	=	false
		@category_arrow.visible	=	false
	end

	def dispose
		@back.dispose	#use cached bitmap
		@content_arr_up.dispose #use cached bitmap
		@content_arr_down.dispose #use cached bitmap
		@arrow_up.dispose #use cached bitmap
		@arrow_down.dispose #use cached bitmap
		@category_arrow.dispose #use cached bitmap
		@category_name.bitmap.dispose
		@category_name.dispose
		#@hint_sprite.bitmap.dispose
		#@hint_sprite.dispose
		@mail_title.bitmap.dispose
		@mail_title.dispose
		@mail_content.bitmap=nil
		@mail_content.dispose
		@category_sprites.each do
			|spr|
			spr.bitmap.dispose
			spr.dispose
		end
		@quest_list.each{|qlist|qlist.dispose}	#array of QuestList
		@list_viewport.dispose
		@content_viewport.dispose
		super
	end

end
