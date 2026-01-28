#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
class Menu_HealthStats < Menu_ContentBase

	def initialize
		super()
		@phase =  1#1: show health info, 2: show state info
		#@health_info = Sprite.new(@viewport)
		#@health_info.bitmap = Bitmap.new(Graphics.width, Graphics.height)
		#@health_info.z = System_Settings::SCENE_Menu_Contents_Z
		@reuqest_refresh_info_delay = 0
		@icon_viewport_default_x = 180
		@icon_viewport_default_y = 32
		@icon_viewport_default_w = 433
		@icon_viewport_default_h = 294
		@buffList_default_witdh = 130 #for mouse
		
		@buff_viewport = Viewport.new
		@buff_viewport.z = System_Settings::SCENE_Menu_Contents_Z
		@icon_viewport = Viewport.new(@icon_viewport_default_x, @icon_viewport_default_y, @icon_viewport_default_w, @icon_viewport_default_h)
		@icon_viewport.z = System_Settings::SCENE_Menu_Contents_Z
		@buff_layout = Sprite.new(@buff_viewport)
		@buff_layout.z = System_Settings::SCENE_Menu_Contents_Z
		@buff_layout.bitmap = Cache.load_bitmap(ROOT,"02Health_stats/buff_stats_layout")#Bitmap.new("#{ROOT}02Health_stats/buff_stats_layout")
		@buff_icons = Sprite.new(@icon_viewport)
		@buff_icons.z = System_Settings::SCENE_Menu_Contents_Z
		@buff_icons.x = 0
		@icon_dy = 0
		@buff_info = Sprite.new(@buff_viewport)
		@buff_info.z = System_Settings::SCENE_Menu_Contents_Z
		@buff_info.bitmap = Bitmap.new(299,312)
		@buff_info.x, @buff_info.y = 314,24
		@buff_viewport.visible = false
		@icon_viewport.visible = false
		
		@arrow_up = Sprite.new
		@arrow_up.z = System_Settings::SCENE_Menu_Contents_Z
		@arrow_down = Sprite.new
		@arrow_down.z = System_Settings::SCENE_Menu_Contents_Z
		@arrow_up.bitmap = @arrow_down.bitmap =Cache.load_bitmap(ROOT,"02Health_stats/scroll_arrow") #Bitmap.new("#{ROOT}02Health_stats/scroll_arrow")
		
		@arrow_up.src_rect.width = @arrow_up.bitmap.width/2
		@arrow_down.src_rect.width = @arrow_up.src_rect.width
		@arrow_down.src_rect.x = @arrow_down.src_rect.width
		@arrow_up.x = @arrow_down.x = 237
		@arrow_up.y, @arrow_down.y = 15, 330
		@arrow_up.visible = @arrow_down.visible = false

		@cursor_display_index = 0
		@cursor_real_index = 0

		refresh
		hide
	
	end

	def update
		return if !@show
		mouse_update_input
		return unless @phase == 2
		update_input
		update_icon_move
		update_arrow
		update_buff_info
	end

	def update_buff_info
		#because skill page got few laggy. this is trying to fix the issue
		return if !@reuqest_refresh_info
		@reuqest_refresh_info_delay += 1
		refresh_buff_info if @reuqest_refresh_info_delay >= 5
	end

	def mouse_update_input
		return Mouse.ForceIdle if Input.MouseWheelForceIdle?
		return if !Mouse.enable?
		return cancel_page if Input.trigger?(:MX_LINK) && @phase == 2
		#p "Mouse.GetMouseXY #{Mouse.GetMouseXY}"
		tmpWithInControlArea = Mouse.within_XYWH?(@icon_viewport_default_x, @icon_viewport_default_y, @buffList_default_witdh, @icon_viewport_default_h)
		tmpWithInWholePage = Mouse.within_XYWH?(180, 25, 130, 314)
		return unless Input.trigger?(:MZ_LINK) || (@phase == 1 && tmpWithInWholePage && (Input.repeat?(:L) || Input.repeat?(:R)))
		enter_page if @phase == 1 && tmpWithInWholePage
		cancel_page if @phase == 2 && !tmpWithInWholePage
		if @buff_icon_rect_record.size >= 1
			tmpProcessIndex = -1
			@buff_icon_rect_record.length.times {|i|
				next unless Mouse.within_XYWH?(*@buff_icon_rect_record[i])
				tmpProcessIndex = i
			}
			
			if tmpProcessIndex >= 0
				@cursor_display_index = tmpProcessIndex
				@cursor_real_index = tmpProcessIndex + (@buff_icons.y/27).abs
				p "cursor_real_index =>#{@cursor_real_index}  buff_icons=>#{@buff_icons.y/27}"
				refresh_flag = true
				if refresh_flag
					SndLib.play_cursor
					@cursor.to_xy(160, 36 + @cursor_display_index * 27)
					@reuqest_refresh_info = true
					@reuqest_refresh_info_delay = 0
				end
			end
		end
	end
	

	def mouse_force_main_menu_pause
		false
	end
	
  def bound_height
	297
  end
  
	def update_input
		cancel_page if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK)
		if Input.repeat?(:UP) || Input.repeat?(:L) || Input.trigger?(:NUMPAD8)
			pageup = Input.trigger?(:NUMPAD8) || Input.repeat?(:L)
			d = pageup ? [-@cursor_real_index, -5].max : -1
			refresh_flag = false
			if @cursor_real_index == 0
				############### move to bottom
				#@cursor_real_index = @states.size - 1
				#@cursor_display_index = [@cursor_real_index, 10].min
				#@icon_dy -= @buff_icons.height - bound_height
				#refresh_flag = true
				
			elsif @cursor_real_index+d <= 0 
				############## stay in top
				@cursor_real_index = 0
				@cursor_display_index = 0
				@icon_dy = 1
				refresh_flag = true
				
			elsif @cursor_real_index != 0
				new_real_index = [@cursor_real_index + d, 0].max
				new_display_index = [@cursor_display_index + d, 0].max
				@icon_dy = 1
				@cursor_real_index = new_real_index
				@cursor_display_index = new_display_index 
				refresh_flag = true
			end
			if refresh_flag
				SndLib.play_cursor
				@cursor.to_xy(160, 36 + @cursor_display_index * 27)
				@reuqest_refresh_info = true
				@reuqest_refresh_info_delay = 0
			end
		end
		if Input.repeat?(:DOWN) || Input.repeat?(:R) || Input.trigger?(:NUMPAD2)
			pagedown = Input.trigger?(:NUMPAD2) || Input.repeat?(:R)
			d = pagedown ? [@states.size - 1 - @cursor_real_index, 5].min : 1
			refresh_flag = false
			if @cursor_real_index == @states.size - 1
				############# move to top
				#@cursor_real_index = 0
				#@cursor_display_index = 0
				#@icon_dy += @buff_icons.height - bound_height
				#refresh_flag = true
				
			elsif @cursor_real_index+d >= @states.size - 1
				############## stay in bot
				@cursor_real_index = @states.size - 1
				@cursor_display_index = [@cursor_real_index, 10].min
				@icon_dy = 1
				refresh_flag = true
				
				
				
			elsif @cursor_real_index != @states.size - 1
				new_real_index = [@cursor_real_index + d, @states.size - 1].min
				new_display_index = [@cursor_display_index + d, 10, @states.size - 1].min
				#@icon_dy += (@cursor_real_index - new_real_index - @cursor_display_index + new_display_index) * 27
				@icon_dy = 1
				@cursor_real_index = new_real_index
				@cursor_display_index = new_display_index
				refresh_flag = true
			end
			if refresh_flag
				SndLib.play_cursor
				@cursor.to_xy(160, 36 + @cursor_display_index * 27)
				@reuqest_refresh_info = true
				@reuqest_refresh_info_delay = 0
			end
		end
	end

	def update_icon_move
		return if @icon_dy == 0
		@buff_icons.y = [(@cursor_real_index-10),0].max * -27 if @cursor_display_index >= 10
		@buff_icons.y = [(@cursor_real_index),0].max * -27 if @cursor_display_index <= 0
		@icon_dy = 0
		
		#return if @buff_icons.height <= 297
		#v = @icon_dy.abs > 50 ? 20 : 5
		#v = @icon_dy.abs > v ? (@icon_dy > 0 ? v : -v) : @icon_dy
		#@buff_icons.y += v
		#@icon_dy = v
	end

	def update_arrow
		@arrow_up.visible = @phase==2 && @cursor_real_index > @cursor_display_index
		@arrow_down.visible = @phase==2 && @cursor_real_index + 10 - @cursor_display_index < @states.size - 1
		@arrow_up.y = 15 - Graphics.frame_count%60/20 if @arrow_up.visible
		@arrow_down.y = 330 + Graphics.frame_count%60/20 if @arrow_down.visible
	end

	def show
		super
		@show = true
		@phase = 1
		@buff_icons.x = 0
		@buff_viewport.visible = true
		@icon_viewport.visible = true
		#@buff_icons.y = @icon_dy = 0
	end

	def hide
		super
		@show = false
		@phase = 1
		@icon_viewport.visible = false
		@buff_viewport.visible = false
		@arrow_up.visible = @arrow_down.visible = false
		@cursor.visible =true
		#@buff_icons.y = @icon_dy = 0
	end

	def enter_page
		SndLib.sys_ok
		@phase = 2
		@viewport.visible = false
		@buff_viewport.visible = true
		@icon_viewport.visible = true
		#@cursor_display_index = @cursor_real_index = 0
		#@icon_dy += -@buff_icons.y if @buff_icons.y!=0
		#@buff_icons.x = 0
		@cursor.visible = !@states.empty?
		@cursor.to_xy(160, 36 + @cursor_display_index * 27)
		#@cursor.to_xy(160, 36)
		refresh_buff_info
	end

	def hide_buff
		@viewport.visible = false
		@arrow_up.visible	= false
		@arrow_down.visible = false
	end
	
	def cancel_page
		SndLib.sys_cancel
		hide_buff
		@phase = 1
		@menu.activate
	end
	
	def refresh
		refresh_buff_icons
	end
  

	def refresh_buff_icons
		#@buff_icons.bitmap.dispose if @buff_icons.bitmap
		@states=@actor.states.uniq.select{|state|
			next if state.menu_hide_lvl && state.menu_hide_lvl.include?(@actor.state_stack(state.id))
			!["trait","combat","","nil",nil].include?(state.type_tag)
			}.sort{|state1,state2|
				sort_order = ["daily","green", "yellow", "red", "magenta"]
				sort_order.index(state1.type_tag) < sort_order.index(state2.type_tag) ? -1 : 1
		}
		states_length = @states.length>0 ? @states.length : 1
		@buff_icons.bitmap = Bitmap.new(130, 27 * states_length)
		@buff_icons.bitmap.font.outline=false
		@buff_icon_rect_record = []
		@states.each_with_index{|state,index|
			case state.type_tag
				when "daily";			@buff_icons.bitmap.font.color=Color.new(20,255,255,255)
				when "green";			@buff_icons.bitmap.font.color=Color.new(10,255,10,255)
				when "yellow";			@buff_icons.bitmap.font.color=Color.new(255,255,0,255)
				when "red"	;			@buff_icons.bitmap.font.color=Color.new(255,30,30,255)
				when "magenta";			@buff_icons.bitmap.font.color=Color.new(255,0,255,255)
				else;break;
			end
			@buff_icons.bitmap.font.size=16
			draw_text_on_canvas(@buff_icons, 13+21, 27 * index-3, $game_text[state.name] ,true)
			@buff_icons.bitmap.font.size=12
			@buff_icons.bitmap.draw_text(0, 27 * index+ 11 , 123, 16, "stack : #{@actor.state_stack(state.id)}", 2)
			if state.icon_index.is_a?(String)
				@buff_icons.bitmap.blt(8, index*27, Cache.normal_bitmap(state.icon_index), Rect.new(0, 0, 24, 24))
			else
				@buff_icons.bitmap.blt(8, index*27, Cache.system("Iconset"), Rect.new(state.icon_index  % 16 * 24, state.icon_index / 16 * 24, 24, 24))
			end
			@buff_icon_rect_record << [@icon_viewport_default_x, @icon_viewport_default_y+27 * index, 123 , 32] if @buff_icon_rect_record.size < 11
		}
	end #refresh_buff_icons
  
	def refresh_buff_info
		return if @states.empty?
		return if !@states[@cursor_real_index]
		@reuqest_refresh_info_delay = 0
		@reuqest_refresh_info = false
		state = @states[@cursor_real_index]
		@buff_info.bitmap.dispose if @buff_info.bitmap
		@buff_info.bitmap = Bitmap.new(299,312)
		#title for info sector
		@buff_info.bitmap.font.size=16
		@buff_info.bitmap.font.outline=false
		draw_text_on_canvas(@buff_info,13, 13,$game_text[state.name])
		
		#content for info sector
		@buff_info.bitmap.font.size=13
		@buff_info.bitmap.font.outline=false
		draw_text_on_canvas(@buff_info,13, 33, $game_text[state.description])
	end
  
	def check_buff_effect_color(line)
		code = line.match(/\<([^\)]+)\>/i)
		if code.nil?
			return line
		else
			return line[code[1].size+2 .. -1]
		end
	end
  
  def dispose
	#@buff_icons.bitmap.dispose
	@buff_icons.dispose
	#@health_info.dispose #never used
	@buff_info.dispose
	@arrow_up.dispose
	@arrow_down.dispose
	@buff_layout.dispose	
	@buff_viewport.dispose
    @icon_viewport.dispose
	super
  end
  
  def new_line_x
	13
  end
  
end
