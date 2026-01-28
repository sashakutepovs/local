#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
#==============================================================================
# ** QuestList
#------------------------------------------------------------------------------
#  A list of all quests belong to a category.
#==============================================================================
class QuestList

	LINE_HEIGHT = 15
	VISIBLE_LINE = 15

	attr_reader		:active
	attr_reader		:mail_index
	attr_reader		:base_y
	attr_reader		:mail_count
	attr_reader		:scroll_amt
	attr_reader		:viewport
	attr_reader		:group_index
	attr_accessor	:no_delete
	attr_reader		:all_mails
	attr_reader		:mail_group
	attr_accessor	:cur_group

	def initialize(mails,viewport,content_sprite,arrow_up,arrow_down)
		@viewport = viewport
		@viewport.z = 3+System_Settings::SCENE_Menu_Contents_Z
		@no_delete = false
		@mail_index = 0
		@mail_count = 0
		@group_index= 0
		@base_y = 0 #所有mail的基準
		@scroll_amt = 0 #整個list，需要往下或往上移動多少，會隨漸變削減
		create_side_arrows
		@arrow_up=arrow_up
		@arrow_down=arrow_down
		@content_sprite=content_sprite
		set_mails(mails)
		hide
	end

	def create_side_arrows
		@side_arrow = Sprite.new(@viewport)
		@side_arrow.bitmap = Bitmap.new(133, 15)
		bmp = Cache.system("Menu/06quest/arrows")
		@side_arrow.bitmap.blt(0, 4, bmp, Rect.new(30, 0, 5, 7))
		@side_arrow.bitmap.blt(128, 4, bmp, Rect.new(45, 0, 5, 7))
		@side_arrow.x = 0
		@side_arrow.y = 0
		@side_arrow.z= 3+System_Settings::SCENE_Menu_Contents_Z
		@side_arrow.visible = false
	end



	def set_mails(mails)
		@mail_count = 0
		groups = mails.group_by {|i| i.sender}
		sorted_senders=groups.keys.sort{|keya,keyb| keya<=>keyb}
		@all_mails=[]
		@mail_group.each{|group|group.dispose;} if @mail_group
		@mail_group=[]
		for i in 0...sorted_senders.length
			sender_name=sorted_senders[i]
			group=[nil].concat(groups[sender_name])
			qli=QuestListItem.new(@viewport,sender_name,group,@mail_count,LINE_HEIGHT * i)
			qli.content_sprite = @content_sprite
			qli.arrow_up	=	@arrow_up
			qli.arrow_down	=	@arrow_down
			@mail_group << qli
			@all_mails.concat(group)
			@mail_count+=group.length
		end
		@mail_group[0] = QuestListItem.new(@viewport,"",[nil],0,0) if @mail_group.empty?
		@cur_group = @mail_group[0]
	end

	def arrow_y
		#注意這個y數值會因為開開關關而有所變化
		@cur_group.cursor_y(@mail_index)
	end


	def update
		# @viewport.z = 3+System_Settings::SCENE_Menu_Contents_Z
		return unless @active
		update_input
		update_item_stuffing
		update_all_list
		update_scroll
		update_arrow
	end

	def update_arrow
		@side_arrow.y = arrow_y
	end

	def update_input
		return if @cur_group.reading_mail
		return expand_cur_group			if Input.trigger?(:RIGHT)
		return collapse_cur_group		if Input.trigger?(:LEFT)
		return leave_mail				if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK)
		return expand_cur_group			if (Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)) && @cur_group.header?(@mail_index) && !@cur_group.expand?
		return collapse_cur_group		if (Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)) && @cur_group.header?(@mail_index) && @cur_group.expand?
		return enter_reading_mode		if Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)
		return delete_current_mail		if Input.trigger?(:S9)
		return prev_mail				if Input.repeat?(:UP) || Input.repeat?(:L)
		return next_mail				if Input.repeat?(:DOWN) || Input.repeat?(:R)
	end

	def update_all_list
		@mail_group.each{
			|group|
			group.update
		}
	end

	#處理整個郵件清單的捲動問題
	def update_scroll
		return if @scroll_amt == 0 
		amt_abs=@scroll_amt.abs
		v = LINE_HEIGHT
		v = amt_abs > LINE_HEIGHT ? v : v/2
		v = amt_abs > v.abs ? v : amt_abs
		v = @scroll_amt > 0 ? v : -v
		@viewport.oy += v
		@scroll_amt -= v
	end

	#處理開關選單造成單位需要往下移動的問題
	def update_item_stuffing
		group_y = @base_y
		delete_index = -1
		for group_index in 0...@mail_group.length
			mail_group = @mail_group[group_index]
			mail_group.y = group_y
			group_y += mail_group.height
			delete_index = group_index if mail_group.no_mail? && mail_group.height <= 0
		end
		if delete_index != -1
			@mail_group.delete_at(delete_index)
		end
		@list_bottom_y = group_y
	end
  
  def create_stuffing_list
 	@cur_group = @mail_group[0] = QuestListItem.new(@viewport,"",[nil],0,0) 
  end

  def expand_cur_group
	@cur_group.expand(@mail_index)
  end
  
  def collapse_cur_group
	@cur_group.collapse(@mail_index)
  end
  
  def delete_current_mail
	return if @no_delete || @cur_group.header?(@mail_index)
	SndLib.sys_DialogNarr(80)
	@cur_group.delete_mail(@mail_index)
	@all_mails[@mail_index].delete
	if @cur_group.no_mail?
		@cur_group.visible=false
		@group_index = @mail_group.length > @group_index ? @group_index : @mail_group.length-1
		@mail_group.delete_at(@group_index)
		@cur_group= @mail_group[@group_index]
		create_stuffing_list if @cur_group.nil?
		@mail_index = @cur_group.starting_index
	else 
		@mail_index = @cur_group.closest_mail_index(@mail_index)
	end
  end
  
  def enter_reading_mode
	return if @cur_group.header?(@mail_index)
	SndLib.sys_DialogNarr(80) if !@cur_group.reading_mail
	@cur_group.read_mail
  end

  
	def enter_mail
		@all_mails[@mail_index].read
	end
  
  
	def leave_mail
		@active=false
		@mail_index=@mail_group[0].starting_index
		@group_index = 0
		@scroll_amt = 0
		@viewport.oy = 0
		@side_arrow.visible = false
	end

	def prev_mail
		return if @mail_index == 0
		SndLib.play_cursor
		cur_index = @mail_index
		last_group_index= @group_index 
		if @cur_group.expand? || @cur_group.expanding?
			prev_mail_id=@cur_group.last_mail_index(@mail_index)
			prev_mail_id==-1 ? to_prev_group : @mail_index=prev_mail_id
		else
			to_prev_group
		end
		enter_mail unless @all_mails[@mail_index].nil?
		refresh_scroll_amt
	end

	def next_mail
		return if @mail_index >= @mail_count
		tmpPrevMainIndex = @mail_index
		cur_index = @mail_index
		last_group_index = @group_index
		if @cur_group.expand? || @cur_group.expanding?
			next_mail_id = @cur_group.next_mail_index(@mail_index)
			next_mail_id ==-1 ? to_next_group : @mail_index=next_mail_id
		else
			to_next_group
		end
		enter_mail unless @all_mails[@mail_index].nil?
		refresh_scroll_amt
		SndLib.play_cursor if tmpPrevMainIndex != @mail_index
	end
	
	def mouse_set_clicked_mail(tarMailIndex,tarMailGroup)
		return if !tarMailIndex
		return if !tarMailGroup
		tmpPrevMainIndex = @mail_index
		last_group_index = @group_index
		@mail_index = tarMailIndex
		@group_index = tarMailGroup
		@cur_group = @mail_group[@group_index]
		enter_mail unless @all_mails[@mail_index].nil?
		refresh_scroll_amt
		update_arrow
		SndLib.play_cursor if tmpPrevMainIndex != @mail_index
	end
	
	def refresh_scroll_amt
		#check if within viewport
		arr_y = arrow_y + LINE_HEIGHT
		bottom = @viewport.rect.height + @viewport.oy.abs
		top = @viewport.oy + LINE_HEIGHT
		return if arr_y < 0
		#going down
		if arr_y > bottom
			amt = arr_y - bottom + LINE_HEIGHT
		elsif arr_y < top #going up
			amt = arr_y - top
		else
			return
		end
		@scroll_amt += amt
	end
  
  
	def to_next_group
		return if @group_index+1 >= @mail_group.length
		return if @mail_group[@group_index+1].nil?
		next_group = @mail_group[@group_index+1]
		@mail_index = next_group.starting_index
		@cur_group	=	next_group
		@group_index+=1
	end
  
	def to_prev_group
		return if @group_index-1 < 0
		return if @mail_group[@group_index-1].nil?
		prev_group	=	@mail_group[@group_index-1]
		@mail_index	=	prev_group.ending_index
		@cur_group	=	prev_group
		@group_index-=1
	end

	def current_mail
		@all_mails[@mail_index] # 不做檢查，Menu看到是nil就直接把畫面清空但不重畫
	end

	def show
		@viewport.visible = true
	end

	def enter
		show
		@active=true
		@group_index = 0
		@selected_mail =nil
		@side_arrow.visible =true
		@scroll_amt = 0
		@cur_group= @mail_group.first
		@viewport.oy = 0
		@mail_index = @cur_group.starting_index
	end

	def hide
		@viewport.visible =false
		@active=false
	end

	#show up arrow
	def can_scroll_up?
		@viewport.oy != 0
	end

	#show down arrow , possibly slow , need check
	 def can_scroll_down?
		@viewport.oy > 0
	end

	def dispose
		@mail_group.each {|group|group.dispose}
		@side_arrow.bitmap.dispose
		@side_arrow.dispose
		@content_sprite=nil #external resource, will be disposed by Menu_Quests
		@viewport.dispose
	end
  
end
