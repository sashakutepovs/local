
class Menu_SexStats < Menu_ContentBase

	def initialize()
		super
		@back = Sprite.new(@viewport)
		@no_record = false #if sex_record is empty
		src= Cache.load_bitmap(ROOT,"03_sex_stats/sex_stats_layout")
		backbmp= Bitmap.new(src.width,src.height)
		backbmp.blt(0,0,src,src.rect)
		@back.bitmap = backbmp
		@back.z = System_Settings::SCENE_Menu_ContentBase_Z
		@scroll_amt=0
		@delta_y = 0 #total amount scrolled cannot scroll up if 0 , cannot scroll down if equals bitmap.height- dd.height
		draw_arrows
		draw_meters
		draw_sex_stats
		draw_sex_skills
		draw_menses
	end
	def semenMeterData
		{Body: [164,225], Vaginal: [202, 225], Anal: [240, 225]}
	end

	def body_descriptions
		[
			GetText.lona_belly_size,
			GetText.lona_hole_broken_level(@actor.vag_damage)[0],
			GetText.lona_hole_broken_level(@actor.anal_damage)[0]
		]
	end
	def body_values
		[
			@actor.stat["preg"],
			GetText.lona_hole_broken_level(@actor.vag_damage)[1],
			GetText.lona_hole_broken_level(@actor.anal_damage)[1]
		]
	end
	def line_height
		19
	end

	def icon32
		Cache.system("32px_iconset")
	end

	def icons
		{
			ovul: 9,
			menses: 10,
			active: 11,
			preg_level2: 12,
			preg_level3: 13,
			preg_level4: 14,
			active_plus: 16,
			fine: 17,
			error: 18,
			bad: 20,
			sick: 21,
			unknown: 19
		}
	end


	def draw_meters
		@tubes= Array.new
		@caps = Array.new
		@meters=Array.new
		semen_meter = Cache.load_bitmap(ROOT,"03_sex_stats/semen_amount")
		rect = Rect.new(0, 0, 15, 49)

		display_amt=@actor.getDisplayCumsAmt
		h = [([49 * (display_amt["body"] / 4000.0),49].min ).to_i,
		     ([49 * (display_amt["vag"]  / 1000.0),49].min ).to_i,
		     ([49 * (display_amt["anal"] / 1000.0),49].min ).to_i
		    ]
		semenMeterData.each.with_index do
			|(key, value), index|
			@back.bitmap.font.color=Color.new(0,255,255)
			@back.bitmap.font.size= 16
			@back.bitmap.font.outline=false
			draw_icon_32(icon32, @back.bitmap, value[0], value[1] + 21, 56 + (2 - index) * 8 + body_values[index]) #Base
			draw_icon_32(icon32, @back.bitmap, value[0], value[1] + 21, 56 + (2 - index+3) * 8 + body_values[index],@actor.melaninNipple.to_i) if key == :Body
			draw_icon_32(icon32, @back.bitmap, value[0], value[1] + 21, 56 + (2 - index+3) * 8 + body_values[index],@actor.melaninVag.to_i) if key == :Vaginal
			draw_icon_32(icon32, @back.bitmap, value[0], value[1] + 21, 56 + (2 - index+3) * 8 + body_values[index],@actor.melaninAnal.to_i) if key == :Anal
			@back.bitmap.draw_text(value[0], value[1] -16, 32, 60, body_descriptions[index], 1)
			@back.bitmap.draw_text(value[0], value[1] -16, 32, 60, body_descriptions[index], 1)
		end
		for cum in 0...3
			height = h[cum]

			tube = Sprite.new(@viewport)
			cap=Sprite.new(@viewport)
			meter=Sprite.new(@viewport)

			tube.bitmap	= semen_meter
			cap.bitmap	= semen_meter
			meter.bitmap	= semen_meter

			tube.src_rect	= Rect.new(0, 0, 15, 49)
			cap.src_rect	= Rect.new(15, 0, 15, 49)
			meter.src_rect= Rect.new(0, 98 - height, 15, height)

			tube.x =173 + cum * 37
			cap.x		=tube.x
			meter.x	=tube.x

			tube.y = 284
			cap.y = 284
			meter.y = 333 - height

			meter.z = 1+System_Settings::SCENE_Menu_Contents_Z
			tube.z = 2+System_Settings::SCENE_Menu_Contents_Z
			cap.z = 3+System_Settings::SCENE_Menu_Contents_Z

			tube.visible	=true
			cap.visible	=(height >= 49)
			meter.visible	=true

			@tubes<< tube
			@caps<< cap
			@meters<< meter
		end
	end


  def draw_arrows
	arrow_source = Cache.load_bitmap(ROOT,"08Items/item_arrow")#Bitmap.new("#{ROOT}08Items/item_arrow")
    @arrow_up = Sprite.new(@viewport)
    @arrow_up.z = System_Settings::SCENE_Menu_Contents_Z
	@arrow_up.x=320
	@arrow_up.y=15
    @arrow_up.bitmap = Bitmap.new(237, 12)
    rect = Rect.new(20, 0, 19, 12)
    @arrow_up.bitmap.blt(0,		0,	arrow_source, rect)
    @arrow_up.bitmap.blt(109, 	0,	arrow_source, rect)
    @arrow_up.bitmap.blt(218, 	0,	arrow_source, rect)
    @arrow_down = Sprite.new(@viewport)
    @arrow_down.z = System_Settings::SCENE_Menu_Contents_Z
    @arrow_down.bitmap = Bitmap.new(237, 12)

    rect = Rect.new(0, 0, 19, 12)
	@arrow_down.x=320
	@arrow_down.y=260
    @arrow_down.bitmap.blt(0, 	0, arrow_source, rect)
    @arrow_down.bitmap.blt(109, 0, arrow_source, rect)
    @arrow_down.bitmap.blt(218, 0, arrow_source, rect)
	@arrow_down.visible=false
	@arrow_up.visible=false
  end

  def draw_sex_stats
	@sex_record_sprite=Sprite.new(@viewport)
	@sex_record_sprite.z = System_Settings::SCENE_Menu_Contents_Z
	@sex_record_sprite.x =290 #WINDOW LOCAL
	@sex_record_sprite.y =30
	@sex_record_sprite.visible=true
	refresh_sex_stats
  end

  def draw_sex_skills
	@sex_skill_sprite=Sprite.new(@viewport)
	@sex_skill_sprite.z = System_Settings::SCENE_Menu_Contents_Z
	@sex_skill_sprite.x = @back.x
	@sex_skill_sprite.y = @back.y
	@sex_skill_sprite.bitmap=Bitmap.new(@back.bitmap.width,@back.bitmap.height)
	refresh_sex_skills
  end

  def draw_menses
	@menses_calendar=Sprite.new(@viewport)
	@menses_calendar.z = System_Settings::SCENE_Menu_Contents_Z
	@menses_calendar.x=156
	@menses_calendar.y=26
	bmp=Bitmap.new(120,220)

	@menses_calendar.bitmap=bmp
	prev_log=@actor.prev_status_log
	current_log=@actor.status_log
	log_no = @actor.current_log_no

	for day in 0...18
		this_cycle= !current_log[day].nil?
		row = day / 3
		col = day % 3
		status =this_cycle ? current_log[day] : prev_log[day]
		status=:unknown if status.nil?

		icon= icons[status]
		if([:bad,:menses].include?(status))
			back_icon = this_cycle ? 0 : 1
		else
			back_icon = this_cycle ? 2 : 3
		end
		draw_icon_32(icon32, bmp, 14 + col * 31, 8 + row * 31, back_icon)
		draw_icon_32(icon32, bmp, 14 + col * 31, 8 + row * 31, icon, this_cycle)
	end
	draw_icon_32(icon32, bmp, 14 + log_no % 3 * 31, 8 + log_no / 3 * 31,8)	#selection box
  end

  def draw_icon(bmp, x, y, index, enabled = true)
    rect = Rect.new(index % 16 * 24, index / 16 * 24, 24, 24)
    bmp.blt(x, y, Cache.system("Iconset"), rect, enabled ? 255 : 192)
  end

	def draw_icon_32(src, tar, x, y, index, enabled = true)
		rect = Rect.new(index % 8 * 32, index / 8 * 32, 32, 32)
		if enabled.is_a?(Numeric)
			opa = enabled
		elsif enabled.is_a?(TrueClass)
			opa = 255
		elsif enabled.is_a?(FalseClass)
			opa = 64
		else
			opa = 255
		end
		tar.blt(x, y, src, rect, opa)
	end

  def enter_page
	@active=true
	@arrow_down.visible	=true
	@arrow_up.visible	=true
    SndLib.sys_ok
	update_arrow
  end

	def back_to_mainmenu
		SndLib.sys_cancel
		@active=false
		@arrow_down.visible=false
		@arrow_up.visible=false
		@menu.activate
	end

	def refresh
		refresh_sex_skills
		refresh_sex_stats
	end

	def refresh_sex_stats
		#tmpData = get_sex_record_partner + get_sex_record_partner_count + get_sex_record_common
		tmpData = get_sex_record_partner + get_sex_record_race_count + get_sex_record_common
		sex_records = tmpData.reject{|rec|val=rec[1]; val.nil? ||  val==0 || val.eql?("")}
		#rec_length = sex_records.length == 0 ? 1 : sex_records.length #old build  no auto line
		rec_length = 1 # auto add line mode
		tmpData.each{|rec_name,val,singleLine|
			rec_length += 1
			rec_length += 1 if singleLine
		}
		bmp = Bitmap.new(320,(rec_length/2.0).ceil * line_height) #雙行
		bmp.font.size= 16 #雙行
		#bmp = Bitmap.new(320,rec_length * line_height) #單行
		#bmp.font.size= 20 #單行
		bmp.font.outline= false
		bmp.font.color= Color.new(20,255,20)
		display_index=0
		@sex_record_bottom = bmp.height - @sex_record_sprite.src_rect.height
		for index in 0...sex_records.length
			#p sex_records
			singleLine = sex_records[index][2]
			val = sex_records[index][1]
			rec_name = sex_records[index][0]
			#▼雙行
			if singleLine
				display_index += 1 if !display_index.even? #if its not 0 or other even number  +=1
				dx = 0
				dy =display_index / 2 * line_height
				bmp.font.size= 18
				bmp.draw_text(5 + dx,  3+dy, 150, line_height, "#{rec_name}")
				bmp.font.size= [[( 18 * (22.0 / "#{val.to_s} ".length ) ).ceil,18].min, 10].max
				bmp.draw_text(150 + dx,  3+dy, 500, line_height, "#{val.to_s}")
				display_index+=2
			else
				dx = 157 * (display_index % 2)
				dy =display_index / 2 * line_height
				bmp.font.size= [[( 17 * (21.0 / "#{rec_name} #{val.to_s}".length ) ).ceil,16].min, 9].max
				bmp.draw_text(5 + dx,  2+dy, 150, line_height, "#{rec_name}" "#{val.to_s}")
				display_index+=1
			end
			#▲雙行
			#▼單行
			#dx = 0
			#dy =display_index * line_height #單行
			#bmp.font.size= 16 #單行
			#bmp.draw_text(5 + dx,  3+dy, 150, line_height, "#{rec_name}") #單行
			#bmp.draw_text(150 + dx,  3+dy, 500, line_height, "#{val.to_s}") #單行
			#display_index+=1
			#▲單行
		end
		@sex_record_sprite.bitmap = bmp
		sex_record_srcr = Rect.new(0, 1, 320, 12* line_height) #window size
		@sex_record_sprite.src_rect=sex_record_srcr
	end

	def refresh_sex_skills
		bmp=@sex_skill_sprite.bitmap
		bmp.clear
		bmp.font.outline=false
		bmp.font.color=Color.new(255,255,0)
		bmp.font.size=16
		draw_hash = sex_skills_hash
		draw_icon(bmp, 297, 276, 676)
		bmp.draw_text(*draw_hash["battle_stats_vag"])
		bmp.clear_rect(418, 275, 35, 13)
		bmp.draw_text(*draw_hash["sex_vag_atk"])


		draw_icon(bmp, 457, 276, 675)
		bmp.draw_text(*draw_hash["battle_stats_anal"])
		bmp.clear_rect(577, 275, 35, 13)
		bmp.draw_text(*draw_hash["sex_anal_atk"])

		draw_icon(bmp, 297, 306, 673)
		bmp.draw_text(*draw_hash["battle_stats_mouth"])
		bmp.clear_rect(418, 305, 35, 13)
		bmp.draw_text(*draw_hash["sex_mouth_atk"])

		draw_icon(bmp, 457, 306, 674)
		bmp.draw_text(*draw_hash["battle_stats_fapping"])
		bmp.clear_rect(577, 305, 35, 13)
		bmp.draw_text(*draw_hash["sex_limbs_atk"])

		bmp.font.size=14
		bmp.draw_text(*draw_hash["sex_vag_atk_skill"])
		bmp.draw_text(*draw_hash["sex_anal_atk_skill"])
		bmp.draw_text(*draw_hash["sex_mouth_atk_skill"])
		bmp.draw_text(*draw_hash["sex_limbs_atk_skill"])
	end


	def sex_skills_hash
		draw_hash = {
			"battle_stats_vag" => [ 327, 274, 112, 13, $game_text["menu:sex_stats/battle_stats_vag"]],
			"battle_stats_anal" => [ 487, 274, 112, 13, $game_text["menu:sex_stats/battle_stats_anal"]],
			"battle_stats_mouth" => [ 327, 304, 112, 13, $game_text["menu:sex_stats/battle_stats_mouth"]],
			"battle_stats_fapping" => [ 487, 304, 112, 13, $game_text["menu:sex_stats/battle_stats_fapping"]],
			"sex_vag_atk" => [ 407, 274, 112, 13, ":   #{@actor.sex_vag_atk}"],
			"sex_anal_atk" => [ 567, 274, 112, 13, ":   #{@actor.sex_anal_atk}"],
			"sex_mouth_atk" => [ 407, 304, 112, 13, ":   #{@actor.sex_mouth_atk}"],
			"sex_limbs_atk" => [ 567, 304, 112, 13, ":   #{@actor.sex_limbs_atk}"],
			"sex_vag_atk_skill" => [ 327, 288, 112, 13, GetText.lona_sex_skill(@actor.sex_vag_atk)],
			"sex_anal_atk_skill" => [ 487, 288, 112, 13, GetText.lona_sex_skill(@actor.sex_anal_atk)],
			"sex_mouth_atk_skill" => [ 327, 318, 112, 13, GetText.lona_sex_skill(@actor.sex_mouth_atk)],
			"sex_limbs_atk_skill" => [ 487, 318, 112, 13, GetText.lona_sex_skill(@actor.sex_limbs_atk)]
		}
		return draw_hash
	end
  def refresh_sex_sex_stats
  end

	def show
		super
		refresh
		@delta_y = 0
		update_arrow
		@visible = true
	end

	def hide
		super
		@visible = false
	end

	def update_meter
		x = 15 * (Graphics.frame_count % 30 / 10)
		@meters.each {|spr| spr.src_rect.x = x}
	end

	def update
		return if !@viewport.visible
		#return unless @visible
		mouse_update_input
		update_meter
		return unless @active
		update_input
		update_sex_record_scroll
		update_arrow
	end


		def update_arrow
			d = Graphics.frame_count%92/23
			@arrow_up.y		= (d == 3) ?  15	:	15 - d*2
			@arrow_down.y	= (d == 3) ?  260	:	260+ d*2
		end

		def update_input
			return back_to_mainmenu 		if Input.trigger?(:B) || WolfPad.trigger?(:X_LINK)
			return scroll_up  				if Input.repeat?(:UP)
			return scroll_down  			if Input.repeat?(:DOWN)
			return 5.times{scroll_up}		if Input.repeat?(:L)
			return 5.times{scroll_down}		if Input.repeat?(:R)
		end

		def mouse_update_input
			return Mouse.ForceIdle if Input.MouseWheelForceIdle?
			return if !Mouse.enable?
			return back_to_mainmenu if Input.trigger?(:MX_LINK) && @active
			#p "Mouse.GetMouseXY #{Mouse.GetMouseXY}"
			tmpRecordArea = Mouse.within_XYWH?(285, 25, 327, 240)
			if !@active && tmpRecordArea && (Input.trigger?(:L) || Input.trigger?(:R) || Input.trigger?(:MZ_LINK))
				enter_page
			#elsif @active && !tmpRecordArea && (Input.trigger?(:L) || Input.trigger?(:R) || Input.trigger?(:MZ_LINK))
			#	back_to_mainmenu
			end
		end


		def update_sex_record_scroll
			return if @scroll_amt == 0
			srcr=@sex_record_sprite.src_rect
			v = @scroll_amt.abs > 10 ? 15 : 5
			v = @scroll_amt.abs > v ? (@scroll_amt > 0 ? v : -v) : @scroll_amt
			@sex_record_sprite.src_rect.y += v
			@scroll_amt -= v
		end

  #handle only the record part, not affecting other parts
  def scroll_up
	return if @delta_y == 0
	@scroll_amt-=line_height
	@delta_y-=line_height
  end

  def scroll_down
    return if @delta_y == @sex_record_bottom
	@scroll_amt+=line_height
	@delta_y+=line_height
  end

	def dispose
		@back.dispose
		@arrow_up.dispose
		@arrow_down.dispose
		@sex_skill_sprite.dispose
		@sex_record_sprite.dispose
		@menses_calendar.dispose
		@tubes.each{|i|i.dispose}
		@caps.each{|i|i.dispose}
		@meters.each {|i| i.dispose}
		super
	end
	def get_sex_record_partner
		#UI 用陣列 當[1]為 ""  or nil or 0 時 不顯示, [2]=Single line default nil
		sex_stats_record= [
			["#{$game_text["menu:sex_stats/record_first_mouth"]} : ",		gen_sex_basic_hole_text($story_stats["sex_record_first_mouth"]),true],
			["#{$game_text["menu:sex_stats/record_first_vag"]} : ",			gen_sex_basic_hole_text($story_stats["sex_record_first_vag"]),true],
			["#{$game_text["menu:sex_stats/record_first_anal"]} : ",		gen_sex_basic_hole_text($story_stats["sex_record_first_anal"]),true],
			["#{$game_text["menu:sex_stats/record_last_mouth"]} : ",		gen_sex_basic_hole_text($story_stats["sex_record_last_mouth"]),true],
			["#{$game_text["menu:sex_stats/record_last_vag"]} : ",			gen_sex_basic_hole_text($story_stats["sex_record_last_vag"]),true],
			["#{$game_text["menu:sex_stats/record_last_anal"]} : ",			gen_sex_basic_hole_text($story_stats["sex_record_last_anal"]),true]
		]
	end

	def gen_sex_basic_hole_text(data)
		textOutput = ""
		return textOutput if !data
		return textOutput if !data.is_a?(Array)
		return textOutput if data.empty?
		data.each{|txtFlag|
				textOutput += $game_text[txtFlag,true] + " " ##########################
			}
		textOutput
	end

	def get_sex_record_race_count
		sex_stats_record = Array.new
		$story_stats["sex_record_race_count"].each{|tmpTextID,tmpCount|
			mergedText = ""
			mergedText += $game_text[tmpTextID,true] + " : "
			sex_stats_record << [mergedText,tmpCount]
		}
		sex_stats_record
	end
	def get_sex_record_partner_count #unused but stay in there for refence
		sex_stats_record = Array.new
		$story_stats["sex_record_partner_count"].each{|tmpTextID,tmpCount|
			mergedText = ""
			tmpTextFlags = eval(tmpTextID) #shits is like "[\"DataNpcName:race/Dog\", \"DataNpcName:part/penis\"]"     just eval it trans to array
			tmpTextFlags.each{|tmpTextFlag|
					mergedText += $game_text[tmpTextFlag,true] + " "  ##########################
			}
			mergedText += ": "   ####################
			sex_stats_record << [mergedText,tmpCount]
		}
		sex_stats_record
	end
	def get_sex_record_common
		#UI 用陣列 當[1]為 ""  or nil or 0 時 不顯示, [2]=Single line default nil
		sex_stats_record= [

			["#{$game_text["menu:sex_stats/record_giveup_PeePoo"]} : ",				$story_stats["record_giveup_PeePoo"]],
			["#{$game_text["menu:sex_stats/record_Rebirth"]} : ",					$story_stats["record_Rebirth"]],
			["#{$game_text["menu:sex_stats/record_cunnilingus_given_count"]} : ",	$story_stats["sex_record_cunnilingus_given_count"]],
			["#{$game_text["menu:sex_stats/record_whore_job"]} : ",					$story_stats["sex_record_whore_job"]],
			["#{$game_text["menu:sex_stats/record_kissed"]} : ",					$story_stats["sex_record_kissed"]],
			["#{$game_text["menu:sex_stats/record_privates_seen"]} : ",				$story_stats["sex_record_privates_seen"]],
			["#{$game_text["menu:sex_stats/record_groped"]} : ",					$story_stats["sex_record_groped"]],
			["#{$game_text["menu:sex_stats/record_semen_swallowed"]} : ",			$story_stats["sex_record_semen_swallowed"]],
			["#{$game_text["menu:sex_stats/record_frottage"]} : ",					$story_stats["sex_record_frottage"]],
			["#{$game_text["menu:sex_stats/record_biggest_gangbang"]} : ",			$story_stats["sex_record_biggest_gangbang"]],
			["#{$game_text["menu:sex_stats/record_seen_peeing"]} : ",				$story_stats["sex_record_seen_peeing"]],
			["#{$game_text["menu:sex_stats/record_peed"]} : ",						$story_stats["sex_record_peed"]],
			["#{$game_text["menu:sex_stats/record_shat"]} : ",						$story_stats["sex_record_shat"]],
			["#{$game_text["menu:sex_stats/record_cumshotted"]} : ",				$story_stats["sex_record_cumshotted"]],
			["#{$game_text["menu:sex_stats/record_seen_shat"]} : ",					$story_stats["sex_record_seen_shat"]],
			["#{$game_text["menu:sex_stats/record_torture"]} : ",					$story_stats["sex_record_torture"]],
			["#{$game_text["menu:sex_stats/record_eating_fecal"]} : ",				$story_stats["sex_record_eating_fecal"]],
			["#{$game_text["menu:sex_stats/record_cunnilingus_taken"]} : ",			$story_stats["sex_record_cunnilingus_taken"]],
			["#{$game_text["menu:sex_stats/record_coma_sex"]} : ",					$story_stats["sex_record_coma_sex"]],
			["#{$game_text["menu:sex_stats/record_mindbreak"]} : ",					$story_stats["sex_record_mindbreak"]],
			["#{$game_text["menu:sex_stats/record_defecate_incontinent"]} : ",		$story_stats["sex_record_defecate_incontinent"]],
			["#{$game_text["menu:sex_stats/record_urinary_incontinence"]} : ",		$story_stats["sex_record_urinary_incontinence"]],
			["#{$game_text["menu:sex_stats/record_anal_dilatation"]} : ",			$story_stats["sex_record_anal_dilatation"]],
			["#{$game_text["menu:sex_stats/record_vag_dilatation"]} : ",			$story_stats["sex_record_vag_dilatation"]],
			["#{$game_text["menu:sex_stats/record_urinary_dilatation"]} : ",		$story_stats["sex_record_urinary_dilatation"]],
			["#{$game_text["menu:sex_stats/record_BreastFeeding"]} : ",				$story_stats["sex_record_BreastFeeding"]],
			["#{$game_text["menu:sex_stats/record_MilkSplash"]} : ",				$story_stats["sex_record_MilkSplash"]],
			["#{$game_text["menu:sex_stats/record_MilkSplash_incontinence"]} : ",	$story_stats["sex_record_MilkSplash_incontinence"]],
			["#{$game_text["menu:sex_stats/record_pregnancy"]} : ",					$story_stats["sex_record_pregnancy"]],
			["#{$game_text["menu:sex_stats/record_orgasm"]} : ",					$story_stats["sex_record_orgasm"]],
			["#{$game_text["menu:sex_stats/record_orgasm_Mouth"]} : ",				$story_stats["sex_record_orgasm_Mouth"]],
			["#{$game_text["menu:sex_stats/record_orgasm_Torture"]} : ",			$story_stats["sex_record_orgasm_Torture"]],
			["#{$game_text["menu:sex_stats/record_orgasm_Vag"]} : ",				$story_stats["sex_record_orgasm_Vag"]],
			["#{$game_text["menu:sex_stats/record_orgasm_Milking"]} : ",			$story_stats["sex_record_orgasm_Milking"]],
			["#{$game_text["menu:sex_stats/record_orgasm_Pee"]} : ",				$story_stats["sex_record_orgasm_Pee"]],
			["#{$game_text["menu:sex_stats/record_orgasm_Poo"]} : ",				$story_stats["sex_record_orgasm_Poo"]],
			["#{$game_text["menu:sex_stats/record_orgasm_Birth"]} : ",				$story_stats["sex_record_orgasm_Birth"]],
			["#{$game_text["menu:sex_stats/record_orgasm_Anal"]} : ",				$story_stats["sex_record_orgasm_Anal"]],
			["#{$game_text["menu:sex_stats/record_orgasm_Semen"]} : ",				$story_stats["sex_record_orgasm_Semen"]],
			["#{$game_text["menu:sex_stats/record_orgasm_Breast"]} : ",				$story_stats["sex_record_orgasm_Breast"]],
			["#{$game_text["menu:sex_stats/record_orgasm_Shame"]} : ",				$story_stats["sex_record_orgasm_Shame"]],
			["#{$game_text["menu:sex_stats/record_enemaed"]} : ",					$story_stats["sex_record_enemaed"]],
			["#{$game_text["menu:sex_stats/record_analbeads"]} : ",					$story_stats["sex_record_analbeads"]],
			["#{$game_text["menu:sex_stats/record_pussy_wash"]} : ",				$story_stats["sex_record_pussy_wash"]],
			["#{$game_text["menu:sex_stats/record_anal_wash"]} : ",					$story_stats["sex_record_anal_wash"]],
			["#{$game_text["menu:sex_stats/record_golden_shower"]} : ",				$story_stats["sex_record_golden_shower"]],
			["#{$game_text["menu:sex_stats/record_piss_drink"]} : ",				$story_stats["sex_record_piss_drink"]],

			["#{$game_text["menu:sex_stats/record_CoconaVag"]} : ",					$story_stats["record_CoconaVag"]],
			["#{$game_text["menu:sex_stats/record_CoconaOgrasm"]} : ",				$story_stats["record_CoconaOgrasm"]],
			["#{$game_text["menu:sex_stats/record_CoconaPeeWith"]} : ",				$story_stats["record_CoconaPeeWith"]],


			["#{$game_text["menu:sex_stats/record_groin_harassment"]} : ",			$story_stats["sex_record_groin_harassment"]],
			["#{$game_text["menu:sex_stats/record_butt_harassment"]} : ",			$story_stats["sex_record_butt_harassment"]],
			["#{$game_text["menu:sex_stats/record_boob_harassment"]} : ",			$story_stats["sex_record_boob_harassment"]],

			["#{$game_text["menu:sex_stats/record_handjob_count"]} : ",				$story_stats["sex_record_handjob_count"]],
			["#{$game_text["menu:sex_stats/record_anal_count"]} : ",				$story_stats["sex_record_anal_count"]],
			["#{$game_text["menu:sex_stats/record_vaginal_count"]} : ",				$story_stats["sex_record_vaginal_count"]],
			["#{$game_text["menu:sex_stats/record_mouth_count"]} : ",				$story_stats["sex_record_mouth_count"]],
			["#{$game_text["menu:sex_stats/record_cumin_vaginal"]} : ",				$story_stats["sex_record_cumin_vaginal"]],
			["#{$game_text["menu:sex_stats/record_cumin_anal"]} : ",				$story_stats["sex_record_cumin_anal"]],
			["#{$game_text["menu:sex_stats/record_cumin_mouth"]} : ",				$story_stats["sex_record_cumin_mouth"]],
			["#{$game_text["menu:sex_stats/record_masturbation_count"]} : ",		$story_stats["sex_record_masturbation_count"]],
			["#{$game_text["menu:sex_stats/record_FloorClearnPee"]} : ",			$story_stats["sex_record_FloorClearnPee"]],
			["#{$game_text["menu:sex_stats/record_FloorClearnScat"]} : ",			$story_stats["sex_record_FloorClearnScat"]],
			["#{$game_text["menu:sex_stats/record_FloorClearnCums"]} : ",			$story_stats["sex_record_FloorClearnCums"]],

			["#{$game_text["menu:sex_stats/record_miscarriage"]} : ",				$story_stats["sex_record_miscarriage"]],
			["#{$game_text["menu:sex_stats/record_baby_birth"]} : ",				$story_stats["sex_record_baby_birth"]],

			["#{$game_text["menu:sex_stats/record_birth_Abomination"]} : ",			$story_stats["sex_record_birth_Abomination"]],
			["#{$game_text["menu:sex_stats/record_birth_Goblin"]} : ",				$story_stats["sex_record_birth_Goblin"]],
			["#{$game_text["menu:sex_stats/record_birth_Human"]} : ",				$story_stats["sex_record_birth_Human"]+$story_stats["sex_record_birth_Deepone"]],
			["#{$game_text["menu:sex_stats/record_birth_Moot"]} : ",				$story_stats["sex_record_birth_Moot"]],
			["#{$game_text["menu:sex_stats/record_birth_Orkind"]} : ",				$story_stats["sex_record_birth_Orkind"]],
			["#{$game_text["menu:sex_stats/record_birth_Fishkind"]} : ",			$story_stats["sex_record_birth_Fishkind"]],

			["#{$game_text["menu:sex_stats/record_birth_PotWorm"]} : ",				$story_stats["sex_record_birth_PotWorm"]],
			["#{$game_text["menu:sex_stats/record_birth_MoonWorm"]} : ",			$story_stats["sex_record_birth_MoonWorm"]],
			["#{$game_text["menu:sex_stats/record_birth_PolypWorm"]} : ",			$story_stats["sex_record_birth_PolypWorm"]],
			["#{$game_text["menu:sex_stats/record_birth_HookWorm"]} : ",			$story_stats["sex_record_birth_HookWorm"]],
			["#{$game_text["menu:sex_stats/record_birth_BabyLost"]} : ",			$story_stats["sex_record_birth_BabyLost"]]
		]
		sex_stats_record
	end




end
