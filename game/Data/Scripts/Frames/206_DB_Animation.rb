=begin

Define animations here.

The spritesheet is divided into 12 columns and 8 rows, for 96 cells.
Cells are specified by their x (0-11) and y (0-7) offsets from the top left.
A cell is shown for a specified number of frames. 0 for infinite frames.
Loops is the number of extra times to repeat the animation. -1 for inifinite.
TODO rename or rework loops.
Animation functions should return the following structure:
  [[[cell_x, cell_y, frames], ...], loops]

TODO support sounds and perhaps sub-animations.
frames 
 1 = play 1 times
 2= play 2 times
 0= 1 times
 -1 = loops
 [[[9, 6, 0]], 0] x,y,frame,  if frame =0 then forever
 ? [Cell_x,Cell_y,frame_time,x,y]
 
 修正點
 direction_offset須改為隊目標有效
 $game_player 須改為地圖之目標  對其他NPC也有效
=end
class CharsetAnimation

  attr_accessor :frame, :loops, :finished, :frames
 
  def initialize(data_array)
    @frames, @loops = data_array
    @frame = 0
    @counter = 0
  end
 
  def update
	return if finished?
    duration = @frames[@frame][2]
    return if duration <= 0
    @counter += 1
    if @counter > duration
      advance_frame
      return if @finished
    end
  end
 
  def advance_frame
    @counter = 1
    @frame += 1
    if @frame >= @frames.length
      if @loops != 0
        @frame = 0
        @loops -= 1 if @loops > 0
      else
        @finished = true
      end
    end
  end
  
  def finished?
	@frame>=@frames.length
  end
  
 
 
  def frame_data
	return @frames.last if @frames.length <=@frame
    @frames[@frame]
  end
 
end
 
class Array
  def random
    self[rand(length)]
  end
end

#class Sprite_Character
  #alias_method :update_src_rect_pre_charset_system, :update_src_rect
  #def update_src_rect
  #  if @character.animation
  #    cell_x, cell_y, duration = @character.animation.frame_data
  #    self.src_rect.set(cell_x * @cw, cell_y * @ch, @cw, @ch)
  #  else
  #    update_src_rect_pre_charset_system
  #  end
  #end
 
	#alias_method :update_position_pre_charset_system, :update_position
	#def update_position
	#	update_position_pre_charset_system
	#	if @character.animation
	#		self.x += @character.animation.frame_data[3] || 0
	#		self.y += @character.animation.frame_data[4] || 0
	#	end
	#end
#end


class Game_CharacterBase
attr_reader :animation
	
 def sex_mode?
	false
 end

	#arg :動畫影格陣列，overriding : 是否複寫播放中的動畫。需要複寫的狀況： 放招到一半被打
  def set_effect_animation(arg,overriding=false)
	return if @animation && !overriding
	self.animation=(arg)
  end
	def animation=(arg)
			if arg.nil?
			@animation = nil
				if @charEffectReset
					@charEffectReset = false
					@angle = 0
					@zoom_x = 1
					@zoom_y = 1
					@mirror = false
				end
			else
				@animation = CharsetAnimation.new(arg)
			end
	end
  
	alias_method :update_animation_pre_charset_system, :update_animation
	def update_animation
		return if sex_mode? && !sex_receiver?
		if @animation
			@animation.update 
			if @animation.finished
				@animation = nil
				@skill_eff_reserved=false
				if @charEffectReset
					@charEffectReset = false
					@angle = 0
					@zoom_x = 1
					@zoom_y = 1
					@mirror = false
				end
			else
				return
			end
		end
		update_animation_pre_charset_system
	end
  
  
  def post_animation
  end
  
  def direction_offset
    (@direction - 2) / 2
  end
  
  def cell_x_offset
		if @character_index <=3
			index_x = @character_index
		else
			index_x = @character_index-4
		end
		cell_x = ((@pattern+1) + (index_x*3)) -1
		return cell_x
  end
  
  def cell_y_offset
		 if @character_index <=3
			index_y = 0
		else
			index_y = 4
		end
		cell_y = (direction_offset + index_y)
		return cell_y
  end
  
  def get_character(param)
    if param == 0
      return $game_map.events[@id]
    end
    if param == -1
      $game_player
    elsif param < -1
      $game_player.followers[param.abs-2]
    else
      $game_map.events[param]
    end
  end
  
	def set_animation(animation_name)
		return if !animation_name
		#return if !animation_name.eql?("animation_nil")
		self.animation=send(animation_name)
	end
  
 end
 
 
#關於Game_Event播放完腳色動畫的處理，Added By KS
 class Game_Event < Game_Character
	
	#覆寫，處理動畫播放完畢後的項目，NPC的話是在任務中處理。
	def post_animation
		return if @npc.nil?
		@skill_eff_reserved=false
		@npc.set_action_state(:none) unless [:death,:sex,:grabber,:grabbed].include?(@npc.action_state)
		@npc.refresh
	end
 
 end
 
 
 
 #關於Game_Player播放動畫的處理，Added By KS
 class Game_Player < Game_Character
	#覆寫，處理動畫播放完畢後的項目，NPC的話是在任務中處理。
	def post_animation
		@skill_eff_reserved=false
		actor.set_action_state(:none) unless [:death,:sex,:grabber,:grabbed].include?(actor.action_state)
		actor.refresh
	end	
 
 end