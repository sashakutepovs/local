#this script is outdated. and noused.
class Game_Player
	def update_afk_timer
		set_timeout(1,:on_afk_timeout) unless timeout_set?
		update_timeout #千萬記得call update
	end

		
		#當玩家將腳色晾在地圖上一陣子並且沒有任何其他事件時呼叫。
		#透過調整數值來觸發over-event跟half-overevent
		def on_afk_timeout
			p "on_afk_timeout"
			handle_on_move
			actor.on_player_walk
			#reset_timer
		end
		
		
		
end