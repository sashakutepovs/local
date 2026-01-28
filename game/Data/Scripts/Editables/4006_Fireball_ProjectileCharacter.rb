#==============================================================================
# This script is created by Kslander 
#==============================================================================
#基本投擲物(ex:石頭、弓箭)使用的class，ai_state永遠為killer
class Game_FireballPorjectile < Game_PorjectileCharacter
	def initialize(name)
		super(name)
	end
	def update_frame
		if @event.summon_data[:user] && @event.summon_data[:user] == $game_player
			if Input.trigger?($game_player.hotkey_skill_normal)
				@event.opacity = 0
				@event.moveto(@event.x,@event.y)
				set_killer_skill(0)
				missile_auto_ded
			end
		end
	end
end
