
#這個模組主要用來處理懷孕及月經相關的事件，被引用到


class Game_Map
	attr_reader :napping

	def pre_nap
		@napping=true
	end


	def nap(initFromEvent=false)
		$game_date.shift 
		play_nap_sounds		
		#如果腳色還在移動中就強制將腳色移到定位，避免飄移問題。
		if $game_player.moving?
			oriX=round_x_with_direction($game_player.x,$game_player.direction)
			oriY=round_y_with_direction($game_player.y,$game_player.direction)
			$game_player.moveto(oriX,oriY)
		end
		$game_player.light_check
		set_light if !initFromEvent 
		end
		
	def aft_nap
		@napping=false
	end
	
	def play_nap_sounds
		if $game_map.isOverMap
			SndLib.sys_OverMapDay if $game_date.day? 
			SndLib.sys_OverMapNight if $game_date.night?
		else
			SndLib.me_play("ME/Mystery",100,50) if $game_date.day?
			SndLib.me_play("ME/Mystery",100,150) if $game_date.night?
		end
	end
		
	def set_light
		return set_underground_light if @isUnderGround
		return setup_dayLight if $game_date.day?
		return setup_nightLight if $game_date.night?
	end	
	
	def setup_dayLight
		prp "$game_map.setup dayLight",3
		if $game_map.isOverMap
			temp_red=		125
			temp_green=		125
			temp_blue =		125
			temp_opacity =	80
		else
			temp_red=		150
			temp_green=		130
			temp_blue =		100
			temp_opacity =	30
		end
		shadows.set_color(temp_red, temp_green, temp_blue)
		shadows.set_opacity(temp_opacity)
	end
	
	def setup_nightLight
		prp "$game_map.setup nightLIght",3
		if $game_map.isOverMap
			temp_red=		80
			temp_green=		90
			temp_blue =		160
			temp_opacity =	200
		else
			temp_red=		40
			temp_green=		40
			temp_blue =		120
			temp_opacity =	170
		end

		shadows.set_color(temp_red, temp_green, temp_blue)
		shadows.set_opacity(temp_opacity)
	end
	
	def set_underground_light
		prp "$game_map.setup nightLIght",3
		tmpBasic = 230
		tmpScoutcraftFix = [$game_player.actor.scoutcraft_trait*3,75].min
		shadows.set_color(0, 5, 10)
		shadows.set_opacity(tmpBasic-tmpScoutcraftFix)
	end
		
	def get_current_region_weather #unused
		a = $game_date.get_weather
		case a
		when "sun"				;     ;return [0,0,0,0]
		when "full_sun"			;     ;return [15,10,10,-10]
		when "light_rain"		;     ;return [5,5,5,5]
		when "middle_rain"		;     ;return [5,5,5,10]
		when "heavy_rain"		;     ;return [5,5,5,15]
		when "fog_sun"			;     ;return [0,0,0,0]
		when "fog_full_sun"		;     ;return [15,10,10,-10]
		when "fog_light_rain"	;     ;return [5,5,5,5]
		when "fog_middle_rain"	;     ;return [5,5,5,10]
		when "fog_heavy_rain"	;     ;return [5,5,5,15]
		end
	end
	
	def get_current_moon_light
		a = $game_date.get_date_light
		case a
		when "half_moon";		return [2,5,7,10]
		when "mid_moon";		return [6,8,12,20]
		when "full_moon";		return [6,8,12,30]
		when "mid_moon";		return [6,8,12,20]
		when "half_moon";		return [2,5,7,10]
		when "no_moon";			return [0,0,0,0]
		end
	end
	
	
		
end#class
