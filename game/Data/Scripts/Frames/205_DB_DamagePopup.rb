#$game_damage_popups.add(value, @target.x, @target.y, @caster.direction)
#todo add small_number index1 for sta damage, higher Z than health,   rand>> Higher strong for XY, Lower Gravity
#todo add small_number index2 for arousal damage, higher Z than health, rand >>Higher strong for XY, Lower Gravity

class DamagePopup
  
  class << self
    attr_accessor 	:Health_gravity, :Health_height, :Health_lifetime, :Health_x_v_up, :Health_x_v_down, :Health_x_v_side, :Health_y_v_up, :Health_y_v_down, :Health_y_v_side, :Health_floor_up, :Health_floor_down, :Health_floor_side
	attr_accessor 	:Sta_gravity, :Sta_height, :Sta_lifetime, :Sta_x_v_up, :Sta_x_v_down, :Sta_x_v_side, :Sta_y_v_up, :Sta_y_v_down, :Sta_y_v_side, :Sta_floor_up, :Sta_floor_down, :Sta_floor_side
	attr_accessor 	:Arousal_gravity, :Arousal_height, :Arousal_lifetime, :Arousal_x_v_up, :Arousal_x_v_down, :Arousal_x_v_side, :Arousal_y_v_up, :Arousal_y_v_down, :Arousal_y_v_side, :Arousal_floor_up, :Arousal_floor_down, :Arousal_floor_side
	attr_accessor 	:Dot_gravity, :Dot_height, :Dot_lifetime, :Dot_x_v_up, :Dot_x_v_down, :Dot_x_v_side, :Dot_y_v_up, :Dot_y_v_down, :Dot_y_v_side, :Dot_floor_up, :Dot_floor_down, :Dot_floor_side
	attr_accessor 	:State_height, :State_lifetime, :State_x_v, :State_y_v,:State_floor
  end
  
	DamagePopup.Health_x_v_side = 0.7
	DamagePopup.Health_y_v_side = -9.0
	DamagePopup.Health_floor_side= 6
	DamagePopup.Health_x_v_up = -0.6
	DamagePopup.Health_y_v_up = -9.1
	DamagePopup.Health_floor_up= -3
	DamagePopup.Health_x_v_down = 0.6
	DamagePopup.Health_y_v_down = -9.1
	DamagePopup.Health_floor_down= 0
	DamagePopup.Health_gravity = 1
	DamagePopup.Health_height = 30
	DamagePopup.Health_lifetime = 40
	
	DamagePopup.Sta_x_v_side = 1.6
	DamagePopup.Sta_y_v_side = -10
	DamagePopup.Sta_floor_side= 14
	DamagePopup.Sta_x_v_up = -2
	DamagePopup.Sta_y_v_up = -10
	DamagePopup.Sta_floor_up= -3.5
	DamagePopup.Sta_x_v_down = 2
	DamagePopup.Sta_y_v_down = -10
	DamagePopup.Sta_floor_down= 0
	DamagePopup.Sta_gravity = 0.8
	DamagePopup.Sta_height = 28
	DamagePopup.Sta_lifetime = 40
	
	DamagePopup.Arousal_x_v_side = 2
	DamagePopup.Arousal_y_v_side = -11
	DamagePopup.Arousal_floor_side= 16
	DamagePopup.Arousal_x_v_up = -1.25
	DamagePopup.Arousal_y_v_up = -11
	DamagePopup.Arousal_floor_up= -4
	DamagePopup.Arousal_x_v_down = 1.25
	DamagePopup.Arousal_y_v_down = -11
	DamagePopup.Arousal_floor_down= 0
	DamagePopup.Arousal_gravity = 0.7
	DamagePopup.Arousal_height = 26
	DamagePopup.Arousal_lifetime = 40

	
	DamagePopup.Dot_x_v_side = 2
	DamagePopup.Dot_y_v_side = -11
	DamagePopup.Dot_floor_side= 16
	DamagePopup.Dot_x_v_up = -1.25
	DamagePopup.Dot_y_v_up = -11
	DamagePopup.Dot_floor_up= -4
	DamagePopup.Dot_x_v_down = 1.25
	DamagePopup.Dot_y_v_down = -11
	DamagePopup.Dot_floor_down= 0
	DamagePopup.Dot_gravity = 0.1
	DamagePopup.Dot_height = 26
	DamagePopup.Dot_lifetime = 40
	
	DamagePopup.State_x_v = 0
	DamagePopup.State_y_v = -7
	DamagePopup.State_floor= -31
	DamagePopup.State_height = 32
	DamagePopup.State_lifetime = 35
  
	attr_reader :tile_x, :tile_y, :offset_x, :offset_y, :value, :direction, :type, :lifetime_rec, :opacity_dec, :def_blend_type, :def_opacity
	attr_reader :markZ_ui
	attr_reader :markZ_particle
	
	def initialize(number, tile_x, tile_y, direction,type,str)
		str = 1 if !str
		@value = number
		@tile_x = tile_x
		@tile_y = tile_y
		@type = type
		@offset_x = 0
		@def_blend_type=0
		@def_opacity = 255
		@opacity_dec = false
		@markZ_ui = false
		@markZ_particle = false
		case type
			when 1,10 #Health
				@offset_y = -DamagePopup.Health_height
					case direction
					when 8
					@floor =		DamagePopup.Health_floor_up
					@x_velocity = 	DamagePopup.Health_x_v_up
					@y_velocity = 	DamagePopup.Health_y_v_up
					when 6
					@floor = 		DamagePopup.Health_floor_side
					@x_velocity = 	DamagePopup.Health_x_v_side
					@y_velocity = 	DamagePopup.Health_y_v_side
					when 4
					@floor = 		DamagePopup.Health_floor_side
					@x_velocity =  -DamagePopup.Health_x_v_side
					@y_velocity = 	DamagePopup.Health_y_v_side
					when 2
					@floor = 		DamagePopup.Health_floor_down
					@x_velocity = 	DamagePopup.Health_x_v_down
					@y_velocity = 	DamagePopup.Health_y_v_down
					end
					@lifetime = DamagePopup.Health_lifetime
					@x_velocity = @x_velocity*str
					@y_velocity = @y_velocity*str
					@markZ_ui = true
			when 2,11 #Sta
				@offset_y = -DamagePopup.Sta_height
					case direction
					when 8
					@floor =		DamagePopup.Sta_floor_up
					@x_velocity = 	DamagePopup.Sta_x_v_up
					@y_velocity = 	DamagePopup.Sta_y_v_up
					when 6
					@floor = 		DamagePopup.Sta_floor_side
					@x_velocity = 	DamagePopup.Sta_x_v_side
					@y_velocity = 	DamagePopup.Sta_y_v_side
					when 4
					@floor = 		DamagePopup.Sta_floor_side
					@x_velocity =  -DamagePopup.Sta_x_v_side
					@y_velocity = 	DamagePopup.Sta_y_v_side
					when 2
					@floor = 		DamagePopup.Sta_floor_down
					@x_velocity = 	DamagePopup.Sta_x_v_down
					@y_velocity = 	DamagePopup.Sta_y_v_down
					when 0
					@floor 		= DamagePopup.State_floor
					@x_velocity = 0
					@y_velocity = DamagePopup.State_y_v
					@opacity_dec = true
					end
					@lifetime = DamagePopup.Sta_lifetime
					@x_velocity = @x_velocity*str
					@y_velocity = @y_velocity*str
					@markZ_ui = true
					
			when 3 #Arousal
				@offset_y = -DamagePopup.Arousal_height
					case direction
					when 8
					@floor =		DamagePopup.Arousal_floor_up
					@x_velocity = 	DamagePopup.Arousal_x_v_up
					@y_velocity = 	DamagePopup.Arousal_y_v_up
					when 6
					@floor = 		DamagePopup.Arousal_floor_side
					@x_velocity = 	DamagePopup.Arousal_x_v_side
					@y_velocity = 	DamagePopup.Arousal_y_v_side
					when 4
					@floor = 		DamagePopup.Arousal_floor_side
					@x_velocity =  -DamagePopup.Arousal_x_v_side
					@y_velocity = 	DamagePopup.Arousal_y_v_side
					when 2
					@floor = 		DamagePopup.Arousal_floor_down
					@x_velocity = 	DamagePopup.Arousal_x_v_down
					@y_velocity = 	DamagePopup.Arousal_y_v_down
					end
					@lifetime = DamagePopup.Arousal_lifetime
					@x_velocity = @x_velocity*str
					@y_velocity = @y_velocity*str
					@markZ_ui = true
					
			when 4 #state
					@offset_y = -DamagePopup.State_height
					@floor = 		DamagePopup.State_floor
					@x_velocity = 	DamagePopup.State_x_v + 2-rand(5)
					@y_velocity = 	DamagePopup.State_y_v
					@lifetime = DamagePopup.State_lifetime
					@markZ_ui = true
					
			when 5,6,7,8,9 #red blood Dot
					@offset_y = 	-3-rand(15)		*direction
					@offset_x = 	-5+rand(10)		*direction
					@floor = 		10-rand(20)		*direction
					@x_velocity = 	4-rand(8)		*direction
					@y_velocity = 	4-rand(8)		*direction
					@lifetime = 	10				*direction
					@def_blend_type=1
					@def_opacity = 255
					@opacity_dec = true
					@markZ_particle = true
			when :GoreDot
					@offset_y = 	-3-rand(15)		*direction
					@offset_x = 	-5+rand(10)		*direction
					@floor = 		10-rand(20)		*direction
					@x_velocity = 	4-rand(16)		*direction
					@y_velocity = 	8-rand(24)		*direction
					@lifetime = 	60
					@def_blend_type=0
					@def_opacity = 255
					@opacity_dec = true
					@markZ_particle = true
					
			when 9 #semen
					@offset_y = 	-3-rand(15)		*direction
					@offset_x = 	-5+rand(10)		*direction
					@floor = 		10-rand(20)		*direction
					@x_velocity = 	2-rand(4)		*direction
					@y_velocity = 	2-rand(4)		*direction
					@lifetime = 	20				*direction
					@def_blend_type=0
					@def_opacity = 255
					@opacity_dec = true
					@markZ_particle = true
					
		end
	@lifetime_rec = @lifetime
  end #def
  
  def update
		unless @offset_y >= @floor
		###################################################################
		@y_velocity += DamagePopup.Health_gravity
		@offset_x += @x_velocity
		@offset_y += @y_velocity
		@offset_y = @floor if @offset_y >= @floor
		end
		#msgbox @opacity
		#@opacity -= (255/@lifetime_rec) if @opacity_dec == true
		@lifetime -= 1
  end
  
  def dead?
    @lifetime <= 0
  end
  
end

class DamagePopups
  
  def initialize
    @popups = []
  end
  
  def add(number, x, y, direction,type,str=1)
	return if type == 0
    @popups << DamagePopup.new(number, x, y, direction,type,str)
  end
  
  def update
    @popups.each { |popup| popup.update }
    @popups.delete_if { |popup| popup.dead? }
  end
  
  def each(&block)
    @popups.each(&block)
  end
  
end

$game_damage_popups = DamagePopups.new

class Spriteset_DamagePopups
  
  def initialize(damage_popups)
    @damage_popups = damage_popups
    @sprites = {}
	###################################################################################################
    #@numbers = Cache.normal_bitmap('Graphics/System/Huds/health_Number.png')
	#@numbers_small = Cache.normal_bitmap('Graphics/System/Huds/Color_Number.png')
  end
  
  def dispose
    @sprites.each_value do |sprite|
      sprite.bitmap.dispose
      sprite.dispose
    end
  end
  
  def update
    dispose_dead
    @damage_popups.each do |popup|
      next if popup.dead?
      sprite = @sprites[popup]
      if sprite.nil?
        sprite = make_sprite(popup)
        @sprites[popup] = sprite
      end
      sprite.x = $game_map.adjust_x(popup.tile_x) * 32 + 16 - sprite.width / 2 + popup.offset_x
      sprite.y = $game_map.adjust_y(popup.tile_y) * 32 + 16 - sprite.height / 2 + popup.offset_y
	  sprite.opacity -= popup.def_opacity/popup.lifetime_rec if popup.opacity_dec
    end
  end
  
  
  def numbers
	Cache.system("Huds/health_Number.png")
  end
  
  def numbers_small
	Cache.system("Huds/Color_Number.png")
  end
  
  def numbers_smallWhr
	Cache.system("Huds/Small_Number.png")
  end
  
  def iconset
	Cache.system("Iconset")
  end
  
	def jumpDots(popup)
		case popup.type
			when 5; Cache.system("Huds/jumpDotsRed.png")
			when 6; Cache.system("Huds/jumpDotsGreen.png")
			when 7; Cache.system("Huds/jumpDotsBlue.png")
			when 8; Cache.system("Huds/jumpDotsFire.png")
			when 9; Cache.system("Huds/jumpDotsSemen.png")
			when :GoreDot; Cache.system("Huds/jumpDotsGore.png")
		end
	end
  
	def make_sprite(popup)
		case popup.type
			when 1;bitmap = create_text_bitmap(popup.value.to_s,numbers,1);
			when 2;bitmap = create_text_bitmap(popup.value.to_s,numbers_small);
			when 3;bitmap = create_text_bitmap(popup.value.to_s,numbers_small,1);
			when 4;bitmap = create_icon_bitmap(popup.value,iconset);#add state
			when 5,6,7,8,9;bitmap = create_jumpDots_bitmap(popup.value.to_i,jumpDots(popup));#RedBlood Dot
			when :GoreDot;bitmap = create_Goredot_bitmap(popup.value.to_i,jumpDots(popup));#RedBlood Dot
			when 10;bitmap = create_text_bitmap(popup.value.to_s,numbers); #white  num  big
			when 11;bitmap = create_text_bitmap(popup.value.to_s,numbers_smallWhr); #white num small
					#tmpDot = true
			else;bitmap = create_text_bitmap(popup.value.to_s,numbers,1)
		end
		sprite = Sprite.new
		sprite.bitmap = bitmap
		#sprite.opacity = $hudForceHide ? 0 : popup.def_opacity if [4.2,11,1,10].include?(popup.type)
		if $hudForceHide
			sprite.opacity = 0
		else
			popup.def_opacity if [4.2,11,1,10].include?(popup.type)
		end
		
		sprite.blend_type = popup.def_blend_type
		if popup.markZ_ui
			sprite.z = System_Settings::DB_POPUP_UI_Z 
		elsif popup.markZ_particle
			sprite.z = System_Settings::DB_POPUP_PARTICLE_Z 
		else
			sprite.z = 100
		end
		sprite
	end
  
  
  def create_text_bitmap(text,src_bitmap,index=0)
	text_width = src_bitmap.width/10
	text_height = src_bitmap.height/2
	
	bitmap = Bitmap.new(text.length * text_width, text_height)
	x = 0
	src_rect = Rect.new(0, text_height*index, text_width, text_height)
	text.codepoints do |char|
		src_rect.x = (char - 48) * text_width
		bitmap.blt(x, 0, src_bitmap, src_rect)
		x += text_width
    end
	bitmap
  end

	def create_icon_bitmap(icon_index,src_bitmap)
		bitmap = -1;
		if icon_index.is_a?(String)
			bitmap = Bitmap.new(24,24)
			bitmap.blt(0,0,Cache.normal_bitmap(icon_index),Rect.new(0,0,24,24))
		else
			bitmap = Bitmap.new(24,24)
			bitmap.blt(0,0,src_bitmap,Rect.new(icon_index%16 * 24,icon_index / 16 *24,24,24))
		end
		bitmap
	end
#  def create_icon_bitmap(icon_index,src_bitmap)
#	bitmap = Bitmap.new(24,24)
#	bitmap.blt(0,0,src_bitmap,Rect.new(icon_index%16 * 24,icon_index /16 *24,24,24))
#	bitmap
#  end

	def create_jumpDots_bitmap(icon_index,src_bitmap)
		bitmap = -1;
		if icon_index.is_a?(String)
			bitmap = Bitmap.new(3,3)
			bitmap.blt(0,0,Cache.normal_bitmap(icon_index),Rect.new(0,0,3,3))
		else
			bitmap = Bitmap.new(4,4)
			bitmap.blt(0,0,src_bitmap,Rect.new(icon_index%4 * 3,icon_index / 4 *4,4,4))
		end
		bitmap
	end

	def create_Goredot_bitmap(icon_index,src_bitmap)
		bitmap = -1;
		bitmap = Bitmap.new(8,8)
		bitmap.blt(0,0,src_bitmap,Rect.new(icon_index%4 * 3,icon_index / 4 *3,8,8))
		bitmap
	end
#  def create_jumpDots_bitmap(icon_index,src_bitmap)
#	bitmap = Bitmap.new(3,3)
#	bitmap.blt(0,0,src_bitmap,Rect.new(icon_index%4 * 3,icon_index /4 *3,3,3))
#	bitmap
#  end
  
  def dispose_dead
    @sprites.each do |k, v|
      if k.dead?
        v.bitmap.dispose
        v.dispose
        @sprites.delete(k)
      end
    end
  end
  
end

class Scene_Map < Scene_Base
  
	alias_method :update_pre_damage_popup, :update
	def update
		$game_damage_popups.update
		update_pre_damage_popup
	end
  
end

class Spriteset_Map
  
  alias_method :initialize_pre_damage_popup, :initialize
  def initialize
    @damage_popups = Spriteset_DamagePopups.new($game_damage_popups)
    initialize_pre_damage_popup # Call last because it updates
  end
  
  alias_method :dispose_pre_damage_popup, :dispose
  def dispose
    dispose_pre_damage_popup
    @damage_popups.dispose
  end
  
  alias_method :update_pre_damage_popup, :update
  def update
    update_pre_damage_popup
    @damage_popups.update
  end
  
end
