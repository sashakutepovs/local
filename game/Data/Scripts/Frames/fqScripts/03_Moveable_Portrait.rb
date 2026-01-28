#==============================================================================
# This script is created by Kslander 
#==============================================================================
=begin

  能夠前後上下移動的Portrait，繼承之前的Portait Class
  這個class支援反轉，以左上角為主

=end


class Moveable_Portrait < Portrait
	attr_accessor	:flipped	#腳色是否反轉 (在 	邊為true，rprt邊為false)
	attr_reader		:charName	#這個portrait所屬的腳色名，用來在$game_portraits中取得自己
  
	FADE_X = 57
	FADE_Y = 30
	HIDE_X = 800
	HIDE_Y = 300
	HIDE_A = 255
	SHAKE_TIME = 24
	FADE_A=85
	@needs_hide = false #merged from portrait opt mod
 
  def initialize(base_char,parts,flipped=false,canvas=[300,400])
    #本portrait 是否反轉，反轉的話@direction變數為負1。
    (@flipped=flipped) ? @direction=-1 : @direction=1
    super(base_char,parts,canvas)
    @charName=base_char.charName
    @frame=0		#動畫總長度
	@cur_frame = 0	#portrait當下所在的影格
	@shaking =false	#是否正在震動
	@shake_strength = 0
	@dx = 0 	#每個frame的移動量，注意如果有交換方向的話dx,dy都要重算
	@dy = 0 	#每個frame的移動量，注意如果有交換方向的話dx,dy都要重算 
  end 
    
  def create_portrait
    super
    @portrait.mirror=@flipped
  end
  
  def setFlipped(flipped)
    (@flipped=flipped) ? @direction=-1 : @direction=1
    @portrait.mirror=flipped
    reset_position
  end
  
  #注意@canvas會因為pose轉變而改變內容(注意LonaPortrait有自己的版本)
  def base_x
	return @canvas[2] if @flipped	#Lprt
	return Graphics.width-@canvas[0]-@canvas[2]	#Rprt
  end
  
  def base_y
	@canvas[3]
  end

	
	def hide_after_move #merged from portrait opt mod
		@needs_hide = true
	end
	
	def update_position #merged from portrait opt mod
		return unshow if @needs_hide && !is_playing?
		return unless is_playing?
		return skip_animation if Input.MsgSkipKeyPressed?
		return update_shake if @shaking
		update_move
	end
	
  def update_shake
	return end_shake if @frame == 0
	@frame-=1
	@portrait.x = @shake_bx + @shake_strength - rand(@shake_strength*2)+1
	@portrait.y = @shake_by + @shake_strength - rand(@shake_strength*2)+1
  end
  
  def update_move 
	@cur_frame+=1
	@portrait.x += @dx
	@portrait.y += @dy
	@portrait.color.alpha += @da
	skip_animation if !is_playing? #動畫播放結束時強制把東西送到定位
  end
  

  
  #將portrait歸到預設位置上
  def reset_position
	@portrait.x=base_x
    @portrait.y=base_y
  end
  
  def set_position(tmpX=0,tmpY=0)
	@portrait.x=@dx + tmpX
    @portrait.y=@dy + tmpY
  end
  
  def reset_to_default
	skip_animation
    reset_position
    @portrait.color.alpha=0
  end

  def is_playing?
	(@frame > @cur_frame) || @shaking
  end
  
  #跳過動畫，直接到達定位
  def skip_animation
	@dx = 0 
	@dy = 0
	@portrait.x		=	@tar_x if @tar_x
	@portrait.y		=	@tar_y if @tar_y
	@portrait.color.alpha =	@tar_a if @tar_a
	@tar_x			=	nil
	@tar_y			=	nil
	@tar_a			=	nil
	@frame = 0
	@cur_frame = 0
	end_shake if @shaking
  end
  
  def end_shake
    @shaking =false
	@portrait.x = @shake_bx
	@portrait.y = @shake_by
	@shake_bx	= nil
	@shake_by	= nil
  end
  
  
  #note : auto compute flip
  # reset_first : 是否強制從最初重新開始
  # 傳入目標移動位置，相對於當下portrait基底位置的左上角, 一律採用+
  def set_motion(dur_frame,target_x,target_y,target_alpha,reset_first=false)
	@frame = dur_frame.to_i
	@cur_frame = 0
	@tar_x = calculate_x_flipped(base_x,target_x.to_i)		#最終portrait要去的x座標
	@tar_y = base_y + target_y.to_i							#最終portrait要去的y座標
	@tar_a = target_alpha.to_i
	@da = (@tar_a - @portrait.color.alpha) / @frame
	calc_move_factor #calculate dist & delta_x 
	reset_to_default if reset_first
  end
  
  def calc_move_factor
	#distance this portrait has to travel
	dist_x = @tar_x - @portrait.x
	dist_y = @tar_y - @portrait.y
	@dx = dist_x / @frame
	@dy = dist_y / @frame
  end
  
  def calculate_x_flipped(start_x,addition=0)
	return (start_x-addition) if @flipped
	return (start_x+addition) 
  end
  
	def show #merged from portrait opt mod
		super
		@needs_hide = false
		focus
	end
  
  def shake(strength=30,frame_count=18)
	return if @shaking
	skip_animation
	@shaking = true
	@shake_bx = @portrait.x
	@shake_by = @portrait.y
	@shake_strength = strength
	@frame= frame_count
  end
  
  def fade
	return if faded?
	skip_animation
	@portrait_state = :fade
	@portrait.color.alpha = FADE_A if @portrait.color.alpha > FADE_A
	set_motion(4,FADE_X,FADE_Y,FADE_A)
  end
  
  def focus
	return if focused?
	skip_animation
	@portrait_state = :focus
	@portrait.color.alpha = FADE_A if @portrait.color.alpha > FADE_A
	set_motion(8,0,0,0)
  end
  
  
	def hide #merged from portrait opt mod
		return if hidden?
		skip_animation
		@portrait_state = :hide
		set_motion(20,HIDE_X,HIDE_Y,HIDE_A)
		hide_after_move
	end
  
  def focus_xy
	[base_x, base_y]
  end
  
  def hidden_xy
	return [calculate_x_flipped(base_x,HIDE_X),base_y+HIDE_Y] if @flipped
	return [Graphics.width-@canvas[0]-(calculate_x_flipped(base_x,HIDE_X)),base_y+HIDE_Y]
  end
  
  def faded_xy
	return [calculate_x_flipped(base_x,FADE_X),base_y+FADE_Y] if @flipped
	return [Graphics.width-@canvas[0]-(calculate_x_flipped(base_x,FADE_X)),base_y+FADE_Y]   
  end
  
  def focused?
	focus_x,focus_y = focus_xy
	@portrait.x == focus_x && @portrait.y == focus_y
  end
  
  def hidden?
	hidden_x,hidden_y = hidden_xy
	@portrait.x == hidden_x && @portrait.y == hidden_y
  end
  
  def faded?
	fade_x,fade_y = faded_xy
	@portrait.x == fade_x && @portrait.y == fade_y
  end


  
end
