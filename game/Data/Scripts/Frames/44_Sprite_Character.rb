#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
#==============================================================================
# ** Sprite_Character
#------------------------------------------------------------------------------
#  This sprite is used to display characters. It observes an instance of the
# Game_Character class and automatically changes sprite state.
#==============================================================================

class Sprite_Character < Sprite_Base
  #--------------------------------------------------------------------------
  # * Public Instance Variables
  #--------------------------------------------------------------------------
  attr_accessor :character
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     character : Game_Character
  #--------------------------------------------------------------------------
  def initialize(viewport, character = nil)
    super(viewport)
    @balloon_age = -1
    @character = character
    @balloon_duration = 0
	@counter=0
	@balloon_GuideMode = $game_map.isOverMap
    update
  end
  #--------------------------------------------------------------------------
  # * Free
  #--------------------------------------------------------------------------
  def dispose
    #end_animation
    end_balloon
    super
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
	def update
		return if @character.nil?
		######AntiLagPart
		@sx = @character.screen_x
		@sy = @character.screen_y
		if !need_update?
			self.visible = false
			return
		end
		######AntiLagPart
		
		super
		update_bitmap
		update_src_rect
		update_position
		update_other
		update_balloon
		update_tone
		setup_new_effect
	end
	def update_tone
		target_tone = @character.tone || Tone.new(0, 0, 0, 0)
		return if @last_tone && @last_tone == target_tone

		self.tone.set(target_tone.red, target_tone.green, target_tone.blue, target_tone.gray)
		@last_tone = target_tone.clone
	end
	def need_update?
		return true if graphic_changed?
		return true if @character.animation_id > 0
		return true if @balloon_sprite
		return true if @character.balloon_id != 0
		w = Graphics.width
		h = Graphics.height
		cw = @cw || 32
		ch = @ch || 32
		@sx.between?(-cw,w+cw) && @sy.between?(0,h+ch)
	end
  #--------------------------------------------------------------------------
  # * Get Tileset Image That Includes the Designated Tile
  #--------------------------------------------------------------------------
  def tileset_bitmap(tile_id)
    Cache.tileset($game_map.tileset.tileset_names[5 + tile_id / 256])
  end
  #--------------------------------------------------------------------------
  # * Update Transfer Origin Bitmap
  #--------------------------------------------------------------------------
	def update_bitmap
		if graphic_changed?
			@tile_id = @character.tile_id
			@character_name = @character.character_name
			@character_index = @character.character_index
			if @tile_id > 0
				set_tile_bitmap
			else
				set_character_bitmap
			end
		end
		@character.chs_need_update=false
	end
  
  
  #--------------------------------------------------------------------------
  # * Determine if Graphic Changed
  #--------------------------------------------------------------------------
	def graphic_changed?
		@tile_id != @character.tile_id ||
		@character_name != @character.character_name ||
		@character_index != @character.character_index ||
		@character.chs_need_update
	end
  #--------------------------------------------------------------------------
  # * Set Tile Bitmap
  #--------------------------------------------------------------------------
	def set_tile_bitmap
		sx = (@tile_id / 128 % 2 * 8 + @tile_id % 8) * 32;
		sy = @tile_id % 256 / 8 % 16 * 32;
		self.bitmap = tileset_bitmap(@tile_id)
		self.src_rect.set(sx, sy, 32, 32)
		self.ox = 16
		self.oy = 32
	end
  #--------------------------------------------------------------------------
  # * Set Character Bitmap
  # * 以use_chs作為判斷依據，如果有，就使用chs
  #--------------------------------------------------------------------------
	def set_character_bitmap
		
		#p "set_character_bitmap" if $debug_chs && @character.is_a?(Game_Event)&&@character.sex_mode?
		self.bitmap = @character.use_chs? ? Cache.chs_character(@character,@character.chs_need_update) : Cache.character(@character_name)
		#p "set_character_bitmap from cache" if $debug_chs && @character.is_a?(Game_Event)&&@character.sex_mode?
		if !self.bitmap # if shits fucked up.
			Cache.clear_chs_material(true)
			Cache.clear
			self.bitmap = Bitmap.new(384, 256)
			color = Color.new(255, 0, 255, 255)
			self.bitmap.fill_rect(0, 0, 384, 256, color)
			@cw = 32
			@ch = 32
			self.ox = @cw /2
			self.oy = @ch
			@using_chs = @character.use_chs?
			return msgbox "graphics error #{@character_name} x=#{@character.x} y=#{@character.y} d=#{@character.direction} p=#{@character.pattern}"
		end
		sign = @character_name[/^[\!\$]./]
		if @character.manual_cw || @character.manual_ch
			@cw = self.bitmap.width / character.manual_cw
			@ch =  self.bitmap.height / character.manual_ch
		elsif sign && sign.include?('$')
			@cw = self.bitmap.width / 3
			@ch = self.bitmap.height / 4
		elsif @character.use_chs? && @character.sex_mode?
			@cw = self.bitmap.width / 3
			@ch = self.bitmap.height / 8
		else
			@cw = self.bitmap.width / 12
			@ch = self.bitmap.height / 8
		end
		self.ox = @cw / 2
		self.oy = @ch
		@using_chs = @character.use_chs?
	end
  #--------------------------------------------------------------------------
  # * Update Transfer Origin Rectangle
  #--------------------------------------------------------------------------
	def update_src_rect
		if @character.animation
			cell_x, cell_y, duration = @character.animation.frame_data
			self.src_rect.set(cell_x * @cw, cell_y * @ch, @cw, @ch)
		else
			if @tile_id == 0
				index = @character.character_index 	  
				pattern = @character.pattern < 3 ? @character.pattern : 1
				sx = (index % 4 * 3 + pattern) * @cw
				sy = (index / 4 * 4 + (@character.direction - 2) / 2) * @ch
				@character.char_block_height=@ch
				@character.char_block_width=@cw
				self.src_rect.set(sx, sy, @cw, @ch)
			end
		end
	end
  #--------------------------------------------------------------------------
  # * Update Position
  #--------------------------------------------------------------------------
	def update_position
		self.x = @sx
		self.y = @sy
		self.z = @character.screen_z
		if @character.animation
			self.x += @character.animation.frame_data[3] || 0
			self.y += @character.animation.frame_data[4] || 0
		end
	end
	
  #--------------------------------------------------------------------------
  # ● Update_other_EX
  #--------------------------------------------------------------------------      
	def update_other_ex
		self.zoom_x = @character.zoom_x
		self.zoom_y = @character.zoom_y
		self.mirror = @character.mirror
		self.angle = @character.angle    
	end  
  #--------------------------------------------------------------------------
  # * Update Other
  #--------------------------------------------------------------------------
	def update_other
		self.opacity = @character.opacity
		self.blend_type = @character.blend_type
		self.bush_depth = @character.bush_depth
		self.visible = !@character.transparent
		update_other_ex
	end
  #--------------------------------------------------------------------------
  # * Set New Effect
  #--------------------------------------------------------------------------
	def setup_new_effect
		#if !animation? && @character.animation_id > 0   #RGSS animation?  unused
		#	animation = $data_animations[@character.animation_id]
		#	start_animation(animation)
		#end
		if !@balloon_sprite && @character.balloon_id > 0
			@balloon_id = @character.balloon_id
			start_balloon
		end
	end
  #--------------------------------------------------------------------------
  # * Move Animation
  #--------------------------------------------------------------------------
  #def move_animation(dx, dy)
  #  if @animation && @animation.position != 3
  #    @ani_ox += dx
  #    @ani_oy += dy
  #    @ani_sprites.each do |sprite|
  #      sprite.x += dx
  #      sprite.y += dy
  #    end
  #  end
  #end
  #--------------------------------------------------------------------------
  # * End Animation
  #--------------------------------------------------------------------------
 # def end_animation
 #   @character.animation_id = 0 unless @character.nil?
 #   super
 # end
  #--------------------------------------------------------------------------
  # * Start Balloon Icon Display
  #--------------------------------------------------------------------------
  def start_balloon
	return end_balloon if @balloon_id == -1 || nil
    dispose_balloon
    @balloon_age = 0
    if @character.balloon_repeat_time > 0
      @balloon_duration = Integer(@character.balloon_repeat_time * Graphics.frame_rate)
      @balloon_looping = true
    elsif @character.balloon_repeat_time == -1
		@balloon_duration = +1.0/0.0 
		@balloon_looping = true
	else
      @balloon_duration = 8 * balloon_speed + balloon_wait
      @balloon_looping = false
    end
    @balloon_sprite = Sprite.new(viewport)
    @balloon_sprite.bitmap = Cache.system("Balloon")
    @balloon_sprite.ox = 16
	@balloon_sprite.z = z + 200
	if @character.balloon_XYfix
		@balloon_sprite.oy = 32 + @character.balloon_XYfix
	elsif @character.use_chs?
		if @character.lower_balloon?
			@balloon_sprite.oy=32+$chs_data[@character.chs_type].balloon_height_low
		else
			@balloon_sprite.oy=32+$chs_data[@character.chs_type].balloon_height
		end
	else
		@balloon_sprite.oy = 32
	end
	update_balloon
  end
  #--------------------------------------------------------------------------
  # * Free Balloon Icon
  #--------------------------------------------------------------------------
  def dispose_balloon
    if @balloon_sprite
      @balloon_sprite.dispose
      @balloon_sprite = nil
    end
  end
  #--------------------------------------------------------------------------
  # * Update Balloon Icon
  #--------------------------------------------------------------------------
	def update_balloon
		return if @balloon_age < 0 || @character.nil?
		return @balloon_age = -1 if !@balloon_sprite
		# Allow balloon switching
		if @balloon_id != @character.balloon_id
			@balloon_id = @character.balloon_id
			start_balloon
		else
			@balloon_age += 1
			if @balloon_age <= @balloon_duration
				if !@balloon_GuideMode
					@balloon_sprite.x = x
					@balloon_sprite.y = y - (@character_height || height)
				else
					# Set the balloon's x-position to follow the target's x
					@balloon_sprite.x = x

					# Clamp the x-position to stay within the screen horizontally (with 32px margin)
					if @balloon_sprite.x > Graphics.width - 32
						@balloon_sprite.x = Graphics.width - 32  # Right edge limit
					elsif @balloon_sprite.x < 32
						@balloon_sprite.x = 32                  # Left edge limit
					end

					# Set the balloon's y-position above the character
					# Use @character_height if available; fallback to height
					@balloon_sprite.y = y - (@character_height || height)

					# Clamp the y-position to stay within the screen vertically (with 32px margin)
					if @balloon_sprite.y > Graphics.height - 32
						@balloon_sprite.y = Graphics.height - 32  # Bottom edge limit
					elsif @balloon_sprite.y < 32
						@balloon_sprite.y = 32                   # Top edge limit
					end
				end
				@balloon_sprite.opacity = $balloonForceHide ? 0 : 255
				sx = balloon_frame_index * 32
				sy = (@balloon_id - 1) * 32
				@balloon_sprite.src_rect.set(sx, sy, 32, 32)
			else
				#@balloon_age = -1 # Move this into end_balloon later
				end_balloon
			end
		end
	end
  #--------------------------------------------------------------------------
  # * End Balloon Icon
  #--------------------------------------------------------------------------
	def end_balloon
		dispose_balloon
		@balloon_age = -1
		@character.balloon_id = 0 if !@character.nil? && @character.balloon_repeat_time ==0
	end
  #--------------------------------------------------------------------------
  # * Balloon Icon Display Speed
  #--------------------------------------------------------------------------
  def balloon_speed
    @character.balloon_frame_speed
  end
  #--------------------------------------------------------------------------
  # * Wait Time for Last Frame of Balloon
  #--------------------------------------------------------------------------
  def balloon_wait
    @character.balloon_frame_wait
  end
  #--------------------------------------------------------------------------
  # * Frame Number of Balloon Icon
  #--------------------------------------------------------------------------
  def balloon_frame_index
		if @balloon_looping
		  (@balloon_age / balloon_speed) % 8
		else
		  7 - [(@balloon_duration - @balloon_age - balloon_wait) / balloon_speed, 0].max
		end  
	end
end
