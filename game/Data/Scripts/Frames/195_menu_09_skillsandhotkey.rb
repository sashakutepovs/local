#==============================================================================
# This script is created by Kslander 
#==============================================================================
#==============================================================================
# ** Menu_SkillAndHotkey
#==============================================================================
class Menu_SkillAndHotkey < Menu_ContentBase

	def initialize
		super()
		@phase = 1 #1:none active #2 active #3 info page
		#@frozen_remaining = 30
		@reuqest_refresh_info_delay = 0
		@icon_viewport_default_x = 180
		@icon_viewport_default_y = 32
		@icon_viewport_default_w = 433
		@icon_viewport_default_h = 241
		@buffList_default_witdh = 130 #for mouse
		@buff_viewport = Viewport.new
		@buff_viewport.z =System_Settings::SCENE_Menu_Contents_Z
		@icon_viewport = Viewport.new(@icon_viewport_default_x, @icon_viewport_default_y, @icon_viewport_default_w, @icon_viewport_default_h)
		@icon_viewport.z =1+System_Settings::SCENE_Menu_Contents_Z
		@buff_layout = Sprite.new(@buff_viewport)
		@buff_layout.z =System_Settings::SCENE_Menu_Contents_Z
		@buff_layout.bitmap = Cache.load_bitmap(ROOT,"09skills/skills_layout")
		@buff_icons = Sprite.new(@icon_viewport)
		@buff_icons.x = 8
		@icon_dy = 0
		@buff_icons.z = 2+System_Settings::SCENE_Menu_Contents_Z
		
		#description text for skill
		@buff_info_viewport = Viewport.new(0, 32, 613, 241)
		@buff_info_viewport.z =System_Settings::SCENE_Menu_Contents_Z
		@buff_info = BuffInfo.new(@buff_info_viewport, self)
		@buff_info.bitmap = Bitmap.new(299,312)
		@buff_info.x, @buff_info.y = 314,0
		@buff_info.z = 3+System_Settings::SCENE_Menu_Contents_Z
		@buff_info_viewport.visible = false
		@buff_viewport.visible = false
		@icon_viewport.visible = false
		
		
		@skill_icons=Sprite.new(@buff_viewport)
		@skill_icons.bitmap= Bitmap.new(434,64)
		@skill_icons.x = 179
		@skill_icons.y = 290
		@skill_icons.z = 1+System_Settings::SCENE_Menu_Contents_Z
		icon1_x = 29 
		icon2_x = 69 
		icon3_x = 109
		icon4_x = 149
		icon5_x = 199
		icon6_x = 239
		icon7_x = 279
		icon8_x = 319
		icon9_x = 380
		@skill_icons.bitmap.font.size = 16
		@skill_icons.bitmap.font.outline = false
		@skill_icons.bitmap.font.bold = true
		@skill_icons.bitmap.font.color.set(255,255,50,255)
		@skill_icons.bitmap.draw_text(icon1_x, -1,24,24,InputUtils.getKeyAndTranslate(:S1),1)
		@skill_icons.bitmap.draw_text(icon2_x, -1,24,24,InputUtils.getKeyAndTranslate(:S2),1)
		@skill_icons.bitmap.draw_text(icon3_x, -1,24,24,InputUtils.getKeyAndTranslate(:S3),1)
		@skill_icons.bitmap.draw_text(icon4_x, -1,24,24,InputUtils.getKeyAndTranslate(:S4),1)
		@skill_icons.bitmap.draw_text(icon5_x, -1,24,24,InputUtils.getKeyAndTranslate(:S5),1)
		@skill_icons.bitmap.draw_text(icon6_x, -1,24,24,InputUtils.getKeyAndTranslate(:S6),1)
		@skill_icons.bitmap.draw_text(icon7_x, -1,24,24,InputUtils.getKeyAndTranslate(:S7),1)
		@skill_icons.bitmap.draw_text(icon8_x, -1,24,24,InputUtils.getKeyAndTranslate(:S8),1)
		@skill_icons.bitmap.draw_text(icon9_x, -1,24,24,InputUtils.getKeyAndTranslate(:S9),1)
		
	
		@skill_icons.bitmap.font.size = 16
		@skill_icons.bitmap.font.outline = true
		if WolfPad.plugged_in?
			tmpKey0= InputUtils.getKeyAndTranslateLong(:ALT) #setup
			tmpKey0_1 = " + #{$game_text["menu:skills/Key"]} = #{$game_text["menu:skills/hint_Setup"]}"
			tmpKey1= InputUtils.getKeyAndTranslateLong(:SHIFT) #cancel
			tmpKey1_1 = " + #{$game_text["menu:skills/Key"]} = #{$game_text["menu:skills/hint_Clear"]}"
			@skill_icons.bitmap.draw_text(157-70, 48,100,20,tmpKey0,1)
			@skill_icons.bitmap.draw_text(213-70, 48,200,20,tmpKey0_1,0)
			@skill_icons.bitmap.draw_text(275-70, 48,100,20,tmpKey1,2)
			@skill_icons.bitmap.draw_text(373-70, 48,200,20,tmpKey1_1,0)
		else
			tmpKey0 = "#{$game_text["menu:skills/Key"]} = #{$game_text["menu:skills/hint_Setup"]}"
			tmpKey1= InputUtils.getKeyAndTranslateLong(:SHIFT) #cancel
			tmpKey1_1 = " + #{$game_text["menu:skills/Key"]} = #{$game_text["menu:skills/hint_Clear"]}"
			@skill_icons.bitmap.draw_text(157-70, 48,200,20,tmpKey0,0)
			@skill_icons.bitmap.draw_text(275-70, 48,100,20,tmpKey1,2)
			@skill_icons.bitmap.draw_text(373-70, 48,200,20,tmpKey1_1,0)
		end
		
		redraw_hotkey_list
		@list_drawn = true
		@arrow_up = Sprite.new
		@arrow_down = Sprite.new
		@arrow_up.bitmap = @arrow_down.bitmap =Cache.load_bitmap(ROOT,"02Health_stats/scroll_arrow")
		@arrow_up.src_rect.width = @arrow_up.bitmap.width/2
		@arrow_down.src_rect.width = @arrow_up.src_rect.width
		@arrow_down.src_rect.x = @arrow_down.src_rect.width
		@arrow_up.x = @arrow_down.x = 237
		@arrow_up.y, @arrow_down.y = 15, 330
		@arrow_up.z = @arrow_down.z = 20+System_Settings::SCENE_Menu_Contents_Z
		@arrow_up.visible = @arrow_down.visible = false
		
		@cursor_display_index = @cursor_real_index = 0
		
		refresh
		hide
	end
	
	def update
		return if !@viewport.visible
		mouse_update_input
		return update_buff_info if @phase == 3
		if @phase == 2
			# only way I found how to stop entering skill menu and buff info at the same button press
			unless @frozen_remaining <= 0
				@frozen_remaining -= 1
			end
			return unless @frozen_remaining <= 0
			update_input
			update_icon_move
			update_arrow
		end
		update_skill_info
	end
	
	def update_buff_info
		@buff_info.update
		update_arrow_in_info_page
	end
	
	def update_skill_info
		#because skill page got few laggy. this is trying to fix the issue
		return if !@reuqest_refresh_info
		@reuqest_refresh_info_delay += 1
		refresh_skill_info if @reuqest_refresh_info_delay >= 5
	end
	
	def enter_buff_info
		@phase = 3
		@buff_info.enter_page
	end
	
	def exit_buff_info
		@phase = 2
		@buff_info.quit_page
	end
	
	def set_phase(tmpPhase)
		@phase = tmpPhase
	end
	
	
	def mouse_update_input
		return Mouse.ForceIdle if Input.MouseWheelForceIdle?
		return if !Mouse.enable?
		return exit_buff_info if Input.trigger?(:MX_LINK) && @phase == 3
		return back_to_mainmenu if Input.trigger?(:MX_LINK) && @phase == 2
		#p "Mouse.GetMouseXY #{Mouse.GetMouseXY}"
		tmpWithInSkilllArea = Mouse.within_XYWH?(181, 25, 130, 256)
		tmpWithInInfolArea = Mouse.within_XYWH?(315, 25, 299, 256)
		tmpWithInMainMenuArea = Mouse.within_XYWH?(0, 0, 156, 360)
		pressMZ = Input.trigger?(:MZ_LINK)
		return unless pressMZ || (Input.repeat?(:L) || Input.repeat?(:R))
		p "enter_page" if !tmpWithInMainMenuArea && @phase == 1
		p "exit_buff_info" if !tmpWithInInfolArea && @phase == 3
		p "enter_buff_info" if tmpWithInInfolArea && @phase != 3
		p "back_to_mainmenu" if tmpWithInMainMenuArea && @phase >= 2
		enter_page if !tmpWithInMainMenuArea && @phase == 1
		exit_buff_info if !tmpWithInInfolArea && @phase == 3
		enter_buff_info if tmpWithInInfolArea && @phase != 3
		back_to_mainmenu if tmpWithInMainMenuArea && @phase >= 2
		return if (Input.repeat?(:L) || Input.repeat?(:R)) && @phase == 2 #if in SkillList.  dont update below when PGUP and DOWN
		if @buff_icon_rect_record.size >= 1
			tmpProcessIndex = -1
			@buff_icon_rect_record.length.times {|i|
				next unless Mouse.within_XYWH?(@buff_icon_rect_record[i][0],@buff_icon_rect_record[i][1],@buff_icon_rect_record[i][2],@buff_icon_rect_record[i][3])
				tmpProcessIndex = i
			}
			if tmpProcessIndex >= 0
				@cursor_display_index = tmpProcessIndex
				@cursor_real_index = tmpProcessIndex + (@buff_icons.y/27).abs
				p "cursor_real_index =>#{@cursor_real_index}  buff_icons=>#{@buff_icons.y/27}"
				refresh_flag = true
				if refresh_flag
					@cursor.to_xy(160, 36 + @cursor_display_index * 27)
					@reuqest_refresh_info = true
					@reuqest_refresh_info_delay = 0
					return prev_skill_page if pressMZ && $data_skills[@skills[@cursor_real_index].id].item_name == "sys_PageDown"
					return next_skill_page if pressMZ && $data_skills[@skills[@cursor_real_index].id].item_name == "sys_PageUp"
					SndLib.play_cursor
				end
			end
		end
	end
	
	
	def update_input
		return prev_skill_page if (Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)) && $data_skills[@skills[@cursor_real_index].id].item_name == "sys_PageDown"
		return next_skill_page if (Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)) && $data_skills[@skills[@cursor_real_index].id].item_name == "sys_PageUp"
		return enter_buff_info	if (Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)) && !(WolfPad.press?(:ALT) || WolfPad.press?(:SHIFT) || WolfPad.press?(:CTRL) || Input.press?(:CTRL) || Input.press?(:SHIFT))
		return back_to_mainmenu if (Input.trigger?(:B) || WolfPad.trigger?(:X_LINK)) && !(WolfPad.press?(:ALT) || WolfPad.press?(:SHIFT) || WolfPad.press?(:CTRL) || Input.press?(:CTRL) || Input.press?(:SHIFT))
		currentReal_index = @cursor_real_index
		pageup = Input.repeat?(:L) && !Input.press?(:SHIFT) #up
		if Input.repeat?(:UP) || pageup
			d = pageup ? [-@cursor_real_index, -5].max : -1
			pageup
			refresh_flag = false
			if @cursor_real_index == 0
				############### move to bottom
				#@cursor_real_index = @skills.size - 1
				#@cursor_display_index = [@cursor_real_index, 8].min
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
				SndLib.play_cursor if currentReal_index != @cursor_real_index
				@cursor.to_xy(160, 36 + @cursor_display_index * 27)
				@reuqest_refresh_info = true
				@reuqest_refresh_info_delay = 0
			end
		end
		pagedown = Input.repeat?(:R) && !Input.press?(:SHIFT) #down
		if Input.repeat?(:DOWN) || pagedown
			d = pagedown ? [@skills.size - 1 - @cursor_real_index, 5].min : 1
			refresh_flag = false
			if @cursor_real_index == @skills.size - 1
				############# move to top
				#@cursor_real_index = 0
				#@cursor_display_index = 0
				#@icon_dy += @buff_icons.height - bound_height 
				#refresh_flag = true
				
			elsif @cursor_real_index+d >= @skills.size - 1
				############## stay in bot
				@cursor_real_index = @skills.size - 1
				@cursor_display_index = [@cursor_real_index, 8].min
				@icon_dy = 1
				refresh_flag = true
				
			elsif @cursor_real_index != @skills.size - 1
				new_real_index = [@cursor_real_index + d, @skills.size - 1].min
				new_display_index = [@cursor_display_index + d, 8, @skills.size - 1].min
				@icon_dy = 1
				@cursor_real_index = new_real_index
				@cursor_display_index = new_display_index
				refresh_flag = true
			end
			if refresh_flag
				SndLib.play_cursor if currentReal_index != @cursor_real_index
				@cursor.to_xy(160, 36 + @cursor_display_index * 27)
				@reuqest_refresh_info = true
				@reuqest_refresh_info_delay = 0
			end
		end
		update_skill_hotkey_input
		redraw_hotkey_list if @requestUpdateHotkeyIcons == true
	end
	def prev_skill_page
		@requestUpdateHotkeyIcons = true
		$game_player.update_GetPrevSkillRoster
		redraw_hotkey_list
	end
	def next_skill_page
		$game_player.update_GetNextSkillRoster
		@requestUpdateHotkeyIcons = true
		redraw_hotkey_list
	end
	def update_skill_hotkey_input
		if Input.repeat?(:L) && Input.press?(:SHIFT) #up
			prev_skill_page
		elsif Input.repeat?(:R) && Input.press?(:SHIFT) #down
			next_skill_page
		elsif Input.press?(:SHIFT)
			update_hotkey_unset_input
		elsif WolfPad.press?(:ALT)
			update_hotkey_set_input
		elsif !(WolfPad.press?(:S1) || WolfPad.press?(:S2) || WolfPad.press?(:S3) || WolfPad.press?(:S4) || WolfPad.press?(:S5) || WolfPad.press?(:S6) || WolfPad.press?(:S7) || WolfPad.press?(:S8) || WolfPad.press?(:S9))
			update_hotkey_set_input
		end
		#Input.press?(:SHIFT) ? update_hotkey_unset_input : update_hotkey_set_input
	end
	def update_hotkey_set_input
		return if pageSkills.any?{|skill| skill.item_name == @skills[@cursor_real_index].item_name}
		return ($game_player.setup_SkillRoster(tmpRoster=$game_player.slot_RosterCurrent,get_skill_id_with_sound(@cursor_real_index),:slot_skill_normal)	;$game_player.actor.skill_changed=true; @requestUpdateHotkeyIcons=true)		if Input.trigger?($game_player.hotkey_skill_normal	)
		return ($game_player.setup_SkillRoster(tmpRoster=$game_player.slot_RosterCurrent,get_skill_id_with_sound(@cursor_real_index),:slot_skill_heavy)		;$game_player.actor.skill_changed=true; @requestUpdateHotkeyIcons=true)		if Input.trigger?($game_player.hotkey_skill_heavy	)
		return ($game_player.setup_SkillRoster(tmpRoster=$game_player.slot_RosterCurrent,get_skill_id_with_sound(@cursor_real_index),:slot_skill_control)	;$game_player.actor.skill_changed=true; @requestUpdateHotkeyIcons=true)		if Input.trigger?($game_player.hotkey_skill_control	)
		return ($game_player.setup_SkillRoster(tmpRoster=$game_player.slot_RosterCurrent,get_skill_id_with_sound(@cursor_real_index),:slot_hotkey_0)		;$game_player.actor.skill_changed=true; @requestUpdateHotkeyIcons=true)		if Input.trigger?($game_player.skill_hotkey_0		)
		return ($game_player.setup_SkillRoster(tmpRoster=$game_player.slot_RosterCurrent,get_skill_id_with_sound(@cursor_real_index),:slot_hotkey_1)		;$game_player.actor.skill_changed=true; @requestUpdateHotkeyIcons=true)		if Input.trigger?($game_player.skill_hotkey_1		)
		return ($game_player.setup_SkillRoster(tmpRoster=$game_player.slot_RosterCurrent,get_skill_id_with_sound(@cursor_real_index),:slot_hotkey_2)		;$game_player.actor.skill_changed=true; @requestUpdateHotkeyIcons=true)		if Input.trigger?($game_player.skill_hotkey_2		)
		return ($game_player.setup_SkillRoster(tmpRoster=$game_player.slot_RosterCurrent,get_skill_id_with_sound(@cursor_real_index),:slot_hotkey_3)		;$game_player.actor.skill_changed=true; @requestUpdateHotkeyIcons=true)		if Input.trigger?($game_player.skill_hotkey_3		)
		return ($game_player.setup_SkillRoster(tmpRoster=$game_player.slot_RosterCurrent,get_skill_id_with_sound(@cursor_real_index),:slot_hotkey_4)		;$game_player.actor.skill_changed=true; @requestUpdateHotkeyIcons=true)		if Input.trigger?($game_player.skill_hotkey_4		)
		return ($game_player.setup_SkillRoster(tmpRoster=$game_player.slot_RosterCurrent,get_skill_id_with_sound(@cursor_real_index),:slot_hotkey_other)	;$game_player.actor.skill_changed=true; @requestUpdateHotkeyIcons=true)		if Input.trigger?($game_player.hotkey_other			)
	end
  
  
	def update_hotkey_unset_input
		return ($game_player.setup_SkillRoster(tmpRoster=$game_player.slot_RosterCurrent,nil,:slot_skill_normal)	;	$game_player.actor.skill_changed=true;	SndLib.sys_ok; @requestUpdateHotkeyIcons=true)		if Input.trigger?($game_player.hotkey_skill_normal	)
		return ($game_player.setup_SkillRoster(tmpRoster=$game_player.slot_RosterCurrent,nil,:slot_skill_heavy)		;	$game_player.actor.skill_changed=true;	SndLib.sys_ok; @requestUpdateHotkeyIcons=true)		if Input.trigger?($game_player.hotkey_skill_heavy	)
		return ($game_player.setup_SkillRoster(tmpRoster=$game_player.slot_RosterCurrent,nil,:slot_skill_control)	;	$game_player.actor.skill_changed=true;	SndLib.sys_ok; @requestUpdateHotkeyIcons=true)		if Input.trigger?($game_player.hotkey_skill_control ) 
		return ($game_player.setup_SkillRoster(tmpRoster=$game_player.slot_RosterCurrent,nil,:slot_hotkey_0)		;	$game_player.actor.skill_changed=true;	SndLib.sys_ok; @requestUpdateHotkeyIcons=true)		if Input.trigger?($game_player.skill_hotkey_0		)
		return ($game_player.setup_SkillRoster(tmpRoster=$game_player.slot_RosterCurrent,nil,:slot_hotkey_1)		;	$game_player.actor.skill_changed=true;	SndLib.sys_ok; @requestUpdateHotkeyIcons=true)		if Input.trigger?($game_player.skill_hotkey_1		)
		return ($game_player.setup_SkillRoster(tmpRoster=$game_player.slot_RosterCurrent,nil,:slot_hotkey_2)		;	$game_player.actor.skill_changed=true;	SndLib.sys_ok; @requestUpdateHotkeyIcons=true)		if Input.trigger?($game_player.skill_hotkey_2		)
		return ($game_player.setup_SkillRoster(tmpRoster=$game_player.slot_RosterCurrent,nil,:slot_hotkey_3)		;	$game_player.actor.skill_changed=true;	SndLib.sys_ok; @requestUpdateHotkeyIcons=true)		if Input.trigger?($game_player.skill_hotkey_3		)
		return ($game_player.setup_SkillRoster(tmpRoster=$game_player.slot_RosterCurrent,nil,:slot_hotkey_4)		;	$game_player.actor.skill_changed=true;	SndLib.sys_ok; @requestUpdateHotkeyIcons=true)		if Input.trigger?($game_player.skill_hotkey_4		)
		return ($game_player.setup_SkillRoster(tmpRoster=$game_player.slot_RosterCurrent,nil,:slot_hotkey_other)	;	$game_player.actor.skill_changed=true;	SndLib.sys_ok; @requestUpdateHotkeyIcons=true)		if Input.trigger?($game_player.hotkey_other         )
	end
  
  def get_skill_id_with_sound(current_index)
	SndLib.sys_ok
	@skills[@cursor_real_index].id
  end
  

   def redraw_hotkey_list
		current_skill_normal	=		$game_player.slot_skill_normal
		current_skill_heavy 	=		$game_player.slot_skill_heavy
		current_skill_control	=		$game_player.slot_skill_control
		current_skill_hotkey_0	=		$game_player.slot_hotkey_0
		current_skill_hotkey_1	=		$game_player.slot_hotkey_1
		current_skill_hotkey_2	=		$game_player.slot_hotkey_2
		current_skill_hotkey_3	=		$game_player.slot_hotkey_3
		current_skill_hotkey_4	=		$game_player.slot_hotkey_4
		current_skill_hotkey_other	=	$game_player.slot_hotkey_other
		
		tmpDrawSkill = !@list_drawn
		draw_hotkey_icon(0,$game_player.slot_skill_normal	,@prev_slot_skill_normal	== current_skill_normal			|| tmpDrawSkill || @requestUpdateHotkeyIcons)
		draw_hotkey_icon(1,$game_player.slot_skill_heavy	,@prev_slot_skill_heavy  	== current_skill_heavy			|| tmpDrawSkill || @requestUpdateHotkeyIcons)
		draw_hotkey_icon(2,$game_player.slot_skill_control	,@prev_slot_skill_control	== current_skill_control		|| tmpDrawSkill || @requestUpdateHotkeyIcons)
		draw_hotkey_icon(3,$game_player.slot_hotkey_0		,@prev_slot_skill_0			== current_skill_hotkey_0		|| tmpDrawSkill || @requestUpdateHotkeyIcons)
		draw_hotkey_icon(4,$game_player.slot_hotkey_1		,@prev_skill_slot_1 		== current_skill_hotkey_1		|| tmpDrawSkill || @requestUpdateHotkeyIcons)
		draw_hotkey_icon(5,$game_player.slot_hotkey_2		,@prev_skill_slot_2 		== current_skill_hotkey_2		|| tmpDrawSkill || @requestUpdateHotkeyIcons)
		draw_hotkey_icon(6,$game_player.slot_hotkey_3		,@prev_skill_slot_3 		== current_skill_hotkey_3		|| tmpDrawSkill || @requestUpdateHotkeyIcons)
		draw_hotkey_icon(7,$game_player.slot_hotkey_4		,@prev_skill_slot_4 		== current_skill_hotkey_4		|| tmpDrawSkill || @requestUpdateHotkeyIcons)
		draw_hotkey_icon(8,$game_player.slot_hotkey_other	,@prev_skill_slot_other		== current_skill_hotkey_other	|| tmpDrawSkill || @requestUpdateHotkeyIcons)
		
		@prev_slot_skill_normal		=$game_player.slot_skill_normal		if @prev_slot_skill_normal	!= current_skill_normal
		@prev_slot_skill_heavy		=$game_player.slot_skill_heavy		if @prev_slot_skill_heavy	!= current_skill_heavy
		@prev_slot_skill_control	=$game_player.slot_skill_control	if @prev_slot_skill_control != current_skill_control
		@prev_slot_skill_0			=$game_player.slot_hotkey_0        	 if @prev_slot_skill_0		!= current_skill_hotkey_0
		@prev_skill_slot_1			=$game_player.slot_hotkey_1        	 if @prev_skill_slot_1		!= current_skill_hotkey_1
		@prev_skill_slot_2			=$game_player.slot_hotkey_2        	 if @prev_skill_slot_2		!= current_skill_hotkey_2
		@prev_skill_slot_3			=$game_player.slot_hotkey_3        	 if @prev_skill_slot_3		!= current_skill_hotkey_3
		@prev_skill_slot_4			=$game_player.slot_hotkey_4        	 if @prev_skill_slot_4		!= current_skill_hotkey_4
		@prev_skill_slot_other		=$game_player.slot_hotkey_other   	 if @prev_skill_slot_other	!= current_skill_hotkey_other
		@requestUpdateHotkeyIcons = false
		
	end
   
	def draw_hotkey_icon(hotkey_slot,skill_id,tmpDrawSkill)
			skill=$data_skills[skill_id] unless skill_id.nil?
			case hotkey_slot
				when 0; icon_x = 29 ;	icon_y=19;	#A
				when 1; icon_x = 69 ;	icon_y=19;	#S
				when 2; icon_x = 109;	icon_y=19;	#D 
				when 3; icon_x = 149;	icon_y=19;	#F 
				when 4; icon_x = 199;	icon_y=19; 	#Q
				when 5; icon_x = 239;	icon_y=19; 	#W
				when 6; icon_x = 279;	icon_y=19; 	#E
				when 7; icon_x = 319;	icon_y=19; 	#R 
				when 8; icon_x = 380;	icon_y=19; 	#SPACE
			end
			@skill_icons.bitmap.clear_rect(icon_x,icon_y,24,24)
			tmpStringMode = false
			if !skill.nil? && tmpDrawSkill
				if skill.type == "QuickSlot"
					ext_CHK = skill.item_name[-1, 1].to_i - 1#"BasicQuickExt1" translate last string to number
					item = $data_ItemName[$game_player.actor.ext_items[ext_CHK]]
						if item != nil
							if item.icon_index.is_a?(String)
								icon_src_rect = Rect.new(0, 0, 24, 24)
								tmpStringMode = item.icon_index
							else
								icon_src_rect = Rect.new(item.icon_index % 16 * 24, item.icon_index / 16 * 24, 24, 24)
							end
						else
							if skill.icon_index.is_a?(String)
								icon_src_rect = Rect.new(0, 0, 24, 24)
								tmpStringMode = skill.icon_index
							else
								if real_skill_icon(skill).is_a?(String) #for mod api. basic skill icon_index may report as string.
									icon_src_rect = Rect.new(0, 0, 24, 24)
									tmpStringMode = real_skill_icon(skill)
								else
									icon_src_rect = Rect.new(real_skill_icon(skill) % 16 * 24, real_skill_icon(skill) / 16 * 24, 24, 24)
								end
							end
						end
				else
					if skill.icon_index.is_a?(String)
						icon_src_rect = Rect.new(0, 0, 24, 24)
						tmpStringMode = skill.icon_index
					else
						if real_skill_icon(skill).is_a?(String) #for mod api. basic skill icon_index may report as string.
							icon_src_rect = Rect.new(0, 0, 24, 24)
							tmpStringMode = real_skill_icon(skill)
						else
							icon_src_rect = Rect.new(real_skill_icon(skill) % 16 * 24, real_skill_icon(skill) / 16 * 24, 24, 24)
						end
					end
				end
				@skill_icons.bitmap.blt(icon_x,icon_y,Cache.system("Iconset"),icon_src_rect)
			end
		#draw roster num
		rosterIcon = 641+$game_player.slot_RosterCurrent
		roster_src_rect = Rect.new(rosterIcon % 16 * 24, rosterIcon / 16 * 24, 24, 24)
		if tmpStringMode
			@skill_icons.bitmap.blt(icon_x, icon_y, Cache.normal_bitmap(tmpStringMode), icon_src_rect)
		else
			@skill_icons.bitmap.blt(icon_x,icon_y,Cache.system("Iconset"),roster_src_rect)
		end
	end
  
				
				
				
  
	def update_icon_move
		return if @icon_dy == 0
		@buff_icons.y = [(@cursor_real_index-8),0].max * -27 if @cursor_display_index >= 8
		@buff_icons.y = [(@cursor_real_index),0].max * -27 if @cursor_display_index <= 0
		@icon_dy = 0
		
		#return if @buff_icons.height <= bound_height
		#v = @icon_dy.abs > 50 ? 20 : 5
		#v = @icon_dy.abs > v ? (@icon_dy > 0 ? v : -v) : @icon_dy
		#@buff_icons.y += v
		#@icon_dy -= v
	end
	

	def update_arrow_in_info_page
		return if @phase != 3
		@arrow_up.x = @arrow_down.x = 237+218
		@arrow_up.visible = @arrow_down.visible = true
		
	end
	
	def update_arrow
		return @arrow_up.visible = @arrow_down.visible = false if @phase != 2
		@arrow_up.visible = @cursor_real_index > @cursor_display_index
		@arrow_down.visible = @cursor_real_index + 8 - @cursor_display_index < @skills.size - 1
		@arrow_up.y = 15 - Graphics.frame_count%60/20 if @arrow_up.visible
		@arrow_down.y = 274 + Graphics.frame_count%60/20 if @arrow_down.visible
		@arrow_up.x = @arrow_down.x = 237
	end
  
	def show
		super
		@buff_viewport.visible = true
		@icon_viewport.visible = true
		@buff_info_viewport.visible = true
		refresh
	end
  
	def hide
		super
		@buff_viewport.visible = false
		@icon_viewport.visible = false
		@buff_info_viewport.visible = false
		@arrow_up.visible = @arrow_down.visible = false
	end
  
	def enter_page
		return @menu.activate if @skills.empty?
		SndLib.sys_ok
		@phase=2
		@frozen_remaining = 30
		@icon_dy += -@buff_icons.y if @buff_icons.y!=0
		#@cursor_real_index = @cursor_display_index = 0
		@cursor.to_xy(160, 36 + @cursor_display_index * 27)
		exit_buff_info if @phase == 3
		refresh_skill_info
	end
  
	def back_to_mainmenu
		@arrow_up.visible = @arrow_down.visible = false
		exit_buff_info if @phase == 3
		SndLib.sys_cancel
		@phase = 1
		@menu.activate
	end
	
  def refresh
    refresh_skill_icons
  end
	def pageSkills
		pageSkills=$data_skills.select{|skill|skill && skill.type.eql?("Page")}
		pageSkills
	end
	

	def refresh_skill_icons
		@buff_icons.bitmap.dispose if @buff_icons.bitmap
		sys_skills = @actor.usable_skills.select{|skill|skill.type.eql?("other")}
		ext_quickslots=@actor.usable_skills.select{|skill|skill.type.eql?("QuickSlot")}
		hotKeySkills=[$data_skills[101],$data_skills[102],$data_skills[103]]
		@skills=hotKeySkills + sys_skills + ext_quickslots + pageSkills
		@buff_icons.bitmap = Bitmap.new(130, 27 * @skills.length)
		@last_icon_index = @skills.size % 9
		@buff_icons.bitmap.font.size=16
		@buff_icons.bitmap.font.outline=false
		@buff_icons.bitmap.font.color.set(Color.new(255,255,0)) #417 COLOR
		@buff_icon_rect_record = []
		for index in 0...@skills.length
			skill=@skills[index]
			icon_index = real_skill_icon(skill);
			@buff_icon_rect_record << [@icon_viewport_default_x, @icon_viewport_default_y+27 * index, 123 , 32] if @buff_icon_rect_record.size < 9
			if skill.item_name == "sys_normal"
				equip_icon_index = getPlayerEquipIcon(0);
				if icon_index.is_a?(String)
					@buff_icons.bitmap.blt(0, index*27, Cache.normal_bitmap(icon_index), Rect.new(0, 0, 24, 24))
					if equip_icon_index.is_a?(String)
						@buff_icons.bitmap.blt(24, index*27, Cache.normal_bitmap(equip_icon_index), Rect.new(0, 0, 24, 24))
					else
						@buff_icons.bitmap.blt(24, index*27, Cache.system("Iconset"), Rect.new(equip_icon_index % 16 * 24, equip_icon_index / 16 * 24, 24, 24))
					end
					draw_text_on_canvas(@buff_icons, 5+21+24, 27 * index, $game_text[skill.name] ,true)
				else
					@buff_icons.bitmap.blt(0, index*27, Cache.system("Iconset"), Rect.new(icon_index  % 16 * 24, icon_index / 16 * 24, 24, 24))
					if equip_icon_index.is_a?(String)
						@buff_icons.bitmap.blt(24, index*27, Cache.normal_bitmap(equip_icon_index), Rect.new(0, 0, 24, 24))
					else
						@buff_icons.bitmap.blt(24, index*27, Cache.system("Iconset"), Rect.new(equip_icon_index % 16 * 24, equip_icon_index / 16 * 24, 24, 24))
					end
					draw_text_on_canvas(@buff_icons, 5+21+24, 27 * index, $game_text[skill.name] ,true)
				end
			elsif skill.item_name == "sys_heavy"
				equip_icon_index = getPlayerEquipIcon(1);
				if icon_index.is_a?(String)
					@buff_icons.bitmap.blt(0, index*27, Cache.normal_bitmap(icon_index), Rect.new(0, 0, 24, 24))
					if equip_icon_index.is_a?(String)
						@buff_icons.bitmap.blt(24, index*27, Cache.normal_bitmap(equip_icon_index), Rect.new(0, 0, 24, 24))
					else
						@buff_icons.bitmap.blt(24, index*27, Cache.system("Iconset"), Rect.new(equip_icon_index % 16 * 24, equip_icon_index / 16 * 24, 24, 24))
					end
					draw_text_on_canvas(@buff_icons, 5+21+24, 27 * index, $game_text[skill.name] ,true)
				else
					@buff_icons.bitmap.blt(0, index*27, Cache.system("Iconset"), Rect.new(icon_index  % 16 * 24, icon_index / 16 * 24, 24, 24))
					if equip_icon_index.is_a?(String)
						@buff_icons.bitmap.blt(24, index*27, Cache.normal_bitmap(equip_icon_index), Rect.new(0, 0, 24, 24))
					else
						@buff_icons.bitmap.blt(24, index*27, Cache.system("Iconset"), Rect.new(equip_icon_index % 16 * 24, equip_icon_index / 16 * 24, 24, 24))
					end
					draw_text_on_canvas(@buff_icons, 5+21+24, 27 * index, $game_text[skill.name] ,true)
				end
			elsif skill.item_name == "sys_control"
				equip_icon_index = getPlayerEquipIcon(1);
				if icon_index.is_a?(String)
					@buff_icons.bitmap.blt(0, index*27, Cache.normal_bitmap(icon_index), Rect.new(0, 0, 24, 24))
					if equip_icon_index.is_a?(String)
						@buff_icons.bitmap.blt(24, index*27, Cache.normal_bitmap(equip_icon_index), Rect.new(0, 0, 24, 24))
					else
						@buff_icons.bitmap.blt(24, index*27, Cache.system("Iconset"), Rect.new(equip_icon_index % 16 * 24, equip_icon_index / 16 * 24, 24, 24))
					end
				else
					@buff_icons.bitmap.blt(0, index*27, Cache.system("Iconset"), Rect.new(icon_index  % 16 * 24, icon_index / 16 * 24, 24, 24))
					if equip_icon_index.is_a?(String)
						@buff_icons.bitmap.blt(24, index*27, Cache.normal_bitmap(equip_icon_index), Rect.new(0, 0, 24, 24))
					else
						@buff_icons.bitmap.blt(24, index*27, Cache.system("Iconset"), Rect.new(equip_icon_index % 16 * 24, equip_icon_index / 16 * 24, 24, 24))
					end
				end
				draw_text_on_canvas(@buff_icons, 5+21+24, 27 * index, $game_text[skill.name] ,true)
			else
				draw_text_on_canvas(@buff_icons, 5+21, 27 * index, $game_text[skill.name] ,true)
				if icon_index.is_a?(String)
					@buff_icons.bitmap.blt(0, index*27, Cache.normal_bitmap(icon_index), Rect.new(0, 0, 24, 24))
				else
					@buff_icons.bitmap.blt(0, index*27, Cache.system("Iconset"), Rect.new(icon_index  % 16 * 24, icon_index / 16 * 24, 24, 24))
				end
			end
		end
	end #refresh_skill_icons
	

	def real_skill_icon(skill)
		return 0 if !skill
		return skill.icon_index if !["sys_normal","sys_heavy","sys_control"].include?(skill.item_name)
		skill = $game_player.actor.get_system_skill(skill)
		return skill.nil? ? 0 : skill.icon_index
	end
	def getPlayerEquipIcon(slot=0)
		return $game_player.actor.equips[0].icon_index if slot == 1 && $game_player.actor.equips[1].nil? && !$game_player.actor.equips[0].nil? && $game_player.actor.equips[0].type_tag == "Equip2H"	#if 2hand equiped
		return 0 if $game_player.actor.equips[slot].nil?
		$game_player.actor.equips[slot].icon_index
	end
	def refresh_skill_info
		@reuqest_refresh_info = false
		@reuqest_refresh_info_delay = 0
		skill = @skills.shift until skill.nil?
		skill = @skills[@cursor_real_index]
		skill = system_skill?(skill.item_name) ? get_system_skill(skill) : @skills[@cursor_real_index]
		@buff_info.bitmap.dispose if @buff_info.bitmap
		@buff_info.bitmap = Bitmap.new(299,312)
		@buff_info.bitmap.font.size=16
		@buff_info.bitmap.font.outline=false
		draw_text_on_canvas(@buff_info,13, 13,$game_text[skill.name])
		@buff_info.bitmap.font.size=13
		@buff_info.bitmap.font.outline=false
		draw_text_on_canvas(@buff_info,13, 33,find_and_eval_interpolations($game_text[skill.description]))
	end

  #control,heavy,normal
	def system_skill?(skill_item_name)
		["sys_normal","sys_heavy","sys_control"].include?(skill_item_name)
	end
  
  def get_system_skill(skill)
	case skill.item_name
		when "sys_normal";tag="normal"
		when "sys_heavy";tag="heavy"
		when "sys_control";tag="control"
	end
	sys_skill=$game_actors[1].usable_skills.select{
			|skill|
			skill.type.eql?(tag)
			}[0]		
	return skill if sys_skill.nil?
	sys_skill
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
	@buff_layout.dispose #use chached bitmap
	@buff_icons.bitmap.dispose
	@buff_icons.dispose
	@buff_info.bitmap.dispose
	@buff_info.dispose
	@skill_icons.bitmap.dispose
	@skill_icons.dispose
	@arrow_up.dispose #use cached bitmap
	@arrow_down.dispose #use cached bitmap
	
    @buff_viewport.dispose
    @icon_viewport.dispose
	@buff_info_viewport.dispose
	super
  end
  
  def new_line_x
	13
  end
  
  def bound_height
	243
  end
  
  def visible_icon_height
	27* 9
  end
  
  def last_icon_index
	@last_icon_index
  end
  
  
end

class BuffInfo < Sprite
	attr_reader :active

	def initialize(viewport, skill_menu)
		super(viewport)
		@skill_menu = skill_menu
		@scroll_amt = 0
		@active = false
	end

	def update
		return unless @active
		update_input
		update_content_scroll
	end
	
	def update_input
		return quit_page			if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK)
		return scroll_up			if Input.repeat?(:UP)   || Input.repeat?(:L)
		return scroll_down			if Input.repeat?(:DOWN) || Input.repeat?(:R)
	end
	
	def update_content_scroll
		return if @scroll_amt == 0
		amt_abs=@scroll_amt.abs
		v = 15
		v = amt_abs > 120 ? v : v/2
		v = amt_abs > v.abs ? v : amt_abs
		v = @scroll_amt > 0 ? v : -v
		self.y += v
		@scroll_amt -= v
	end

	def scroll_up
		return if self.y + @scroll_amt >=0
		@scroll_amt += 30
	end

	def scroll_down
		return if self.y + @scroll_amt <= @content_bottom
		@scroll_amt += -30
	end

	def enter_page
		SndLib.sys_DialogNarr(80)
		@content_bottom = -1 * (self.bitmap.height - self.viewport.rect.height) 
		@scroll_amt = 0
		self.y = 0
		@active = true
	end

	def quit_page
		SndLib.sys_DialogNarrClose(80)
		@content_bottom = -1
		@scroll_amt = 0
		self.y = 0
		@active = false
		@skill_menu.set_phase(2)
	end
	
	
	
end
