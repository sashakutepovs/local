#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
# Menu MainStats

#==============================================================================
# ** Menu_MainStats
#==============================================================================

class Menu_MainStats < Menu_ContentBase

	def initialize
		super()
		@main_stats_layout = Sprite.new(@viewport)
		@main_stats_layout.bitmap = Cache.load_bitmap(ROOT,"01Main_stats/main_stats_layout")
		@main_stats_layout.z = 1
		@info = Sprite.new(@viewport)
		@info.bitmap = Bitmap.new(Graphics.width, Graphics.height)
		@info.z = 2
		refresh
		hide
	end

	def refresh
		base_x = 175
		base_y = 115
		dy = 14

		bmp = @info.bitmap
		bmp.clear #避免重複繪製，與記憶體crash無關。
		bmp.font.outline = false
		bmp.font.size = 54
		bmp.font.color=Color.new(255,255,255,255)
		bmp.draw_text(157+5,18    ,160,60,$game_text["menu:main_stats/name"],0)
		bmp.font.size = 24
		bmp.draw_text(157+8,47,300,60,$game_text["DataTitle:#{$game_player.actor.record_lona_title}"],0)
		bmp.font.color=Color.new(0,255,0,255)

		bmp.font.size = 15
		bmp.font.outline = false
		bmp.font.color=Color.new(20,255,20,255)

		draw_hash = make_menu_hash
		draw_hash.each{|stat,args|;bmp.draw_text(*args) if args != nil}
	end


	def make_menu_hash

		draw_hash = {

			"race" => [157+8,0+85    ,160,60,    "#{$game_text["menu:main_stats/race"]} : #{GetText.lona_race}",0],

			"persona" => [157+8,24+85    ,160,60,    "#{$game_text["menu:main_stats/persona"]} : #{GetText.lona_persona}",0],

			"level" => [157+8,36+85    ,160,60,    "#{$game_text["menu:main_stats/level"]} : #{$game_player.actor.level}",0],

			#set2 combat
			"atk" => [157+8,72+85    ,160,60,    "#{$game_text["menu:main_stats/atk"]}: #{$game_player.actor.atk.round(2)}",0],
			"def" => [157+8,84+85    ,160,60,    "#{$game_text["menu:main_stats/def"]} : #{$game_player.actor.def.round(2)}",0],

			"Dodge" => [157+8,96+85    ,160,60,    "#{$game_text["DataSkill:BasicDodge/item_name"]} : #{$game_player.actor.dodge_frame}",0],

			"move_speed" => [157+8,108+85    ,160,60,    "#{$game_text["menu:main_stats/move_speed"]} : #{$game_player.actor.move_speed.round(2)}",0],

			#set3 needed
			"mood" => [157+8,0+221    ,160,60,    "#{$game_text["menu:main_stats/mood"]} : #{$game_player.actor.mood.round(2)}",0],

			"dirt" => [157+8,12+221    ,160,60,    "#{$game_text["menu:main_stats/dirt"]} : #{$game_player.actor.dirt.round(2)}",0],


			"arousal" => [157+8,24+221    ,160,60,    "#{$game_text["menu:main_stats/arousal"]} : #{$game_player.actor.arousal.round(2)}",0],

			#set4 other

			"date" => [157+130,0+85    ,160,60,    "#{$game_text["menu:main_stats/date"]} : #{$game_date.date[0]}.#{$game_date.date[1]}.#{$game_date.date[2]}.#{GetText.time}",0],

			#bmp.draw_text(157+130,24+85    ,160,60,    "#{$game_text["menu:main_stats/carrying_capacity"]} : #{$game_player.actor.weight_carried} :#{(2*$game_player.actor.attr_dimensions["sta"][2]).round(2)} ",0)
			"trade_point" => [157+130,12+85 ,160,60,    "#{$game_text["menu:main_stats/trade_point"]} : #{$game_party.gold}",0],

			#set4 looking
			"morality" => [157+130,72+85    ,160,60,    "#{$game_text["menu:main_stats/morality"]} : #{$game_player.actor.morality.round(2)}",0],
			"sexy" => [157+130,84+85    ,160,60,    "#{$game_text["menu:main_stats/sexy"]} : #{$game_player.actor.sexy.round(2)}",0],
			"weak" => [157+130,96+85    ,160,60,    "#{$game_text["menu:main_stats/weak"]} : #{$game_player.actor.weak.round(2)}",0]
			}

		draw_hash["exp_need"] = [157+8,48+85    ,160,60,    "#{$game_text["menu:main_stats/exp_need"]} : #{$game_player.actor.exp - $game_player.actor.exp_for_level($game_player.actor.level)} : #{$game_player.actor.exp_for_level($game_player.actor.level + 1) - $game_player.actor.exp_for_level($game_player.actor.level)}",0] if $game_player.actor.level !=99

		draw_hash["baby_health"] = [157+130,24+85 ,160,60,    "#{$game_text["menu:main_stats/baby_health"]} : #{$game_player.actor.baby_health.round(1)}/#{$game_player.actor.attr_dimensions['baby_health'][2]}",0] if $game_player.actor.stat["displayBabyHealth"] == 1 || $TEST

		draw_hash["micturition_need"] = [157+8,36+221    ,160,60,    "#{$game_text["menu:main_stats/micturition_need"]} : #{$game_player.actor.urinary_level}",0] if  $TEST || ($game_player.actor.urinary_level >0 && $story_stats["Setup_UrineEffect"] ==1)

		draw_hash["breast_swelling"] = [157+8,48+221    ,160,60,    "#{$game_text["menu:main_stats/breast_swelling"]} : #{$game_player.actor.lactation_level.round(1)}",0] if $TEST || ($game_player.actor.lactation_level >0)

		draw_hash["stomach_upset"] = [157+8,60+221    ,160,60,    "#{$game_text["menu:main_stats/stomach_upset"]} : #{$game_player.actor.puke_value_normal.round(1)}",0] if $TEST || ($game_player.actor.puke_value_normal >0)

		draw_hash["defecation_need"] = [157+8,72+221    ,160,60,    "#{$game_text["menu:main_stats/defecation_need"]} : #{$game_player.actor.defecate_level.round(1)}",0] if  $TEST || ($game_player.actor.defecate_level >0 && $story_stats["Setup_ScatEffect"] ==1)
		return draw_hash
	end


	def show
		super
		$game_player.actor.stat["EventMouth"] = nil
		$game_player.actor.prtmood("normal")
		lonaprt=$game_portraits.getPortrait("Lona")
		lonaprt.update
		lonaprt.show
		lonaprt.focus
		lonaprt.portrait.x-=25
		lonaprt.portrait.y-=45
	end

	def mouse_no_need_update
		true
	end
	def hide
		super
		prt = $game_portraits.getPortrait("Lona")
		prt.hide
		prt.skip_animation
		#prt.prt_vp.z = System_Settings::SCENE_PORTRAIT_MENU_Z
	end

	def dispose
		#@info.bitmap.dispose #geneerated , not cached
		@main_stats_layout.dispose
		@info.dispose
		super
	end


end
