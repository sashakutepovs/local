
#==============================================================================
# ** Map_Hud
#==============================================================================

class Map_Hud
	def initialize
		@actor = $game_player.actor
		@player = $game_player
		@viewport = Viewport.new
		@viewport.z = System_Settings::MAP_HUD_Z
		setting = [ 
		["Layout",				18,		13],			
		["Lona_Face",			18,		13],
		["MOOD_Meter",			40,		14],
		["MOOD_Meter",			40,		14],
		["LV_Meter",			19,		35],
		["health_Number",		37,		40],
		["health_Number",		37,		54],
		["health_Number",		37,		68],
		#["Sight_Icon",			20,		86],
		#["Small_Number",		36,		88],
		["Combat_Icon",			20,		99],
		#["Small_Number",		36,		101],
		["Carrying_Layout",		20,		340],
		["Small_Number",		36,		342],
		["Resource_Layout",		20,		327],
		["Small_Number",		36,		328],
		["Drug_Layout",			607,	276],
		["Small_Number",		590,	277],
		["Semen_Layout",		607,	289],
		["Small_Number",		590,	290],
		["Defecation_Layout",	607,	302],
		["Small_Number",		590,	303],
		["Lactation_Layout",	607,	315],
		["Small_Number",		590,	316],
		["Micturition_Layout",	607,	328],
		["Small_Number",		590,	329],
		["Arousal_layout",		607,	341],
		["Small_Number",		590,	342],
		#mod
		["Wound_Stats",			607,	13],
		["wound_head",			607,	13],
		["wound_chest",			607,	13],
		["wound_Cuff",			607,	13],
		["wound_sarm",			607,	13],
		["wound_marm",			607,	13],
		["wound_Collar",		607,	13],
		["wound_belly",			607,	13],
		["wound_groin",			607,	13],
		["wound_mthigh",		607,	13],
		["wound_sthigh",		607,	13],
		#mod
		["hotkey_asdf",			120,	333],
		["hotkey_qwer",			416,	333],
		["battle_sex_ux",		120,	333],
		["X_Layout",			88,		340],
		["Small_Number",		104,	342],
		["Y_Layout",			138,	340],
		["Small_Number",		154,	342],
		["Time_Layout",			188,	340],
		["Small_Number",		204,	342],
		#["Encounter_Layout",	450,	340],
		#["Small_Number",		433,	342],
		#["WildDangerous_Layout",500,	340],
		#["Small_Number",		483,	342],
		["WorldDifficulty_Layout",550,	340],
		["Small_Number",		533,	342]
		#["Mail_Layout",			610,	7] mod, useless and removed
		]
		@list = [	:layout,
					:face,
					:mood_meter,
					:mood_meter_back,
					:exp_meter,
					:health_number,
					:sta_number,
					:sat_number,
					#:sight_icon,
					#:scoutcraft_number,		#非戰鬥狀態不顯示
					:combat_icon,			#若有事野 則1 若為戰鬥 則2 以上皆非 則不顯示(0)
					#:move_speed_number,	#非戰鬥狀態不顯示
					:carrying_layout,
					:weight_number,
					:resource_layout,
					:resource_number,
					:drug_layout,
					:drug_number,
					:semen_layout,
					:semen_number,
					:defecation_layout,	
					:defecation_number,	
					:lactation_layout,
					:lactation_number,	
					:micturition_layout,
					:micturition_number,
					:arousal_layout,
					:arousal_number,
					#mod
					:wound_layout,
					:wound_head,
					:wound_chest,
					:wound_Cuff,
					:wound_sarm,
					:wound_marm,
					:wound_Collar,
					:wound_belly,
					:wound_groin,
					:wound_mthigh,
					:wound_sthigh,
					#mod
					:hotkey_asdf,
					:hotkey_qwer,
					:battle_sex_ux,
					:x_layout,
					:x_number,
					:y_layout,
					:y_number,
					:time_layout,
					:time_number,
					#:encounter_layout,
					#:encounter_number,
					#:dangerous_layout,
					#:dangerous_number,
					:difficulty_layout,
					:difficulty_number
					#:mail_layout mod, useless and removed
				].collect{
					|i| 
						instance_variable_set("@#{i}", Sprite.new(@viewport))
				}
		@list.each_with_index do |sprite, index|
			sprite.bitmap = Bitmap.new("#{System_Settings::MAP_HUD_FOLDER}#{setting[index][0]}")
			sprite.x = setting[index][1]
			sprite.y = setting[index][2]
		end

		#mod, wounds initialize 
		@wound_layout.src_rect = Rect.new(0, 0, 15, 26)
		@wound_layout.z = @wound_layout.z-1
		@wound_Cuff.z = @wound_Cuff.z+1
		@wound_Collar.z = @wound_Collar.z+1
		@total_wounds=refresh_wound_total
		@wound_head.src_rect = Rect.new(0, [26*(@actor.stat["WoundHead"]-1),52].min, 15, 26)
		@wound_chest.src_rect = Rect.new(0, 26*(@actor.stat["WoundChest"]-1), 15, 26)
		@wound_Cuff.src_rect = Rect.new(0, 0, 15, 26)
		@wound_sarm.src_rect = Rect.new(0, 26*(@actor.stat["WoundSArm"]-1), 15, 26)
		@wound_marm.src_rect = Rect.new(0, [26*(@actor.stat["WoundMArm"]-1),52].min, 15, 26)
		@wound_Collar.src_rect = Rect.new(0, 0, 15, 26)
		@wound_belly.src_rect = Rect.new(0, 26*(@actor.stat["WoundBelly"]-1), 15, 26)
		@wound_groin.src_rect = Rect.new(0, 26*(@actor.stat["WoundGroin"]-1), 15, 26)
		@wound_mthigh.src_rect = Rect.new(0, 26*(@actor.stat["WoundMThigh"]-1), 15, 26)
		@wound_sthigh.src_rect = Rect.new(0, 26*(@actor.stat["WoundSThigh"]-1), 15, 26)
		@actor.stat["WoundCuff"] >=1 ? @wound_Cuff.opacity = 255 : @wound_Cuff.opacity = 0
		@actor.stat["WoundCollar"] >=1 ? @wound_Collar.opacity = 255 : @wound_Collar.opacity = 0
		#rect for face
		@face.src_rect.width = @face.bitmap.width/8
		@mood_meter.src_rect.width = @mood_meter.bitmap.width/8
		@mood_meter.z = 1
		@mood_meter_back.src_rect.width = @mood_meter.src_rect.width

		# rects for health/sta/sat numbers
		@number_bmp = Bitmap.new("#{System_Settings::MAP_HUD_FOLDER}health_Number")
		w = @number_bmp.width/10
		@number_rect = {}
		(0..9).each {|num|
		@number_rect[num] = Rect.new(w * num, 0, w, @number_bmp.height / 2)}
		
		# rects for small numbers
		@small_number_bmp = Bitmap.new("#{System_Settings::MAP_HUD_FOLDER}Small_Number")
		w = @small_number_bmp.width/10
		@small_number_rect = {}
		(0..9).each {|num|
		@small_number_rect[num] = Rect.new(w * num, 0, w, @small_number_bmp.height / 2)}
		@dmg_timer = 0
		@roster_need_display = false
		@roster_rev = 0
		@roster_fade_delay = 0
		@keyS1sym = InputUtils.getKeyAndTranslate(:S1)
		@keyS2sym = InputUtils.getKeyAndTranslate(:S2)
		@keyS3sym = InputUtils.getKeyAndTranslate(:S3)
		@keyS4sym = InputUtils.getKeyAndTranslate(:S4)
		@keyS5sym = InputUtils.getKeyAndTranslate(:S5)
		@keyS6sym = InputUtils.getKeyAndTranslate(:S6)
		@keyS7sym = InputUtils.getKeyAndTranslate(:S7)
		@keyS8sym = InputUtils.getKeyAndTranslate(:S8)
		@icon_no_item = 717
		@iconDrawRoster = []
		refresh
	end
  
	def refresh
		return unless @viewport.visible
		refresh_face
		refresh_mood_meter
		refresh_exp_meter
		refresh_numbers
		update_damage_effect
		refresh_combat_icon
		refresh_wound_layout #mod, refresh def
		#refresh_sight_icon
	end
	def refresh_wound_total
		total_wounds = 0
		@actor.wound_state_list.each{|state|
			total_wounds += @actor.stat[state]
		}
		total_wounds
	end
	def refresh_wound_layout
		total_wounds = 0
		total_wounds += refresh_wound_total
		@wound_layout.opacity = 0 if total_wounds == 0
		return if @total_wounds == total_wounds
		@wound_head.src_rect.y =		[26*(@actor.stat["WoundHead"]-1),52].min if @wound_head.src_rect.y!=[26*(@actor.stat["WoundHead"]-1),52].min
		@wound_chest.src_rect.y =		26*(@actor.stat["WoundChest"]-1) if @wound_chest.src_rect.y!=26*(@actor.stat["WoundChest"]-1)
		@actor.stat["WoundCuff"] >=1 ? @wound_Cuff.opacity = 255 : @wound_Cuff.opacity = 0
		@wound_sarm.src_rect.y =		26*(@actor.stat["WoundSArm"]-1) if @wound_sarm.src_rect.y!=26*(@actor.stat["WoundSArm"]-1)
		@wound_marm.src_rect.y =		[26*(@actor.stat["WoundMArm"]-1),52].min if @wound_marm.src_rect.y!=[26*(@actor.stat["WoundMArm"]-1),52].min
		@actor.stat["WoundCollar"] >=1 ? @wound_Collar.opacity = 255 : @wound_Collar.opacity = 0
		@wound_belly.src_rect.y = 26*(@actor.stat["WoundBelly"]-1) if @wound_belly.src_rect.y!=26*(@actor.stat["WoundBelly"]-1)
		@wound_groin.src_rect.y = 26*(@actor.stat["WoundGroin"]-1) if @wound_groin.src_rect.y!=26*(@actor.stat["WoundGroin"]-1)
		@wound_mthigh.src_rect.y = 26*(@actor.stat["WoundMThigh"]-1) if @wound_mthigh.src_rect.y!=26*(@actor.stat["WoundMThigh"]-1)
		@wound_sthigh.src_rect.y = 26*(@actor.stat["WoundSThigh"]-1) if @wound_sthigh.src_rect.y!=26*(@actor.stat["WoundSThigh"]-1)
		@wound_layout.opacity = 255 if total_wounds > 0
		@total_wounds = total_wounds
	end
	
	def refresh_numbers
		refresh_health
		refresh_sta
		refresh_sat
		refresh_semen_number
		refresh_drug_number
		refresh_weight_number
		refresh_resource_number
		refresh_arousal_number
		#refresh_move_speed_number
		#refresh_scoutcraft_number
		refresh_micturition_number
		refresh_lactation_number
		refresh_defecation_number
		refresh_overmap_x_number
		refresh_overmap_y_number
		refresh_overmap_time_number
		#refresh_overmap_encounter_number
		#refresh_overmap_dangerous_number
		refresh_overmap_difficulty_number
		refresh_hotkey
		@actor.skill_changed=false 
		refresh_battle_sex_ux
		refresh_overmap_ui
		#refresh_unread_mail mod
	end
def refresh_battle_sex_ux
	@battle_sex_ux.opacity  = (@player.actor.action_state == :sex && @actor.sta >=0) ? 255 : 0
end

def refresh_combat_icon 
	if $game_map.isOverMap
		temp_threat = $game_map.overmap_threatended?
	else
		temp_threat = $game_map.threat
	end
	@combat_icon.opacity = temp_threat ? 255 : 0
end
  
  
def refresh_face    # width = 144 w=18   
    index = @dmg_timer>0 ? 0 : [(@actor.mood+100).to_i / 25, 3].min	
    w = @face.bitmap.width/8
    tar_x = w * (7 - index)
    return if @face.src_rect.x == tar_x
    @face.src_rect = Rect.new(w * (3 - index), 0, w, @face.height)
  end
  
  def refresh_mood_meter
    index = [(@actor.mood).to_i/25, 3].min
    w = 3
    tar_x = w * (3 - index)
    tar_h = ((@actor.mood%25) / 25.0 * @mood_meter.bitmap.height).ceil
    tar_h = @mood_meter.bitmap.height if @actor.mood == 100
    tar_h = 1 if tar_h == 0 && @actor.mood != 0
    return if @mood_meter.src_rect.x == tar_x && @mood_meter.src_rect.height == tar_h
    @mood_meter.src_rect = Rect.new(w*(3-index), @mood_meter.bitmap.height-tar_h, w, tar_h)
    @mood_meter.y = 37 - @mood_meter.src_rect.height
    @mood_meter_back.src_rect.x = @mood_meter.src_rect.x + w * 5
  end
  
  def refresh_exp_meter
    if @actor.max_level?
      @exp_meter.src_rect.width
      return
    end
    exp_now = @actor.exp - @actor.exp_for_level(@actor.level)
    exp_need = @actor.exp_for_level(@actor.level + 1) - @actor.exp_for_level(@actor.level)
    @exp_meter.src_rect.width = @exp_meter.bitmap.width * exp_now.to_f / exp_need
  end
 
  
  def refresh_health
    return if @prev_health == @actor.health
    draw_number(@health_number.bitmap, @number_bmp, @actor.health, 
                @number_rect, @actor.health <= 0)
    @prev_health = @actor.health
  end
  
  def refresh_sta
    return if @prev_sta == @actor.sta
    draw_number(@sta_number.bitmap, @number_bmp, @actor.sta, 
                @number_rect, @actor.sta <= 0)
    @prev_sta = @actor.sta
  end
  
  def refresh_sat
    return if @prev_sat == @actor.sat
    draw_number(@sat_number.bitmap, @number_bmp, @actor.sat, 
    @number_rect, @actor.attr_dimensions["sat"][2] <= 0.25)
    @prev_sat = @actor.sat
  end
  
	def refresh_move_speed_number
		return if @prev_movespeed == @actor.move_speed && @prev_threat == $game_map.threat
		draw_number(@move_speed_number.bitmap, @small_number_bmp, 100*@actor.move_speed, @small_number_rect, @actor.move_speed <3)
		@move_speed_number.opacity = $game_map.threat ? 255 : 0
		@prev_threat = $game_map.threat
		@prev_movespeed = @actor.move_speed
	end    

	def refresh_resource_number
		return if @prev_resource == $game_party.gold
		draw_number(@resource_number.bitmap, @small_number_bmp, $game_party.gold, @small_number_rect)
		$game_party.gold <=0 ? opacity = 0 : opacity = 255
		@resource_layout.opacity = opacity
		@resource_number.opacity = opacity
		@prev_resource = $game_party.gold
	end  
  
	def refresh_weight_number
		return if @prev_weight == @actor.hud_weight_count
		draw_number(@weight_number.bitmap, @small_number_bmp, @actor.hud_weight_count, @small_number_rect, @actor.weight_carried > (2*@actor.attr_dimensions["sta"][2]))
		@prev_weight = @actor.hud_weight_count
	end

def refresh_lactation_number
	return if @prev_lactation == @actor.lactation_level
	draw_number(@lactation_number.bitmap, @small_number_bmp, 100 - (@actor.lactation_level/10), @small_number_rect, @actor.lactation_level >= 900)
	@actor.lactation_level <=0 ? opacity = 0 : opacity = 255
	@lactation_number.opacity =opacity
	@lactation_layout.opacity =opacity
	@prev_lactation = @actor.lactation_level
end

def refresh_drug_number
	return if @prev_drug == (@actor.will - @actor.drug_addiction_level)
	draw_number(@drug_number.bitmap, @small_number_bmp,(@actor.will/10) - (@actor.drug_addiction_level/10), @small_number_rect, @actor.drug_addiction_level >= @actor.will)
	@actor.stat["DrugAddiction"] !=0 ? opacity = 255 : opacity = 0
	@drug_number.opacity =opacity
	@drug_layout.opacity =opacity
	@prev_drug = (@actor.will - @actor.drug_addiction_level)
end

def refresh_semen_number
	return if @prev_semen == (@actor.will - @actor.semen_addiction_level)
	draw_number(@semen_number.bitmap, @small_number_bmp,(@actor.will/10) - (@actor.semen_addiction_level/10), @small_number_rect, @actor.semen_addiction_level >= @actor.will)
	@actor.stat["SemenAddiction"] !=0 ? opacity = 255 : opacity = 0
	@semen_number.opacity =opacity
	@semen_layout.opacity =opacity
	@prev_semen = (@actor.will - @actor.semen_addiction_level)
end

def refresh_micturition_number
	return if @prev_micturition == (@actor.will - @actor.urinary_level)
	draw_number(@micturition_number.bitmap, @small_number_bmp,(@actor.will/10) - (@actor.urinary_level/10), @small_number_rect, @actor.urinary_level >= @actor.will)
	@actor.stat["UrethralDamaged"] == 0 ? opacity = 0 : opacity = 255
	@micturition_number.opacity =opacity
	@micturition_layout.opacity =opacity
	@prev_micturition = (@actor.will - @actor.urinary_level)
end

def refresh_defecation_number
	return if @prev_defecation == (@actor.will - @actor.defecate_level)
	draw_number(@defecation_number.bitmap, @small_number_bmp,(@actor.will/10) - (@actor.defecate_level/10), @small_number_rect, @actor.defecate_level >= @actor.will)
	@actor.stat["SphincterDamaged"] == 0 ? opacity = 0 : opacity = 255
	@defecation_number.opacity =opacity
	@defecation_layout.opacity =opacity
	@prev_defecation = (@actor.will - @actor.defecate_level)
end

def refresh_arousal_number
  return if @prev_arousal == (@actor.will - @actor.arousal)
  draw_number(@arousal_number.bitmap, @small_number_bmp,(@actor.will/10) - (@actor.arousal/10), @small_number_rect, @actor.arousal >= @actor.will)
  @prev_arousal = (@actor.will - @actor.arousal)
end

  
	#def refresh_unread_mail
	#	
	#	
	#	
	#	return @mail_layout.opacity = 0 if $game_system.unread_mails_count ==0
	#	#return @mail_layout.opacity = 0 if $game_system.unread_mails_count ==0
	#	#
	#	#
	#	#if @mail_layout.opacity >= 255
	#	#	@mail_count = false
	#	#elsif @mail_layout.opacity <= 120
	#	#	@mail_count = true
	#	#end
	#	#
	#	#if @mail_count == true
	#	#	@mail_layout.opacity += 5 
	#	#elsif @mail_count == false
	#	#	@mail_layout.opacity -= 5 
	#	#end
	#	
	#end
  
#############################################################################################################################################################
#############################################################################################################################################################
#############################################################################################################################################################
###################################################################		OVERMAP		########################################################################
#############################################################################################################################################################
#############################################################################################################################################################
#############################################################################################################################################################
#############################################################################################################################################################
def refresh_overmap_ui
	isOverMap = $game_map.isOverMap
	@overmap_ui_opacity = isOverMap ? 255 : 0
	@hotkey_asdf.visible = !isOverMap
	@hotkey_qwer.visible = !isOverMap
	return if @overmap_ui_opacity == @prev_overmap_ui_opacity
	@x_layout.opacity				=@overmap_ui_opacity
	@x_number.opacity				=@overmap_ui_opacity
	@y_layout.opacity				=@overmap_ui_opacity
	@y_number.opacity				=@overmap_ui_opacity
	@time_layout.opacity			=@overmap_ui_opacity
	@time_number.opacity			=@overmap_ui_opacity
	#@encounter_layout.opacity		=@overmap_ui_opacity
	#@encounter_number.opacity		=@overmap_ui_opacity
	#@dangerous_layout.opacity		=@overmap_ui_opacity
	#@dangerous_number.opacity		=@overmap_ui_opacity
	@difficulty_layout.opacity		=@overmap_ui_opacity
	@difficulty_number.opacity		=@overmap_ui_opacity
	@prev_overmap_ui_opacity = @overmap_ui_opacity
end

  def refresh_overmap_x_number
	return if !$game_map.isOverMap
	return if @prev_overmap_x == @player.x
	draw_number(@x_number.bitmap, @small_number_bmp, @player.x,@small_number_rect)
	@prev_overmap_x = @player.x
  end
  

  def refresh_overmap_y_number
	return if !$game_map.isOverMap
	return if @prev_overmap_y == @player.y
	draw_number(@y_number.bitmap, @small_number_bmp, @player.y, @small_number_rect)
	@prev_overmap_y = @player.y
  end
  
  def refresh_overmap_time_number
	return if !$game_map.isOverMap
	return if @prev_overmap_time == $story_stats["OverMapEvent_DateCount"]
	draw_number(@time_number.bitmap, @small_number_bmp, $story_stats["OverMapEvent_DateCount"],@small_number_rect, $story_stats["OverMapEvent_DateCount"] >= 90)
	@prev_overmap_time = $story_stats["OverMapEvent_DateCount"]
  end
  
  def refresh_overmap_encounter_number
	return if !$game_map.isOverMap
	return if @prev_encounter == $story_stats["StepOvermapDangerous"]
	draw_number(@encounter_number.bitmap, @small_number_bmp, $story_stats["StepOvermapDangerous"]/10,@small_number_rect,  $story_stats["StepOvermapDangerous"]/10 >= 90)
	@prev_encounter = $story_stats["StepOvermapDangerous"]
  end
  
  def refresh_overmap_dangerous_number
	return if !$game_map.isOverMap
	return if @prev_dangerous == $story_stats["WildDangerous"]
	draw_number(@dangerous_number.bitmap, @small_number_bmp, $story_stats["WildDangerous"],@small_number_rect,$story_stats["WildDangerous"] >= 90)
	@prev_dangerous = $story_stats["WildDangerous"]
  end
  
  def refresh_overmap_difficulty_number
	return if !$game_map.isOverMap
	return if @prev_difficulty == $story_stats["WorldDifficulty"]
	draw_number(@difficulty_number.bitmap, @small_number_bmp, $story_stats["WorldDifficulty"],@small_number_rect,$story_stats["WorldDifficulty"] >= 90)
	@prev_difficulty = $story_stats["WorldDifficulty"]
  end
  
#############################################################################################################################################################
#############################################################################################################################################################
  def draw_number(tar_bmp, src_bmp, number, rects, crisis = false)
    tar_bmp.clear
    w = rects[0].width
    number.ceil.split_digits.map.with_index do |char, index|
      rect = rects[char].dup
      rect.y += rect.height if crisis
      tar_bmp.blt(index*w, 0, src_bmp, rect)
    end
  end
  
  def perform_damage_effect
    @dmg_timer = 20
	$game_map.interpreter.flash_screen(Color.new(125,0,20,25),5,false)
	$game_map.interpreter.screen.start_shake(2,3,5)
  end
  
  def update_damage_effect
    return if @dmg_timer.zero?
    d = (5 * @dmg_timer / 20.0).ceil
    @face.x = 18 + ((Graphics.frame_count%8>3) ? d : -d)
    @dmg_timer -= 1
    @face.x = 18 if @dmg_timer.zero?
  end

  
	def hide
		@viewport.visible = false
		#@list.each{|spr|spr.visible=false}
	end
  
	def show
		return if @viewport.visible
		refresh
		@viewport.visible = true
	end
  
  def hud_opa(tmpOpa=255)
	@viewport.opacity = tmpOpa
  end
  
	def dispose
		@list.each do |spr| 
		spr.bitmap.dispose
		spr.dispose
		end
		@number_bmp.dispose
		@small_number_bmp.dispose
		@viewport.dispose
	end
	
	def refresh_hotkey
		return if @player.actor.action_state==:sex
		return unless @actor.skill_changed
		@cachedBitmapASDF = Cache.load_bitmap("Graphics/System/Huds/","hotkey_asdf.png")
		@cachedBitmapQWER = Cache.load_bitmap("Graphics/System/Huds/","hotkey_qwer.png")
		if @player.npc_control_mode?
			tmpSkillList = @actor.master.actor.player_control_mode_skills
			draw_master_hotkey_icon(@cachedBitmapASDF,@hotkey_asdf,$data_arpgskills[tmpSkillList[0]],0,@keyS1sym)
			draw_master_hotkey_icon(@cachedBitmapASDF,@hotkey_asdf,$data_arpgskills[tmpSkillList[1]],1,@keyS2sym)
			draw_master_hotkey_icon(@cachedBitmapASDF,@hotkey_asdf,$data_arpgskills[tmpSkillList[2]],2,@keyS3sym)
			draw_master_hotkey_icon(@cachedBitmapASDF,@hotkey_asdf,$data_arpgskills[tmpSkillList[3]],3,@keyS4sym)
			draw_master_hotkey_icon(@cachedBitmapQWER,@hotkey_qwer,$data_arpgskills[tmpSkillList[4]],0,@keyS5sym)
			draw_master_hotkey_icon(@cachedBitmapQWER,@hotkey_qwer,$data_arpgskills[tmpSkillList[5]],1,@keyS6sym)
			draw_master_hotkey_icon(@cachedBitmapQWER,@hotkey_qwer,$data_arpgskills[tmpSkillList[6]],2,@keyS7sym)
			draw_master_hotkey_icon(@cachedBitmapQWER,@hotkey_qwer,$data_arpgskills[tmpSkillList[7]],3,@keyS8sym)
		else
			check_skill_roster
			draw_player_hotkey_icon(@cachedBitmapASDF,@hotkey_asdf,real_skill_id(@player.slot_skill_normal)	,0,@keyS1sym)
			draw_player_hotkey_icon(@cachedBitmapASDF,@hotkey_asdf,real_skill_id(@player.slot_skill_heavy)	,1,@keyS2sym)
			draw_player_hotkey_icon(@cachedBitmapASDF,@hotkey_asdf,real_skill_id(@player.slot_skill_control),2,@keyS3sym)
			draw_player_hotkey_icon(@cachedBitmapASDF,@hotkey_asdf,real_skill_id(@player.slot_hotkey_0)		,3,@keyS4sym)
			draw_player_hotkey_icon(@cachedBitmapQWER,@hotkey_qwer,real_skill_id(@player.slot_hotkey_1),0,@keyS5sym)
			draw_player_hotkey_icon(@cachedBitmapQWER,@hotkey_qwer,real_skill_id(@player.slot_hotkey_2),1,@keyS6sym)
			draw_player_hotkey_icon(@cachedBitmapQWER,@hotkey_qwer,real_skill_id(@player.slot_hotkey_3),2,@keyS7sym)
			draw_player_hotkey_icon(@cachedBitmapQWER,@hotkey_qwer,real_skill_id(@player.slot_hotkey_4),3,@keyS8sym)
		end
	end

	def real_skill_id(skill_id)
		return skill_id if ![101,102,103].include?(skill_id)
		skill = @actor.get_system_skill($data_skills[skill_id])
		return skill.nil? ?  -1 : skill.id
	end
	
	def draw_master_hotkey_icon(original_bitmap,hotkey_sprite,skill_id,sort_index,sym)
		icon_index = -1
		icon_index = skill_id.icon_index if skill_id.is_a?(SkillData) && skill_id.icon_index
		icon_index = 687 if skill_id.is_a?(SkillData) && !skill_id.icon_index
		if icon_index.is_a?(String)
			return if skill_id.nil?
			draw_hotkey_icon_from_string(original_bitmap,hotkey_sprite,icon_index,sort_index,sym)
		else
			draw_hotkey_icon_from_skill(original_bitmap,hotkey_sprite,icon_index,sort_index,sym)
		end
	end
	def draw_player_hotkey_icon(original_bitmap,hotkey_sprite,skill_id,sort_index,sym)
		icon_index = draw_hotkey_icon_get_icon_index(original_bitmap,hotkey_sprite,skill_id,sort_index,sym)
		if icon_index.is_a?(String)
			return if skill_id.nil?
			draw_hotkey_icon_from_string(original_bitmap,hotkey_sprite,icon_index,sort_index,sym)
		else
			draw_hotkey_icon_from_skill(original_bitmap,hotkey_sprite,icon_index,sort_index,sym)
		end
	end
	
	def draw_hotkey_icon_get_icon_index(original_bitmap,hotkey_sprite,skill_id,sort_index,sym)
		case skill_id
			when nil ; icon_index = -1
			when 61 ; icon_index = get_ext_skill_icon(extSkillID=0,skill_id=61) #ext1
			when 62 ; icon_index = get_ext_skill_icon(extSkillID=1,skill_id=62) #ext2
			when 63 ; icon_index = get_ext_skill_icon(extSkillID=2,skill_id=63) #ext3
			when 64 ; icon_index = get_ext_skill_icon(extSkillID=3,skill_id=64) #ext4
			when 69 ; icon_index = get_ext_skill_icon(extSkillID=4,skill_id=69) #ext5
			else
				if skill_id == -1 || !@actor.can_set_skill?($data_skills[skill_id])
					icon_index = @icon_no_item #XX icon
				else
					icon_index = $data_skills[skill_id].icon_index
				end
		end
		icon_index
	end
	def get_ext_skill_icon(extSkillID=0,skill_id)
		if @player.actor.ext_items[extSkillID].nil?
			icon_index = @icon_no_item
		elsif !$game_party.has_item?(@player.actor.ext_items[extSkillID], include_equip = false)
			icon_index = $data_ItemName[@player.actor.ext_items[extSkillID]].icon_index
			@display_X_icon = true
		else
			icon_index = $data_ItemName[@player.actor.ext_items[extSkillID]].icon_index
		end
		icon_index #= @iconDrawRoster[0]
		
	end
	def draw_hotkey_icon_from_string(original_bitmap,hotkey_sprite,icon_index,sort_index,sym)
		@cachedBitmapICON = Cache.normal_bitmap(icon_index)
		icon_src_rect = Rect.new(0, 0, 24, 24)
		board_src_rect= Rect.new(sort_index * 27, 0, 24, 32)
		hotkey_sprite.bitmap.fill_rect(board_src_rect,Color.new(255,255,255,0))
		hotkey_sprite.bitmap.blt(sort_index * 27 , 0 ,@cachedBitmapICON , icon_src_rect)
		hotkey_sprite.bitmap.blt(sort_index * 27 , 0 , original_bitmap, board_src_rect)  # CAUTION
		if @roster_need_display
			skillRosterIcon = 641 + @player.slot_RosterCurrent
			skillRosterIcon_src_rect = Rect.new(0, 0, 24, 24)
			hotkey_sprite.bitmap.blt(sort_index * 27  , 0 ,@cachedBitmapICON , skillRosterIcon_src_rect)
		end
		if @display_X_icon
			iconX_src = Rect.new(@icon_no_item % 16 * 24, @icon_no_item / 16 * 24, 24, 24)
			hotkey_sprite.bitmap.blt(sort_index * 27  , 0 ,@cachedBitmapICON , iconX_src)
			@display_X_icon = false
		end
		hotkey_sprite.bitmap.font.size = 14
		hotkey_sprite.bitmap.font.color.set(255,255,255,180)
		hotkey_sprite.bitmap.draw_text(sort_index * 27, 8,24,30,sym,1)
	end
	
	def draw_hotkey_icon_from_skill(original_bitmap,hotkey_sprite,icon_index,sort_index,sym)
		@cachedBitmapICON = Cache.system("Iconset")
		icon_src_rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
		board_src_rect= Rect.new(sort_index * 27, 0, 24, 32)
		hotkey_sprite.bitmap.fill_rect(board_src_rect,Color.new(255,255,255,0))
		hotkey_sprite.bitmap.blt(sort_index * 27 , 0 ,@cachedBitmapICON , icon_src_rect) if icon_index !=-1
		hotkey_sprite.bitmap.blt(sort_index * 27 , 0 , original_bitmap, board_src_rect)
		if @roster_need_display
			skillRosterIcon = 641 + @player.slot_RosterCurrent
			skillRosterIcon_src_rect = Rect.new(skillRosterIcon % 16 * 24, skillRosterIcon / 16 * 24, 24, 24)
			hotkey_sprite.bitmap.blt(sort_index * 27  , 0 ,@cachedBitmapICON , skillRosterIcon_src_rect)
		end
		if @display_X_icon
			iconX_src = Rect.new(@icon_no_item % 16 * 24, @icon_no_item / 16 * 24, 24, 24)
			hotkey_sprite.bitmap.blt(sort_index * 27  , 0 ,@cachedBitmapICON , iconX_src)
			@display_X_icon = false
		end
		return if icon_index == -1
		hotkey_sprite.bitmap.font.size = 14
		hotkey_sprite.bitmap.font.color.set(255,255,255,180)
		hotkey_sprite.bitmap.draw_text(sort_index * 27, 8,24,30,sym,1)
	end

	def check_skill_roster
		if @player.slot_RosterCurrent != @roster_rev
			@roster_rev = @player.slot_RosterCurrent
			@roster_need_display = true
			@roster_fade_delay = 2
		elsif @roster_fade_delay > 0
			@roster_fade_delay -= 1
		elsif @roster_need_display
			@roster_need_display = false
		end
	end
end

