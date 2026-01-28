#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
#==============================================================================
# ** Spriteset_Map
#------------------------------------------------------------------------------
#  This class brings together map screen sprites, tilemaps, etc. It's used
# within the Scene_Map class.
#==============================================================================

class Spriteset_Map

  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    create_viewports
    create_tilemap
    create_parallax
    create_characters
    #create_shadow
    create_weather
    create_pictures
    create_timer
    create_map_background
	$game_map.added_ev_ids.clear #test
    update
  end
  #--------------------------------------------------------------------------
  # * Create Viewport
  #--------------------------------------------------------------------------
  def create_viewports
    @viewport1 = Viewport.new
    @viewport2 = Viewport.new
    @viewport3 = Viewport.new
	@viewport4 = Viewport.new
	@ivp_map=Viewport.new
    @viewport2.z = System_Settings::MAP_VP2_Z
    @viewport3.z = System_Settings::MAP_VP3_Z
	@viewport4.z = System_Settings::MAP_VP4_Z
    @viewport1.z = System_Settings::MAP_VP1_Z
	@ivp_map.z=System_Settings::MAP_BACKGROUND_COLOR_Z
  end
  
  #++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  # map bG by 417
  #++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	#def create_map_background
	#	return if !$game_map.map_background_color
	#	if @cover_map
	#		@cover_map.dispose
	#		@cover_map.bitmap.dispose
	#	end
	#	@cover_map=Sprite.new(@ivp_map)
	#	case $data_ToneMode
	#		when 1 #tone Pixel mode
	#			bmp_map = Cache.load_bitmap("Graphics/System/","MapBG_Tone")
	#			@cover_map.color.set($game_map.map_background_color)
	#			@cover_map.blend_type = $game_map.map_background_color_blend
	#			@cover_map.opacity=$game_map.map_background_color_opacity
	#		when 2 #scanLine Mode
	#			bmp_map = Cache.load_bitmap("Graphics/System/","MapBG_Scan")
	#			@cover_map.color.set($game_map.map_background_color)
	#			@cover_map.blend_type = $game_map.map_background_color_blend
	#			@cover_map.opacity=$game_map.map_background_color_opacity
	#		else
	#			bmp_map=Bitmap.new(Graphics.width,Graphics.height)
	#			@cover_map.blend_type = $game_map.map_background_color_blend
	#			@cover_map.opacity=$game_map.map_background_color_opacity
	#			bmp_map.fill_rect(bmp_map.rect,$game_map.map_background_color)
	#	end
	#	@cover_map.bitmap=bmp_map
	#	@cover_map.visible=true
	#	@cover_map.color = $game_map.map_background_color
	#	$game_map.map_background_changed=false
	#end
	def create_map_background
		return unless $game_map.map_background_color

		if @cover_map
			@cover_map.dispose
			@cover_map.bitmap.dispose if @cover_map.bitmap && !@cover_map.bitmap.disposed?
		end

		@cover_map = Sprite.new(@ivp_map)
		bmp_map = nil


		if File.exists?($data_ToneMode)
			src = Bitmap.new($data_ToneMode)
			bmp_map = Bitmap.new(Graphics.width, Graphics.height)
			(0...Graphics.width).step(src.width) do |x|
				(0...Graphics.height).step(src.height) do |y|
					bmp_map.blt(x, y, src, src.rect)
				end
			end
			@cover_map.color.set($game_map.map_background_color)
			@cover_map.blend_type = $game_map.map_background_color_blend
			@cover_map.opacity = $game_map.map_background_color_opacity
		#case $data_ToneMode
		#when 1 # tone Pixel mode
		#	src = Cache.load_bitmap("Graphics/System/MapBackgroundColor/", "Tone")
		#	bmp_map = Bitmap.new(Graphics.width, Graphics.height)
		#	# Tile the source until the whole screen is covered
		#	(0...Graphics.width).step(src.width) do |x|
		#		(0...Graphics.height).step(src.height) do |y|
		#			bmp_map.blt(x, y, src, src.rect)
		#		end
		#	end
		#	@cover_map.color.set($game_map.map_background_color)
		#	@cover_map.blend_type = $game_map.map_background_color_blend
		#	@cover_map.opacity = $game_map.map_background_color_opacity
		#when 2 # scanLine Mode
		#	#Cache.system("Huds/jumpDotsRed.png")
		#	src = Cache.load_bitmap("Graphics/System/MapBackgroundColor/", "Scan")
		#	bmp_map = Bitmap.new(Graphics.width, Graphics.height)
		#	(0...Graphics.width).step(src.width) do |x|
		#		(0...Graphics.height).step(src.height) do |y|
		#			bmp_map.blt(x, y, src, src.rect)
		#		end
		#	end
		#	@cover_map.color.set($game_map.map_background_color)
		#	@cover_map.blend_type = $game_map.map_background_color_blend
		#	@cover_map.opacity = $game_map.map_background_color_opacity

		else # solid color fill
			bmp_map = Bitmap.new(Graphics.width, Graphics.height)
			bmp_map.fill_rect(bmp_map.rect, $game_map.map_background_color)
			@cover_map.blend_type = $game_map.map_background_color_blend
			@cover_map.opacity = $game_map.map_background_color_opacity
		end

		@cover_map.bitmap = bmp_map
		@cover_map.visible = true
		@cover_map.color = $game_map.map_background_color
		$game_map.map_background_changed = false
	end
  #--------------------------------------------------------------------------
  # * Create Tilemap
  #--------------------------------------------------------------------------
  def create_tilemap
    @tilemap = Tilemap.new(@viewport1)
    @tilemap.map_data = $game_map.data
    load_tileset
  end
  #--------------------------------------------------------------------------
  # * Load Tileset
  #--------------------------------------------------------------------------
  def load_tileset
		@tileset = $game_map.tileset
		@tileset.tileset_names.each_with_index do |name, i|
			@tilemap.bitmaps[i] = Cache.tileset(name)
			#try to hack
			#@tilemap.bitmaps[i].clear 
		end
		
		@tilemap.flags = @tileset.flags
  end
  #--------------------------------------------------------------------------
  # * Create Parallax
  #--------------------------------------------------------------------------
  def create_parallax
    @parallax = Plane.new(@viewport1)
    @parallax.z = System_Settings::MAP_PARALLAX_Z
  end
  #--------------------------------------------------------------------------
  # * Create Character Sprite
  #--------------------------------------------------------------------------
	def create_characters
		@character_count=$game_map.events.length
		@character_sprites = []
		$game_map.events.values.each do |event|
			@character_sprites.push(Sprite_Character.new(@viewport1, event))
		end
		#$game_player.followers.reverse_each do |follower|
		#	@character_sprites.push(Sprite_Character.new(@viewport1, follower))
		#end
		@character_sprites.push(Sprite_Character.new(@viewport1, $game_player))
		@map_id = $game_map.map_id
		$game_map.added_ev_ids.clear #use to clear Double sprite created by BIOS event summon(also double SEX sprite)
	end
  #--------------------------------------------------------------------------
  # * Create Airship Shadow Sprite
  #--------------------------------------------------------------------------
  def create_shadow
    @shadow_sprite = Sprite.new(@viewport1)
    @shadow_sprite.bitmap = Cache.system("Shadow")
    @shadow_sprite.ox = @shadow_sprite.bitmap.width / 2
    @shadow_sprite.oy = @shadow_sprite.bitmap.height
    @shadow_sprite.z = 180
  end
  #--------------------------------------------------------------------------
  # * Create Weather
  #--------------------------------------------------------------------------
  def create_weather
    @weather = Spriteset_Weather.new(@viewport2)
  end
  #--------------------------------------------------------------------------
  # * Create Picture Sprite
  #--------------------------------------------------------------------------
  def create_pictures
    @picture_sprites = []
  end
  #--------------------------------------------------------------------------
  # * Create Timer Sprite
  #--------------------------------------------------------------------------
  def create_timer
    @timer_sprite = Sprite_Timer.new(@viewport2)
  end
  
  #--------------------------------------------------------------------------
  # * Free
  #--------------------------------------------------------------------------
	def dispose
		dispose_tilemap
		dispose_parallax
		dispose_characters
		#dispose_shadow
		dispose_weather
		dispose_pictures
		dispose_timer
		dispose_ultra_graphics
		dispose_viewports
	end
  
  #--------------------------------------------------------------------------
  # * Free Tilemap
  #--------------------------------------------------------------------------
  def dispose_tilemap
    @tilemap.dispose
  end
  #--------------------------------------------------------------------------
  # * Free Parallax
  #--------------------------------------------------------------------------
  def dispose_parallax
    @parallax.bitmap.dispose if @parallax.bitmap
    @parallax.dispose
  end
  #--------------------------------------------------------------------------
  # * Free Character Sprite
  #--------------------------------------------------------------------------
  def dispose_characters
    @character_sprites.each {|sprite| sprite.dispose }
  end
  #--------------------------------------------------------------------------
  # * Free Airship Shadow Sprite
  #--------------------------------------------------------------------------
  def dispose_shadow
    @shadow_sprite.dispose
  end
  #--------------------------------------------------------------------------
  # * Free Weather
  #--------------------------------------------------------------------------
  def dispose_weather
    @weather.dispose
  end
  #-------------------------------------------------------------------------
  # * Free Picture Sprite
  #-------------------------------------------------------------------------
  def dispose_pictures
	if @cover_map
		@cover_map.bitmap.dispose
		@cover_map.dispose 
	end
    @picture_sprites.compact.each {|sprite| sprite.dispose }
  end
  #--------------------------------------------------------------------------
  # * Free Timer Sprite
  #--------------------------------------------------------------------------
	def dispose_timer
	return if !@timer_sprite
		@timer_sprite.dispose
	end
  
  #--------------------------------------------------------------------------
  # * Free Viewport
  #--------------------------------------------------------------------------
  def dispose_viewports
    @viewport1.dispose
    @viewport2.dispose
    @viewport3.dispose
	@viewport4.dispose
	@ivp_map.dispose
  end
  #--------------------------------------------------------------------------
  # * Refresh Characters
  #--------------------------------------------------------------------------
  def refresh_characters
    dispose_characters
    create_characters
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    update_tileset
    update_tilemap
    update_parallax
    update_characters
    #update_shadow
    update_weather
    update_pictures
    update_timer
    update_viewports
    update_map_background
  end  
  #--------------------------------------------------------------------------
  # * MAP BG by 417
  #--------------------------------------------------------------------------
  def update_map_background
	@ivp_map.visible = !$game_map.map_background_color.nil?
	return if !$game_map.map_background_changed
	create_map_background
  end
  #--------------------------------------------------------------------------
  # * Update Tileset
  #--------------------------------------------------------------------------
  def update_tileset
    if @tileset != $game_map.tileset
      load_tileset
      refresh_characters
    end
  end
  #--------------------------------------------------------------------------
  # * Update Tilemap
  #--------------------------------------------------------------------------
  def update_tilemap
    @tilemap.map_data = $game_map.data
    @tilemap.ox = $game_map.display_x * 32
    @tilemap.oy = $game_map.display_y * 32
    @tilemap.update
  end
  #--------------------------------------------------------------------------
  # * Update Parallax
  #--------------------------------------------------------------------------
	def update_parallax
		return if !$game_map.parallax_name
		if @parallax_name != $game_map.parallax_name
			@parallax_name = $game_map.parallax_name
			@parallax.bitmap.dispose if @parallax.bitmap
			@parallax.bitmap = Cache.normal_bitmap(@parallax_name)
			Graphics.frame_reset
		end
		@parallax.ox = $game_map.parallax_ox(@parallax.bitmap)
		@parallax.oy = $game_map.parallax_oy(@parallax.bitmap)
	end
  #--------------------------------------------------------------------------
  # * Update Character Sprite
  #--------------------------------------------------------------------------
  def update_characters
    refresh_characters if @map_id != $game_map.map_id || $ov
	append_character if $game_map.added_ev_ids.length>0
	#@character_sprites.each{|sprite| sprite.dispose if sprite.character.nil? || (!sprite.character.nil? && sprite.character.deleted?) }
	@character_sprites.each{|sprite| sprite.dispose if sprite.character.nil? || (!sprite.character.nil? && sprite.character.deleted?) }
	@character_sprites.reject!{|sprite| sprite.disposed?}
    @character_sprites.each {|sprite| sprite.update }
  end
  #--------------------------------------------------------------------------
  # * Update Weather
  #--------------------------------------------------------------------------
  def update_weather
    @weather.type = $game_map.screen.weather_type
    @weather.power = $game_map.screen.weather_power
    @weather.ox = $game_map.display_x * 32
    @weather.oy = $game_map.display_y * 32
    @weather.update
  end
  #--------------------------------------------------------------------------
  # *Update Picture Sprite
  #--------------------------------------------------------------------------
  def update_pictures
    $game_map.screen.pictures.each do |pic|
      @picture_sprites[pic.number] ||= Sprite_Picture.new(@viewport2, pic)
      @picture_sprites[pic.number].update
    end
  end
  #--------------------------------------------------------------------------
  # * Update Timer Sprite
  #--------------------------------------------------------------------------
  def update_timer
	$game_timer.start($game_timer.count) if $game_timer.count > 0
  	return $game_timer.stop if $game_map.interpreter.running? || $game_message.busy?
    @timer_sprite.update
  end
	def timer_sprite_force_update
		@timer_sprite.force_update
	end
  #--------------------------------------------------------------------------
  # * Update Viewport
  #--------------------------------------------------------------------------
  def update_viewports
    @viewport1.tone.set($game_map.screen.tone)
    @viewport1.ox = $game_map.screen.shake
    @viewport1.oy = $game_map.screen.shakeY
    @viewport2.color.set($game_map.screen.flash_color)
    @viewport4.color.set($game_map.screen.flash_color)
    @viewport3.color.set(0, 0, 0, 255 - $game_map.screen.brightness)
    @viewport1.update
    @viewport2.update
    @viewport3.update
    @viewport4.update
	@ivp_map.update
  end
  
  #--------------------------------------------------------------------------
  # * 從他處複製事件時增加新增事件的Sprite。
  #--------------------------------------------------------------------------
  def append_character
		#p "@character_sprites.length=>#{@character_sprites.length}"
		#until $game_map.added_ev_ids.empty?
		#	evid=$game_map.added_ev_ids.pop
		#	@character_sprites.push(Sprite_Character.new(@viewport1, $game_map.events[evid]))
		#end
		evid=$game_map.added_ev_ids.pop
		event=$game_map.events[evid]
		#return if event && @character_sprites.find{|k| k.character = event} #NEW LINE  > try to fix double SEX sprite bug , another way. new way in line 117
		@character_sprites.push(Sprite_Character.new(@viewport1, event))
  end
  
end
