#class Scene_RebirthOptions < Scene_Map
class Scene_RebirthOptions < Scene_Base

	def start
		super
		@background_sprite = Sprite.new
		@background_sprite.bitmap = Cache.load_bitmap("Graphics/System/TitleScreen/","titleOptBg")
		@background_sprite.z = System_Settings::TITLE_COMMAND_WINDOW_Z-1
		@menu = RebirthOptionMenu.new
		
		$hudForceHide = true
		$balloonForceHide = true
		#$game_portraits.lprt.hide
		#$game_portraits.rprt.hide
		#$game_player.force_update = false
		#$game_system.menu_disabled = true
		#$game_pause = true
	end

	def update
		super
		refresh_menu
	end

	def terminate
		super
		@background_sprite.dispose
		@menu.dispose
		#$game_pause = false
		#$hudForceHide = false
		#$balloonForceHide = false
		#$game_player.force_update = true
		#$game_system.menu_disabled = false
	end



	def dispose_background
		@background_sprite.dispose
	end
	

	def refresh_menu
		if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK) || Input.trigger?(:MX_LINK)
			SndLib.sys_cancel
			return SceneManager.goto(Scene_Map)
		end
		@menu.update
	end
end

#-------------------------------------------------------------------------------
# * Graphics Menu
#-------------------------------------------------------------------------------

class RebirthOptionMenu < OptionMenu
	def initialize_options
		reroll_sensitivity
		reroll_reBirthStates
		draw_expWarning
		$inheritance["rebirthData"]["remember_bank"] = true
		$inheritance["rebirthData"]["remember_exp"] = true
		$inheritance["rebirthData"]["remember_sex_rec"] = false
		buildOptions(:reroll,			$game_text["menu:system/reset"], "",[""])
		buildOptions(:remember_bank,	$game_text["menu:system/remember_bank"], 	$inheritance["rebirthData"]["remember_bank"],				[true,false])
		buildOptions(:remember_exp,		$game_text["menu:system/remember_exp"], 	$inheritance["rebirthData"]["remember_exp"],				[true,false])
		buildOptions(:remember_sex_rec,	$game_text["menu:system/remember_sex_rec"],		$inheritance["rebirthData"]["remember_sex_rec"],			[true,false])
		buildOptions(:sen_vag,			$game_text["menu:sex_stats/sensitivity_vag"],		$inheritance["rebirthData"]["sensitivity_basic_vag"], 			@sen_v_ary)
		buildOptions(:sen_anal,			$game_text["menu:sex_stats/sensitivity_anal"],		$inheritance["rebirthData"]["sensitivity_basic_anal"], 			@sen_a_ary)
		buildOptions(:sen_mouth,		$game_text["menu:sex_stats/sensitivity_mouth"],		$inheritance["rebirthData"]["sensitivity_basic_mouth"],			@sen_m_ary)
		buildOptions(:sen_breast,		$game_text["menu:sex_stats/sensitivity_breast"],	$inheritance["rebirthData"]["sensitivity_basic_breast"], 		@sen_b_ary)
		@opts_length = @optNames.keys.length if !@opts_length #to get state icon Y
		draw_state_icons
	end

	def reroll_reBirthStates
		$game_player.actor.reBirthReroll_state
	end
	def reroll_sensitivity
		$game_player.actor.reBirthReroll_sensitivity
		@sen_v_ary = ($inheritance["rebirthData"]["sensitivity_basic_vag"]..15).to_a
		@sen_a_ary = ($inheritance["rebirthData"]["sensitivity_basic_anal"]..15).to_a
		@sen_m_ary = ($inheritance["rebirthData"]["sensitivity_basic_mouth"]..15).to_a
		@sen_b_ary = ($inheritance["rebirthData"]["sensitivity_basic_breast"]..15).to_a
	end
	def setOPT(setting, value)
		case setting
			when :remember_sex_rec; remember_sex_rec_opt_handler(value)
			when :remember_bank; remember_bank_opt_handler(value)
			when :remember_exp; remember_exp_opt_handler(value)

			when :reroll; reroll_opt_handler(value)
			when :rollSaveSlot; rollSaveSlot_opt_handler(value)
			when :sen_vag; sen_vag_opt_handler(value)
			when :sen_anal; sen_anal_opt_handler(value)
			when :sen_mouth; sen_mouth_opt_handler(value)
			when :sen_breast; sen_breast_opt_handler(value)
		end
	end
	
	def refreshBuildOptions(key, name, default, options)
		@optSymbol[key] = key
		@optNames[key] = name
		@optSettings[key] = default
		@optOptions[key] = options
	end
	
	def rollSaveSlot_opt_handler(value)
		return if @onBegin == true
	end
	def reroll_opt_handler(value)
		return if @onBegin == true
		$inheritance["Exp"] = 0 if !$inheritance["Exp"]
		exp_cost = [($inheritance["Exp"]*0.02),20000].max.round
		if exp_cost > $inheritance["Exp"]
			draw_expCost(exp_cost)
			return SndLib.sys_buzzer
		end
		SndLib.sys_CoinsFalling
		$inheritance["Exp"] -= exp_cost
		draw_expWarning
		draw_expCost(exp_cost)
		reroll_sensitivity
		reroll_reBirthStates
		draw_state_icons
		refreshBuildOptions(:sen_vag,	$game_text["menu:sex_stats/sensitivity_vag"],		$inheritance["rebirthData"]["sensitivity_basic_vag"], 			@sen_v_ary)
		refreshBuildOptions(:sen_anal,	$game_text["menu:sex_stats/sensitivity_anal"],		$inheritance["rebirthData"]["sensitivity_basic_anal"],			@sen_a_ary)
		refreshBuildOptions(:sen_mouth,	$game_text["menu:sex_stats/sensitivity_mouth"],		$inheritance["rebirthData"]["sensitivity_basic_mouth"], 		@sen_m_ary)
		refreshBuildOptions(:sen_breast,$game_text["menu:sex_stats/sensitivity_breast"],	$inheritance["rebirthData"]["sensitivity_basic_breast"], 		@sen_b_ary)
		
		clear_item(@index+1)
		clear_item(@index+2)
		clear_item(@index+3)
		clear_item(@index+4)
		draw_item(@index+1)
		draw_item(@index+2)
		draw_item(@index+3)
		draw_item(@index+4)
		p $inheritance["rebirthData"]
		p $inheritance["rebirthStateData"]
	end
	def remember_sex_rec_opt_handler(value)
		return if @onBegin == true
		$inheritance["rebirthData"]["remember_sex_rec"] = value
	end

	def remember_bank_opt_handler(value)
		return if @onBegin == true
		$inheritance["rebirthData"]["remember_bank"] = value
	end

	def remember_exp_opt_handler(value)
		return if @onBegin == true
		$inheritance["rebirthData"]["remember_exp"] = value
	end

	def sen_vag_opt_handler(value)
		return if @onBegin == true
		$inheritance["rebirthData"]["sensitivity_basic_vag"] = value
	end
	
	def sen_anal_opt_handler(value)
		return if @onBegin == true
		$inheritance["rebirthData"]["sensitivity_basic_anal"] = value
	end
	
	def sen_mouth_opt_handler(value)
		return if @onBegin == true
		$inheritance["rebirthData"]["sensitivity_basic_mouth"] = value
	end
	
	def sen_breast_opt_handler(value)
		return if @onBegin == true
		$inheritance["rebirthData"]["sensitivity_basic_breast"] = value
	end
	
	def update
		if @expCostWarning && @expCostWarning.opacity >= 0
			@expCostWarning.y -= 1
			@expCostWarning.opacity -= 5
		end
		refresh_index(@index + 1) if Input.trigger?(:DOWN)
		refresh_index(@index - 1) if Input.trigger?(:UP)
		next_option if Input.trigger?(:C) && @optSettings[@items[@index]] == ""
		next_option if @optSettings[@items[@index]] == "" && Input.trigger?(:RIGHT) || Input.trigger?(:C) || WolfPad.trigger?(:Z_LINK)
		previous_option if @optSettings[@items[@index]] == "" && Input.trigger?(:LEFT)
		update_arrows
		mouse_input_check
	end
	
	
	def dispose
		@state_icons.dispose if @expCurrentWarning
		@expCurrentWarning.dispose if @expCurrentWarning
		@expCostWarning.dispose if @expCostWarning
		super
	end
	
	
	def draw_title
		self.bitmap.font.size = System_Settings::FONT_SIZE::SCENE_REBIRTH_TITLE
		self.bitmap.draw_text(40,20,Graphics.width,32,$game_text["menu:sex_stats/record_Rebirth"],0)
		self.bitmap.font.size = System_Settings::FONT_SIZE::SCENE_REBIRTH_OPTIONS
	end
	
	def draw_expWarning
		@expCurrentWarning.dispose if @expCurrentWarning
		@expCurrentWarning = Sprite.new
		@expCurrentWarning.z = self.z+1
		@expCurrentWarning.y = @yFix
		@expCurrentWarning.x = -40
		@expCurrentWarning.bitmap = Bitmap.new(Graphics.width,60)
		@expCurrentWarning.bitmap.font.size = System_Settings::FONT_SIZE::SCENE_REBIRTH_EXP_WARNING
		@expCurrentWarning.bitmap.font.bold = false
		@expCurrentWarning.bitmap.font.outline = false
		@expCurrentWarning.bitmap.draw_text(0,0,Graphics.width-20,32,"EXP:#{$inheritance["Exp"]}",2)
	end
	def draw_expCost(exp_cost)
		@expCostWarning.dispose if @expCostWarning
		@expCostWarning = Sprite.new
		@expCostWarning.z = self.z+1
		@expCostWarning.y = @yFix
		@expCostWarning.x = -40
		@expCostWarning.bitmap = Bitmap.new(Graphics.width,60)
		@expCostWarning.bitmap.font.size = System_Settings::FONT_SIZE::SCENE_REBIRTH_EXP_COST
		@expCostWarning.bitmap.font.bold = false
		@expCostWarning.bitmap.font.outline = false
		@expCostWarning.bitmap.draw_text(0,0,Graphics.width-20,32,"-#{exp_cost}",2)
	end
	def draw_state_icons
		@state_icons.dispose if @state_icons
		@state_icons = Sprite.new
		@state_icons.z = self.z+2
		#@state_icons.y = (Graphics.height-Graphics.height/3).round
		@state_icons.y = @yFix+@indexStartY+(@indexEachY*@opts_length)
		@state_icons.x = 0
		#tmpXfix = (Graphics.width/6).round
		iconWindowPosW = 1+$inheritance["rebirthStateData"].size*27
		#@state_icons.x = iconWindowPosW2+20
		
		
		window_size = [Graphics.width, Graphics.height]
		obj_size = [iconWindowPosW, 60]
		center_x = window_size[0] / 2
		center_y = window_size[1] / 2
		@state_icons.bitmap = Bitmap.new(iconWindowPosW,60)
		@state_icons.x = center_x - obj_size[0] / 2
		
		
		
		
		#@state_icons.bitmap.fill_rect(@state_icons.bitmap.rect,Color.new(0,255,0,255))
		
		sort_index = 0
		$inheritance["rebirthStateData"].each{|stateName|
			draw_state_icon($data_StateName[stateName[0]].icon_index,tmpLVL=stateName[1],sort_index,@state_icons.bitmap.rect)
			sort_index += 1
		}
	end
	def draw_state_icon(icon_index,tmpLVL,sort_index,rect)
		if icon_index.is_a?(String)
			cachedBitmapICON = Cache.normal_bitmap(icon_index)
		else
			cachedBitmapICON = Cache.system("Iconset")
		end
		numIcon = Graphics.width + tmpLVL
		icon_src_rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
		@state_icons.bitmap.blt(sort_index * 27 , 0 ,cachedBitmapICON , icon_src_rect) if icon_index !=-1
		if tmpLVL >= 2
			icon_src_rect = Rect.new(numIcon % 16 * 24, numIcon / 16 * 24, 24, 24)
			@state_icons.bitmap.blt(sort_index * 27 , 0 ,cachedBitmapICON , icon_src_rect)
		end
	end
	
end
