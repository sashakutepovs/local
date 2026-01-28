#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
#==============================================================================
# ** QuestListItem
#------------------------------------------------------------------------------
#  Quests grouped by one location.
#==============================================================================
class QuestListItem < Sprite
	NON_HEADER_MARGIN_LEFT = 20
	PADDING_LEFT = 5
	SIGN_WIDTH = 12
	LINE_HEIGHT = 15
	attr_reader	:mail_no
	attr_reader	:expanding
	attr_reader	:size_changing #expanding or collapsing , depends on tar_height
	attr_reader	:starting_index
	attr_reader	:mail_count
	attr_reader	:mail_rects
	attr_reader	:mail_index_list
	attr_reader	:rec_LINE_HEIGHT
	attr_reader	:rec_START_X
	attr_reader	:sender_name
	attr_accessor	:reading_mail
	attr_accessor :content_sprite #use common sprite from Menu, manage only scroll , not anything else
	attr_accessor :arrow_up
	attr_accessor :arrow_down

	def initialize(viewport,sender_name,mails,starting,base_y)
		super(viewport)
		@rec_LINE_HEIGHT = LINE_HEIGHT
		@rec_START_X = 13
		@size_changing=false
		@mail_no = 0
		@starting_index	 =	starting #這個list的第一封信是整個list裡的第幾封
		@ending_index =	starting + mails.length-1
		@mail_count = mails.length + 1 #
		self.y = base_y
		@mail_list=[] #the indexes of mail contained in this ListItem , number only
		@mail_index_list= (@starting_index...@starting_index+mails.length).to_a
		set(sender_name,mails)
		@scrollable=false
		self.src_rect=Rect.new(0,0,119,LINE_HEIGHT)
		@tar_height = LINE_HEIGHT
		@scroll_amt = 0
	end

	def set(sender,list,default_expand=false)
		@mail_list = list
		@sender_name=sender
		refresh
	end

	#visible lines
	def size
		expand? ? @mail_count : 1
	end

	#the rect for cursor, used in MenuQuest
	def mail_rect(mail_index)
		return @mail_rects[0] if !expand?
		return @mail_rects[0] if !has_mail?(mail_index)
		return @mail_rects[0] if (rect=@mail_rects[@mail_index_list.index(mail_index)]).nil?
		return rect
	end


	def visible_height
		size * LINE_HEIGHT
	end

	def update
		update_size_change
		update_content_scroll
		update_input
	end

	def update_size_change
		@size_changing = (self.height != @tar_height)
		return unless @size_changing
		dy = @tar_height - self.src_rect.height
		v = dy.abs > 100 ? 10 : 5
		v = dy.abs < v ? dy : (dy > 0 ? v : -v)
		self.src_rect.height += v
	end

	def update_content_scroll
		return if @scroll_amt == 0
		amt_abs=@scroll_amt.abs
		v = 15
		v = amt_abs > 120 ? v : v/2
		v = amt_abs > v.abs ? v : amt_abs
		v = @scroll_amt > 0 ? v : -v
		@content_sprite.y += v
		@scroll_amt -= v
	end


	def update_input
		return unless @reading_mail
		return quit_read_mail	if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK)
		return scroll_up(30)	if Input.repeat?(:UP)
		return scroll_down(30)	if Input.repeat?(:DOWN)
		return scroll_up(90)	if Input.repeat?(:L)
		return scroll_down(90)	if Input.repeat?(:R)
	end

	def update_arrow_visible
		return unless @reading_mail && @content_bottom < 0
		cur_y_pos = @content_sprite.y + @scroll_amt
		@arrow_up.visible = cur_y_pos < 0 if @content_bottom < 0
		@arrow_down.visible = cur_y_pos > @content_bottom if @content_bottom < 0
	end


	def scroll_up(power= 30)
		return if @content_sprite.y + @scroll_amt >=0
		@scroll_amt += power
	end



	def scroll_down(power= 30)
		return if @content_sprite.y + @scroll_amt <= @content_bottom
		@scroll_amt += -power
	end

	def expand?
		return false if self.src_rect.nil? || self.bitmap.nil?
		self.height == self.bitmap.height
	end

	def expand(index)
		return if index != @starting_index
		SndLib.sys_ok
		if(!@sender_name.eql?(""))
			self.bitmap.clear_rect(0, 0, 200, LINE_HEIGHT)
			self.bitmap.draw_text(PADDING_LEFT-2, 0, SIGN_WIDTH, LINE_HEIGHT, "-",1)
			self.bitmap.draw_text(PADDING_LEFT+SIGN_WIDTH, 0, 200, LINE_HEIGHT, "#{@sender_name}" )
		end
		@tar_height = self.bitmap.height
	end

	def expanding?
		@tar_height > LINE_HEIGHT && @tar_height != height
	end

	def collapsing?
		@tar_height == LINE_HEIGHT && @tar_height != height
	end

	def collapsed?
		@tar_height == LINE_HEIGHT && @tar_height == height
	end

	def collapse(index)
		return if index != @starting_index
		return unless expand?
		SndLib.sys_cancel
		if(!@sender_name.eql?(""))
			self.bitmap.clear_rect(0, 0, 200, LINE_HEIGHT)
			self.bitmap.draw_text(PADDING_LEFT, 0, SIGN_WIDTH, LINE_HEIGHT, "+",1)
			self.bitmap.draw_text(PADDING_LEFT+SIGN_WIDTH, 0, 200, LINE_HEIGHT, "#{@sender_name}")
		end
		@tar_height = LINE_HEIGHT
		@mail_no = 0
	end

	#y for drawing cursor
	def cursor_y(mail_index)
		mail_rect(mail_index).y + self.y
	end

	def delete_mail(mail_index)
		return if @no_delete || header?(mail_index)
		@mail_index_list.delete(mail_index)
		no_mail? ? @tar_height = 0 : refresh
	end

	def last_mail_index(mail_index)
		current_mail_no=@mail_index_list.index(mail_index)
		return -1 if !@mail_index_list.include?(mail_index)
		return -1 if header?(current_mail_no) && expand?
		return -1 if current_mail_no == 0 || @mail_index_list[current_mail_no-1].nil?
		return @mail_index_list[current_mail_no-1]
	end

	def next_mail_index(mail_index)
		current_mail_no=@mail_index_list.index(mail_index)
		return -1 if !@mail_index_list.include?(mail_index)
		return -1 if header?(@mail_index_list[current_mail_no+1]) && expand?
		return -1 if @mail_index_list[current_mail_no+1].nil?
		return @mail_index_list[current_mail_no+1]
	end

	#刪除後取得最編號上最接近的mail
	def closest_mail_index(mail_index)
		min_index = mail_index
		dist = mail_index
		for num in 0...@mail_index_list.length
			min_index = @mail_index_list[num] if (@mail_index_list[num]-mail_index) < dist
		end
		min_index
	end

	def refresh
		expand_status = expand? #當下的開啟狀況
		@mail_rects = []
		#self.bitmap.dispose if self.bitmap
		bmp = self.bitmap = Bitmap.new(119, LINE_HEIGHT * @mail_index_list.length)
		bmp.font.color=Color.new(20,255,20)
		bmp.font.size= 14
		bmp.font.outline=false
		@mail_rects << Rect.new(0, 0, 255, LINE_HEIGHT)
		if(!@sender_name.eql?(""))
			bmp.draw_text(PADDING_LEFT, 0, SIGN_WIDTH, LINE_HEIGHT,expand_status ? "-" : "+")			#reserve #0 of array for name tag
			bmp.draw_text(PADDING_LEFT+SIGN_WIDTH, 0, 200, LINE_HEIGHT,@sender_name)#reserve #0 of array for name tag
		end
		for mail_index in 1...@mail_list.length
			next unless @mail_index_list.include?(@starting_index + mail_index)
			bmp.draw_text(NON_HEADER_MARGIN_LEFT, @mail_rects.length* LINE_HEIGHT, bmp.width, LINE_HEIGHT, @mail_list[mail_index].name)
			@mail_rects << Rect.new(@rec_START_X, @mail_rects.length * LINE_HEIGHT  , bmp.width, LINE_HEIGHT)
		end
		@tar_height = self.height
	end

	#has nothing except height
	def no_mail?
		@mail_index_list.length<=1
	end

	def ending_index
		expand? ? @ending_index : @starting_index
	end

	def toggle(index)
		return unless @mail_index.zero? && index == @starting_index
		expand? ? collapse : expand
	end

	def has_mail?(index)
		@mail_index_list.include?(index)
	end

	def header?(mail_index)
		mail_index == @starting_index
	end

	def quit_read_mail
		SndLib.sys_DialogNarrClose(80)
		@arrow_down.visible = false if @arrow_down
		@arrow_up.visible = false if @arrow_up
		@content_bottom =	-1
		@scroll_amt		=	 0
		@reading_mail	=	false
	end

	def read_mail
		@arrow_down.visible = true if @arrow_down
		@arrow_up.visible 	= true if @arrow_up
		@content_bottom=-1 * (@content_sprite.bitmap.height - @content_sprite.viewport.rect.height)
		@scroll_amt		=	 0
		@reading_mail	=	true
	end

	def dispose
		self.bitmap.dispose
		@content_sprite=nil
		super
	end


end


